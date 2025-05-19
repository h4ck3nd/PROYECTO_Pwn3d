package utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.ExpiredJwtException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.nio.charset.StandardCharsets;

public class JWTUtils {

    private static final String SECRET_KEY = "clave_super_secreta";

    public static UsuarioJWT obtenerUsuarioDesdeRequest(HttpServletRequest request) throws Exception {
        String token = obtenerTokenDesdeCookies(request);
        if (token == null || token.isEmpty()) {
            throw new Exception("Token no encontrado");
        }

        try {
            Claims claims = Jwts.parser()
                    .setSigningKey(SECRET_KEY.getBytes(StandardCharsets.UTF_8))
                    .parseClaimsJws(token)
                    .getBody();

            String nombre = (String) claims.get("nombre");
            String apellidos = (String) claims.get("apellidos");
            String rol = (String) claims.get("rol");
            String email = (String) claims.get("email");
            String ultimoLogin = (String) claims.get("ultimo_login");
            String usuario = (String) claims.get("usuario");
            String cookie = (String) claims.get("cookie");
            String userId = String.valueOf(claims.get("user_id"));

            return new UsuarioJWT(nombre, apellidos, rol, email, ultimoLogin, usuario, cookie, userId, token);

        } catch (ExpiredJwtException e) {
            throw new Exception("Token expirado");
        } catch (Exception e) {
            throw new Exception("Token inválido: " + e.getMessage());
        }
    }

    private static String obtenerTokenDesdeCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("token".equals(c.getName())) {
                    return c.getValue();
                }
            }
        }
        return null;
    }
}