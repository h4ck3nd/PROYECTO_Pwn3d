package controller;

import utils.JWTUtil;
import io.jsonwebtoken.Claims;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/perfil")
public class PerfilServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    Cookie[] cookies = request.getCookies();
	    String token = null;

	    if (cookies != null) {
	        for (Cookie c : cookies) {
	            if (c.getName().equals("token")) {
	                token = c.getValue();
	                break;
	            }
	        }
	    }

	    if (token != null && JWTUtil.validateToken(token)) {
	        Map<String, Object> claims = JWTUtil.getAllClaims(token);
	        if (claims != null) {
	            for (Map.Entry<String, Object> entry : claims.entrySet()) {
	                request.setAttribute(entry.getKey(), entry.getValue() != null ? entry.getValue().toString() : null);
	            }
	            request.setAttribute("identity", JWTUtil.getTokenIdentity(token));
	        }
	        request.getRequestDispatcher("profile/editarProfile.jsp").forward(request, response);
	    } else {
	        response.sendRedirect("login-register/login.jsp");
	    }
	}
}