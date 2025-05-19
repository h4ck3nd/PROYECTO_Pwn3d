package controlador;

import dao.ValidateFlagRootDAO;
import conexionDDBB.ConexionDDBB;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/getFlagRootCount")
public class ValidateFlagRootControlador extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String labIdParam = request.getParameter("lab_id");

        if (labIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "lab_id no proporcionado");
            return;
        }

        try {
            int labId = Integer.parseInt(labIdParam);

            ConexionDDBB db = new ConexionDDBB();
            Connection conexion = db.conectar();
            ValidateFlagRootDAO dao = new ValidateFlagRootDAO(conexion);
            int count = dao.contarFlagsPorLabId(labId);
            db.cerrarConexion();

            // Devolver el número de flags como respuesta
            response.setContentType("text/plain");
            response.getWriter().write(String.valueOf(count));

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "lab_id inválido");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}