package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MachineDAO;

@WebServlet("/eliminarMaquina")
public class EliminarMaquinaServlet extends HttpServlet {

    @Override
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
