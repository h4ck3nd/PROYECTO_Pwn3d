package model;

import java.sql.Timestamp;

public class InfoNotice {
    private int id;
    private String description;
    private String vmName;
    private String date;
    private Timestamp timeCreated;
    private String estado;
    private String os;
    private String difficulty;
    private String environment;
    private String secondEnvironment;
    private String pathInfoNotice;
    private String creator;

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }


    public String getPathInfoNotice() {
        return pathInfoNotice;
    }

    public void setPathInfoNotice(String pathInfoNotice) {
        this.pathInfoNotice = pathInfoNotice;
    }

    public String getSecondEnvironment() {
        return secondEnvironment;
    }
    public void setSecondEnvironment(String secondEnvironment) {
        this.secondEnvironment = secondEnvironment;
    }

    public String getEnvironment() {
        return environment;
    }

    public void setEnvironment(String environment) {
        this.environment = environment;
    }

    // Getters y setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getVmName() { return vmName; }
    public void setVmName(String vmName) { this.vmName = vmName; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public Timestamp getTimeCreated() { return timeCreated; }
    public void setTimeCreated(Timestamp timeCreated) { this.timeCreated = timeCreated; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getOs() { return os; }
    public void setOs(String os) { this.os = os; }

    public String getDifficulty() { return difficulty; }
    public void setDifficulty(String difficulty) { this.difficulty = difficulty; }
}