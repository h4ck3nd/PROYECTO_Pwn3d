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

@WebServlet("/validarFlag")
public class ValidateFlagControlador extends HttpServlet {
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
            boolean flagValidada = ValidateFlagDAO.hasFlagBeenValidated(Integer.parseInt(userId), labId);
            if (flagValidada) {
                mensaje = "Ya has validado esta flag.";
            } else {
                // Comprobar flag
                String flagIngresada = request.getParameter("flag");
                String flagCorrecta = LaboratorioDAO.obtenerFlagPorLaboratorio(labId);

                if (flagIngresada != null && flagIngresada.equals(flagCorrecta)) {
                    int puntos = LaboratorioDAO.obtenerPuntosPorLaboratorio(labId);
                    ValidateFlagDAO.registerFlagValidation(Integer.parseInt(userId), labId, flagIngresada, puntos);
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
                redireccion = "/labs/foro-xss-lab.jsp";
                break;
            case 2:
                redireccion = "/labs/amashop/amashop-lab.jsp";
                break;
            case 3:
                redireccion = "/labs/hacking_community/hacking_community-lab.jsp";
                break;
            case 4:
                redireccion = "/labs/separo/separo-lab.jsp";
                break;
            case 5:
                redireccion = "/labs/cinehub/cinehub-lab.jsp";
                break;
            case 6:
                redireccion = "/labs/retroGame/retroGame-lab.jsp";
                break;
            case 7:
                redireccion = "/labs/whatsapp_fake/whatsapp_fake_lab.jsp";
                break;
            case 8:
                redireccion = "/labs/router/router-lab.jsp";
                break;
            case 9:
                redireccion = "/labs/hackGame/hackGame-lab.jsp";
                break;
            default:
                redireccion = "/home_directory/home.jsp?page=0"; // Ruta por defecto si no coincide
                break;
        }

        response.sendRedirect(request.getContextPath() + redireccion + "?mensaje=" + mensaje);
    }
}
