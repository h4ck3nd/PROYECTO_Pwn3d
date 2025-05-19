package controlador;

import dao.AmistadDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.JSONObject;
import java.sql.SQLException;

@WebServlet("/amistadEstado")
public class AmistadEstadoControlador extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdParam = request.getParameter("userId");
        String userIdDestinoParam = request.getParameter("userIdDestino");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        JSONObject jsonResponse = new JSONObject();

        try {
            int userId = Integer.parseInt(userIdParam);
            int userIdDestino = Integer.parseInt(userIdDestinoParam);

            AmistadDAO amistadDAO = new AmistadDAO();
            String estadoAmistad = amistadDAO.obtenerEstadoAmistad(userId, userIdDestino);

            jsonResponse.put("estado", estadoAmistad);

        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            jsonResponse.put("estado", "error");
        }

        out.print(jsonResponse.toString());
        out.flush();
    }
}
