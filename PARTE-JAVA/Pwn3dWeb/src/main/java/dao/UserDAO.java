package dao;

import conexionDDBB.ConexionDDBB;
import model.User;
import java.sql.*;

public class UserDAO {

    private final Connection con;

    public UserDAO() {
        con = new ConexionDDBB().conectar();
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
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsuario(rs.getString("usuario"));
                user.setEmail(rs.getString("email"));
                user.setNombre(rs.getString("nombre"));
                user.setApellido(rs.getString("apellido"));
                user.setRol(rs.getString("rol"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
