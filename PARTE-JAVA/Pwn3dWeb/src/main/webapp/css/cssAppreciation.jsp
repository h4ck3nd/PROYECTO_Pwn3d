<%@ page contentType="text/css" %>
<%
    String cssPath = "/css/style_appreciation.css"; // RUTA RELATIVA al servlet containe
    RequestDispatcher rd = request.getRequestDispatcher(cssPath);
    if (rd != null) {
        rd.include(request, response);
    } else {
        out.println("/* Archivo CSS no encontrado: " + cssPath + " */");
    }
%>
