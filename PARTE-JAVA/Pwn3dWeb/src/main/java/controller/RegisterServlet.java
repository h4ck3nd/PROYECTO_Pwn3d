package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
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
        if (dao.registerUser(user)) {
            // Guardamos el código seguro en sesión para que register.jsp lo pueda usar
            HttpSession session = request.getSession();
            session.setAttribute("loginExit", "Registro Exitoso y Codigo descargado con Exito.");
            session.setAttribute("codigoSeguro", user.getCodeSecure()); // <-- código seguro aquí

            // Redirigimos a register.jsp para que haga la descarga y muestre mensaje
            response.sendRedirect("login-register/register.jsp");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("loginError", "Parametros vacios o mal formados en el registro.");
            response.sendRedirect("login-register/register.jsp");
        }
    }
}
