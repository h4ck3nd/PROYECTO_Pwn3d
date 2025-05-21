package controller;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.security.MessageDigest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MachineDAO;

@WebServlet("/calcularMD5")
public class CalcularMD5Servlet extends HttpServlet {

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String urlArchivo = request.getParameter("url");
        String nombreMaquina = request.getParameter("maquina");

        try {
            // Descargar archivo
            URL url = new URL(urlArchivo);
            InputStream input = url.openStream();

            // Calcular MD5
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                md.update(buffer, 0, bytesRead);
            }

            byte[] digest = md.digest();
            StringBuilder md5Hex = new StringBuilder();
            for (byte b : digest) {
                md5Hex.append(String.format("%02x", b));
            }

            input.close();

            // Actualizar en BBDD
            MachineDAO dao = new MachineDAO();
            boolean ok = dao.actualizarMD5(nombreMaquina, md5Hex.toString());

            request.setAttribute("resultado", ok ? "MD5 actualizado correctamente." : "Error al actualizar la BBDD.");
            request.setAttribute("md5", md5Hex.toString());

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("resultado", "Error al procesar el archivo.");
        }

        request.getRequestDispatcher("/agregarVM.jsp").forward(request, response);
    }
}
