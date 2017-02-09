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
public class PrimerDAO {
    String msg = "";
    Connection conn = null;
    Statement s = null;
    PreparedStatement ps = null;
    String sql;
    ResultSet r;
    Primer p;
    List<Primer> primers;
    
    public PrimerDAO() {
        primers = new ArrayList();
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
    
    public List<Primer> getAllPrimers() {
        try {
            s = conn.createStatement();
            sql = "SELECT * FROM primers ORDER BY primer_num";
            r = s.executeQuery(sql);
            while (r.next()) {
                p = new Primer();
                p.setPrimerID(r.getInt("primer_num"));
                p.setSequence(r.getString("primer_seq"));
                p.setPrDesc(r.getString("primer_desc"));

                primers.add(p);
            }
               // cntmsg = primers.size() + " primers returned from this query.";
                
        } catch(SQLException e) {
           msg += "SQL problems getting primer: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating primer list: " + e.getMessage() + "<br>";
        } finally {
            try {
                if (r != null) {
                    r.close();
                }
                if (s != null) {
                    s.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch(SQLException e) {
                msg += e.getMessage() + "<br>";
            }
        }
        return primers;
    }//End getAllPrimers
    
    public List<Primer> getAllPrimersByPS() {
        try {
            ps.execute();
            r = ps.getResultSet();
            while (r.next()) {
                p = new Primer();
                p.setPrimerID(r.getInt("primer_num"));
                p.setSequence(r.getString("primer_seq"));
                p.setPrDesc(r.getString("primer_desc"));

                primers.add(p);
            }
        } catch(SQLException e) {
           msg += "SQL problems getting primer: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating primer list: " + e.getMessage() + "<br>";
        } finally {
            try {
            if (s != null) {
                s.close();
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
        return primers;
    }//End getAllPrimersPS
    
    public void findPrimers(int iprid, String seq, String prdesc) {
        try {
            sql = "SELECT * FROM primers WHERE ";
            if(iprid > 0) {
                sql += "primer_num = ? AND ";
            }
            if (seq.length() > 0) {
                sql += "primer_seq LIKE ? AND ";
            }
            if (prdesc.length() >0) {
                sql += "primer_desc LIKE ? AND ";
            }
            sql += "1=1 ORDER BY primer_num";
            ps = conn.prepareStatement(sql);
            int param = 1;

            if(iprid > 0) {
                ps.setInt(param, iprid);
                param++;
            }
            if (seq.length() > 0) {
                ps.setString(param,"%"+seq+"%");
                param++;
            }
            if (prdesc.length() > 0) {
                ps.setString(param, "%"+prdesc+"%");
                param++;
            }
        } catch(SQLException e) {
           msg += "SQL problems getting primer: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating primer list: " + e.getMessage() + "<br>";
        }
    }//End findPrimers
    
    public void updatePrimers(String seq, String prdesc, int iprid) {
        try {
            sql = "UPDATE primers SET primer_seq = ?, primer_desc = ? ";
                    sql += "WHERE primer_num = ?";
                    ps = conn.prepareStatement(sql);

                    ps.setString(1, seq);
                    ps.setString(2, prdesc);
                    ps.setInt(3, iprid);
                    ps.executeUpdate();
        } catch(SQLException e) {
           msg += "SQL problems updating primer: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems updating primer list: " + e.getMessage() + "<br>";
        }
    }//End updatePrimers
    
    public void addPrimers(int iprid, String seq, String prdesc) {
        try {
            sql = "INSERT INTO primers (primer_seq, primer_desc) VALUES (?,?)";
                    ps = conn.prepareStatement(sql);
                    //primers table uses auto_increment
                    //primer_seq int PRIMARY KEY AUTO_INCREMENT
                    ps.setString(1, seq);
                    ps.setString(2, prdesc);
                    ps.execute();
        } catch(SQLException e) {
           msg += "SQL problems getting primer: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating primer list: " + e.getMessage() + "<br>";
        }
    }//End addPrimers
    
    public void deletePrimers(int iprid, String seq, String prdesc) {
        try {
            sql = "DELETE FROM primers WHERE primer_num = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, iprid);
                    ps.execute();
        } catch(SQLException e) {
            msg += "SQL problems deleting primer: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems deleting primer: " + e.getMessage() + "<br>";
        }
    }
    
    public String getMsg(){
        String str = msg;
        msg = ""; // clear error msgs
        return str;
    }
}//End class
