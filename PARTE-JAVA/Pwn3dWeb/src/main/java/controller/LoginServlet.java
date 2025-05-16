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
        	String token = JWTUtil.generateToken(
        		    user.getId(),
        		    user.getNombre(),
        		    user.getApellido(),
        		    user.getUsuario(),
        		    user.getEmail(),
        		    user.getRol(),
        		    user.getCookie(),
        		    user.getFlagsUser(),
        		    user.getFlagsRoot(),
        		    user.getUltimoInicio()
        		);
            Cookie cookie = new Cookie("token", token);
            cookie.setHttpOnly(true);
            cookie.setMaxAge(60 * 60 * 24); // 1 día
            response.addCookie(cookie);
            response.sendRedirect("index.jsp");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("loginError", "Usuario o contraseña incorrectos.");
            response.sendRedirect("login-register/login.jsp");
        }
    }
}