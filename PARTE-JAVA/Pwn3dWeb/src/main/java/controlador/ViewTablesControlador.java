package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conexionDDBB.ConexionDDBB;

@WebServlet("/getTables")
public class ViewTablesControlador extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ConexionDDBB conexion = new ConexionDDBB();
        List<String> tables = new ArrayList<>();
        StringBuilder tableHtml = new StringBuilder();
        
        try (Connection conn = conexion.conectar()) {
            DatabaseMetaData metaData = conn.getMetaData();
            ResultSet rs = metaData.getTables(null, null, "%", new String[]{"TABLE"});
            
            // Obtener todas las tablas
            while (rs.next()) {
                String tableName = rs.getString("TABLE_NAME");
                tables.add(tableName);
            }

            // Construir el HTML para cada tabla
            for (String table : tables) {
                tableHtml.append("<div class=\"table-container\">")
                          .append("<h3>Tabla: ").append(table).append("</h3>")
                          .append("<table><thead><tr>");
                
                // Obtener las columnas de la tabla
                ResultSet columns = conn.getMetaData().getColumns(null, null, table, null);
                List<String> columnNames = new ArrayList<>();
                while (columns.next()) {
                    columnNames.add(columns.getString("COLUMN_NAME"));
                    tableHtml.append("<th>").append(columns.getString("COLUMN_NAME")).append("</th>");
                }

                tableHtml.append("</tr></thead><tbody>");

                // Obtener los datos de la tabla
                Statement stmt = conn.createStatement();
                ResultSet data = stmt.executeQuery("SELECT * FROM " + table);
                while (data.next()) {
                    tableHtml.append("<tr>");
                    for (String column : columnNames) {
                        tableHtml.append("<td>").append(data.getString(column)).append("</td>");
                    }
                    tableHtml.append("</tr>");
                }
                tableHtml.append("</tbody></table></div>");
            }
            
            // Enviar el HTML con las tablas
            response.setContentType("text/html");
            response.getWriter().write(tableHtml.toString());
            
        } catch (SQLException e) {
            response.getWriter().write("<p>Error al obtener las tablas o los datos.</p>");
            e.printStackTrace();
        }
    }
}