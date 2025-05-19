package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import conexionDDBB.ConexionDDBB;

public class AmistadDAO {
	private ConexionDDBB conexionDDBB;
    private Connection conn;

    public AmistadDAO() {
    	conexionDDBB = new ConexionDDBB();
        conn = new ConexionDDBB().conectar();
    }

    public void enviarSolicitud(int solicitanteId, int solicitadoId) throws SQLException {
        String sql = "INSERT INTO amistad (solicitante_id, solicitado_id, estado) VALUES (?, ?, 'pendiente')";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, solicitanteId);
        ps.setInt(2, solicitadoId);
        ps.executeUpdate();
    }

    public void aceptarSolicitud(int idAmistad) throws SQLException {
        String sql = "UPDATE amistad SET estado = 'aceptada' WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, idAmistad);
        ps.executeUpdate();
    }

    public void rechazarSolicitud(int idAmistad) throws SQLException {
        String sql = "UPDATE amistad SET estado = 'rechazada' WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, idAmistad);
        ps.executeUpdate();
    }
    
    public String obtenerEstadoAmistad(int usuarioId, int usuarioDestinoId) throws SQLException {
        String estado = "ninguna"; // Estado por defecto
        String sql = "SELECT estado FROM amistad " +
                     "WHERE (solicitante_id = ? AND solicitado_id = ?) " +
                     "   OR (solicitante_id = ? AND solicitado_id = ?) " +
                     "ORDER BY fecha_creacion DESC LIMIT 1"; // <-- añadimos esto

        Connection localConn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            localConn = conexionDDBB.conectar();
            stmt = localConn.prepareStatement(sql);
            stmt.setInt(1, usuarioId);
            stmt.setInt(2, usuarioDestinoId);
            stmt.setInt(3, usuarioDestinoId);
            stmt.setInt(4, usuarioId);

            rs = stmt.executeQuery();
            if (rs.next()) {
                estado = rs.getString("estado");
            }
        } catch (SQLException e) {
            System.err.println("Error obteniendo estado de amistad:");
            e.printStackTrace();
            throw e;
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
            if (localConn != null) conexionDDBB.cerrarConexion();
        }

        return estado;
    }

    
    private Map<String, String> obtenerDatosUsuarioDesdeFlask(int usuarioId) throws Exception {
        String endpoint = "http://localhost:5000/usuarios/" + usuarioId; // Cambia el puerto si es diferente
        java.net.URL url = new java.net.URL(endpoint);
        java.net.HttpURLConnection con = (java.net.HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        int status = con.getResponseCode();

        if (status == 200) {
            // Si la respuesta es exitosa (200 OK), leemos el contenido
            java.io.BufferedReader in = new java.io.BufferedReader(new java.io.InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuilder content = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            in.close();
            con.disconnect();

            // Parseamos la respuesta JSON
            org.json.JSONObject jsonResponse = new org.json.JSONObject(content.toString());

            // Extraemos los datos de usuario
            Map<String, String> datosUsuario = new HashMap<>();

            datosUsuario.put("id", String.valueOf(jsonResponse.optInt("id")));
            datosUsuario.put("nombre", jsonResponse.optString("nombre", ""));
            datosUsuario.put("apellidos", jsonResponse.optString("apellidos", ""));
            datosUsuario.put("usuario", jsonResponse.optString("usuario", ""));
            datosUsuario.put("email", jsonResponse.optString("email", ""));
            datosUsuario.put("rol", jsonResponse.optString("rol", ""));

            return datosUsuario;
        } else if (status == 404) {
            return null; // Usuario no encontrado
        } else {
            throw new RuntimeException("Error al consultar usuario en Flask: HTTP " + status);
        }
    }
    
    public List<Map<String, String>> obtenerSolicitudesRecibidas(int usuarioId) throws Exception {
        String sql = "SELECT id, solicitante_id FROM amistad WHERE solicitado_id = ? AND estado = 'pendiente'";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, usuarioId);
        ResultSet rs = ps.executeQuery();
        
        List<Map<String, String>> solicitudes = new ArrayList<>();
        
        while (rs.next()) {
            int idAmistad = rs.getInt("id");
            int solicitanteId = rs.getInt("solicitante_id");

            Map<String, String> datosUsuario = obtenerDatosUsuarioDesdeFlask(solicitanteId);

            if (datosUsuario != null && !datosUsuario.isEmpty()) {
                Map<String, String> solicitud = new HashMap<>();
                solicitud.put("idAmistad", String.valueOf(idAmistad));
                solicitud.put("nombre", datosUsuario.getOrDefault("nombre", ""));
                solicitud.put("apellidos", datosUsuario.getOrDefault("apellidos", ""));
                solicitud.put("usuario", datosUsuario.getOrDefault("usuario", ""));
                solicitud.put("email", datosUsuario.getOrDefault("email", ""));
                solicitud.put("rol", datosUsuario.getOrDefault("rol", ""));
                
                // Instanciar el DAO
                ProfileUsersDAO profileDAO = new ProfileUsersDAO();
                String photoPath;
                try {
                    photoPath = profileDAO.obtenerRutaFotoPerfil(solicitanteId);
                } catch (SQLException e) {
                    e.printStackTrace();
                    photoPath = "img/Profile.png"; // Imagen por defecto si falla
                }

                if (photoPath == null || photoPath.isEmpty()) {
                    photoPath = "img/Profile.png"; // Imagen por defecto si está vacío
                }
                solicitud.put("photo_path", photoPath);
                
                solicitudes.add(solicitud);
            }
        }
        
        return solicitudes;
    }

}
