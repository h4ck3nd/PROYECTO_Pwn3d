package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BadgeDAO;
import dao.UserDAO;
import model.Badge;
import model.User;
import utils.JWTUtil;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("username");
        String password = request.getParameter("password");
        String passwordHash = org.apache.commons.codec.digest.DigestUtils.sha256Hex(password);

        UserDAO userDao = new UserDAO();
        User user = userDao.getUserByCredentials(usuario, passwordHash);

        if (user != null) {

            // Actualizar el último inicio en base de datos
            userDao.updateUltimoInicio(user.getId());

            // Volver a cargar el usuario actualizado (con nuevo último_inicio)
            user = userDao.getUserById(user.getId());

            // 1. Generar token temporal (sin cookie todavía)
            String tempToken = JWTUtil.generateToken(
                user.getId(),
                user.getNombre(),
                user.getApellido(),
                user.getUsuario(),
                user.getEmail(),
                user.getRol(),
                null, // cookie aún no incluida
                user.getFlagsUser(),
                user.getFlagsRoot(),
                user.getUltimoInicio()
            );

            // 2. Guardar el token temporal en base de datos
            userDao.updateUserToken(user.getId(), tempToken);

            // 3. Recargar el usuario para que contenga ya el token en el campo cookie
            User updatedUser = userDao.getUserById(user.getId());

            // 4. Generar el token final incluyendo la cookie (es decir, el mismo valor guardado)
            String finalToken = JWTUtil.generateToken(
                updatedUser.getId(),
                updatedUser.getNombre(),
                updatedUser.getApellido(),
                updatedUser.getUsuario(),
                updatedUser.getEmail(),
                updatedUser.getRol(),
                updatedUser.getCookie(), // ahora sí contiene el token guardado
                updatedUser.getFlagsUser(),
                updatedUser.getFlagsRoot(),
                updatedUser.getUltimoInicio()
            );

            // 5. Guardar el token final en la base de datos para que coincida con el de la cookie
            userDao.updateUserToken(updatedUser.getId(), finalToken);

            // 6. Enviar el token como cookie al navegador
            Cookie cookie = new Cookie("token", finalToken);
            cookie.setHttpOnly(true);
            cookie.setMaxAge(60 * 60 * 24); // 1 día
            cookie.setPath("/"); // importante para ser accesible desde toda la app
            response.addCookie(cookie);

            // Agregar creación del badge (solo si no existe)
            BadgeDAO badgeDAO = new BadgeDAO();
            Badge existingBadges = badgeDAO.getBadgesByUserId(user.getId());
            if (existingBadges == null) {
                badgeDAO.createBadgesForUser(user.getId());
            }

            // 7. Guardar userId en la sesión HTTP
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());

            // 8. Redirigir al inicio tras login exitoso
            response.sendRedirect("stats");

        } else {
            // Si las credenciales no son válidas, verificar si el usuario existe al menos por nombre
            User userExist = userDao.getUserByUsername(usuario);
            HttpSession session = request.getSession();

            if (userExist == null) {
                session.setAttribute("loginErrorUser", "El usuario no existe.");
            } else {
                session.setAttribute("loginError", "Usuario o contraseña incorrectos.");
            }

            response.sendRedirect("login-register/login.jsp");
        }
    }
}
