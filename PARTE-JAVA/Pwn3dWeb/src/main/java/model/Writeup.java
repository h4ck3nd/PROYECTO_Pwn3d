package model;

public class Writeup {
    private String url;
    private String vmName;
    private int userId;
    private String creator;
    private String contentType;
    private String language;
    private String opinion;
    private String estado; // "Pendiente" o "Publicado"

    // Getters y setters para todos los campos
    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public String getVmName() { return vmName; }
    public void setVmName(String vmName) { this.vmName = vmName; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCreator() { return creator; }
    public void setCreator(String creator) { this.creator = creator; }

    public String getContentType() { return contentType; }
    public void setContentType(String contentType) { this.contentType = contentType; }

    public String getLanguage() { return language; }
    public void setLanguage(String language) { this.language = language; }

    public String getOpinion() { return opinion; }
    public void setOpinion(String opinion) { this.opinion = opinion; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}
