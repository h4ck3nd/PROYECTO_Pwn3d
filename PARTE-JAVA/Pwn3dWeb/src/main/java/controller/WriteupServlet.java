package controller;

import model.Writeup;
import dao.WriteupDAO;
import utils.JWTUtil;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
}