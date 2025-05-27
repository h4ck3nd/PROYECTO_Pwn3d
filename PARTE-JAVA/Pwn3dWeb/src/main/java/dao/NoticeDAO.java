package dao;

import conexionDDBB.ConexionDDBB;
import model.Notice;

import org.json.JSONArray;
import org.json.JSONObject;

import java.sql.*;

public class NoticeDAO {
    public JSONArray getActiveNotices() {
        JSONArray notices = new JSONArray();
        ConexionDDBB db = new ConexionDDBB();
        Connection con = db.conectar();

        String sql = "SELECT * FROM notices WHERE estado = 'new' ORDER BY created_notice DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JSONObject notice = new JSONObject();
                notice.put("vm_name", rs.getString("vm_name"));
                notice.put("date", rs.getString("date"));
                notice.put("creator", rs.getString("creator"));
                notice.put("second_vm_name", rs.getString("second_vm_name"));
                notice.put("second_date", rs.getString("second_date"));
                notice.put("second_creator", rs.getString("second_creator"));
                notice.put("description_page", rs.getString("description_page"));
                notices.put(notice);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.cerrarConexion();
        }
        return notices;
    }
    
    public void addNotice(Notice notice) throws SQLException {
        Connection conn = null;
        PreparedStatement updateStmt = null;
        PreparedStatement insertStmt = null;

        try {
            conn = new ConexionDDBB().conectar();
            conn.setAutoCommit(false); // Inicia transacción

            // 1) Cambiar todos los estados "new" a "old"
            String updateSql = "UPDATE notices SET estado = 'old' WHERE estado = 'new'";
            updateStmt = conn.prepareStatement(updateSql);
            updateStmt.executeUpdate();

            // 2) Insertar nuevo notice con estado "new"
            String insertSql = "INSERT INTO notices (vm_name, date, creator, second_vm_name, second_date, second_creator, description_page, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            insertStmt = conn.prepareStatement(insertSql);
            insertStmt.setString(1, notice.getVmName());
            insertStmt.setString(2, notice.getDate());
            insertStmt.setString(3, notice.getCreator());
            insertStmt.setString(4, notice.getSecondVmName());
            insertStmt.setString(5, notice.getSecondDate());
            insertStmt.setString(6, notice.getSecondCreator());
            insertStmt.setString(7, notice.getDescriptionPage());
            insertStmt.setString(8, notice.getEstado()); // Debe ser "new"

            insertStmt.executeUpdate();

            conn.commit(); // Confirma transacción

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (updateStmt != null) updateStmt.close();
            if (insertStmt != null) insertStmt.close();
            if (conn != null) conn.close();
        }
    }
}