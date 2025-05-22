package controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EditProfileDAO;
import io.jsonwebtoken.io.IOException;
import utils.JWTUtil;

@WebServlet("/actualizarPais")
public class ActualizarPaisServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, java.io.IOException {
        String pais = request.getParameter("pais");
        String token = null;

        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if ("token".equals(cookie.getName())) {
                token = cookie.getValue();
                break;
            }
        }

        if (token != null && JWTUtil.validateToken(token)) {
            int userId = JWTUtil.getUserIdFromToken(token);
            EditProfileDAO dao = new EditProfileDAO();
            boolean actualizado = dao.actualizarPais(userId, pais);
            dao.cerrarConexion();
            response.getWriter().write(actualizado ? "ok" : "error");
        } else {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }
}

