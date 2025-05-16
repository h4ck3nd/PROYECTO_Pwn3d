package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("first-name");
        String apellido = request.getParameter("last-name");
        String email = request.getParameter("email");
        String usuario = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");

        if (!password.equals(confirmPassword)) {
        	HttpSession session = request.getSession();
            session.setAttribute("loginErrorPass", "Password incorrecta.");
            response.sendRedirect("login-register/register.jsp");
            return;
        }

        String passwordHash = org.apache.commons.codec.digest.DigestUtils.sha256Hex(password);

        User user = new User();
        user.setNombre(nombre);
        user.setApellido(apellido);
        user.setEmail(email);
        user.setUsuario(usuario);
        user.setPassword(passwordHash);

        UserDAO dao = new UserDAO();
        if (dao.registerUser(user)) {
        	HttpSession session = request.getSession();
            session.setAttribute("loginExit", "Registro Exitoso.");
            response.sendRedirect("login-register/register.jsp");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("loginError", "Parametros vacios o mal formados en el registro.");
            response.sendRedirect("login-register/register.jsp");
        }
    }
}
