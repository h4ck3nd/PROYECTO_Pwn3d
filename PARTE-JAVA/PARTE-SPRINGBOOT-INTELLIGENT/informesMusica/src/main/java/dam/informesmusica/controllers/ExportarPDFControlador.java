package dam.informesmusica.controllers;

import dam.informesmusica.conexionDDBB.ConexionDDBB;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

@RestController
public class ExportarPDFControlador {

    @GetMapping("/exportarPDF")
    public ResponseEntity<byte[]> exportarPDF(
            @RequestParam("user_id") int userId,
            @RequestParam("usuarioNombre") String nombre,
            @RequestParam("usuarioApellidos") String apellidos,
            @RequestParam("usuarioEmail") String email
    ) {
        ConexionDDBB conexionDDBB = new ConexionDDBB();

        try (Connection conn = conexionDDBB.conectar();
             FileInputStream jasperStream = new FileInputStream("C:/Users/clipd/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ProyectoMaven/reports/reportFlags.jasper")) {

            Map<String, Object> parametros = new HashMap<>();
            parametros.put("USER_ID", userId);
            parametros.put("USUARIO_NOMBRE", nombre);
            parametros.put("USUARIO_APELLIDOS", apellidos);
            parametros.put("USUARIO_EMAIL", email);

            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperStream, parametros, conn);

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            JasperExportManager.exportReportToPdfStream(jasperPrint, baos);

            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_PDF)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=InformeUsuario.pdf")
                    .body(baos.toByteArray());

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError()
                    .body(("Error generando PDF: " + e.getMessage()).getBytes());
        }
    }
}
