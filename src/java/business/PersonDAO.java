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
public class PersonDAO {
    String msg = "";
    Connection conn = null;
    Statement s = null;
    PreparedStatement ps = null;
    String sql;
    ResultSet r;
    Person prsn;
    List<Person> people;
    List<String> names;
    
    public PersonDAO() {
        people = new ArrayList();
        getConnection();
        try{
            conn.close();
        }catch(SQLException e){}
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
    
    public List<Person> getAllPeople() {
        people = new ArrayList();
        try {
            getConnection();
            s = conn.createStatement();
            sql = "SELECT * FROM people";
            r = s.executeQuery(sql);
            while (r.next()) {
                prsn = new Person();
                prsn.setPpl_num(r.getInt("ppl_num"));
                prsn.setFname(r.getString("fname"));
                prsn.setMinit(r.getString("minit"));
                prsn.setLname(r.getString("lname"));
                prsn.setUnm(r.getString("username"));
                prsn.setPwd(r.getString("pwd"));
                
                people.add(prsn);
            }
        } catch(SQLException e) {
           msg += "SQL problems getting person: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating people list: " + e.getMessage() + "<br>";
        } finally {
            closeResources();
        }
        return people;
    }
    
     public List<Person> getAllPeopleByPS() {
        try {
            getConnection();
            ps.execute();
            r = ps.getResultSet();
            while (r.next()) {
                prsn = new Person();
                prsn.setPpl_num(r.getInt("ppl_num"));
                prsn.setFname(r.getString("fname"));
                prsn.setMinit(r.getString("minit"));
                prsn.setLname(r.getString("lname"));
                prsn.setUnm(r.getString("username"));
                prsn.setPwd(r.getString("pwd"));
                
                people.add(prsn);
            }
        } catch(SQLException e) {
           msg += "SQL problems getting person: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating people list: " + e.getMessage() + "<br>";
        } finally {
            closeResources();
        }
        return people;
    }//End getAllPeoplePS
    
    public Person getPersonById() {
        people = new ArrayList();
        try {
            getConnection();
            s = conn.createStatement();
        } catch(SQLException e) {
           msg += "SQL problems getting person: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating people list: " + e.getMessage() + "<br>";
        } finally {
            closeResources();
        }
        return prsn;
    }
    
    public void addPerson(int ipplid, String fname, String minit, String lname,
            String username, String pwd) {
        try {
            getConnection();
            sql = "INSERT INTO people (fname, minit, lname, username, pwd) VALUES (?,?,?,?,?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, fname);
            ps.setString(2, minit);
            ps.setString(3, lname);
            ps.setString(4, username);
            ps.setString(5, pwd);
            ps.execute();
        } catch(SQLException e) {
           msg += "SQL problems adding person: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating people list: " + e.getMessage() + "<br>";
        } finally {
            closeResources();
        }
    }//End addPerson
    
    public void deletePerson(int ipplid, String fname, String lname) {
        try {
            getConnection();
            sql = "DELETE FROM people WHERE ppl_num = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, ipplid);
                    ps.execute();
        } catch(SQLException e) {
           msg += "SQL problems deleting person: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating people list: " + e.getMessage() + "<br>";
        } finally {
            closeResources();
        }
    }//End deletePerson
    
    public void findPerson(int ippl_num, String fname, String minit, String lname) {
        try {
            getConnection();
            sql = "SELECT * FROM people WHERE ";
            if(ippl_num > 0) {
                sql += "ppl_num = ? AND ";
            }
            if (fname.length() > 0) {
                sql += "fname LIKE ? AND ";
            }
            if (minit.length() > 0) {
                sql += "minit LIKE ? AND ";
            }
            if (lname.length() > 0) {
                sql += "lname LIKE ? AND ";
            }
            sql += "1=1 ORDER BY ppl_num";
            ps = conn.prepareStatement(sql);
            int param = 1;

            if(ippl_num> 0) {
                ps.setInt(param, ippl_num);
                param++;
            }
            if (fname.length() > 0) {
                ps.setString(param,"%"+fname+"%");
                param++;
            }
            if (minit.length() > 0) {
                ps.setString(param, "%"+minit+"%");
                param++;
            }
            if (lname.length() > 0) {
                ps.setString(param, "%"+lname+"%");
            }
        } catch(SQLException e) {
           msg += "SQL problems getting person: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating people list: " + e.getMessage() + "<br>";
        } finally {
            closeResources();
        }
    }//End findPerson
    
    public void updatePeople(String fname, String minit, String lname,
            String username, String pwd, int ippl_num) {
        try {
            getConnection();
            sql = "UPDATE people SET fname = ?, minit = ?, lname = ?, username = ?, pwd = ? ";
            sql += "WHERE ppl_num = ?";
            ps = conn.prepareStatement(sql);

            ps.setString(1, fname);
            ps.setString(2, minit);
            ps.setString(3, lname);
            ps.setString(4, username);
            ps.setString(5, pwd);
            ps.setInt(6, ippl_num);
            ps.executeUpdate();
        } catch(SQLException e) {
           msg += "SQL problems updating people: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems updating people list: " + e.getMessage() + "<br>";
        } finally {
            closeResources();
        }
    }//End updatePeople
    
    private void closeResources() {
        try {
            if (s != null) {
                s.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (r != null) {
                r.close();
            }
            if (conn != null) {
                conn.close();
            }
            } catch (SQLException e) {
                msg += e.getMessage();
            }
    }
    
    public String getMsg(){
        String str = msg;
        msg = ""; // clear error msgs
        return str;
    }
}
