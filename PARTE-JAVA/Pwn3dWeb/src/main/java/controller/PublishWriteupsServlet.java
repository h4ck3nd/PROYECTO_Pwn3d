package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.WriteupDAO;
import model.Writeup;

@WebServlet("/addWriteupsPublish")
public class PublishWriteupsServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        WriteupDAO dao = new WriteupDAO();
        response.setContentType("application/javascript");
        PrintWriter out = response.getWriter();

        try {
            List<Writeup> pendientes = dao.getPendingWriteups();

            for (Writeup w : pendientes) {
                dao.publishWriteup(w);
                out.println("writeupObj = {");
                out.println("  name: \"" + w.getVmName() + "\",");
                out.println("  creator: \"" + w.getCreator() + "\",");
                out.println("  url: \"" + w.getUrl() + "\",");
                out.println("  contentType: \"" + w.getContentType() + "\"");
                out.println("};");
                out.println("writeupsArr.push(writeupObj);");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
