package controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DBAdminDAO;

@WebServlet("/TablaController")
public class DBAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        String tabla = request.getParameter("tabla");

        if (tabla == null || tabla.isEmpty() || accion == null) {
            response.sendRedirect(request.getContextPath() + "/paginasDeAdministracioneWeb/adminDB.jsp");
            return;
        }

        // Detectar la clave primaria
        String clavePrimaria = "id";
        if ("laboratorios".equalsIgnoreCase(tabla)) {
            clavePrimaria = "lab_id";
        }

        DBAdminDAO dao = new DBAdminDAO();
        Map<String, String[]> parametros = request.getParameterMap();
        Map<String, String> valores = new LinkedHashMap<>();

        for (Map.Entry<String, String[]> entry : parametros.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue()[0];

            if (!key.equals("accion") && !key.equals("tabla")) {
                valores.put(key, value);
            }
        }

        try {
            switch (accion) {
                case "insert":
                    dao.insertar(tabla, valores);
                    break;
                case "update":
                    dao.actualizar(tabla, valores, valores.get(clavePrimaria));
                    break;
                case "delete":
                    dao.eliminar(tabla, clavePrimaria, valores.get(clavePrimaria));
                    break;
                default:
                    throw new IllegalArgumentException("Acción no reconocida: " + accion);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Puedes registrar en un logger si prefieres
        }

        // Redirigir de vuelta a la gestión de la tabla actual
        response.sendRedirect(request.getContextPath() + "/paginasDeAdministracioneWeb/adminDB.jsp?tabla=" + tabla);
    }
}
