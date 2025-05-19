package controlador;

import conexionDDBB.ConexionDDBB;
import com.google.gson.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/countdown")
public class CountdownControlador extends HttpServlet {

    private static final int COUNTDOWN_ID = 1;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        ConexionDDBB db = new ConexionDDBB();
        Connection conn = db.conectar();

        try (PreparedStatement stmt = conn.prepareStatement("SELECT target_time FROM countdown WHERE id = ?")) {
            stmt.setInt(1, COUNTDOWN_ID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                long targetTime = rs.getLong("target_time");

                JsonObject json = new JsonObject();

                // Si viene el parámetro ?status=true devolvemos si está activo o no
                if ("true".equalsIgnoreCase(req.getParameter("status"))) {
                    boolean activo = (targetTime > 0); // si hay tiempo, está activo
                    json.addProperty("activo", activo);
                } else {
                    // Si no hay parámetro, devolvemos el targetTime
                    json.addProperty("targetTime", targetTime);
                }

                resp.getWriter().write(json.toString());
            } else {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace(resp.getWriter());
        } finally {
            db.cerrarConexion();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");

        BufferedReader reader = req.getReader();
        JsonObject body = JsonParser.parseReader(reader).getAsJsonObject();
        int durationSeconds = body.get("durationSeconds").getAsInt();

        long targetTime = System.currentTimeMillis() + (durationSeconds * 1000L);

        ConexionDDBB db = new ConexionDDBB();
        Connection conn = db.conectar();

        try (PreparedStatement stmt = conn.prepareStatement("UPDATE countdown SET target_time = ? WHERE id = ?")) {
            stmt.setLong(1, targetTime);
            stmt.setInt(2, COUNTDOWN_ID);
            stmt.executeUpdate();

            JsonObject json = new JsonObject();
            json.addProperty("targetTime", targetTime);
            resp.getWriter().write(json.toString());
        } catch (SQLException e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace(resp.getWriter());
        } finally {
            db.cerrarConexion();
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");

        ConexionDDBB db = new ConexionDDBB();
        Connection conn = db.conectar();

        try (PreparedStatement stmt = conn.prepareStatement("UPDATE countdown SET target_time = NULL WHERE id = ?")) {
            stmt.setInt(1, COUNTDOWN_ID);
            stmt.executeUpdate();

            JsonObject json = new JsonObject();
            json.addProperty("message", "Contador reseteado");
            resp.getWriter().write(json.toString());
        } catch (SQLException e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace(resp.getWriter());
        } finally {
            db.cerrarConexion();
        }
    }
}