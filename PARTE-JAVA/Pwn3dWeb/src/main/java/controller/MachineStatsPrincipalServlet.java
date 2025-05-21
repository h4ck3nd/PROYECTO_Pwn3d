package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MachineDAO;
import utils.JWTUtil;

@WebServlet("/machines-stats-principal")
public class MachineStatsPrincipalServlet extends HttpServlet {

    private MachineDAO machineDAO;

    @Override
    public void init() throws ServletException {
        machineDAO = new MachineDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, Integer> countsByDifficulty = machineDAO.getMachinesCountByDifficulty2();
        int totalMachines = countsByDifficulty.values().stream().mapToInt(Integer::intValue).sum();

        int pwnedMachines = 0;
        Map<String, Integer> hackedByDifficulty = new HashMap<>();

        Cookie[] cookies = request.getCookies();
        String token = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token != null && JWTUtil.validateToken(token)) {
            Integer userId = JWTUtil.getUserIdFromToken(token);
            if (userId != null) {
                hackedByDifficulty = machineDAO.getHackedMachinesCountByDifficulty(userId);
                for (int value : hackedByDifficulty.values()) {
                    pwnedMachines += value;
                }
            }
        }

        // Construcción del JSON
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"totalMachines\":").append(totalMachines).append(",");
        json.append("\"pwnedMachines\":").append(pwnedMachines).append(",");

        // countsByDifficulty
        json.append("\"countsByDifficulty\":{");
        boolean first = true;
        for (Map.Entry<String, Integer> entry : countsByDifficulty.entrySet()) {
            if (!first) {
				json.append(",");
			}
            json.append("\"").append(entry.getKey()).append("\":").append(entry.getValue());
            first = false;
        }
        json.append("},");

        // hackedByDifficulty
        json.append("\"hackedByDifficulty\":{");
        first = true;
        for (Map.Entry<String, Integer> entry : hackedByDifficulty.entrySet()) {
            if (!first) {
				json.append(",");
			}
            json.append("\"").append(entry.getKey()).append("\":").append(entry.getValue());
            first = false;
        }
        json.append("}");

        json.append("}");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json.toString());
    }
}

