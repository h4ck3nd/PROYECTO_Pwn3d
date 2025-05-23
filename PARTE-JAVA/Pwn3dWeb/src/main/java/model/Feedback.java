package model;

import java.sql.Timestamp;

public class Feedback {
    private int id;
    private int userId;
    private String message;
    private String estado;
    private Timestamp timeCreated;

    public Feedback() {}

    public Feedback(int userId, String message) {
        this.userId = userId;
        this.message = message;
        this.estado = "Por contestar...";
    }

    // getters y setters
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
