package controller;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.WriteupDAO;
import model.Writeup;
import utils.JWTUtil;

@WebServlet("/sendWriteup")
public class WriteupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        if (token == null || !JWTUtil.validateToken(token)) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Token inválido o no presente.");
            return;
        }

        Integer userId = JWTUtil.getUserIdFromToken(token);
        if (userId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No se pudo extraer el userId del token.");
            return;
        }

        // Parámetros del formulario
        String url = request.getParameter("URL");

        // 🔒 Validar la URL antes de continuar
        if (!isUrlSegura(url)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "URL inválida o potencialmente insegura.");
            return;
        }

        String vmName = request.getParameter("vmName");
        String creator = request.getParameter("Creator");
        String contentType = request.getParameter("ContentType");
        String language = request.getParameter("Language");
        String opinion = request.getParameter("Opinion");

        // Validación básica
        if (url == null || vmName == null || creator == null || contentType == null || language == null ||
            url.isEmpty() || vmName.isEmpty() || creator.isEmpty() || contentType.isEmpty() || language.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Faltan campos obligatorios.");
            return;
        }

        Writeup writeup = new Writeup();
        writeup.setUrl(url);
        writeup.setVmName(vmName);
        writeup.setUserId(userId);
        writeup.setCreator(creator);
        writeup.setContentType(contentType);
        writeup.setLanguage(language);
        writeup.setOpinion(opinion != null && !opinion.trim().isEmpty() ? opinion.trim() : null);

        try {
            new WriteupDAO().insertWriteup(writeup);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al insertar el writeup.");
        }
    }

    // SOLAMENTE ADMITE DOMINIOS, NO IPs

    private boolean isUrlSegura(String url) {
        try {
            URL parsedUrl = new URL(url);
            String host = parsedUrl.getHost();

            // Rechazar si no es HTTPS
            if (!"https".equalsIgnoreCase(parsedUrl.getProtocol())) {
                return false;
            }

            // Rechazar localhost y variantes
            if (host.equalsIgnoreCase("localhost") ||
                host.equals("127.0.0.1") ||
                host.equals("0.0.0.0") ||
                host.equals("::1")) {
                return false;
            }

            // Rechazar IPs IPv4 (ej. 192.168.1.1) o IPv6
            if (host.matches("^\\d{1,3}(\\.\\d{1,3}){3}$") ||     // IPv4
                host.matches("^[\\da-fA-F:]+$")) {               // IPv6
                return false;
            }

            // Solo permitir dominios
            return true;
        } catch (MalformedURLException e) {
            return false;
        }
    }
}