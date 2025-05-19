package controlador;

import dao.LaboratorioDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/agregarLaboratorio")
public class AgregarLaboratorioControlador extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los datos del formulario
        String nombre = request.getParameter("nombre");
        String flag = request.getParameter("flag");
        String puntosStr = request.getParameter("puntos");

        String mensaje = "";

        try {
            // Validar los puntos (debe ser un número entero positivo)
            int puntos = Integer.parseInt(puntosStr);
            if (puntos <= 0) {
                mensaje = "Los puntos deben ser un número positivo.";
            } else {
                // Insertar el nuevo laboratorio en la base de datos
                boolean exito = LaboratorioDAO.agregarLaboratorio(nombre, flag, puntos);
                if (exito) {
                    mensaje = "Laboratorio agregado con éxito.";
                } else {
                    mensaje = "Hubo un error al agregar el laboratorio.";
                }
            }
        } catch (NumberFormatException e) {
            mensaje = "Los puntos deben ser un número válido.";
        }

        // Pasar el mensaje al JSP
        request.setAttribute("mensaje", mensaje);
        request.getRequestDispatcher("designer/agregarLaboratorio.jsp").forward(request, response);
    }
}
