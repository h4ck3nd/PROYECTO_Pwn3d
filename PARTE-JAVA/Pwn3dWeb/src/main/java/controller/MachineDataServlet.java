package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/submitMachineData")
public class MachineDataServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener datos del formulario
        String id = request.getParameter("id");
        String nameMachine = request.getParameter("name_machine");
        String size = request.getParameter("size");
        String os = request.getParameter("os");
        String enviroment = request.getParameter("enviroment");
        String creator = request.getParameter("creator");
        String difficulty = request.getParameter("difficulty");
        String date = request.getParameter("date");
        String md5 = request.getParameter("md5");
        String writeupUrl = request.getParameter("writeup_url");
        String firstUser = request.getParameter("first_user");
        String firstRoot = request.getParameter("first_root");
        String imgNameOs = request.getParameter("img_name_os");
        String downloadUrl = request.getParameter("download_url");

        // Pasar los datos al JSP
        request.setAttribute("id", id);
        request.setAttribute("name_machine", nameMachine);
        request.setAttribute("size", size);
        request.setAttribute("os", os);
        request.setAttribute("enviroment", enviroment);
        request.setAttribute("creator", creator);
        request.setAttribute("difficulty", difficulty);
        request.setAttribute("date", date);
        request.setAttribute("md5", md5);
        request.setAttribute("writeup_url", writeupUrl);
        request.setAttribute("first_user", firstUser);
        request.setAttribute("first_root", firstRoot);
        request.setAttribute("img_name_os", imgNameOs);
        request.setAttribute("download_url", downloadUrl);

        // Redirigir al JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/machines.jsp");
        dispatcher.forward(request, response);
    }
}
