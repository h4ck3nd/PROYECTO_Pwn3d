package controlador;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conexionDDBB.ConexionDDBB;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

@WebServlet("/exportarPDF")
public class ExportarPDFControlador extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Connection conn = null;

        try {
            // Datos del usuario (desde GET o JSP)
            int userId = Integer.parseInt(request.getParameter("user_id"));
            String nombre = request.getParameter("usuarioNombre");
            String apellidos = request.getParameter("usuarioApellidos");
            String email = request.getParameter("usuarioEmail");

            // Ruta al informe compilado .jasper
            String jasperPath = getServletContext().getRealPath("/reports/reportFlags.jasper");

            // Parámetros para el informe Jasper
            Map<String, Object> parametros = new HashMap<>();
            parametros.put("USER_ID", userId);
            parametros.put("USUARIO_NOMBRE", nombre);
            parametros.put("USUARIO_APELLIDOS", apellidos);
            parametros.put("USUARIO_EMAIL", email);

            // Conexión a la base de datos usando tu clase ConexionDDBB
            ConexionDDBB conexionDDBB = new ConexionDDBB();
            conn = conexionDDBB.conectar(); // ¡Ya devuelve java.sql.Connection!

            // Generar el informe
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperPath, parametros, conn);

            // Configuración de la respuesta HTTP
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=InformeUsuario.pdf");

            OutputStream out = response.getOutputStream();
            JasperExportManager.exportReportToPdfStream(jasperPrint, out);

            out.flush();
            out.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error generando el informe PDF: " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();  // o usa conexionDDBB.cerrarConexion();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
