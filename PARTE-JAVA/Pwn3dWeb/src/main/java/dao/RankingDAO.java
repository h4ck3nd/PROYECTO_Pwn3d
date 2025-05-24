package dao;

import java.sql.*;
import java.util.*;
import conexionDDBB.ConexionDDBB;
import model.User;
import model.ImgProfile;

public class RankingDAO {
    private Connection conexion;

    public RankingDAO() {
        conexion = new ConexionDDBB().conectar();
    }

    public List<User> getRanking(String periodo) {
        List<User> ranking = new ArrayList<>();
        String query = "";

        if ("mes".equals(periodo)) {
            query = "SELECT * FROM users WHERE EXTRACT(MONTH FROM created_at) = EXTRACT(MONTH FROM CURRENT_DATE) ORDER BY puntos DESC";
        } else {
            query = "SELECT * FROM users ORDER BY puntos DESC";
        }

        try (PreparedStatement ps = conexion.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
            	User u = new User();
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setUsuario(rs.getString("usuario"));
                u.setPuntos(rs.getInt("puntos"));
                u.setPais(rs.getString("pais"));
                ranking.add(u);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ranking;
    }

    public void cerrarConexion() {
        try {
            if (conexion != null) conexion.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
