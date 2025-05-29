package controller;

import com.google.gson.Gson;
import dao.UserStatsDAO;
import utils.JWTUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/user-stats")
public class UserStatsController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        String token = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token == null || !JWTUtil.validateToken(token)) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Token inválido o no encontrado");
            return;
        }

        Integer userId = JWTUtil.getUserIdFromToken(token);
        if (userId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No se pudo extraer el ID del token");
            return;
        }

        UserStatsDAO dao = new UserStatsDAO();
        Map<String, Object> stats = dao.getUserStatsById(userId);

        if (stats == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Usuario no encontrado");
            return;
        }

        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        response.getWriter().write(gson.toJson(stats));
    }
}
