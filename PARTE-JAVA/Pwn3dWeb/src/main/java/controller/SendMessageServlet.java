package controller;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conexionDDBB.ConexionDDBB;
import dao.MessageDAO;
import io.jsonwebtoken.io.IOException;
import model.Message;

@WebServlet("/sendMessageAjax")
public class SendMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int senderId = Integer.parseInt(request.getParameter("senderId"));
        int receiverId = Integer.parseInt(request.getParameter("receiverId"));
        String content = request.getParameter("message");

        ConexionDDBB db = new ConexionDDBB();

        try (Connection conn = db.conectar()) {
            MessageDAO dao = new MessageDAO(conn);
            Message msg = new Message();
            msg.setSenderId(senderId);
            msg.setReceiverId(receiverId);
            msg.setContent(content);
            dao.sendMessage(msg);
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
