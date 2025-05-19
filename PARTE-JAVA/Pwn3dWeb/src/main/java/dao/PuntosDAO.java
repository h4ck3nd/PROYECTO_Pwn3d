package dao;

import java.sql.*;

import conexionDDBB.ConexionDDBB; // Asegúrate de importar tu clase ConexionDDBB

public class PuntosDAO {
    
    // Método para obtener los puntos de Hacking Web del usuario
    public int obtenerPuntosHackingWeb(int userId) throws SQLException {
        int puntosHackingWeb = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS total_puntos FROM validate_flag WHERE user_id = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    puntosHackingWeb = rs.getInt("total_puntos");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos Hacking Web: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosHackingWeb;
    }
    
 // Método para obtener los puntos de Hacking Web del usuario
    public int obtenerPuntosDockerPwned(int userId) throws SQLException {
        int puntosDockerPwned = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS total_puntos FROM validate_flag_dockerpwned WHERE user_id = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosDockerPwned = rs.getInt("total_puntos");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos Hacking Web: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosDockerPwned;
    }
    
    // Método para obtener los puntos de Hacking Web del usuario
    public int obtenerPuntosOvaLabs(int userId) throws SQLException {
        int puntosOvaLabs = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS total_puntos FROM validate_flag_ovalabs WHERE user_id = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosOvaLabs = rs.getInt("total_puntos");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos Hacking Web: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosOvaLabs;
    }
    
    // Método para obtener los puntos de Hacking Web del usuario
    public int obtenerPuntosTimelabs(int userId) throws SQLException {
        int puntosTimelabs = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS total_puntos FROM validate_flag_timelabs WHERE user_id = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosTimelabs = rs.getInt("total_puntos");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos Timelabs: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosTimelabs;
    }
    
 // NUEVO: Obtener puntos totales del lab_id = 1 (sin importar el usuario)
    public int obtenerPuntosTotalesDeLab1() throws SQLException {
        int totalPuntosLab1 = 0;

        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();

        String sql = "SELECT SUM(puntos) AS total_puntos FROM laboratorios";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalPuntosLab1 = rs.getInt("total_puntos");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos totales del lab_id = 1: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion();
        }

        return totalPuntosLab1;
    }
    
 // NUEVO: Obtener puntos totales del lab_id = 1 (sin importar el usuario)
    public int obtenerPuntosTotalesDeLab2() throws SQLException {
        int totalPuntosLab1 = 0;

        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();

        String sql = "SELECT SUM(puntos) AS total_puntos_dockerpwned FROM laboratorios_dockerpwned";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalPuntosLab1 = rs.getInt("total_puntos_dockerpwned");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos totales del lab_id = 2: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion();
        }

        return totalPuntosLab1;
    }
    
    // NUEVO: Obtener puntos totales del lab_id = 1 (sin importar el usuario)
    public int obtenerPuntosTotalesDeLab3() throws SQLException {
        int totalPuntosLab1 = 0;

        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();

        String sql = "SELECT SUM(puntos) AS total_puntos_ovalabs FROM laboratorios_ovalabs";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalPuntosLab1 = rs.getInt("total_puntos_ovalabs");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos totales del lab_id = 3: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion();
        }

        return totalPuntosLab1;
    }
    
    // NUEVO: Obtener puntos totales del lab_id = 4 (sin importar el usuario)
    public int obtenerPuntosTotalesDeLab4() throws SQLException {
        int totalPuntosLab4 = 0;

        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();

        String sql = "SELECT SUM(puntos) AS total_puntos_timelabs FROM laboratorios_timelabs";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	totalPuntosLab4 = rs.getInt("total_puntos_timelabs");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos totales del lab_id = 4: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion();
        }

        return totalPuntosLab4;
    }
    
    // Método para obtener los puntos de Hacking Web del usuario
    public int obtenerPuntosXSS1(int userId) throws SQLException {
        int puntosXSS1 = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS puntosXSS1 FROM validate_flag WHERE user_id = ? AND lab_id = 1";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosXSS1 = rs.getInt("puntosXSS1");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos XSS1: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosXSS1;
    }
    
    // Método para obtener los puntos de SQLi LAB 1 del usuario
    public int obtenerPuntosSQLi1(int userId) throws SQLException {
        int puntosSQLi1 = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS puntosSQLi1 FROM validate_flag WHERE user_id = ? AND lab_id = 2";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosSQLi1 = rs.getInt("puntosSQLi1");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos SQLi1: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosSQLi1;
    }
    
    // Método para obtener los puntos de OR LAB 1 del usuario
    public int obtenerPuntosCSRF1(int userId) throws SQLException {
        int puntosOR1 = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS puntosOR1 FROM validate_flag WHERE user_id = ? AND lab_id = 4";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosOR1 = rs.getInt("puntosOR1");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos OR1: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosOR1;
    }
    
    // Método para obtener los puntos de BAC LAB 1 del usuario
    public int obtenerPuntosBAC1(int userId) throws SQLException {
        int puntosBAC1 = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS puntosBAC1 FROM validate_flag WHERE user_id = ? AND lab_id = 3";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosBAC1 = rs.getInt("puntosBAC1");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos BAC1: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosBAC1;
    }
    
    // Método para obtener los puntos de XPATH LAB 1 del usuario
    public int obtenerPuntosXPATH1(int userId) throws SQLException {
        int puntosXPATH1 = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS puntosXPATH1 FROM validate_flag WHERE user_id = ? AND lab_id = 5";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosXPATH1 = rs.getInt("puntosXPATH1");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos XPATH1: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosXPATH1;
    }
    
    // Método para obtener los puntos de ForceBrute LAB 1 del usuario
    public int obtenerPuntosForceBrute1(int userId) throws SQLException {
        int puntosForceBrute1 = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS puntosForceBrute1 FROM validate_flag WHERE user_id = ? AND lab_id = 6";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosForceBrute1 = rs.getInt("puntosForceBrute1");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos ForceBrute1: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosForceBrute1;
    }
    
    // Método para obtener los puntos de PYZ LAB 7 del usuario
    public int obtenerPuntosPyz1(int userId) throws SQLException {
        int puntosPyz1 = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS puntosPyz1 FROM validate_flag WHERE user_id = ? AND lab_id = 7";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosPyz1 = rs.getInt("puntosPyz1");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos Pyz1: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosPyz1;
    }
    
    // Método para obtener los puntos de Lenguaje LAB 8 del usuario
    public int obtenerPuntosLenguaje1(int userId) throws SQLException {
        int puntosLenguaje1 = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS puntosLenguaje1 FROM validate_flag WHERE user_id = ? AND lab_id = 8";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosLenguaje1 = rs.getInt("puntosLenguaje1");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos Lenguaje1: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosLenguaje1;
    }
    
    // Método para obtener los puntos de CommandInjection LAB 8 del usuario
    public int obtenerPuntosCommandInjection1(int userId) throws SQLException {
        int puntosCommandInjection1 = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS puntosCommandInjection1 FROM validate_flag WHERE user_id = ? AND lab_id = 9";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosCommandInjection1 = rs.getInt("puntosCommandInjection1");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos CommandInjection1: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosCommandInjection1;
    }
    
    // Método para obtener los puntos de R00tless LAB 1 del usuario
    public int obtenerPuntosR00tless(int userId) throws SQLException {
        int puntosR00tless = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS puntosR00tless FROM validate_flag_dockerpwned WHERE user_id = ? AND lab_id = 1";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosR00tless = rs.getInt("puntosR00tless");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos R00tless: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosR00tless;
    }
    
    // Método para obtener los puntos de Crackoff LAB 2 del usuario
    public int obtenerPuntosCrackoff(int userId) throws SQLException {
        int puntosCrackoff = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS puntosCrackoff FROM validate_flag_dockerpwned WHERE user_id = ? AND lab_id = 2";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosCrackoff = rs.getInt("puntosCrackoff");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos Crackoff: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosCrackoff;
    }
    
    // Método para obtener los puntos de Hackmedaddy LAB 3 del usuario
    public int obtenerPuntosHackmedaddy(int userId) throws SQLException {
        int puntosHackmedaddy = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS puntosHackmedaddy FROM validate_flag_dockerpwned WHERE user_id = ? AND lab_id = 3";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosHackmedaddy = rs.getInt("puntosHackmedaddy");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos Hackmedaddy: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosHackmedaddy;
    }
    
    // Método para obtener los puntos de goodness LAB 1 del usuario
    public int obtenerPuntosGoodness(int userId) throws SQLException {
        int puntosGoodness = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS puntosGoodness FROM validate_flag_ovalabs WHERE user_id = ? AND lab_id = 1";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosGoodness = rs.getInt("puntosGoodness");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos goodness: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosGoodness;
    }
    
    // Método para obtener los puntos de goodness LAB 1 del usuario
    public int obtenerPuntosCineHack(int userId) throws SQLException {
        int puntosCineHack = 0;
        
        // Usamos la clase ConexionDDBB para obtener la conexión a la base de datos
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();
        
        String sql = "SELECT SUM(puntos) AS puntosCineHack FROM validate_flag_timelabs WHERE user_id = ? AND lab_id = 1";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	puntosCineHack = rs.getInt("puntosCineHack");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener puntos CineHack: " + e.getMessage());
            throw e;
        } finally {
            conexionDB.cerrarConexion(); // Cerramos la conexión
        }
        
        return puntosCineHack;
    }
}
