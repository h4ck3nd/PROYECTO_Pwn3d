package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;

@WebServlet("/deleteAccount")
public class DeleteAccountServlet extends HttpServlet {
    @Override
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
