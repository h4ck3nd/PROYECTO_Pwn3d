package utils;

public class UsuarioJWT {
    private String nombre;
    private String apellidos;
    private String rol;
    private String email;
    private String ultimoLogin;
    private String usuario;
    private String cookie;
    private String userId;
    private String token;

    // Constructor
    public UsuarioJWT(String nombre, String apellidos, String rol, String email,
                      String ultimoLogin, String usuario, String cookie, String userId, String token) {
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.rol = rol;
        this.email = email;
        this.ultimoLogin = ultimoLogin;
        this.usuario = usuario;
        this.cookie = cookie;
        this.userId = userId;
        this.token = token;
    }

    // Getters
    public String getNombre() { return nombre; }
    public String getApellidos() { return apellidos; }
    public String getRol() { return rol; }
    public String getEmail() { return email; }
    public String getUltimoLogin() { return ultimoLogin; }
    public String getUsuario() { return usuario; }
    public String getCookie() { return cookie; }
    public String getUserId() { return userId; }
    public String getToken() { return token; }
}