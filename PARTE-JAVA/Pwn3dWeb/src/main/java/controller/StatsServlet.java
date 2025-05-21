package controller;

import dao.StatsDAO;
import conexionDDBB.ConexionDDBB;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/stats")
public class StatsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ConexionDDBB conexionDDBB = new ConexionDDBB();
        Connection con = conexionDDBB.conectar();

        try {
            StatsDAO dao = new StatsDAO(con);
            int totalVMs = dao.getTotalMachines();
            int totalUsers = dao.getTotalUsers();
            int totalWriteups = dao.getTotalWriteups();

            request.setAttribute("totalVMs", totalVMs);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalWriteups", totalWriteups);

            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error al cargar estadísticas.");
        } finally {
            conexionDDBB.cerrarConexion();
        }
    }
}
