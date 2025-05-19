package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import conexionDDBB.ConexionDDBB;

public class MachineDAO {

    public boolean eliminarMaquina(String id) {
        boolean eliminado = false;
        ConexionDDBB db = new ConexionDDBB();
        Connection conn = db.conectar();

        try {
            String sql = "DELETE FROM machines WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, id);  // 🔄 Cambiado de setInt a setString

            int rows = stmt.executeUpdate();
            eliminado = rows > 0;

            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.cerrarConexion();
        }

        return eliminado;
    }
    
    public Map<String, Integer> getMachinesCountByDifficulty() {
        Map<String, Integer> counts = new HashMap<>();
        ConexionDDBB db = new ConexionDDBB();
        Connection con = db.conectar();

        String sql = "SELECT difficulty, COUNT(*) AS count FROM machines GROUP BY difficulty";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                counts.put(rs.getString("difficulty"), rs.getInt("count"));
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.cerrarConexion();
        }

        return counts;
    }

    public int getTotalMachines() {
        ConexionDDBB db = new ConexionDDBB();
        Connection con = db.conectar();

        String sql = "SELECT COUNT(*) AS total FROM machines";
        int total = 0;

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.cerrarConexion();
        }

        return total;
    }

}
