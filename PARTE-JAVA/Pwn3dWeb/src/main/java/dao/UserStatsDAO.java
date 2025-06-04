package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
                
                // 💜 Nuevo: incluir "loves"
                stats.put("loves", rs.getInt("loves"));
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
            
            String nombreUsuario = (String) stats.get("usuario");
            PreparedStatement psVm = conn.prepareStatement("SELECT COUNT(*) FROM machines WHERE creator = ?");
            psVm.setString(1, nombreUsuario);
            ResultSet rsVm = psVm.executeQuery();
            if (rsVm.next()) {
                stats.put("vms_creadas", rsVm.getInt(1));
            }
            
            // Redes sociales públicas
            String socialQuery = "SELECT social_icon, url_social FROM editprofile WHERE user_id = ? AND estado = 'Publico'";
            PreparedStatement psSocial = conn.prepareStatement(socialQuery);
            psSocial.setInt(1, userId);
            ResultSet rsSocial = psSocial.executeQuery();

            Map<String, String> redesSociales = new HashMap<>();
            while (rsSocial.next()) {
                String icon = rsSocial.getString("social_icon");
                String url = rsSocial.getString("url_social");
                if (icon != null && url != null && !icon.trim().isEmpty() && !url.trim().isEmpty()) {
                    redesSociales.put(icon, url);
                }
            }

            // Si no hay redes públicas, indicamos estado privado
            if (redesSociales.isEmpty()) {
                stats.put("redes_privadas", true);
            } else {
                stats.put("redes_privadas", false);
                stats.put("redes", redesSociales);
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
            
         // Determinar rango del usuario basado en el orden de prioridad
            String[] rangos = {
                "god", "FuckSystem", "anonymous", "0xcoffee", "aprendiz", "proHacker", "hacker", "noob"
            };

            String rangoUsuario = "Sin Rango";

            for (String r : rangos) {
                Boolean tiene = badges.get(r);
                if (tiene != null && tiene) {
                    rangoUsuario = r;
                    break;
                }
            }
            
            PreparedStatement psMachines = conn.prepareStatement("SELECT name_machine, download_url, size FROM machines WHERE creator = ?");
            psMachines.setString(1, nombreUsuario);
            ResultSet rsMachines = psMachines.executeQuery();

            List<Map<String, String>> machines = new ArrayList<>();
            while (rsMachines.next()) {
                Map<String, String> machine = new HashMap<>();
                machine.put("name", rsMachines.getString("name_machine"));
                machine.put("url", rsMachines.getString("download_url"));
                machine.put("size", rsMachines.getString("size"));
                machines.add(machine);
            }
            stats.put("machines", machines);
            
            // Obtener logs de flags por usuario
            PreparedStatement psFlags = conn.prepareStatement(""
                    + "SELECT vm_name, tipo_flag, first_flag_user, first_flag_root, created_at "
                    + "FROM flags WHERE id_user = ? ORDER BY created_at DESC");
            psFlags.setInt(1, userId);
            ResultSet rsFlags = psFlags.executeQuery();

            List<Map<String, Object>> flagsLogs = new ArrayList<>();
            while (rsFlags.next()) {
                Map<String, Object> flagLog = new HashMap<>();
                flagLog.put("vm", rsFlags.getString("vm_name"));
                flagLog.put("tipo", rsFlags.getString("tipo_flag"));
                flagLog.put("firstUser", rsFlags.getBoolean("first_flag_user"));
                flagLog.put("firstRoot", rsFlags.getBoolean("first_flag_root"));
                flagLog.put("fecha", rsFlags.getTimestamp("created_at"));
                flagsLogs.add(flagLog);
            }
            stats.put("flags_logs", flagsLogs);
            
            // Calcular posición en ranking por puntos
            PreparedStatement rankStmt = conn.prepareStatement(
                "SELECT id FROM users ORDER BY puntos DESC"
            );
            ResultSet rankRs = rankStmt.executeQuery();

            int posicion = 1;
            while (rankRs.next()) {
                int id = rankRs.getInt("id");
                if (id == userId) {
                    break;
                }
                posicion++;
            }
            stats.put("ranking", posicion);

            PreparedStatement psWriteups = conn.prepareStatement("SELECT vm_name, url, language FROM writeups_public WHERE user_id = ?");
            psWriteups.setInt(1, userId);
            ResultSet rsWriteups = psWriteups.executeQuery();

            List<Map<String, String>> writeups = new ArrayList<>();
            while (rsWriteups.next()) {
                Map<String, String> writeup = new HashMap<>();
                writeup.put("vm", rsWriteups.getString("vm_name"));
                writeup.put("url", rsWriteups.getString("url"));
                writeup.put("lang", rsWriteups.getString("language"));
                writeups.add(writeup);
            }
            stats.put("writeups", writeups);

            // Capitalizar primera letra si es necesario
            rangoUsuario = Character.toUpperCase(rangoUsuario.charAt(0)) + rangoUsuario.substring(1);

            // Poner el rango en stats
            stats.put("rango", rangoUsuario);

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