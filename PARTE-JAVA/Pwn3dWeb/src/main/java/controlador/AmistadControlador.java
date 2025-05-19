package controlador;

import dao.AmistadDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/amistad")
public class AmistadControlador extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        
        // Depuración: Mostrar el valor de la acción recibida
        System.out.println("Acción recibida: " + accion);

        // Obtener el ID de usuario desde el parámetro GET (en lugar de la sesión)
        String userIdParam = request.getParameter("userId");

        // Depuración: Verificar si el userIdParam está llegando correctamente
        System.out.println("Valor de userIdParam: " + userIdParam);

        if (userIdParam == null || userIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login"); // Redirigir al login si no se proporciona el ID de usuario
            return;
        }

        try {
            int usuarioLogueadoId = Integer.parseInt(userIdParam); // Convertir el parámetro a entero
            System.out.println("ID de usuario logueado: " + usuarioLogueadoId); // Depuración: Verificar el ID del usuario logueado

            AmistadDAO dao = new AmistadDAO();

            switch (accion) {
                case "enviar":
                    String solicitadoIdParam = request.getParameter("solicitadoId");
                    System.out.println("Valor de solicitadoIdParam: " + solicitadoIdParam); // Depuración: Verificar solicitadoId

                    if (solicitadoIdParam == null || solicitadoIdParam.isEmpty()) {
                        System.out.println("El solicitadoId no ha sido proporcionado.");
                        break;
                    }

                    int solicitadoId = Integer.parseInt(solicitadoIdParam);
                    System.out.println("ID del solicitado: " + solicitadoId); // Depuración: Verificar ID del solicitado
                    dao.enviarSolicitud(usuarioLogueadoId, solicitadoId);
                    break;
                case "aceptar":
                    String idAmistadParam = request.getParameter("idAmistad");
                    System.out.println("Valor de idAmistadParam: " + idAmistadParam); // Depuración: Verificar idAmistad

                    if (idAmistadParam == null || idAmistadParam.isEmpty()) {
                        System.out.println("El idAmistad no ha sido proporcionado.");
                        break;
                    }

                    int idAmistadAceptar = Integer.parseInt(idAmistadParam);
                    System.out.println("ID de amistad para aceptar: " + idAmistadAceptar); // Depuración: Verificar ID de amistad para aceptar
                    dao.aceptarSolicitud(idAmistadAceptar);
                    break;
                case "rechazar":
                    String idAmistadRechazarParam = request.getParameter("idAmistad");
                    System.out.println("Valor de idAmistadRechazarParam: " + idAmistadRechazarParam); // Depuración: Verificar idAmistad

                    if (idAmistadRechazarParam == null || idAmistadRechazarParam.isEmpty()) {
                        System.out.println("El idAmistad no ha sido proporcionado.");
                        break;
                    }

                    int idAmistadRechazar = Integer.parseInt(idAmistadRechazarParam);
                    System.out.println("ID de amistad para rechazar: " + idAmistadRechazar); // Depuración: Verificar ID de amistad para rechazar
                    dao.rechazarSolicitud(idAmistadRechazar);
                    break;
                default:
                    System.out.println("Acción no válida: " + accion); // Depuración: Acción no válida
                    break;
            }
        } catch (SQLException e) {
            // Depuración: Mostrar error de SQL
            e.printStackTrace();
        } catch (NumberFormatException e) {
            // Depuración: Mostrar error de conversión de número
            System.out.println("Error de formato de número: " + e.getMessage());
            e.printStackTrace();
        }

        // Redirigir después de la acción
        response.sendRedirect(request.getContextPath() + "/usuarios");
    }
}
