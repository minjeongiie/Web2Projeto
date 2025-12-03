package model;



public class Local {

    private int id;

    private String nomeLocal;
    private String predio;
    private String andar;
    private String sala;
    private String linkOnline;

    public Local() {
    }

    public Local(String nomeLocal, String predio, String andar, String sala, String linkOnline) {
        this.nomeLocal = nomeLocal;
        this.predio = predio;
        this.andar = andar;
        this.sala = sala;
        this.linkOnline = linkOnline;
    }

    public int getId() {
        return id;
    }

    public String getNomeLocal() {
        return nomeLocal;
    }

    public void setNomeLocal(String nomeLocal) {
        this.nomeLocal = nomeLocal;
    }

    public String getPredio() {
        return predio;
    }

    public void setPredio(String predio) {
        this.predio = predio;
    }

    public String getAndar() {
        return andar;
    }

    public void setAndar(String andar) {
        this.andar = andar;
    }

    public String getSala() {
        return sala;
    }

    public void setSala(String sala) {
        this.sala = sala;
    }

    public String getLinkOnline() {
        return linkOnline;
    }

    public void setLinkOnline(String linkOnline) {
        this.linkOnline = linkOnline;
    }
}
