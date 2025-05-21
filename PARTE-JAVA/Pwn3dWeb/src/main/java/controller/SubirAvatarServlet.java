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

        // Validar token JWT en cookies
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
        if (token == null || !JWTUtil.validateToken(token)) {
            resp.sendRedirect(req.getContextPath() + "/login-register/login.jsp");
            return;
        }
        Integer userId = JWTUtil.getUserIdFromToken(token);
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login-register/login.jsp");
            return;
        }

        // Obtener archivo
        Part filePart = req.getPart("avatarInput");
        if (filePart == null || filePart.getSize() == 0) {
            req.getSession().setAttribute("errorAvatar", "No se ha seleccionado ninguna imagen.");
            resp.sendRedirect(req.getContextPath() + "/perfil");
            return;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String extension = "";
        int i = fileName.lastIndexOf('.');
        if (i > 0) {
            extension = fileName.substring(i).toLowerCase();
        }
        if (!extension.matches("\\.(jpg|jpeg|png|gif|bmp)")) {
            req.getSession().setAttribute("errorAvatar", "Solo se permiten imágenes JPG, JPEG, PNG, GIF o BMP.");
            resp.sendRedirect(req.getContextPath() + "/perfil");
            return;
        }

        // Ruta absoluta en ${catalina.base}/imgProfile
        String tomcatBase = System.getProperty("catalina.base");
        File uploadDir = new File(tomcatBase, UPLOAD_DIR);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
            System.out.println("[DEBUG] Carpeta imgProfile creada: " + created + " en " + uploadDir.getAbsolutePath());
        }

        String newFileName = "avatar_" + userId + "_" + System.currentTimeMillis() + extension;
        File file = new File(uploadDir, newFileName);
        filePart.write(file.getAbsolutePath());

        // DEBUG: Mostrar ruta absoluta del archivo guardado
        System.out.println("[DEBUG] Archivo guardado en: " + file.getAbsolutePath());

        String relativePath = UPLOAD_DIR + "/" + newFileName; // Ruta relativa para guardar en BD

        ImgProfileDAO dao = new ImgProfileDAO();
        try {
            ImgProfile existingImg = dao.getImgProfileByUserId(userId);
            if (existingImg != null) {
                // Borrar archivo anterior
                File oldFile = new File(tomcatBase, existingImg.getPathImg());
                if (oldFile.exists()) {
                    boolean deleted = oldFile.delete();
                    System.out.println("[DEBUG] Archivo anterior borrado: " + deleted);
                }
                dao.updateImgProfile(userId, relativePath);
            } else {
                dao.insertImgProfile(userId, relativePath);
            }
        } finally {
            dao.cerrarConexion();
        }

        req.getSession().setAttribute("successAvatar", "Avatar subido con éxito.");
        resp.sendRedirect(req.getContextPath() + "/perfil");
    }
}
