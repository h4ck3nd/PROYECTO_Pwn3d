package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

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
        if (diff == null) {
			return "Unknown";
		}
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

    public JSONObject getMachineDetails(int id) {
        JSONObject json = new JSONObject();
        ConexionDDBB db = new ConexionDDBB();
        Connection con = db.conectar();

        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM machines WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                json.put("id", rs.getInt("id"));
                json.put("nameMachine", rs.getString("name_machine"));
                // ...otros campos que quieras incluir
                StarsDAO starsDAO = new StarsDAO();
                double average = starsDAO.getAverageRating(rs.getString("name_machine"));
                json.put("averageRating", average);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.cerrarConexion();
        }

        return json;
    }

    public String getUltimoId() {
        String ultimoId = null;
        ConexionDDBB db = new ConexionDDBB();
        Connection con = db.conectar();

        try {
            String sql = "SELECT id FROM machines ORDER BY LENGTH(id)::int DESC, id::int DESC LIMIT 1";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ultimoId = rs.getString("id");
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.cerrarConexion();
        }

        return ultimoId;
    }

    public JSONObject getMachineById(String id) {
        JSONObject json = new JSONObject();
        ConexionDDBB db = new ConexionDDBB();
        Connection con = db.conectar();

        try {
            String sql = "SELECT name_machine, download_url FROM machines WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                json.put("nameMachine", rs.getString("name_machine"));
                json.put("downloadUrl", rs.getString("download_url"));
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.cerrarConexion();
        }

        return json;
    }

    public boolean isUserCreator(String usuario) {
        String sql = "SELECT 1 FROM machines WHERE creator = ? LIMIT 1";
        ConexionDDBB db = new ConexionDDBB();
        try (Connection conn = db.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, usuario);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
