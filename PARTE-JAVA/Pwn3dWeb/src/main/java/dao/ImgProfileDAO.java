package dao;

import conexionDDBB.ConexionDDBB;
import model.ImgProfile;

import java.sql.*;

public class ImgProfileDAO {
    private Connection con;

    public ImgProfileDAO() {
        ConexionDDBB conexion = new ConexionDDBB();
        this.con = conexion.conectar();
        System.out.println("[DEBUG] Conexion abierta en ImgProfileDAO: " + (con != null));
    }

    public ImgProfile getImgProfileByUserId(int userId) {
        System.out.println("[DEBUG] getImgProfileByUserId - userId: " + userId);
        String sql = "SELECT * FROM imgProfile WHERE user_id = ?";
        ResultSet rs = null;
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, userId);
            rs = pst.executeQuery();
            if (rs.next()) {
                ImgProfile img = new ImgProfile();
                img.setId(rs.getInt("id"));
                img.setUserId(rs.getInt("user_id"));
                img.setPathImg(rs.getString("pathImg"));
                System.out.println("[DEBUG] Imagen encontrada en BD: " + img.getPathImg());
                return img;
            } else {
                System.out.println("[DEBUG] No se encontró imagen para userId: " + userId);
            }
        } catch (SQLException e) {
            System.out.println("[ERROR] SQLException en getImgProfileByUserId");
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        return null;
    }

    public boolean insertImgProfile(int userId, String pathImg) {
        System.out.println("[DEBUG] insertImgProfile - userId: " + userId + ", pathImg: " + pathImg);
        String sql = "INSERT INTO imgProfile (user_id, pathImg) VALUES (?, ?)";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, userId);
            pst.setString(2, pathImg);
            int rows = pst.executeUpdate();
            System.out.println("[DEBUG] insertImgProfile - filas afectadas: " + rows);
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("[ERROR] SQLException en insertImgProfile");
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateImgProfile(int userId, String pathImg) {
        System.out.println("[DEBUG] updateImgProfile - userId: " + userId + ", pathImg: " + pathImg);
        String sql = "UPDATE imgProfile SET pathImg = ? WHERE user_id = ?";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, pathImg);
            pst.setInt(2, userId);
            int rows = pst.executeUpdate();
            System.out.println("[DEBUG] updateImgProfile - filas afectadas: " + rows);
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("[ERROR] SQLException en updateImgProfile");
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteImgProfile(int userId) {
        System.out.println("[DEBUG] deleteImgProfile - userId: " + userId);
        String sql = "DELETE FROM imgProfile WHERE user_id = ?";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, userId);
            int rows = pst.executeUpdate();
            System.out.println("[DEBUG] deleteImgProfile - filas afectadas: " + rows);
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("[ERROR] SQLException en deleteImgProfile");
            e.printStackTrace();
            return false;
        }
    }

    public void cerrarConexion() {
        if (con != null) {
            try {
                con.close();
                System.out.println("[DEBUG] Conexión cerrada correctamente.");
            } catch (SQLException e) {
                System.out.println("[ERROR] Error cerrando conexión");
                e.printStackTrace();
            }
        }
    }
}
