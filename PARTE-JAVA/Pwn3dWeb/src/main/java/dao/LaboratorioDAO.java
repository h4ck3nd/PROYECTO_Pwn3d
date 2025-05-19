package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import conexionDDBB.ConexionDDBB;

public class LaboratorioDAO {
	
	// Método para asegurarse de que la tabla 'laboratorios' exista, si no la crea
    public static void ensureTableExists() throws SQLException {
        String checkTableQuery = "SELECT COUNT(*) FROM information_schema.tables WHERE table_name = 'laboratorios'";

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(checkTableQuery)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) == 0) {
                // Si la tabla no existe, crearla
                String createTableQuery = "CREATE TABLE laboratorios ("
                        + "lab_id SERIAL PRIMARY KEY, "
                        + "nombre VARCHAR(255) NOT NULL, "
                        + "flag VARCHAR(255) NOT NULL, "
                        + "puntos INT NOT NULL)";
                
                try (Statement stmt = conn.createStatement()) {
                    stmt.executeUpdate(createTableQuery);
                    System.out.println("Tabla 'laboratorios' creada exitosamente.");
                }
            }
        }
    }
	
	// Método para obtener el ID del laboratorio con nombre "foro-xss" (fijo)
    public static int obtenerIdLaboratorioForoXss() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios WHERE nombre = 'foro-xss'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para obtener el ID del laboratorio con nombre "Amashop" (fijo)
    public static int obtenerIdLaboratorioAmashop() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios WHERE nombre = 'amashop'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para obtener el ID del laboratorio con nombre "Hacking_community" (fijo)
    public static int obtenerIdLaboratorioHacking_community() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios WHERE nombre = 'hacking_community'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para obtener el ID del laboratorio con nombre "Separo" (fijo)
    public static int obtenerIdLaboratorioSeparo() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios WHERE nombre = 'separo'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para obtener el ID del laboratorio con nombre "CineHub" (fijo)
    public static int obtenerIdLaboratorioCineHub() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios WHERE nombre = 'cinehub'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para obtener el ID del laboratorio con nombre "RetroGame" (fijo)
    public static int obtenerIdLaboratorioRetroGame() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios WHERE nombre = 'retrogame'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para obtener el ID del laboratorio con nombre "WhatsappFake" (fijo)
    public static int obtenerIdLaboratorioWhatsappFake() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios WHERE nombre = 'whatsappfake'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para obtener el ID del laboratorio con nombre "RouterOS" (fijo)
    public static int obtenerIdLaboratorioRouterOS() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios WHERE nombre = 'routeros'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para obtener el ID del laboratorio con nombre "HackGame" (fijo)
    public static int obtenerIdLaboratorioHackGame() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios WHERE nombre = 'hackgame'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para obtener el ID del laboratorio con nombre "r00tless" (fijo)
    public static int obtenerIdLaboratorioR00tless() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios_dockerpwned WHERE nombre = 'r00tless'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para obtener el ID del laboratorio con nombre "crackoff" (fijo)
    public static int obtenerIdLaboratorioCrackoff() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios_dockerpwned WHERE nombre = 'crackoff'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para obtener el ID del laboratorio con nombre "hackmedaddy" (fijo)
    public static int obtenerIdLaboratorioHackmedaddy() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios_dockerpwned WHERE nombre = 'hackmedaddy'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para obtener el ID del laboratorio con nombre "goodness" (fijo)
    public static int obtenerIdLaboratorioGoodness() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios_ovalabs WHERE nombre = 'goodness'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para obtener el ID del laboratorio con nombre "cinehack" (fijo) [Timelabs]
    public static int obtenerIdLaboratorioCineHack() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios_timelabs WHERE nombre = 'cinehack'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para agregar un nuevo laboratorio a la base de datos
    public static boolean agregarLaboratorio(String nombre, String flag, int puntos) {
        boolean exito = false;
        String query = "INSERT INTO laboratorios (nombre, flag, puntos) VALUES (?, ?, ?)";

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, nombre);
            stmt.setString(2, flag);
            stmt.setInt(3, puntos);

            // Ejecutar la consulta
            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas > 0) {
                exito = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return exito;
    }
	
    // Obtener la flag del laboratorio
    public static String obtenerFlagPorLaboratorio(int labId) {
        String flag = null;
        String query = "SELECT flag FROM laboratorios WHERE lab_id = ?";
        
        // Crea una instancia de ConexionDDBB
        ConexionDDBB conexionDB = new ConexionDDBB();
        
        try (Connection conn = conexionDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, labId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    flag = rs.getString("flag");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return flag;
    }
    
    public static String obtenerNombreLaboratorio(int labId) {
        String nombre = "";
        String query = "SELECT nombre FROM laboratorios WHERE lab_id = ?";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, labId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                nombre = rs.getString("nombre");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return nombre;
    }
    
    // Obtener los puntos del laboratorio
    public static int obtenerPuntosPorLaboratorio(int labId) {
        int puntos = 0;
        String query = "SELECT puntos FROM laboratorios WHERE lab_id = ?";
        
        // Crea una instancia de ConexionDDBB
        ConexionDDBB conexionDB = new ConexionDDBB();
        
        try (Connection conn = conexionDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, labId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    puntos = rs.getInt("puntos");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return puntos;
    }
    
    // Obtener la flag del laboratorio (Dockerpwned)
    public static String obtenerFlagPorLaboratorioDockerpwned(int labId) {
        String flag = null;
        String query = "SELECT flag FROM laboratorios_dockerpwned WHERE lab_id = ?";
        
        // Crea una instancia de ConexionDDBB
        ConexionDDBB conexionDB = new ConexionDDBB();
        
        try (Connection conn = conexionDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, labId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    flag = rs.getString("flag");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return flag;
    }
    
    public static String obtenerNombreLaboratorioDockerpwned(int labId) {
        String nombre = "";
        String query = "SELECT nombre FROM laboratorios_dockerpwned WHERE lab_id = ?";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, labId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                nombre = rs.getString("nombre");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return nombre;
    }
    
    // Obtener los puntos del laboratorio (Dockerpwned)
    public static int obtenerPuntosPorLaboratorioDockerpwned(int labId) {
        int puntos = 0;
        String query = "SELECT puntos FROM laboratorios_dockerpwned WHERE lab_id = ?";
        
        // Crea una instancia de ConexionDDBB
        ConexionDDBB conexionDB = new ConexionDDBB();
        
        try (Connection conn = conexionDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, labId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    puntos = rs.getInt("puntos");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return puntos;
    }
    
    // Obtener la flag del laboratorio (Dockerpwned)
    public static String obtenerFlagPorLaboratorioOvalabs(int labId) {
        String flag = null;
        String query = "SELECT flag FROM laboratorios_ovalabs WHERE lab_id = ?";
        
        // Crea una instancia de ConexionDDBB
        ConexionDDBB conexionDB = new ConexionDDBB();
        
        try (Connection conn = conexionDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, labId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    flag = rs.getString("flag");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return flag;
    }
    
    public static String obtenerNombreLaboratorioOvalabs(int labId) {
        String nombre = "";
        String query = "SELECT nombre FROM laboratorios_ovalabs WHERE lab_id = ?";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, labId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                nombre = rs.getString("nombre");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return nombre;
    }
    
    // Obtener los puntos del laboratorio (ovalabs)
    public static int obtenerPuntosPorLaboratorioOvalabs(int labId) {
        int puntos = 0;
        String query = "SELECT puntos FROM laboratorios_ovalabs WHERE lab_id = ?";
        
        // Crea una instancia de ConexionDDBB
        ConexionDDBB conexionDB = new ConexionDDBB();
        
        try (Connection conn = conexionDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, labId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    puntos = rs.getInt("puntos");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return puntos;
    }
    
 // Obtener la flag del laboratorio (Timelabs)
    public static String obtenerFlagPorLaboratorioTimelabs(int labId) {
        String flag = null;
        String query = "SELECT flag FROM laboratorios_timelabs WHERE lab_id = ?";
        
        // Crea una instancia de ConexionDDBB
        ConexionDDBB conexionDB = new ConexionDDBB();
        
        try (Connection conn = conexionDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, labId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    flag = rs.getString("flag");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return flag;
    }
    
    public static String obtenerNombreLaboratorioTimelabs(int labId) {
        String nombre = "";
        String query = "SELECT nombre FROM laboratorios_timelabs WHERE lab_id = ?";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, labId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                nombre = rs.getString("nombre");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return nombre;
    }
    
    // Obtener los puntos del laboratorio (timelabs)
    public static int obtenerPuntosPorLaboratorioTimelabs(int labId) {
        int puntos = 0;
        String query = "SELECT puntos FROM laboratorios_timelabs WHERE lab_id = ?";
        
        // Crea una instancia de ConexionDDBB
        ConexionDDBB conexionDB = new ConexionDDBB();
        
        try (Connection conn = conexionDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, labId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    puntos = rs.getInt("puntos");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return puntos;
    }
}
