package controller;

import com.google.gson.Gson;
import dao.FlagDAO;
import dao.ImgProfileDAO;
import model.Flag;
import model.ImgProfile;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/logsJson")
public class LogServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        FlagDAO dao = new FlagDAO();
        List<Flag> logs = dao.getAllFlags();

        ImgProfileDAO imgDao = new ImgProfileDAO();

        String contextPath = request.getContextPath();

        for (Flag log : logs) {
            ImgProfile img = imgDao.getImgProfileByUserId(log.getIdUser());
            String imgSrc;
            if (img != null && img.getPathImg() != null && !img.getPathImg().isEmpty()) {
                imgSrc = contextPath + "/" + img.getPathImg();
            } else {
                imgSrc = contextPath + "/imgProfile/default.png";
            }
            log.setImgSrc(imgSrc);
        }

        imgDao.cerrarConexion();

        String jsonLogs = new Gson().toJson(logs);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonLogs);
    }
}
