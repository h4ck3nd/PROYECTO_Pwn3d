package controller;

import dao.LovesUserDAO;
import utils.JWTUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/giveLoveUser")
public class GiveLoveUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("userId")); // al que se le da love

        // Extraer token de cookies
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

        // Obtener el guestId desde el token
        Integer guestId = null;
        if (token != null && !token.trim().isEmpty()) {
            guestId = JWTUtil.getUserIdFromToken(token);
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (guestId == null || guestId.equals(userId)) {
            out.print("{\"success\": false, \"message\": \"Operación inválida.\"}");
            return;
        }

        LovesUserDAO dao = new LovesUserDAO();
        try {
            if (dao.yaDioLove(userId, guestId)) {
                out.print("{\"success\": false, \"message\": \"Ya le diste love.\"}");
            } else {
                dao.darLove(userId, guestId);
                out.print("{\"success\": true}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Error interno.\"}");
        } finally {
            dao.cerrarConexion();
        }
    }
}
