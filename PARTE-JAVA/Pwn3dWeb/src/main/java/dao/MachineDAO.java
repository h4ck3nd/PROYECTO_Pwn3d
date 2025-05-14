package dao;

import java.sql.*;
import java.util.*;

import model.Machine;

public class MachineDAO {
    private Connection connection;

    // Constructor
    public MachineDAO(Connection connection) {
        this.connection = connection;
    }

    // Método para agregar una nueva máquina
    public void addMachine(Machine machine) throws SQLException {
        String query = "INSERT INTO machines (id, name_machine, size, os, enviroment, enviroment2, creator, difficulty_card, difficulty, date, md5, writeup_url, first_user, first_root, img_name_os, download_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, machine.getId());
            ps.setString(2, machine.getNameMachine());
            ps.setString(3, machine.getSize());
            ps.setString(4, machine.getOs());
            ps.setString(5, machine.getEnviroment());
            ps.setString(6, machine.getEnviroment2());
            ps.setString(7, machine.getCreator());
            ps.setString(8, machine.getDifficultyCard());
            ps.setString(9, machine.getDifficulty());
            ps.setString(10, machine.getDate());
            ps.setString(11, machine.getMd5());
            ps.setString(12, machine.getWriteupUrl());
            ps.setString(13, machine.getFirstUser());
            ps.setString(14, machine.getFirstRoot());
            ps.setString(15, machine.getImgNameOs());
            ps.setString(16, machine.getDownloadUrl());
            ps.executeUpdate();
        }
    }
}
