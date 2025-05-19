package controlador;

import javax.servlet.*;
import javax.servlet.annotation.WebListener;
import java.io.*;
import java.util.concurrent.*;

@WebListener
public class AutoCleanerListenerControlador implements ServletContextListener {

    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String rutaUsuarios = sce.getServletContext().getRealPath("/labs/retroGame/users.txt");
        String rutaContrasenas = sce.getServletContext().getRealPath("/labs/retroGame/pass.txt");

        scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.scheduleAtFixedRate(() -> {
            try {
                new PrintWriter(rutaUsuarios).close();
                new PrintWriter(rutaContrasenas).close();
                System.out.println("[INFO] Diccionarios limpiados automáticamente.");
            } catch (IOException e) {
                System.err.println("[ERROR] Error limpiando archivos: " + e.getMessage());
            }
        }, 5, 5, TimeUnit.MINUTES);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null && !scheduler.isShutdown()) {
            scheduler.shutdown();
        }
    }
}
