package dao;

import conexionDDBB.ConexionDDBB;
import modelo.Writeup;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WriteupUserDAO {

	public static List<Writeup> obtenerWriteupsPorLabId(int labId) {
	    List<Writeup> lista = new ArrayList<>();
	    ConexionDDBB db = new ConexionDDBB();
	    Connection con = null;

	    String sql = "SELECT w.url_writeup, w.username, l.nombre " +
	                 "FROM writeups w " +
	                 "JOIN laboratorios l ON w.lab_id = l.lab_id " +
	                 "WHERE w.lab_id = ?";

	    try {
	        con = db.conectar();
	        PreparedStatement stmt = con.prepareStatement(sql);
	        stmt.setInt(1, labId);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            String url = rs.getString("url_writeup");
	            String username = rs.getString("username");
	            String nombreLab = rs.getString("nombre");

	            lista.add(new Writeup(username, url, nombreLab));
	        }

	        rs.close();
	        stmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.cerrarConexion();
	    }

	    return lista;
	}
	
	public static List<Writeup> obtenerWriteupsPorLabIdDockerpwned(int labId) {
	    List<Writeup> lista = new ArrayList<>();
	    ConexionDDBB db = new ConexionDDBB();
	    Connection con = null;

	    String sql = "SELECT w.url_writeup, w.username, l.nombre " +
	                 "FROM writeups_dockerpwned w " +
	                 "JOIN laboratorios_dockerpwned l ON w.lab_id = l.lab_id " +
	                 "WHERE w.lab_id = ?";

	    try {
	        con = db.conectar();
	        PreparedStatement stmt = con.prepareStatement(sql);
	        stmt.setInt(1, labId);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            String url = rs.getString("url_writeup");
	            String username = rs.getString("username");
	            String nombreLab = rs.getString("nombre");

	            lista.add(new Writeup(username, url, nombreLab));
	        }

	        rs.close();
	        stmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.cerrarConexion();
	    }

	    return lista;
	}
	
	public static List<Writeup> obtenerWriteupsPorLabIdOvalabs(int labId) {
	    List<Writeup> lista = new ArrayList<>();
	    ConexionDDBB db = new ConexionDDBB();
	    Connection con = null;

	    String sql = "SELECT w.url_writeup, w.username, l.nombre " +
	                 "FROM writeups_ovalabs w " +
	                 "JOIN laboratorios_ovalabs l ON w.lab_id = l.lab_id " +
	                 "WHERE w.lab_id = ?";

	    try {
	        con = db.conectar();
	        PreparedStatement stmt = con.prepareStatement(sql);
	        stmt.setInt(1, labId);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            String url = rs.getString("url_writeup");
	            String username = rs.getString("username");
	            String nombreLab = rs.getString("nombre");

	            lista.add(new Writeup(username, url, nombreLab));
	        }

	        rs.close();
	        stmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.cerrarConexion();
	    }

	    return lista;
	}
	
	public static List<Writeup> obtenerWriteupsPorLabIdTimelabs(int labId) {
	    List<Writeup> lista = new ArrayList<>();
	    ConexionDDBB db = new ConexionDDBB();
	    Connection con = null;

	    String sql = "SELECT w.url_writeup, w.username, l.nombre " +
	                 "FROM writeups_timelabs w " +
	                 "JOIN laboratorios_timelabs l ON w.lab_id = l.lab_id " +
	                 "WHERE w.lab_id = ?";

	    try {
	        con = db.conectar();
	        PreparedStatement stmt = con.prepareStatement(sql);
	        stmt.setInt(1, labId);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            String url = rs.getString("url_writeup");
	            String username = rs.getString("username");
	            String nombreLab = rs.getString("nombre");

	            lista.add(new Writeup(username, url, nombreLab));
	        }

	        rs.close();
	        stmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.cerrarConexion();
	    }

	    return lista;
	}
}