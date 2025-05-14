package controller;

import dao.MachineDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/eliminarMaquina")
public class EliminarMaquinaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        if (id != null && !id.isEmpty()) {
            MachineDAO dao = new MachineDAO();
            boolean eliminado = dao.eliminarMaquina(id);  // ahora pasa String

            if (eliminado) {
                response.sendRedirect("machines.jsp");
            } else {
                response.sendRedirect("machines.jsp?status=error");
            }
        } else {
            response.sendRedirect("machines.jsp?status=invalid");
        }
    }
}
