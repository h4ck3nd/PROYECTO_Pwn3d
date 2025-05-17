package filters;

import dao.UserDAO;
import model.User;
import utils.JWTUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class SecurityFilter implements Filter {

    private UserDAO userDao;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        userDao = new UserDAO();
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String path = request.getRequestURI().substring(request.getContextPath().length());

        // Exclusiones: no filtrar login.jsp, login servlet, recursos estáticos, etc.
        if (path.startsWith("/login-register/login.jsp")
                || path.startsWith("/login")
                || path.startsWith("/login-register/register.jsp")
                || path.startsWith("/logout")
                || path.startsWith("/register")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            redirectToLogin(request, response);
            return;
        }
        Integer sessionUserId = (Integer) session.getAttribute("userId");

        // Obtener cookie "token"
        String token = null;
        if (request.getCookies() != null) {
            for (Cookie c : request.getCookies()) {
                if ("token".equals(c.getName())) {
                    token = c.getValue();
                    break;
                }
            }
        }

        if (token == null || token.isEmpty()) {
            invalidateAndRedirect(sessionUserId, request, response);
            return;
        }

        try {
            boolean validToken = JWTUtil.validateToken(token);
            if (!validToken) {
                invalidateAndRedirect(sessionUserId, request, response);
                return;
            }

            Integer tokenUserId = JWTUtil.getUserIdFromToken(token);

            if (tokenUserId == null || !tokenUserId.equals(sessionUserId)) {
                invalidateAndRedirect(sessionUserId, request, response);
                return;
            }

            User userFromDB = userDao.getUserById(sessionUserId);
            if (userFromDB == null) {
                invalidateAndRedirect(sessionUserId, request, response);
                return;
            }

            String tokenDB = userFromDB.getCookie();

            if (tokenDB == null || !tokenDB.equals(token)) {
                invalidateAndRedirect(sessionUserId, request, response);
                return;
            }

            // Token válido, continuar
            chain.doFilter(request, response);

        } catch (Exception ex) {
            invalidateAndRedirect(sessionUserId, request, response);
        }
    }

    private void invalidateAndRedirect(Integer userId, HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (userId != null) {
            userDao.updateUserToken(userId, null);  // Borra token en BD
        }

        Cookie cookie = new Cookie("token", "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        redirectToLogin(request, response);
    }

    private void redirectToLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Aquí está la clave para evitar URLs repetidas
        response.sendRedirect(request.getContextPath() + "/login-register/login.jsp");
    }

    @Override
    public void destroy() {}
}
