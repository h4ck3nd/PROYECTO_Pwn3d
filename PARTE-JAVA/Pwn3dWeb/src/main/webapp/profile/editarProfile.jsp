<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.ImgProfileDAO" %>
<%@ page import="model.ImgProfile" %>
<%@ page import="dao.EditProfileDAO" %>
<%@ page import="model.EditProfile" %>
<%@ page import="utils.JWTUtil" %>
<%
    Integer userId = null;
    try {
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
        if (token == null || !JWTUtil.validateToken(token)) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }
        userId = JWTUtil.getUserIdFromToken(token);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
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
  <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
  <style>
    body {
  margin: 0;
  font-family: 'Press Start 2P', monospace;
  font-size: 10px; /* Necesario porque la fuente es grande */
  line-height: 0.75rem;
  background-color: #0f0f11;
  color: #eee;
  display: flex;
  justify-content: center;
  padding: 2rem;
}
.welcome-card {
  display: flex;
  background-color: #1e1e1e;
  border: 2px solid #333;
  border-radius: 12px;
  box-shadow: 0 0 12px #000;
  padding: 2rem;
  gap: 2rem;
  margin: 2rem auto;
  width: 95%;
}

/* Lado izquierdo limpio, sin fondo total */
.profile-left {
  flex: 2.2;
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  align-items: center;
}

/* Avatar */
.avatar-box {
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.75rem; /* Añade espacio entre la imagen y el botón */
}

.avatar-image {
  width: 120px;
  height: 120px;
  border-radius: 8px;
  border: 2px solid #444;
  margin-bottom: 0.5rem;
}

/* Lado derecho */
.profile-right {
  flex: 2.6;
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

/* Tarjeta de eliminar cuenta (fuera de la sección principal) */
.full-width {
  max-width: 100px;
  margin: 2rem auto;
  padding: 1.5rem;
  border-radius: 12px;
  background-color: #1e1e1e;
  box-shadow: 0 0 10px #000;
  border: 2px solid #333;
}

.container {
  width: 100%;
  max-width: 800px;
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.card {
  background: #1b1b1e;
  border-radius: 16px;
  padding: 2rem;
  box-shadow: 0 0 20px rgba(255, 0, 128, 0.1);
  width: 80%;
  gap: 50px;
  line-height: 1.4rem;
}

.card.danger {
  border: 1px solid #ff4c4c;
  background: #1e1113;
  max-width: 95% !important;
  font-size: 1rem !important;
}

.avatar-container {
  text-align: center;
}

.avatar-container img {
  width: 100px;
  border-radius: 50%;
  margin-bottom: 1rem;
}

.form-group {
  display: flex;
  flex-direction: column;
  margin-bottom: 1rem;
}

.form-group label {
  margin-bottom: 0.5rem;
  color: #aaa;
}

input, select {
  background-color: #2a2a2d;
  border: none;
  border-radius: 8px;
  padding: 0.8rem;
  color: #fff;
  margin-top: 15px;
}

.card {
  background: #1b1b1e;
  border-radius: 16px;
  padding: 2rem;
  box-shadow: 0 0 20px rgba(255, 0, 128, 0.1);
  margin-bottom: 2rem;
  text-align: center;
}

.card h2 {
  margin-bottom: 1.5rem;
  font-size: 1.1rem;
  color: #ff4dd8;
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 1rem;
  margin-bottom: 1.5rem;
}

.btn-glow {
  padding: 0.8rem 1.5rem;
  background: #ff4dd8;
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-weight: bold;
  transition: all 0.3s;
  box-shadow: 0 0 10px rgba(255, 77, 216, 0.6);
}

.btn-glow:hover {
  background: #e03cc0;
  box-shadow: 0 0 20px rgba(255, 77, 216, 0.8);
}

input:focus, select:focus {
  outline: 2px solid #ff4dd8;
}

.checkbox-label {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin: 1rem 0;
}

.grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
}

.btn-glow {
  padding: 0.8rem 1.5rem;
  background: #ff4dd8;
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-weight: bold;
  transition: all 0.3s;
  box-shadow: 0 0 10px rgba(255, 77, 216, 0.6);
}

.btn-password {
  margin-top: 10px;
}

.btn-glow:hover {
  background: #e03cc0;
  box-shadow: 0 0 20px rgba(255, 77, 216, 0.8);
}

.btn-glow.delete {
  background: #ff4c4c;
  box-shadow: 0 0 10px rgba(255, 77, 77, 0.6);
}

.btn-glow.delete:hover {
  background: #e03a3a;
}

/* Base: fondo oscuro estilo retro */
.popup-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(10, 10, 20, 0.8);
  backdrop-filter: blur(4px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 999;
}

#closePopup,
#saveLink.btn-glow {
  font-family: 'Press Start 2P', monospace !important;
  font-size: 0.75rem;
  letter-spacing: 0.5px;
  text-transform: uppercase;
}


/* Tarjeta del popup */
.popup-content {
  background: linear-gradient(145deg, #1b1b2f, #222);
  color: #ccc;
  border: 1px solid #2d2d4d;
  border-radius: 12px;
  padding: 20px 24px;
  width: 100%;
  max-width: 420px;
  box-shadow: 0 0 18px #000;
  position: relative;
}

/* Cabecera */
.popup-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid #333;
  margin-bottom: 15px;
}

.popup-header h3 {
  margin: 0;
  color: #e0b0ff; /* morado suave */
  font-size: 1.2rem;
  text-shadow: 0 0 3px #a64ef3;
}

#closePopup {
  background: none;
  border: none;
  color: #888;
  font-size: 20px;
  cursor: pointer;
  transition: color 0.2s ease;
}
#closePopup:hover {
  color: #e0b0ff;
}

/* Campos del formulario */
.form-group {
  margin-bottom: 15px;
}

.form-group label {
  display: block;
  margin-bottom: 6px;
  color: #aaa;
  font-size: 0.9rem;
  align-items: center;
}

/* Estilo general del label */
.checkbox-label {
  display: flex;
  align-items: center;      /* Centra verticalmente */
  justify-content: center;  /* Centra horizontalmente */
  gap: 0.5rem;
  font-size: 0.8rem;
  cursor: pointer;
  width: 100%;              /* Ocupa todo el ancho del contenedor padre */
}

/* Oculta el checkbox nativo */
.checkbox-label input[type="checkbox"] {
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  width: 20px;
  height: 20px;
  border: 2px solid #ff4dd8;
  border-radius: 4px;
  background-color: #111;
  position: relative;
  cursor: pointer;
  transition: all 0.2s ease;
  display: grid;
  place-content: end; /* Centra el contenido */

}

/* Marca de verificación */
.checkbox-label input[type="checkbox"]::after {
  content: '';
  width: 10px;
  height: 15px;
  border-right: 2px solid #ff4dd8;
  border-bottom: 2px solid #ff4dd8;
  transform: rotate(45deg);
  opacity: 0;
  transition: opacity 0.2s ease;
}

/* Mostrar el tick cuando está activado */
.checkbox-label input[type="checkbox"]:checked::after {
  opacity: 1;
}

.form-group input[type="text"] {
  width: 100%;
  padding: 8px 10px;
  background: #111;
  border: 1px solid #2e2e48;
  border-radius: 6px;
  color: #e0e0e0;
  font-size: 0.95rem;
  transition: border-color 0.2s ease;
}
.form-group input[type="text"]:focus {
  border-color: #a64ef3;
  outline: none;
}

/* Icon selector wrapper */
.selected-icon {
  display: flex;
  align-items: center;
  gap: 10px;
  background: #161622;
  padding: 8px;
  border: 1px solid #333;
  border-radius: 6px;
  cursor: pointer;
  transition: border-color 0.2s ease;
}
.selected-icon:hover {
  border-color: #a64ef3;
}
.selected-icon img {
  width: 28px;
  height: 28px;
  object-fit: cover;
  border-radius: 4px;
}

/* Selector de iconos (desplegable) */
.icon-selector {
  display: grid;
  grid-template-columns: repeat(auto-fill, 40px);
  gap: 10px;
  margin-top: 10px;
  padding-top: 5px;
}

.icon-selector img {
  width: 40px;
  height: 40px;
  cursor: pointer;
  border-radius: 6px;
  padding: 4px;
  background: #2d2d4d;
  transition: all 0.2s ease;
  border: 2px solid transparent;
}

.icon-selector img:hover {
  background: #3a3a5c;
}

.icon-selector img.selected {
  border-color: #a64ef3;
  background: #1c1c30;
}

/* Botón de guardar */
#saveLink.btn-glow {
  width: 100%;
  padding: 10px;
  background: #a64ef3;
  color: #fff;
  font-weight: bold;
  border: none;
  border-radius: 8px;
  text-shadow: 0 0 2px #000;
  cursor: pointer;
  box-shadow: 0 0 10px #a64ef3a6;
  transition: background 0.3s ease, box-shadow 0.3s ease;
}

#saveLink.btn-glow:hover {
  background: #c77aff;
  box-shadow: 0 0 16px #d9aaff;
}

/* Ocultar elementos */
.hidden {
  display: none !important;
}
/* ESTILOS PARA EL POPUP DE ELIMINAR CUENTA */
    
    @import url('https://fonts.googleapis.com/css2?family=Fira+Code:wght@400;600&display=swap');
    .neon-popup {
        font-family: 'Fira Code', monospace;
        font-weight: 600;
        font-size: 1rem;
        text-align: center;
    }
    .swal2-dark-popup {
	    box-shadow: 0 0 20px rgba(229, 83, 83, 0.7);
	    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	    border-radius: 12px;
	}
	.alert-danger {
		color: red;
	}
	.alert-success {
		color: green;
	}
	
	 #socialLinksContainer {
    display: flex;
    flex-direction: column; /* columna vertical */
    gap: 15px; /* separación entre links */
  }

  .form-group {
    /*background: #222;*/
    padding: 10px;
    border-radius: 8px;
    color: #eee;
  }

  .form-group > label {
    font-weight: bold;
    margin-bottom: 6px;
    display: block;
  }

  .link-content a {
  color: #ccc;
  flex-grow: 1;
  text-decoration: none;
  white-space: nowrap;        /* Evita que el texto se rompa en varias líneas */
  overflow: hidden;           /* Oculta el desbordamiento */
  text-overflow: ellipsis;    /* Muestra "..." si el texto es muy largo */
  font-size: clamp(6px, 1vw, 12px); /* Tamaño adaptable, nunca menor a 12px ni mayor a 16px */
}


  .link-content img {
    width: 30px;
    height: 30px;
    object-fit: cover;
    border-radius: 5px;
  }

  .link-content a {
    color: #ccc;
    flex-grow: 1;
    text-decoration: none;
    word-break: break-all;
  }

  .btn-delete {
    background-color: #e74c3c;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    transition: background-color 0.3s ease;
    margin-left: 10px;
  }

  .btn-delete:hover {
    background-color: #c0392b;
  }
	
  </style>
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

/* ELIMINAR CUENTA */

document.getElementById('deleteBtn').addEventListener('click', function () {
   Swal.fire({
       title: '¿Eliminar cuenta?',
       text: "Esta acción no se puede deshacer.",
       icon: 'warning',
       input: 'text',
       inputPlaceholder: 'Escribe "delete account" para confirmar',
       inputAttributes: {
           autocapitalize: 'off',
           autocorrect: 'off',
           spellcheck: 'false'
       },
       showCancelButton: true,
       confirmButtonColor: '#e55353',  // rojo vibrante pero elegante
       cancelButtonColor: '#6c757d',   // gris neutro para cancelar
       confirmButtonText: 'Sí, eliminar',
       cancelButtonText: 'Cancelar',
       background: '#1e1e2f',  // fondo oscuro azulado
       color: '#f8f9fa',       // texto claro
       customClass: {
           popup: 'swal2-dark-popup'
       },
       preConfirm: (inputValue) => {
           if (inputValue !== 'delete account') {
               Swal.showValidationMessage('La frase no coincide. Intenta de nuevo.');
           }
       }
   }).then((result) => {
       if (result.isConfirmed) {
           document.getElementById('deleteForm').submit();
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

/* SI NO COINCIDEN LAS CONTRASEÑAS */
 
 document.getElementById('changePasswordForm').addEventListener('submit', function(e) {
   const passNueva = document.getElementById('passNueva').value.trim();
   const passConfirm = document.getElementById('passConfirm').value.trim();
   if (passNueva !== passConfirm) {
     e.preventDefault(); // detiene el envío
     alert('La nueva contraseña y su confirmación no coinciden.');
   }
 });

/* VALIDACION IMG */

 document.getElementById('avatarInput').addEventListener('change', function () {
     console.log("[DEBUG] Archivo seleccionado: ", this.files[0]);
     document.getElementById('avatarForm').submit();
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