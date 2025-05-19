package controlador;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import java.util.concurrent.TimeUnit;

@WebServlet("/EjecutarBruteForceControlador")
public class EjecutarBruteForceControlador extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Paso 1: Obtener parámetros
        String path = request.getParameter("path");
        String jsession = request.getParameter("jsession");
        String token = request.getParameter("token");

        out.println("[DEBUG] Parámetro path: " + path);
        out.println("[DEBUG] Parámetro jsession: " + jsession);
        out.println("[DEBUG] Parámetro token: " + token);
        out.flush();

        if (path == null || jsession == null || token == null) {
            out.println("[ERROR] Faltan parámetros en la URL.");
            return;
        }

        // Paso 2: Rutas y archivo temporal
        String scriptOriginal = getServletContext().getRealPath("/labs/retroGame/bruteForce.py");
        String scriptTemp = getServletContext().getRealPath("/labs/retroGame/tempBrute.py");
        String rutaUsuarios = getServletContext().getRealPath("/labs/retroGame/users.txt");
        String rutaContrasenas = getServletContext().getRealPath("/labs/retroGame/pass.txt");

        out.println("[DEBUG] Ruta script original: " + scriptOriginal);
        out.println("[DEBUG] Ruta script temporal: " + scriptTemp);
        out.flush();

        // Paso 3: Leer el script original
        String scriptContenido = "";
        try {
            scriptContenido = new String(Files.readAllBytes(Paths.get(scriptOriginal)));
            out.println("[DEBUG] Lectura script original: OK (" + scriptContenido.length() + " caracteres)");
        } catch (IOException e) {
            out.println("[ERROR] No se pudo leer el script original.");
            e.printStackTrace(out);
            return;
        }

        // Paso 4: Reemplazos
        scriptContenido = scriptContenido.replace("<PATH_HTTP>", path)
                                         .replace("<JSESSIONID>", jsession)
                                         .replace("<TOKEN>", token);
        out.println("[DEBUG] Reemplazos en script realizados.");
        out.flush();

        // Paso 5: Guardar nuevo script temporal
        try (PrintWriter writer = new PrintWriter(new FileWriter(scriptTemp))) {
            writer.print(scriptContenido);
            out.println("[DEBUG] Script temporal escrito correctamente.");
        } catch (IOException e) {
            out.println("[ERROR] No se pudo escribir el script temporal.");
            e.printStackTrace(out);
            return;
        }

        // Paso 6: Ejecutar script
        ProcessBuilder pb = new ProcessBuilder("python", scriptTemp, "-u", rutaUsuarios, "-w", rutaContrasenas);
        pb.redirectErrorStream(true);

        out.println("[DEBUG] Ejecutando script con Python...");
        out.flush();

        Process p = pb.start();
        BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));

        String line;
        while ((line = reader.readLine()) != null) {
            out.println(line);
            out.flush();
        }

        out.println("[DEBUG] Script finalizado.");
    }
}
