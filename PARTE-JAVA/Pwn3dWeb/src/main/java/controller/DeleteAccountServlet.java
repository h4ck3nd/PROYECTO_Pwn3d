package controller;

import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteAccount")
public class DeleteAccountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener sesión y userId
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login-register/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        UserDAO userDao = new UserDAO();

        // Eliminar usuario por userId
        boolean eliminado = userDao.deleteUserById(userId);

        if (eliminado) {
            // Limpiar token cookie
            Cookie expiredCookie = new Cookie("token", "");
            expiredCookie.setMaxAge(0);
            expiredCookie.setPath("/");
            expiredCookie.setHttpOnly(true);
            response.addCookie(expiredCookie);

            // Invalidar sesión
            session.invalidate();

            // Redirigir a página de confirmación o login
            HttpSession session1 = request.getSession();
            session1.setAttribute("deleteExit", "Cuenta eliminada con exito.");
            response.sendRedirect("login-register/login.jsp");
        } else {
        	HttpSession session1 = request.getSession();
            session1.setAttribute("deleteError", "Hubo un error al eliminar su cuenta, pruebe mas tarde.");
            response.sendRedirect("login-register/login.jsp");
        }
    }
}
