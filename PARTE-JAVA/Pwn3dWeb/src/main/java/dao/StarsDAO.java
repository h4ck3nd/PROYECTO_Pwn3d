package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conexionDDBB.ConexionDDBB;

public class StarsDAO {
    private Connection conexion;

    public StarsDAO() {
        conexion = new ConexionDDBB().conectar();
    }

    public boolean hasUserVoted(int userId, String vmName) {
        try (PreparedStatement ps = conexion.prepareStatement(
            "SELECT COUNT(*) FROM stars_machines WHERE user_id = ? AND vm_name = ?")) {
            ps.setInt(1, userId);
            ps.setString(2, vmName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertVote(int userId, String vmName, int stars) {
        try (PreparedStatement ps = conexion.prepareStatement(
            "INSERT INTO stars_machines (user_id, vm_name, number_stars, time_created) VALUES (?, ?, ?, NOW())")) {
            ps.setInt(1, userId);
            ps.setString(2, vmName);
            ps.setInt(3, stars);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public double getAverageRating(String vmName) {
        try (PreparedStatement ps = conexion.prepareStatement(
            "SELECT AVG(number_stars) FROM stars_machines WHERE vm_name = ?")) {
            ps.setString(1, vmName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public void cerrarConexion() {
        try {
            if (conexion != null && !conexion.isClosed()) {
				conexion.close();
			}
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}