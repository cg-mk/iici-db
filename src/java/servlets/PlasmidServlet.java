/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import business.Plasmid;
//import com.sun.xml.internal.ws.util.StringUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Miriam
 */
public class PlasmidServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String msg = "";
        String cntmsg = "";
        String sql = "";
        String URL = "/plasmids.jsp";
        Connection conn = null;
        Statement s = null;
        PreparedStatement ps = null;
        ResultSet r;
        Plasmid pl;
        ArrayList<Plasmid> plasmids = new ArrayList<Plasmid>();
        
        String hdnCmd = request.getParameter("hdnCmd");
        String plnum = request.getParameter("plnum");
        String bin = request.getParameter("bin");
        String res = request.getParameter("res");
        String intermed = request.getParameter("intermed");
        String pldesc = request.getParameter("pldesc");
        String author = request.getParameter("author");
        String nbnum = request.getParameter("nbnum");
        String nbpg  = request.getParameter("nbpg");
//        String yr = request.getParameter("yr");
//        String mo = request.getParameter("month");
//        String day = request.getParameter("day");
//        String dt = yr + "-" + mo + "-" + day;
        String yr1 = request.getParameter("yr1");
        String mo1 = request.getParameter("month1");
        String day1 = request.getParameter("day1");
        String dt1 = null;
        if(yr1 == null || mo1 == null || day1 == null) {
            dt1 = null;
        }else if (yr1.equalsIgnoreCase("00") || mo1.equalsIgnoreCase("00") || day1.equalsIgnoreCase("00")){
            dt1 = null;
            if (!yr1.equalsIgnoreCase("00") || !mo1.equalsIgnoreCase("00") || !day1.equalsIgnoreCase("00")){
                msg += "Partial Date detected.<br/>";
            }
        } else {         
            dt1 = yr1 + "-" + mo1 + "-" + day1;
        }
        String yr2 = request.getParameter("yr2");
        String mo2 = request.getParameter("month2");
        String day2 = request.getParameter("day2");
        String dt2 = null;
        if(yr2 == null || mo2 == null || day2 == null) {
            dt2 = null;
        }else if (yr2.equalsIgnoreCase("00") || mo2.equalsIgnoreCase("00") ||day2.equalsIgnoreCase("00")){
            dt2 = null;
            if (!yr2.equalsIgnoreCase("00") || !mo2.equalsIgnoreCase("00") || !day2.equalsIgnoreCase("00")){
                msg += "Partial Date detected.<br/>";
            }
        } else {         
            dt2 = yr2 + "-" + mo2 + "-" + day2;
        }
        String cknbnum = request.getParameter("cknbnum");
        String cknbp = request.getParameter("cknbp");
        String cmd = "";
        
        if(plnum == null){ plnum = ""; }
        if(bin == null){ bin = ""; }
        if(res == null){ res = "";}
        if(intermed == null) { intermed = ""; }
        if(pldesc == null) { pldesc = ""; }
        if(author == null) {author = "";}
        if(nbnum == null) {nbnum = "";}
        if(nbpg == null) {nbpg = "";}
        //if(yr == null) {yr = "";}
        //if(mo == null) {mo = "";}
        //if(day == null) {day = "";}
        if(cknbnum == null) {cknbnum = "";}
        if(cknbp == null) {cknbp = "";}
        
        if (hdnCmd != null && hdnCmd.length() > 0) {
            if (hdnCmd.equalsIgnoreCase("SEARCH")) {    
                cmd = "SEARCH";
            } else if (plnum.length() > 0) {
                cmd = "UPDATE";    
            } else if (plnum.isEmpty()) {
                cmd = "INSERT";
            } else if (hdnCmd.equalsIgnoreCase("DELETE")) {
                cmd = "DELETE";
            }
        } else {
            cmd = "SELECT";
        }
        
        int iplnum = -1;
        int inbnum = -1;
        int inbpg = -1;
        int icknbnum = -1;
        int icknbp = -1;
        if (cmd.equalsIgnoreCase("UPDATE") || cmd.equalsIgnoreCase("DELETE")){
            try{
                iplnum = Integer.parseInt(plnum.trim());
                if (iplnum<0){
                    msg += "Validation failed: negative id.<br>";
                }
                
            }catch(Exception e){
                msg += "Validation failed: " + plnum + " is an invalid plasmid number.<br>";
            }
        }
        if (cmd.equalsIgnoreCase("SEARCH")){
              try{
                  
                String ipl = plnum.trim();
                if (!ipl.isEmpty()){
                    iplnum = Integer.parseInt(ipl);
                    if (iplnum<0){
                        msg += "Validation failed: negative id.<br>";
                    }
                }
                
            }catch(Exception e){
                msg += "Validation failed: " + plnum + " is an invalid plasmid number.<br>";
            }
        }
        if (cmd.equalsIgnoreCase("UPDATE") || cmd.equalsIgnoreCase("INSERT"))
        {
            try {
                if (!nbnum.isEmpty()) {
                inbnum = Integer.parseInt(nbnum.trim());
                if (inbnum < 0) {
                    msg += "Validation failed: negative notebook number.<br>";
                }
                }
            } catch (Exception e) {
                msg += "Validation failed: invalid notebook number.";
            }
            try {
                if (!nbpg.isEmpty()) {
                inbpg = Integer.parseInt(nbpg.trim());
                if (inbpg < 0) {
                    msg += "Validation failed: negative notebook page1.<br>";
                }
                }
            } catch(Exception e) {
                msg += "Validation failed: invalid notebook page1.";
            }
            try {
                if (!cknbnum.trim().isEmpty()) {
                icknbnum = Integer.parseInt(cknbnum.trim());
                if(icknbnum < 0) {
                    msg += "Validation failed: negative notebook number2";
                }
                }
            } catch(Exception e) {
                msg += "Validatation failed: invalid notebook number2.";
            }
            try {
                if(!cknbp.trim().isEmpty()) {
                    icknbp = Integer.parseInt(cknbp.trim());
                    if(icknbp < 0) {
                        msg += "Validation failed: negative notebook page2";
                    }
                }
            } catch(Exception e) {
                msg += "Validatation failed: invalid notebook page2.";
            }
            try {
                String sbin = bin.trim();
                if (!sbin.isEmpty()) {
                    if (!sbin.equalsIgnoreCase("no") && !sbin.equalsIgnoreCase("n") &&  
                         !sbin.equalsIgnoreCase("yes") && !sbin.equalsIgnoreCase("y")) {
                        msg += "Invalid value entered.";
                }
                   }
                intermed = intermed.trim();
                if (!intermed.equalsIgnoreCase("Intermediate") && !intermed.equalsIgnoreCase("Final")) {
                    msg += "Validation failed: Unknown value.<br>";
                }
                res = res.trim();
                if (res.isEmpty()) {
                    msg += "No antibiotic resistance entered.";
                }
                pldesc = pldesc.trim();
                if (pldesc.isEmpty()) {
                    msg += "No description entered.";
                }
                author = author.trim();
                if (author.isEmpty()) {
                    msg += "No author entered.";
                }
            } catch(Exception e) {
                msg += "Validation failed: invalid value.<br>";
            }
        }
                
        try {
            String dbURL = "jdbc:mysql://localhost:3306/iici_db";
            String dbUser = "root";
            String dbPwd = "sesame";
            
            conn = DriverManager.getConnection(dbURL, dbUser, dbPwd);
            
            if (msg.isEmpty()){ // if validation was success and produced no msgs
                
                if (cmd.equalsIgnoreCase("UPDATE")){
                    sql = cmd + " plasmids SET isbinary = ?, intermed_final = ?,"
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
                    ps.setString(8, dt1);
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

                }else if(cmd.equalsIgnoreCase("INSERT")){
                    sql = cmd + " INTO plasmids (isbinary, intermed_final, resistance,"
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
                    ps.setString(8, dt1);
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
                    
                }else if(cmd.equalsIgnoreCase("DELETE")){
                    sql = cmd + " FROM plasmids WHERE plasmid_num = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, iplnum);
                    ps.execute();
                    
                }else if(cmd.equalsIgnoreCase("SEARCH")) {
                    sql = "SELECT * FROM plasmids WHERE ";
                    if(iplnum > 0) {
                        sql += "plasmid_num = ? AND ";
                    }
                    if (!bin.isEmpty()) {
                        sql += "isbinary = ? AND ";
                    }
                    if (!intermed.isEmpty()) {
                        sql += "intermed_final = ? AND ";
                    }
                    if (!res.isEmpty()) {
                        sql += "resistance = ? AND ";
                    }
                    if (pldesc.length() >0) {
                        sql += "description LIKE ? AND ";
                    }
                    if (!author.isEmpty()) {
                        sql += "author LIKE ? AND ";
                    }
                    if (inbnum > 0) {
                        sql += "nb_num = ? AND ";
                    }
                    if (inbpg > 0) {
                        sql += "nb_page = ? AND ";
                    }
                    if (dt1 != null && dt2 == null) {
                        sql += "ck_dt >= ? AND ";
                    }else if (dt1== null && dt2 != null) {
                        sql += "ck_dt <= ? AND ";
                    }else if (dt1 != null && dt2 != null) {
                        sql += "ck_dt BETWEEN ? AND ? AND "; 
                    }
                    sql += "1=1 ORDER BY plasmid_num";
                    ps = conn.prepareStatement(sql);
                    int param = 1;
                    
                    if(iplnum > 0) {
                        ps.setInt(param, iplnum);
                        param++;
                    }
                    if (bin.length() > 0) {
                        ps.setString(param, bin);
                        param++;
                    }
                    if (intermed.length() > 0) {
                        ps.setString(param, intermed);
                        param++;
                    }
                    if (res.length() > 0) {
                        ps.setString(param, res);
                        param++;
                    }
                    if (pldesc.length() > 0) {
                        ps.setString(param, "%"+pldesc+"%");
                        param++;
                    }
                    if (author.length() > 0) {
                        ps.setString(param,"%"+author+"%");
                        param++;
                    }
                    if (inbnum > 0) {
                        ps.setInt(param, inbnum);
                        param++;
                    }
                    if (inbpg > 0) {
                        ps.setInt(param, inbpg);
                        param++;
                    }
                    if (dt1 != null && dt2 == null) {
                        ps.setString(param, dt1);
                        param++;
                    } else if (dt2 != null && dt1 == null) {
                        ps.setString(param, dt2);
                        param++;
                    } else if (dt1 != null && dt2 != null) {
                        ps.setString(param, dt1);
                        param++;
                        ps.setString(param, dt2);
                        param++;
                    }
                    if (icknbnum > 0) {
                        ps.setString(param,"%"+icknbnum+"%");
                        param++;
                    }
                    if (icknbp > 0) {
                        ps.setString(param, "%"+icknbp+"%");
                        param++;
                    }
                    }//end search
            }
            if (!cmd.equalsIgnoreCase("SEARCH")) { // IF NOT SEARCH
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
                
                } else {
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
                    pl.setCkdt(r.getString("ck_dt"));
                    pl.setCknbnum(r.getInt("ck_after_agro_nbnum"));
                    pl.setCknbpg(r.getInt("ck_after_agro_nbpage"));

                    plasmids.add(pl);
                }
                ps.close();
                r.close(); 
            }
            if(plasmids.size() > 0) {
                URL = "/plasmids.jsp";
                request.setAttribute("plasmids", plasmids);
            } else {
                msg = "No plasmids returned.";
            }
        } catch(SQLException e) {
            msg += "SQL problems getting plasmid: " + e.getMessage() + "<br>";
        } catch (Exception e) {
            msg += "Problems creating plasmid list: " + e.getMessage() + "<br>";
        }
        
        request.setAttribute("msg", msg);
        request.setAttribute("cntmsg", cntmsg);
        RequestDispatcher disp = getServletContext().getRequestDispatcher(URL);
        disp.forward(request, response);
        
    }//End process request

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}//End of servlet
