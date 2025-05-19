package controlador;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/GuardarDiccionariosControlador")
public class GuardarDiccionariosControlador extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuarios = request.getParameter("usuarios");
        String contrasenas = request.getParameter("contrasenas");

        String rutaUsuarios = getServletContext().getRealPath("/labs/retroGame/users.txt");
        String rutaContrasenas = getServletContext().getRealPath("/labs/retroGame/pass.txt");

        try (PrintWriter writer = new PrintWriter(new FileWriter(rutaUsuarios))) {
            writer.write(usuarios != null ? usuarios : "");
        }

        try (PrintWriter writer = new PrintWriter(new FileWriter(rutaContrasenas))) {
            writer.write(contrasenas != null ? contrasenas : "");
        }

        response.sendRedirect(request.getContextPath() + "/labs/retroGame/bruteForce.jsp"); // Vuelve a la interfaz principal
    }
}