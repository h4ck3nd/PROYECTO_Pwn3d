package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.FeedbackUpdateDAO;

@WebServlet("/updateFeedbackEstado")
public class UpdateFeedbackEstadoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Parámetros recibidos del formulario
        String idStr = request.getParameter("id");
        String nuevoEstado = request.getParameter("estado");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (idStr == null || nuevoEstado == null || idStr.isEmpty() || nuevoEstado.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false, \"message\":\"Parámetros inválidos\"}");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            FeedbackUpdateDAO dao = new FeedbackUpdateDAO();
            boolean actualizado = dao.actualizarEstado(id, nuevoEstado);
            dao.cerrarConexion();

            if (actualizado) {
                response.getWriter().write("{\"success\":true, \"message\":\"Estado actualizado correctamente\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"success\":false, \"message\":\"No se encontró feedback con ese ID\"}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false, \"message\":\"ID inválido\"}");
        }
    }
}
