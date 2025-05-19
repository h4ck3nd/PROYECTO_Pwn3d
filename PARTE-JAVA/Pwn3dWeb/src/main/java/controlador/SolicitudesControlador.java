package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.AmistadDAO;

@WebServlet("/solicitudes")
public class SolicitudesControlador extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int usuarioId = Integer.parseInt(request.getParameter("userId"));
        
        // Obtener solicitudes desde tu DAO
        List<Map<String, String>> solicitudes = null;
		try {
			solicitudes = new AmistadDAO().obtenerSolicitudesRecibidas(usuarioId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        // Devolver las solicitudes como JSON
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.println(new Gson().toJson(solicitudes));  // Si usas Gson para convertir a JSON
    }
}