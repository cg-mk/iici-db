/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import business.Primer;
import business.PrimerDAO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/* @author Miriam */

public class PrimerServlet extends HttpServlet {

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
        PrimerDAO prd = new PrimerDAO();
        String msg = "";
        String sql = "";
        String URL = "/primers.jsp";
        Connection conn = null;
        Statement s = null;
        PreparedStatement ps = null;
        ResultSet r;
        Primer p;
        List<Primer> primers = new ArrayList();
         
        String subm = request.getParameter("btnSubmit");
        String dbtn = request.getParameter("hdnDel");
        String sbtn = request.getParameter("hdnSearch");
        String prid = request.getParameter("prid");
        String seq = request.getParameter("seq");
        String prdesc = request.getParameter("prdesc");
        //String btnmsg = "";
        String cmd = "";
        String cntmsg = "";
                
        if(subm == null){ subm = ""; }
        if(dbtn == null){ dbtn = ""; }
        if(sbtn == null){ sbtn = ""; }
        if(prid == null){ prid = ""; }
        if(seq == null){ seq = ""; }
        if(prdesc == null){ prdesc = ""; }
        
        if (subm.length() > 0)  {
            if (sbtn.length() > 0) {
                cmd = "SEARCH";
            } else if (prid.length() > 0) {
                cmd = "UPDATE";    
            } else if (prid.isEmpty()) {
                cmd = "INSERT";
            }
        } else if (dbtn.length() > 0) {
            cmd = "DELETE";
        } else {
            cmd = "SELECT";
        }
        
        int iprid = -1;
        if (cmd.equalsIgnoreCase("UPDATE") || cmd.equalsIgnoreCase("DELETE") || cmd.equalsIgnoreCase("SEARCH")){
            try{
                iprid = Integer.parseInt(prid.trim());
                if (iprid<0){
                    msg += "Validation failed: negative id.<br>";
                }
            }catch(Exception e){
                msg += "Validation failed: invalid id.<br>";
            }
            if (cmd.equalsIgnoreCase("SEARCH")){
                msg = "";
            }
        }
        if (cmd.equalsIgnoreCase("UPDATE") || cmd.equalsIgnoreCase("INSERT")){
            seq = seq.trim().toUpperCase();
            prdesc = prdesc.trim();
            Pattern regp = Pattern.compile("[^CATGU]");
            Matcher regm = regp.matcher(seq);

            if ( regm.find() ){
                msg += "Validation failed: illegal sequence:["+ seq +"]<br>";
            }
            if(seq.isEmpty()){
                msg += "Validation failed: blank sequence.<br>";
            }
            if(prdesc.isEmpty()){
                msg += "Validation failed: blank description.<br>";
            }
       }
        
                if (cmd.equalsIgnoreCase("UPDATE")){
                    prd.updatePrimers(seq, prdesc, iprid);
                
                }else if(cmd.equalsIgnoreCase("INSERT")){
                    prd.addPrimers(iprid, seq, prdesc);
                
                }else if(cmd.equalsIgnoreCase("DELETE")){
                    prd.deletePrimers(iprid, seq, prdesc);

                } else if(cmd.equalsIgnoreCase("SEARCH")) {
                    prd.findPrimers(iprid, seq, prdesc);
                }
        
           if (sbtn.isEmpty()) { // IF NOT SEARCH
                primers = prd.getAllPrimers();
            } else {
                primers = prd.getAllPrimersByPS();
            }
            
            cntmsg = primers.size() + " primers returned from this query.";
            
            if (primers.size() > 0) {
                URL = "/primers.jsp";
                request.setAttribute("primers", primers);
            }
        request.setAttribute("msg", msg);
        request.setAttribute("cntmsg", cntmsg);
        RequestDispatcher disp = getServletContext().getRequestDispatcher(URL);
        disp.forward(request, response);
        
}
    
    
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

}
