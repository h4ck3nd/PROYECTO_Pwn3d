package dao;

import conexionDDBB.ConexionDDBB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ValidateFlagDAO {
	
	// Método para verificar si la tabla validate_flag existe, si no la crea
    public static void ensureTableExists() throws SQLException {
        String checkTableQuery = "SELECT COUNT(*) FROM information_schema.tables WHERE table_name = 'validate_flag'";

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(checkTableQuery)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) == 0) {
                // Si no existe, crear la tabla
                String createTableQuery = "CREATE TABLE validate_flag ("
                        + "id SERIAL PRIMARY KEY, "
                        + "user_id INT NOT NULL, "
                        + "lab_id INT NOT NULL, "
                        + "flag VARCHAR(255) NOT NULL, "
                        + "puntos INT NOT NULL)";
                
                try (Statement stmt = conn.createStatement()) {
                    stmt.executeUpdate(createTableQuery);
                    System.out.println("Tabla 'validate_flag' creada exitosamente.");
                }
            }
        }
    }
	
    // Verificar si el usuario ya ha validado la flag para el laboratorio
    public static boolean hasFlagBeenValidated(int userId, int labId) throws SQLException {
        boolean result = false;
        String query = "SELECT COUNT(*) FROM validate_flag WHERE user_id = ? AND lab_id = ?";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, labId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                result = true;
            }
        }
        
        return result;
    }
    
    // Verificar si el usuario ya ha validado la flag para el laboratorio (Dockerpwned)
    public static boolean hasFlagBeenValidatedDockerpwned(int userId, int labId) throws SQLException {
        boolean result = false;
        String query = "SELECT COUNT(*) FROM validate_flag_dockerpwned WHERE user_id = ? AND lab_id = ?";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, labId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                result = true;
            }
        }
        
        return result;
    }
    
    // Verificar si el usuario ya ha validado la flag para el laboratorio (Ovalabs)
    public static boolean hasFlagBeenValidatedOvalabs(int userId, int labId) throws SQLException {
        boolean result = false;
        String query = "SELECT COUNT(*) FROM validate_flag_ovalabs WHERE user_id = ? AND lab_id = ?";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, labId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                result = true;
            }
        }
        
        return result;
    }
    
    // Verificar si el usuario ya ha validado la flag para el laboratorio (timelabs)
    public static boolean hasFlagBeenValidatedTimelabs(int userId, int labId) throws SQLException {
        boolean result = false;
        String query = "SELECT COUNT(*) FROM validate_flag_timelabs WHERE user_id = ? AND lab_id = ?";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, labId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                result = true;
            }
        }
        
        return result;
    }
    
    // Registrar la validación de la flag para el usuario
    public static void registerFlagValidation(int userId, int labId, String flag, int puntos) throws SQLException {
        String query = "INSERT INTO validate_flag (user_id, lab_id, flag, puntos) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, labId);
            ps.setString(3, flag);
            ps.setInt(4, puntos);
            
            ps.executeUpdate();
        }
    }
    
    // Registrar la validación de la flag para el usuario (Dockerpwned)
    public static void registerFlagValidationDockerpwned(int userId, int labId, String flag, int puntos) throws SQLException {
        String query = "INSERT INTO validate_flag_dockerpwned (user_id, lab_id, flag, puntos) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, labId);
            ps.setString(3, flag);
            ps.setInt(4, puntos);
            
            ps.executeUpdate();
        }
    }
    
    // Registrar la validación de la flag para el usuario (Ovalabs)
    public static void registerFlagValidationOvalabs(int userId, int labId, String flag, int puntos) throws SQLException {
        String query = "INSERT INTO validate_flag_ovalabs (user_id, lab_id, flag, puntos) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, labId);
            ps.setString(3, flag);
            ps.setInt(4, puntos);
            
            ps.executeUpdate();
        }
    }
    
    // Registrar la validación de la flag para el usuario (timelabs)
    public static void registerFlagValidationTimelabs(int userId, int labId, String flag, int puntos) throws SQLException {
        String query = "INSERT INTO validate_flag_timelabs (user_id, lab_id, flag, puntos) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, labId);
            ps.setString(3, flag);
            ps.setInt(4, puntos);
            
            ps.executeUpdate();
        }
    }
}
