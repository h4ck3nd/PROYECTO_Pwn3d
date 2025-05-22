package model;

public class EditProfile {
    private int id;
    private int userId;
    private String socialIcon;
    private String titleSocial;
    private String urlSocial;
    private String estado;
    private String pais;

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }


    // Getters y setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getSocialIcon() { return socialIcon; }
    public void setSocialIcon(String socialIcon) { this.socialIcon = socialIcon; }

    public String getTitleSocial() { return titleSocial; }
    public void setTitleSocial(String titleSocial) { this.titleSocial = titleSocial; }

    public String getUrlSocial() { return urlSocial; }
    public void setUrlSocial(String urlSocial) { this.urlSocial = urlSocial; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}
