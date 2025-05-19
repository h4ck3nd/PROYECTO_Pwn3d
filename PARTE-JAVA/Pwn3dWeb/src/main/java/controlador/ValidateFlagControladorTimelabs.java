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

@WebServlet("/validarFlagTimelabs")
public class ValidateFlagControladorTimelabs extends HttpServlet {
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
            boolean flagValidada = ValidateFlagDAO.hasFlagBeenValidatedTimelabs(Integer.parseInt(userId), labId);
            if (flagValidada) {
                mensaje = "Ya has validado esta flag.";
            } else {
                // Comprobar flag
                String flagIngresada = request.getParameter("flag");
                String flagCorrecta = LaboratorioDAO.obtenerFlagPorLaboratorioTimelabs(labId);

                if (flagIngresada != null && flagIngresada.equals(flagCorrecta)) {
                    int puntos = LaboratorioDAO.obtenerPuntosPorLaboratorioTimelabs(labId);
                    ValidateFlagDAO.registerFlagValidationTimelabs(Integer.parseInt(userId), labId, flagIngresada, puntos);
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
                redireccion = "/timelabs/timelabs.jsp";
                break;
            default:
                redireccion = "/timelabs/timelabs.jsp"; // Ruta por defecto si no coincide
                break;
        }

        response.sendRedirect(request.getContextPath() + redireccion + "?mensaje=" + mensaje);
    }
}
