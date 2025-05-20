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
    
    public Map<String, Integer> getHackedMachinesCountByDifficulty(int userId) {
        Map<String, Integer> counts = new HashMap<>();
        ConexionDDBB db = new ConexionDDBB();
        Connection con = db.conectar();

        String sql =
            "SELECT m.difficulty, COUNT(*) AS count " +
            "FROM (" +
            "  SELECT vm_name " +
            "  FROM flags " +
            "  WHERE id_user = ? " +
            "  GROUP BY vm_name " +
            "  HAVING COUNT(DISTINCT tipo_flag) = 2" +
            ") AS completed " +
            "JOIN machines m ON m.name_machine = completed.vm_name " +
            "GROUP BY m.difficulty";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String difficulty = rs.getString("difficulty");
                String normalizedDifficulty = normalizeDifficulty(difficulty);
                counts.put(normalizedDifficulty, rs.getInt("count"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.cerrarConexion();
        }

        return counts;
    }

    public Map<String, Integer> getMachinesCountByDifficulty2() {
        Map<String, Integer> counts = new HashMap<>();
        ConexionDDBB db = new ConexionDDBB();
        Connection con = db.conectar();

        String sql = "SELECT difficulty, COUNT(*) AS count FROM machines GROUP BY difficulty";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String difficulty = rs.getString("difficulty");
                String normalizedDifficulty = normalizeDifficulty(difficulty);
                counts.put(normalizedDifficulty, rs.getInt("count"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.cerrarConexion();
        }

        return counts;
    }

    private String normalizeDifficulty(String diff) {
        if (diff == null) return "Unknown";
        switch (diff.trim().toLowerCase()) {
            case "very-easy":
                return "Very-Easy";
            case "easy":
                return "Easy";
            case "medium":
                return "Medium";
            case "hard":
                return "Hard";
            default:
                return diff;
        }
    }
    
    public boolean actualizarMD5(String nombreMaquina, String nuevoMD5) {
        boolean exito = false;
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection con = conexionDB.conectar();

        try {
            String sql = "UPDATE machines SET md5 = ? WHERE name_machine = ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, nuevoMD5);
            stmt.setString(2, nombreMaquina);

            int filas = stmt.executeUpdate();
            exito = filas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            conexionDB.cerrarConexion();
        }

        return exito;
    }

}
