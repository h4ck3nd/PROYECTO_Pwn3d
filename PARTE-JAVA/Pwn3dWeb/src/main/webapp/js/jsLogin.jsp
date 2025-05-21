<%@ page contentType="application/javascript" %>
<%
    String jsPath = "/js/script_login.js"; // RUTA RELATIVA al servlet container
    RequestDispatcher rd = request.getRequestDispatcher(jsPath);
    if (rd != null) {
        rd.include(request, response);
    } else {
        out.println("// Archivo JS no encontrado: " + jsPath);
    }
%>
