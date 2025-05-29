package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conexionDDBB.ConexionDDBB;
import model.User;

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
    
 // Método para obtener el usuario top del periodo
    public User getTopUserByPeriod(String periodo) {
        String query = "";
        if ("mes".equalsIgnoreCase(periodo)) {
            query = "SELECT * FROM users WHERE EXTRACT(MONTH FROM created_at) = EXTRACT(MONTH FROM CURRENT_DATE) ORDER BY puntos DESC LIMIT 1";
        } else if ("anio".equalsIgnoreCase(periodo)) {
            query = "SELECT * FROM users WHERE EXTRACT(YEAR FROM created_at) = EXTRACT(YEAR FROM CURRENT_DATE) ORDER BY puntos DESC LIMIT 1";
        } else {
            query = "SELECT * FROM users ORDER BY puntos DESC LIMIT 1";
        }

        try (Connection conexion = new ConexionDDBB().conectar();
             PreparedStatement ps = conexion.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setUsuario(rs.getString("usuario"));
                u.setPuntos(rs.getInt("puntos"));
                u.setPais(rs.getString("pais"));
                return u;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
    
    public void cerrarConexion() {
        try {
            if (conexion != null) {
				conexion.close();
			}
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
