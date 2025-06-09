package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conexionDDBB.ConexionDDBB;

public class LovesUserDAO {
    private Connection connection;

    public LovesUserDAO() {
        ConexionDDBB conexion = new ConexionDDBB();
        this.connection = conexion.conectar();
    }

    public boolean yaDioLove(int userId, int guestId) throws SQLException {
        String sql = "SELECT 1 FROM lovesusers WHERE user_id = ? AND user_id_guest = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, guestId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    public void darLove(int userId, int guestId) throws SQLException {
        String insertSQL = "INSERT INTO lovesusers (user_id, user_id_guest, loves) VALUES (?, ?, 1)";
        String updateSQL = "UPDATE users SET loves = loves + 1 WHERE id = ?";

        PreparedStatement insertStmt = null;
        PreparedStatement updateStmt = null;

        try {
            connection.setAutoCommit(false); // conexión correcta

            insertStmt = connection.prepareStatement(insertSQL);
            insertStmt.setInt(1, userId);
            insertStmt.setInt(2, guestId);
            insertStmt.executeUpdate();

            updateStmt = connection.prepareStatement(updateSQL);
            updateStmt.setInt(1, userId);
            updateStmt.executeUpdate();

            connection.commit(); // conexión correcta

        } catch (SQLException e) {
            if (connection != null) {
                connection.rollback(); // conexión correcta
            }
            throw e;
        } finally {
            if (insertStmt != null) {
				insertStmt.close();
			}
            if (updateStmt != null) {
				updateStmt.close();
			}
            connection.setAutoCommit(true); // conexión correcta
        }
    }

    public void cerrarConexion() {
        try {
            if (connection != null) {
				connection.close();
			}
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
