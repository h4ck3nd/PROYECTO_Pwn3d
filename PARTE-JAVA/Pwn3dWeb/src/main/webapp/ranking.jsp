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

<html>
<head>
	<meta charset="utf-8">
	<link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
	<title>Ranking - Pwn3d!</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');

    :root {
      --bg-dark: #1e1b27;
      --panel-bg: #222034;
      --accent-purple: #8e7cc3;
      --text-light: #d7d3e0;
      --text-muted: #9994a5;
      --border-color: #3e3b5c;
      --hover-bg: #2d2b43;
      --color-sidebar-bg: #2c2c3a;
  	--shadow-color: rgba(0, 0, 0, 0.6);
    }

    body {
      margin: 0;
      background: var(--bg-dark);
      font-family: 'Press Start 2P', monospace;
      color: var(--text-light);
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
      user-select: none;
    }

    .ranking-wrapper {
      max-width: 1200px;
      margin: 40px auto;
      padding: 10px 30px 40px 30px;
      display: flex;
      flex-direction: column;
      gap: 25px;
    }

    .ranking-buttons {
      display: flex;
      justify-content: center;
      gap: 30px;
      margin-right: 18rem;
    }

    .ranking-buttons button {
      background: transparent;
      border: 2px solid var(--accent-purple);
      color: var(--accent-purple);
      padding: 10px 28px;
      font-size: 13px;
      border-radius: 12px;
      cursor: pointer;
      transition: background-color 0.3s ease, color 0.3s ease;
      font-weight: 700;
      letter-spacing: 1px;
      margin-right: 5rem;
    }

    .ranking-buttons button:hover,
    .ranking-buttons button:focus {
      background-color: var(--accent-purple);
      color: var(--bg-dark);
      outline: none;
    }

    .ranking-flex {
      display: flex;
      gap: 40px;
      justify-content: center;
      align-items: flex-start;
    }

    /* Tabla Ranking: más ancha y con scroll vertical */
    .ranking-table {
      flex: 3;
      min-width: 600px;
      max-width: 800px;
      background: var(--panel-bg);
      border-radius: 14px;
      overflow-y: auto;
      max-height: 600px;
      padding: 20px 0 0 0;
      box-shadow: none;
      align-content: center;
      text-align: center;
      align-items: center;
    }

    .ranking-table h2 {
      text-align: center;
      font-size: 20px;
      margin-bottom: 18px;
      color: var(--accent-purple);
      user-select: none;
    }

    .ranking-header, .ranking-row {
      display: grid;
      grid-template-columns: 70px 2fr 1fr;
      align-items: center;
      padding: 10px 28px;
      font-size: 13px;
      text-transform: uppercase;
      letter-spacing: 1.2px;
      user-select: none;
    }

    .ranking-header {
      background: #3a3850;
      border-bottom: 2px solid var(--border-color);
      font-weight: 700;
      color: var(--accent-purple);
      position: sticky;
      top: 0;
      z-index: 10;
    }

    .ranking-row {
      background: var(--panel-bg);
      border-left: 6px solid transparent;
      color: var(--text-light);
      gap: 15px;
      border-radius: 0 12px 12px 0;
      transition: background-color 0.25s ease;
      cursor: default;
      align-content: center;
      text-align: center;
      align-items: center;
    }
    .ranking-row:hover {
      background-color: var(--hover-bg);
    }
    .ranking-row.gold { border-left-color: gold; }
    .ranking-row.silver { border-left-color: silver; }
    .ranking-row.bronze { border-left-color: #cd7f32; }

    .ranking-col {
	  display: flex;
	  align-items: center;      /* centra vertical */
	  justify-content: center;
	  gap: 12px;
	  font-size: 13px;
	  white-space: nowrap;
	  overflow: hidden;
	  text-overflow: ellipsis;
	}
	
	.ranking-col-hackers {
	  display: flex;
	  align-items: center;
	  gap: 12px;
	  font-size: clamp(5px, 1vw, 10px); /* reduce tamaño de fuente según espacio */
	  white-space: nowrap;
	  overflow: visible; /* permitimos que no se oculte */
	  text-overflow: clip; /* no muestra puntos suspensivos */
	  margin-left: 90px;
	  max-width: calc(100% - 70px - 20px); /* ancho máximo para que no se salga del contenedor */
	  flex-shrink: 1;
	}
	
	.ranking-col-hackers .avatar {
	  width: 14%;
	  height: 14%;
	}


    .ranking-col.points {
      justify-content: flex-end;
      font-weight: 700;
      font-size: 0.6rem;
    }

    .avatar {
      width: 42px;
      height: 42px;
      border-radius: 50%;
      border: 2px solid #555;
      flex-shrink: 0;
      object-fit: cover;
    }

    .flag-icon {
      width: 18px;
      height: 14px;
    }

    /* Panel TOP 1 */
    .top1-panel {
      flex: 1;
      min-width: 280px;
      border-radius: 16px;
      position: relative;
      overflow: hidden;
      box-shadow: 0 0 15px var(--accent-purple);
      cursor: default;
      display: flex;
      flex-direction: column;
      justify-content: flex-end;
      color: var(--text-light);
      user-select: none;
      background-color: var(--panel-bg);
      margin-top: 4.5rem;
    }

    .top1-image {
      position: absolute;
      inset: 0;
      width: 100%;
      height: 100%;
      object-fit: cover;
      filter: brightness(0.45);
      z-index: 0;
      transition: filter 0.3s ease;
    }

    .top1-panel:hover .top1-image {
      filter: brightness(0.6);
    }

    .top1-overlay {
      position: relative;
      z-index: 1;
      padding: 24px 20px;
      background: linear-gradient(to top, rgba(30, 23, 55, 0.85), transparent 60%);
      border-radius: 0 0 16px 16px;
      display: flex;
      flex-direction: column;
      gap: 6px;
      height: 395px;
    }

    .top1-title {
      position: absolute;
      top: 16px;
      left: 0;
      width: 100%;
      font-size: 28px;
      font-weight: 900;
      text-align: center;
      color: var(--accent-purple);
      text-shadow:
        0 0 8px var(--accent-purple),
        0 0 15px var(--accent-purple);
      user-select: none;
      pointer-events: none;
    }

    .top1-name {
      font-size: 14px;
      font-weight: 700;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      margin-top: 21rem;
    }

    .top1-user {
      font-size: 11px;
      color: var(--text-muted);
    }

    .top1-points {
      font-weight: 700;
      font-size: 12px;
      margin-top: 4px;
    }

    .top1-flag {
      width: 20px;
      height: 14px;
      margin-left: 6px;
      vertical-align: middle;
      filter: drop-shadow(0 0 1px #000);
    }

    .top1-info {
      display: flex;
      align-items: center;
      gap: 6px;
    }

    /* Scrollbar styling (simple) */
    .ranking-table::-webkit-scrollbar {
      width: 8px;
    }
    .ranking-table::-webkit-scrollbar-thumb {
      background-color: var(--accent-purple);
      border-radius: 6px;
    }
    .ranking-table::-webkit-scrollbar-track {
      background-color: var(--panel-bg);
    }
    
    /* Contenido del menú */
    .sidebar {
      position: relative;
      height: 100%;
      padding: 20px;
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }

    .sidebar a {
      color: var(--color-text-aside) !important;
      text-decoration: none;
      padding: 10px 0;
      display: flex;
      align-items: center;
      gap: 10px;
      transition: color 0.2s ease;
    }

    .sidebar a:hover {
      color: var(--color-accent);
    }

    /* Botón de cerrar dentro del menú */
    .menu-close {
      position: absolute;
      top: 10px;
      left: 10px;
      font-size: 1.0rem;
      background: none;
      color: var(--color-text);
      border: none;
      cursor: pointer;
      z-index: 2001;
      display: none;
    }

    /* Mostrar botón de cerrar solo cuando el menú está abierto */
    .sidebar-wrapper.open .menu-close {
      display: block;
    }

    /* Botón de hamburguesa (☰) */
    .menu-toggle {
      position: fixed;
      top: 20px;
      left: 20px;
      font-size: 2rem;
      background: none;
      color: var(--color-text);
      border: none;
      cursor: pointer;
      z-index: 2000;
      display: none;
    }

    /* Mostrar hamburguesa solo cuando el menú está cerrado */
    .sidebar-wrapper.closed + .menu-toggle {
      display: block;
    }

    /* Menú lateral */
    .sidebar-wrapper {
      position: fixed;
      top: 0;
      left: 0;
      width: 340px;
      height: 100vh;
      background-color: var(--color-sidebar-bg);
      box-shadow: 4px 0 10px var(--shadow-color);
      overflow-y: hidden;
      z-index: 1000;
      transition: transform 0.3s ease;
      align-items: center;
      text-align: center;
      align-content: center;
      color: white !important;
    }

    /* Menú abierto */
    .sidebar-wrapper.open {
      transform: translateX(0);
    }

    /* Menú cerrado */
    .sidebar-wrapper.closed {
      transform: translateX(-100%);
    }

    .sidebar-wrapper.closed ~ .main-content {
      margin-left: 10rem;
      margin-right: 10rem;
    }

    .main-content {
      margin-left: 340px;
      margin-right: 140px;
    }

    /* En pantallas pequeñas, el contenido debe ajustarse */
    @media (max-width: 768px) {
      .main-content {
        margin-left: 0;
        padding: 60px 20px 20px;
      }
    }

    .profile {
      text-align: center;
    }

    .profile img {
      width: 80px;
      height: 80px;
      border-radius: 50%;
      margin-bottom: 10px;
    }

    .avatar {
      border-radius: 50%;
      width: 80px;
      height: 80px;
    }

    .username {
      margin-top: 10px;
      font-weight: bold;
      font-size: 0.95rem;
    }

    .menu {
      display: flex;
      flex-direction: column;
      gap: 1.63rem;
      margin-top: 80px;
    }

    .menu a {
      color: var(--color-text-muted);
      text-decoration: none;
      font-size: 0.9rem;
      transition: color 0.2s ease;
      margin-top: -10px;
    }

    .menu a:hover {
      color: var(--color-text);
    }
    
    hr {
    	width: 18rem;
    	margin-top: -10px;
    }
  </style>
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
            <img src="<%= imgSrc %>" alt="Avatar" class="avatar-image" />
            <p><strong>Username:</strong> <%= nombreUsuario %></p>
          </div>
          <hr>
      <nav class="menu">
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
          int pos = 1;
          User topUser = null;
          User currentUser = null;
          int posicionUsuario = -1;
          ImgProfile imgUsuario = null;

          for (User u : ranking) {
            if (u.getId() == userId) {
              currentUser = u;
              posicionUsuario = pos;
              imgUsuario = imgDao.getImgProfileByUserId(u.getId());
            }

            ImgProfile img = imgDao.getImgProfileByUserId(u.getId());
            String imgPath = (img != null) ? request.getContextPath() + "/" + img.getPathImg() : request.getContextPath() + "/imgProfile/default.png";
            String flagPath = (u.getPais() != null) ? request.getContextPath() + "/img/flags/" + u.getPais().toLowerCase() + ".svg" : null;

            String colorClass = "";
            if (pos == 1) { colorClass = "gold"; topUser = u; }
            else if (pos == 2) colorClass = "silver";
            else if (pos == 3) colorClass = "bronze";
        %>
        <div class="ranking-row <%= colorClass %>">
          <div class="ranking-col">#<%= pos %></div>
          <div class="ranking-col-hackers">
            <img src="<%= imgPath %>" class="avatar" alt="avatar"/>
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
        %>
        <hr style="border: 1px solid var(--border-color); margin: 18px auto; width: 90%;">
        <div class="ranking-row" style="border-left: 6px solid #8e7cc3;">
          <div class="ranking-col">#<%= posicionUsuario %></div>
          <div class="ranking-col-hackers">
            <img src="<%= imgPathUser %>" class="avatar" alt="avatar"/>
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
      <% } %>
    </div>
  </div>
</main>
  
  <script>
	  const hamburger = document.getElementById("hamburger");
	  const closeBtn = document.getElementById("closeMenu");
	  const sidebarWrapper = document.getElementById("sidebarWrapper");
	
	  function openMenu() {
	    sidebarWrapper.classList.remove("closed");
	    sidebarWrapper.classList.add("open");
	    hamburger.style.display = "none";     // Oculta el botón ☰
	    closeBtn.style.display = "block";     // Muestra el botón ❌
	  }
	
	  function closeMenu() {
	    sidebarWrapper.classList.remove("open");
	    sidebarWrapper.classList.add("closed");
	    hamburger.style.display = "block";    // Muestra el botón ☰
	    closeBtn.style.display = "none";      // Oculta el botón ❌
	  }
	
	  // Eventos
	  hamburger.addEventListener("click", openMenu);
	  closeBtn.addEventListener("click", closeMenu);
	
	  // inicializacion
	  document.addEventListener("DOMContentLoaded", () => {
	    openMenu(); // Mostramos el menú por defecto
	  });
  </script>
</body>
</html>
