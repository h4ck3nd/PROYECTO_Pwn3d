package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import dao.MachineDAO;

@WebServlet("/ultimaMaquina")
public class UltimaMaquinaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UltimaMaquinaServlet() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        MachineDAO dao = new MachineDAO();
        String ultimoId = dao.getUltimoId();

        JSONObject json = new JSONObject();
        json.put("ultimoId", ultimoId);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json.toString());
    }
}