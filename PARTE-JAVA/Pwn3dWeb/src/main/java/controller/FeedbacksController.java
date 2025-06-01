package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.BadgeDAO;
import dao.FeedbackDAO;
import model.FeedbackResponse;

@WebServlet("/feedbacks")
public class FeedbacksController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        FeedbackDAO dao = new FeedbackDAO();
        BadgeDAO badgeDAO = new BadgeDAO();
        List<FeedbackResponse> feedbackList = null;

        try {
            feedbackList = dao.listarFeedbacksConUsuarioYAvatar();

         // Para cada feedback, preguntamos si el usuario tiene el badge proHacker
            for (FeedbackResponse feedback : feedbackList) {
                int userId = feedback.getUserId();  // suponiendo que FeedbackResponse tiene getUserId()
                boolean esProHacker = badgeDAO.tieneBadgeProHacker(userId);
                feedback.setEsProHacker(esProHacker); // asegurate que FeedbackResponse tenga este setter
            }

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
