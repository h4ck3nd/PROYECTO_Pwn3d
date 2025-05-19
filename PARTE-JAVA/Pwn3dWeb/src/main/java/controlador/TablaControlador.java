package controlador;

import dao.TablaDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/TablaController")
public class TablaControlador extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tabla = request.getParameter("tabla");
        String accion = request.getParameter("accion");
        TablaDAO dao = new TablaDAO();

        Map<String, String> valores = new HashMap<>();
        Enumeration<String> nombres = request.getParameterNames();
        while (nombres.hasMoreElements()) {
            String param = nombres.nextElement();
            if (!param.equals("accion") && !param.equals("tabla")) {
                valores.put(param, request.getParameter(param));
            }
        }

        // Determinamos la columna clave según el nombre de la tabla
        String columnaClave = "id"; // Valor predeterminado
        if ("laboratorios".equalsIgnoreCase(tabla)) {
            columnaClave = "lab_id";  // Si la tabla es 'laboratorios', la columna clave es 'lab_id'
        }

        switch (accion) {
            case "insert":
                dao.insertar(tabla, valores);
                break;
            case "delete":
                String valorClave = valores.get(columnaClave); // Obtén el valor de la clave primaria
                if (valorClave != null) {
                    dao.eliminar(tabla, columnaClave, valorClave); // Llamamos a eliminar pasando la tabla, columna clave y valor clave
                } else {
                    response.getWriter().write("No se ha proporcionado el valor de la clave primaria para eliminar.");
                    return;
                }
                break;
            case "update":
                String valorClaveUpdate = request.getParameter(columnaClave); // Obtén la clave primaria
                if (valorClaveUpdate != null) {
                    Map<String, String> valoresUpdate = new HashMap<>();
                    
                    // Extraer los parámetros del formulario, excepto la clave primaria, tabla y acción
                    Enumeration<String> nombresUpdate = request.getParameterNames();
                    while (nombresUpdate.hasMoreElements()) {
                        String param = nombresUpdate.nextElement();
                        if (!param.equals("accion") && !param.equals("tabla") && !param.equals(columnaClave)) {
                            valoresUpdate.put(param, request.getParameter(param));
                        }
                    }

                    dao.actualizar(tabla, valoresUpdate, valorClaveUpdate); // Llamada al método actualizar
                } else {
                    response.getWriter().write("No se proporcionó la clave primaria para la actualización.");
                }
                break;
        }

        response.sendRedirect("designer/manageTables.jsp?tabla=" + tabla);
    }
}
