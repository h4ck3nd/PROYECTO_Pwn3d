package dao;

import conexionDDBB.ConexionDDBB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class FeedbackUpdateDAO {
    private Connection conexion;

    public FeedbackUpdateDAO() {
        conexion = new ConexionDDBB().conectar();
    }

    public boolean actualizarEstado(int id, String nuevoEstado) {
        String sql = "UPDATE feedbacks SET estado = ? WHERE id = ?";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, id);
            int filasActualizadas = ps.executeUpdate();
            return filasActualizadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void cerrarConexion() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
