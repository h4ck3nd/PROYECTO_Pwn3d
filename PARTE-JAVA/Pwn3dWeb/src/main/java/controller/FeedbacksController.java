package controller;

import dao.FeedbackDAO;
import model.FeedbackResponse;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/feedbacks")
public class FeedbacksController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        FeedbackDAO dao = new FeedbackDAO();
        List<FeedbackResponse> feedbackList = null;

        try {
            feedbackList = dao.listarFeedbacksConUsuarioYAvatar();
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false, \"message\":\"Error al obtener feedbacks\"}");
            return;
        } finally {
            dao.cerrarConexion();
        }

        // Serializar a JSON con Gson
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(feedbackList);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse);
    }
}
