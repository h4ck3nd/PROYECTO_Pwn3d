package dao;

import modelo.FlagLog;
import conexionDDBB.ConexionDDBB;

import java.sql.*;
import java.util.*;
import java.net.*;
import java.io.*;
import org.json.JSONObject;

public class FlagLogDockerpwnedDAO {

    public List<FlagLog> getAllLogs() throws Exception {
        List<FlagLog> logs = new ArrayList<>();
        ConexionDDBB conexionDB = new ConexionDDBB();
        Connection conn = conexionDB.conectar();

        String sql = "SELECT user_id FROM validate_flag_dockerpwned ORDER BY id DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int userId = rs.getInt("user_id");

            // Obtener username desde el endpoint
            String username = getUsernameFromAPI(userId);

            // Obtener foto de perfil directamente desde la tabla
            String photoPath = getPhotoPath(conn, userId);

            logs.add(new FlagLog(username, photoPath));
        }

        rs.close();
        ps.close();
        conexionDB.cerrarConexion();

        return logs;
    }

    private String getUsernameFromAPI(int userId) throws Exception {
        URL url = new URL("http://localhost:5000/get_username/" + userId);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");

        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        StringBuilder response = new StringBuilder();
        String inputLine;

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        JSONObject json = new JSONObject(response.toString());
        return json.getString("username");
    }

    private String getPhotoPath(Connection conn, int userId) throws SQLException {
        String path = "img/Profile.png";
        String sql = "SELECT photo_path FROM profile WHERE user_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            path = rs.getString("photo_path");
        }

        rs.close();
        ps.close();
        return path;
    }
    
    public List<FlagLog> getLogsByLabId(int labId) throws Exception {
        List<FlagLog> logs = new ArrayList<>();
        ConexionDDBB con = new ConexionDDBB();
        Connection conn = con.conectar();

        String sql = "SELECT user_id FROM validate_flag_dockerpwned WHERE lab_id = ? ORDER BY id DESC";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, labId);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            int userId = rs.getInt("user_id");

            // Obtener datos necesarios
            String username = getUsernameFromAPI(userId);
            String photoPath = getPhotoPath(conn, userId);

            logs.add(new FlagLog(username, photoPath));
        }

        rs.close();
        stmt.close();
        con.cerrarConexion();

        return logs;
    }
}