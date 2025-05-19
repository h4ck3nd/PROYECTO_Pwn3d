package dao;

import java.sql.*;
import java.util.*;
import modelo.RankingEntry;
import utils.HttpUtils;

public class RankingDAO {

    public List<RankingEntry> getRankingFromAllTables(Connection conn) throws SQLException {
        Map<Integer, Integer> puntosPorUsuario = new HashMap<>();

        String[] tablas = { "validate_flag", "validate_flag_dockerpwned", "validate_flag_ovalabs", "validate_flag_timelabs" };

        for (String tabla : tablas) {
            String query = "SELECT user_id, SUM(puntos) as total FROM " + tabla + " GROUP BY user_id";
            try (PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int userId = rs.getInt("user_id");
                    int puntos = rs.getInt("total");
                    puntosPorUsuario.put(userId, puntosPorUsuario.getOrDefault(userId, 0) + puntos);
                }
            }
        }

        List<RankingEntry> ranking = new ArrayList<>();

        for (Map.Entry<Integer, Integer> entry : puntosPorUsuario.entrySet()) {
            int userId = entry.getKey();
            int totalPuntos = entry.getValue();

            String username = HttpUtils.getUsernameFromFlask(userId); // endpoint flask
            if (username != null) {
                ranking.add(new RankingEntry(username, totalPuntos));
            }
        }

        ranking.sort((a, b) -> Integer.compare(b.getTotalPoints(), a.getTotalPoints())); // Ordenar por puntos

        return ranking;
    }
}