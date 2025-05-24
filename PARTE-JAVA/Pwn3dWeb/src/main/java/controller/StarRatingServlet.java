package controller;

import dao.StarsDAO;
import utils.JWTUtil;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/star-rating")
public class StarRatingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String token = null;
        for (Cookie cookie : request.getCookies()) {
            if ("token".equals(cookie.getName())) {
                token = cookie.getValue();
                break;
            }
        }

        Integer userId = (token != null && JWTUtil.validateToken(token)) ? JWTUtil.getUserIdFromToken(token) : null;
        if (userId == null) {
            out.print("{\"success\": false, \"message\": \"Usuario no autenticado.\"}");
            return;
        }

        String vmName = request.getParameter("vm_name");
        int rating = Integer.parseInt(request.getParameter("rating"));

        StarsDAO dao = new StarsDAO();
        if (dao.hasUserVoted(userId, vmName)) {
            dao.cerrarConexion();
            out.print("{\"success\": false, \"message\": \"Ya has votado.\"}");
            return;
        }

        boolean inserted = dao.insertVote(userId, vmName, rating);
        double avg = dao.getAverageRating(vmName);
        dao.cerrarConexion();

        if (inserted) {
            out.print("{\"success\": true, \"average\": " + avg + "}");
        } else {
            out.print("{\"success\": false, \"message\": \"Error al insertar el voto.\"}");
        }
    }
}
