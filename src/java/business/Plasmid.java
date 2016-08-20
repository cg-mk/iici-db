
package business;

/**
 *
 * @author Miriam
 */
public class Plasmid {
    private int plasmidID;
    private String bin;
    private String intermed;
    private String res;
    private String pldesc;
    private String author;
    private int nbnum;
    private int nbpg;
    private String ckdt;
    private int cknbnum;
    private int cknbpg;
    
    public Plasmid() {
        plasmidID = 0;
        bin = "";
        intermed = "";
        res = "";
        pldesc = "";
        author = "";
        nbnum = 0;
        nbpg = 0;
        ckdt = "";
        cknbnum = 0;
        cknbpg = 0;
    }

    /**
     * @return the plasmidID
     */
    public int getPlasmidID() {
        return plasmidID;
    }

    /**
     * @param plasmidID the plasmidID to set
     */
    public void setPlasmidID(int plasmidID) {
        this.plasmidID = plasmidID;
    }

    /**
     * @return the bin
     */
    public String getBin() {
        return bin;
    }

    /**
     * @param bin the bin to set
     */
    public void setBin(String bin) {
        this.bin = bin;
    }

    /**
     * @return the intermed
     */
    public String getIntermed() {
        return intermed;
    }

    /**
     * @param intermed the intermed to set
     */
    public void setIntermed(String intermed) {
        this.intermed = intermed;
    }

    /**
     * @return the resistance
     */
    public String getRes() {
        return res;
    }

    /**
     * @param resistance the resistance to set
     */
    public void setRes(String res) {
        this.res = res;
    }

    /**
     * @return the pldesc
     */
    public String getPldesc() {
        return pldesc;
    }

    /**
     * @param pldesc the pldesc to set
     */
    public void setPldesc(String pldesc) {
        this.pldesc = pldesc;
    }

    /**
     * @return the author
     */
    public String getAuthor() {
        return author;
    }

    /**
     * @param author the author to set
     */
    public void setAuthor(String author) {
        this.author = author;
    }

    /**
     * @return the nbnum
     */
    public int getNbnum() {
        return nbnum;
    }

    /**
     * @param nbmun the nbnum to set
     */
    public void setNbnum(int nbnum) {
        this.nbnum = nbnum;
    }

    /**
     * @return the nbpg
     */
    public int getNbpg() {
        return nbpg;
    }

    /**
     * @param nbpg the nbpg to set
     */
    public void setNbpg(int nbpg) {
        this.nbpg = nbpg;
    }

    /**
     * @return the ckdt
     */
    public String getCkdt() {
        return ckdt;
    }

    /**
     * @param ckdt the ckdt to set
     */
    public void setCkdt(String ckdt) {
        this.ckdt = ckdt;
    }

    /**
     * @return the cknbnum
     */
    public int getCknbnum() {
        return cknbnum;
    }

    /**
     * @param cknbnum the cknbnum to set
     */
    public void setCknbnum(int cknbnum) {
        this.cknbnum = cknbnum;
    }

    /**
     * @return the cknbpg
     */
    public int getCknbpg() {
        return cknbpg;
    }

    /**
     * @param cknbpg the cknbpg to set
     */
    public void setCknbpg(int cknbpg) {
        this.cknbpg = cknbpg;
    }
    @Override
    public String toString(){
        return "Plasmid:[plasmidID="+plasmidID+",bin="+bin+",intermed="+intermed
                +",res="+res+", pldesc="+pldesc+",author="+author+",nbnum="+nbnum
                +",nbpg="+nbpg+",ckdt="+ckdt+",cknbnum="+cknbnum+",cknbpg="+cknbpg+"]";
        /*  
        res = "";
        pldesc = "";
        author = "";
        nbnum = 0;
        nbpg = 0;
        ckdt = "";
        cknbnum = 0;
        cknbpg = 0;
        */
    }
}//End Plasmid class
