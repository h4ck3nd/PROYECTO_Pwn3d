package dao;

import conexionDDBB.ConexionDDBB;
import model.Badge;

import java.sql.*;

public class BadgeDAO {

    private ConexionDDBB conexion = new ConexionDDBB();

 // Obtener badges por userId
    public Badge getBadgesByUserId(int userId) {
        Badge badge = null;
        String sql = "SELECT * FROM badges WHERE userId = ?";
        try (Connection conn = conexion.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    badge = new Badge();
                    badge.setId(rs.getInt("id"));
                    badge.setUserId(rs.getInt("userId"));
                    badge.setTop1mes(rs.getBoolean("top1mes"));
                    badge.setCreador(rs.getBoolean("creador"));
                    badge.setVms100(rs.getBoolean("vms100"));
                    badge.setVms200(rs.getBoolean("vms200"));
                    badge.setVms300(rs.getBoolean("vms300"));
                    badge.setVms50(rs.getBoolean("vms50"));
                    badge.setJuniorvm(rs.getBoolean("juniorvm"));
                    badge.setHacker(rs.getBoolean("hacker"));
                    badge.setProHacker(rs.getBoolean("proHacker"));
                    badge.setEscritor(rs.getBoolean("escritor"));
                    badge.setWriteups100(rs.getBoolean("writeups100"));
                    badge.setFirstroot(rs.getBoolean("firstroot"));
                    badge.setFirstuser(rs.getBoolean("firstuser"));
                    badge.setSolucionador(rs.getBoolean("solucionador"));
                    badge.setNoob(rs.getBoolean("noob"));
                    badge.setTop1año(rs.getBoolean("top1año"));
                    badge.setPuntos1000(rs.getBoolean("puntos1000"));
                    badge.setPuntos100(rs.getBoolean("puntos100"));
                    badge.setPuntos2000(rs.getBoolean("puntos2000"));
                    badge.setPuntos3000(rs.getBoolean("puntos3000"));
                    badge.setEstrellita(rs.getBoolean("estrellita"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return badge;
    }

    // Crear badges para nuevo usuario (todos false)
    public boolean createBadgesForUser(int userId) {
        String sql = "INSERT INTO badges(userId) VALUES (?) ON CONFLICT (userId) DO NOTHING";
        try (Connection conn = conexion.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            int rows = ps.executeUpdate();
            conexion.cerrarConexion();
            // rows será 0 si ya existía, > 0 si se insertó
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Actualizar un badge específico a true
    public boolean updateBadge(int userId, String badgeColumn) {
        if (!isValidBadgeColumn(badgeColumn)) {
            throw new IllegalArgumentException("Badge inválido: " + badgeColumn);
        }

        String sql = "UPDATE badges SET \"" + badgeColumn + "\" = TRUE WHERE userId = ?";
        try (Connection conn = conexion.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            int rows = ps.executeUpdate();
            conexion.cerrarConexion();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean isValidBadgeColumn(String column) {
        // Validar el badgeColumn para evitar SQL Injection
        String[] validColumns = {
            "top1mes", "creador", "vms100", "vms200", "vms300", "vms50", "juniorvm",
            "hacker", "prohacker", "escritor", "writeups100", "firstroot", "firstuser",
            "solucionador", "noob", "top1año", "puntos1000", "puntos100", "puntos2000",
            "puntos3000", "estrellita"
        };
        for (String col : validColumns) {
            if (col.equals(column)) return true;
        }
        return false;
    }
}
