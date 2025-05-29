package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import conexionDDBB.ConexionDDBB;
import model.Flag;

public class FlagsDAO {
    private final Connection conn;

    public FlagsDAO(Connection conn) {
        this.conn = conn;
    }

    /**
     * Verifica si el usuario ya validó una flag de cierto tipo para una máquina.
     */
    public boolean hasUserValidatedFlag(int userId, String vmName, String tipoFlag) throws SQLException {
        String query = "SELECT 1 FROM flags WHERE id_user = ? AND vm_name = ? AND tipo_flag = ? LIMIT 1";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setString(2, vmName);
            ps.setString(3, tipoFlag);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // basta con saber si hay alguna coincidencia
            }
        }
    }

    /**
     * Verifica si ya existe una flag validada de cierto tipo para una máquina (por cualquier usuario).
     */
    public boolean existsFlagForVmName(String vmName, String tipoFlag) throws SQLException {
        String query = "SELECT 1 FROM flags WHERE vm_name = ? AND tipo_flag = ? LIMIT 1";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, vmName);
            ps.setString(2, tipoFlag);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    /**
     * Inserta una nueva flag validada.
     */
    public void insertFlag(Flag flag) throws SQLException {
        String insertSQL = "INSERT INTO flags (id_user, vm_name, username, tipo_flag, flag, first_flag_user, first_flag_root) " +
                           "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(insertSQL)) {
            ps.setInt(1, flag.getIdUser());
            ps.setString(2, flag.getVmName());
            ps.setString(3, flag.getUser());
            ps.setString(4, flag.getTipoFlag());
            ps.setString(5, flag.getFlag());
            ps.setBoolean(6, flag.isFirstFlagUser());
            ps.setBoolean(7, flag.isFirstFlagRoot());
            ps.executeUpdate();
        }
    }

    public Map<String, String> getFirstUsersForVM(String vmName) throws SQLException {
        Map<String, String> result = new HashMap<>();
        String sql = "SELECT tipo_flag, username FROM flags WHERE vm_name = ? AND (first_flag_user = TRUE OR first_flag_root = TRUE)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, vmName);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String tipo = rs.getString("tipo_flag");
                    String user = rs.getString("user");  // cuidado: usa comillas dobles en SQL si usas PostgreSQL
                    if ("user".equalsIgnoreCase(tipo)) {
                        result.put("firstUser", user);
                    } else if ("root".equalsIgnoreCase(tipo)) {
                        result.put("firstRoot", user);
                    }
                }
            }
        }
        return result;
    }
    
    /**
     * Cuenta las máquinas hackeadas por un usuario (que tenga ambas flags: user y root).
     */
    public int countMachinesHackedByUser(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM (" +
                "SELECT vm_name FROM flags WHERE id_user = ? GROUP BY vm_name HAVING COUNT(DISTINCT tipo_flag) = 2" +
                ") AS hackeadas";

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        }
        return 0;
    }

    /**
     * Verifica si el usuario tiene la primera flag root.
     */
    public boolean hasFirstRootFlag(int userId) throws SQLException {
        String sql = "SELECT 1 FROM flags WHERE id_user = ? AND first_flag_root = TRUE LIMIT 1";
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    /**
     * Verifica si el usuario tiene la primera flag user.
     */
    public boolean hasFirstUserFlag(int userId) throws SQLException {
        String sql = "SELECT 1 FROM flags WHERE id_user = ? AND first_flag_user = TRUE LIMIT 1";
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
}
