package controller;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import conexionDDBB.ConexionDDBB;
import dao.MessageDAO;

@WebServlet("/getUnreadSenders")
public class GetUnreadSendersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws java.io.IOException {
        int currentUserId;
        try {
            currentUserId = Integer.parseInt(request.getParameter("currentUserId"));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        ConexionDDBB db = new ConexionDDBB();
        List<Map<String, Object>> unreadSenders = new ArrayList<>();

        try (Connection conn = db.conectar()) {
            MessageDAO dao = new MessageDAO(conn);
            // Obtener la lista de usuarios que enviaron mensajes no leídos
            List<Integer> senderIds = dao.obtenerUsuariosConMensajesNoLeidos(currentUserId);

            for (Integer senderId : senderIds) {
                String senderName = dao.obtenerNombreUsuario(senderId);
                Map<String, Object> map = new HashMap<>();
                map.put("senderId", senderId);
                map.put("senderName", senderName);

                // También se podría incluir el número de mensajes no leídos por ese sender, si quieres
                int unreadCount = dao.contarMensajesNoLeidos(senderId, currentUserId);
                map.put("unreadCount", unreadCount);

                unreadSenders.add(map);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(unreadSenders));
        out.flush();
    }
}
