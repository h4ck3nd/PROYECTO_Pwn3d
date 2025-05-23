package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RequestDAO;
import io.jsonwebtoken.io.IOException;

@WebServlet("/give-love")
public class GiveLoveServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, java.io.IOException {

        Integer userId = (Integer) req.getSession().getAttribute("userId");
        if (userId == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int requestId;
        try {
            requestId = Integer.parseInt(req.getParameter("requestId"));
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        RequestDAO dao = new RequestDAO();
        boolean success = dao.addLove(userId, requestId);
        dao.cerrarConexion();

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (success) {
            resp.getWriter().write("{\"success\":true, \"message\":\"¡Love añadido!\"}");
        } else {
            resp.getWriter().write("{\"success\":false, \"message\":\"Ya diste love a este request.\"}");
        }
    }
}