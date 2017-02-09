package business;

import java.util.Date;

/**
 *
 * @author Miriam
 */
public class Sequence {
    private int seqID;
    private String seqName;
    private String seqPath;
    private Date seqDt;
    private String seqData;
    
    public Sequence() {
        seqID = 0;
        seqName = "";
        seqPath = "";
        seqDt = null;
        seqData = "";
    }

    public int getSeqID() {
        return seqID;
    }

    public void setSeqID(int seqID) {
        this.seqID = seqID;
    }

    public String getSeqName() {
        return seqName;
    }

    public void setSeqName(String seqName) {
        this.seqName = seqName;
    }

    public String getSeqPath() {
        return seqPath;
    }

    public void setSeqPath(String seqPath) {
        this.seqPath = seqPath;
    }

    public Date getSeqDt() {
        return seqDt;
    }

    public void setSeqDt(Date seqDt) {
        this.seqDt = seqDt;
    }

    public String getSeqData() {
        return seqData;
    }
        
    public String getSafeSeqData() {
        if(this.seqData != null && this.seqData.length() > 0){
            String s = seqData;
            s = s.replace("&", "&amp;");
            s = s.replace(">", "&gt;");
            s = s.replace("<", "&lt;");
            return s;
        }else{
            return "";
        }
    }
    public void setSeqData(String seqData) {
        this.seqData = seqData;
    }
    
    
}//End sequence class
