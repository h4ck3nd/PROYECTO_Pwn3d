<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.RankingDAO" %>
<%@ page import="dao.ImgProfileDAO" %>
<%@ page import="model.User" %>
<%@ page import="model.ImgProfile" %>
<%@ page import="java.util.*" %>
<%@ page import="utils.JWTUtil" %>
<%@ page import="java.util.Map" %>
<%@ page import="javax.servlet.http.Cookie" %>

<%

	String token = null; // Declarada fuera para ser accesible globalmente
	Integer userId = null;
	String nombreUsuario = "Invitado";
	
	try {
	    javax.servlet.http.Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (javax.servlet.http.Cookie cookie : cookies) {
	            if ("token".equals(cookie.getName())) {
	                token = cookie.getValue();
	                break;
	            }
	        }
	    }
	
	    if (token == null || !JWTUtil.validateToken(token)) {
	        response.sendRedirect(request.getContextPath() + "/logout");
	        return;
	    }
	
	    userId = JWTUtil.getUserIdFromToken(token);
	    if (userId == null) {
	        response.sendRedirect(request.getContextPath() + "/logout");
	        return;
	    }
	
	    // Extraer el nombre desde los claims del token
	    Map<String, Object> claims = JWTUtil.getAllClaims(token);
	    if (claims != null && claims.get("usuario") != null) {
	        nombreUsuario = (String) claims.get("usuario");
	    }
	
	} catch (Exception e) {
	    e.printStackTrace();
	    response.sendRedirect(request.getContextPath() + "/logout");
	    return;
	}
	
	ImgProfileDAO imgDao1 = new ImgProfileDAO();
	ImgProfile img1 = imgDao1.getImgProfileByUserId(userId);
	imgDao1.cerrarConexion();
	
	String imgSrc = (img1 != null && img1.getPathImg() != null && !img1.getPathImg().isEmpty())
	    ? request.getContextPath() + "/" + img1.getPathImg()
	    : request.getContextPath() + "/imgProfile/default.png";

    String periodo = request.getParameter("periodo") != null ? request.getParameter("periodo") : "mes";
    RankingDAO dao = new RankingDAO();
    ImgProfileDAO imgDao = new ImgProfileDAO();
    List<User> ranking = dao.getRanking(periodo);
    dao.cerrarConexion();
%>
<%@ page import="dao.BadgeDAO" %>
<%
    boolean esProHacker = false;

    if (userId != null) {
        BadgeDAO badgeDAO = new BadgeDAO();
        esProHacker = badgeDAO.tieneBadgeProHacker(userId);
    }

    request.setAttribute("esProHacker", esProHacker);
%>
<html>
<head>
	<meta charset="utf-8">
	<link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
	<title>Ranking - Pwn3d!</title>
  	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssRanking.jsp">
  	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
</head>
<body>

<!-- MENU DE HABURGUESA -->

    <button id="hamburger" class="menu-toggle" style="display: none;">☰</button>
  <div class="app">
    <div id="sidebarWrapper" class="sidebar-wrapper open">
        <aside class="sidebar">
          <!-- Botón de cerrar -->
          <button id="closeMenu" class="menu-close">❌</button>
          <div class="profile">
            <img src="<%= imgSrc %>" alt="Avatar" class="avatar-image <%= esProHacker ? "prohacker-border" : "" %>" />
            <p><strong>Username:</strong> <%= nombreUsuario %></p>
          </div>
          <hr>
      <nav class="menu">
      
      <!-- Seccion Perfil Usuario -->
      	<a href="<%= request.getContextPath() %>/profile/profile.jsp">
      	<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 64 64" fill="none">
		  <!-- Contorno del círculo exterior -->
		  <circle cx="32" cy="32" r="30" stroke="#ffffff" stroke-width="5" fill="none" />
		  
		  <!-- Cabeza (solo contorno) -->
		  <circle cx="32" cy="24" r="8" stroke="#ffffff" stroke-width="5" fill="none" />
		  
		  <!-- Cuerpo estilizado (contorno) -->
		  <path d="M20 44c0-6.6 5.4-12 12-12s12 5.4 12 12" stroke="#ffffff" stroke-width="5" fill="none" />
		</svg>
      	Perfil
      	</a>
      	
      <!-- Seccion Usuarios -->
      	<a href="<%= request.getContextPath() %>/perfil">
      	<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" role="img" aria-label="Editar Perfil">
		  <!-- Cabeza (círculo) -->
		  <circle cx="12" cy="7" r="4" />
		  
		  <!-- Hombros (curva) -->
		  <path d="M5 21c0-4 14-4 14 0" />
		
		  <!-- Tuerca (engranaje) -->
		  <g transform="translate(18, 10) scale(0.6)" stroke="currentColor" stroke-width="2" fill="none" stroke-linejoin="round" stroke-linecap="round">
		    <circle cx="0" cy="0" r="4" />
		    <!-- Dientes -->
		    <line x1="0" y1="-6" x2="0" y2="-4" />
		    <line x1="0" y1="6" x2="0" y2="4" />
		    <line x1="-6" y1="0" x2="-4" y2="0" />
		    <line x1="6" y1="0" x2="4" y2="0" />
		    <line x1="-4.2" y1="-4.2" x2="-3" y2="-3" />
		    <line x1="4.2" y1="4.2" x2="3" y2="3" />
		    <line x1="-4.2" y1="4.2" x2="-3" y2="3" />
		    <line x1="4.2" y1="-4.2" x2="3" y2="-3" />
		    <!-- Círculo interior -->
		    <circle cx="0" cy="0" r="1.5" fill="currentColor" />
		  </g>
		</svg>
      	Ajustes Cuenta
      	</a>
        <a href="<%= request.getContextPath() %>/stats">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" role="img" aria-label="Dashboard Icon">
		  <!-- Contorno general -->
		  <rect x="2" y="3" width="20" height="18" rx="2" ry="2" />
		  
		  <!-- Barra 1 (más baja) -->
		  <rect x="6" y="16" width="3" height="5" />
		  <!-- Barra 2 (media) -->
		  <rect x="11" y="12" width="3" height="9" />
		  <!-- Barra 3 (más alta) -->
		  <rect x="16" y="8" width="3" height="13" />
		</svg> 
        Dashboard
        </a>
        <a href="<%= request.getContextPath() %>/machines.jsp" style="color: #b600ff; text-decoration:none; display:inline-flex; align-items:center; gap:8px;">
		 <svg xmlns="http://www.w3.org/2000/svg" width="24" height="18" viewBox="0 0 32 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" role="img" aria-label="Terminal Icon">
		  <!-- Contorno de la terminal -->
		  <rect x="1" y="1" width="30" height="22" rx="2" ry="2"/>
		  
		  <!-- Línea de prompt -->
		  <polyline points="6 12 10 16 6 20" />
		  
		  <!-- Línea horizontal que representa texto -->
		  <line x1="14" y1="16" x2="26" y2="16" />
		</svg>
		  Machines
		</a>
		
		<a href="<%= request.getContextPath() %>/feedbacks-requests/request.jsp" style="color: #b600ff; text-decoration:none; display:inline-flex; align-items:center; gap:8px;">
		  <svg xmlns="http://www.w3.org/2000/svg" 
		     width="30" height="30" viewBox="0 0 24 24" 
		     fill="none" stroke="currentColor" stroke-width="1.8" 
		     stroke-linecap="round" stroke-linejoin="round">
		  <!-- Bocadillo de diálogo -->
		  <path d="M19 13a2 2 0 0 1-2 2H8l-3 3V6a2 2 0 0 1 2-2h11a2 2 0 0 1 2 2z"></path>
		  <!-- Check mark para feedback -->
		  <polyline points="8 11 11 14 18 7"></polyline>
		</svg>
		  FeedBack
		</a>
		
		<a href="<%= request.getContextPath() %>/ranking.jsp" style="color: #b600ff; text-decoration:none; display:inline-flex; align-items:center; gap:8px;">
		  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" viewBox="0 0 24 24" role="img" aria-label="Ranking icon">
		    <path d="M17 4V2H7v2H2v3c0 2.76 2.24 5 5 5 .68 0 1.32-.14 1.91-.39A6.98 6.98 0 0 0 11 15.9V19H8v2h8v-2h-3v-3.1a6.98 6.98 0 0 0 2.09-4.29c.59.25 1.23.39 1.91.39 2.76 0 5-2.24 5-5V4h-5zM4 7V6h3v2.93c-1.72-.23-3-1.69-3-2.93zm16 0c0 1.24-1.28 2.7-3 2.93V6h3v1z"/>
		  </svg>
		  Ranking
		</a>
		
		<!-- Seccion Reconocimientos paginas -->
      	<a href="<%= request.getContextPath() %>/appreciation.jsp">
      	<svg width="24" height="24" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
		  <path d="M32 2L8 12V30C8 47 22 59 32 62C42 59 56 47 56 30V12L32 2Z" fill="none" stroke="#ffffff" stroke-width="4"/>
		  <path d="M32 20L35.09 26.26L42 27.27L37 32.14L38.18 39.02L32 35.77L25.82 39.02L27 32.14L22 27.27L28.91 26.26L32 20Z"
		        fill="#ffffff"/>
		</svg>
      	Reconocimientos
      	</a>

        <!--<hr/>  -->
        <!-- Seccion de Autenticacion -->
        <!--<a href="#">⚙️ Settings</a>-->
        
        <!-- BOTON/FORMULARIO PARA CERRAR SESION DEL USUSARIO ACTUAL POR ID -->
        <br><br>
        <form action="<%= request.getContextPath() %>/logout" method="get" style="display: inline;">
		    <button type="submit" style="
		        font-size: 0.7rem;
		        background-color: #7e0036; /* morado-rojizo */
		        border: none;
		        padding: 6px 10px 6px 8px;
		        color: #fff;
		        font-family: 'Press Start 2P', monospace !important;
		        cursor: pointer;
		        border-radius: 6px;
		        display: flex;
		        align-items: center;
		        gap: 6px;
		    ">
		        <!-- SVG de logout (simple y elegante) -->
		        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
				  <path d="M16 17l1.41-1.41L13.83 12l3.58-3.59L16 7l-5 5 5 5z"/>
				  <path d="M19 3H5c-1.1 0-2 .9-2 2v4h2V5h14v14H5v-4H3v4c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2z"/>
				</svg>
		        Cerrar sesión
		    </button>
		</form>
      </nav>
      <!-- 
      <div class="theme-toggle">
        <button id="toggle-theme">Modo Claro 🌞</button>
      </div>
       -->
    </aside>
</div>

<!-- CONTENIDO PRINCIPAL -->

<main class="main-content">
  <div class="ranking-wrapper">
    <div class="ranking-buttons">
      <button onclick="window.location.href='ranking.jsp?periodo=mes'" style="font-family: 'Press Start 2P', monospace;">Top del Mes</button>
      <button onclick="window.location.href='ranking.jsp?periodo=ano'" style="font-family: 'Press Start 2P', monospace;">Top del Año</button>
    </div>

    <div class="ranking-flex">
      <!-- Tabla Ranking -->
      <div class="ranking-table" tabindex="0" aria-label="Lista de ranking">
        <h2>🏆 Ranking <%= periodo.equals("mes") ? "Mensual" : "Anual" %></h2>
        <div class="ranking-header">
          <div>Puesto</div>
          <div>Hacker</div>
          <div style="text-align:right;">Puntos</div>
        </div>
        <%
		    if (ranking == null || ranking.isEmpty()) {
		%>
		    <p style="text-align:center; font-weight:bold; margin-top: 2rem;">
		        ⚠️ No hay usuarios registrados para este <%= periodo.equals("mes") ? "mes" : "período" %>.
		    </p>
		<%
		    } else {
          int pos = 1;
          User topUser = null;
          User currentUser = null;
          int posicionUsuario = -1;
          ImgProfile imgUsuario = null;
          BadgeDAO badgeDAO = new BadgeDAO();

          for (User u : ranking) {
            if (u.getId() == userId) {
              currentUser = u;
              posicionUsuario = pos;
              imgUsuario = imgDao.getImgProfileByUserId(u.getId());
            }

            ImgProfile img = imgDao.getImgProfileByUserId(u.getId());
            String imgPath = (img != null) ? request.getContextPath() + "/" + img.getPathImg() : request.getContextPath() + "/imgProfile/default.png";
            String flagPath = (u.getPais() != null) ? request.getContextPath() + "/img/flags/" + u.getPais().toLowerCase() + ".svg" : null;
			
            boolean proHacker = badgeDAO.tieneBadgeProHacker(u.getId());
            
            String colorClass = "";
            if (pos == 1) { colorClass = "gold"; topUser = u; }
            else if (pos == 2) colorClass = "silver";
            else if (pos == 3) colorClass = "bronze";
        %>
        
        <div class="ranking-row <%= colorClass %>">
          <div class="ranking-col">#<%= pos %></div>
          <div class="ranking-col-hackers">
            <a href="<%= request.getContextPath() %>/profile/profile-user-public.jsp?id=<%= u.getId() %>" style="display: contents;">
			  <img src="<%= imgPath %>" class="avatar <%= proHacker ? "prohacker-border" : "" %>" alt="avatar de <%= u.getUsuario() %>" />
			</a>
            <span><%= u.getNombre() %> @<%= u.getUsuario() %></span>
            <% if (flagPath != null) { %>
              <img src="<%= flagPath %>" class="flag-icon" alt="flag" />
            <% } %>
          </div>
          <div class="ranking-col points" style="text-align:right;"><%= u.getPuntos() %> pts</div>
        </div>
        <%
            pos++;
          }
          imgDao.cerrarConexion();
        %>

        <%-- Mostrar siempre al usuario actual al final --%>
        <% if (currentUser != null) {
              String imgPathUser = (imgUsuario != null && imgUsuario.getPathImg() != null)
                      ? request.getContextPath() + "/" + imgUsuario.getPathImg()
                      : request.getContextPath() + "/imgProfile/default.png";
              String flagPathUser = (currentUser.getPais() != null)
                      ? request.getContextPath() + "/img/flags/" + currentUser.getPais().toLowerCase() + ".svg"
                      : null;
              boolean proHackerUsuario = badgeDAO.tieneBadgeProHacker(currentUser.getId());
        %>
        <hr style="border: 1px solid var(--border-color); margin: 18px auto; width: 90%;">
        <div class="ranking-row" style="border-left: 6px solid #8e7cc3;">
          <div class="ranking-col">#<%= posicionUsuario %></div>
          <div class="ranking-col-hackers">
            <a href="<%= request.getContextPath() %>/profile/profile-user-public.jsp?id=<%= currentUser.getId() %>" style="display: contents;">
			  <img src="<%= imgPathUser %>" class="avatar <%= proHackerUsuario ? "prohacker-border" : "" %>" alt="avatar"/>
			</a>
            <span><%= currentUser.getNombre() %> @<%= currentUser.getUsuario() %></span>
            <% if (flagPathUser != null) { %>
              <img src="<%= flagPathUser %>" class="flag-icon" alt="flag" />
            <% } %>
          </div>
          <div class="ranking-col points" style="text-align:right;"><%= currentUser.getPuntos() %> pts</div>
        </div>
        <% } %>
      </div>

      <!-- Panel TOP 1 -->
      <% if (topUser != null) {
          ImgProfile topImg = new ImgProfileDAO().getImgProfileByUserId(topUser.getId());
          String topImgPath = (topImg != null) ? request.getContextPath() + "/" + topImg.getPathImg() : request.getContextPath() + "/imgProfile/default.png";
          String topFlagPath = (topUser.getPais() != null) ? request.getContextPath() + "/img/flags/" + topUser.getPais().toLowerCase() + ".svg" : null;
          String topTitle = periodo.equals("mes") ? "TOP MES" : "TOP ANUAL";
      %>
      <div class="top1-panel" aria-label="Panel top 1">
        <img src="<%= topImgPath %>" alt="Top 1" class="top1-image" />
        <div class="top1-title"><%= topTitle %></div>
        <div class="top1-overlay">
          <div class="top1-name"><%= topUser.getNombre() %></div>
          <div class="top1-info">
            <span class="top1-user">@<%= topUser.getUsuario() %></span>
            <% if (topFlagPath != null) { %>
              <img src="<%= topFlagPath %>" class="top1-flag" alt="flag" />
            <% } %>
          </div>
          <div class="top1-points"><%= topUser.getPuntos() %> puntos</div>
        </div>
      </div>
      <% 
	      }
		}
      %>
    </div>
  </div>
</main>
  
  <script src="<%= request.getContextPath() %>/js/jsRanking.jsp"></script>
</body>
</html>
