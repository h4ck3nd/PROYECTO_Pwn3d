package controlador;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conexionDDBB.ConexionDDBB;
import dao.ValidateFlagRootOvalabsDAO;

@WebServlet("/getFlagRootOvalabsCount")
public class ValidateFlagRootOvalabsControlador extends HttpServlet {
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
            ValidateFlagRootOvalabsDAO dao = new ValidateFlagRootOvalabsDAO(conexion);
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