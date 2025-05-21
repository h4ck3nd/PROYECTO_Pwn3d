package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ImgProfileDAO;
import io.jsonwebtoken.io.IOException;
import model.ImgProfile;
import model.User;

@WebServlet("/perfilImg")
public class PerfilImgServlet extends HttpServlet {
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, java.io.IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login-register/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login-register/login.jsp");
            return;
        }

        ImgProfileDAO imgDao = new ImgProfileDAO();
        ImgProfile img = imgDao.getImgProfileByUserId(user.getId());

        String imgSrc;
        if (img != null && img.getPathImg() != null && !img.getPathImg().isEmpty()) {
            imgSrc = request.getContextPath() + "/" + img.getPathImg();
        } else {
            imgSrc = request.getContextPath() + "/imgProfile/default.png";
        }

        // Pasamos todo a JSP con atributos
        request.setAttribute("user", user);
        request.setAttribute("imgSrc", imgSrc);

        // Forward a JSP
        request.getRequestDispatcher("/perfil").forward(request, response);
    }
}

