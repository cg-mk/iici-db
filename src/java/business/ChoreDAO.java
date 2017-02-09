package business;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Miriam
 */
public class ChoreDAO {
    String msg = "";
    Connection conn = null;
    Statement s = null;
    PreparedStatement ps = null;
    String sql;
    ResultSet r;
    Chore c;
    List<Chore> chores = null;
    List<Person> people;
    
    public ChoreDAO() {
        //chores = new ArrayList();
        getConnection();
    }
    
    private void getConnection() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/iici_db";
            String dbUser = "root";
            String dbPwd = "sesame";
            
            conn = DriverManager.getConnection(dbURL, dbUser, dbPwd);
            
        } catch(SQLException e) {
            msg = "Unable to connect to database: " + e.getMessage();
        }
    }
    
    public List<Chore> getAllChores() {
        chores = new ArrayList();
        try {
            getConnection();
            s = conn.createStatement();
            sql = "SELECT * FROM chore_list";
            r = s.executeQuery(sql);
            while (r.next()) {
                c = new Chore();
                c.setTaskID(r.getInt("task_num"));
                c.setTaskType(r.getString("task_type"));
                c.setTaskDesc(r.getString("task_desc"));
                
                chores.add(c);
            }
            s.close();
            r.close();
            conn.close();
        } catch(SQLException e) {
           msg += "SQL problems getting chore: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating chore list: " + e.getMessage() + "<br>";
        }
        return chores;
    }//End getAllChores
    
    public List<Chore> getCleanUpChores() {
        chores = new ArrayList();
        try {
            getConnection();
            s = conn.createStatement();
            sql = "SELECT * FROM chore_list WHERE task_type = 1 ORDER BY task_num";
            r = s.executeQuery(sql);
            while (r.next()) {
                c = new Chore();
                c.setTaskID(r.getInt("task_num"));
                c.setTaskType(r.getString("task_type"));
                c.setTaskDesc(r.getString("task_desc"));
                
                chores.add(c);
            }
            s.close();
            r.close();
            conn.close();
        } catch(SQLException e) {
           msg += "SQL problems getting chore: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating chore list: " + e.getMessage() + "<br>";
        }
        return chores;
    }
    
    public List<Chore> getWeeklyChores() {
        chores = new ArrayList();
        try {
            getConnection();
            s = conn.createStatement();
            sql = "SELECT * FROM chore_list WHERE task_type = 2 ORDER BY task_num";
            r = s.executeQuery(sql);
            while (r.next()) {
                c = new Chore();
                c.setTaskID(r.getInt("task_num"));
                c.setTaskType(r.getString("task_type"));
                c.setTaskDesc(r.getString("task_desc"));
                
                chores.add(c);
            }
            s.close();
            r.close();
            conn.close();
        } catch(SQLException e) {
           msg += "SQL problems getting chore: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating chore list: " + e.getMessage() + "<br>";
        }
        return chores;
    }
    
    public void findChores(Integer ichid, Integer ictype, String taskDesc) {
        try {
            getConnection();
            sql = "SELECT * FROM chore_list WHERE ";
            if(ichid > 0) {
                sql += "task_num = ? AND ";
            }
            if (ictype > 0) {
                sql += "task_type LIKE ? AND ";
            }
            if (taskDesc.length() >0) {
                sql += "task_desc LIKE ? AND ";
            }
            sql += "1=1 ORDER BY task_num";
            ps = conn.prepareStatement(sql);
            int param = 1;

            if(ichid > 0) {
                ps.setInt(param, ichid);
                param++;
            }
            if (ictype > 0) {
                ps.setString(param,"%"+ictype+"%");
                param++;
            }
            if (taskDesc.length() > 0) {
                ps.setString(param, "%"+taskDesc+"%");
                param++;
            }
        } catch(SQLException e) {
           msg += "SQL problems getting chores: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating chore list: " + e.getMessage() + "<br>";
        }
    }//End findChores
    
    public void updateChores(int ichid, int ictype, String chdesc) {
        try {
            getConnection();
            sql = "UPDATE chore_list SET task_type = ?, task_desc = ? ";
                    sql += "WHERE primer_num = ?";
                    ps = conn.prepareStatement(sql);

                    ps.setInt(1, ictype);
                    ps.setString(2, chdesc);
                    ps.setInt(3, ichid);
                    ps.executeUpdate();
                    
        } catch(SQLException e) {
           msg += "SQL problems getting chore: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating chore list: " + e.getMessage() + "<br>";
        }
    }//End updateChores
    
    public void addChores(int ichid, int ictype, String chdesc) {
        try {
            getConnection();
            sql = "INSERT INTO chore_list (task_type, task_desc) VALUES (?,?)";
            ps = conn.prepareStatement(sql);
            //primers table uses auto_increment
            //primer_seq int PRIMARY KEY AUTO_INCREMENT
            ps.setInt(1, ictype);
            ps.setString(2, chdesc);
            ps.execute();
            
        } catch(SQLException e) {
           msg += "SQL problems getting chore: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating chore list: " + e.getMessage() + "<br>";
        }
    }//End addChores
    
    public void deleteChores(int ichid, int ictype, String chdesc) {
        try {
            getConnection();
            sql = "DELETE FROM chore_list WHERE task_num = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, ichid);
                    ps.execute();
                    
        } catch(SQLException e) {
           msg += "SQL problems deleting chore: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating chore list: " + e.getMessage() + "<br>";
        }
    }//End deleteChores
    
    public String getMsg() {
        String str = msg;
        msg = "";
        return str;
    }
}
