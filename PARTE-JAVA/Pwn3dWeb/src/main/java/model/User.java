package model;

import java.sql.Timestamp;

public class User {
    private int id;
    private String nombre;
    private String apellido;
    private String usuario;
    private String email;
    private String password;
    private String rol;
    private String cookie;
    private int flagsUser;
    private int flagsRoot;
    private java.sql.Timestamp ultimoInicio;
    private String codeSecure;
    private int puntos;
    private String pais;

	public User(int id, String nombre, String apellido, String usuario, String email, String password, String rol,
			String cookie, int flagsUser, int flagsRoot, Timestamp ultimoInicio) {
		super();
		this.id = id;
		this.nombre = nombre;
		this.apellido = apellido;
		this.usuario = usuario;
		this.email = email;
		this.password = password;
		this.rol = rol;
		this.cookie = cookie;
		this.flagsUser = flagsUser;
		this.flagsRoot = flagsRoot;
		this.ultimoInicio = ultimoInicio;
	}
	public User() {
		// TODO Auto-generated constructor stub
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getApellido() {
		return apellido;
	}
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRol() {
		return rol;
	}
	public void setRol(String rol) {
		this.rol = rol;
	}
	public String getCookie() {
		return cookie;
	}
	public void setCookie(String cookie) {
		this.cookie = cookie;
	}
	public int getFlagsUser() {
		return flagsUser;
	}
	public void setFlagsUser(int flagsUser) {
		this.flagsUser = flagsUser;
	}
	public int getFlagsRoot() {
		return flagsRoot;
	}
	public void setFlagsRoot(int flagsRoot) {
		this.flagsRoot = flagsRoot;
	}
	public java.sql.Timestamp getUltimoInicio() {
		return ultimoInicio;
	}
	public void setUltimoInicio(java.sql.Timestamp ultimoInicio) {
		this.ultimoInicio = ultimoInicio;
	}

	public String getCodeSecure() {
	    return codeSecure;
	}

	public void setCodeSecure(String codeSecure) {
	    this.codeSecure = codeSecure;
	}
	public int getPuntos() {
		return puntos;
	}
	public void setPuntos(int puntos) {
		this.puntos = puntos;
	}
	public String getPais() {
		return pais;
	}
	public void setPais(String pais) {
		this.pais = pais;
	}
}
