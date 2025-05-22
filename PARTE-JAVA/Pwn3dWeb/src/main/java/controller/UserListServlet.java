package controller;

import com.google.gson.Gson;
import dao.UserDAO;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/users")
public class UserListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Validación de token opcional aquí si lo deseas
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        UserDAO dao = new UserDAO();
        List<User> users = dao.getAllUsers();

        String json = new Gson().toJson(users);
        response.getWriter().write(json);
    }
}
