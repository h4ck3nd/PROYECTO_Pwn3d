package controller;

import dao.UserDAO;
import model.User;
import utils.JWTUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usuario = request.getParameter("username");
        String password = request.getParameter("password");
        String passwordHash = org.apache.commons.codec.digest.DigestUtils.sha256Hex(password);

        UserDAO userDao = new UserDAO();
        User user = userDao.getUserByCredentials(usuario, passwordHash);
        
        if (user != null) {
        	
        	// Actualizar el último inicio
            userDao.updateUltimoInicio(user.getId());

            // Volver a cargar el usuario para obtener el último_inicio actualizado
            user = userDao.getUserById(user.getId());
        	
            // 1. Generar token temporal sin incluir el campo "cookie"
            String tempToken = JWTUtil.generateToken(
                user.getId(),
                user.getNombre(),
                user.getApellido(),
                user.getUsuario(),
                user.getEmail(),
                user.getRol(),
                null, // aún sin cookie
                user.getFlagsUser(),
                user.getFlagsRoot(),
                user.getUltimoInicio()
            );

            // 2. Guardar token temporal en la base de datos
            userDao.updateUserToken(user.getId(), tempToken);

            // 3. Volver a cargar al usuario actualizado (con cookie desde la BDD)
            User updatedUser = userDao.getUserById(user.getId());

            // 4. Regenerar token ahora incluyendo el campo cookie
            String finalToken = JWTUtil.generateToken(
                updatedUser.getId(),
                updatedUser.getNombre(),
                updatedUser.getApellido(),
                updatedUser.getUsuario(),
                updatedUser.getEmail(),
                updatedUser.getRol(),
                updatedUser.getCookie(), // ya no es null
                updatedUser.getFlagsUser(),
                updatedUser.getFlagsRoot(),
                updatedUser.getUltimoInicio()
            );

            // 5. Guardar el token final como cookie
            Cookie cookie = new Cookie("token", finalToken);
            cookie.setHttpOnly(true);
            cookie.setMaxAge(60 * 60 * 24); // 1 día
            cookie.setPath("/"); // importante para disponibilidad global
            response.addCookie(cookie);
            
            // GUARDAR userId en sesión
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());

            response.sendRedirect("index.jsp");
        } else {
        	// Aquí verificamos si el usuario existe solo por nombre
            User userExist = userDao.getUserByUsername(usuario);

            HttpSession session = request.getSession();
            if (userExist == null) {
                // Usuario no existe
                session.setAttribute("loginErrorUser", "El usuario no existe.");
            } else {
                // Usuario existe pero la contraseña está mal
                session.setAttribute("loginError", "Usuario o contraseña incorrectos.");
            }
            response.sendRedirect("login-register/login.jsp");
        }
    }
}

