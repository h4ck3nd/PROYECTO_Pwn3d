package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ValidateFlagRootDAO {

    private Connection conexion;

    public ValidateFlagRootDAO(Connection conexion) {
        this.conexion = conexion;
    }

    public int contarFlagsPorLabId(int labId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM validate_flag WHERE lab_id = ?";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, labId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }
}