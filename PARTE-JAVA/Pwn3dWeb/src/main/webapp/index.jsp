<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="dao.ImgProfileDAO" %>
<%@ page import="model.ImgProfile" %>
<%@ page import="dao.EditProfileDAO" %>
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

    ImgProfileDAO imgDao = new ImgProfileDAO();
    ImgProfile img = imgDao.getImgProfileByUserId(userId);
    imgDao.cerrarConexion();

    String imgSrc = (img != null && img.getPathImg() != null && !img.getPathImg().isEmpty())
        ? request.getContextPath() + "/" + img.getPathImg()
        : request.getContextPath() + "/imgProfile/default.png";
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
  <title>Dashboard - Pwn3d!</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssIndex.jsp">
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
      <header class="hero">
		  <h1 class="title">Pwn3d!<span class="dot">.</span></h1>
		  <div class="right-content">
		    <div class="vm-info"></div>
		    <br>
		    <div id="notices-container"></div>
		  </div>
		</header>
	  <img src="<%= request.getContextPath() %>/img/logo-flag-white.png" alt="logo-pwn3d!" class="logo-pwn3d" />
      <section class="stats">
		  <div class="stat">
		    <h3>VMs</h3>
		    <p><%= request.getAttribute("totalVMs") != null ? request.getAttribute("totalVMs") : "..." %></p>
		  </div>
		  <div class="stat">
		    <h3>Hackers</h3>
		    <p><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : "..." %></p>
		  </div>
		  <div class="stat">
		    <h3>Writeups</h3>
		    <p><%= request.getAttribute("totalWriteups") != null ? request.getAttribute("totalWriteups") : "..." %></p>
		  </div>
		</section>
		
		<p>Bienvenido a nuestra comunidad dedicada a los CTFs y al hacking ético.</p>
		<p>Aquí podrás enviar tus máquinas virtuales y writeups para compartir conocimiento.</p>
		<p>Estamos en constante mejora, fomentando el aprendizaje y la colaboración entre todos.</p>
		
		<br>
		<h2>Logs<span class="dot">.</span></h2>
		<br>
        <div id="logs-container"></div>
        
    </main>
    
    <script>
	  const contextPath = '<%= request.getContextPath() %>';
	</script>
    
    <script src="<%= request.getContextPath() %>/js/jsIndex.jsp"></script>
    <script>
	 	// Cargar logs desde el servlet JSON y añadirlo al DOM
	    fetch('<%= request.getContextPath() %>/logsJson')
	      .then(response => response.json())
	      .then(logs => {
	        document.getElementById('logs-container').innerHTML = buildLogsHTML(logs);
	      })
	      .catch(error => {
	        console.error('Error cargando logs:', error);
	        document.getElementById('logs-container').innerHTML = '<p>Error cargando logs.</p>';
	      });
	 	
	    /* CARGAR ULTIMA MAQUINA SUBIDA */
	    
	    document.addEventListener("DOMContentLoaded", function () {
	      fetch('<%= request.getContextPath() %>/ultimaMaquinaIndex')
	        .then(function(response) {
	          return response.json();
	        })
	        .then(function(data) {
	          var nameMachine = data.nameMachine;
	          var downloadUrl = data.downloadUrl;

	          var vmInfo = document.querySelector('.vm-info');
	          if (vmInfo && nameMachine && downloadUrl) {
	            vmInfo.innerHTML =
	              '<h2>Nueva VM: <span>' + nameMachine + '</span></h2>' +
	              '<a href="' + downloadUrl + '" target="_blank" class="btn download">Download</a>';
	          } else {
	            console.warn('Datos incompletos recibidos para la última máquina:', data);
	          }
	        })
	        .catch(function(error) {
	          console.error('Error al obtener la última máquina:', error);
	        });
	    });
	    
	    /* AUTO AJUSTE DE IMAGEN */

	    function isVisible(elem) {
	      return elem && elem.offsetParent !== null && window.getComputedStyle(elem).display !== 'none' && elem.offsetHeight > 0 && elem.offsetWidth > 0;
	    }

	    function ajustarLogoPorVisibilidad() {
	      const logo = document.querySelector('.logo-pwn3d');
	      if (!logo) return;

	      const info1 = document.querySelector('.info1');
	      const sinInfo = document.querySelector('.sinInfo');
	      const info2 = document.querySelector('.info2');
			
	      if (isVisible(info2)) {           // Prioridad 1: info2
	    	    logo.style.marginTop = '-15rem';
	    	  } else if (isVisible(info1)) {    // Prioridad 2: info1
	    	    logo.style.marginTop = '-5rem';
	    	  } else if (isVisible(sinInfo)) {  // Prioridad 3: sinInfo
	    	    logo.style.marginTop = '8rem';
	    	  } else {
	    	    logo.style.marginTop = '10rem'; // Margen por defecto
	    	  }
	    }
		
	    function ajustarLogoEnPantallaPequena() {
	    	  const logo = document.querySelector('.logo-pwn3d');
	    	  if (!logo) return;

	    	  const isSmallScreen = window.matchMedia("(max-width: 768px)").matches;

	    	  if (isSmallScreen) {
	    	    logo.style.marginTop = '0'; // Ajuste fijo para móvil, puedes cambiar el valor
	    	  }
	    	}
	    
	    /* VISUALIZACION DE LAS NOTICIAS NUEVAS */

	    document.addEventListener("DOMContentLoaded", function () {
	      fetch("<%= request.getContextPath() %>/getNotices")
	        .then(response => response.json())
	        .then(data => {
	          const container = document.getElementById("notices-container");
	          container.innerHTML = "";

	          if (data.length === 0) {
	            container.innerHTML = '<p class="sinInfo">No hay noticias por el momento</p>';
	            ajustarLogoPorVisibilidad();
	            return;
	          }

	          data.forEach(function(noticia) {
	        	  container.innerHTML += 
	        	    '<h3>NOTICIAS: </h3><br>' + 
	        	    (noticia.description_page ? '<p class="info1"><em>' + noticia.description_page + '</em></p><br>' : '') +
	        	    '<span>' + noticia.date + '</span><br>' +

	        	    // SVG DEL LOGO DE LA MAQUINA
	        	    '<p>' +
	        	      '<svg width="20" height="20" viewBox="0 0 250 250" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Logo Windows estilo hacker azul sin fondo" style="vertical-align: middle; margin-right: 6px; fill: none; stroke: none;">' +
	        	        '<defs>' +
	        	          '<linearGradient id="neonBlue" x1="0" y1="0" x2="1" y2="1">' +
	        	            '<stop offset="0%" stop-color="#00A4EF"/>' +
	        	            '<stop offset="100%" stop-color="#004A99"/>' +
	        	          '</linearGradient>' +
	        	          '<filter id="pixelate" x="0" y="0" width="100%" height="100%" color-interpolation-filters="sRGB">' +
	        	            '<feMorphology operator="dilate" radius="1" />' +
	        	            '<feDisplacementMap in="SourceGraphic" scale="4" xChannelSelector="R" yChannelSelector="G"/>' +
	        	          '</filter>' +
	        	          '<style>' +
	        	            '.code-line { fill: none; stroke: #00A4EF; stroke-width: 1.5; stroke-dasharray: 4 6; opacity: 0.7; }' +
	        	            '.warning-circle { fill: #FF3300; stroke: #FF0000; stroke-width: 2; }' +
	        	            '.warning-text { font-family: \'Courier New\', monospace; font-weight: bold; font-size: 20px; fill: white; pointer-events: none; }' +
	        	          '</style>' +
	        	        '</defs>' +

	        	        '<rect x="40" y="40" width="70" height="70" fill="url(#neonBlue)" filter="url(#pixelate)" rx="6" ry="6" />' +
	        	        '<rect x="140" y="40" width="70" height="70" fill="url(#neonBlue)" filter="url(#pixelate)" rx="6" ry="6" />' +
	        	        '<rect x="40" y="140" width="70" height="70" fill="url(#neonBlue)" filter="url(#pixelate)" rx="6" ry="6" />' +
	        	        '<rect x="140" y="140" width="70" height="70" fill="url(#neonBlue)" filter="url(#pixelate)" rx="6" ry="6" />' +

	        	        '<line x1="20" y1="30" x2="230" y2="30" class="code-line"/>' +
	        	        '<line x1="20" y1="80" x2="230" y2="80" class="code-line"/>' +
	        	        '<line x1="20" y1="120" x2="230" y2="120" class="code-line"/>' +
	        	        '<line x1="20" y1="170" x2="230" y2="170" class="code-line"/>' +
	        	        '<line x1="20" y1="210" x2="230" y2="210" class="code-line"/>' +

	        	        '<circle cx="200" cy="200" r="25" class="warning-circle" />' +
	        	        '<text x="200" y="210" class="warning-text" text-anchor="middle" dominant-baseline="middle">!</text>' +
	        	      '</svg>' +
	        	      ' ' + noticia.vm_name + ' by <strong>' + noticia.creator + '</strong>' +
	        	    '</p>' +
	        	    '<button onclick="window.location.href=\'' + contextPath + '/infoNoticias.jsp\'" class="btn download">Ver</button>';

	        	  if (noticia.second_vm_name) {
	        	    container.innerHTML +=
	        	      '<br><br><hr><br>' +
	        	      '<h4 class="info2">SEGUNDA MAQUINA: </h4>' +
	        	      '<span>' + noticia.second_date + '</span><br>' +
	        	      '<p>LOGO ' + noticia.second_vm_name + ' by <strong>' + noticia.second_creator + '</strong></p>' +
	        	      '<button onclick="window.location.href=\'' + contextPath + '/infoNoticias.jsp\'" class="btn download">Ver</button>';
	        	  }
	        	});
	          
	          ajustarLogoPorVisibilidad();
	        })
	        .catch(err => {
	          console.error("Error cargando noticias:", err);
	        });
	    });

	    const container = document.getElementById('notices-container');

	    if (container) {
	      const observer = new MutationObserver(() => {
	        ajustarLogoPorVisibilidad();
	      });

	      observer.observe(container, { childList: true, subtree: true });
	    }



    </script>
</body>
</html>