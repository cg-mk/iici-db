package business;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Miriam
 */
public class SequenceDAO {
    String msg = "";
    Connection conn = null;
    Statement s = null;
    PreparedStatement ps = null;
    String sql;
    ResultSet r;
    Sequence seq;
    List<Sequence> sequences = null;
    String cntmsg;
    
    public SequenceDAO() {
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
    
    public void addSeq(String seqName, String filePath, Date d, String stxt){
        if (seqName == null || seqName.isEmpty()) {
            msg += "Missing sequence name.<br>";
            return;
        }
        if (filePath != null) {
            stxt = null;
        } else if (stxt != null) {
            filePath = null;
        }
        if ((filePath == null || filePath.isEmpty()) && (stxt == null || stxt.isEmpty())) {
            msg += "No sequence data to store.<br>";
            return;
        } else if (d == null) {
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            d = new Date();
            //msg += "Missing date.<br>";
            //return;
        }
        try {
            s = conn.createStatement();
            sql = "INSERT INTO sequences (gene_name, seq_path, seq_date, seq_data) VALUES (?,?,?,?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, seqName);
            ps.setString(2, filePath);
            java.sql.Date sqlDate = new java.sql.Date(d.getTime());
            ps.setDate(3, sqlDate);
            ps.setString(4, stxt);
            ps.execute();
        } catch(SQLException e) {
            msg += "SQL problems adding sequence: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating sequence to insert: " + e.getMessage() + "<br>";
        } 
    }//end add sequence
    
    public void deleteSeq(int iseqid, String seqname, String seqpath, String seqtxt) {
        try {
            s = conn.createStatement();
            sql = "DELETE from sequences WHERE seq_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, iseqid);
            ps.execute();
        } catch (SQLException e) {
            msg += "SQL problems deleting sequence: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "General problems deleting sequence: " + e.getMessage() + "<br>";
        }
    }// end deleteSeq
    
    public void updateSequence(int iseqid, String seqname, Date d, String seqpath,
            String seqtxt) {
        d = new Date();
        try {
            sql = "UPDATE sequences SET gene_name = ?, seq_path = ?, seq_date = ?, seq_data = ?";
            sql += "WHERE seq_id = ?";
            ps = conn.prepareStatement(sql);

            ps.setString(1, seqname);
            ps.setString(2, seqpath);
            java.sql.Date sqlDate = new java.sql.Date(d.getTime());
            ps.setDate(3, sqlDate);
            ps.setString(4, seqtxt);
            ps.setInt(5, iseqid);
            ps.executeUpdate();
        } catch(SQLException e) {
           msg += "SQL problems updating sequence: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems updating sequence list" + e.getMessage() + "<br>";
        }
    }//End updateSequence
    
    public List<Sequence> findSequences(String seqDesc) {
        sequences = new ArrayList<Sequence>();
        try {
            sql = "SELECT * FROM sequences WHERE gene_name LIKE ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%"+seqDesc+"%");
            r = ps.executeQuery();
            
            if (r == null) {
                msg += "This search returned no results.";
                return null;
            }
            
            while(r.next()) {
                seq = new Sequence();
                seq.setSeqID(r.getInt("seq_id"));
                seq.setSeqName(r.getString("gene_name"));
                seq.setSeqPath(r.getString("seq_path"));
                seq.setSeqDt(r.getDate("seq_date"));
                seq.setSeqData(r.getString("seq_data"));
                
                sequences.add(seq);
            }
        if (sequences.isEmpty()) {
                msg += "No results returned from this search.";
                //return null;
        }    
        } catch(SQLException e) {
           msg += "SQL problems getting sequence: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating sequence list: " + e.getMessage() + "<br>";
        }
        return sequences;
    }//End findSequences
    
    public List<Sequence> getAllSeqs() {
        sequences = new ArrayList<Sequence>();
        try {
            s = conn.createStatement();
            sql = "SELECT * FROM sequences ORDER BY seq_id";
            r = s.executeQuery(sql);
            while (r.next()) {
                seq = new Sequence();
                seq.setSeqID(r.getInt("seq_id"));
                seq.setSeqName(r.getString("gene_name"));
                seq.setSeqPath(r.getString("seq_path"));
                seq.setSeqDt(r.getDate("seq_date"));
                seq.setSeqData(r.getString("seq_data"));
                sequences.add(seq);
            }
            cntmsg = sequences.size() + " sequences returned from this query.";
            s.close();
            r.close();
            //conn.close(); // if you close it here then you need to reopen it
            
        } catch(SQLException e) {
            msg += "SQL problems getting sequence: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating list of sequences: " + e.getMessage() + "<br>";
        } 
        return sequences;
    }//End getAllSeqs
    
    public String getMsg() {
        String str = msg;
        msg = "";
        return str;
    }
    public String getCntMsg() {
        String str = cntmsg;
        cntmsg = "";
        return str;
    }
    
}//End class