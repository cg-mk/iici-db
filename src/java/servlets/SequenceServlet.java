package servlets;

import business.Sequence;
import business.SequenceDAO;
//import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
//import java.io.InputStream;
//import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import org.apache.commons.fileupload.FileItem;
//import org.apache.commons.fileupload.disk.DiskFileItemFactory;
//import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Miriam
 */
public class SequenceServlet extends HttpServlet {
    
//    public void init( ){
//      // Get the file location where it would be stored.
//      //filePath = getServletContext().getInitParameter("file-upload"); 
//   }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        SequenceDAO seqd = new SequenceDAO();
        String msg = seqd.getMsg();
        //String sql = "";
        String URL = "/sequence.jsp";
        String seqpath = null;
        Date d = null;
        List<Sequence> sequences = new ArrayList<Sequence>();
        String cntmsg = "";
                
        String subm = request.getParameter("btnSubmit");
        //String dbtn = request.getParameter("hdnDel");
        //String sbtn = request.getParameter("hdnSearch");
        String seqid = request.getParameter("hdnSeqId");
        String seqname = request.getParameter("seqName");
        String seqtxt = request.getParameter("txtseq");
        String action = request.getParameter("hdnAction");
        String seqDesc = request.getParameter("seqdesc");
        
        if(subm == null){ subm = ""; }
        //if(dbtn == null){ dbtn = ""; }
        //if(sbtn == null){ sbtn = ""; }
        if (action == null){action = ""; }
        
        int iseqid = -1;
        
        
        if (action.isEmpty()){
            // do nothing except return all sequences
        }else if (action.equalsIgnoreCase("INSERT") == true) { // IF Insert New
            if (!seqtxt.isEmpty()) {
            sequences = null;
            seqd.addSeq(seqname, seqpath, d, seqtxt);
            msg += seqd.getMsg();
            }
        }else if (action.equalsIgnoreCase("UPDATE") == true) { // IF Update
            if (!seqid.isEmpty()) {
                try {
                    iseqid = Integer.parseInt(seqid);
                    if (iseqid < 0) {
                        msg += "Validation failed: Id must be positive.<br>";
                    }
                } catch (NumberFormatException e) {
                    msg += "Validation failed: Id is invalid.<br>";
                }
            }
            seqd.updateSequence(iseqid, seqname, d, seqpath, seqtxt);
            msg += seqd.getMsg();
        }else if (action.equalsIgnoreCase("DELETE") == true) { // IF Delete
            if (!seqid.isEmpty()) {
                try {
                    iseqid = Integer.parseInt(seqid);
                    if (iseqid<0){
                    msg += "Validation failed: negative id.<br>";
                    } 
                } catch(NumberFormatException e){
                msg += "Validation failed: invalid id.<br>";
                }
            }
            seqd.deleteSeq(iseqid, seqname, seqpath, seqtxt);
            seqd.getMsg();
        }else if (action.equalsIgnoreCase("SEARCH") == true) { // IF Search
            sequences = null;
            if (seqDesc.length() > 0) {
                sequences = seqd.findSequences(seqDesc);
                msg += seqd.getMsg();
            }
        }else{
            msg += "Unknown Action: [" + action + "]<br/>";
        }
        
        if (action.equalsIgnoreCase("SEARCH") == false) { // IF NOT SEARCH
            sequences = seqd.getAllSeqs();
            msg += seqd.getMsg();
            cntmsg = seqd.getCntMsg();
        }

        
        request.setAttribute("msg", msg);
        request.setAttribute("seq", sequences);
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
