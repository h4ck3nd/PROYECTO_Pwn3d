package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import dao.BadgeDAO;
import dao.RequestDAO;
import model.Request;

@WebServlet("/requests")  // URL: /requests
public class RequestsListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Obtener userId desde sesión (asegúrate que se guarde al loguear)
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        RequestDAO dao = new RequestDAO();
        BadgeDAO badgeDAO = new BadgeDAO();

        List<Request> requestList = dao.getAllWithLoves(userId);

        JSONArray jsonArray = new JSONArray();

        for (Request req : requestList) {
            JSONObject json = new JSONObject();
            json.put("id", req.getId());
            json.put("user", req.getUserName());
            json.put("message", req.getMessage());
            json.put("estado", req.getEstado());
            json.put("userImgPath", req.getUserImgPath());
            json.put("loves", req.getLoves());
            json.put("lovedByUser", req.isLovedByUser());

            boolean esProHacker = badgeDAO.tieneBadgeProHacker(req.getUserId());
            System.out.println("UserID: " + req.getUserId() + " esProHacker: " + esProHacker);
            json.put("esProHacker", esProHacker);

            jsonArray.put(json);
        }

        dao.cerrarConexion();

        PrintWriter out = response.getWriter();
        out.print(jsonArray.toString());
        out.flush();

    }
}

