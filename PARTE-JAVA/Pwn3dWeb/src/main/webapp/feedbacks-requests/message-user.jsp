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
  <meta charset="UTF-8">
  <title>Mensaje - Pwn3d!</title>
  <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
  <!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
  @font-face {
	  font-family: 'Press Start 2P';
	  src: url('../fonts/PressStart2P-Regular.ttf') format('truetype');
	  font-weight: normal;
	  font-style: normal;
	}
	
    :root {
      --bg-color: #2c2b30;
      /*--bg-color: #1e1c26;*/ /* FONDO UN POCO MAS OSCURO */
      --sidebar-color: #2a2734;
      --text-color: #bfb3ff;
      --highlight-color: #a366ff;
      --button-bg: #aa00aa;
      --button-hover: #c299ff;
      --danger-bg: #c0392b;
      --shadow-color: rgba(0,0,0,0.5);
      --bg-hamburguer: transparent;
      --color-hamburguer: #fff;
    }

    .light-theme {
      --bg-color: #f0f0f0;
      --sidebar-color: #ffffff;
      --text-color: #222;
      --highlight-color: #7c4dff;
      --button-bg: #7c4dff;
      --button-hover: #b299ff;
      --danger-bg: #e74c3c;
      --shadow-color: rgba(0,0,0,0.1);
      --bg-hamburguer: transparent;
      --color-hamburguer: #000;
    }

body {
  background-color: var(--bg-color);
  color: var(--text-color);
  font-family: 'Press Start 2P', monospace;
  margin: 0;
  padding: 0;
  display: flex;
}

textarea {
	background: #1e1c26 !important;
	gap: 1rem !important;
}

.title {
      font-size: 32px;
      text-align: center;
      color: #ffffff;
      margin-bottom: 50px;
    }

    .comment {
      margin-bottom: 60px;
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
	
    .avatar {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      border: 2px solid #555;
      display: block;
      margin-bottom: 10px;
    }

    .username {
      font-size: 16px;
      margin-bottom: 15px;
    }

/* Sidebar */
    .sidebar-wrapper {
	  width: 350px;
	  background-color: #2c2c3a;
	  min-height: 100vh;
	  padding: 20px;
	  box-shadow: 4px 0 10px var(--shadow-color);
	  transition: left 0.3s ease, visibility 0.3s ease;
	  position: fixed;
	  top: 0;
	  left: 0;
	  z-index: 5;
	  visibility: visible;
	  pointer-events: auto;
	}

.sidebar-wrapper.closed {
  left: -250px;
  visibility: hidden;
  pointer-events: none;
}


.content {
  flex: 1;
  padding: 40px;
  text-align: center;
  margin-left: 250px;
  transition: margin-left 0.3s ease;
}


body.sidebar-closed .content {
  margin-left: 0;
}


    #hamburger {
      position: absolute;
      top: 20px;
      left: 20px;
      color: var(--color-hamburguer);
      border: none;
      background-color: transparent;
      font-size: 2rem;
      cursor: pointer;
      border-radius: 4px;
      z-index: 10;
      font-family: 'Press Start 2P', monospace;
    }

    .sidebar {
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .menu-close {
      background: none;
      margin-top: -35px;
      margin-left: -35px;
      border: none;
      color: var(--danger-bg);
      font-size: 1rem;
      cursor: pointer;
      align-self: flex-start;
    }
	
	.profile {
		margin-top: -30px;
		text-align: center;
	}
	
    .profile img {
      width: 80px;
      height: 80px;
      margin-bottom: 16px;
      border-radius: 50%;
    }

    .profile p {
      font-size: 10px;
      color: var(--text-color);
      text-align: center;
    }

    .menu {
      display: flex;
      flex-direction: column;
      gap: 12px;
      margin-top: 60px;
      margin-left: -60px;
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

    .menu button {
      font-size: 10px;
      background-color: var(--button-bg);
      border: 2px solid var(--highlight-color);
      padding: 8px 12px;
      color: white;
      font-family: 'Press Start 2P', monospace;
      cursor: pointer;
      border-radius: 4px;
      margin-top: 10px;
      width: 100%;
    }

    #deleteBtn {
      background-color: var(--danger-bg);
      box-shadow: 0 0 10px rgba(192, 57, 43, 0.6);
      transition: transform 0.2s ease;
      font-weight: bold;
    }

    #deleteBtn:hover {
      transform: scale(1.05);
    }

    .theme-toggle button {
      margin-top: 250px;
      background-color: #333;
      color: #fff;
      border: 1px solid #888;
      padding: 8px;
      font-size: 10px;
      font-family: 'Press Start 2P', monospace;
      cursor: pointer;
    }

    nav {
      margin-bottom: 40px;
    }

    nav a {
      text-decoration: none;
      color: var(--text-color);
      background-color: transparent;
      padding: 10px 20px;
      border-radius: 4px;
      margin: 0 10px;
      border: 2px solid transparent;
      transition: all 0.3s ease;
    }

.nav-bar {
      display: flex;
      justify-content: center;
      gap: 30px;
      margin-bottom: 40px;
      margin-left: 250px;
      transition: all 0.3s ease;
    }

    nav a.active {
      background-color: var(--highlight-color);
      color: #fff;
    }

    .content a:hover {
      border: 2px solid var(--highlight-color);
    }

    .title {
      font-size: 28px;
      margin-bottom: 30px;
    }

    .box {
      max-width: 700px;
      margin: 0 auto;
      background-color: var(--sidebar-color);
      border: 1px solid var(--highlight-color);
      padding: 25px;
      text-align: left;
      color: var(--text-color);
      font-size: 12px;
      line-height: 1.8em;
    }
    
    hr {
    	margin-top: -14px;
    	opacity: 0.8;
    }

textarea, select, button.send-btn {
  display: block;
  margin: 30px auto;
  width: 100%;
  max-width: 500px;
  min-width: 300px;
  background-color: var(--bg-color);
  border: 1px solid var(--highlight-color);
  color: var(--text-color);
  padding: 10px;
  font-family: 'Press Start 2P', monospace;
  font-size: 10px;
  resize: none;
}


    button.send-btn {
      background-color: var(--highlight-color);
      border: none;
      color: white;
      cursor: pointer;
      width: 100px;
      transition: background 0.3s;
    }

    button.send-btn:hover {
      background-color: var(--button-hover);
    }
    
    .swal2-popup {
    	background-color: #2c2c3a !important;
    }
  </style>
</head>
<body>

  <button id="hamburger" style="display: none;">☰</button>

  <div id="sidebarWrapper" class="sidebar-wrapper open">
    <aside class="sidebar">
      <button id="closeMenu" class="menu-close">❌</button>
      <div class="profile">
        <img src="<%= imgSrc %>" alt="Avatar" class="avatar-image" />
        <p style="font-size: 1rem; color: white !important;"><strong>Username:</strong> <%= nombreUsuario %></p>
      </div>
      <hr style="width: 20rem; border-width: 0.15rem; color: white !important;">
      <nav class="menu" style="color: white !important;">
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
			    color: #fff;
			    font-family: 'Press Start 2P', monospace !important;
			    cursor: pointer;
			    border-radius: 6px;
			    padding: 6px 10px;
			    margin-top: 18px;
			    text-align: center;
			    align-content: center;
			    margin-left: 10px;
			    width: 15rem;
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
      <div class="theme-toggle" hidden>
        <button id="toggle-theme">Modo Claro 🌞</button>
      </div>
    </aside>
  </div>

  <div class="content">
    <nav>
      <a href="<%= request.getContextPath() %>/feedbacks-requests/request.jsp">Request</a>
	  <a href="<%= request.getContextPath() %>/feedbacks-requests/feedback.jsp">Feedback</a>
	  <a href="<%= request.getContextPath() %>/feedbacks-requests/message-user.jsp" class="active">Message!</a>
    </nav>

    <div class="title">Mensaje</div>

    <div class="box">
      ¡Pídenos lo que quieras!<br>
      Ej1: Quiero más máquinas virtuales de Wordpress.<br>
      Ej2: Quiero más retos de programación.<br><br>

      ¿Quieres darnos tu opinión? ¡La apreciamos mucho!<br>
      Ej1: Me encanta la comunidad.<br>
      Ej2: ¡Usa IRC en lugar de Discord!
	</div>
    
    <br>
	<div id="alert-container" style="max-width: 500px; margin: 0 auto;"></div>
	
    <textarea rows="8" placeholder="Escribe tu mensaje..."></textarea>

    <select>
      <option>Request</option>
      <option>Feedback</option>
    </select>

    <button class="send-btn">ENVIAR</button>
  </div>

  <script>
    const hamburger = document.getElementById('hamburger');
    const sidebarWrapper = document.getElementById('sidebarWrapper');
    const closeMenu = document.getElementById('closeMenu');
    const toggleThemeBtn = document.getElementById('toggle-theme');

    function updateHamburgerVisibility() {
      hamburger.style.display = sidebarWrapper.classList.contains('closed') ? 'block' : 'none';
    }

    hamburger.addEventListener('click', () => {
      sidebarWrapper.classList.remove('closed');
      updateHamburgerVisibility();
    });

    closeMenu.addEventListener('click', () => {
      sidebarWrapper.classList.add('closed');
      updateHamburgerVisibility();
    });

    // Modo claro/oscuro con almacenamiento en localStorage
    function toggleTheme() {
      document.body.classList.toggle('light-theme');
      const isLight = document.body.classList.contains('light-theme');
      localStorage.setItem('theme', isLight ? 'light' : 'dark');
      toggleThemeBtn.textContent = isLight ? 'Modo Oscuro 🌙' : 'Modo Claro 🌞';
    }

    toggleThemeBtn.addEventListener('click', toggleTheme);

    // Aplicar tema guardado al cargar
    window.onload = function () {
      if (localStorage.getItem('theme') === 'light') {
        document.body.classList.add('light-theme');
        toggleThemeBtn.textContent = 'Modo Oscuro 🌙';
      }
      updateHamburgerVisibility();
    };

    function updateHamburgerVisibility() {
  const isClosed = sidebarWrapper.classList.contains('closed');
  hamburger.style.display = isClosed ? 'block' : 'none';

  if (isClosed) {
    document.body.classList.add('sidebar-closed');
  } else {
    document.body.classList.remove('sidebar-closed');
  }
}
    
    /* SEND MESSAGE LOGICA */

    const contextPath = "<%= request.getContextPath() %>";

	document.querySelector(".send-btn").addEventListener("click", function () {
	  const mensaje = document.querySelector("textarea").value.trim();
	  const tipo = document.querySelector("select").value;
	  const alertContainer = document.getElementById("alert-container");
	
	  if (!mensaje) {
	    showAlert("Mensaje vacío", "danger");
	    return;
	  }
	
	  const url = tipo === "Request" ? "/request" : "/feedback";
	
	  fetch(contextPath + url, {
	    method: "POST",
	    headers: {
	      'Content-Type': 'application/x-www-form-urlencoded'
	    },
	    body: "mensaje=" + encodeURIComponent(mensaje) + "&tipo=" + encodeURIComponent(tipo)
	  })
	    .then(function (res) {
	      return res.json();
	    })
	    .then(function (data) {
	      if (data.success) {
	        showAlert(data.message, "success");
	        document.querySelector("textarea").value = "";
	      } else {
	        showAlert(data.message || "Error al enviar", "danger");
	      }
	    })
	    .catch(function () {
	      showAlert("Error del servidor", "danger");
	    });
	
	  function showAlert(message, type) {
	    alertContainer.innerHTML =
	      '<div class="alert alert-' + type + ' alert-dismissible fade show" role="alert">' +
	        message +
	        '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
	      '</div>';
	  }
	});
  </script>

</body>
</html>