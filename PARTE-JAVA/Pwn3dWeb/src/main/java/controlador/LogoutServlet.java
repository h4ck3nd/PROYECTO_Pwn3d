package controlador;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el token de la cookie
        String token = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token != null && !token.isEmpty()) {
            // Invalidar sesión actual
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }

            // Eliminar cookie del navegador
            Cookie authCookie = new Cookie("token", "");
            authCookie.setMaxAge(0);
            authCookie.setPath("/");
            response.addCookie(authCookie);

            // Llamar al endpoint de Flask
            try {
                HttpClient client = HttpClient.newHttpClient();
                HttpRequest flaskRequest = HttpRequest.newBuilder()
                        .uri(URI.create("http://localhost:5000/logout"))
                        .header("Cookie", "token=" + token)
                        .POST(HttpRequest.BodyPublishers.noBody())
                        .build();

                HttpResponse<String> flaskResponse = client.send(flaskRequest, HttpResponse.BodyHandlers.ofString());

                if (flaskResponse.statusCode() == 200) {
                    System.out.println("Sesión cerrada correctamente en backend Flask.");
                } else {
                    System.out.println("Error al cerrar sesión en Flask: código " + flaskResponse.statusCode());
                }

            } catch (Exception e) {
                System.out.println("Error llamando al backend Flask: " + e.getMessage());
            }
        }

        // Redirigir siempre al login de Flet
        response.sendRedirect("http://localhost:30050");
    }
}
