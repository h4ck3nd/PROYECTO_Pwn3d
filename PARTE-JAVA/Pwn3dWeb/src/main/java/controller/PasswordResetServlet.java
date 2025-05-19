package controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import io.jsonwebtoken.io.IOException;
import model.User;

@WebServlet("/reset-password")
public class PasswordResetServlet extends HttpServlet {
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, java.io.IOException {
        String code = request.getParameter("code");
        String newPassword = request.getParameter("new-password");

        String hash = org.apache.commons.codec.digest.DigestUtils.sha256Hex(newPassword);
        UserDAO dao = new UserDAO();

        // Obtener usuario con código actual
        User user = dao.getUserByCode(code);

        if (user != null) {
            // Generar nuevo código seguro
            String nuevoCodigoSeguro = generateNewCode(); // Implementa esta función

            // Actualizar contraseña y nuevo código en DB
            if (dao.updatePasswordAndCode(user.getId(), hash, nuevoCodigoSeguro)) {
                HttpSession session = request.getSession();
                session.setAttribute("ResetPasswordExit", "Contraseña cambiada con éxito.");

                // Guardar nuevo código para descarga
                session.setAttribute("nuevoCodigoSeguro", nuevoCodigoSeguro);
                session.setAttribute("usuario", user.getUsuario());

                // Redirigir a página que lance descarga del nuevo código
                response.sendRedirect("login-register/login.jsp");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("loginCodeError", "Error al actualizar la contraseña.");
                response.sendRedirect("login-register/login.jsp");
            }
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("loginCodeError", "Código inválido o expirado.");
            response.sendRedirect("login-register/login.jsp");
        }
    }

    private String generateNewCode() {
        return java.util.UUID.randomUUID().toString(); // Ejemplo: 9c62dceb-7abd-42a4-8605-2510fc82564b
    }
}
