package dao;

import model.NewVM;
import conexionDDBB.ConexionDDBB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class NewVMDAO {

    public void insertNewVM(NewVM vm) throws Exception {
        String sql = "INSERT INTO new_vm (user_id, name_vm, difficulty, creator, url_vm, user_flag, root_flag, url_writeup, contact, tags, estado) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        ConexionDDBB db = new ConexionDDBB();
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = db.conectar();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, vm.getUserId());
            stmt.setString(2, vm.getNameVm());
            stmt.setString(3, vm.getDifficulty());
            stmt.setString(4, vm.getCreator());
            stmt.setString(5, vm.getUrlVm());
            stmt.setString(6, vm.getUserFlag());
            stmt.setString(7, vm.getRootFlag());
            stmt.setString(8, vm.getUrlWriteup());
            stmt.setString(9, vm.getContact());
            stmt.setString(10, vm.getTags());
            stmt.setString(11, "Pendiente");

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new Exception("Error al insertar la VM: " + e.getMessage(), e);
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) db.cerrarConexion();
        }
    }
    
    public boolean updateEstadoPublicado(int id) throws Exception {
        String sql = "UPDATE new_vm SET estado = 'Publicado' WHERE id = ?";
        ConexionDDBB db = new ConexionDDBB();
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = db.conectar();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            throw new Exception("Error al actualizar estado: " + e.getMessage(), e);
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) db.cerrarConexion();
        }
    }
}
