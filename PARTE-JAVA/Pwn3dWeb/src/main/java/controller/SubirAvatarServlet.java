package controller;

import dao.ImgProfileDAO;
import model.ImgProfile;
import utils.JWTUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/subirAvatar")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,    // 1MB antes de escribir en disco
    maxFileSize = 1024 * 1024 * 5,          // max 5MB
    maxRequestSize = 1024 * 1024 * 10       // max 10MB
)
public class SubirAvatarServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "imgProfile";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("[DEBUG] Entrando a SubirAvatarServlet.doPost");

        // Obtener token y validar usuario
        Cookie[] cookies = req.getCookies();
        String token = null;
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("token".equals(c.getName())) {
                    token = c.getValue();
                    break;
                }
            }
        }

        if (token == null) {
            System.out.println("[DEBUG] Token no encontrado en cookies");
            resp.sendRedirect(req.getContextPath() + "/login-register/login.jsp");
            return;
        }

        if (!JWTUtil.validateToken(token)) {
            System.out.println("[DEBUG] Token inválido");
            resp.sendRedirect(req.getContextPath() + "/login-register/login.jsp");
            return;
        }

        Integer userId = JWTUtil.getUserIdFromToken(token);
        System.out.println("[DEBUG] userId extraído del token: " + userId);
        if (userId == null) {
            System.out.println("[DEBUG] userId es null después de extraer del token");
            resp.sendRedirect(req.getContextPath() + "/login-register/login.jsp");
            return;
        }

        // Obtener archivo enviado
        Part filePart = req.getPart("avatarInput");
        if (filePart == null || filePart.getSize() == 0) {
            System.out.println("[DEBUG] No se ha seleccionado ninguna imagen o archivo vacío");
            req.getSession().setAttribute("errorAvatar", "No se ha seleccionado ninguna imagen.");
            resp.sendRedirect(req.getContextPath() + "/perfil");
            return;
        }
        System.out.println("[DEBUG] Archivo recibido: " + filePart.getSubmittedFileName() + ", tamaño: " + filePart.getSize());

        // Obtener nombre archivo y extensión
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String extension = "";
        int i = fileName.lastIndexOf('.');
        if (i > 0) {
            extension = fileName.substring(i).toLowerCase();
        }
        System.out.println("[DEBUG] Extensión del archivo: " + extension);

        // Validar extensión de imagen (opcional)
        if (!extension.matches("\\.(jpg|jpeg|png|gif|bmp)")) {
            System.out.println("[DEBUG] Extensión no permitida: " + extension);
            req.getSession().setAttribute("errorAvatar", "Solo se permiten imágenes JPG, JPEG, PNG, GIF o BMP.");
            resp.sendRedirect(req.getContextPath() + "/perfil");
            return;
        }

        // Crear carpeta relativa a la aplicación web
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdir();
            System.out.println("[DEBUG] Carpeta upload creada: " + created + " en " + uploadPath);
        } else {
            System.out.println("[DEBUG] Carpeta upload ya existe: " + uploadPath);
        }

        // Nombre único para evitar conflictos: "avatar_userId_timestamp.ext"
        String newFileName = "avatar_" + userId + "_" + System.currentTimeMillis() + extension;
        System.out.println("[DEBUG] Nuevo nombre archivo: " + newFileName);

        // Guardar archivo físicamente
        File file = new File(uploadDir, newFileName);
        filePart.write(file.getAbsolutePath());
        System.out.println("[DEBUG] Archivo guardado en: " + file.getAbsolutePath());

        // Ruta relativa para guardar en BD (para llamar desde JSP)
        String relativePath = UPLOAD_DIR + "/" + newFileName;

        ImgProfileDAO dao = new ImgProfileDAO();
        try {
            // Obtener imagen previa
            ImgProfile existingImg = dao.getImgProfileByUserId(userId);
            if (existingImg != null) {
                System.out.println("[DEBUG] Imagen previa encontrada: " + existingImg.getPathImg());
                // Borrar archivo anterior
                File oldFile = new File(getServletContext().getRealPath("") + File.separator + existingImg.getPathImg());
                if (oldFile.exists()) {
                    boolean deleted = oldFile.delete();
                    System.out.println("[DEBUG] Archivo anterior borrado: " + deleted);
                }
                // Actualizar ruta en BD
                boolean updated = dao.updateImgProfile(userId, relativePath);
                System.out.println("[DEBUG] Actualización en BD: " + updated);
            } else {
                System.out.println("[DEBUG] No existe imagen previa, insertando nueva");
                boolean inserted = dao.insertImgProfile(userId, relativePath);
                System.out.println("[DEBUG] Inserción en BD: " + inserted);
            }
        } finally {
            dao.cerrarConexion();
        }

        // Mensaje éxito y redirección
        req.getSession().setAttribute("successAvatar", "Avatar subido con éxito.");
        resp.sendRedirect(req.getContextPath() + "/perfil");
    }
}
