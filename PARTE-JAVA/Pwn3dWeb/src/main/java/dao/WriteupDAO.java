package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conexionDDBB.ConexionDDBB;
import model.Writeup;

public class WriteupDAO {
    public void insertWriteup(Writeup writeup) throws SQLException {
        String sql = "INSERT INTO writeups (url, vm_name, user_id, creator, content_type, language, opinion, estado) VALUES (?, ?, ?, ?, ?, ?, ?, 'Pendiente')";
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, writeup.getUrl());
            stmt.setString(2, writeup.getVmName());
            stmt.setInt(3, writeup.getUserId());
            stmt.setString(4, writeup.getCreator());
            stmt.setString(5, writeup.getContentType());
            stmt.setString(6, writeup.getLanguage());
            stmt.setString(7, writeup.getOpinion());
            stmt.executeUpdate();
        }
    }

    public List<Writeup> getPendingWriteups() throws SQLException {
        List<Writeup> pending = new ArrayList<>();
        String sql = "SELECT * FROM writeups WHERE estado = 'Pendiente'";

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Writeup w = new Writeup();
                w.setUrl(rs.getString("url"));
                w.setVmName(rs.getString("vm_name"));
                w.setUserId(rs.getInt("user_id"));
                w.setCreator(rs.getString("creator"));
                w.setEstado(rs.getString("estado"));
                w.setContentType(rs.getString("content_type")); // 💥 AÑADIR ESTO
                pending.add(w);
            }
        }
        return pending;
    }

    public List<Writeup> getWriteupsPublicByVmName(String vmName) throws SQLException {
        List<Writeup> lista = new ArrayList<>();
        String sql = "SELECT vm_name, creator, url, content_type FROM writeups_public WHERE vm_name = ?";

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, vmName);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Writeup w = new Writeup();
                w.setVmName(rs.getString("vm_name"));
                w.setCreator(rs.getString("creator"));
                w.setUrl(rs.getString("url"));
                w.setContentType(rs.getString("content_type")); // NUEVO
                lista.add(w);
            }
        }
        return lista;
    }

    public void publishWriteup(Writeup w) throws SQLException {
        try (Connection conn = new ConexionDDBB().conectar()) {
            conn.setAutoCommit(false);

            try {
                String insertSql = "INSERT INTO writeups_public (url, vm_name, user_id, creator, content_type) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setString(1, w.getUrl());
                    insertStmt.setString(2, w.getVmName());
                    insertStmt.setInt(3, w.getUserId());
                    insertStmt.setString(4, w.getCreator());
                    insertStmt.setString(5, w.getContentType() != null ? w.getContentType() : "text");
                    insertStmt.executeUpdate();
                }

                String updateSql = "UPDATE writeups SET estado = 'Publicado' WHERE url = ?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setString(1, w.getUrl());
                    updateStmt.executeUpdate();
                }

                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }
}