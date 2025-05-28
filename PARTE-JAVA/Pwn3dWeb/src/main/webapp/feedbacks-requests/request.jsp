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
	
    String userRole = "user"; // Valor por defecto
    Map<String, Object> claims = JWTUtil.getAllClaims(token);
    if (claims != null && claims.get("rol") != null) {
        userRole = (String) claims.get("rol");
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
  <title>Request - Pwn3d!</title>
  <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
  <!-- Carga SweetAlert2 -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  
  <script>
    // Definir CustomSwal justo después de cargar SweetAlert2
    const CustomSwal = Swal;
  </script>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssRequest.jsp" />
</head>
<body>

<button id="hamburger" style="display: none;">☰</button>

  <div id="sidebarWrapper" class="sidebar-wrapper open">
    <aside class="sidebar">
      <button id="closeMenu" class="menu-close">❌</button>
      <div class="profile">
        <img src="<%= imgSrc %>" alt="Avatar" class="avatar-image" />
        <p style="font-size: 1rem;"><strong>Username:</strong> <%= nombreUsuario %></p>
      </div>
      <hr style="width: 20rem; font-weight: bold !important;">
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
      <div class="theme-toggle" hidden>
        <button id="toggle-theme">Modo Claro 🌞</button>
      </div>
    </aside>
  </div>

<nav class="nav-bar">
  <a href="<%= request.getContextPath() %>/feedbacks-requests/request.jsp" class="active">Request</a>
  <a href="<%= request.getContextPath() %>/feedbacks-requests/feedback.jsp">Feedback</a>
  <a href="<%= request.getContextPath() %>/feedbacks-requests/message-user.jsp">Message!</a>
</nav>

<div class="container">
  <h1 class="title">Requests</h1>
  <div class="comment">
  <div id="comments-container"></div>
  <script src="<%= request.getContextPath() %>/js/jsRequest.jsp"></script>
<script>
  /* MOSTRAR LOS REQUEST DESDE LA DDBB */
	
	const USER_ROLE = "<%= userRole %>";
const isAdmin = USER_ROLE === "admin";
const contextPath = "<%= request.getContextPath() %>";

fetch(contextPath + "/requests")
  .then(function(res) {
    return res.json();
  })
  .then(function(data) {
    console.log(data);
    var container = document.getElementById("comments-container");
    container.innerHTML = ""; // Limpia

    data.forEach(function(item) {
      var estado = item.estado;
      var estadoTexto = "";
      var estadoClase = "";

      if (estado === "Hecho") {
        estadoTexto = "✔ Hecho";
        estadoClase = "status-tag";
      } else if (estado === "Mas adelante") {
        estadoTexto = "🤔 Mas adelante";
        estadoClase = "status-tag maybe";
      } else if (estado === "En progreso") {
        estadoTexto = "⚙️ En progreso";
        estadoClase = "status-tag inProgress";
      } else {
        estadoTexto = estado;
        estadoClase = "status-tag";
      }

      var imgSrc = item.userImgPath
        ? contextPath + "/" + item.userImgPath
        : contextPath + "/imgProfile/default.png";

      var dropdownHTML = "";
      if (isAdmin) {
        dropdownHTML =
          '<select class="status-dropdown" data-request-id="' + item.id + '">' +
            '<option value="En progreso"' + (estado === "En progreso" ? " selected" : "") + '>⚙️ En progreso</option>' +
            '<option value="Mas adelante"' + (estado === "Mas adelante" ? " selected" : "") + '>🤔 Mas adelante</option>' +
            '<option value="Hecho"' + (estado === "Hecho" ? " selected" : "") + '>✔ Hecho</option>' +
          '</select>';
      }

      var heartEmptySVG =
        '<svg class="heart-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ff69b4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="cursor:pointer;">' +
          '<path d="M12 21C12 21 5 14.5 5 9.5C5 7 7 5 9.5 5C11 5 12 6 12 6C12 6 13 5 14.5 5C17 5 19 7 19 9.5C19 14.5 12 21 12 21Z"/>' +
        '</svg>';

      var heartFilledSVG =
        '<svg class="heart-icon filled" width="24" height="24" viewBox="0 0 24 24" fill="#ff69b4" stroke="#ff69b4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="cursor:pointer;">' +
          '<path d="M12 21C12 21 5 14.5 5 9.5C5 7 7 5 9.5 5C11 5 12 6 12 6C12 6 13 5 14.5 5C17 5 19 7 19 9.5C19 14.5 12 21 12 21Z"/>' +
        '</svg>';

      var heartSVG = item.lovedByUser ? heartFilledSVG : heartEmptySVG;

      container.innerHTML +=
        '<div class="comment">' +
          '<div class="fancy-terminal">' +
            '<img src="' + imgSrc + '" alt="Profile" class="avatar" />' +
            '<p>' + item.user + '</p><br>' +
            '<div class="mac-body">' +
              '<p>' + item.message + '</p>' +
            '</div>' +
            '<div class="mac-footer" style="display:flex; align-items:center;">' +
              '<span class="' + estadoClase + '">' + estadoTexto + '</span>' +
              dropdownHTML +
              '<span class="love-container" data-request-id="' + item.id + '" style="display:flex; align-items:center; gap:6px; margin-left:10px;">' +
                heartSVG +
                '<span class="love-count">' + item.loves + '</span>' +
              '</span>' +
            '</div>' +
          '</div><br><br>' +
        '</div>';
    });

    // Event listeners para dropdowns
    var selects = document.querySelectorAll(".status-dropdown");
    selects.forEach(function(select) {
      select.addEventListener("change", function() {
        var requestId = this.getAttribute("data-request-id");
        var newEstado = this.value;

        fetch(contextPath + "/update-request", {
          method: "POST",
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
          body: "id=" + encodeURIComponent(requestId) + "&estado=" + encodeURIComponent(newEstado)
        })
        .then(function(response) { return response.json(); })
        .then(function(data) {
          if (data.success) {
            CustomSwal.fire({
              icon: 'success',
              title: 'Estado actualizado',
              text: 'Estado actualizado correctamente.',
              timer: 2000,
              showConfirmButton: false
            }).then(() => location.reload());
          } else {
            CustomSwal.fire({
              icon: 'error',
              title: 'Error',
              text: 'Error al actualizar el estado.'
            });
          }
        })
        .catch(function() {
          CustomSwal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Error en la solicitud.'
          });
        });
      });
    });

    // Event listeners para corazones
    var loveContainers = document.querySelectorAll(".love-container");
    loveContainers.forEach(function(containerEl) {
      containerEl.addEventListener("click", function() {
        var requestId = this.getAttribute("data-request-id");
        var heartIcon = this.querySelector(".heart-icon");
        var loveCountSpan = this.querySelector(".love-count");

        if (heartIcon.classList.contains("filled")) {
          CustomSwal.fire({
            icon: 'info',
            title: 'Info',
            text: 'Solo puedes dar 1 love por request.'
          });
          return;
        }

        fetch(contextPath + "/give-love", {
          method: "POST",
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
          body: "requestId=" + encodeURIComponent(requestId)
        })
        .then(function(res) { return res.json(); })
        .then(function(data) {
          if (data.success) {
            // Reemplazar icono vacío por icono relleno
            heartIcon.outerHTML =
              '<svg class="heart-icon filled" width="24" height="24" viewBox="0 0 24 24" fill="#ff69b4" stroke="#ff69b4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="cursor:pointer;">' +
                '<path d="M12 21C12 21 5 14.5 5 9.5C5 7 7 5 9.5 5C11 5 12 6 12 6C12 6 13 5 14.5 5C17 5 19 7 19 9.5C19 14.5 12 21 12 21Z"/>' +
              '</svg>';

            var currentCount = parseInt(loveCountSpan.textContent, 10) || 0;
            loveCountSpan.textContent = currentCount + 1;

            CustomSwal.fire({
              icon: 'success',
              title: '¡Gracias!',
              text: '¡Gracias por tu love!',
              timer: 2000,
              showConfirmButton: false
            });
          } else {
            CustomSwal.fire({
              icon: 'error',
              title: 'Error',
              text: data.message || 'Error al dar love.'
            });
          }
        })
        .catch(function() {
          CustomSwal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Error en la solicitud.'
          });
        });
      });
    });

  })
  .catch(function() {
    console.error("Error al cargar los datos.");
  });


</script>

</body>
</html>