package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conexionDDBB.ConexionDDBB;
import model.InfoNotice;

public class InfoNoticeDAO {

    public List<InfoNotice> obtenerNoticiasPublicas() {
        List<InfoNotice> noticias = new ArrayList<>();
        String query = "SELECT * FROM info_notices_machines WHERE estado = 'publico' ORDER BY time_created DESC";

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                InfoNotice notice = new InfoNotice();
                notice.setId(rs.getInt("id"));
                notice.setDescription(rs.getString("description"));
                notice.setVmName(rs.getString("vm_name"));
                notice.setDate(rs.getString("date"));
                notice.setTimeCreated(rs.getTimestamp("time_created"));
                notice.setEstado(rs.getString("estado"));
                notice.setOs(rs.getString("os"));
                notice.setDifficulty(rs.getString("difficulty"));
                notice.setEnvironment(rs.getString("environment"));
                notice.setSecondEnvironment(rs.getString("second_environment"));
                notice.setPathInfoNotice(rs.getString("path_info_notice"));
                notice.setCreator(rs.getString("creator"));
                noticias.add(notice);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return noticias;
    }
}