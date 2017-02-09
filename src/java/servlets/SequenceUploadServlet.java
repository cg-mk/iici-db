package servlets;

import business.Sequence;
import business.SequenceDAO;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * @author Miriam
 */
public class SequenceUploadServlet extends HttpServlet {
    
    String msg = "";
    String seqName = "";
    String URL = "/sequence.jsp";
    SequenceDAO seqd = new SequenceDAO();
    Timestamp ts = null;
    

    //location to store uploaded file
    //In reality, you would use a properties file in source folder. load with Java class resource bundle (java.util???)
    private static final String UPLOAD_DIR = "jetsons"; // was jetsons
    //upload settings
    private static final int MEM_THRESHOLD  = 1024 * 1024 * 1;
    private static final int MAX_FILE_SIZE  = 1024 * 1024 * 1;
    private static final int MAX_REQUEST_SIZE  = 1024 * 1024 * 1;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                                            throws ServletException, IOException {
       response.setContentType("text/html;charset=UTF-8");
       msg = "ERROR doGet";
    }// end doGet

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                                            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Date d = new Date();
        String newFileNm = "";
        msg = "";
        List<Sequence> sequences = null;
        
         //check to see if request has a file to upload...
        if(!ServletFileUpload.isMultipartContent(request)) {
            msg += "No file to upload";
            return;
        }
        //configure upload settings
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(MEM_THRESHOLD);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setFileSizeMax(MAX_FILE_SIZE);
        upload.setSizeMax(MAX_REQUEST_SIZE);
        
        //constructs the directory path to store uploaded file - pate is relative to app's directory
        String path = getServletContext().getRealPath("") + UPLOAD_DIR;
        //create dir if it doesn't exist...
        File uploadDir = new File(path);
        if(!uploadDir.exists()) {
            uploadDir.mkdir();
            msg += "Creating upload directory<br>";
        }
        try { //parse contend to request to extract file data
            @SuppressWarnings("unchecked")
            List<FileItem> items = upload.parseRequest(request);
            boolean success = false;
            if (items != null && items.size() > 0) {
                for (FileItem item : items) { // this loop finds the file in the submitted form 
                    if(!item.isFormField()) {
                        seqName = new File(item.getName()).getName();
                        newFileNm = "S" + d.getTime() + "_" + seqName; //make new file name unique
                        String filePath = path + File.separator + seqName;
                        File storeFile = new File(filePath);
                        //save file to disk
                        item.write(storeFile);
                        msg += seqName + " has been successfully uploaded.";
                        success = true;
                    }
                    
                }
            }
            if (success){
                
                seqd.addSeq(seqName, path, d, path);
                sequences = seqd.getAllSeqs();
                msg += seqd.getMsg();
            }
        } catch (Exception e) {
            msg += "Error: " + e.getMessage();
            URL = "/Error.jsp";
        }
                
        request.setAttribute("msg", msg);
        request.setAttribute("seqName", seqName);
        request.setAttribute("seq", sequences);
        RequestDispatcher disp = getServletContext().getRequestDispatcher(URL);
        disp.forward(request, response);
        
    }// end doPost

  
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}// end of class
