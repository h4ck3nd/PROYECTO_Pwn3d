package controller;

import conexionDDBB.ConexionDDBB;
import model.Machine;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/machineDetails")
public class MachineDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID de la máquina desde la solicitud (lo que se pasa por URL)
        String machineId = request.getParameter("id");
        System.out.println("👉 ID recibido desde el cliente: " + machineId);

        if (machineId == null || machineId.isEmpty()) {
            System.out.println("⚠️ No se proporcionó un ID válido en la solicitud.");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de máquina no válido");
            return;
        }

        // Conexión a la base de datos
        ConexionDDBB conexionDDBB = new ConexionDDBB();
        Connection conn = conexionDDBB.conectar();
        System.out.println("✅ Conexión establecida con la base de datos.");

        String query = "SELECT * FROM machines WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, machineId);
            ResultSet rs = stmt.executeQuery();

            Machine machine = null;
            if (rs.next()) {
                machine = new Machine(
                    rs.getString("id"),
                    rs.getString("name_machine"),
                    rs.getString("size"),
                    rs.getString("os"),
                    rs.getString("enviroment"),
                    rs.getString("enviroment2"),
                    rs.getString("creator"),
                    rs.getString("difficulty_card"),
                    rs.getString("difficulty"),
                    rs.getString("date"),
                    rs.getString("md5"),
                    rs.getString("writeup_url"),
                    rs.getString("first_user"),
                    rs.getString("first_root"),
                    rs.getString("img_name_os"),
                    rs.getString("download_url")
                );
                System.out.println("✅ Máquina encontrada: " + machine.getNameMachine() + machine.getCreator() + machine.getDate() + machine.getDifficulty() + machine.getDifficultyCard() + machine.getDownloadUrl() + machine.getEnviroment() + machine.getEnviroment2() + machine.getFirstRoot() + machine.getFirstUser() + machine.getImgNameOs() + machine.getMd5());
            } else {
                System.out.println("❌ No se encontró ninguna máquina con ID: " + machineId);
            }

            // Cerrar la conexión
            conexionDDBB.cerrarConexion();
            System.out.println("🔒 Conexión cerrada.");

            // Si la máquina fue encontrada, enviamos los datos como JSON
            if (machine != null) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();

                // Convertir el objeto 'machine' a JSON manualmente o utilizando una librería como Gson o Jackson
                // Aquí lo estamos construyendo manualmente en formato JSON
                String jsonResponse = "{"
                        + "\"id\":\"" + machine.getId() + "\","
                        + "\"nameMachine\":\"" + machine.getNameMachine() + "\","
                        + "\"size\":\"" + machine.getSize() + "\","
                        + "\"os\":\"" + machine.getOs() + "\","
                        + "\"enviroment\":\"" + machine.getEnviroment() + "\","
                        + "\"enviroment2\":\"" + machine.getEnviroment2() + "\","
                        + "\"creator\":\"" + machine.getCreator() + "\","
                        + "\"difficultyCard\":\"" + machine.getDifficultyCard() + "\","
                        + "\"difficulty\":\"" + machine.getDifficulty() + "\","
                        + "\"date\":\"" + machine.getDate() + "\","
                        + "\"md5\":\"" + machine.getMd5() + "\","
                        + "\"writeupUrl\":\"" + machine.getWriteupUrl() + "\","
                        + "\"firstUser\":\"" + machine.getFirstUser() + "\","
                        + "\"firstRoot\":\"" + machine.getFirstRoot() + "\","
                        + "\"imgNameOs\":\"" + machine.getImgNameOs() + "\","
                        + "\"downloadUrl\":\"" + machine.getDownloadUrl() + "\""
                        + "}";

                out.print(jsonResponse);
                out.flush();
            } else {
                // Enviar error si no se encuentra la máquina
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Máquina no encontrada");
            }

        } catch (SQLException e) {
            System.err.println("💥 Error al ejecutar la consulta SQL:");
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error en la base de datos");
        }
    }
}
