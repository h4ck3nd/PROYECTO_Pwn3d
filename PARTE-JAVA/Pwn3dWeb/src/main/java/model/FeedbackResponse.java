package model;

public class FeedbackResponse {
    private int id;
    private int userId;
    private String message;
    private String estado;
    private String username;
    private String avatarPath;
    private String adminReply; // si tienes alguna respuesta admin
    private boolean esProHacker;

    public boolean isEsProHacker() {
        return esProHacker;
    }

    public void setEsProHacker(boolean esProHacker) {
        this.esProHacker = esProHacker;
    }


    public FeedbackResponse() {}

    // getters y setters para todos los campos
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getAvatarPath() { return avatarPath; }
    public void setAvatarPath(String avatarPath) { this.avatarPath = avatarPath; }

    public String getAdminReply() { return adminReply; }
    public void setAdminReply(String adminReply) { this.adminReply = adminReply; }
}
