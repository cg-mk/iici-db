
package business;
/*
 * @author Miriam
 */
public class Primer {
    private int primerID;
    private String sequence;
    private String prDesc;
    
    public Primer() {
        primerID = 0;
        sequence = "";
        prDesc = "";
    }

    /**
     * @return the primerID
     */
    public int getPrimerID() {
        return primerID;
    }

    /**
     * @param primerID the primerID to set
     */
    public void setPrimerID(int primerID) {
        this.primerID = primerID;
    }

    /**
     * @return the sequence
     */
    public String getSequence() {
        return sequence;
    }

    /**
     * @param sequence the sequence to set
     */
    public void setSequence(String sequence) {
        this.sequence = sequence;
    }

    /**
     * @return the prDesc
     */
    public String getPrDesc() {
        return prDesc;
    }

    /**
     * @param prDesc the prDesc to set
     */
    public void setPrDesc(String prDesc) {
        this.prDesc = prDesc;
    }
    
    @Override
    public String toString(){
        return "Primer:[primerID="+primerID+",sequence="+sequence+ ",prDesc="+prDesc+"]";
    }
}
