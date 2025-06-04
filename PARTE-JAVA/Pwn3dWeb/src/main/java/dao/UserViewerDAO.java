package dao;

import conexionDDBB.ConexionDDBB;

import java.sql.*;
import java.util.*;

public class UserViewerDAO {

    public Map<String, Object> getUserDataById(int userId) {
        Map<String, Object> data = new HashMap<>();
        ConexionDDBB db = new ConexionDDBB();
        Connection conn = db.conectar();

        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                data.put("nombre", rs.getString("nombre"));
                data.put("apellido", rs.getString("apellido"));
                data.put("usuario", rs.getString("usuario"));
                data.put("pais", rs.getString("pais"));
                data.put("flags_user", rs.getInt("flags_user"));
                data.put("flags_root", rs.getInt("flags_root"));
                data.put("puntos", rs.getInt("puntos"));
                data.put("ultimo_inicio", rs.getTimestamp("ultimo_inicio"));
                data.put("loves", rs.getInt("loves"));
            }

            String username = (String) data.get("usuario");

            // Redes sociales
            String sqlRRSS = "SELECT social_icon, url_social FROM editprofile WHERE user_id = ? AND estado = 'Publico'";
            ps = conn.prepareStatement(sqlRRSS);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            Map<String, String> redes = new HashMap<>();
            while (rs.next()) {
                redes.put(rs.getString("social_icon"), rs.getString("url_social"));
            }

            data.put("redes_privadas", redes.isEmpty());
            if (!redes.isEmpty()) data.put("redes", redes);

            // Badges
            String sqlBadges = "SELECT * FROM badges WHERE userid = ?";
            ps = conn.prepareStatement(sqlBadges);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            Map<String, Boolean> badges = new HashMap<>();
            if (rs.next()) {
                ResultSetMetaData meta = rs.getMetaData();
                for (int i = 1; i <= meta.getColumnCount(); i++) {
                    String col = meta.getColumnName(i);
                    if (!col.equals("id") && !col.equals("userid")) {
                        badges.put(col, rs.getBoolean(col));
                    }
                }
            }
            data.put("badges", badges);

            // Rango
            String[] rangos = { "god", "FuckSystem", "anonymous", "0xcoffee", "aprendiz", "proHacker", "hacker", "noob" };
            String rango = "Sin Rango";
            for (String r : rangos) {
                if (badges.getOrDefault(r, false)) {
                    rango = Character.toUpperCase(r.charAt(0)) + r.substring(1);
                    break;
                }
            }
            data.put("rango", rango);

            // Máquinas creadas
            String sqlMachines = "SELECT name_machine, download_url, size FROM machines WHERE creator = ?";
            ps = conn.prepareStatement(sqlMachines);
            ps.setString(1, username);
            rs = ps.executeQuery();

            List<Map<String, String>> machines = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> m = new HashMap<>();
                m.put("name", rs.getString("name_machine"));
                m.put("url", rs.getString("download_url"));
                m.put("size", rs.getString("size"));
                machines.add(m);
            }
            data.put("machines", machines);

            // Writeups
            ps = conn.prepareStatement("SELECT vm_name, url, language FROM writeups_public WHERE user_id = ?");
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            List<Map<String, String>> writeups = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> w = new HashMap<>();
                w.put("vm", rs.getString("vm_name"));
                w.put("url", rs.getString("url"));
                w.put("lang", rs.getString("language"));
                writeups.add(w);
            }
            data.put("writeups", writeups);

            // Flags logs
            ps = conn.prepareStatement("SELECT vm_name, tipo_flag, first_flag_user, first_flag_root, created_at FROM flags WHERE id_user = ? ORDER BY created_at DESC");
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            List<Map<String, Object>> flags = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> f = new HashMap<>();
                f.put("vm", rs.getString("vm_name"));
                f.put("tipo", rs.getString("tipo_flag"));
                f.put("firstUser", rs.getBoolean("first_flag_user"));
                f.put("firstRoot", rs.getBoolean("first_flag_root"));
                f.put("fecha", rs.getTimestamp("created_at"));
                flags.add(f);
            }
            data.put("flags_logs", flags);

            // Ranking
            ps = conn.prepareStatement("SELECT id FROM users ORDER BY puntos DESC");
            rs = ps.executeQuery();
            int pos = 1;
            while (rs.next()) {
                if (rs.getInt("id") == userId) break;
                pos++;
            }
            data.put("ranking", pos);

            // First flags contadores
            ps = conn.prepareStatement("SELECT COUNT(CASE WHEN first_flag_user = true THEN 1 END) AS firstUserCount, COUNT(CASE WHEN first_flag_root = true THEN 1 END) AS firstRootCount FROM flags WHERE id_user = ?");
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                data.put("firstUserFlags", rs.getInt("firstUserCount"));
                data.put("firstRootFlags", rs.getInt("firstRootCount"));
            }

            // Writeups count
            ps = conn.prepareStatement("SELECT COUNT(*) FROM writeups_public WHERE user_id = ?");
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                data.put("total_writeups", rs.getInt(1));
            }

            // VMs creadas
            ps = conn.prepareStatement("SELECT COUNT(*) FROM machines WHERE creator = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                data.put("vms_creadas", rs.getInt(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.cerrarConexion();
        }

        return data;
    }
}
