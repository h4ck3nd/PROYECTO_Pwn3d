package controller;

import dao.NewVMDAO;
import model.NewVM;
import utils.JWTUtil;
import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/sendNewVM")
public class NewVMServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = null;
        if (request.getCookies() != null) {
            for (Cookie c : request.getCookies()) {
                if ("token".equals(c.getName())) {
                    token = c.getValue();
                    break;
                }
            }
        }

        if (token == null || !JWTUtil.validateToken(token)) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Token inválido.");
            return;
        }

        Integer userId = JWTUtil.getUserIdFromToken(token);
        if (userId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID inválido.");
            return;
        }

        String urlVm = request.getParameter("URL");
        String urlWriteup = request.getParameter("Solution");

        // Validar URL VM (obligatoria)
        if (urlVm == null || !isUrlSegura(urlVm)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "URL de VM inválida o insegura. Debe ser HTTPS y no usar IPs o localhost.");
            return;
        }
        // Validar URL Writeup (opcional, puede estar vacía)
        if (urlWriteup != null && !urlWriteup.trim().isEmpty() && !isUrlSegura(urlWriteup)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "URL del writeup inválida o insegura.");
            return;
        }

        try {
            NewVM vm = new NewVM();
            vm.setUserId(userId);
            vm.setNameVm(request.getParameter("Name"));
            vm.setCreator(request.getParameter("Creator"));
            vm.setDifficulty(request.getParameter("Level"));
            vm.setUrlVm(urlVm);
            vm.setUserFlag(request.getParameter("UserFlag"));
            vm.setRootFlag(request.getParameter("RootFlag"));
            vm.setUrlWriteup(urlWriteup);
            vm.setContact(request.getParameter("Contact"));
            vm.setTags(request.getParameter("Tags"));
            vm.setEstado("Pendiente");

            new NewVMDAO().insertNewVM(vm);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al insertar VM.");
        }
    }
    
    private boolean isUrlSegura(String url) {
        try {
            URL parsedUrl = new URL(url);
            String host = parsedUrl.getHost();

            // Solo HTTPS permitido
            if (!"https".equalsIgnoreCase(parsedUrl.getProtocol())) {
                return false;
            }

            // Bloquear localhost e IPs directas
            if (host.equalsIgnoreCase("localhost") ||
                host.equals("127.0.0.1") ||
                host.equals("0.0.0.0") ||
                host.equals("::1") ||
                host.matches("^\\d{1,3}(\\.\\d{1,3}){3}$")) {
                return false;
            }

            return true;
        } catch (MalformedURLException e) {
            return false;
        }
    }
}
