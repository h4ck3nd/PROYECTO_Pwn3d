package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StatsDAO {
    private Connection con;

    public StatsDAO(Connection con) {
        this.con = con;
    }

    public int getTotalMachines() throws SQLException {
        return getCount("SELECT COUNT(*) FROM machines");
    }

    public int getTotalUsers() throws SQLException {
        return getCount("SELECT COUNT(*) FROM users");
    }

    public int getTotalWriteups() throws SQLException {
        return getCount("SELECT COUNT(*) FROM writeups_public");
    }

    private int getCount(String sql) throws SQLException {
        try (PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
