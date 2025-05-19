package controller;

import dao.MachineDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/machines-stats")
public class MachineStatsServlet extends HttpServlet {

    private MachineDAO machineDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        machineDAO = new MachineDAO(); // inicializar DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, Integer> countsByDifficulty = machineDAO.getMachinesCountByDifficulty();
        int totalMachines = machineDAO.getTotalMachines();

        // Construir JSON manualmente o usando alguna librería (Gson, Jackson). Aquí manual:
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"totalMachines\":").append(totalMachines).append(",");
        json.append("\"countsByDifficulty\":{");

        boolean first = true;
        for (Map.Entry<String, Integer> entry : countsByDifficulty.entrySet()) {
            if (!first) {
                json.append(",");
            }
            json.append("\"").append(entry.getKey()).append("\":").append(entry.getValue());
            first = false;
        }
        json.append("}}");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json.toString());
    }
}
