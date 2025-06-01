package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import conexionDDBB.ConexionDDBB;

public class UserStatsDAO {

    public Map<String, Object> getUserStatsById(int userId) {
        Map<String, Object> stats = new HashMap<>();
        ConexionDDBB db = new ConexionDDBB();
        Connection conn = db.conectar();

        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                stats.put("nombre", rs.getString("nombre"));
                stats.put("apellido", rs.getString("apellido"));
                stats.put("usuario", rs.getString("usuario"));
                stats.put("pais", rs.getString("pais"));
                stats.put("flags_user", rs.getInt("flags_user"));
                stats.put("flags_root", rs.getInt("flags_root"));
                stats.put("puntos", rs.getInt("puntos"));
                stats.put("ultimo_inicio", rs.getTimestamp("ultimo_inicio"));
            }

            ps = conn.prepareStatement("SELECT COUNT(*) FROM writeups_public WHERE user_id = ?");
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                stats.put("total_writeups", rs.getInt(1));
            }

            ps = conn.prepareStatement("SELECT COUNT(*) FROM stars_machines WHERE user_id = ?");
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                stats.put("estrellas_dadas", rs.getInt(1));
            }

            ps = conn.prepareStatement("SELECT COUNT(*) FROM feedbacks WHERE user_id = ?");
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                stats.put("feedbacks", rs.getInt(1));
            }

            ps = conn.prepareStatement("SELECT COUNT(*) FROM requests WHERE user_id = ?");
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                stats.put("requests", rs.getInt(1));
            }

            // Dentro de getUserStatsById
            String badgeQuery = "SELECT * FROM badges WHERE userid = ?";
            PreparedStatement badgeStmt = conn.prepareStatement(badgeQuery);
            badgeStmt.setInt(1, userId);
            ResultSet badgeRs = badgeStmt.executeQuery();

            Map<String, Boolean> badges = new HashMap<>();
            if (badgeRs.next()) {
                ResultSetMetaData meta = badgeRs.getMetaData();
                int colCount = meta.getColumnCount();
                for (int i = 1; i <= colCount; i++) {
                    String column = meta.getColumnName(i);
                    if (!column.equals("userid") && !column.equals("id")) {
                        badges.put(column, badgeRs.getBoolean(column));
                    }
                }
            }
            stats.put("badges", badges);

            // Obtener las primeras flags de user y root por usuario
            String firstFlagsQuery = "SELECT " +
                    "COUNT(CASE WHEN first_flag_user = TRUE THEN 1 END) AS firstUserCount, " +
                    "COUNT(CASE WHEN first_flag_root = TRUE THEN 1 END) AS firstRootCount " +
                    "FROM flags WHERE id_user = ?";
			PreparedStatement stmt = conn.prepareStatement(firstFlagsQuery);
			stmt.setInt(1, userId);
			ResultSet rs1 = stmt.executeQuery();
			if (rs1.next()) {
			stats.put("firstUserFlags", rs1.getInt("firstUserCount"));
			stats.put("firstRootFlags", rs1.getInt("firstRootCount"));
			}


        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.cerrarConexion();
        }

        return stats;
    }

    public int getMaquinasResueltas(int userId) {
        int count = 0;
        ConexionDDBB db = new ConexionDDBB();
        Connection conn = db.conectar();
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM stars_machines WHERE user_id = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.cerrarConexion();
        }
        return count;
    }

    public int getWriteupsCount(int userId) {
        int count = 0;
        ConexionDDBB db = new ConexionDDBB();
        Connection conn = db.conectar();
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM writeups_public WHERE user_id = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.cerrarConexion();
        }
        return count;
    }

    public int getPuntos(int userId) {
        int puntos = 0;
        ConexionDDBB db = new ConexionDDBB();
        Connection conn = db.conectar();
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT puntos FROM users WHERE id = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                puntos = rs.getInt("puntos");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.cerrarConexion();
        }
        return puntos;
    }
}