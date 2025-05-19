package controlador;

import dao.FotoPerfilDAO;  // Importar el DAO
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;

@WebServlet("/SubirFotoPerfil")
@MultipartConfig
public class FotoControlador extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // POST: Recibe imagen y obtiene user_id desde la URL (GET)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("POST - Procesando subida de foto...");

        // user_id viene por GET, como parámetro en la URL
        String userId = request.getParameter("user_id");
        System.out.println("POST - user_id (por GET): " + userId);

        if (userId == null || userId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de usuario no proporcionado.");
            return;
        }

        // Verifica si es acción de eliminar foto
        if (request.getParameter("eliminar") != null) {
            FotoPerfilDAO.eliminarFoto(userId, getServletContext());
            response.sendRedirect("profile.jsp");
            return;
        }

        // Obtener imagen subida
        Part filePart = request.getPart("profilePhoto");
        String fileName = extractFileName(filePart);
        System.out.println("POST - Imagen recibida: " + fileName);

        if (fileName == null || fileName.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No se proporcionó una foto de perfil.");
            return;
        }
        
        // Validar extensión del archivo
        String fileExtension = getFileExtension(fileName).toLowerCase();
        if (!fileExtension.equals("png") && !fileExtension.equals("jpg") && !fileExtension.equals("jpeg")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Solo se permiten archivos .png, .jpg o .jpeg.");
            return;
        }

        
        // Definir la carpeta "uploads" dentro del contexto de la aplicación
        String relativePath = "uploads";
        String absolutePath = getServletContext().getRealPath(relativePath);  // Ruta absoluta relativa a /webapp/uploads

        // Crear el directorio si no existe
        File uploadDir = new File(absolutePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
            System.out.println("Directorio creado en: " + absolutePath);
        }

        // Ruta completa del archivo a guardar
        String uploadPath = absolutePath + File.separator + fileName;

        try {
            filePart.write(uploadPath);  // Guardar archivo
            System.out.println("Archivo guardado en: " + uploadPath);
        } catch (IOException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al guardar el archivo.");
            return;
        }

        // Llamada al DAO para actualizar la foto en la base de datos
        FotoPerfilDAO.actualizarFoto(userId, "uploads/" + fileName);

        response.sendRedirect("profile.jsp");
    }

    // Extraer nombre real del archivo subido
    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String cd : contentDisposition.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 2, cd.length() - 1);
            }
        }
        return null;
    }
    
    // Obtener la extensión del archivo
    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex == -1) return "";  // No tiene extensión
        return fileName.substring(dotIndex + 1);
    }

}
