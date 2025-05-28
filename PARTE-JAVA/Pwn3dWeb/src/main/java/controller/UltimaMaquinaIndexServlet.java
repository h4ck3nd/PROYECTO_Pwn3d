package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import dao.MachineDAO;

@WebServlet("/ultimaMaquinaIndex")
public class UltimaMaquinaIndexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UltimaMaquinaIndexServlet() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            MachineDAO dao = new MachineDAO();
            String ultimoId = dao.getUltimoId();

            JSONObject json = dao.getMachineById(ultimoId); // ← aquí usamos el nuevo método
            json.put("id", ultimoId); // opcional si también quieres enviar el ID

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json.toString());
        }
    }