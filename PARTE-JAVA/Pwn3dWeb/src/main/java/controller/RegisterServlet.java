package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import dao.UserDAO.RegisterResult;
import model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
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
        RegisterResult result = dao.registerUser(user);
        HttpSession session = request.getSession();

        switch (result) {
            case SUCCESS:
                session.setAttribute("loginExit", "Registro Exitoso y Código descargado con Éxito.");
                session.setAttribute("codigoSeguro", user.getCodeSecure());
                response.sendRedirect("login-register/register.jsp");
                break;

            case DUPLICATE_USERNAME:
                session.setAttribute("loginError", "Este nombre de usuario ya está en uso.");
                response.sendRedirect("login-register/register.jsp");
                break;

            case IO_ERROR:
                session.setAttribute("loginError", "No se pudo generar el archivo del código seguro.");
                response.sendRedirect("login-register/register.jsp");
                break;

            case SQL_ERROR:
            default:
                session.setAttribute("loginError", "Error inesperado al registrar el usuario.");
                response.sendRedirect("login-register/register.jsp");
                break;
        }
    }
}
