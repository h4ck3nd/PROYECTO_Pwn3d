package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.EditProfileDAO;
import model.EditProfile;

@WebServlet("/manageSocialLinks")
public class ManageSocialLinksServlet extends HttpServlet {
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        EditProfileDAO dao = new EditProfileDAO();

        try {
            switch (action) {
                case "add":
                    String title = request.getParameter("title");
                    String url = request.getParameter("url");
                    String icon = request.getParameter("icon");

                    EditProfile newLink = new EditProfile();
                    newLink.setUserId(userId);
                    newLink.setTitleSocial(title);
                    newLink.setUrlSocial(url);
                    newLink.setSocialIcon(icon);
                    newLink.setEstado("Privado");

                    boolean added = dao.insertLink(newLink);

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    if (added && newLink.getId() > 0) {
                        response.getWriter().write("{\"id\":" + newLink.getId() + "}");
                    } else {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write("{\"error\":\"No se pudo insertar\"}");
                    }
                    break;

                case "delete":
                    int id = Integer.parseInt(request.getParameter("id"));
                    boolean deleted = dao.deleteLink(id, userId);

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    if (deleted) {
                        response.getWriter().write("{\"status\":\"ok\"}");
                    } else {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write("{\"error\":\"No se pudo eliminar\"}");
                    }
                    break;
                case "updateAllEstados":
                    String nuevoEstado = request.getParameter("nuevoEstado");
                    boolean success = dao.updateAllEstadosByUserId(userId, nuevoEstado);
                    response.setStatus(success ? 200 : 500);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
            e.printStackTrace();
        } finally {
            dao.cerrarConexion();
        }
    }
}
