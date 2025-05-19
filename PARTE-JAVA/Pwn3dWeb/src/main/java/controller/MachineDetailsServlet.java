package controller;

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

import conexionDDBB.ConexionDDBB;
import model.Machine;

@WebServlet("/machineDetails")
public class MachineDetailsServlet extends HttpServlet {
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String machineId = request.getParameter("id");
        System.out.println("👉 ID recibido desde el cliente: " + machineId);

        if (machineId == null || machineId.isEmpty()) {
            System.out.println("⚠️ No se proporcionó un ID válido en la solicitud.");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de máquina no válido");
            return;
        }

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
                        rs.getString("first_user"),  // Ya no se usarán en el JSON
                        rs.getString("first_root"),
                        rs.getString("img_name_os"),
                        rs.getString("download_url"),
                        rs.getString("user_flag"),
                        rs.getString("root_flag")
                );
                System.out.println("✅ Máquina encontrada: " + machine.getNameMachine());
            } else {
                System.out.println("❌ No se encontró ninguna máquina con ID: " + machineId);
            }

            int totalWriteups = 0;
            if (machine != null) {
                String writeupsQuery = "SELECT COUNT(*) FROM writeups_public WHERE vm_name = ?";
                try (PreparedStatement stmtWriteups = conn.prepareStatement(writeupsQuery)) {
                    stmtWriteups.setString(1, machine.getNameMachine());
                    ResultSet rsWriteups = stmtWriteups.executeQuery();
                    if (rsWriteups.next()) {
                        totalWriteups = rsWriteups.getInt(1);
                    }
                } catch (SQLException e) {
                    System.err.println("💥 Error al contar writeups:");
                    e.printStackTrace();
                }
            }

            // NUEVO: obtener el primer user/root desde tabla flags
            String firstUserName = "";
            String firstRootName = "";

            if (machine != null) {
                String flagQuery = "SELECT username, first_flag_user, first_flag_root FROM flags WHERE vm_name = ?";
                try (PreparedStatement flagStmt = conn.prepareStatement(flagQuery)) {
                    flagStmt.setString(1, machine.getNameMachine());
                    ResultSet flagRs = flagStmt.executeQuery();
                    while (flagRs.next()) {
                        if (flagRs.getBoolean("first_flag_user")) {
                            firstUserName = flagRs.getString("username");
                        }
                        if (flagRs.getBoolean("first_flag_root")) {
                            firstRootName = flagRs.getString("username");
                        }
                    }
                } catch (SQLException e) {
                    System.err.println("💥 Error al consultar la tabla flags:");
                    e.printStackTrace();
                }
            }

            // NUEVO: contar flags agrupados por tipo_flag
            int flagsUserCount = 0;
            int flagsRootCount = 0;

            if (machine != null) {
                String countFlagsQuery = "SELECT tipo_flag, COUNT(*) AS total FROM flags WHERE vm_name = ? GROUP BY tipo_flag";
                try (PreparedStatement countStmt = conn.prepareStatement(countFlagsQuery)) {
                    countStmt.setString(1, machine.getNameMachine());
                    ResultSet countRs = countStmt.executeQuery();
                    while (countRs.next()) {
                        String tipoFlag = countRs.getString("tipo_flag");
                        int total = countRs.getInt("total");
                        if ("user".equals(tipoFlag)) {
                            flagsUserCount = total;
                        } else if ("root".equals(tipoFlag)) {
                            flagsRootCount = total;
                        }
                    }
                } catch (SQLException e) {
                    System.err.println("💥 Error al contar flags:");
                    e.printStackTrace();
                }
            }

            conexionDDBB.cerrarConexion();
            System.out.println("🔒 Conexión cerrada.");

            if (machine != null) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();

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
                        + "\"firstUser\":\"" + firstUserName + "\","
                        + "\"firstRoot\":\"" + firstRootName + "\","
                        + "\"imgNameOs\":\"" + machine.getImgNameOs() + "\","
                        + "\"downloadUrl\":\"" + machine.getDownloadUrl() + "\","
                        + "\"totalWriteups\":" + totalWriteups + ","
                        + "\"flagsUserCount\":" + flagsUserCount + ","
                        + "\"flagsRootCount\":" + flagsRootCount + ","
                        + "\"userFlag\":\"" + machine.getUserFlag() + "\","
                        + "\"rootFlag\":\"" + machine.getRootFlag() + "\""
                        + "}";

                out.print(jsonResponse);
                out.flush();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Máquina no encontrada");
            }

        } catch (SQLException e) {
            System.err.println("💥 Error al ejecutar la consulta SQL:");
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error en la base de datos");
        }
    }
}
