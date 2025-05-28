package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conexionDDBB.ConexionDDBB;
import model.Feedback;
import model.FeedbackResponse;

public class FeedbackDAO {
    private Connection conexion;

    public FeedbackDAO() {
        conexion = new ConexionDDBB().conectar();
    }

    public void insert(Feedback feedback) {
        String sql = "INSERT INTO feedbacks (user_id, message, estado) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, feedback.getUserId());
            ps.setString(2, feedback.getMessage());
            ps.setString(3, feedback.getEstado());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void cerrarConexion() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Ejemplo pseudocódigo en Java para recuperar feedback + usuario + img
    public List<FeedbackResponse> listarFeedbacksConUsuarioYAvatar() throws SQLException {
        List<FeedbackResponse> list = new ArrayList<>();

        String sql = "SELECT f.id, f.user_id, f.message, f.estado, u.usuario, ip.pathImg " +
                "FROM feedbacks f " +
                "JOIN users u ON f.user_id = u.id " +
                "LEFT JOIN imgProfile ip ON ip.user_id = u.id " +
                "ORDER BY f.id DESC";  // Aquí el ORDER BY DESC

        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                FeedbackResponse fbRes = new FeedbackResponse();
                fbRes.setId(rs.getInt("id"));
                fbRes.setUserId(rs.getInt("user_id"));
                fbRes.setMessage(rs.getString("message"));
                fbRes.setEstado(rs.getString("estado"));
                fbRes.setUsername(rs.getString("usuario"));

                String path = rs.getString("pathImg");
                if (path == null || path.isEmpty()) {
                    path = "imgProfile/default.png";
                }
                fbRes.setAvatarPath("/" + path);

                list.add(fbRes);
            }
        }

        return list;
    }
}
