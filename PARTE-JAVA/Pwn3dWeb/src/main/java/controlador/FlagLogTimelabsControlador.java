package controlador;

import dao.FlagLogTimelabsDAO;
import modelo.FlagLog;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/FlagLogTimelabsControlador")
public class FlagLogTimelabsControlador extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String labIdParam = request.getParameter("lab_id");

        if (labIdParam == null || labIdParam.isEmpty()) {
            response.getWriter().write("<p style='color:red;'>No se especificó lab_id.</p>");
            return;
        }

        try {
            int labId = Integer.parseInt(labIdParam);

            FlagLogTimelabsDAO dao = new FlagLogTimelabsDAO();
            List<FlagLog> logs = dao.getLogsByLabId(labId); // <-- nuevo método

            StringBuilder html = new StringBuilder();
            String contextPath = request.getContextPath();
            
            html.append("<div class='log-wrapper' style='max-width: 800px; margin: 0 auto; padding: 40px 30px; background-color: #181818; border-radius: 12px; box-shadow: 0 0 15px rgba(0,255,204,0.1); border: 1px solid #2c2c2c;'>");

            html.append("<h2 style='color: #00ffff; font-family: \"Share Tech Mono\", monospace; margin-bottom: 25px; text-align: center; font-size: 28px !important; margin-top: -20px !important;'>Flag Log</h2>");

            // Lista de logs
            html.append("<div class='logs-container' style='display: flex; flex-direction: column; gap: 15px;'>");

            for (FlagLog log : logs) {
                html.append("<div class='log-entry' style='display: flex; align-items: center; background-color: #1e1e1e; border: 1px solid #333; padding: 12px 20px; border-radius: 10px; box-shadow: 0 0 8px rgba(0,255,204,0.05); transition: transform 0.2s;'>")
                    .append("<img src='").append(contextPath).append("/").append(log.getPhotoPath())
                    .append("' alt='Foto de perfil' class='profile-img' style='width: 45px; height: 45px; border-radius: 50%; margin-right: 15px; border: 2px solid #00ffff33; box-shadow: 0 0 6px #00ffff22;'>")
                    .append("<div class='log-text' style='color: #e0e0e0; font-family: \"Share Tech Mono\", monospace; font-size: 1rem;'>")
                    .append("<span style='color: #00ffff;'>").append(log.getUsername()).append("</span>")
                    .append(" <span style='color: #ccc;'>got root</span>")
                    .append("</div>")
                    .append("</div>");
            }

            html.append("</div>"); // cierre logs-container
            html.append("</div>"); // cierre log-wrapper

            response.getWriter().write(html.toString());

        } catch (NumberFormatException e) {
            response.getWriter().write("<p style='color:red;'>lab_id inválido.</p>");
        } catch (Exception e) {
            response.getWriter().write("<p style='color:red;'>Error al cargar logs.</p>");
            e.printStackTrace();
        }
    }
}