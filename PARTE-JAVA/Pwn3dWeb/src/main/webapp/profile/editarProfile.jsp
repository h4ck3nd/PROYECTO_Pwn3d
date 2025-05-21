<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.ImgProfileDAO" %>
<%@ page import="model.ImgProfile" %>
<%@ page import="dao.EditProfileDAO" %>
<%@ page import="model.EditProfile" %>
<%@ page import="utils.JWTUtil" %>
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

    EditProfileDAO dao = new EditProfileDAO();
    java.util.List<EditProfile> socialLinks = dao.getLinksByUserId(userId);
    dao.cerrarConexion();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Mi Perfil</title>
  <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
  <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssEditProfile.jsp">
</head>
<!-- FUENTE DE LETRA PARA EL POPUP DE ELIMINAR CUENTA -->
  
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
<body>
<!-- FORMULARIO OCULTO PARA ELIMINAR CUENTA CUANDO SE LLAMADA DESDE EL BOTON -->

<form id="deleteForm" method="post" action="<%= request.getContextPath() %>/deleteAccount" style="display:none;">
    <!-- Form vacío, se envía solo el userId de sesión en backend -->
</form>

<!-- 
<h1>Bienvenido, <%= request.getAttribute("usuario") %></h1>
  <p>Nombre completo: <%= request.getAttribute("nombre") %> <%= request.getAttribute("apellido") %></p>
  <p>Email: <%= request.getAttribute("email") %></p>
  <p>Rol: <%= request.getAttribute("rol") %></p>
  <p>Flags usuario: <%= request.getAttribute("flags_user") %></p>
  <p>Flags root: <%= request.getAttribute("flags_root") %></p>
  <p>Último inicio: <%= request.getAttribute("ultimo_inicio") %></p>
  <p>Identidad pública: <%= request.getAttribute("identity") %></p>
   -->
   
   <!-- MENU DE HABURGUESA -->

    <button id="hamburger" class="menu-toggle" style="display: none;">☰</button>
  
    <div id="sidebarWrapper" class="sidebar-wrapper open">
        <aside class="sidebar">
          <!-- Botón de cerrar -->
          <button id="closeMenu" class="menu-close">❌</button>
          <div class="profile">
            <img src="<%= imgSrc %>" alt="Avatar" class="avatar-image" />
            <p style="font-size: 1rem;"><strong>Username:</strong> <%= nombreUsuario %></p>
          </div>
          <hr style="width: 18rem;">
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
		
		<a href="#" style="color: #b600ff; text-decoration:none; display:inline-flex; align-items:center; gap:8px;">
		  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" viewBox="0 0 24 24" role="img" aria-label="Ranking icon">
		    <path d="M17 4V2H7v2H2v3c0 2.76 2.24 5 5 5 .68 0 1.32-.14 1.91-.39A6.98 6.98 0 0 0 11 15.9V19H8v2h8v-2h-3v-3.1a6.98 6.98 0 0 0 2.09-4.29c.59.25 1.23.39 1.91.39 2.76 0 5-2.24 5-5V4h-5zM4 7V6h3v2.93c-1.72-.23-3-1.69-3-2.93zm16 0c0 1.24-1.28 2.7-3 2.93V6h3v1z"/>
		  </svg>
		  Ranking
		</a>

        <!--<hr/>  -->
        <!-- Seccion de Autenticacion -->
        <!--<a href="#">⚙️ Settings</a>-->
        
        <!-- BOTON/FORMULARIO PARA CERRAR SESION DEL USUSARIO ACTUAL POR ID -->
        <br><br><br>
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

<!-- PAGINA PRINCIPAL -->

  <div class="container">

    <!-- Tarjeta de bienvenida -->
    <section class="welcome-card">

      <!-- IZQUIERDA: Avatar y datos básicos -->
      <div class="profile-left">
        <div class="avatar-box">
		    <img src="<%= imgSrc %>" alt="Avatar" class="avatar-image" />
		    <form action="<%= request.getContextPath() %>/subirAvatar" method="post" enctype="multipart/form-data" id="avatarForm">
		        <input
		            type="file"
		            name="avatarInput"
		            id="avatarInput"
		            class="hidden-input"
		            accept="image/*"
		            onchange="document.getElementById('avatarForm').submit();"
		            style="font-family: 'Press Start 2P', monospace; font-size: 0.55rem;"
		        >
		    </form>
		</div>
		
        <div class="form-group">
          <label>Nombre de usuario</label>
          <input type="text" value="<%= request.getAttribute("usuario") %>" style="font-family: 'Press Start 2P', monospace;" readonly>
        </div>
        <div class="form-group">
          <label>Token</label>
          <input type="text" value="<%= request.getAttribute("identity") %>" style="font-family: 'Press Start 2P', monospace;" readonly>
        </div>
        <div class="form-group">
          <label>Nombre y Apellidos</label>
          <input id="nombreInput" type="text" value="<%= request.getAttribute("nombre") %>" style="font-family: 'Press Start 2P', monospace;">
          <input id="apellidoInput" type="text" value="<%= request.getAttribute("apellido") %>" style="font-family: 'Press Start 2P', monospace;">
        </div>
        <div class="form-group">
          <label>Email</label>
          <input id="emailInput" type="text" value="<%= request.getAttribute("email") %>" style="font-family: 'Press Start 2P', monospace;">
        </div>
        <!-- Eliminar cuenta (fuera de la tarjeta principal) -->
    <div class="card danger full-width">
      <h2>Eliminar cuenta</h2>
      <button type="button" class="btn-glow delete" id="deleteBtn" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'" style="font-family: 'Press Start 2P', monospace; font-size: 0.8rem; white-space: nowrap;">Eliminar Cuenta</button>
    </div>
      </div>
	  <!-- MENSAJE DE ERROR MEDIANTE EL CONTROLADOR AL ELIMINAR CUENTA -->
	    
	    <%
		    String deleteError = (String) session.getAttribute("deleteError");
		    if (deleteError != null) {
		%>	
			<br>
		    <div style="color: red; font-weight: bold; font-size: 0.8rem;">
		        <%= deleteError %>
		    </div>
		<%
		        session.removeAttribute("deleteError"); // Elimina el mensaje después de mostrarlo
		    }
		%>
      <!-- DERECHA: Información editable -->
      <div class="profile-right">
        <!-- Perfil público -->
        <div class="card">
		  <h2>Visibilidad</h2>
		  <label class="checkbox-label">
		    <input type="checkbox" id="perfilPublicoCheckbox"
		      <%-- Aquí marcamos el checkbox si todos los links están en Publico --%>
		      <% 
		         boolean todosPublicos = true;
		         for (EditProfile link : socialLinks) {
		             if (!"Publico".equalsIgnoreCase(link.getEstado())) {
		                 todosPublicos = false;
		                 break;
		             }
		         }
		         if (todosPublicos) { 
		      %> checked <% } %>
		    >
		    Hacer Perfil Público
		  </label>
		</div>

        <!-- Cambiar contraseña -->
        <div class="card">
		  <h2>Cambiar contraseña</h2>
		  <form action="<%= request.getContextPath() %>/cambiarPassword" method="POST" id="changePasswordForm">
		    <input id="passActual" name="passActual" type="password" placeholder="Contraseña actual" required style="font-family: 'Press Start 2P', monospace;">
		    <input id="passNueva" name="passNueva" type="password" placeholder="Nueva contraseña" required style="font-family: 'Press Start 2P', monospace;">
		    <input id="passConfirm" name="passConfirm" type="password" placeholder="Confirmar nueva contraseña" required style="font-family: 'Press Start 2P', monospace;">
		    <br><br>
		    <button type="submit" class="btn-glow btn-password" style="font-family: 'Press Start 2P', monospace; font-size: 0.8rem; white-space: nowrap;">
		      Actualizar contraseña
		    </button>
		  </form>
		</div>
		
		<%
		    if (session.getAttribute("errorPassword") != null) {
		%>
		    <div class="alert alert-danger"><%= session.getAttribute("errorPassword") %></div>
		<%
		        session.removeAttribute("errorPassword");
		    }
		
		    if (session.getAttribute("successPassword") != null) {
		%>
		    <div class="alert alert-success"><%= session.getAttribute("successPassword") %></div>
		<%
		        session.removeAttribute("successPassword");
		    }
		%>
		
        <!-- Redes sociales -->
        <div class="card">
          <h2>Redes sociales</h2>
          <div id="socialLinksContainer">
			  <% for (EditProfile link : socialLinks) { %>
			    <div class="form-group" data-id="<%= link.getId() %>">
			      <label><%= link.getTitleSocial() %></label>
			      <div class="link-content">
			        <img src="<%= request.getContextPath() %>/img/icons/<%= link.getSocialIcon() %>" alt="<%= link.getTitleSocial() %>">
			        <a href="<%= link.getUrlSocial() %>" target="_blank"><%= link.getUrlSocial() %></a>
			        <button class="btn-delete" data-id="<%= link.getId() %>">Eliminar</button>
			      </div>
			    </div>
			  <% } %>
			</div>
			<br>
          <button id="addSocialBtn" class="btn-glow" style="font-family: 'Press Start 2P', monospace;">Añadir red social</button>
        </div>
      </div>
    </section>

		<%
		    if (session.getAttribute("updateErrorProfile") != null) {
		%>
		    <div class="alert alert-danger"><%= session.getAttribute("updateErrorProfile") %></div>
		<%
		        session.removeAttribute("updateErrorProfile");
		    }
		
		    if (session.getAttribute("successMsg") != null) {
		%>
		    <div class="alert alert-success"><%= session.getAttribute("successMsg") %></div>
		<%
		        session.removeAttribute("successMsg");
		    }
		%>    
 <button type="button" id="updateProfileBtn" class="btn-glow yellow" style="font-family: 'Press Start 2P', monospace;">Guardar</button>
  </div>

<!-- POPUP -->
<div id="popup" class="popup-overlay hidden">
  <div class="popup-content">
    <div class="popup-header">
      <h3>LINKS</h3>
      <button id="closePopup">&times;</button>
    </div>
    <br>
    <div class="form-group">
      <label>Título</label>
      <input type="text" id="inputTitle" style="font-family: 'Press Start 2P', monospace;" required>
    </div>
    <br>
    <div class="form-group">
      <label>URL</label>
      <input type="text" id="inputURL" style="font-family: 'Press Start 2P', monospace;" required>
    </div>
    <br>
    <div class="form-group">
      <label>Selecciona un icono</label>
      <div id="iconSelectorWrapper" class="icon-selector-wrapper">
        <div id="selectedIcon" class="selected-icon">
          <span>Selecciona un icono</span>
        </div>
        <div id="iconSelector" class="icon-selector hidden">
          <img src="<%= request.getContextPath() %>/img/icons/instagram.png" data-icon="instagram" alt="Instagram">
          <img src="<%= request.getContextPath() %>/img/icons/youtube.png" data-icon="youtube" alt="YouTube">
          <img src="<%= request.getContextPath() %>/img/icons/x.png" data-icon="x" alt="X">
          <img src="<%= request.getContextPath() %>/img/icons/facebook.png" data-icon="facebook" alt="Facebook">
          <img src="<%= request.getContextPath() %>/img/icons/github.png" data-icon="github" alt="GitHub">
          <img src="<%= request.getContextPath() %>/img/icons/linkedin.png" data-icon="linkedin" alt="LinkedIn">
          <img src="<%= request.getContextPath() %>/img/icons/discord.png" data-icon="discord" alt="Discord">
          <img src="<%= request.getContextPath() %>/img/icons/website.png" data-icon="website" alt="Website">
        </div>
      </div>
    </div>
    <br>
    <button id="saveLink" class="btn-glow yellow">Guardar</button>
  </div>
</div>
<script src="<%= request.getContextPath() %>/js/jsEditProfile.jsp"></script>
<!-- PARA SCRIPT BONITO DE ELIMINAR CUENTA -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script>
  document.addEventListener('DOMContentLoaded', function () {
	  const popup = document.getElementById('popup');
	  const openPopupBtn = document.getElementById('addSocialBtn');
	  const closePopupBtn = document.getElementById('closePopup');
	  const selectedIconDiv = document.getElementById('selectedIcon');
	  const iconSelector = document.getElementById('iconSelector');
	  const socialLinksContainer = document.getElementById('socialLinksContainer');

	  let selectedIconKey = null;
	  const contextPath = '<%= request.getContextPath() %>';

	  openPopupBtn?.addEventListener('click', () => popup.classList.remove('hidden'));
	  closePopupBtn?.addEventListener('click', () => popup.classList.add('hidden'));

	  selectedIconDiv.addEventListener('click', function () {
	    iconSelector.classList.toggle('hidden');
	  });

	  iconSelector.querySelectorAll('img').forEach(function (img) {
	    img.addEventListener('click', function () {
	      selectedIconKey = img.getAttribute('data-icon') + ".png";
	      selectedIconDiv.innerHTML = '<img src="' + img.src + '" alt="' + selectedIconKey + '" style="width:30px; height:30px; object-fit:cover; border-radius:5px;">';
	      iconSelector.classList.add('hidden');
	    });
	  });

	  document.getElementById('saveLink').addEventListener('click', function () {
	    const titleInput = document.getElementById('inputTitle');
	    const urlInput = document.getElementById('inputURL');

	    const title = titleInput.value.trim();
	    const url = urlInput.value.trim();

	    if (!title || !url || !selectedIconKey) {
	      alert('Completa título, URL y selecciona un icono.');
	      return;
	    }

	    // Validación de máximo 5
	    if (socialLinksContainer.querySelectorAll('.form-group').length >= 5) {
	      alert("Solo puedes tener hasta 5 redes sociales.");
	      return;
	    }

	    const xhr = new XMLHttpRequest();
	    xhr.open('POST', contextPath + '/manageSocialLinks', true);
	    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

	    xhr.onload = function () {
	      if (xhr.status === 200) {
	        let response;
	        try {
	          response = JSON.parse(xhr.responseText); // Se espera { id: xxx }
	        } catch (e) {
	          alert('Error: respuesta no válida del servidor.');
	          return;
	        }
	        const newDiv = document.createElement('div');
	        newDiv.className = 'form-group';
	        newDiv.setAttribute('data-id', response.id);

	        newDiv.innerHTML =
	          '<label>' + title + '</label>' +
	          '<div style="display:flex; align-items:center; gap:10px;">' +
	          '<img src="' + contextPath + '/img/icons/' + selectedIconKey + '" alt="' + title + '" style="width:30px; height:30px; object-fit:cover; border-radius:5px;">' +
	          '<a href="' + url + '" target="_blank" style="color:#ccc;">' + url + '</a>' +
	          '<button class="btn-delete" data-id="' + response.id + '" style="margin-left:10px;">Eliminar</button>' +
	          '</div>';

	        socialLinksContainer.appendChild(newDiv);

	        titleInput.value = '';
	        urlInput.value = '';
	        selectedIconKey = null;
	        selectedIconDiv.innerHTML = '<span>Selecciona un icono</span>';
	        iconSelector.querySelectorAll('img').forEach(i => i.classList.remove('selected'));
	        popup.classList.add('hidden');
	      } else {
	        alert(xhr.responseText || 'Error guardando link.');
	      }
	    };

	    const params = 'action=add&title=' + encodeURIComponent(title) +
	      '&url=' + encodeURIComponent(url) +
	      '&icon=' + encodeURIComponent(selectedIconKey);
	    xhr.send(params);
	  });

	  // Eliminar con delegación de evento
	  socialLinksContainer.addEventListener('click', function (e) {
	    if (e.target.classList.contains('btn-delete')) {
	      const parentDiv = e.target.closest('.form-group');
	      const id = parentDiv.getAttribute('data-id');
	      console.log("Intentando eliminar ID:", id);

	      if (!id) {
	        alert('No se puede eliminar este elemento.');
	        return;
	      }

	      if (!confirm('¿Seguro que quieres eliminar este link?')) return;

	      const xhr = new XMLHttpRequest();
	      xhr.open('POST', contextPath + '/manageSocialLinks', true);
	      xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

	      xhr.onload = function () {
	        if (xhr.status === 200) {
	          parentDiv.remove();
	        } else {
	          alert('Error eliminando link.');
	        }
	      };

	      xhr.send('action=delete&id=' + encodeURIComponent(id));
	    }
	  });
	});

/* ACTUALIZAR INFORMACION DEL PERFIL */

 document.getElementById("updateProfileBtn").addEventListener("click", function () {
  const params = new URLSearchParams();
  params.append("nombre", document.getElementById("nombreInput").value.trim());
  params.append("apellido", document.getElementById("apellidoInput").value.trim());
  params.append("email", document.getElementById("emailInput").value.trim());

  fetch('<%= request.getContextPath() %>/editarPerfil', {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: params.toString()
  }).then(response => {
    if (response.ok) {
      alert("Perfil actualizado correctamente.");
      location.reload();
    } else {
      response.text().then(text => alert("Error: " + text));
    }
  }).catch(error => {
    console.error("Error al actualizar perfil:", error);
    alert("Error en la conexión con el servidor.");
  });
});

/* CAMBIAR A ESTADO PUBLICO */

 document.getElementById('perfilPublicoCheckbox').addEventListener('change', function() {
	  const nuevoEstado = this.checked ? 'Publico' : 'Privado';

	  const xhr = new XMLHttpRequest();
	  xhr.open('POST', '<%= request.getContextPath() %>/manageSocialLinks', true);
	  xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

	  xhr.onload = () => {
	    if (xhr.status !== 200) {
	      alert('Error actualizando la visibilidad de los links.');
	      // Revertir el cambio visual en el checkbox
	      this.checked = !this.checked;
	    } else {
	      // Opcional: recargar la página para actualizar estados o actualizar visualmente los estados si tienes UI para ello
	      location.reload();
	    }
	  };

	  xhr.send('action=updateAllEstados&nuevoEstado=' + encodeURIComponent(nuevoEstado));
	});


</script>
</body>
</html>