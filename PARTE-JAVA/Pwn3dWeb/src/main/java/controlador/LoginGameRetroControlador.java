package controlador;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import java.io.*;

@WebServlet("/LoginGameRetroControlador")
public class LoginGameRetroControlador extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // Obtener las credenciales del formulario
	    String username = request.getParameter("username");
	    String password = request.getParameter("password");

	    // Imprimir los datos recibidos para depuración
	    System.out.println("Formulario recibido. Usuario: " + username + ", Contraseña: " + password);

	    // Validar credenciales
	    if (isValidUser(username, password)) {
	        // Crear una nueva sesión si no existe
	        HttpSession session = request.getSession();
	        session.setAttribute("username", username);  // Almacena el nombre de usuario en la sesión
	        response.sendRedirect(request.getContextPath() + "/labs/retroGame/admin-panel-super-secret.jsp");
	    } else {
	        // Si las credenciales son incorrectas, redirigir a login.jsp
	        System.out.println("Credenciales incorrectas. Redirigiendo a retroGame-login.jsp");
	        response.sendRedirect(request.getContextPath() + "/labs/retroGame/retroGame-login.jsp");
	    }
	}

    // Función para validar las credenciales contra el archivo XML
    private boolean isValidUser(String username, String password) {
        try {
            // Obtener la ruta absoluta del archivo XML en la carpeta WEB-INF
            String filePath = getServletContext().getRealPath("/labs/retroGame/superultrasecretusers/users.xml");

            // Asegurarse de que la ruta es válida
            File xmlFile = new File(filePath);
            System.out.println("Ruta del archivo XML: " + filePath);  // Depuración
            if (!xmlFile.exists()) {
                System.out.println("Archivo XML no encontrado en la ruta: " + filePath);
                return false;
            }

            // Parsear el archivo XML
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse(xmlFile);
            document.getDocumentElement().normalize();

            NodeList nodeList = document.getElementsByTagName("usuario");

            // Iterar sobre los usuarios en el XML
            for (int i = 0; i < nodeList.getLength(); i++) {
                Node node = nodeList.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element element = (Element) node;
                    String xmlUsername = element.getElementsByTagName("nombre").item(0).getTextContent();
                    String xmlPassword = element.getElementsByTagName("clave").item(0).getTextContent();

                    // Comparar con las credenciales del formulario
                    System.out.println("Comparando: " + xmlUsername + " == " + username + " && " + xmlPassword + " == " + password);
                    if (xmlUsername.equals(username) && xmlPassword.equals(password)) {
                        return true; // Credenciales válidas
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Si no se encuentran las credenciales
    }
}
