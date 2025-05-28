package dao;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import conexionDDBB.ConexionDDBB;

public class DBAdminDAO {

    // Normaliza el string timestamp para que pueda ser parseado
    private String normalizarTimestamp(String val) {
        if (val == null || val.isEmpty()) {
			return null;
		}

        val = val.replace('T', ' ');

        // Añade segundos si sólo tiene hasta minutos: "yyyy-MM-dd HH:mm"
        if (val.matches("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}$")) {
            val += ":00";
        }

        // Limita las fracciones de segundo a 9 dígitos (nanosegundos)
        if (val.contains(".")) {
            String[] parts = val.split("\\.");
            if (parts.length == 2) {
                String nano = parts[1];
                if (nano.length() > 9) {
                    nano = nano.substring(0, 9);
                    val = parts[0] + "." + nano;
                }
            }
        }
        return val;
    }

    // Formateador para LocalDateTime con fracciones opcionales
    private static final DateTimeFormatter FORMATTER =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss[.n]");

    public List<String> getListaTablas() {
        List<String> tablas = new ArrayList<>();
        try (Connection conn = new ConexionDDBB().conectar();
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
        try (Connection conn = new ConexionDDBB().conectar();
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
        try (Connection conn = new ConexionDDBB().conectar();
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
        // Filtrar columnas con valor no nulo y no vacío para el INSERT
        Map<String, String> valoresNoNulos = new LinkedHashMap<>();
        for (Map.Entry<String, String> entry : valores.entrySet()) {
            String val = entry.getValue();
            if (val != null && !val.isEmpty() && !val.equalsIgnoreCase("null")) {
                valoresNoNulos.put(entry.getKey(), val);
            }
            // Si quieres, puedes imprimir columnas omitidas aquí para debug
        }

        // Construir SQL sólo con columnas que tienen valor para insertar
        StringBuilder sql = new StringBuilder("INSERT INTO ").append(tabla).append(" (");
        StringBuilder placeholders = new StringBuilder();

        for (String col : valoresNoNulos.keySet()) {
            sql.append(col).append(",");
            placeholders.append("?").append(",");
        }

        if (valoresNoNulos.isEmpty()) {
            // No se pueden insertar sin columnas, lanzar excepción o manejar error
            throw new IllegalArgumentException("No hay valores para insertar");
        }

        sql.setLength(sql.length() - 1);
        placeholders.setLength(placeholders.length() - 1);
        sql.append(") VALUES (").append(placeholders).append(")");

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            DatabaseMetaData meta = conn.getMetaData();
            ResultSet rsCols = meta.getColumns(null, null, tabla, null);
            Map<String, Integer> tipos = new HashMap<>();
            while (rsCols.next()) {
                tipos.put(rsCols.getString("COLUMN_NAME"), rsCols.getInt("DATA_TYPE"));
            }

            int i = 1;
            for (String col : valoresNoNulos.keySet()) {
                String val = valoresNoNulos.get(col);
                int tipo = tipos.getOrDefault(col, Types.VARCHAR);

                switch (tipo) {
                    case Types.INTEGER:
                        ps.setInt(i++, Integer.parseInt(val));
                        break;
                    case Types.BOOLEAN:
                        ps.setBoolean(i++, Boolean.parseBoolean(val));
                        break;
                    case Types.DOUBLE:
                    case Types.DECIMAL:
                    case Types.NUMERIC:
                        ps.setDouble(i++, Double.parseDouble(val));
                        break;
                    case Types.TIMESTAMP:
                        val = normalizarTimestamp(val);
                        LocalDateTime ldt = LocalDateTime.parse(val, FORMATTER);
                        ps.setTimestamp(i++, Timestamp.valueOf(ldt));
                        break;
                    default:
                        ps.setString(i++, val);
                        break;
                }
            }
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void eliminar(String tabla, String columnaClave, String valorClave) {
        if ("laboratorios".equalsIgnoreCase(tabla)) {
			columnaClave = "lab_id";
		}

        String sql = "DELETE FROM " + tabla + " WHERE " + columnaClave + " = ?";
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet rsCols = meta.getColumns(null, null, tabla, null);
            int tipo = Types.VARCHAR;
            while (rsCols.next()) {
                if (rsCols.getString("COLUMN_NAME").equalsIgnoreCase(columnaClave)) {
                    tipo = rsCols.getInt("DATA_TYPE");
                    break;
                }
            }
            switch (tipo) {
                case Types.INTEGER:
                    ps.setInt(1, Integer.parseInt(valorClave));
                    break;
                case Types.BOOLEAN:
                    ps.setBoolean(1, Boolean.parseBoolean(valorClave));
                    break;
                case Types.DOUBLE:
                case Types.DECIMAL:
                case Types.NUMERIC:
                    ps.setDouble(1, Double.parseDouble(valorClave));
                    break;
                default:
                    ps.setString(1, valorClave);
                    break;
            }
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void actualizar(String tabla, Map<String, String> valores, String valorClave) {
        String columnaClave = "id";
        if ("laboratorios".equalsIgnoreCase(tabla)) {
			columnaClave = "lab_id";
		}

        StringBuilder sql = new StringBuilder("UPDATE ").append(tabla).append(" SET ");
        for (String col : valores.keySet()) {
            sql.append(col).append(" = ?,");
        }
        sql.setLength(sql.length() - 1);
        sql.append(" WHERE ").append(columnaClave).append(" = ?");

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet rsCols = meta.getColumns(null, null, tabla, null);
            Map<String, Integer> tipos = new HashMap<>();
            while (rsCols.next()) {
                tipos.put(rsCols.getString("COLUMN_NAME"), rsCols.getInt("DATA_TYPE"));
            }

            int i = 1;
            for (String col : valores.keySet()) {
                String val = valores.get(col);
                int tipo = tipos.getOrDefault(col, Types.VARCHAR);

                if (val == null || val.isEmpty() || val.equalsIgnoreCase("null")) {
                    ps.setNull(i++, tipo);
                } else {
                    switch (tipo) {
                        case Types.INTEGER:
                            ps.setInt(i++, Integer.parseInt(val));
                            break;
                        case Types.BOOLEAN:
                            ps.setBoolean(i++, Boolean.parseBoolean(val));
                            break;
                        case Types.DOUBLE:
                        case Types.DECIMAL:
                        case Types.NUMERIC:
                            ps.setDouble(i++, Double.parseDouble(val));
                            break;
                        case Types.TIMESTAMP:
                            val = normalizarTimestamp(val);
                            LocalDateTime ldt = LocalDateTime.parse(val, FORMATTER);
                            ps.setTimestamp(i++, Timestamp.valueOf(ldt));
                            break;
                        default:
                            ps.setString(i++, val);
                            break;
                    }
                }
            }

            // Valor clave en WHERE
            int tipoClave = tipos.getOrDefault(columnaClave, Types.VARCHAR);
            switch (tipoClave) {
                case Types.INTEGER:
                    ps.setInt(i, Integer.parseInt(valorClave));
                    break;
                case Types.BOOLEAN:
                    ps.setBoolean(i, Boolean.parseBoolean(valorClave));
                    break;
                case Types.DOUBLE:
                case Types.DECIMAL:
                case Types.NUMERIC:
                    ps.setDouble(i, Double.parseDouble(valorClave));
                    break;
                default:
                    ps.setString(i, valorClave);
                    break;
            }

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
