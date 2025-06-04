package controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.google.gson.Gson;

import dao.UserViewerDAO;

@WebServlet("/user-viewer")
public class UserViewerController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parámetro 'id' requerido.");
            return;
        }

        int userId;
        try {
            userId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parámetro 'id' inválido.");
            return;
        }

        UserViewerDAO dao = new UserViewerDAO();
        Map<String, Object> stats = dao.getUserDataById(userId);

        if (stats == null || stats.isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Usuario no encontrado.");
            return;
        }

        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(stats));
    }
}
