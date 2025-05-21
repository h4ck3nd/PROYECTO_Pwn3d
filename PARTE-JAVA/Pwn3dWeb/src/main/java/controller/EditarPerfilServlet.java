package controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;
import utils.JWTUtil;

@WebServlet("/editarPerfil")
public class EditarPerfilServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie[] cookies = req.getCookies();
        String token = null;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("token")) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token == null || !JWTUtil.validateToken(token)) {
            resp.sendRedirect("login-register/login.jsp"); // redirige si el token es inválido
            return;
        }

        Integer userId = JWTUtil.getUserIdFromToken(token);
        if (userId == null) {
            resp.sendRedirect("login-register/login.jsp");
            return;
        }

        String nombre   = req.getParameter("nombre");
        String apellido = req.getParameter("apellido");
        String email    = req.getParameter("email");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(userId);

        if (user == null) {
        	resp.sendRedirect(req.getContextPath() + "/perfil");
            return;
        }

        // Si algún campo viene vacío, mantenemos el valor actual
        if (nombre == null || nombre.trim().isEmpty()) {
            nombre = user.getNombre();
        }
        if (apellido == null || apellido.trim().isEmpty()) {
            apellido = user.getApellido();
        }
        if (email == null || email.trim().isEmpty()) {
            email = user.getEmail();
        }

        // Actualizar perfil SIN tocar la contraseña (pasamos null)
        boolean updated = userDAO.updateUserProfile(userId, nombre, apellido, email, null);

        if (updated) {
            String nuevoToken = JWTUtil.generateToken(
                userId,
                nombre,
                apellido,
                user.getUsuario(),
                email,
                user.getRol(),
                null,
                user.getFlagsUser(),
                user.getFlagsRoot(),
                new Date()
            );

            userDAO.updateUserToken(userId, nuevoToken);

            Cookie newTokenCookie = new Cookie("token", nuevoToken);
            newTokenCookie.setMaxAge(86400); // 1 día
            newTokenCookie.setPath("/");
            resp.addCookie(newTokenCookie);

            req.getSession().setAttribute("successMsg", "Perfil actualizado correctamente.");
        } else {
            req.getSession().setAttribute("updateErrorProfile", "Error al actualizar el perfil.");
        }

        resp.sendRedirect(req.getContextPath() + "/perfil");
    }
}
