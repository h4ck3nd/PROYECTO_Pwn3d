package dao;

import conexionDDBB.ConexionDDBB;

import java.sql.*;
import java.util.*;

public class TablaDAO {

    public List<String> getListaTablas() {
        List<String> tablas = new ArrayList<>();
        ConexionDDBB conexionDDBB = new ConexionDDBB();

        try (Connection conn = conexionDDBB.conectar();
             ResultSet rs = conn.getMetaData().getTables(null, null, "%", new String[]{"TABLE"})) {

            while (rs.next()) {
                tablas.add(rs.getString("TABLE_NAME"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tablas;
    }

    public List<String> getColumnas(String tabla) {
        List<String> columnas = new ArrayList<>();
        ConexionDDBB conexionDDBB = new ConexionDDBB();

        try (Connection conn = conexionDDBB.conectar();
             ResultSet rs = conn.getMetaData().getColumns(null, null, tabla, null)) {

            while (rs.next()) {
                columnas.add(rs.getString("COLUMN_NAME"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return columnas;
    }

    public List<Map<String, String>> getDatos(String tabla) {
        List<Map<String, String>> filas = new ArrayList<>();
        ConexionDDBB conexionDDBB = new ConexionDDBB();

        try (Connection conn = conexionDDBB.conectar();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM " + tabla);
             ResultSet rs = ps.executeQuery()) {

            ResultSetMetaData meta = rs.getMetaData();
            int cols = meta.getColumnCount();

            while (rs.next()) {
                Map<String, String> fila = new HashMap<>();
                for (int i = 1; i <= cols; i++) {
                    fila.put(meta.getColumnName(i), rs.getString(i));
                }
                filas.add(fila);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return filas;
    }

    public void insertar(String tabla, Map<String, String> valores) {
        ConexionDDBB conexionDDBB = new ConexionDDBB();
        StringBuilder sql = new StringBuilder("INSERT INTO ").append(tabla).append(" (");
        StringBuilder placeholders = new StringBuilder();

        for (String col : valores.keySet()) {
            sql.append(col).append(",");
            placeholders.append("?,");
        }

        sql.setLength(sql.length() - 1);
        placeholders.setLength(placeholders.length() - 1);
        sql.append(") VALUES (").append(placeholders).append(")");

        try (Connection conn = conexionDDBB.conectar();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            // Obtener metadatos para determinar tipos reales de columnas
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet rsCols = meta.getColumns(null, null, tabla, null);

            Map<String, Integer> tiposColumna = new HashMap<>();
            while (rsCols.next()) {
                tiposColumna.put(rsCols.getString("COLUMN_NAME"), rsCols.getInt("DATA_TYPE"));
            }

            int i = 1;
            for (String col : valores.keySet()) {
                String valor = valores.get(col);
                int tipoSQL = tiposColumna.getOrDefault(col, Types.VARCHAR); // por defecto, VARCHAR

                switch (tipoSQL) {
                    case Types.INTEGER:
                        ps.setInt(i++, Integer.parseInt(valor));
                        break;
                    case Types.BOOLEAN:
                        ps.setBoolean(i++, Boolean.parseBoolean(valor));
                        break;
                    case Types.DOUBLE:
                    case Types.FLOAT:
                    case Types.REAL:
                    case Types.NUMERIC:
                    case Types.DECIMAL:
                        ps.setDouble(i++, Double.parseDouble(valor));
                        break;
                    default:
                        ps.setString(i++, valor);
                        break;
                }
            }

            ps.executeUpdate();

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
        }
    }

    public void eliminar(String tabla, String columnaClave, String valorClave) {
        ConexionDDBB conexionDDBB = new ConexionDDBB();

        // Si la tabla es 'laboratorios', usamos 'lab_id' como columna clave
        if (tabla.equalsIgnoreCase("laboratorios")) {
            columnaClave = "lab_id";  // Modificamos la columnaClave solo si la tabla es 'laboratorios'
        }

        String sql = "DELETE FROM " + tabla + " WHERE " + columnaClave + " = ?";

        try (Connection conn = conexionDDBB.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Verificamos que la conexión se haya establecido correctamente
            if (conn == null) {
                System.err.println("La conexión a la base de datos falló.");
                return;
            }

            // Obtener tipo de columna desde los metadatos
            DatabaseMetaData meta = conn.getMetaData();
            try (ResultSet rsCols = meta.getColumns(null, null, tabla, null)) {
                int tipoClave = Types.VARCHAR; // Tipo predeterminado si no se encuentra otro

                // Buscamos el tipo de columna
                while (rsCols.next()) {
                    if (rsCols.getString("COLUMN_NAME").equalsIgnoreCase(columnaClave)) {
                        tipoClave = rsCols.getInt("DATA_TYPE");
                        break;
                    }
                }

                // Asignamos el valor al PreparedStatement según el tipo de la columna
                switch (tipoClave) {
                    case Types.INTEGER:
                        try {
                            ps.setInt(1, Integer.parseInt(valorClave));  // Aseguramos que el valor se pueda convertir a Integer
                        } catch (NumberFormatException e) {
                            System.err.println("Error al convertir el valor a Integer: " + e.getMessage());
                            return;
                        }
                        break;
                    case Types.BOOLEAN:
                        ps.setBoolean(1, Boolean.parseBoolean(valorClave));
                        break;
                    case Types.DOUBLE:
                    case Types.FLOAT:
                    case Types.REAL:
                    case Types.NUMERIC:
                    case Types.DECIMAL:
                        try {
                            ps.setDouble(1, Double.parseDouble(valorClave));  // Aseguramos que el valor se pueda convertir a Double
                        } catch (NumberFormatException e) {
                            System.err.println("Error al convertir el valor a Double: " + e.getMessage());
                            return;
                        }
                        break;
                    default:
                        ps.setString(1, valorClave);
                        break;
                }

                // Ejecutamos la actualización (eliminación)
                ps.executeUpdate();

            } catch (SQLException e) {
                System.err.println("Error al obtener los metadatos de la base de datos: " + e.getMessage());
            }

        } catch (SQLException e) {
            System.err.println("Error al ejecutar la consulta SQL: " + e.getMessage());
        }
    }


    public void actualizar(String tabla, Map<String, String> valores, String valorClave) {
        ConexionDDBB conexionDDBB = new ConexionDDBB();
        String columnaClave = "id";  // Valor por defecto

        // Si la tabla es 'laboratorios', usamos 'lab_id'
        if (tabla.equalsIgnoreCase("laboratorios")) {
            columnaClave = "lab_id";
        }

        StringBuilder sql = new StringBuilder("UPDATE ").append(tabla).append(" SET ");

        for (String col : valores.keySet()) {
            sql.append(col).append(" = ?, ");
        }

        sql.setLength(sql.length() - 2); // quitar la última coma
        sql.append(" WHERE ").append(columnaClave).append(" = ?");

        try (Connection conn = conexionDDBB.conectar();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            // Obtener metadatos para tipos de columnas
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet rsCols = meta.getColumns(null, null, tabla, null);

            Map<String, Integer> tiposColumna = new HashMap<>();
            while (rsCols.next()) {
                tiposColumna.put(rsCols.getString("COLUMN_NAME"), rsCols.getInt("DATA_TYPE"));
            }

            int i = 1;
            for (String col : valores.keySet()) {
                String valor = valores.get(col);
                int tipoSQL = tiposColumna.getOrDefault(col, Types.VARCHAR);

                switch (tipoSQL) {
                    case Types.INTEGER:
                        ps.setInt(i++, Integer.parseInt(valor));
                        break;
                    case Types.BOOLEAN:
                        ps.setBoolean(i++, Boolean.parseBoolean(valor));
                        break;
                    case Types.DOUBLE:
                    case Types.FLOAT:
                    case Types.REAL:
                    case Types.NUMERIC:
                    case Types.DECIMAL:
                        ps.setDouble(i++, Double.parseDouble(valor));
                        break;
                    default:
                        ps.setString(i++, valor);
                        break;
                }
            }

            // Valor para la cláusula WHERE
            int tipoClave = tiposColumna.getOrDefault(columnaClave, Types.VARCHAR);
            switch (tipoClave) {
                case Types.INTEGER:
                    ps.setInt(i, Integer.parseInt(valorClave));
                    break;
                case Types.BOOLEAN:
                    ps.setBoolean(i, Boolean.parseBoolean(valorClave));
                    break;
                case Types.DOUBLE:
                case Types.FLOAT:
                case Types.REAL:
                case Types.NUMERIC:
                case Types.DECIMAL:
                    ps.setDouble(i, Double.parseDouble(valorClave));
                    break;
                default:
                    ps.setString(i, valorClave);
                    break;
            }

            ps.executeUpdate();

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
        }
    }


}
