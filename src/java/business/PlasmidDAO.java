package business;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import servlets.PlasmidServlet;

/**
 *
 * @author Miriam.
 */
public class PlasmidDAO {
    Plasmid pl;
    List<Plasmid> plasmids;
    String msg = "";
    Connection conn = null;
    String sql = "";
    ResultSet r;
    String cntmsg;
    Statement s;
    PreparedStatement ps;
    
    public PlasmidDAO() {
        plasmids = new ArrayList<Plasmid>();
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
    
    public List<Plasmid> getAllPlasmids() {
        
        try {
            s = conn.createStatement();
            sql = "SELECT * FROM plasmids ORDER BY plasmid_num";
            r = s.executeQuery(sql);
            while(r.next()) {
                pl = new Plasmid();
                pl.setPlasmidID(r.getInt("plasmid_num"));
                pl.setBin(r.getString("isbinary"));
                pl.setIntermed(r.getString("intermed_final"));
                pl.setRes(r.getString("resistance"));
                pl.setPldesc(r.getString("description"));
                pl.setAuthor(r.getString("author"));
                pl.setNbnum(r.getInt("nb_num"));
                pl.setNbpg(r.getInt("nb_page"));
                pl.setCkdt(r.getString("ck_dt"));
                pl.setCknbnum(r.getInt("ck_after_agro_nbnum"));
                pl.setCknbpg(r.getInt("ck_after_agro_nbpage"));

                plasmids.add(pl);
                        
                }
                cntmsg = plasmids.size() + " plasmids returned from this query.";
                s.close();
                r.close();
                conn.close();
                    
        } catch (SQLException e) {
            msg = "Problems getting plasmid list: " + e.getMessage();
        } catch (Exception e) {
            msg = "Error: " + e.getMessage();
        }
            return plasmids;
        }//End getAllPlasmids

    public List<Plasmid> getPlasmidsByPS() {
        try {
            ps.execute();
            r = ps.getResultSet();
    
                while (r.next()) {
                    pl = new Plasmid();
                    pl.setPlasmidID(r.getInt("plasmid_num"));
                    pl.setBin(r.getString("isbinary"));
                    pl.setIntermed(r.getString("intermed_final"));
                    pl.setRes(r.getString("resistance"));
                    pl.setPldesc(r.getString("description"));
                    pl.setAuthor(r.getString("author"));
                    pl.setNbnum(r.getInt("nb_num"));
                    pl.setNbpg(r.getInt("nb_page"));
                    pl.setCkdt(r.getString("ck_date"));
                    pl.setCknbnum(r.getInt("ck_after_agro_nbnum"));
                    pl.setCknbpg(r.getInt("ck_after_agro_nbpage"));
    
                    plasmids.add(pl);
                }
                    ps.close();
                    r.close();
                    conn.close();
        } catch(SQLException e) {
            msg = "Problems retrieving plasmid: " + e.getMessage();
        } catch(Exception e) {
            msg = "Error with plasmid: " + e.getMessage();
        }
        return plasmids;
    }//End getPlasmidByPS
    
    public void updatePlasmid(String bin, String intermed, String res, 
            String pldesc, String author, String nbnum, String nbpg,
            String dt, int icknbnum, int icknbp, int iplnum) {
        try {
            sql = "UPDATE plasmids SET isbinary = ?, intermed_final = ?,"
                            + " resistance = ?, description = ?, author = ?,"
                            + " nb_num = ?, nb_page = ?, ck_dt = ?,"
                            + " ck_after_agro_nbnum = ?, ck_after_agro_nbpage = ? ";
                    sql += " WHERE plasmid_num = ?";
                    ps = conn.prepareStatement(sql);

                    ps.setString(1, bin);
                    ps.setString(2, intermed);
                    ps.setString(3, res);
                    ps.setString(4, pldesc);
                    ps.setString(5, author);
                    ps.setString(6, nbnum);
                    ps.setString(7, nbpg);
                    ps.setString(8, dt);
                    if (icknbnum <= 0) {
                        ps.setNull(9, java.sql.Types.INTEGER);
                    } else {
                        ps.setInt(9, icknbnum);
                    }
                    if (icknbp <= 0) {
                        ps.setNull(10, java.sql.Types.INTEGER);
                    } else {
                        ps.setInt(10, icknbp);
                    }
                    ps.setInt(11, iplnum);
                    ps.executeUpdate();
        } catch(SQLException e) {
            msg = "Problems updating plasmid: " + e.getMessage();
        } catch(Exception e) {
            msg = "Error with plasmid: " + e.getMessage();
        }
    }//End updatePlasmids
    
    public void addPlasmids(String bin, String intermed, String res, 
            String pldesc, String author, String nbnum, String nbpg,
            String dt, int icknbnum, int icknbp, int iplnum) {
        try {
            sql = "INSERT INTO plasmids (isbinary, intermed_final, resistance,"
                            + " description, author, nb_num, nb_page, ck_dt,"
                            + " ck_after_agro_nbnum, ck_after_agro_nbpage) VALUES"
                            + " (?,?,?,?,?,?,?,?,?,?)";
            ps = conn.prepareStatement(sql);
            //plasmids table uses auto_increment
            ps.setString(1, bin);
            ps.setString(2, intermed);
            ps.setString(3, res);
            ps.setString(4, pldesc);
            ps.setString(5, author);
            ps.setString(6, nbnum);
            ps.setString(7, nbpg);
            ps.setString(8, dt);
            if (icknbnum <= 0) {
                ps.setNull(9, java.sql.Types.INTEGER);
            } else {
                ps.setInt(9, icknbnum);
            }
            if (icknbp <= 0) {
                ps.setNull(10, java.sql.Types.INTEGER);
            } else {
                ps.setInt(10, icknbp);
            }ps.execute();
        } catch(SQLException e) {
            msg = "Problems inserting plasmid: " + e.getMessage();
        } catch(Exception e) {
            msg = "Error with plasmid: " + e.getMessage();
        }
    }
    
    public void dropPlasmids(int iplnum) {
        try {
            sql = " DELETE FROM plasmids WHERE plasmid_num = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, iplnum);
                    ps.execute();
        } catch (SQLException e) {
            msg = "Problem deleting plasmid: " + e.getMessage();
        } catch (Exception e) {
            msg = "General Error: "  + e.getMessage();
        }
    }
    
    public String getErrorMsg(){
        String str = msg;
        msg = "";
        return str;
    }
}//End class