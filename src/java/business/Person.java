package business;

/**
 *
 * @author Miriam
 */
public class Person {
    private int ppl_num;
    private String fname;
    private String minit;
    private String lname;
    private String unm;
    private String pwd;
    
    public Person() {
        ppl_num = 0;
        fname = "";
        minit = "";
        lname = "";
        unm = "";
        pwd = "";
    }

    public int getPpl_num() {
        return ppl_num;
    }

    public void setPpl_num(int ppl_num) {
        this.ppl_num = ppl_num;
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

    public String getMinit() {
        return minit;
    }

    public void setMinit(String minit) {
        this.minit = minit;
    }

    public String getUnm() {
        return unm;
    }

    public void setUnm(String unm) {
        this.unm = unm;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }
}

