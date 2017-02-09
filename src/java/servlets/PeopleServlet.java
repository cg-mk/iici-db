package servlets;

import business.Person;
import business.PersonDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author Miriam
 */
public class PeopleServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        PersonDAO persond = new PersonDAO();
        String msg = "";
        String cntmsg = "";
        String sql = "";
        String URL = "/users.jsp";
        Connection conn = null;
        Statement s = null;
        PreparedStatement ps = null;
        ResultSet r;
        Person person;
        List<Person> people = new ArrayList();
        String cmd = "";
        String subm = request.getParameter("btnPplSub");
        String dbtn = request.getParameter("hdnPplDel");
        String sbtn = request.getParameter("hdnPplSearch");
        String ppl_num = request.getParameter("ppl_id");
        String fname = request.getParameter("fnm");
        String minit = request.getParameter("mi");
        String lname = request.getParameter("lnm");
        
        if(subm == null){ subm = ""; }
        if(dbtn == null){ dbtn = ""; }
        if(sbtn == null){ sbtn = ""; }
        if(ppl_num == null){ ppl_num = ""; }
        if(fname == null){ fname = ""; }
        if(minit == null){ minit = ""; }
        if(lname == null){lname = "";}
        
        if (subm.length() > 0)  {
            if (sbtn.length() > 0) {
                cmd = "SEARCH";
            } else if (ppl_num.length() > 0) {
                cmd = "UPDATE";    
            } else if (ppl_num.isEmpty()) {
                cmd = "INSERT";
            }
        } else if (dbtn.length() > 0) {
            cmd = "DELETE";
        } else {
            cmd = "SELECT";
        }
        
        int ippl_num = -1;
        if (cmd.equalsIgnoreCase("UPDATE") || cmd.equalsIgnoreCase("DELETE") || cmd.equalsIgnoreCase("SEARCH")){
            try{
                ippl_num = Integer.parseInt(ppl_num.trim());
                if (ippl_num < 0){
                    msg += "Validation failed: negative id.<br>";
                }
            }catch(Exception e){
                msg += "Validation failed: invalid id.<br>";
            }
            if (cmd.equalsIgnoreCase("SEARCH")){
                msg = "";
            }
        }
        
        if (cmd.equalsIgnoreCase("UPDATE")){
            persond.updatePeople(fname, minit, lname, lname, cmd, ippl_num);
            msg += persond.getMsg();
        } else if (cmd.equalsIgnoreCase("INSERT")) {
            persond.addPerson(ippl_num, fname, minit, lname, lname, cmd);
            msg += persond.getMsg();
        } else if (cmd.equalsIgnoreCase("DELETE")) {
            persond.deletePerson(ippl_num, fname, lname);
        } else if (cmd.equalsIgnoreCase("SEARCH")) {
            persond.findPerson(ippl_num, fname, minit, lname);
            msg += persond.getMsg();
        }
        
        if (sbtn.isEmpty()) { // IF NOT SEARCH
                people = persond.getAllPeople();
                msg += persond.getMsg();
            } else {
                people = persond.getAllPeopleByPS();
            }
        cntmsg += people.size() + " users returned.<br>";
        
        if (people.size() > 0)  {
            URL = "/users.jsp";
            request.setAttribute("people", people);
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
