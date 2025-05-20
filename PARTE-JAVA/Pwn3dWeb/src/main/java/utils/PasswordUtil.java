package utils;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtil {

    // Método para hashear con SHA-256
    public static String hashPasswordSHA256(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    // Verificar que el password plano coincide con el hash SHA-256 almacenado
    public static boolean verifyPasswordSHA256(String passwordPlain, String hashedPassword) {
        if (passwordPlain == null || hashedPassword == null) return false;
        String hashedInput = hashPasswordSHA256(passwordPlain);
        return hashedInput.equalsIgnoreCase(hashedPassword);
    }
}
