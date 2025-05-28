package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.NoticeDAO;
import model.Notice;

@WebServlet("/addNotice")
public class NoticeController extends HttpServlet {

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vmName = request.getParameter("vm_name");
        String date = request.getParameter("date");
        String creator = request.getParameter("creator");
        String secondVmName = request.getParameter("second_vm_name");
        String secondDate = request.getParameter("second_date");
        String secondCreator = request.getParameter("second_creator");
        String descriptionPage = request.getParameter("description_page");

        // El nuevo estado será "new"
        String estado = "new";

        Notice notice = new Notice(vmName, date, creator, secondVmName, secondDate, secondCreator, descriptionPage, estado);
        NoticeDAO dao = new NoticeDAO();

        try {
            dao.addNotice(notice);
            HttpSession session = request.getSession();
            session.setAttribute("message", "Noticia añadida correctamente");
        } catch (SQLException e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("error", "Error al añadir la noticia");
        }
        response.sendRedirect("paginasDeAdministracioneWeb/addNotice.jsp");

    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
