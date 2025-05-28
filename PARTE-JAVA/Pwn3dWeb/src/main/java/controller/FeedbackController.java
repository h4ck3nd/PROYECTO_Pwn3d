package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.FeedbackDAO;
import model.Feedback;
import utils.JWTUtil;

@WebServlet("/feedback")
public class FeedbackController extends HttpServlet {
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

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

        Feedback feedback = new Feedback();
        feedback.setUserId(userId);
        feedback.setMessage(mensaje);
        feedback.setEstado("Por contestar...");

        FeedbackDAO dao = new FeedbackDAO();
        dao.insert(feedback);
        dao.cerrarConexion();

        response.getWriter().write("{\"success\":true, \"message\":\"Feedback enviado con éxito\"}");
    }
}
