package controlador;

import dao.LaboratorioDAO;
import dao.ValidateFlagDAO;
import utils.JWTUtils;
import utils.UsuarioJWT;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/validarFlagDockerpwned")
public class ValidateFlagControladorDockerpwned extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mensaje = "";
        int labId = -1;

        try {
            // Obtener el userId desde el JWT
            UsuarioJWT usuario = JWTUtils.obtenerUsuarioDesdeRequest(request);
            String userId = usuario.getUserId();

            // Obtener lab_id desde los parámetros de la URL
            String labIdParam = request.getParameter("lab_id");
            labId = Integer.parseInt(labIdParam);

            // Verificar si el usuario ya ha validado la flag
            boolean flagValidada = ValidateFlagDAO.hasFlagBeenValidatedDockerpwned(Integer.parseInt(userId), labId);
            if (flagValidada) {
                mensaje = "Ya has validado esta flag.";
            } else {
                // Comprobar flag
                String flagIngresada = request.getParameter("flag");
                String flagCorrecta = LaboratorioDAO.obtenerFlagPorLaboratorioDockerpwned(labId);

                if (flagIngresada != null && flagIngresada.equals(flagCorrecta)) {
                    int puntos = LaboratorioDAO.obtenerPuntosPorLaboratorioDockerpwned(labId);
                    ValidateFlagDAO.registerFlagValidationDockerpwned(Integer.parseInt(userId), labId, flagIngresada, puntos);
                    mensaje = "Flag validada con exito. Puntos: " + puntos;
                } else {
                    mensaje = "Flag incorrecta, intenta nuevamente.";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            mensaje = "Hubo un error al validar la flag.";
        }

        // Redirección según el labId
        String redireccion;
        switch (labId) {
            case 1:
                redireccion = "/dockerpwned/labs/r00tless.jsp";
                break;
            case 2:
                redireccion = "/dockerpwned/labs/crackoff.jsp";
                break;
            case 3:
                redireccion = "/dockerpwned/labs/hackmedaddy.jsp";
                break;
            default:
                redireccion = "/dockerpwned/home_directory_dockerpwned/home_dockerpwned.jsp?page=0"; // Ruta por defecto si no coincide
                break;
        }

        response.sendRedirect(request.getContextPath() + redireccion + "?mensaje=" + mensaje);
    }
}
