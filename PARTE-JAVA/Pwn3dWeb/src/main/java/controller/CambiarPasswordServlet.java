package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;
import utils.JWTUtil;
import utils.PasswordUtil;

@WebServlet("/cambiarPassword")
public class CambiarPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = null;

        // Extraer el token de la cookie llamada "token"
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token == null || !JWTUtil.validateToken(token)) {
            req.getSession().setAttribute("errorPassword", "Sesión no válida o expirada. Por favor, inicia sesión nuevamente.");
            resp.sendRedirect("login-register/login.jsp");
            return;
        }

        Integer userId = JWTUtil.getUserIdFromToken(token);
        if (userId == null) {
            req.getSession().setAttribute("errorPassword", "Token inválido. No se pudo obtener usuario.");
            resp.sendRedirect("login-register/login.jsp");
            return;
        }

        String passActual = req.getParameter("passActual");
        String passNueva = req.getParameter("passNueva");
        String passConfirm = req.getParameter("passConfirm");

        if (passActual == null || passNueva == null || passConfirm == null
                || passActual.isEmpty() || passNueva.isEmpty() || passConfirm.isEmpty()) {
            req.getSession().setAttribute("errorPassword", "Todos los campos son obligatorios.");
            resp.sendRedirect(req.getContextPath() + "/perfil");
            return;
        }

        if (!passNueva.equals(passConfirm)) {
            req.getSession().setAttribute("errorPassword", "La nueva contraseña y su confirmación no coinciden.");
            resp.sendRedirect(req.getContextPath() + "/perfil");
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByIdWithPassword(userId);

        if (user == null) {
            req.getSession().setAttribute("errorPassword", "Usuario no encontrado.");
            resp.sendRedirect(req.getContextPath() + "/perfil");
            return;
        }

        // Aquí usamos SHA-256 para verificar la contraseña actual
        if (!PasswordUtil.verifyPasswordSHA256(passActual, user.getPassword())) {
            req.getSession().setAttribute("errorPassword", "La contraseña actual es incorrecta.");
            resp.sendRedirect(req.getContextPath() + "/perfil");
            return;
        }

        // Hasheamos la nueva contraseña con SHA-256 antes de guardar
        String hashedNewPass = PasswordUtil.hashPasswordSHA256(passNueva);
        boolean updated = userDAO.updatePassword(userId, hashedNewPass);

        if (updated) {
            req.getSession().setAttribute("successPassword", "Contraseña actualizada correctamente.");
        } else {
            req.getSession().setAttribute("errorPassword", "Error al actualizar la contraseña.");
        }

        resp.sendRedirect(req.getContextPath() + "/perfil");
    }
}
