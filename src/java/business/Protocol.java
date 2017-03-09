package business;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

/**
  @author Miriam
 */
public class Protocol {
    private int protID;
    private String protName;
    private String protPath;
    private String protData;
    
    public Protocol() {
        protID = 0;
        protName = "";
        protPath = "";
        protData = "";
    }

    public int getProtID() {
        return protID;
    }

    public void setProtID(int protID) {
        this.protID = protID;
    }

    public String getProtName() {
        return protName;
    }

    public void setProtName(String protName) {
        this.protName = protName;
    }

    public String getProtPath() {
        return protPath;
    }

    public void setProtPath(String protPath) {
        this.protPath = protPath;
    }
    
    public String getProtData() {
        return protData;
    }
    
    public String getSafeProtData() {
        if(this.protData != null && this.protData.length() > 0){
            String s = protData;
            s = s.replace("&", "&amp;");
            s = s.replace(">", "&gt;");
            s = s.replace("<", "&lt;");
            s = s.replace("'", "?");
            s = s.replace("\"", "?");
            return s;
        }else{
            return "";
        }
    }
    
    public void setProtData(String protData) {
        this.protData = protData;
    }
    
    String msg = "";
    Connection conn = null;
    Statement s = null;
    PreparedStatement ps = null;
    String sql;
    ResultSet r;
    Protocol prot;
    List<Protocol> protocols;
}
