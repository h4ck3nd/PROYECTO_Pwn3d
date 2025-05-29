package controller;

import dao.BadgeDAO;
import utils.JWTUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/update-badge")
public class BadgeController extends HttpServlet {
    private BadgeDAO badgeDAO = new BadgeDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener token de cookie
        String token = null;
        if (request.getCookies() != null) {
            for (Cookie c : request.getCookies()) {
                if ("token".equals(c.getName())) {
                    token = c.getValue();
                    break;
                }
            }
        }

        if (token == null || !JWTUtil.validateToken(token)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Token inválido o inexistente");
            return;
        }

        Integer userId = JWTUtil.getUserIdFromToken(token);
        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("No se pudo obtener userId");
            return;
        }

        String badgeName = request.getParameter("badge");
        if (badgeName == null || badgeName.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("No se especificó badge");
            return;
        }

        // Crear badges si no existen para el usuario
        if (badgeDAO.getBadgesByUserId(userId) == null) {
            badgeDAO.createBadgesForUser(userId);
        }

        // Actualizar badge
        boolean updated = badgeDAO.updateBadge(userId, badgeName);
        if (updated) {
            response.getWriter().write("Badge actualizado correctamente");
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al actualizar badge");
        }
    }
}
