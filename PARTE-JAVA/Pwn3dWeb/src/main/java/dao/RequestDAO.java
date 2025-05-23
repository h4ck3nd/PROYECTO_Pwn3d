package dao;

import java.sql.*;
import java.util.*;
import conexionDDBB.ConexionDDBB;
import model.Request;

public class RequestDAO {
    private Connection conn;

    public RequestDAO() {
        conn = new ConexionDDBB().conectar();
    }

    public void insert(Request req) {
        String sql = "INSERT INTO requests (user_id, message, estado) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, req.getUserId());
            ps.setString(2, req.getMessage());
            ps.setString(3, req.getEstado());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Request> getAllByUserId(int userId) {
        List<Request> list = new ArrayList<>();
        String sql = "SELECT * FROM requests WHERE user_id = ? ORDER BY time_created DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Request r = new Request();
                r.setId(rs.getInt("id"));
                r.setUserId(rs.getInt("user_id"));
                r.setMessage(rs.getString("message"));
                r.setEstado(rs.getString("estado"));
                r.setTimeCreated(rs.getTimestamp("time_created"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void cerrarConexion() {
        try {
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<Request> getAll() {
        List<Request> list = new ArrayList<>();
        try {
            String sql = "SELECT r.*, u.usuario, ip.pathImg AS userImgPath " +
                         "FROM requests r " +
                         "LEFT JOIN users u ON r.user_id = u.id " +
                         "LEFT JOIN imgProfile ip ON ip.user_id = u.id " +
                         "ORDER BY r.time_created DESC";  // <-- Orden descendente
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Request r = new Request();
                r.setId(rs.getInt("id"));
                r.setMessage(rs.getString("message"));
                r.setEstado(rs.getString("estado"));
                r.setUserName(rs.getString("usuario"));
                r.setUserImgPath(rs.getString("userImgPath"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public boolean updateEstado(int requestId, String nuevoEstado) {
        String sql = "UPDATE requests SET estado = ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, requestId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
 // Modificado getAll para traer también el count loves y si el usuario ha dado love
    public List<Request> getAllWithLoves(int currentUserId) {
        List<Request> list = new ArrayList<>();
        String sql = "SELECT r.*, u.usuario, ip.pathImg AS userImgPath, r.loves, " +
                     "CASE WHEN rl.user_id IS NULL THEN false ELSE true END AS lovedByUser " +
                     "FROM requests r " +
                     "LEFT JOIN users u ON r.user_id = u.id " +
                     "LEFT JOIN imgProfile ip ON ip.user_id = u.id " +
                     "LEFT JOIN request_loves rl ON rl.request_id = r.id AND rl.user_id = ? " +
                     "ORDER BY r.time_created DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, currentUserId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Request r = new Request();
                r.setId(rs.getInt("id"));
                r.setMessage(rs.getString("message"));
                r.setEstado(rs.getString("estado"));
                r.setUserName(rs.getString("usuario"));
                r.setUserImgPath(rs.getString("userImgPath"));
                r.setLoves(rs.getInt("loves"));
                r.setLovedByUser(rs.getBoolean("lovedByUser"));  // Necesitas añadir este campo en tu modelo Request
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Método para añadir un love (si no existe, y actualizar contador)
    public boolean addLove(int userId, int requestId) {
        String insertLoveSQL = "INSERT INTO request_loves (user_id, request_id) VALUES (?, ?)";
        String updateLovesSQL = "UPDATE requests SET loves = loves + 1 WHERE id = ?";
        try {
            conn.setAutoCommit(false);

            try (PreparedStatement psInsert = conn.prepareStatement(insertLoveSQL)) {
                psInsert.setInt(1, userId);
                psInsert.setInt(2, requestId);
                psInsert.executeUpdate();
            }

            try (PreparedStatement psUpdate = conn.prepareStatement(updateLovesSQL)) {
                psUpdate.setInt(1, requestId);
                psUpdate.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            // Si falla porque ya dio love, devuelve false
            return false;
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}