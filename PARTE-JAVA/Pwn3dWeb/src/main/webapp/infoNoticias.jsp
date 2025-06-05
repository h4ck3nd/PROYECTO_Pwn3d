<%@ page import="java.util.List" %>
<%@ page import="model.InfoNotice" %>
<%@ page import="dao.InfoNoticeDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.UserDAO" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
    <title>Info Noticias - Pwn3d!</title>

    <!-- Tipografía personalizada -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssInfoNotice.jsp">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
</head>
<body>

<div class="container">
    <h1>🧠 Noticias Públicas</h1>

    <%
        InfoNoticeDAO dao = new InfoNoticeDAO();
        List<InfoNotice> noticias = dao.obtenerNoticiasPublicas();
        for (InfoNotice n : noticias) {
    %>
        <div class="notice">
            <h3>
             <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 2rem;">
			    <!-- Información a la izquierda -->
			    <div style="flex: 1; padding-right: 1.5rem;">
			        <h3 style="margin-top: 0;">
			            <img src="<%= request.getContextPath() %>/img/<%= 
			                ("windows".equalsIgnoreCase(n.getOs()) ? "Windows.svg" : 
			                ("linux".equalsIgnoreCase(n.getOs()) ? "Linux.svg" : "unknown.svg")) %>" 
			                alt="OS Icon" 
			                style="height: 20px; vertical-align: middle; margin-right: 8px;" />
			
			            <%= n.getOs() != null ? n.getOs() : "Desconocido" %><br><br>
			
			            <span style="color: #d98eff;">NAME: </span><%= n.getVmName() %><br><br>
			            <span class="date-badge"><%= n.getDate() %></span>
			            <br><br>
			            <%
				            UserDAO userDAO = new UserDAO();
				            Integer creatorId = userDAO.getUserIdByUsername(n.getCreator());
				        %>
						<% if (creatorId != null) { %>
						    <span style="font-size: 10px;">
						        By: <a href="<%= request.getContextPath() %>/profile/profile-user-public.jsp?id=<%= creatorId %>" style="color: #cb9cf0; text-decoration: none;">
						            <%= n.getCreator() %>
						        </a>
						    </span>
						<% } else { %>
						    <span style="font-size: 10px; color: #aaa;">By: <%= n.getCreator() %></span>
						<% } %>
			        </h3>
			    </div>
			
			    <!-- Imagen a la derecha -->
			    <% if (n.getPathInfoNotice() != null && !n.getPathInfoNotice().isEmpty()) { %>
			        <div style="flex: 0 0 auto;">
			            <img src="<%= request.getContextPath() + "/" + n.getPathInfoNotice() %>"
			                 alt="Imagen portada"
			                 style="max-width: 290px; height: auto; border-radius: 12px; box-shadow: 0 6px 20px rgba(0,0,0,0.7);" />
			        </div>
			    <% } %>
			</div>
			</h3>

            <p><%= n.getDescription() %></p>
            <p class="meta">
            <br>
			    Publicado: <%= n.getTimeCreated() %><br><br>
			    Sistema Operativo: <span class="tag"><%= n.getOs() != null ? n.getOs() : "Desconocido" %></span> <br><br>
			    Dificultad: <span class="tag"><%= n.getDifficulty() != null ? n.getDifficulty() : "No definida" %></span> <br><br>
			    Entorno:
			    <% if (n.getEnvironment() != null) { %>
			        <% String env = n.getEnvironment(); %>
			        <% if ("VMWare".equalsIgnoreCase(env)) { %>
			            <img src="<%= request.getContextPath() %>/img/vmware.png" alt="VMWare" style="height: 20px; vertical-align: middle;" />
			        <% } else if ("Virtual Box".equalsIgnoreCase(env)) { %>
			            <img src="<%= request.getContextPath() %>/img/vbox.png" alt="VirtualBox" style="height: 20px; vertical-align: middle;" />
			        <% } else if ("Docker".equalsIgnoreCase(env)) { %>
			            <img src="<%= request.getContextPath() %>/img/docker.png" alt="Docker" style="height: 20px; vertical-align: middle;" />
			        <% } %>
			        <span class="tag"><%= env %></span>
			    <% } else { %>
			        <span class="tag">No especificado</span>
			    <% } %>
			
			    <% if (n.getSecondEnvironment() != null && !n.getSecondEnvironment().isEmpty()) { %>
			        /
			        <% String secondEnv = n.getSecondEnvironment(); %>
			        <% if ("VMWare".equalsIgnoreCase(secondEnv)) { %>
			            <img src="<%= request.getContextPath() %>/img/vmware.png" alt="VMWare" style="height: 20px; vertical-align: middle;" />
			        <% } else if ("Virtual Box".equalsIgnoreCase(secondEnv)) { %>
			            <img src="<%= request.getContextPath() %>/img/vbox.png" alt="VirtualBox" style="height: 20px; vertical-align: middle;" />
			        <% } else if ("Docker".equalsIgnoreCase(secondEnv)) { %>
			            <img src="<%= request.getContextPath() %>/img/docker.png" alt="Docker" style="height: 20px; vertical-align: middle;" />
			        <% } %>
			        <span class="tag"><%= secondEnv %></span>
			    <% } %>
			</p>
        </div>
    <%
        }
        if (noticias == null || noticias.isEmpty()) {
    %>
        <p style="text-align: center; margin-top: 4rem; color: #586069;">No hay noticias públicas disponibles.</p>
    <%
        }
    %>
</div>
	
<div style="display: flex; justify-content: center; margin: 3rem 0;">
  <button onclick="window.location.href='<%= request.getContextPath() %>/stats'" class="btn exit" style="font-family: 'Press Start 2P', monospace !important;">Volver</button>
</div>

</body>
</html>
