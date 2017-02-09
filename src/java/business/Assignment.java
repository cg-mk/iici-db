package business;

/**
 * @author Miriam
 */
public class Assignment {
    private int pepid;
    private String fname;
    private String lname;
    private int choreid;
    private String taskDesc;
    
    public Assignment(String fname, String lname, int pid, String chore, int cid) {
        this.fname = fname;
        this.lname = lname;
        taskDesc = chore;
        pepid = pid;
        choreid = cid;
    }
    public Assignment(Person p, Chore c) {
        this.fname = p.getFname();
        this.lname = p.getLname();
        taskDesc = c.getTaskDesc();
        pepid = p.getPpl_num();
        choreid = c.getTaskID();
    }

    public String getFullName() {
        String fullName = fname + "" + lname.substring(0) + ".";
        return fullName;
    }

    public int getPepid() {
        return pepid;
    }

    public void setPepid(int pepid) {
        this.pepid = pepid;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public int getChoreid() {
        return choreid;
    }

    public void setChoreid(int choreid) {
        this.choreid = choreid;
    }

    public String getTaskDesc() {
        return taskDesc;
    }

    public void setTaskDesc(String taskDesc) {
        this.taskDesc = taskDesc;
    }
    
   
}// end of class
