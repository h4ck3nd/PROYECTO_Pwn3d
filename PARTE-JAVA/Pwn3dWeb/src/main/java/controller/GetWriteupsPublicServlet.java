package controller;

import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.WriteupDAO;
import io.jsonwebtoken.io.IOException;
import model.Writeup;

@WebServlet("/getWriteupsPublic")
public class GetWriteupsPublicServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, java.io.IOException {

        String vmName = request.getParameter("vmName");
        WriteupDAO dao = new WriteupDAO();

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            List<Writeup> publicados = dao.getWriteupsPublicByVmName(vmName); // método que filtra por vmName

            out.print("[");
            for (int i = 0; i < publicados.size(); i++) {
                Writeup w = publicados.get(i);

                String safeVmName = w.getVmName().replace("\"", "\\\"");
                String safeCreator = w.getCreator().replace("\"", "\\\"");
                String safeUrl = w.getUrl().replace("\"", "\\\"");
                String safeType = w.getContentType().replace("\"", "\\\"");
                String safeLanguage = w.getLanguage() != null ? w.getLanguage().replace("\"", "\\\"") : "";

                out.print("{");
                out.print("\"name\": \"" + safeVmName + "\",");
                out.print("\"creator\": \"" + safeCreator + "\",");
                out.print("\"url\": \"" + safeUrl + "\",");
                out.print("\"contentType\": \"" + safeType + "\",");
                out.print("\"language\": \"" + safeLanguage + "\"");
                out.print("}");

                if (i < publicados.size() - 1) {
                    out.print(",");
                }
            }
            out.print("]");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            out.close();
        }
    }
}
