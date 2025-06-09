package dao;

import java.sql.*;
import java.util.*;

import model.Message;

public class MessageDAO {
    private Connection conn;

    public MessageDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Message> getChatMessages(int user1, int user2) throws SQLException {
    	String sql = "SELECT * FROM messages WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?) ORDER BY sent_at ASC";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user1);
            stmt.setInt(2, user2);
            stmt.setInt(3, user2);
            stmt.setInt(4, user1);
            ResultSet rs = stmt.executeQuery();

            List<Message> messages = new ArrayList<>();
            while (rs.next()) {
                Message msg = new Message();
                msg.setId(rs.getInt("id"));
                msg.setSenderId(rs.getInt("sender_id"));
                msg.setReceiverId(rs.getInt("receiver_id"));
                msg.setContent(rs.getString("content"));
                msg.setSentAt(rs.getTimestamp("sent_at"));
                msg.setRead(rs.getBoolean("is_read"));
                messages.add(msg);
            }
            return messages;
        }
    }

    public void sendMessage(Message message) throws SQLException {
        String sql = "INSERT INTO messages (sender_id, receiver_id, content) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, message.getSenderId());
            stmt.setInt(2, message.getReceiverId());
            stmt.setString(3, message.getContent());
            stmt.executeUpdate();
        }
    }
    
    public void marcarMensajesComoLeidos(int senderId, int receiverId) throws SQLException {
        String sql = "UPDATE messages SET is_read = true WHERE sender_id = ? AND receiver_id = ? AND is_read = false";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, senderId);
            stmt.setInt(2, receiverId);
            stmt.executeUpdate();
        }
    }
    
    public String obtenerNombreUsuario(int userId) throws SQLException {
        String sql = "SELECT usuario FROM users WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("usuario");
            }
        }
        return "Desconocido";
    }
    
 // Devuelve lista de userIds que enviaron mensajes no leídos al usuario actual
    public List<Integer> obtenerUsuariosConMensajesNoLeidos(int userId) throws SQLException {
        List<Integer> senderIds = new ArrayList<>();
        String sql = "SELECT DISTINCT sender_id FROM messages WHERE receiver_id = ? AND is_read = FALSE";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                senderIds.add(rs.getInt("sender_id"));
            }
        }
        return senderIds;
    }

    // Cuenta mensajes no leídos de senderId hacia receiverId
    public int contarMensajesNoLeidos(int senderId, int receiverId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM messages WHERE sender_id = ? AND receiver_id = ? AND is_read = FALSE";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, senderId);
            stmt.setInt(2, receiverId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
