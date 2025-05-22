package dao;

import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

import conexionDDBB.ConexionDDBB;
import io.jsonwebtoken.io.IOException;
import model.User;

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

    // En un archivo nuevo o dentro de UserDAO.java (si es estático)
    public enum RegisterResult {
        SUCCESS,
        DUPLICATE_USERNAME,
        IO_ERROR,
        SQL_ERROR
    }

    public RegisterResult registerUser(User user) throws FileNotFoundException {
        String codeSecure = UUID.randomUUID().toString();
        user.setCodeSecure(codeSecure);

        String sql = "INSERT INTO users (nombre, apellido, email, usuario, password, code_secure) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, user.getNombre());
            stmt.setString(2, user.getApellido());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getUsuario());
            stmt.setString(5, user.getPassword());
            stmt.setString(6, user.getCodeSecure());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                String fileName = user.getUsuario() + "_codigo_seguro.txt";
                try (PrintWriter writer = new PrintWriter(fileName)) {
                    writer.println("Tu código seguro para recuperar la contraseña:");
                    writer.println(codeSecure);
                }
                return RegisterResult.SUCCESS;
            }

        } catch (org.postgresql.util.PSQLException e) {
            if ("23505".equals(e.getSQLState())) {
                if ("users_usuario_key".equals(e.getServerErrorMessage().getConstraint())) {
                    return RegisterResult.DUPLICATE_USERNAME;
                }
            }
            e.printStackTrace();
            return RegisterResult.SQL_ERROR;

        } catch (IOException e) {
            e.printStackTrace();
            return RegisterResult.IO_ERROR;

        } catch (SQLException e) {
            e.printStackTrace();
            return RegisterResult.SQL_ERROR;
        }

        return RegisterResult.SQL_ERROR;
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

    public boolean updatePasswordAndCode(int userId, String newPasswordHash, String nuevoCodigoSeguro) {
        String sql = "UPDATE users SET password = ?, code_secure = ? WHERE id = ?";
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, newPasswordHash);
            stmt.setString(2, nuevoCodigoSeguro);
            stmt.setInt(3, userId);
            int rows = stmt.executeUpdate();
            System.out.println("Filas actualizadas: " + rows);
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User getUserByCode(String code) {
        String sql = "SELECT * FROM users WHERE code_secure = ?";
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToUser(rs); // Usa tu método ya definido
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateUserProfile(int userId, String nombre, String apellido, String email, String newPasswordHash) {
        String sql = newPasswordHash == null ?
            "UPDATE users SET nombre = ?, apellido = ?, email = ? WHERE id = ?" :
            "UPDATE users SET nombre = ?, apellido = ?, email = ?, password = ? WHERE id = ?";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, nombre);
            stmt.setString(2, apellido);
            stmt.setString(3, email);
            if (newPasswordHash == null) {
                stmt.setInt(4, userId);
            } else {
                stmt.setString(4, newPasswordHash);
                stmt.setInt(5, userId);
            }

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePassword(int userId, String newHashedPassword) {
        String sql = "UPDATE users SET password = ? WHERE id = ?";
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, newHashedPassword);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private User mapResultSetToUserWithPassword(ResultSet rs) throws SQLException {
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
        user.setPassword(rs.getString("password"));  // Incluye el password
        return user;
    }

    public User getUserByIdWithPassword(int userId) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return mapResultSetToUserWithPassword(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void addPointsToUser(int userId, int points) throws SQLException {
        String sql = "UPDATE users SET puntos = puntos + ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, points);
            ps.setInt(2, userId);
            ps.executeUpdate();
        }
    }

}
