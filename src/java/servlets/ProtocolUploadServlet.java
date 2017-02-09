package servlets;

import business.Protocol;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import business.ProtocolDAO;
import java.util.List;

/**
 @author Miriam
 */
//@WebServlet(name = "/ProtocoUploadServlet"/*, urlPatterns = {"/ProtocolUpload"}*/)
@MultipartConfig(fileSizeThreshold=1024 * 1024 * 1,//1MB
        maxFileSize=1024 * 1024 * 1,//1MB
        maxRequestSize=1024 * 1024 * 2)//2MB
public class ProtocolUploadServlet extends HttpServlet {
    private final static Logger LOGGER = Logger.getLogger(ProtocolUploadServlet.class.getCanonicalName());
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String msg = "";
        String URL = "/protocol.jsp";
        ProtocolDAO protd = new ProtocolDAO();
        List<Protocol> protocols = null;
        String action = request.getParameter("hdnAction");
        String protnm = request.getParameter("protName");
        String txtprot = request.getParameter("txtprot");
        
        if(action == null) {action = ""; }
        
        // Create path components to save the file
        String path = getServletContext().getRealPath("/") + "flintstones";// was flintstones
        Part filePart = request.getPart("uploadfile");
        String fileName = getFileName(filePart);
        Date d = new Date();
        String newFileNm = "P" + d.getTime() + "_" + fileName;
    //    String filePath = path + "/" + fileName; 
        
        OutputStream out = null;
        InputStream filecontent = null;
        
        File uploadDir = new File(path);
        if(!uploadDir.exists()) {
            uploadDir.mkdir();
            msg += "Creating upload directory<br>";
        }
        
        try {
            out = new FileOutputStream(new File(path + File.separator + fileName));
            filecontent = filePart.getInputStream();
            
            int read = 0;
            byte[] bytes = new byte[1024];
            
            while ((read = filecontent.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }
            msg += "New file " + fileName + " created at " + path;
            LOGGER.log(Level.INFO, "File{0} being uploaded to {1}", new Object[]{fileName, path});
            if (action.equalsIgnoreCase("INSERT") == true) {
                protd.addProtocol(fileName, path, txtprot);
                protocols = protd.getAllProtocols();
                protd.getMsg();
            }
            URL = "/protocol.jsp";
        } catch(FileNotFoundException e) {
            msg += "Either you did not specify a file to upload or "
                    + "you are trying to upload a file to a protected or "
                    + "nonexistent location. <br> ERROR: " + e.getMessage();
            LOGGER.log(Level.SEVERE, "Problems with file upload. Error: {0}",
                    new Object[]{e.getMessage()});
            URL = "/error.jsp";
        } catch (IOException e) {
            msg += "Problem getting file: " + e.getMessage();
            URL = "/error.jsp";
        } catch (Exception e) {
            msg += "Problems: " + e.getMessage();
            URL = "/error.jsp";
        } finally {
            if (out != null) {
                out.close();
            }
            if (filecontent != null) {
                filecontent.close();
            }
        }
        request.setAttribute("msg", msg);
        request.setAttribute("fileName", fileName);
        request.setAttribute("prot", protocols);
        RequestDispatcher disp = getServletContext().getRequestDispatcher(URL);
        disp.forward(request, response);
    }
    
    private String getFileName(final Part part) {

        final String partHeader = part.getHeader("content-disposition");
        LOGGER.log(Level.INFO, "Part Header = {0}", partHeader);
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') +1).trim().replace("\"", "");
            }
        }
        return null;
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
        
        
    }//End doPost
    
        
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
