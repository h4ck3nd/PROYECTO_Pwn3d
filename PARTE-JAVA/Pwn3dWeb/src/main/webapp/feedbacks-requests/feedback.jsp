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
<%@ page import="dao.BadgeDAO" %>
<%
    userId = (Integer) session.getAttribute("userId");
    boolean esProHacker = false;

    if (userId != null) {
        BadgeDAO badgeDAO = new BadgeDAO();
        esProHacker = badgeDAO.tieneBadgeProHacker(userId);
    }

    request.setAttribute("esProHacker", esProHacker); // (opcional, si también querés usarlo en EL u otros sitios)
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Feedback - Pwn3d!</title>
  <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssFeedback.jsp" />
</head>
<body>

<button id="hamburger" style="display: none;">☰</button>

  <div id="sidebarWrapper" class="sidebar-wrapper open">
    <aside class="sidebar">
      <button id="closeMenu" class="menu-close">❌</button>
      <div class="profile">
        <img src="<%= imgSrc %>" alt="Avatar" class="avatar-image <%= esProHacker ? "prohacker-border" : "" %>" />
        <p style="font-size: 1rem;"><strong>Username:</strong> <%= nombreUsuario %></p>
      </div>
      <hr style="width: 20rem; font-weight: bold !important;">
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
      <div class="theme-toggle" hidden>
        <button id="toggle-theme">Modo Claro 🌞</button>
      </div>
    </aside>
  </div>

<nav class="nav-bar">
  <a href="<%= request.getContextPath() %>/feedbacks-requests/request.jsp">Request</a>
  <a href="<%= request.getContextPath() %>/feedbacks-requests/feedback.jsp" class="active">Feedback</a>
  <a href="<%= request.getContextPath() %>/feedbacks-requests/message-user.jsp">Message!</a>
</nav>

<div class="container">
  <h1 class="title">Feedback</h1>
  <div id="feedback-container"></div>
</div>
<script src="<%= request.getContextPath() %>/js/jsFeedBack.jsp"></script>
<script>
  
  /* MOSTRAR LOS FEEDBACKS DESDE LA DDBB */
  
  const feedbackContainer = document.getElementById("feedback-container");
  const contextPath = "<%= request.getContextPath() %>";
  
	fetch(contextPath + '/feedbacks')
	  .then(function(response) {
	    return response.json();
	  })
	  .then(function(feedbacks) {
	    let html = "";
	    feedbacks.forEach(function(fb) {
	      html += '<div class="comment">';
	      html +=   '<a href="' + contextPath + '/profile/profile-user-public.jsp?id=' + fb.userId + '">';
	      html +=     '<img class="avatar ' + (fb.esProHacker ? 'prohacker-border' : '') + '" src="' + contextPath + fb.avatarPath + '" alt="' + fb.username + ' avatar" />';
	      html +=   '</a>';
	      html +=   '<h2 class="username pink">' + fb.username + '</h2>';
	      html +=   '<div class="user-msg">' + fb.message + '</div>';
	      html +=   '<div class="admin-reply">' + fb.estado + '</div>';  // Mostrar siempre estado aquí
	      html += '</div>';
	    });
	    feedbackContainer.innerHTML = html;
	  })
	  .catch(function(err) {
	    feedbackContainer.innerHTML = '<p>Error al cargar los comentarios.</p>';
	    console.error(err);
	  });

</script>

</body>
</html>