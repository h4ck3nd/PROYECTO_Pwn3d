package utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

public class JWTUtil {

    private static final String SECRET_KEY = "-yTUI4zPf>V7/60x:1?V<MHod}>"; //Clave secreta TOKEN
    private static final long EXPIRATION_TIME = 86400000; // 1 día

    public static String generateToken(
            int id,
            String nombre,
            String apellido,
            String usuario,
            String email,
            String rol,
            String cookie,
            int flagsUser,
            int flagsRoot,
            Date ultimoInicio
    ) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("id", id);
        claims.put("nombre", nombre);
        claims.put("apellido", apellido);
        claims.put("usuario", usuario);
        claims.put("email", email);
        claims.put("rol", rol);
        claims.put("cookie", cookie);
        claims.put("flags_user", flagsUser);
        claims.put("flags_root", flagsRoot);
        claims.put("ultimo_inicio", ultimoInicio);

        return Jwts.builder()
                .setClaims(claims)
                .setSubject(usuario)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY.getBytes())
                .compact();
    }

    // Valida el token (ya lo tienes)
    public static boolean validateToken(String token) {
        try {
            Jwts.parser().setSigningKey(SECRET_KEY.getBytes()).parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    // Nuevo método para extraer el userId
    public static Integer getUserIdFromToken(String token) {
        try {
            Claims claims = Jwts.parser()
                .setSigningKey(SECRET_KEY.getBytes())
                .parseClaimsJws(token)
                .getBody();
            // Asumiendo que el id está en el claim "id" y es un número entero
            Number id = (Number) claims.get("id");
            return id != null ? id.intValue() : null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String getUsernameFromToken(String token) {
        return Jwts.parser()
                .setSigningKey(SECRET_KEY.getBytes())
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }

    public static String getRoleFromToken(String token) {
        return (String) Jwts.parser()
                .setSigningKey(SECRET_KEY.getBytes())
                .parseClaimsJws(token)
                .getBody()
                .get("rol");
    }
    
    public static Map<String, Object> getAllClaims(String token) {
        try {
            Claims claims = Jwts.parser()
                    .setSigningKey(SECRET_KEY.getBytes())
                    .parseClaimsJws(token)
                    .getBody();
            return new HashMap<>(claims);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static String getTokenIdentity(String token) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(token.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.substring(0, 10) + "@pwn3d.es"; // ejemplo: ab5cd923f1@pwn3d.es
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error al generar la identidad");
        }
    }
}
