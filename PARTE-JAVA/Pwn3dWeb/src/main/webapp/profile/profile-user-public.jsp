<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.ImgProfileDAO" %>
<%@ page import="model.ImgProfile" %>
<%@ page import="utils.JWTUtil" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.User" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    Integer userId = null;
    String nombreUsuario = "Desconocido";
    User usuario = null;

    try {
        String idParam = request.getParameter("id");
        if (idParam == null || !idParam.matches("\\d+")) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
            return;
        }

        userId = Integer.parseInt(idParam);

        // Obtener usuario por ID
        UserDAO userDao = new UserDAO();
        usuario = userDao.getUserById(userId); // Usa tu método que busca por ID directamente

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
            return;
        }

        nombreUsuario = usuario.getUsuario();

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/error.jsp");
        return;
    }

    // Obtener imagen de perfil
    ImgProfileDAO imgDao = new ImgProfileDAO();
    ImgProfile img = imgDao.getImgProfileByUserId(userId);
    imgDao.cerrarConexion();

    String imgSrc = (img != null && img.getPathImg() != null && !img.getPathImg().isEmpty())
        ? request.getContextPath() + "/" + img.getPathImg()
        : request.getContextPath() + "/imgProfile/default.png";

    // País
    String pais = usuario.getPais();
    String iso = (pais != null && !pais.trim().isEmpty()) ? pais.toLowerCase() : null;
    
 	// Obtener ID del usuario actual que está visitando
    Integer guestId = null;
    User visitante = null;
    String guestUsername = "Invitado";

    javax.servlet.http.Cookie[] cookies = request.getCookies();
    String token = null;

    if (cookies != null) {
        for (javax.servlet.http.Cookie cookie : cookies) {
            if ("token".equals(cookie.getName())) {
                token = cookie.getValue();
                break;
            }
        }
    }

    if (token != null && !token.trim().isEmpty()) {
        guestId = JWTUtil.getUserIdFromToken(token);
        if (guestId != null) {
            UserDAO userDaoGuest = new UserDAO();
            visitante = userDaoGuest.getUserById(guestId);
            if (visitante != null) {
                guestUsername = visitante.getUsuario();
            }
        }
    }

    boolean isOwner = (guestId != null && guestId.equals(userId));

 	// Obtener imagen de perfil del usuario visitante
    ImgProfileDAO imgDao2 = new ImgProfileDAO();
    ImgProfile imgGuest = imgDao2.getImgProfileByUserId(guestId);
    imgDao2.cerrarConexion();

    String imgSrcGuest = (imgGuest != null && imgGuest.getPathImg() != null && !imgGuest.getPathImg().isEmpty())
        ? request.getContextPath() + "/" + imgGuest.getPathImg()
        : request.getContextPath() + "/imgProfile/default.png";
%>
<%@ page import="dao.BadgeDAO" %>
<%
    boolean esProHacker = false;

    if (guestId != null) {
        BadgeDAO badgeDAO = new BadgeDAO();
        esProHacker = badgeDAO.tieneBadgeProHacker(guestId);
    }

    request.setAttribute("esProHacker", esProHacker); // opcional
    
    boolean esProHackerOwner = false;

    if (userId != null) {
        BadgeDAO badgeDAO = new BadgeDAO();
        esProHackerOwner = badgeDAO.tieneBadgeProHacker(userId);
    }

    request.setAttribute("esProHackerOwner", esProHackerOwner); // opcional
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
    <title>Perfil <%= nombreUsuario %> - Pwn3d!</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Incluye SweetAlert2 si no lo has hecho -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssProfileUserPublic.jsp" />
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
            <img src="<%= imgSrcGuest %>" alt="Avatar" class="avatar-image <%= esProHacker ? "prohacker-border" : "" %>" />
    		<p><strong>Username:</strong> <%= guestUsername %></p>
          </div>
          <hr style="width: 18rem; font-weight: bold !important;">
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

<!-- PROFILE HEADER -->
<div class="profile-header">

    <!-- STATS LEFT -->
    <div class="stats-section">
        <div class="username-title"><span id="ranking-username"></span> <%= nombreUsuario %> 
        <% if (iso != null) { %>
		    <img src="<%= request.getContextPath() %>/img/flags/<%= iso %>.svg"
		         alt="<%= pais %>" 
		         style="vertical-align: middle;" 
		         width="20px" 
		         height="20px">
		<% } %>
        </div>
       <div style="display: flex; align-items: center;">
		    <span id="user-rank" style="font-size: 15px; color: #fff8fd; margin-right: 8px;"></span>
		    <span id="points-user" style="background:#cb9cf0; color:#000; padding:2px 6px; font-size: 9px; border-radius: 10px; text-shadow: none;">
		    	<!-- SECCION DE PUNTOS -->
		    </span>
		</div>

        <br>
        <% System.out.println("Sesión user_id (guestId): " + guestId); %>
        
        <% if (guestId != null && !isOwner) { %>
		    <!-- INPUT HIDDEN CON EL ID DEL USUARIO VISITADO -->
		    <input type="hidden" id="profileUserId" value="<%= userId %>">
		
		    <!-- SECCION DE DAR LOVE -->
		    <button class="btn-love" id="btnLove">
		        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="#cb9cf0">
		            <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 
		                     2 5.42 4.42 3 7.5 3c1.74 0 3.41 0.81 4.5 2.09 
		                     C13.09 3.81 14.76 3 16.5 3 
		                     19.58 3 22 5.42 22 8.5 
		                     c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
		        </svg>
		        Dar Love
		    </button>
		<% } %>
        <br><br>
        <div style="margin-top: 15px; color: #cb9cf0;">Stadisticas<span style="color: white;">.</span></div>
        <ul class="stats-list" id="stats-list">
		    <!-- Aquí se inyectarán las estadísticas dinámicamente -->
		</ul>
    </div>

    <!-- AVATAR CENTER -->
    <div class="avatar-section">
        <img src="<%= imgSrc %>" alt="Avatar" class="avatar-img <%= esProHackerOwner ? "prohacker-border" : "" %>">
        <div class="quote">– Informacion de <%= nombreUsuario %>.</div>
        <button class="btn-message" onclick="window.location.href='<%= request.getContextPath() %>/profile/chat.jsp?id=<%= userId %>'">
	        <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="none" stroke="#cb9cf0" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24">
			  <circle cx="12" cy="12" r="10"/>
			  <line x1="2" y1="12" x2="22" y2="12"/>
			  <path d="M12 2a15.3 15.3 0 0 1 0 20"/>
			  <path d="M12 2a15.3 15.3 0 0 0 0 20"/>
			</svg>
	 		Enviar Mensaje
 		</button>
 		<br><br><br><br>
    </div>
	
    <!-- TROPHIES + RR.SS. agrupados -->
	<div class="trophies-section">
	    <!-- Logros -->
	    <div style="color: #cb9cf0; margin-bottom: 10px;">Logros<span style="color: white;">.</span></div>
	    <div class="trophy-icons" id="trophy-icons">
	        <!-- JS insertará aquí las imágenes -->
	    </div>
		
		<br><br>
		
	    <!-- RR.SS. -->
	    <div style="color: #cb9cf0; margin: 20px 0 10px;">RR<span style="color: white;">.</span>SS<span style="color: white;">.</span></div>
	    <div class="trophy-icons" id="rrss-icons">
	        <!-- JS insertará aquí las imágenes -->
	    </div>
	</div>



</div>


<!-- MACHINES SECTION -->
<div class="machines-section">
    <div class="machines-title">Maquinas<span style="color: white;">.</span></div>
    <table class="machines-table">
        <thead>
            <tr>
                <th>Nombre VM</th>
                <th>Descargar</th>
                <th>Tamaño</th>
            </tr>
        </thead>
        <tbody id="machines-body">
            <!-- JS insertará aquí -->
        </tbody>
    </table>
</div>

<!-- WRITEUPS SECTION -->
<div class="machines-section">
    <div class="machines-title">Writeups<span style="color: white;">.</span></div>
    <table class="machines-table">
        <thead>
            <tr>
                <th>Nombre VM</th>
                <th>Link</th>
                <th>Idioma</th>
            </tr>
        </thead>
        <tbody id="writeups-body">
            <!-- JS insertará aquí -->
        </tbody>
    </table>
</div>

<!-- LOGS SECTION -->
<div class="machines-section" style="max-height: 300px; overflow-y: auto;">
    <div class="machines-title">Logs<span style="color: white;">.</span></div>
    <ul id="flags-log" class="flags-log-list"></ul>
</div>

</main>

<!-- Define tu CustomSwal con un estilo oscuro/morado -->
<script>
const CustomSwal = Swal.mixin({
  background: '#1e1b27',
  color: '#cb9cf0',
  confirmButtonColor: '#cb9cf0',
  cancelButtonColor: '#999'
});
</script>

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
	
	/* CARGAR INFORMACION DEL PERFIL */

	async function loadStats() {
		const params = new URLSearchParams(window.location.search);
		const id = params.get("id");

		if (!id) {
		    alert("ID de usuario no especificado.");
		    return;
		}

		const res = await fetch('<%= request.getContextPath() %>/user-viewer?id=' + id);
	    const raw = await res.text();
	
	    try {
	        const data = JSON.parse(raw);
	
	        var statsHTML = ""
	            + "<li>Total Root: " + data.flags_root + "</li>"
	            + "<li>Total User: " + data.flags_user + "</li>"
	            + "<li>Primeras Root: " + (data.firstRootFlags || 0) + "</li>"
	            + "<li>Primeras User: " + (data.firstUserFlags || 0) + "</li>"
	            + "<li>Writeups: " + data.total_writeups + "</li>"
	            + "<li>VMs Creadas: " + data.vms_creadas + "</li>"
	            + "<br>"
	            + "<li>"
	            + "    <svg xmlns='http://www.w3.org/2000/svg' width='15' height='15' viewBox='0 0 24 24' fill='#cb9cf0' style='vertical-align: middle; margin-right: 5px;'>"
	            + "        <path d='M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 "
	            + "                 2 5.42 4.42 3 7.5 3c1.74 0 3.41 0.81 4.5 2.09 "
	            + "                 C13.09 3.81 14.76 3 16.5 3 "
	            + "                 19.58 3 22 5.42 22 8.5 "
	            + "                 c0 3.78-3.4 6.86-8.55 11.54L12 21.35z'/>"
	            + "    </svg> "
	            + data.loves
	            + "</li>";
	
	        document.getElementById("stats-list").innerHTML = statsHTML;
	        
	        var pointsHTML = ""
	            + '<span>'
	            + data.puntos + ' pts'
	            + '</span>';
	
	        document.getElementById("points-user").innerHTML = pointsHTML;
	        
	        var badgeContainer = document.getElementById("trophy-icons");
	        badgeContainer.innerHTML = ""; // Limpia los logros anteriores

	        for (var badge in data.badges) {
	            if (data.badges[badge] === true) {
	                var img = document.createElement("img");
	                img.src = "<%= request.getContextPath() %>/img/badges/" + badge + ".svg";
	                img.alt = badge;
	                img.title = badge;
	                img.style.imageRendering = "pixelated";
	                img.width = 28;
	                img.height = 28;
	                badgeContainer.appendChild(img);
	            }
	        }
	        
	     // RR.SS.
	        var rrssContainer = document.getElementById("rrss-icons");
	        rrssContainer.innerHTML = ""; // Limpiar

	        if (data.redes_privadas) {
	            rrssContainer.innerHTML = "<span style='font-size: 10px; color: #aaa;'>Redes sociales en privado</span>";
	        } else {
	            for (var icon in data.redes) {
	                var url = data.redes[icon];
	                var link = document.createElement("a");
	                link.href = url;
	                link.target = "_blank";
	                link.style.marginRight = "8px";

	                var img = document.createElement("img");
	                img.src = "<%= request.getContextPath() %>/img/icons/" + icon;
	                img.alt = icon;
	                img.title = icon;
	                img.style.width = "24px";
	                img.style.height = "24px";

	                link.appendChild(img);
	                rrssContainer.appendChild(link);
	            }
	        }
	        
	        document.getElementById("user-rank").innerText = "[" + data.rango + "]";
	        
	     	// MÁQUINAS CREADAS
	        var machinesBody = document.getElementById("machines-body");
	        machinesBody.innerHTML = "";

	        if (Array.isArray(data.machines) && data.machines.length > 0) {
	            data.machines.forEach(function(machine) {
	                var row = "<tr>"
	                        + "<td style='color:#6efdee;'>" + machine.name + "</td>"
	                        + "<td><a href='" + machine.url + "' target='_blank'>Descargar</a></td>"
	                        + "<td>" + machine.size + "</td>"
	                        + "</tr>";
	                machinesBody.innerHTML += row;
	            });
	        } else {
	            machinesBody.innerHTML = "<tr><td colspan='3' style='color: #888;'>No hay máquinas creadas.</td></tr>";
	        }

	     	// WRITEUPS PUBLICADOS
	        var writeupsBody = document.getElementById("writeups-body");
	        writeupsBody.innerHTML = "";

	        if (Array.isArray(data.writeups) && data.writeups.length > 0) {
	            data.writeups.forEach(function(writeup) {
	                var row = "<tr>"
	                        + "<td style='color:#6efdee;'>" + writeup.vm + "</td>"
	                        + "<td><a href='" + writeup.url + "' target='_blank'>Leer</a></td>"
	                        + "<td>" + writeup.lang + "</td>"
	                        + "</tr>";
	                writeupsBody.innerHTML += row;
	            });
	        } else {
	            writeupsBody.innerHTML = "<tr><td colspan='3' style='color: #888;'>No hay writeups publicados.</td></tr>";
	        }
	        
	     	// Logs de flags
	        const flagLogsContainer = document.getElementById("flags-log");
	        flagLogsContainer.innerHTML = "";

	        if (Array.isArray(data.flags_logs) && data.flags_logs.length > 0) {
	            data.flags_logs.forEach(log => {
	                const tipo = log.tipo === "root" ? "ROOT" : "USER";
	                const isFirst = (log.tipo === "root" && log.firstRoot) || (log.tipo === "user" && log.firstUser);
	                const fecha = new Date(log.fecha).toLocaleString();
	                const tag = isFirst ? " 💥 First Blood!" : "";

	                const li = document.createElement("li");
	                li.innerHTML =
	                    "<strong>[" + tipo + "]</strong> "
	                    + log.vm
	                    + " - <span style='color:#cb9cf0;'>" + fecha + "</span>"
	                    + tag;
	                flagLogsContainer.appendChild(li);
	            });
	        } else {
	            flagLogsContainer.innerHTML = "<li style='color:#777;'>No hay flags registradas aún.</li>";
	        }
	        
	        document.getElementById("ranking-username").innerHTML =
	            "#" + data.ranking;
	
	    } catch (e) {
	        console.error("Error parsing stats JSON:", e);
	        document.getElementById("stats-list").innerHTML =
	            "<li style='color:red;'>Error al cargar estadísticas</li>";
	    }
	}
	
	window.onload = loadStats;
	
	/* DAR LOVE USER */
	
	const btnLove = document.querySelector(".btn-love");
		if (btnLove) {
		  btnLove.addEventListener("click", function () {
		    const userId = parseInt(document.getElementById("profileUserId").value);
		
		    fetch("<%= request.getContextPath() %>/giveLoveUser", {
		      method: "POST",
		      headers: {
		        "Content-Type": "application/x-www-form-urlencoded"
		      },
		      body: "userId=" + userId
		    })
		    .then(function (res) {
		      if (res.ok) {
		        return res.json();
		      } else {
		        throw new Error("Error en la petición.");
		      }
		    })
		    .then(function (data) {
		      if (data.success) {
		        CustomSwal.fire({
		          icon: 'success',
		          title: '❤️ Love dado',
		          text: 'Has dado love correctamente a este usuario.',
		          background: '#2d233b',
		          color: '#cb9cf0',
		          confirmButtonColor: '#cb9cf0',
		          timer: 2000,
		          showConfirmButton: false
		        }).then(function () {
		          location.reload();
		        });
		      } else {
		        CustomSwal.fire({
		          icon: 'warning',
		          title: 'Atención',
		          text: data.message || 'Ya le diste love.',
		          background: '#2d233b',
		          color: '#cb9cf0',
		          confirmButtonColor: '#cb9cf0'
		        });
		      }
		    })
		    .catch(function (err) {
		      console.error("Error:", err);
		      CustomSwal.fire({
		        icon: 'error',
		        title: 'Error',
		        text: 'Ocurrió un error al dar love.',
		        background: '#2d233b',
		        color: '#cb9cf0',
		        confirmButtonColor: '#cb9cf0'
		      });
		    });
		  });
		}
</script>
</body>
</html>
