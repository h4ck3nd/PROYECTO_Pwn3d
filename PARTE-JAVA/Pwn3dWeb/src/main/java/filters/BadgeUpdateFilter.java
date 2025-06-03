package filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import service.BadgeService;

@WebFilter("/*")
public class BadgeUpdateFilter implements Filter {

    private final BadgeService badgeService = new BadgeService();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpReq = (HttpServletRequest) request;
        String contextPath = httpReq.getContextPath();
        String path = httpReq.getRequestURI();
        System.out.println("DEBUG: path = " + path);
        HttpSession session = httpReq.getSession(false);

     // ✅ Excluir rutas específicas que incluyan el contextPath
        if (path.startsWith(contextPath + "/css/") ||
            path.startsWith(contextPath + "/js/") ||
            path.startsWith(contextPath + "/img/") ||
            path.startsWith(contextPath + "/paginasDeAdministracioneWeb/") ||
            path.startsWith(contextPath + "/machineDetails/") ||
            path.startsWith(contextPath + "/feedbacks-requests/") ||
            path.startsWith(contextPath + "/fonts/") ||
            path.equals(contextPath + "/machines.jsp") ||
            path.equals(contextPath + "/ultimaMaquina") ||
            path.equals(contextPath + "/machines-stats") ||
            path.equals(contextPath + "/machines-stats-principal") ||
            path.equals(contextPath + "/machineDetails") ||
            path.equals(contextPath + "/getWriteupsPublic") ||
            path.equals(contextPath + "/requests") ||
            path.equals(contextPath + "/feedbacks") ||
            path.equals(contextPath + "/sendNewVM") ||
            path.equals(contextPath + "/submitFlag") ||
            path.equals(contextPath + "/getNotices") ||
            path.equals(contextPath + "/logsJson") ||
            path.equals(contextPath + "/ultimaMaquinaIndex") ||
            path.equals(contextPath + "/give-love") ||
            path.equals(contextPath + "/star-rating") ||
            path.equals(contextPath + "/editarPerfil") ||
            path.equals(contextPath + "/subirAvatar") ||
            path.equals(contextPath + "/actualizarPais") ||
            path.equals(contextPath + "/user-stats") ||
            path.equals(contextPath + "/ranking.jsp") ||
            path.equals(contextPath + "/infoNoticias.jsp") ||
            path.equals(contextPath + "/welcome.jsp") ||
            path.startsWith(contextPath + "/login-register/")) {

            chain.doFilter(request, response); // No aplicar lógica de badges
            return;
        }

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
