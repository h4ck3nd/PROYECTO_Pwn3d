package model;

import java.sql.Timestamp;

public class Request {
    private int id;
    private int userId;
    private String message;
    private String estado;
    private Timestamp timeCreated;
    private String userName;
    private String userImgPath; // nueva propiedad
    private int loves;
    private boolean lovedByUser;
    private boolean esProHacker;

    public boolean isEsProHacker() {
        return esProHacker;
    }

    public void setEsProHacker(boolean esProHacker) {
        this.esProHacker = esProHacker;
    }

    // getters y setters
    public int getLoves() { return loves; }
    public void setLoves(int loves) { this.loves = loves; }

    public boolean isLovedByUser() { return lovedByUser; }
    public void setLovedByUser(boolean lovedByUser) { this.lovedByUser = lovedByUser; }


    // getters y setters existentes...

    public String getUserImgPath() {
        return userImgPath;
    }

    public void setUserImgPath(String userImgPath) {
        this.userImgPath = userImgPath;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }


    // Getters y setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    public Timestamp getTimeCreated() { return timeCreated; }
    public void setTimeCreated(Timestamp timeCreated) { this.timeCreated = timeCreated; }
}