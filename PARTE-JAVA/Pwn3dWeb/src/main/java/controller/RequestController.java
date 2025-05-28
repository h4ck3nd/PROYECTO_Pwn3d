package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RequestDAO;
import model.Request;
import utils.JWTUtil;

@WebServlet("/request")
public class RequestController extends HttpServlet {
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String tipo = request.getParameter("tipo");
        String mensaje = request.getParameter("mensaje");
        String token = null;
        Integer userId = null;

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token == null || !JWTUtil.validateToken(token)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\":false, \"message\":\"Token inválido\"}");
            return;
        }

        userId = JWTUtil.getUserIdFromToken(token);

        Request req = new Request();
        req.setUserId(userId);
        req.setMessage(mensaje);
        req.setEstado("En progreso");

        RequestDAO dao = new RequestDAO();
        dao.insert(req);
        dao.cerrarConexion();

        response.getWriter().write("{\"success\":true, \"message\":\"Mensaje enviado con éxito\"}");
    }
}
