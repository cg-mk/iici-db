/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import business.Protocol;
import business.ProtocolDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Miriam
 */
public class ProtocolServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        ProtocolDAO protd = new ProtocolDAO();
        String msg = protd.getMsg();
        String URL = "/protocol.jsp";
        List<Protocol> protocols = null;
        String path = null;
        
        String subm = request.getParameter("btnSubmit");
        String action = request.getParameter("hdnAction");
        String protid = request.getParameter("hdnProtId");
        String protnm = request.getParameter("protName");
        String txtprot = request.getParameter("txtprot");
        String snm = request.getParameter("protdesc");
        
        if(subm == null){ subm = ""; }
        if(action == null) {action = ""; }
        
        int iprotid = -1;
        
        if (action.equalsIgnoreCase("INSERT") == true) {
            if (!txtprot.isEmpty()) {
                protocols = null;
                protd.addProtocol(protnm, path, txtprot);
                msg += protd.getMsg();
            }
        }
        
        if (action.equalsIgnoreCase("UPDATE") == true) {
            protocols = null;
            if (!protid.isEmpty()) {
                try {
                    iprotid = Integer.parseInt(protid);
                    if (iprotid<0){
                    msg += "Validation failed: negative id.<br>";
                    } 
                } catch(NumberFormatException e){
                msg += "Validation failed: invalid id.<br>";
                }
            }
            protd.updateProtocol(iprotid, protnm, path, txtprot);
            msg += protd.getMsg();
            //protocols = protd.getAllProtocols();
        }
        
        if (action.equalsIgnoreCase("DELETE") == true) {
            if (!protid.isEmpty()) {
                try {
                    iprotid = Integer.parseInt(protid);
                    if (iprotid<0){
                    msg += "Validation failed: negative id.<br>";
                    } 
                } catch(NumberFormatException e){
                msg += "Validation failed: invalid id.<br>";
                }
            }
            protd.deleteProtocol(iprotid, protnm, path, protnm);
            msg += protd.getMsg();
        }
        
        if (action.equalsIgnoreCase("SEARCH")) {
            protocols = null;
            if (snm.length() > 0) { 
            protocols = protd.findProtocols(snm);
            msg += protd.getMsg();
            }
        }//End if search
        
        if (action.equalsIgnoreCase("SEARCH") == false) { // IF NOT SEARCH
            protocols = protd.getAllProtocols();
            msg += protd.getMsg();
        }
        
        String cntmsg = protocols.size() + " protocols returned from this query.";
            
        request.setAttribute("msg", msg);
        request.setAttribute("prot", protocols);
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
