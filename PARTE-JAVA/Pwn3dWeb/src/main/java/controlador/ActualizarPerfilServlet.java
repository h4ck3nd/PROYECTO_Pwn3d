package controlador;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureException;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet("/actualizarPerfil")
public class ActualizarPerfilServlet extends HttpServlet {

    private static final String SECRET_KEY = "clave_super_secreta";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        if (token == null || token.isEmpty()) {
            response.sendRedirect("editarPerfil.jsp?mensaje=Error: Token no proporcionado");
            return;
        }

        String userId = null;
        try {
            Claims claims = Jwts.parser()
                    .setSigningKey(SECRET_KEY.getBytes())
                    .parseClaimsJws(token)
                    .getBody();
            userId = claims.getSubject();
        } catch (SignatureException e) {
            response.sendRedirect("editarPerfil.jsp?mensaje=Error: Token no válido");
            return;
        } catch (Exception e) {
            response.sendRedirect("editarPerfil.jsp?mensaje=Error: No se pudo verificar el token");
            return;
        }

        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String email = request.getParameter("email");
        String usuario = request.getParameter("usuario");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        if (newPassword != null && !newPassword.isEmpty() && !newPassword.equals(confirmNewPassword)) {
            response.sendRedirect("editarPerfil.jsp?mensaje=Las contraseñas no coinciden");
            return;
        }

        try {
            URL url = new URL("http://localhost:5000/actualizar-datos");
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json");
            con.setRequestProperty("Cookie", "token=" + token);
            con.setDoOutput(true);

            JSONObject json = new JSONObject();
            json.put("nombre", nombre);
            json.put("apellidos", apellidos);
            json.put("email", email);
            json.put("usuario", usuario);
            json.put("currentPassword", currentPassword);
            json.put("newPassword", newPassword);

            try (OutputStream os = con.getOutputStream()) {
                byte[] input = json.toString().getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
            StringBuilder responseText = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                responseText.append(line.trim());
            }

            JSONObject jsonResponse = new JSONObject(responseText.toString());
            String nuevoToken = jsonResponse.getString("token");

            // Eliminar la cookie antigua
            Cookie cookieAntigua = new Cookie("token", "");
            cookieAntigua.setMaxAge(0);
            cookieAntigua.setPath("/");
            response.addCookie(cookieAntigua);

            // Crear nueva cookie
            Cookie nueva = new Cookie("token", nuevoToken);
            nueva.setHttpOnly(true);
            nueva.setPath("/");
            nueva.setMaxAge(3600);
            response.addCookie(nueva);

            response.sendRedirect("profile.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editarPerfil.jsp?mensaje=Error: No se pudo actualizar el perfil.");
        }
    }
}
