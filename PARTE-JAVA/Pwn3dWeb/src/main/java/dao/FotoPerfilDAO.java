package dao;

import conexionDDBB.ConexionDDBB;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletContext;

public class FotoPerfilDAO {

    // Actualiza la foto de perfil del usuario
    public static void actualizarFoto(String userId, String filePath) {
        ConexionDDBB conexion = new ConexionDDBB();
        try (Connection conn = conexion.conectar()) {
            // Verificar si el user_id ya tiene entrada en profile
            String checkSql = "SELECT COUNT(*) FROM profile WHERE user_id = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, Integer.parseInt(userId));
                ResultSet rs = checkStmt.executeQuery();
                rs.next();
                int count = rs.getInt(1);

                if (count > 0) {
                    // Si ya existe, hacer UPDATE
                    String updateSql = "UPDATE profile SET photo_path = ? WHERE user_id = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(updateSql)) {
                        stmt.setString(1, filePath);
                        stmt.setInt(2, Integer.parseInt(userId));
                        stmt.executeUpdate();
                        System.out.println("Foto actualizada para user_id = " + userId);
                    }
                } else {
                    // Si no existe, hacer INSERT
                    String insertSql = "INSERT INTO profile (user_id, photo_path) VALUES (?, ?)";
                    try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                        stmt.setInt(1, Integer.parseInt(userId));
                        stmt.setString(2, filePath);
                        stmt.executeUpdate();
                        System.out.println("Foto insertada para user_id = " + userId);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Aquí se podrían manejar excepciones de base de datos
        }
    }

    // Elimina la foto de perfil y asigna la foto por defecto
    public static void eliminarFoto(String userId, ServletContext context) {
        ConexionDDBB conexion = new ConexionDDBB();
        try (Connection conn = conexion.conectar()) {
            // Obtener la foto de la base de datos
            String selectSql = "SELECT photo_path FROM profile WHERE user_id = ?";
            String filePath = null;
            try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
                selectStmt.setInt(1, Integer.parseInt(userId));
                ResultSet rs = selectStmt.executeQuery();
                if (rs.next()) {
                    filePath = rs.getString("photo_path");
                }
            }

            if (filePath != null) {
                // Eliminar la foto de perfil en la base de datos
                String deleteSql = "DELETE FROM profile WHERE user_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(deleteSql)) {
                    stmt.setInt(1, Integer.parseInt(userId));
                    stmt.executeUpdate();
                    System.out.println("Foto eliminada de la base de datos para user_id = " + userId);
                }

                // Eliminar la imagen física del servidor
                File file = new File(context.getRealPath(filePath));  // Utilizar la ruta completa de la imagen
                if (file.exists()) {
                    file.delete();
                    System.out.println("Imagen eliminada físicamente: " + filePath);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Manejar error en base de datos
        }
    }
}
