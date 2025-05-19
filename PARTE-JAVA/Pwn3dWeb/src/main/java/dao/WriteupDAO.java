package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import conexionDDBB.ConexionDDBB;

public class WriteupDAO {

	public boolean insertWriteup(int labId, int userId, String url, String username) {
	    ConexionDDBB db = new ConexionDDBB();
	    Connection con = null;
	    boolean exito = false;

	    String sql = "INSERT INTO writeups (lab_id, user_id, url_writeup, username) " +
	                 "VALUES (?, ?, ?, ?) " +
	                 "ON CONFLICT (lab_id, user_id) DO UPDATE SET " +
	                 "url_writeup = EXCLUDED.url_writeup, " +
	                 "username = EXCLUDED.username";

	    try {
	        con = db.conectar();
	        PreparedStatement stmt = con.prepareStatement(sql);

	        stmt.setInt(1, labId);
	        stmt.setInt(2, userId);
	        stmt.setString(3, url);
	        stmt.setString(4, username);

	        int filas = stmt.executeUpdate();
	        exito = filas > 0;

	        stmt.close();
	    } catch (SQLException e) {
	        System.err.println("Error al insertar o actualizar writeup:");
	        e.printStackTrace();
	    } finally {
	        db.cerrarConexion();
	    }

	    return exito;
	}
	
	public boolean insertWriteupDockerpwned(int labId, int userId, String url, String username) {
	    ConexionDDBB db = new ConexionDDBB();
	    Connection con = null;
	    boolean exito = false;

	    String sql = "INSERT INTO writeups_dockerpwned (lab_id, user_id, url_writeup, username) " +
	                 "VALUES (?, ?, ?, ?) " +
	                 "ON CONFLICT (lab_id, user_id) DO UPDATE SET " +
	                 "url_writeup = EXCLUDED.url_writeup, " +
	                 "username = EXCLUDED.username";

	    try {
	        con = db.conectar();
	        PreparedStatement stmt = con.prepareStatement(sql);

	        stmt.setInt(1, labId);
	        stmt.setInt(2, userId);
	        stmt.setString(3, url);
	        stmt.setString(4, username);

	        int filas = stmt.executeUpdate();
	        exito = filas > 0;

	        stmt.close();
	    } catch (SQLException e) {
	        System.err.println("Error al insertar o actualizar writeup dockerpwned:");
	        e.printStackTrace();
	    } finally {
	        db.cerrarConexion();
	    }

	    return exito;
	}
	
	public boolean insertWriteupOvalabs(int labId, int userId, String url, String username) {
	    ConexionDDBB db = new ConexionDDBB();
	    Connection con = null;
	    boolean exito = false;

	    String sql = "INSERT INTO writeups_ovalabs (lab_id, user_id, url_writeup, username) " +
	                 "VALUES (?, ?, ?, ?) " +
	                 "ON CONFLICT (lab_id, user_id) DO UPDATE SET " +
	                 "url_writeup = EXCLUDED.url_writeup, " +
	                 "username = EXCLUDED.username";

	    try {
	        con = db.conectar();
	        PreparedStatement stmt = con.prepareStatement(sql);

	        stmt.setInt(1, labId);
	        stmt.setInt(2, userId);
	        stmt.setString(3, url);
	        stmt.setString(4, username);

	        int filas = stmt.executeUpdate();
	        exito = filas > 0;

	        stmt.close();
	    } catch (SQLException e) {
	        System.err.println("Error al insertar o actualizar writeup ovalabs:");
	        e.printStackTrace();
	    } finally {
	        db.cerrarConexion();
	    }

	    return exito;
	}
	
	public boolean insertWriteupTimelabs(int labId, int userId, String url, String username) {
	    ConexionDDBB db = new ConexionDDBB();
	    Connection con = null;
	    boolean exito = false;

	    String sql = "INSERT INTO writeups_timelabs (lab_id, user_id, url_writeup, username) " +
	                 "VALUES (?, ?, ?, ?) " +
	                 "ON CONFLICT (lab_id, user_id) DO UPDATE SET " +
	                 "url_writeup = EXCLUDED.url_writeup, " +
	                 "username = EXCLUDED.username";

	    try {
	        con = db.conectar();
	        PreparedStatement stmt = con.prepareStatement(sql);

	        stmt.setInt(1, labId);
	        stmt.setInt(2, userId);
	        stmt.setString(3, url);
	        stmt.setString(4, username);

	        int filas = stmt.executeUpdate();
	        exito = filas > 0;

	        stmt.close();
	    } catch (SQLException e) {
	        System.err.println("Error al insertar o actualizar writeup timelabs:");
	        e.printStackTrace();
	    } finally {
	        db.cerrarConexion();
	    }

	    return exito;
	}
}
