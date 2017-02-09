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
* @author Miriam
 */
public class ProtocolDAO {
    String msg = "";
    Connection conn = null;
    Statement s = null;
    PreparedStatement ps = null;
    String sql;
    ResultSet r;
    Protocol prot;
    List<Protocol> protocols;
       
    public ProtocolDAO() {
        protocols = new ArrayList();
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
    }//End getConnection
    
    public void addProtocol(String fileName, String filePath, String txtprot){
        if (fileName == null || fileName.isEmpty()) {
            msg += "Missing protocol name.<br>";
            return;
        }
        if (filePath != null) {
            txtprot = null;
        } else if (txtprot != null) {
            filePath = null;
        }
        if ((filePath == null || filePath.isEmpty()) && (txtprot == null || txtprot.isEmpty())) {
            msg += "No protocol data to store.<br>";
            return;
        }
        try {
            s = conn.createStatement();
            sql = "INSERT INTO protocols (prot_name,prot_path,prot_data) VALUES (?,?,?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, fileName);
            ps.setString(2, filePath);
            ps.setString(3, txtprot);
            ps.execute();
        } catch(SQLException e) {
            msg += "SQL problems adding sequence: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating sequence to insert: " + e.getMessage() + "<br>";
        }
    }//End AddProtocol
    
    public void deleteProtocol(int iprotid, String fileName, String filePath, String prottxt) {
        try {
            sql = "DELETE FROM protocols WHERE prot_id = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, iprotid);
                    ps.execute();
        } catch(SQLException e) {
           msg += "SQL problems deleting protocol: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems deleting protocol: " + e.getMessage() + "<br>";
        }
    }
    
    public List<Protocol> findProtocols(String snm) {
        try {
            sql = "SELECT * FROM protocols WHERE prot_name LIKE ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%"+snm+"%");
            r = ps.executeQuery();
            
            if (r == null) {
                msg += "This search returned no results.";
                return null;
            }
            
            while(r.next()) {
                prot = new Protocol();
                prot.setProtID(r.getInt("prot_id"));
                prot.setProtName(r.getString("prot_name"));
                prot.setProtPath(r.getString("prot_path"));
                prot.setProtData(r.getString("prot_data"));
                
                protocols.add(prot);
            }
        if (protocols.isEmpty()) {
                msg += "No results returned from this search.";
                //return null;
        }    
        } catch(SQLException e) {
           msg += "SQL problems getting protocol: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating protocol list: " + e.getMessage() + "<br>";
        }
        return protocols;
    }//End find Protocols
    
    public void updateProtocol(int iprotid, String fileName, String filePath,
            String txtprot) {
        try {
            sql = "UPDATE protocols SET prot_name = ?, prot_path = ?, prot_data = ?";
                    sql += "WHERE prot_id = ?";
                    ps = conn.prepareStatement(sql);

                    ps.setString(1, fileName);
                    ps.setString(2, filePath);
                    ps.setString(3, txtprot);
                    ps.setInt(4, iprotid);
                    ps.executeUpdate();
        } catch(SQLException e) {
           msg += "SQL problems updating protocol: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems updating protocol list" + e.getMessage() + "<br>";
        }
    }//End updateProtocols
    
    public List<Protocol> getAllProtocols() {
        try {
            s = conn.createStatement();
            sql = "SELECT * FROM protocols ORDER BY prot_id";
            r = s.executeQuery(sql);
            while(r.next()) {
                prot = new Protocol();
                prot.setProtID(r.getInt("prot_id"));
                prot.setProtName(r.getString("prot_name"));
                prot.setProtPath(r.getString("prot_path"));
                prot.setProtData(r.getString("prot_data"));
                
                protocols.add(prot);
            }
            s.close();
            r.close();
        } catch(SQLException e) {
           msg += "SQL problems getting protocol: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating list of protocols: " + e.getMessage() + "<br>";
        } 
        return protocols;
    }//End getAllProtocols
    
    public String getMsg() {
        String str = msg;
        msg = ""; // clear error msgs
        return str;
    }
}
