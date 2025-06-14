package model;

import java.sql.Timestamp; // Asegúrate de importar esto arriba

public class Flag {
    private int id;
    private int idUser;
    private String vmName;
    private String user;
    private String tipoFlag; // "user" o "root"
    private String flag;
    private boolean firstFlagUser;
    private boolean firstFlagRoot;
    private Timestamp createdAt;
    private String imgSrc;
    private boolean esProHacker;

    public boolean isEsProHacker() {
        return esProHacker;
    }

    public void setEsProHacker(boolean esProHacker) {
        this.esProHacker = esProHacker;
    }


    // Constructor completo
    public Flag(int id, int idUser, String vmName, String user, String tipoFlag, String flag,
                boolean firstFlagUser, boolean firstFlagRoot) {
        this.id = id;
        this.idUser = idUser;
        this.vmName = vmName;
        this.user = user;
        this.tipoFlag = tipoFlag;
        this.flag = flag;
        this.firstFlagUser = firstFlagUser;
        this.firstFlagRoot = firstFlagRoot;
    }

    public String getImgSrc() {
        return imgSrc;
    }

    public void setImgSrc(String imgSrc) {
        this.imgSrc = imgSrc;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // Constructor vacío
    public Flag() {
        // Requerido para frameworks o instanciación manual
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getVmName() {
        return vmName;
    }

    public void setVmName(String vmName) {
        this.vmName = vmName;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getTipoFlag() {
        return tipoFlag;
    }

    public void setTipoFlag(String tipoFlag) {
        this.tipoFlag = tipoFlag;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public boolean isFirstFlagUser() {
        return firstFlagUser;
    }

    public void setFirstFlagUser(boolean firstFlagUser) {
        this.firstFlagUser = firstFlagUser;
    }

    public boolean isFirstFlagRoot() {
        return firstFlagRoot;
    }

    public void setFirstFlagRoot(boolean firstFlagRoot) {
        this.firstFlagRoot = firstFlagRoot;
    }
}
