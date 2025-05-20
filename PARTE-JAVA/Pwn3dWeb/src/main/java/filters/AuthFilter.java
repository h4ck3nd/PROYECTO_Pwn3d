package filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import utils.JWTUtil;

@WebFilter("/*")
public class AuthFilter implements Filter {
    @Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        boolean isExcluded =
                uri.startsWith(contextPath + "/login-register/login.jsp") ||
                uri.startsWith(contextPath + "/login-register/register.jsp") ||
                uri.startsWith(contextPath + "/login") ||
                uri.startsWith(contextPath + "/img") ||
                uri.startsWith(contextPath + "/register") ||
                uri.startsWith(contextPath + "/reset-password") ||
                uri.startsWith(contextPath + "/cambiarPassword") ||
                uri.startsWith(contextPath + "/logout");

        if (isExcluded) {
            chain.doFilter(request, response);
            return;
        }

        Cookie[] cookies = req.getCookies();
        String token = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token != null) {
            Integer userId = JWTUtil.getUserIdFromToken(token);

            if (JWTUtil.validateToken(token)) {
                chain.doFilter(request, response);
                return;
            } else {
                if (userId != null) {
                    new UserDAO().clearUserTokenByUserId(userId);
                }

                Cookie expiredCookie = new Cookie("token", "");
                expiredCookie.setMaxAge(0);
                expiredCookie.setPath("/");
                expiredCookie.setHttpOnly(true);
                res.addCookie(expiredCookie);

                HttpSession session = req.getSession(false);
                if (session != null) {
                    session.invalidate();
                }

                res.sendRedirect(contextPath + "/login-register/login.jsp");
                return;
            }
        } else {
            // No hay token, intentar limpiar con userId de sesión antes de redirigir a /logout
            HttpSession session = req.getSession(false);
            if (session != null) {
                Integer userId = (Integer) session.getAttribute("userId");
                if (userId != null) {
                    new UserDAO().clearUserTokenByUserId(userId);
                }
                session.invalidate();
            }

            res.sendRedirect(contextPath + "/logout");
        }
    }
}
