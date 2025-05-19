package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ValidateFlagRootTimelabsDAO {
	
	private Connection conexion;

    public ValidateFlagRootTimelabsDAO(Connection conexion) {
        this.conexion = conexion;
    }

    public int contarFlagsPorLabId(int labId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM validate_flag_timelabs WHERE lab_id = ?";

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
