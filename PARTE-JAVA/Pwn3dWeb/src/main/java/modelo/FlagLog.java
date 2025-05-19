package modelo;

public class FlagLog {
    private String username;
    private String photoPath;

    public FlagLog(String username, String photoPath) {
        this.username = username;
        this.photoPath = photoPath;
    }

    public String getUsername() {
        return username;
    }

    public String getPhotoPath() {
        return photoPath;
    }
}