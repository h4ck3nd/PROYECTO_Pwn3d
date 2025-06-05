<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.ImgProfileDAO" %>
<%@ page import="model.ImgProfile" %>
<%@ page import="utils.JWTUtil" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.User" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%
    String token = null;
    Integer userId = null;
    String nombreUsuario = "Invitado";
    User usuario = null;

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

        Map<String, Object> claims = JWTUtil.getAllClaims(token);
        if (claims != null && claims.get("usuario") != null) {
            nombreUsuario = (String) claims.get("usuario");
        }

        // Obtener todos los usuarios y buscar el actual
        UserDAO userDao = new UserDAO();
        List<User> usuarios = userDao.getAllUsers();
        for (User u : usuarios) {
            if (u.getId() == userId) {
                usuario = u;
                break;
            }
        }

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/logout");
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
%>
<%@ page import="dao.BadgeDAO" %>
<%
    boolean esProHacker = false;

    if (userId != null) {
        BadgeDAO badgeDAO = new BadgeDAO();
        esProHacker = badgeDAO.tieneBadgeProHacker(userId);
    }

    request.setAttribute("esProHacker", esProHacker); // (opcional, si también querés usarlo en EL u otros sitios)
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
    <title>Perfil <%= nombreUsuario %> - Pwn3d!</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
    <style>
    
    	:root {
		  /* Oscuro por defecto */
		  /*--color-background: #2c2b30;*/ /* ANTIGUO COLOR MAS CLARO DEL FONDO */
		  --color-background: #1e1b27;
		  --color-sidebar-bg: #2c2c3a;
		  --shadow-color: rgba(0, 0, 0, 0.6);
		  --color-text-aside: #fff;
		  --color-text: #fff;
		  --color-text-muted: #6a0dad;
		  --color-accent: #ff4f87;
		  --color-accent-alt: #8340c4;
		  --color-dot: #c9aee0;
		  --color-hover-bg: #2a2a2a;
		  --color-card-bg: #1a1a1a;
		  --color-download-bg: #c9aee0;
		  --color-shadow: rgba(0, 0, 0, 0.3);
		  --color-border: #333;
		  --color-gray-dark: #444;
		  --color-timestamp: #888;
		  --color-root: #9b6ad1;
		  --color-user: #00ffff;
		}
    
        body {
            background-color: #1e1b27;
            font-family: 'Press Start 2P', monospace;
            color: #d6d6d6;
            margin: 0 15rem;
            padding: 60px 8%;
            text-shadow: 1px 1px 1px #000000;
        }

        .profile-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
        }

        .stats-section, .trophies-section {
            width: 25%;
            min-width: 220px;
        }

        .avatar-section {
            text-align: center;
            flex: 1;
        }

        .avatar-img {
            width: 220px;
            height: 220px;
            border-radius: 50%;
            border: 6px solid #cb9cf0;
            object-fit: cover;
            background-color: #2c323e;
        }

        .username-title {
            font-size: 18px;
            color: #cb9cf0;
            margin-bottom: 10px;
        }

        .btn-love {
		    background-color: transparent;
		    border-radius: 5px;
		    color: #cb9cf0;
		    border: 2px solid #cb9cf0;
		    padding: 10px 20px;
		    font-size: 11px;
		    margin-top: 10px;
		    font-family: 'Press Start 2P', monospace;
		    cursor: pointer;
		    transition: all 0.3s ease;
		}
		.btn-love:hover {
		    background-color: #cb9cf0;
		    color: #000;
		}
		
		.btn-love:hover svg {
		    fill: #000;
		}
		
		.btn-message {
		    background-color: transparent;
		    border-radius: 5px;
		    color: #cb9cf0;
		    border: 2px solid #cb9cf0;
		    padding: 10px 20px;
		    font-size: 11px;
		    margin-top: 10px;
		    font-family: 'Press Start 2P', monospace;
		    cursor: pointer;
		    transition: all 0.3s ease;
		}
		.btn-message:hover {
		    background-color: #cb9cf0;
		    color: #000;
		}
		
		.btn-message:hover svg {
		    stroke: #000;
		}

        .quote {
            font-size: 8px;
            color: #999;
            margin-top: 10px;
        }

        ul.stats-list {
            list-style: none;
            padding-left: 0;
            font-size: 10px;
            line-height: 1.8;
        }

        .trophy-icons {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            margin-top: 10px;
        }

        .trophy-icons img {
            width: 28px;
            height: 28px;
            image-rendering: pixelated;
            padding: 2px;
        }

        .machines-section {
            margin-top: 70px;
            text-align: center;
            max-height: 400px; /* o el valor que prefieras */
		    overflow-y: auto;
		    /*border: 1px solid #6f42c1;*/ /* opcional: para delimitar visualmente */
		    padding-right: 5px; /* espacio para scroll */
        }
        
        .machines-section::-webkit-scrollbar {
		    width: 6px;
		}
		
		.machines-section::-webkit-scrollbar-thumb {
		    background-color: #6f42c1;
		    border-radius: 3px;
		}
		
		.machines-section::-webkit-scrollbar-track {
		    background-color: #1e1b27;
		}
        

        .machines-title {
            font-size: 16px;
            color: #cb9cf0;
            margin-bottom: 15px;
        }

        .machines-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 11px;
        }

        .machines-table th, .machines-table td {
            padding: 10px;
            border-bottom: 1px solid #6f42c1;
            text-align: center;
        }

        a {
            color: #cb9cf0;
        }

        @media screen and (max-width: 900px) {
            .profile-header {
                flex-direction: column;
                align-items: center;
            }

            .stats-section, .trophies-section {
                width: 100%;
                text-align: center;
                margin-top: 30px;
            }
        }
        .flags-log-list {
		    list-style: none;
		    font-size: 10px;
		    padding: 0;
		    color: #eee;
		}
		
		.flags-log-list li {
		    background-color: #2c253a;
		    border-left: 4px solid #cb9cf0;
		    padding: 8px;
		    margin-bottom: 5px;
		    border-radius: 5px;
		}  
		/* Contenido del menú */
    .sidebar {
      position: relative;
      height: 100%;
      padding: 20px;
      display: flex;
      flex-direction: column;
      gap: 1rem;
      
      /* Añadido para evitar forzar scroll */
	  max-width: 100vw;
	  max-height: 100vh;
	  overflow: hidden;
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
	  overflow-y: hidden; /* <-- esto evita la barra de scroll */
	  z-index: 1000;
	  transition: transform 0.3s ease;
	  align-items: center;
	  text-align: center;
	  align-content: center;
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
      margin-left: -10rem;
      margin-right: -10rem;
    }

    .main-content {
      flex: 1;
      padding: 40px;
      margin-left: 40px;
      margin-right: -280px;
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
    }
	
	.profile p {
    	color: white !important;
    	opacity: 1 !important;
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
      color: white !important;
    }

    .menu {
      display: flex;
      flex-direction: column;
      gap: 12px;
      margin-top: 70px;
    }

    .menu a {
      color: var(--color-text-muted);
      text-decoration: none;
      font-size: 0.9rem;
      transition: color 0.2s ease;
    }

    .menu a:hover {
      color: var(--color-text);
    }

    .hero {
	  display: flex;
	  flex-wrap: wrap;
	  justify-content: space-between;
	  align-items: flex-start;
	  gap: 2rem; /* Mejor que márgenes negativos */
	  padding: 1rem 2rem; 
	}
	
	hr {
		margin-top: -10px;
		opacity: 1;
	}
	
	.title {
	  font-size: 2.5rem;
	  font-weight: 700;
	  margin: 0;           
	}
	
	/* ESTILO DEL LOGRO PROHACKER PARA EL AVATAR */

	.avatar-image {
	  width: 120px;
	  height: 120px;
	  border-radius: 50%;
	  object-fit: cover;
	  border: 3px solid transparent;
	}
	
	/* Contorno exclusivo para prohacker */
	.prohacker-border {
	  position: relative;
	  animation: pulseBorder 2s infinite;
	  box-shadow: 0 0 15px 5px rgba(255, 0, 0, 0.6);
	}
	
	@keyframes pulseBorder {
	  0% {
	    box-shadow: 0 0 10px 3px rgba(255, 0, 0, 0.5);
	  }
	  50% {
	    box-shadow: 0 0 20px 8px rgba(255, 0, 0, 0.9);
	  }
	  100% {
	    box-shadow: 0 0 10px 3px rgba(255, 0, 0, 0.5);
	  }
	}
	
	.custom-button {
        display: inline-block;
        padding: 12px 14px;
        font-size: 8px;
        font-family: 'Press Start 2P', monospace;
        text-decoration: none;
        border: 2px solid #cb9cf0;
        background-color: #1e1b27;
        color: #cb9cf0;
        border-radius: 8px;
        transition: all 0.3s ease;
        text-align: center;
    }

    .custom-button:hover {
        background-color: #cb9cf0;
        color: #1e1b27;
        box-shadow: 0 0 10px #cb9cf0;
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
            <img src="<%= imgSrc %>" alt="Avatar" class="avatar-image <%= esProHacker ? "prohacker-border" : "" %>" />
            <p><strong>Username:</strong> <%= nombreUsuario %></p>
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
        <!-- SECCION DE DAR LOVE -->
        <!-- 
        <button class="btn-love">
        	<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="#cb9cf0">
			  <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 
			           2 5.42 4.42 3 7.5 3c1.74 0 3.41 0.81 4.5 2.09 
			           C13.09 3.81 14.76 3 16.5 3 
			           19.58 3 22 5.42 22 8.5 
			           c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
			</svg>
 			Dar Love
 		</button>
 		 -->
        <br><br>
        <div style="margin-top: 15px; color: #cb9cf0;">Stadisticas<span style="color: white;">.</span></div>
        <ul class="stats-list" id="stats-list">
		    <!-- Aquí se inyectarán las estadísticas dinámicamente -->
		</ul>
    </div>

    <!-- AVATAR CENTER -->
    <div class="avatar-section">
        <img src="<%= imgSrc %>" alt="Avatar" class="avatar-img <%= esProHacker ? "prohacker-border" : "" %>">
        <div class="quote">– Informacion de <%= nombreUsuario %>.</div>
        <!-- 
        <button class="btn-message">
	        <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="none" stroke="#cb9cf0" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24">
			  <circle cx="12" cy="12" r="10"/>
			  <line x1="2" y1="12" x2="22" y2="12"/>
			  <path d="M12 2a15.3 15.3 0 0 1 0 20"/>
			  <path d="M12 2a15.3 15.3 0 0 0 0 20"/>
			</svg>
	 		Enviar Mensaje
 		</button>
 		 -->
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
	    
	    <!-- Botones -->
		<br><br>
		<a href="<%= request.getContextPath() %>/profile/stats-tree.jsp" class="custom-button">Ver Árbol de estadísticas</a>
		
		<br><br>
		<a href="<%= request.getContextPath() %>/profile/badges-info.jsp" class="custom-button">Ver Info. Logros</a>

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

<!-- FLAGS SECTION -->
<div class="machines-section" style="max-height: 300px; overflow-y: auto;">
    <div class="machines-title">Logs<span style="color: white;">.</span></div>
    <ul id="flags-log" class="flags-log-list"></ul>
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

	/* CARGAR INFORMACION DEL PERFIL */
	async function loadStats() {
	    const res = await fetch('<%= request.getContextPath() %>/user-stats');
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
</script>
</body>
</html>
