package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import dao.UserDAO.RegisterResult;
import model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    // Lista de patrones prohibidos para nombres de usuario (regex, case insensitive)
    private static final List<Pattern> PATRONES_PROHIBIDOS = new ArrayList<>();

    static {
        // Palabras ofensivas básicas (en español) para bloqueo en nombres de usuario
        PATRONES_PROHIBIDOS.add(Pattern.compile(".*(puto|puta|pendejo|pendeja|gilipollas|idiota|imbecil|mierda|cabrón|cabron|cabrone|culo|chingar|chingado|verga|coño|zorra|maricón|maricon|joto|tarado|tarada|bobo|tonto|estupido|estúpido|subnormal|baboso|idiota|retardado|hijo de puta|hijueputa|hijueputas|malparido|malparida|maldito|cojones|cagón|chinga|putas|puta madre|madre de puta|polla|pelotudo|pelotuda|chupapollas|culero|mierda).*", Pattern.CASE_INSENSITIVE));

        // Ejemplos combinados o con palabras intercaladas
        PATRONES_PROHIBIDOS.add(Pattern.compile(".*(puto|puta).*", Pattern.CASE_INSENSITIVE));
        // Agrega más patrones o palabras compuestas según convenga
    }

    // Método que valida si el usuario contiene patrones prohibidos
    private boolean contienePatronProhibido(String usuario) {
        if (usuario == null) {
			return false;
		}
        for (Pattern p : PATRONES_PROHIBIDOS) {
            Matcher matcher = p.matcher(usuario);
            if (matcher.matches()) {
                return true;
            }
        }
        return false;
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("first-name");
        String apellido = request.getParameter("last-name");
        String email = request.getParameter("email");
        String usuario = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");

        HttpSession session = request.getSession();

        // Validar patrón prohibido antes que nada
        if (usuario == null || usuario.trim().isEmpty()) {
            session.setAttribute("loginError", "El nombre de usuario no puede estar vacío.");
            response.sendRedirect("login-register/register.jsp");
            return;
        }

        if (contienePatronProhibido(usuario)) {
            session.setAttribute("loginError", "El nombre de usuario contiene palabras o patrones prohibidos.");
            response.sendRedirect("login-register/register.jsp");
            return;
        }

        if (!password.equals(confirmPassword)) {
            session.setAttribute("loginErrorPass", "Password incorrecta.");
            response.sendRedirect("login-register/register.jsp");
            return;
        }

        String passwordHash = org.apache.commons.codec.digest.DigestUtils.sha256Hex(password);

        User user = new User();
        user.setNombre(nombre);
        user.setApellido(apellido);
        user.setEmail(email);
        user.setUsuario(usuario);
        user.setPassword(passwordHash);

        UserDAO dao = new UserDAO();
        RegisterResult result = dao.registerUser(user);

        switch (result) {
            case SUCCESS:
                session.setAttribute("loginExit", "Registro Exitoso y Código descargado con Éxito.");
                session.setAttribute("codigoSeguro", user.getCodeSecure());
                response.sendRedirect("login-register/register.jsp");
                break;

            case DUPLICATE_USERNAME:
                session.setAttribute("loginError", "Este nombre de usuario ya está en uso.");
                response.sendRedirect("login-register/register.jsp");
                break;

            case IO_ERROR:
                session.setAttribute("loginError", "No se pudo generar el archivo del código seguro.");
                response.sendRedirect("login-register/register.jsp");
                break;

            case SQL_ERROR:
            default:
                session.setAttribute("loginError", "Error inesperado al registrar el usuario.");
                response.sendRedirect("login-register/register.jsp");
                break;
        }
    }
}
