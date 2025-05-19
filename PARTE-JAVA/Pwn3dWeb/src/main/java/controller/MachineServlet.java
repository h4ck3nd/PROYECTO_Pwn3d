package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conexionDDBB.ConexionDDBB;
import model.Machine;

@WebServlet("/machines")
public class MachineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Connection connection;
    private ConexionDDBB conexionDDBB;

    // Iniciar la conexión al servlet
    @Override
    public void init() throws ServletException {
        conexionDDBB = new ConexionDDBB();
        connection = conexionDDBB.conectar();
    }

 // Método para manejar el POST
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los datos del formulario
        String id = request.getParameter("id");
        String nameMachine = request.getParameter("name_machine");
        String size = request.getParameter("size");
        String os = request.getParameter("os");
        String enviroment = request.getParameter("enviroment");
        String enviroment2 = request.getParameter("enviroment2");
        String creator = request.getParameter("creator");
        String difficultyCard = request.getParameter("difficulty_card");
        String difficulty = request.getParameter("difficulty");
        String date = request.getParameter("date");
        String md5 = request.getParameter("md5");
        String writeupUrl = request.getParameter("writeup_url");
        String firstUser = request.getParameter("first_user");
        String firstRoot = request.getParameter("first_root");
        String imgNameOs = request.getParameter("img_name_os");
        String downloadUrl = request.getParameter("download_url");
        String userFlag = request.getParameter("user_flag");
        String rootFlag = request.getParameter("root_flag");

        // Crear un objeto de la clase Machine
        Machine machine = new Machine(id, nameMachine, size, os, enviroment, enviroment2, creator, difficultyCard, difficulty, date, md5, writeupUrl, firstUser, firstRoot, imgNameOs, downloadUrl, userFlag, rootFlag);

        // Verificar si el id ya existe en la base de datos
        try {
            if (isIdExists(id)) {
                response.sendRedirect("error.jsp?error=El ID ya existe"); // Redirige a la página de error si el ID ya existe
            } else {
                // Insertar la máquina en la base de datos
                insertMachine(machine);
                response.sendRedirect("machines.jsp"); // Redirige a la página de éxito
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirige a la página de error si ocurre un problema
        }
    }

 // Método para verificar si el ID ya existe en la base de datos
    private boolean isIdExists(String id) throws SQLException {
        // Asegúrate de que 'id' esté en formato String
        String checkQuery = "SELECT COUNT(*) FROM machines WHERE id = CAST(? AS VARCHAR)";  // Conversión explícita a VARCHAR

        try (PreparedStatement ps = connection.prepareStatement(checkQuery)) {
            ps.setString(1, id); // Aquí se pasa el valor de 'id' como String
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Si el número de registros es mayor a 0, el ID existe
            }
        }
        return false; // El ID no existe
    }

    // Método para insertar la máquina en la base de datos
    private void insertMachine(Machine machine) throws SQLException {
    	String query = "INSERT INTO machines (id, name_machine, size, os, enviroment, enviroment2, creator, difficulty_card, difficulty, date, md5, writeup_url, first_user, first_root, img_name_os, download_url, user_flag, root_flag) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // Asumiendo que tienes un PreparedStatement preparado para los valores
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, machine.getId());
            ps.setString(2, machine.getNameMachine());
            ps.setString(3, machine.getSize());
            ps.setString(4, machine.getOs());
            ps.setString(5, machine.getEnviroment());

            // Aquí verificamos si 'enviroment2' es nulo o vacío, y si es así, lo dejamos como null
            if (machine.getEnviroment2() == null || machine.getEnviroment2().isEmpty()) {
                ps.setNull(6, Types.VARCHAR);  // Establece NULL para enviroment2 si no se proporciona
            } else {
                ps.setString(6, machine.getEnviroment2());
            }

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

            ps.setString(17, machine.getUserFlag());
            ps.setString(18, machine.getRootFlag());

            // Ejecutar la actualización
            ps.executeUpdate();
        }
    }

    // Cerrar la conexión al servlet
    @Override
    public void destroy() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Conexión cerrada.");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
