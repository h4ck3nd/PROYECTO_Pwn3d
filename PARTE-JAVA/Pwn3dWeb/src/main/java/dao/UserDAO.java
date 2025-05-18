package dao;

import conexionDDBB.ConexionDDBB;
import model.User;

import java.sql.*;

public class UserDAO {

    private final Connection con;

    // Constructor por defecto conecta usando ConexionDDBB
    public UserDAO() {
        this.con = new ConexionDDBB().conectar();
    }

    // Constructor que recibe conexión (para reusar)
    public UserDAO(Connection con) {
        this.con = con;
    }

    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (nombre, apellido, usuario, email, password) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, user.getNombre());
            pst.setString(2, user.getApellido());
            pst.setString(3, user.getUsuario());
            pst.setString(4, user.getEmail());
            pst.setString(5, user.getPassword());
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserByCredentials(String usuario, String passwordHash) {
        String sql = "SELECT * FROM users WHERE usuario = ? AND password = ?";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, usuario);
            pst.setString(2, passwordHash);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void clearUserTokenByUserId(int userId) {
        String sql = "UPDATE users SET cookie = NULL WHERE id = ?";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, userId);
            int filas = pst.executeUpdate();
            System.out.println("Filas afectadas al limpiar token por userId: " + filas);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateUserToken(int userId, String token) {
        System.out.println("Guardando token en DB para usuario " + userId + ": " + token);
        String sql = "UPDATE users SET cookie = ? WHERE id = ?";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, token);
            pst.setInt(2, userId);
            int rows = pst.executeUpdate();
            System.out.println("Filas afectadas al guardar token: " + rows);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String getTokenByUserId(int userId) {
        String sql = "SELECT cookie FROM users WHERE id = ?";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getString("cookie");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateUltimoInicio(int userId) {
        String sql = "UPDATE users SET ultimo_inicio = CURRENT_TIMESTAMP WHERE id = ?";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, userId);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean deleteUserById(int userId) {
        String sql = "DELETE FROM users WHERE id = ?";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, userId);
            int affectedRows = pst.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE usuario = ? LIMIT 1";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, username);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Método privado para mapear un ResultSet a un objeto User
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsuario(rs.getString("usuario"));
        user.setEmail(rs.getString("email"));
        user.setNombre(rs.getString("nombre"));
        user.setApellido(rs.getString("apellido"));
        user.setRol(rs.getString("rol"));
        user.setCookie(rs.getString("cookie"));
        user.setFlagsUser(rs.getInt("flags_user"));
        user.setFlagsRoot(rs.getInt("flags_root"));
        user.setUltimoInicio(rs.getTimestamp("ultimo_inicio"));
        return user;
    }

    // Método para obtener el id de usuario por username (usa este DAO)
    public int getUserIdFromUsername(String username) {
        User user = getUserByUsername(username);
        if (user != null) {
            return user.getId();
        }
        return -1; // Devuelve -1 si no encuentra usuario
    }

    // Incrementa contador flags_user o flags_root según tipoFlag
    public void incrementFlagCount(int userId, String tipoFlag) throws SQLException {
        String column = tipoFlag.equals("user") ? "flags_user" : "flags_root";
        String sql = "UPDATE users SET " + column + " = " + column + " + 1 WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        }
    }
}
