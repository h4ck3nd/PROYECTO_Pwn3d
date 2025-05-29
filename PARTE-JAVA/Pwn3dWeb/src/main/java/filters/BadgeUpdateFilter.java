package filters;

import service.BadgeService;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class BadgeUpdateFilter implements Filter {

    private final BadgeService badgeService = new BadgeService();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);

        if (session != null && session.getAttribute("userId") != null) {
            int userId = (int) session.getAttribute("userId");

            try {
                badgeService.checkAndUpdateBadges(userId);  // ✅ Usa el servicio completo
            } catch (Exception e) {
                e.printStackTrace(); // Loguear si algo va mal
            }
        }

        chain.doFilter(request, response);
    }
}
