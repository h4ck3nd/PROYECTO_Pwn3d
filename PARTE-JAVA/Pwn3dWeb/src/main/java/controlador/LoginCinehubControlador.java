package controlador;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.xml.parsers.*;
import javax.xml.xpath.*;
import org.w3c.dom.*;
import java.io.*;

@WebServlet("/LoginCinehubControlador")
public class LoginCinehubControlador extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("username");
        String password = request.getParameter("password");

        // Ruta absoluta del archivo XML dentro del proyecto web
        String path = getServletContext().getRealPath("/labs/cinehub/users.xml");

        try {
            File archivo = new File(path);
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(archivo);
            doc.getDocumentElement().normalize();

            // ⚠️ Consulta XPath vulnerable a inyección
            XPath xpath = XPathFactory.newInstance().newXPath();
            String expression = "/usuarios/usuario[nombre='" + usuario + "' and clave='" + password + "']";
            Node node = (Node) xpath.evaluate(expression, doc, XPathConstants.NODE);

            if (node != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", usuario);
                response.sendRedirect(request.getContextPath() + "/labs/cinehub/cinehub.jsp");
            } else {
                response.getWriter().println("Credenciales inválidas.");
            }

        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }
}
