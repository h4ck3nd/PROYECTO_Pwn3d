package createTomcat;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.io.File;

@WebListener
public class AppStartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String tomcatBase = System.getProperty("catalina.base");
        File uploadDir = new File(tomcatBase, "imgProfile");
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
            System.out.println("[AppStartupListener] Carpeta imgProfile creada: " + created + " en " + uploadDir.getAbsolutePath());
        } else {
            System.out.println("[AppStartupListener] Carpeta imgProfile ya existe en " + uploadDir.getAbsolutePath());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Nada que hacer al destruir contexto
    }
}
