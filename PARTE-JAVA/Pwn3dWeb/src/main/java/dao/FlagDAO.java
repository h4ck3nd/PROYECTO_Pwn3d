package dao;

import conexionDDBB.ConexionDDBB;
import model.Flag;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FlagDAO {
    private final Connection con;

    public FlagDAO() {
        this.con = new ConexionDDBB().conectar();
    }

    public List<Flag> getAllFlags() {
        List<Flag> flags = new ArrayList<>();
        String sql = "SELECT * FROM flags ORDER BY created_at DESC";

        try (Connection con = new ConexionDDBB().conectar();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Flag flag = new Flag();
                flag.setId(rs.getInt("id"));
                flag.setIdUser(rs.getInt("id_user"));
                flag.setVmName(rs.getString("vm_name"));
                flag.setUser(rs.getString("username")); // ojo que en tu Flag.java tienes 'user' pero aquí 'username'
                flag.setTipoFlag(rs.getString("tipo_flag"));
                flag.setFlag(rs.getString("flag"));
                flag.setFirstFlagUser(rs.getBoolean("first_flag_user"));
                flag.setFirstFlagRoot(rs.getBoolean("first_flag_root"));
                flag.setCreatedAt(rs.getTimestamp("created_at"));
                flags.add(flag);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flags;
    }
}
