package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NewVMDAO;

@WebServlet("/publishVM")
public class PublishVMServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Falta el parámetro id.");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID inválido.");
            return;
        }

        try {
            NewVMDAO dao = new NewVMDAO();
            boolean updated = dao.updateEstadoPublicado(id);
            if (updated) {
                // Redirigir tras éxito para evitar reenvío formulario
                response.sendRedirect(request.getContextPath() + "/agregarVM.jsp");
            } else {
                // Pasar error y reenviar a formulario para que el usuario corrija
                request.setAttribute("error", "No se encontró la VM con ese ID.");
                request.getRequestDispatcher("/agregarVM.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al actualizar estado.");
        }
    }
}
