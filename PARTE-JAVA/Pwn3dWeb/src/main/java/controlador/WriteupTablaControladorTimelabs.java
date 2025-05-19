package controlador;

import dao.WriteupUserDAO;
import modelo.Writeup;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/verWriteupsTimelabs")
public class WriteupTablaControladorTimelabs extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int labId = Integer.parseInt(request.getParameter("lab_id"));
        List<Writeup> writeups = WriteupUserDAO.obtenerWriteupsPorLabIdTimelabs(labId);

        request.setAttribute("writeups", writeups);
        request.getRequestDispatcher("/tablaWriteups.jsp").forward(request, response);
    }
}