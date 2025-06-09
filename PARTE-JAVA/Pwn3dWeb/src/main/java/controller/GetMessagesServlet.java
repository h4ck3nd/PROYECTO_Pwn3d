package controller;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import conexionDDBB.ConexionDDBB;
import dao.MessageDAO;
import model.Message;

@WebServlet("/getMessages")
public class GetMessagesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws java.io.IOException {
        int currentUserId = Integer.parseInt(request.getParameter("currentUserId"));
        int otherUserId = Integer.parseInt(request.getParameter("otherUserId"));

        ConexionDDBB db = new ConexionDDBB();
        List<Message> messages;
        List<Map<String, Object>> msgsForJson = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

        try (Connection conn = db.conectar()) {
            MessageDAO dao = new MessageDAO(conn);

            // ✅ Marcar como leídos los mensajes del otro usuario hacia el actual
            dao.marcarMensajesComoLeidos(otherUserId, currentUserId);

            messages = dao.getChatMessages(currentUserId, otherUserId);

            for (Message m : messages) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", m.getId());
                map.put("senderId", m.getSenderId());
                map.put("receiverId", m.getReceiverId());
                map.put("content", m.getContent());
                map.put("sentAt", sdf.format(m.getSentAt()));
                map.put("isRead", m.isRead());

                // ✅ Agregar el nombre del remitente
                String senderName = dao.obtenerNombreUsuario(m.getSenderId());
                map.put("senderName", senderName);

                msgsForJson.add(map);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(msgsForJson));
        out.flush();
    }
}