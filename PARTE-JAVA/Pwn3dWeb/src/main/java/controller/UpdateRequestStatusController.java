package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RequestDAO;
import io.jsonwebtoken.io.IOException;

@WebServlet("/update-request")
public class UpdateRequestStatusController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, java.io.IOException {

        int requestId = Integer.parseInt(request.getParameter("id"));
        String nuevoEstado = request.getParameter("estado");

        RequestDAO dao = new RequestDAO();
        boolean success = dao.updateEstado(requestId, nuevoEstado);
        dao.cerrarConexion();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"success\":" + success + "}");
    }
}