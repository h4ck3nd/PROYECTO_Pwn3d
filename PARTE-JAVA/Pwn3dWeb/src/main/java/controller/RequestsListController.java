package controller;

import dao.RequestDAO;
import model.Request;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

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
        List<Request> requestList = dao.getAllWithLoves(userId);
        dao.cerrarConexion();

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
            jsonArray.put(json);
        }

        PrintWriter out = response.getWriter();
        out.print(jsonArray.toString());
        out.flush();
    }
}

