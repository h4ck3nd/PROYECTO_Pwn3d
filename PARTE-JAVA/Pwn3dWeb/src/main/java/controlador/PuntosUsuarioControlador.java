package controlador;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.PuntosDAO;

import java.io.*;
import java.sql.SQLException;

@WebServlet("/obtener-puntos")
public class PuntosUsuarioControlador extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID del usuario desde el formulario oculto
        String userIdStr = request.getParameter("userId");

        if (userIdStr != null) {
            try {
            	//============================================SECCIONES DE LABS========================================================
                // Convertir el ID a Integer
                int userId = Integer.parseInt(userIdStr);

                // Crear el objeto DAO y obtener los puntos de Hacking Web
                PuntosDAO puntosDAO = new PuntosDAO();
                int puntosHackingWeb = puntosDAO.obtenerPuntosHackingWeb(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosHackingWeb", puntosHackingWeb);
                
                // Crear el objeto DAO y obtener los puntos de DockerPwned
                int puntosDockerPwned = puntosDAO.obtenerPuntosDockerPwned(userId);
                
                // Pasar los puntos al JSP
                request.setAttribute("puntosDockerPwned", puntosDockerPwned);
                
                // Crear el objeto DAO y obtener los puntos de OvaLabs
                int puntosOvaLabs = puntosDAO.obtenerPuntosOvaLabs(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosOvaLabs", puntosOvaLabs);
                
                // Crear el objeto DAO y obtener los puntos de Timelabs
                int puntosTimelabs = puntosDAO.obtenerPuntosTimelabs(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosTimelabs", puntosTimelabs);
                
             	//============================================SECCIONES DE LABS TOTALES========================================================
                
                // También obtener los puntos totales del laboratorio 1
                int puntosTotalesLab1 = puntosDAO.obtenerPuntosTotalesDeLab1();
                request.setAttribute("puntosTotalesLab1", puntosTotalesLab1);
                
                // También obtener los puntos totales del laboratorio 2
                int puntosTotalesLab2 = puntosDAO.obtenerPuntosTotalesDeLab2();
                request.setAttribute("puntosTotalesLab2", puntosTotalesLab2);
                
                // También obtener los puntos totales del laboratorio 3
                int puntosTotalesLab3 = puntosDAO.obtenerPuntosTotalesDeLab3();
                request.setAttribute("puntosTotalesLab3", puntosTotalesLab3);
                
                // También obtener los puntos totales del laboratorio 4
                int puntosTotalesLab4 = puntosDAO.obtenerPuntosTotalesDeLab4();
                request.setAttribute("puntosTotalesLab4", puntosTotalesLab4);
                
                //============================================LABS POR SEPARADO========================================================
                
                // Obtener Puntos del laboratorio XSS1
                int puntosXSS1 = puntosDAO.obtenerPuntosXSS1(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosXSS1", puntosXSS1);
                
                // Obtener Puntos del laboratorio SQLi1
                int puntosSQLi1 = puntosDAO.obtenerPuntosSQLi1(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosSQLi1", puntosSQLi1);
                
                // Obtener Puntos del laboratorio OR1
                int puntosOR1 = puntosDAO.obtenerPuntosCSRF1(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosOR1", puntosOR1);
                
                // Obtener Puntos del laboratorio BAC1
                int puntosBAC1 = puntosDAO.obtenerPuntosBAC1(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosBAC1", puntosBAC1);
                
                // Obtener Puntos del laboratorio XPATH
                int puntosXPATH1 = puntosDAO.obtenerPuntosXPATH1(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosXPATH1", puntosXPATH1);
                
                // Obtener Puntos del laboratorio ForceBrute
                int puntosForceBrute1 = puntosDAO.obtenerPuntosForceBrute1(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosForceBrute1", puntosForceBrute1);
                
                // Obtener Puntos del laboratorio PYZ
                int puntosPyz1 = puntosDAO.obtenerPuntosPyz1(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosPyz1", puntosPyz1);
                
                // Obtener Puntos del laboratorio PYZ
                int puntosLenguaje1 = puntosDAO.obtenerPuntosLenguaje1(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosLenguaje1", puntosLenguaje1);
                
                // Obtener Puntos del laboratorio CommandInjection
                int puntosCommandInjection1 = puntosDAO.obtenerPuntosCommandInjection1(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosCommandInjection1", puntosCommandInjection1);
                
                // PUNTOS DOCKERPWNED
                
                // Obtener Puntos del laboratorio R00tless (DockerPwned)
                int puntosR00tless = puntosDAO.obtenerPuntosR00tless(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosR00tless", puntosR00tless);
                
                // Obtener Puntos del laboratorio Crackoff (DockerPwned)
                int puntosCrackoff = puntosDAO.obtenerPuntosCrackoff(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosCrackoff", puntosCrackoff);
                
                // Obtener Puntos del laboratorio Hackmedaddy (DockerPwned)
                int puntosHackmedaddy = puntosDAO.obtenerPuntosHackmedaddy(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosHackmedaddy", puntosHackmedaddy);
                
                // PUNTOS OVALABS
                
                // Obtener Puntos del laboratorio Goodness (OvaLabs)
                int puntosGoodness = puntosDAO.obtenerPuntosGoodness(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosGoodness", puntosGoodness);
                
                // PUNTOS TIMELABS
                
                // Obtener Puntos del laboratorio CineHack (Timelabs)
                int puntosCineHack = puntosDAO.obtenerPuntosCineHack(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosCineHack", puntosCineHack);
                
                //============================================RESTO========================================================

                // Redirigir a la página JSP para mostrar los puntos
                RequestDispatcher dispatcher = request.getRequestDispatcher("/progreso.jsp");
                dispatcher.forward(request, response);

            } catch (NumberFormatException e) {
                // Manejo de error si el ID no es válido
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            } catch (SQLException e) {
                // Manejo de error en la base de datos
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        } else {
            // Manejo de error si no se encuentra el ID del usuario
            response.sendRedirect("error.jsp");
        }
    }
}
