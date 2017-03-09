/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import business.Assignment;
import business.Chore;
import business.ChoreDAO;
import business.Person;
import business.PersonDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
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
public class ChoreServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ChoreDAO chd = new ChoreDAO();
        PersonDAO perd  = new PersonDAO();
        String msg = "";
        String URL = "/chores.jsp";
        Chore c;
        String display = "";
        List<Chore> chores = null;
        List<Person> people = null;
        ArrayList<Assignment> assign = null;
        
        String formname = request.getParameter("formname");
       
        if (formname == null){
            formname = "";
        }
       
        String choreMode = (String)request.getSession().getAttribute("choreMode"); // Weekly or Cleanup
        
        if (formname.isEmpty()){
            // initial page load
            display = "1";
            
        }else if (formname.equalsIgnoreCase("form1")) { // a radio button was selected
            
            String chrtype = request.getParameter("choretp");
            
            if (chrtype == null){
                msg += "Error: null choreMode";
                
            }else if (chrtype.equalsIgnoreCase("WEEKLY")) {
                chores = chd.getWeeklyChores();
                msg += chd.getMsg();
                request.getSession().setAttribute("choreMode", "Weekly");
                
            } else if (chrtype.equalsIgnoreCase("CLEANUP")) {
                chores = chd.getCleanUpChores();
                msg += chd.getMsg();
                request.getSession().setAttribute("choreMode", "Cleanup");
               
            }else{
                msg += "Error: missing choreMode -- Weekly or Cleanup";
            }
            
            people = perd.getAllPeople();
            msg += perd.getMsg();
            display = "2";
            request.setAttribute("chores", chores);
            request.setAttribute("people", people);
    
            
        } else if (formname.equalsIgnoreCase("form2")) {// assign tasks button was clicked
            
            people = perd.getAllPeople();//get the people list
            msg += perd.getMsg();
            
            if (choreMode != null && choreMode.equalsIgnoreCase("WEEKLY")){
                chores = chd.getWeeklyChores();
                msg += chd.getMsg();
            }else if (choreMode != null && choreMode.equalsIgnoreCase("CLEANUP")){
                chores = chd.getCleanUpChores();
                msg += chd.getMsg();
            }else{
                 msg += "Error: missing choreMode -- Weekly or Cleanup";
            }
            
            ArrayList<Person> peeps = new ArrayList<Person>();
            //get checked people from form 
            for(Person p : people){
                if(request.getParameter(String.valueOf(p.getPpl_num())) != null){
                    peeps.add(p);
                }
            }
            //at this point peeps contains the people and chores contains the chores
            //now shuffle them pair with chores send back to form.
            if (chores != null){
                int len1 = peeps.size();
                int len2 = chores.size();
                Collections.shuffle(peeps);
                Collections.shuffle(chores);
                assign = new ArrayList<Assignment>();
                int j = 0;
                for(int i=0 ; i<len2 ; i++){
                    
                    Assignment a = new Assignment(peeps.get(j),chores.get(i));
                    //Assignment(String fname, String lname, int pid, String chore, int cid) 
                    assign.add(a);
                    
                    if (j == len1-1){
                        j = 0;
                    }else{
                        j++;
                    }
                }
                // now display the chore assignments
                request.getSession().setAttribute("assign", assign);
                display = "3";
                msg += "Tasks Shuffled and Assigned";
            }
        } else if (formname.equalsIgnoreCase("form3")) {// assignments were accepted or rejected 
            
            String btn = request.getParameter("assignbtn");
            if (btn.equalsIgnoreCase("ACCEPT")){
                // get assignments
                ArrayList<Assignment> a = (ArrayList<Assignment>)request.getSession().getAttribute("assign");
                int len = a.size();
                // write assignments to database with todays date?
                
                ???
  
                msg += "Need code to write the assignments to database";
                
            }else if (btn.equalsIgnoreCase("RE-DO")){
                // re-do assignments
                msg += attachPeople(request);
                msg += attachChores(request);
                display = "2";
             
                
            }else{
                msg += "unknown button seen.";
            }
            
        } else if (formname.equalsIgnoreCase("form4")) {// delete chore
            
            String chid = request.getParameter("chrId");
           
            if ( chid != null && !chid.isEmpty()){
                try{
                    int ichid = Integer.parseInt(chid);
                    // delete chore
                    // public void deleteChores(int ichid, int ictype, String chdesc)
                    
                    chd.deleteChores(ichid, 0, "");
                    msg += chd.getMsg();
                }catch(NumberFormatException e){
                    msg += "Error deleting chore id = ["+ chid +"]";
                }
                
            }else{
                msg += "Error deleting chore id = ["+ chid +"]";
            }
        }else if (formname.equalsIgnoreCase("form5")) { // add or edit chore
            String chid = request.getParameter("chrId");
            String chtype = request.getParameter("chrType");
            String chdesc = request.getParameter("chrDesc");
            int ichid = 0;
            int ichtype = -1;
            try{
                ichtype = Integer.parseInt(chtype);
                ichid = Integer.parseInt(chid);
            }catch(NumberFormatException e){
                // ignore
            }
            if (ichtype != 1 && ichtype != 2){
                 msg += "Error adding chore type=[" + chtype + "] desc=[" + chdesc + "] id=[" + chid +"]";
            }else if (chdesc == null || chdesc.trim().isEmpty()){
                 msg += "Error adding chore type=[" + chtype + "] desc=[" + chdesc + "] id=[" + chid +"]";
            }else{
                if (ichid > 0){// if core exists
                    // update
                    //public void updateChores(int ichid, int ictype, String chdesc)
                    chd.updateChores(ichid, ichtype, chdesc.trim());
                    
                    msg += chd.getMsg();
                    
                }else{// new chore
                    // insert
                    //public void addChores(int ichid, int ictype, String chdesc) 
                    chd.addChores(ichid, ichtype, chdesc.trim());
                    
                    msg += chd.getMsg();                   
                }
            }
            
        }else if (formname.equalsIgnoreCase("form6")) { // search
            String chdesc = request.getParameter("chrDesc");
            msg += "Need form6 handler here. desc=" + chdesc;;
            
            // search for chores
            //public void findChores(Integer ichid, Integer ictype, String taskDesc)
            
        }
    
        request.setAttribute("display", display);
        request.setAttribute("msg", msg);
        RequestDispatcher disp = getServletContext().getRequestDispatcher(URL);
        disp.forward(request, response);
    
    }// end of processRequest

    private String attachPeople(HttpServletRequest request){
        PersonDAO perd  = new PersonDAO();
        List<Person> people = null;
        String msg = "";
        people = perd.getAllPeople();
        msg += perd.getMsg();
            
        request.setAttribute("people", people);
        return msg;
    }
    
    private String attachChores(HttpServletRequest request){
        
        ChoreDAO chd = new ChoreDAO();
        List<Chore> chores = null;
        String chrtype1 = request.getParameter("choretp");
        String chrtype2 = (String)request.getSession().getAttribute("choreMode");
        String chrtype = "";
        String msg = "";
            
            if (chrtype1 != null && !chrtype1.isEmpty()){
                chrtype = chrtype1;
            }else if (chrtype2 != null && !chrtype2.isEmpty()){
                chrtype = chrtype2;
            }else{
                chrtype = "";
            }
                
            if (chrtype.equalsIgnoreCase("WEEKLY")) {
                chores = chd.getWeeklyChores();
                msg += chd.getMsg();
                request.getSession().setAttribute("choreMode", "Weekly");
                
            } else if (chrtype.equalsIgnoreCase("CLEANUP")) {
                chores = chd.getCleanUpChores();
                msg += chd.getMsg();
                request.getSession().setAttribute("choreMode", "Cleanup");
               
            }else{
                msg += "Error: missing choreMode";
            }
            request.setAttribute("chores", chores);
            return msg;
    }
    
    private void attachAssignedChores(){
        
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
