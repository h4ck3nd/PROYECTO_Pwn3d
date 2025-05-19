package modelo;

public class Writeup {
    private String username;
    private String url;
    private String nombreLaboratorio;

    public Writeup(String username, String url, String nombreLaboratorio) {
        this.username = username;
        this.url = url;
        this.nombreLaboratorio = nombreLaboratorio;
    }

    public String getUsername() {
        return username;
    }

    public String getUrl() {
        return url;
    }

    public String getNombreLaboratorio() {
        return nombreLaboratorio;
    }
}