package dao;

import java.sql.*;

import conexionDDBB.ConexionDDBB; // Agregar la clase de conexión

public class ProfileUsersDAO {
    private ConexionDDBB conexionDB;

    // Constructor
    public ProfileUsersDAO() {
        this.conexionDB = new ConexionDDBB(); // Instancia la clase de conexión
    }

    public String obtenerRutaFotoPerfil(int userId) throws SQLException {
        String sql = "SELECT photo_path FROM profile WHERE user_id = ?";
        try (Connection conexion = conexionDB.conectar(); // Usa el método conectar para obtener la conexión
             PreparedStatement stmt = conexion.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("photo_path");
            }
        }
        return null; // No tiene foto
    }
}