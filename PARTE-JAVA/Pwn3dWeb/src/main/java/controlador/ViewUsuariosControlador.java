package controlador;

import dao.ProfileUsersDAO;
import dao.ViewUsuariosDAO;
import conexionDDBB.ConexionDDBB; // Clase de conexión
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet("/usuarios")
public class ViewUsuariosControlador extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ViewUsuariosDAO usuarioDAO = new ViewUsuariosDAO();
        ConexionDDBB conexionDB = new ConexionDDBB(); // Instancia la clase de conexión
        Connection conexion = null;

        try {
            conexion = conexionDB.conectar(); // Se establece la conexión a la base de datos
            List<Map<String, String>> usuarios = usuarioDAO.obtenerUsuarios();

            ProfileUsersDAO profileDAO = new ProfileUsersDAO(); // Instancia el ProfileDAO

            for (Map<String, String> usuario : usuarios) {
                int userId = Integer.parseInt(usuario.get("id"));
                String photoPath = profileDAO.obtenerRutaFotoPerfil(userId); // Obtén la foto del perfil

                if (photoPath == null || photoPath.isEmpty()) {
                    photoPath = "img/Profile.png"; // Imagen por defecto si no tiene foto
                }
                usuario.put("photo_path", photoPath); // Añade la foto al mapa del usuario
            }

            request.setAttribute("usuarios", usuarios);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/usuarios.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error obteniendo usuarios", e);
        } finally {
            // Se cierra la conexión en el bloque finally
            if (conexion != null) {
                try {
                    conexion.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
