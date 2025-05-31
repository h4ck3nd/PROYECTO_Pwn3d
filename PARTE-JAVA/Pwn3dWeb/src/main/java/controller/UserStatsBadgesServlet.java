package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import conexionDDBB.ConexionDDBB;
import utils.JWTUtil; // IMPORTANTE: importa tu clase JWT

@WebServlet("/user-stats-badges")
public class UserStatsBadgesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("token".equals(c.getName())) {
                    token = c.getValue();
                    break;
                }
            }
        }

        if (token == null || !JWTUtil.validateToken(token)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\":\"Token no válido o ausente\"}");
            return;
        }

        Integer userId = JWTUtil.getUserIdFromToken(token);
        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\":\"No se pudo extraer userId del token\"}");
            return;
        }

        Map<String, Boolean> badges = getUserBadges(userId);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        String json = gson.toJson(badges);

        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }

    private Map<String, Boolean> getUserBadges(int userId) {
        Map<String, Boolean> badges = new HashMap<>();

        String[] badgeKeys = {
            "noob", "top1mes", "top1año", "creador", "vms50", "vms100", "vms200", "vms300",
            "juniorvm", "escritor", "writeups100", "solucionador", "firstroot", "firstuser",
            "puntos100", "puntos1000", "puntos2000", "puntos3000", "estrellita", "prohacker", "hacker"
        };

        for (String b : badgeKeys) {
            badges.put(b, false); // por defecto todos en false
        }

        String sql = "SELECT * FROM badges WHERE userId = ?";

        try (
            Connection conn = new ConexionDDBB().conectar();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    for (String b : badgeKeys) {
                        try {
                            badges.put(b, rs.getBoolean(b));
                        } catch (SQLException e) {
                            System.err.println("Columna no encontrada: " + b);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return badges;
    }

}
