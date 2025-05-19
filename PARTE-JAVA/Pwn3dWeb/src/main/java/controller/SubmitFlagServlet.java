package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conexionDDBB.ConexionDDBB;
import dao.FlagsDAO;
import dao.UserDAO;
import model.Flag;
import model.User;
import utils.JWTUtil;

@WebServlet("/submitFlag")
public class SubmitFlagServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");

	    // Obtener token de cookies
	    String token = null;
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("token".equals(cookie.getName())) {
	                token = cookie.getValue();
	                break;
	            }
	        }
	    }

	    if (token == null || !JWTUtil.validateToken(token)) {
	        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	        response.getWriter().write("{\"error\":\"Token no válido o no proporcionado.\"}");
	        return;
	    }

	    Integer userId = JWTUtil.getUserIdFromToken(token);
	    if (userId == null) {
	        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	        response.getWriter().write("{\"error\":\"No se pudo obtener el ID de usuario del token.\"}");
	        return;
	    }

	    // Parámetros del formulario
	    String vmName = request.getParameter("vmName");
	    String flagValue = request.getParameter("flag");
	    String tipoFlag = request.getParameter("flagType");

	    // Validación parámetros
	    if (vmName == null || flagValue == null || tipoFlag == null ||
	        vmName.trim().isEmpty() || flagValue.trim().isEmpty() || tipoFlag.trim().isEmpty()) {
	        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	        response.getWriter().write("{\"error\":\"Parámetros incompletos.\"}");
	        return;
	    }

	    ConexionDDBB conexionDDBB = new ConexionDDBB();
	    Connection conn = null;

	    try {
	        conn = conexionDDBB.conectar();

	        FlagsDAO flagsDAO = new FlagsDAO(conn);

	        if (flagsDAO.hasUserValidatedFlag(userId, vmName, tipoFlag)) {
	            response.setStatus(HttpServletResponse.SC_CONFLICT);
	            response.getWriter().write("{\"message\":\"Ya validaste la flag de este tipo para esta máquina.\"}");
	            return;
	        }

	        String correctFlag = getFlagFromMachines(vmName, tipoFlag, conn);

	        if (!flagValue.equals(correctFlag)) {
	            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	            response.getWriter().write("{\"error\":\"Flag incorrecta.\"}");
	            return;
	        }

	        boolean existeOtraFlag = flagsDAO.existsFlagForVmName(vmName, tipoFlag);

	        Flag newFlag = new Flag();
	        newFlag.setIdUser(userId);
	        newFlag.setVmName(vmName);
	        // Opcional: si quieres almacenar username, puedes extraerlo también del token
	        newFlag.setUser(JWTUtil.getUsernameFromToken(token));
	        newFlag.setTipoFlag(tipoFlag);
	        newFlag.setFlag(flagValue);
	        newFlag.setFirstFlagUser(tipoFlag.equals("user") && !existeOtraFlag);
	        newFlag.setFirstFlagRoot(tipoFlag.equals("root") && !existeOtraFlag);

	        flagsDAO.insertFlag(newFlag);

	        // Incrementar contador de flags del usuario
	        UserDAO userDAO = new UserDAO(conn);
	        userDAO.incrementFlagCount(userId, tipoFlag);

	        response.setStatus(HttpServletResponse.SC_OK);
	        response.getWriter().write("{\"message\":\"Flag validada con éxito.\"}");

	    } catch (Exception e) {
	        e.printStackTrace();  // Loguear error para debug
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        response.getWriter().write("{\"error\":\"Error en el servidor.\"}");
	    } finally {
	        if (conn != null) {
	            try {
	                conn.close();
	            } catch (Exception ex) {
	                ex.printStackTrace();
	            }
	        }
	        conexionDDBB.cerrarConexion();
	    }
	}

    private int getUserIdFromUsername(String username, UserDAO userDAO) {
        User user = userDAO.getUserByUsername(username);
        return (user != null) ? user.getId() : -1;
    }

    private String getFlagFromMachines(String vmName, String tipoFlag, Connection conn) throws Exception {
        String columnaFlag = tipoFlag.equals("user") ? "user_flag" : "root_flag";
        String sql = "SELECT " + columnaFlag + " FROM machines WHERE name_machine = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, vmName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            } else {
                throw new Exception("Máquina no encontrada");
            }
        }
    }
}
