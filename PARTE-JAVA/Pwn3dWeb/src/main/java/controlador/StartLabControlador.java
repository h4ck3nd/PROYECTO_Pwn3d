package controlador;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

// CODIGO PROVISIONAL PARA DESPLEGAR UNA MAQUINA EN DOCKER (NO EN USO ACTUALMENTE)

@WebServlet("/startLab")
public class StartLabControlador extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String containerName = "r00tless";
        String imageName = "r00tless:latest";

        // Ruta del archivo .tar dentro de /resources/docker/
        String tarPath = getServletContext().getRealPath("/resources/docker/r00tless.tar");

        // Verificar si la imagen ya existe
        if (!isImageLoaded(imageName)) {
            // Cargar imagen .tar
            ProcessBuilder loadImage = new ProcessBuilder("runDocker.bat", "load", "-i", tarPath);
            loadImage.redirectErrorStream(true);
            Process loadProcess = loadImage.start();
            try {
                int result = loadProcess.waitFor();
                if (result != 0) {
                    response.getWriter().println("❌ Error al cargar la imagen .tar");
                    return;
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
                response.getWriter().println("❌ Error de sistema al cargar imagen");
                return;
            }
        }

        // Verificar si el contenedor ya existe
        try {
            if (isContainerRunning(containerName)) {
                // Eliminarlo si está creado
                Process removeProcess = new ProcessBuilder("runDocker.bat", "rm", "-f", containerName).start();
                removeProcess.waitFor();
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            response.getWriter().println("❌ Error al eliminar el contenedor existente.");
            return;
        }

        // Lanzar contenedor
        ProcessBuilder pb = new ProcessBuilder("runDocker.bat", "run", "-d", "-p", "8085:80", "--name", containerName, imageName);
        pb.redirectErrorStream(true);
        Process process = pb.start();
        BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));

        StringBuilder output = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            output.append(line).append("\n");
        }

        int exitCode;
        try {
            exitCode = process.waitFor();
        } catch (InterruptedException e) {
            e.printStackTrace();
            response.getWriter().println("❌ Error interno.");
            return;
        }

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (exitCode == 0) {
            out.println("<h3>🟢 Contenedor iniciado con éxito</h3>");
            out.println("<p>Accede al laboratorio: <a href='http://localhost:8085' target='_blank'>http://localhost:8085</a></p>");
        } else {
            out.println("<h3>🔴 Error al iniciar el contenedor</h3>");
            out.println("<pre>" + output.toString() + "</pre>");
        }
    }

    private boolean isImageLoaded(String imageName) throws IOException {
        ProcessBuilder checkImage = new ProcessBuilder("runDocker.bat", "images", "-q", imageName);
        Process imageCheck = checkImage.start();
        BufferedReader reader = new BufferedReader(new InputStreamReader(imageCheck.getInputStream()));
        String result = reader.readLine();
        return result != null && !result.isEmpty();
    }

    private boolean isContainerRunning(String containerName) throws IOException {
        ProcessBuilder checkContainer = new ProcessBuilder("runDocker.bat", "ps", "-a", "--filter", "name=" + containerName, "--format", "{{.Names}}");
        Process process = checkContainer.start();
        BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
        return reader.readLine() != null;
    }

    public static void main(String[] args) {
        // Imprimir el PATH para depurar
        System.out.println("PATH del entorno Java: " + System.getenv("PATH"));
    }
}