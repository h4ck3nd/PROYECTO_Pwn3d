package dao;

import conexionDDBB.ConexionDDBB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FotoDAO {

    // Método que obtiene la ruta de la foto de perfil desde la base de datos
    public String obtenerRutaFotoPerfil(String userId) {
        String photoPath = null;
        Connection conexion = null;
        
        try {
            // Usar la clase ConexionDDBB para obtener la conexión
            ConexionDDBB conexionDDBB = new ConexionDDBB();
            conexion = conexionDDBB.conectar();
            
            String query = "SELECT photo_path FROM profile WHERE user_id = ?";
            PreparedStatement stmt = conexion.prepareStatement(query);
            
            // Cambiar setString a setInt si el tipo de user_id en la base de datos es INTEGER
            stmt.setInt(1, Integer.parseInt(userId));  // Convierte el String a Integer
            
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                photoPath = rs.getString("photo_path");
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conexion != null) {
                try {
                    conexion.close();  // Cerrar la conexión después de terminar
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return photoPath;
    }
}
