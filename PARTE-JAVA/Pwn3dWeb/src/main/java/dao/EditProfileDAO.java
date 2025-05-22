package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conexionDDBB.ConexionDDBB;
import model.EditProfile;

public class EditProfileDAO {
    private Connection con;

    public EditProfileDAO() {
        this.con = new ConexionDDBB().conectar();
    }

    public boolean insertLink(EditProfile link) {
        String sql = "INSERT INTO editProfile (user_id, social_icon, title_social, url_social, estado) " +
                     "VALUES (?, ?, ?, ?, ?) RETURNING id";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, link.getUserId());
            ps.setString(2, link.getSocialIcon());
            ps.setString(3, link.getTitleSocial());
            ps.setString(4, link.getUrlSocial());
            ps.setString(5, link.getEstado());

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                link.setId(rs.getInt(1)); // Guarda el ID en el objeto
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteLink(int id, int userId) {
        String sql = "DELETE FROM editProfile WHERE id = ? AND user_id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<EditProfile> getLinksByUserId(int userId) {
        List<EditProfile> list = new ArrayList<>();
        String sql = "SELECT * FROM editProfile WHERE user_id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                EditProfile ep = new EditProfile();
                ep.setId(rs.getInt("id"));
                ep.setUserId(userId);
                ep.setSocialIcon(rs.getString("social_icon"));
                ep.setTitleSocial(rs.getString("title_social"));
                ep.setUrlSocial(rs.getString("url_social"));
                ep.setEstado(rs.getString("estado"));
                list.add(ep);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void cerrarConexion() {
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateEstado(int id, int userId, String nuevoEstado) {
        String sql = "UPDATE editProfile SET estado = ? WHERE id = ? AND user_id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, id);
            ps.setInt(3, userId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateAllEstadosByUserId(int userId, String nuevoEstado) {
        String sql = "UPDATE editProfile SET estado = ? WHERE user_id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, userId);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public String getPaisByUserId(int userId) {
        String pais = null;
        String query = "SELECT pais FROM users WHERE id = ?";
        try (Connection con = new ConexionDDBB().conectar();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    pais = rs.getString("pais");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pais;
    }
    
    public boolean actualizarPais(int userId, String pais) {
        String query = "UPDATE users SET pais = ? WHERE id = ?";
        try (Connection con = new ConexionDDBB().conectar();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, pais);
            stmt.setInt(2, userId);
            int filas = stmt.executeUpdate();
            return filas > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}