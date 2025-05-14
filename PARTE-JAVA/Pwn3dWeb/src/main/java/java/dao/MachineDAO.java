package dao;

import conexionDDBB.ConexionDDBB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
}
