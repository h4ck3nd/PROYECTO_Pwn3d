<%@page import="controller.MachineDetailsServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Machine" %>
<%@ page import="dao.ImgProfileDAO" %>
<%@ page import="model.ImgProfile" %>
<%@ page import="dao.EditProfileDAO" %>
<%@ page import="utils.JWTUtil" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="java.util.Map" %>

<%
	Machine machine = null;

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
<html lang="es">
<meta http-equiv="content-type" content="text/html;charset=UTF-8" />
<head>
<meta charset="utf-8">
<link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
<link rel="canonical" href="<%= request.getContextPath() %>/machines.jsp">
<title>Machines - Pwn3d!</title>
<script async defer src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!--<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_machines134.css">-->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssMachines.jsp">
<style>
    #loader {
      position: fixed;
      top: 0; left: 0; right: 0; bottom: 0;
      background: rgba(42, 14, 56, 1);
      color: white;
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: 1.5em;
      z-index: 9999;
    }
  </style>
</head>
<body>

<!-- PANTALLA DE CARGA -->

<div id="loader">Cargando contenido...</div>

<!-- MENU DE HABURGUESA -->

    <button id="hamburger" class="menu-toggle" style="display: none; font-size: 3rem !important;">☰</button>
    <div id="sidebarWrapper" class="sidebar-wrapper open">
        <aside class="sidebar">
          <!-- Botón de cerrar -->
          <button id="closeMenu" class="menu-close" style="font-size: 1.4rem !important;">❌</button>
          <div class="profile">
            <img src="<%= imgSrc %>" alt="Avatar" class="avatar-image" />
            <p style="font-size: 1.2rem !important; line-height: 30px !important;"><strong style="font-size: 1.4rem !important;">Username:</strong> <%= nombreUsuario %></p>
          </div>
          <hr>
      <nav class="menu">
      <!-- Seccion Usuarios -->
      	<a href="<%= request.getContextPath() %>/perfil" style="font-size: 1.3rem !important;">
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
        <a href="<%= request.getContextPath() %>/stats" style="font-size: 1.3rem !important;">
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
        <a href="<%= request.getContextPath() %>/machines.jsp" style="color: #b600ff; text-decoration:none; display:inline-flex; align-items:center; gap:8px; font-size: 1.3rem !important;">
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
		
		<a href="<%= request.getContextPath() %>/feedbacks-requests/request.jsp" style="color: #b600ff; text-decoration:none; display:inline-flex; align-items:center; gap:8px; font-size: 1.3rem !important;">
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
		
		<a href="<%= request.getContextPath() %>/ranking.jsp" style="color: #b600ff; text-decoration:none; display:inline-flex; align-items:center; gap:8px; font-size: 1.3rem !important;">
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
		        font-size: 1rem !important;
		        margin-top: 50px !important;
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

<!-- CONTENIDO DE LA PAGINA PRINCIPAL -->

		<section class="header-container">
		
				<!-- BOTÓN AGRUPADO -->
				
			   <!--  <div class="header-controls">
			    
			    [!-- LOGO --]
		        
		        <article class="pwned-header">
	  				<img src="<%= request.getContextPath() %>/img/logo-flag-white.png" alt="Pwned Icon" class="pwned-icon" />
		            <h2 class="pwned-title"></h2>
		        </article>
		        -->
		        <div class="header-controls">
		        
			      <!-- BOTÓN MODO CLARO/OSCURO -->
			      
			      <button title="Alternar entre Claro/Oscuro" id="toggle-theme" class="toggle-button" aria-label="Toggle theme" style="display: none;">
			        <svg viewBox="0 0 100 100" class="theme-icon">
			          <circle cx="50" cy="50" r="40" class="circle-bg" />
			          <path d="M50,10 A40,40 0 1,1 49.9,10 Z" class="half" />
			        </svg>
			      </button>
			      
			      <!-- BOTÓN ADMIN (VALIDACION ROL = admin) -->
			       
				    <%
					    // Obtener la cookie 'token' del request
					    Cookie[] cookies = request.getCookies();
					    if (cookies != null) {
					        for (Cookie cookie : cookies) {
					            if ("token".equals(cookie.getName())) {
					                token = cookie.getValue();
					                break;
					            }
					        }
					    }
					
					    String role = null;
					    if (token != null && JWTUtil.validateToken(token)) {
					        try {
					            role = JWTUtil.getRoleFromToken(token);
					        } catch (Exception e) {
					            role = null;
					            // Opcional: imprimir error para debug
					            e.printStackTrace();
					        }
					    }
					%>
					
					<!-- Mostrar botón solo si rol es admin -->
					
					<% if ("admin".equals(role)) { %>
					    <button 
					      type="button" 
					      class="admin-btn" 
					      onclick="window.location.href='<%= request.getContextPath() %>/paginasDeAdministracioneWeb/agregarVM.jsp'">
					      Agregar VM
					    </button>
					<% } %>
				</div>
			</section>
			
			<br>
			
		<!-- SECCION PARA ENVIAR VM -->
			
			<section class="form-vm">
			  <div class="wizard-vm-container">
			    <div class="wizard-vm-header">
			      <img src="<%= request.getContextPath() %>/img/logo-prueba.png" class="vb-icon" />
			      <span class="wizard-vm-title">Nuevo envío de VM</span>
			      <span class="close-form" onclick="document.querySelector('.close-form').style.display='none'">&times;</span>
			    </div>
			    <div class="wizard-vm-inner">
			      <div class="wizard-vm-side">
			        <img src="<%= request.getContextPath() %>/img/banner-ctf.png" 
				     class="vb-icon-send-vm" 
				     style="height: 180px; max-width: 90%; display: block; margin: 20px auto; object-fit: contain;" 
				     alt="VirtualBox Logo" />
			      </div>
			      <div class="wizard-vm-content">
			        <p class="wizard-vm-subtext">
			          Complete el formulario con toda la información sobre su máquina virtual. Si desea comentarios sobre su subida, contáctenos.
			        </p>
			        <form id="wizardVmForm" class="wizard-vm-form-steps">
			
			          <!-- Nombre y Creador -->
			          <div class="wizard-vm-field-group">
			            <div class="wizard-vm-field">
			              <label for="wizard-vm-name">Nombre</label>
			              <input id="wizard-vm-name" name="Name" type="text" maxlength="20" placeholder="Nombre de la máquina" required />
			            </div>
			            <div class="wizard-vm-field">
			              <label for="wizard-vm-creator">Creador</label>
			              <input id="wizard-vm-creator" name="Creator" type="text" maxlength="15" placeholder="Nombre de usuario" required />
			            </div>
			          </div>
			
			          <!-- Dificultad y URL -->
			          <div class="wizard-vm-field-group">
			            <div class="wizard-vm-field">
			              <label for="wizard-vm-level">Dificultad</label>
			              <select id="wizard-vm-level" name="Level" required>
			                <option value="Very-Easy">Very Easy</option>
			                <option value="Easy">Easy</option>
			                <option value="Medium">Medium</option>
			                <option value="Hard">Hard</option>
			              </select>
			            </div>
			            <div class="wizard-vm-field">
			              <label for="wizard-vm-url">VM URL (HTTPS)</label>
			              <input id="wizard-vm-url" name="URL" type="url" pattern="https?://.+" placeholder="URL de VM pública (Drive, Mega...)" required />
			            </div>
			          </div>
			
			          <!-- Flags -->
			          <div class="wizard-vm-field-group">
			            <div class="wizard-vm-field">
			              <label for="wizard-user-flag">Flag Usuario</label>
			              <input id="wizard-user-flag" name="UserFlag" type="text" maxlength="32" placeholder="Flag del usuario" required />
			            </div>
			            <div class="wizard-vm-field">
			              <label for="wizard-root-flag">Flag Root</label>
			              <input id="wizard-root-flag" name="RootFlag" type="text" maxlength="32" placeholder="Flag de root" required />
			            </div>
			          </div>
			
			          <!-- Writeup y Contacto -->
			          <div class="wizard-vm-field-group">
			            <div class="wizard-vm-field">
			              <label for="wizard-writeup-url">Writeup URL (HTTPS)</label>
			              <input id="wizard-writeup-url" name="Solution" type="url" pattern="https?://.+" placeholder="URL del writeup (Word, GitHub, Drive...)" style="font-size: 1rem !important;" />
			            </div>
			            <div class="wizard-vm-field">
			              <label for="wizard-contact">Contacto</label>
			              <input id="wizard-contact" name="Contact" type="text" maxlength="32" placeholder="email, Discord, etc..." />
			            </div>
			          </div>
			
			          <!-- Tags -->
			          <div class="wizard-vm-field">
			            <label for="wizard-tags">Tags</label>
			            <textarea id="wizard-tags" name="Tags" maxlength="200" rows="2" placeholder="Tags separadas por comas"></textarea>
			          </div>
			
			          <!-- Botones -->
			          <div class="wizard-vm-buttons">
			            <button type="submit">Enviar</button>
			            <button type="reset">Borrar</button>
			          </div>
			
			          <!-- Footer -->
			          <div class="wizard-vm-footer">
			            <small>Por favor, lea nuestras 
			              <a href="https://vulnyx.com/rules/" target="_blank">
			                <strong>Reglas</strong>
			              </a> antes de enviar una nueva VM.
			            </small>
			          </div>
			        </form>
			      </div>
			    </div>
			  </div>
			</section>
		
		<!-- IMAGEN DE LA PAGINA DE MAQUINAS PRINCIPAL -->
		
		<div id="machinesStatsContainer"></div>

		<script>
		  document.addEventListener("DOMContentLoaded", function () {
		    document.querySelectorAll('.progress-fill-img-machines').forEach(bar => {
		      const width = bar.getAttribute('data-width');
		      if (width) {
		        // Forzamos reflow antes de aplicar el ancho para que el transition funcione
		        void bar.offsetWidth;
		        bar.style.width = width + '%';
		      }
		    });
		  });
		</script>
		
	<main class="main-content">
		<section class="wrapper">
		<br><br>
			<article class="actions">
			
				<!-- BARRA DE BUSQUEDA -->
					
				    <div id="vm-search-wrapper">
				        <div class="search-icon">
				            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-search" width="24" height="24" viewBox="0 0 24 24" stroke-width="2.5" stroke="#999999" fill="none" stroke-linecap="round" stroke-linejoin="round">
				                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
				                <path d="M10 10m-7 0a7 7 0 1 0 14 0a7 7 0 1 0 -14 0" />
				                <path d="M21 21l-6 -6" />
				            </svg>
				        </div>
				        <input title="Buscar VM..." id="vm-search" type="text" placeholder="Buscar por nombre, dificultad, creador..." aria-label="search" />
				        <button class="clear-search" title="Limpiar Busqueda" onclick="clearSearch()">Clear</button>
				    </div>
				
				<!-- HEADER ENCIMA DE LA ZONA DE MAQUINAS -->
				
				<div class="filters">
				
				<!-- STATS -->
				
				<ul class="vm-stats" id="vmStatsContainer"></ul>
				
				<!-- FILTROS -->
				
				    <div class="filter-wrapper">
				        
				        <!-- Botón para abrir el popup Filtro -->
				        
						<button title="Filtrar" type="button" class="filter-by" onclick="openFilterPopup()">
						<svg xmlns="http://www.w3.org/2000/svg" 
						     width="24" height="24" 
						     viewBox="0 0 24 24" 
						     fill="none" 
						     stroke="currentColor" 
						     stroke-width="2" 
						     stroke-linecap="round" 
						     stroke-linejoin="round" 
						     class="feather feather-filter">
						  <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"/>
						</svg></button>
						
						<!-- Filtro en forma de popup -->
						
						<div id="filterPopup" class="popup-overlay-filter">
						  <div class="popup-content-filter">
						    <button class="close-btn-filter" onclick="closeFilterPopup()">×</button>
						    <h3>Filtrar máquinas</h3>
						    <div class="filter-options">
						      <div class="level-filter">
						        <input type="checkbox" id="very-easy" name="very-easy" />
						        <label for="very-easy">Very Easy</label>
						      </div>
						      <div class="level-filter">
						        <input type="checkbox" id="easy" name="easy" />
						        <label for="easy">Easy</label>
						      </div>
						      <div class="level-filter">
						        <input type="checkbox" id="medium" name="medium" />
						        <label for="medium">Medium</label>
						      </div>
						      <div class="level-filter">
						        <input type="checkbox" id="hard" name="hard" />
						        <label for="hard">Hard</label>
						      </div>
						      <div class="os-filter">
						        <input type="checkbox" id="linux" name="linux" />
						        <label for="linux">Linux</label>
						      </div>
						      <div class="os-filter">
						        <input type="checkbox" id="windows" name="windows" />
						        <label for="windows">Windows</label>
						      </div>
						      <div class="size-sort-filter" style="margin-top: 10px;">
								  <label for="sizeSort">Ordenar por tamaño:</label>
								  <br><br>
								  <select id="sizeSort">
								    <option value="">-- Sin orden --</option>
								    <option value="asc">Menor a mayor</option>
								    <option value="desc">Mayor a menor</option>
								  </select>
								</div>
						    </div>
						    <button onclick="applyFilters()">Aplicar</button>
						  </div>
						</div>
				    </div>
				    
				    <!-- BOTON DE ENVIO NEW VM -->
				
				    <button type="button" class="submit-btn" onclick="showVMForm()">Envío de VM</button>
				</div>
				
			<!-- ZONA DE MAQUINAS -->
			
			</article>
			
			<!-- HEADER DE ZONA DE MAQUINAS -->
			
			<div id="vm-table-wrapper">
				<table id="vm-table">
					<thead>
						<tr>
							<th id="idnum">#</th>
							<th id="card">Info</th>
							<th class="vm-name" style="text-align: center;">Nombre/Tamaño</th>
							<th id="tested">Entorno</th>
							<th class="url">MD5</th>
							<th id="md5">Writeups</th>
							<th class="first-user">Creador</th>
							<th class="firts-flags">Primer User/Root</th>
							<th class="flag">Flag</th>
							<th id="writeups">Valoración</th>
							<th id="writeups">Descarga</th>
						</tr>
					</thead>
					
					<!-- MAQUINAS -->
					
					<tbody>
						<script>
						    let writeupsArr = [];
						    let writeupObj = {};
						</script>
						<tr class="row" data-machine-id="1">
						    <td colspan="1">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Lower5...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="2">
						    <td colspan="2">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Change...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="3">
						    <td colspan="3">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Anon...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="4">
						    <td colspan="4">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Hit...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="5">
						    <td colspan="5">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Matrix...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="6">
						    <td colspan="6">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Tunnel...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="7">
						    <td colspan="7">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina War...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="8">
						    <td colspan="8">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Manager...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="9">
						    <td colspan="9">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Controler...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						  <tr class="row" data-machine-id="10">
						    <td colspan="10">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina testMachine...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="11">
						    <td colspan="11">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina r00tless...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="12">
						    <td colspan="12">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina goodness...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="13">
						    <td colspan="13">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina nullMachine...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="14">
						    <td colspan="14">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina avengers...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="15">
						    <td colspan="15">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina CrackOff...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="16">
						    <td colspan="16">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina 404-not-found...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="17">
						    <td colspan="17">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina PressEnter...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="18">
						    <td colspan="18">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Memesploit...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="19">
						    <td colspan="19">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina HackMeDaddy...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="20">
						    <td colspan="20">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Mapache2...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="21">
						    <td colspan="21">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Jenkhack...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="22">
						    <td colspan="22">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina chmod-4755...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="23">
						    <td colspan="23">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina hackzones...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="24">
						    <td colspan="24">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina darkweb...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="25">
						    <td colspan="25">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Flow...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="26">
						    <td colspan="26">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Sender...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="27">
						    <td colspan="27">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Cracker...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="28">
						    <td colspan="28">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Express...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="29">
						    <td colspan="29">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina CineHack...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="30">
						    <td colspan="30">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina LifeOrDead...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="31">
						    <td colspan="31">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina TpRoot...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="32">
						    <td colspan="32">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Gitea...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="33">
						    <td colspan="33">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina SecureLAB...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="34">
						    <td colspan="34">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina Goodness...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="35">
						    <td colspan="35">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina LogisticCloud...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
						<tr class="row" data-machine-id="36">
						    <td colspan="36">
						    <div class="loading-container">
						      <div class="liquid-loader dark">
						        <span>Cargando la máquina GhostCTF...</span>
						        <div class="liquid"></div>
						        <div class="wave"></div>
						      </div>
						    </div>
						</tr>
					</tbody>
				</table>
				<p id="search-message" style="display:none;">
				  No hay coincidencias para <span id="query"></span>. Pruebe con otra búsqueda.
				</p>
			</div>
			
			<!-- SECCION DE ENVIAR WRITEUP -->
			
			<section class="form-writeup">
			  <div class="virtualbox-container">
			    <!-- Header superior blanco -->
			    <div class="vb-header">
			      <img src="<%= request.getContextPath() %>/img/logo-prueba.png" class="vb-icon" />
			      <button class="vb-close" onclick="closeWriteupForm()">×</button>
			      <span>Añadir Writeup</span>
			    </div>
			
			    <div class="vb-inner">
			      <!-- Lado izquierdo decorativo -->
			      <div class="vb-side-image">
			        <img src="<%= request.getContextPath() %>/img/banner-ctf.png" alt="Banner CTF" />
			        
			      </div>
			
			      <!-- Contenido del formulario -->
			      <div class="vb-content">
			        <h2 class="vb-title">Nombre y sistema operativo de la máquina virtual</h2>
			        <p class="vb-subtext">
			          Complete todos los campos del formulario con la información de su informe. Después de la revisión, si el informe cumple con nuestras reglas de envío, el artículo estará disponible públicamente en el sitio web para cualquier usuario.
			        </p>
			
			        <form class="submit-form" id="writeupForm">
			          <div class="vb-field">
			            <label for="writeup-creator">Creador</label>
			            <input id="writeup-creator" name="Creator" type="text" maxlength="15" placeholder="Nombre de usuario" required />
			          </div>
			
			          <div class="vb-field">
						  <label for="writeup-url">URL (solo HTTPS)</label>
						  <input
						    id="writeup-url"
						    name="URL"
						    type="url"
						    placeholder="https://example.com/writeup"
						    pattern="https://.*"
						    title="La URL debe comenzar con https://"
						    required
						  />
						</div>
			
			          <div class="vb-field">
			            <span>Tipo de contenido</span>
			            <div class="vb-radio">
			              <input type="radio" id="text" name="ContentType" value="Text" checked />
			              <label for="text">Texto</label>
			              <input type="radio" id="video" name="ContentType" value="Video" />
			              <label for="video">Video</label>
			            </div>
			          </div>
			
			          <div class="vb-field">
			            <label for="language">Idioma</label>
			            <select id="language" name="Language" required>
			              <option value="EN">English</option>
			              <option value="ES">Español</option>
			              <option value="FR">Français</option>
			              <option value="DE">Deutsch</option>
			              <option value="PT">Português</option>
			              <option value="ZH">Chinese</option>
			              <option value="Other">Other</option>
			              <option value="None">None (Just Video)</option>
			            </select>
			          </div>
			
			          <div class="vb-field">
			            <label for="opinion">Opinion (Opcional)</label>
			            <textarea id="opinion" name="Opinion" maxlength="2000" rows="2" placeholder="Tu opinión solo se compartirá con el equipo de Pwn3d! y será útil como retroalimentación. Usted es libre de revisar o calificar la máquina como desee."></textarea>
			          </div>
			
			          <div class="vb-buttons">
			            <button type="submit">Enviar</button>
			            <button type="reset">Borrar</button>
			          </div>
			
			          <div class="vb-footer">
			            <small>
			              Por favor, lea nuestras
			              <a href="https://vulnyx.com/rules/" target="_blank"><strong>Reglas</strong></a>
			              antes de enviar un nuevo writeup.
			            </small>
			          </div>
			        </form>
			      </div>
			    </div>
			  </div>
			</section>
			<br>
			
			<!-- SECCION DE ENVIAR FLAGs -->

			<section class="form-flag">
			  <div class="form-container">
			    <!-- Botón de cierre -->
			    <span class="close-form-flag" style="margin-bottom: -30px !important; margin-top: -10px !important; margin-right: -40rem !important;">&times;</span>
			
			    <!-- Título -->
			    <div class="form-title">
			      <h1 style="font-size: 20px !important; color: #f26e56 !important; font-style: bold !important; margin-bottom: -12px !important;">Enviar Flag</h1>
			    </div>
			
			    <!-- Descripción -->
			    <p class="form-text" style="font-size: 12px !important; margin-bottom: -25px !important; line-height: 1.6 !important;">
			      Ingrese su nombre de usuario y la flag correspondiente. No garantiza prioridad si otros ya enviaron antes.
			    </p>
			
			    <!-- Formulario -->
			    <form class="form submit-form" id="flagForm" method="POST" action="<%= request.getContextPath() %>/submitFlag">
			      <input type="hidden" id="vmName" name="vmName" value="" />
			      <!-- Campo: Usuario -->
			      <div class="form-field" style="margin-bottom: -5px !important; margin-top: 5px !important;">
			        <label class="form-label" for="username" style="margin-bottom: 5px !important;">Usuario</label>
			        <input
			          class="form-control"
			          id="username"
			          name="username"
			          type="text"
			          maxlength="15"
			          placeholder="Nombre de usuario"
			          required
			          autocomplete="username"
			        />
			      </div>
			      <br>
			
			      <!-- Campo: Flag -->
			      <div class="form-field" style="margin-bottom: -5px !important; margin-top: 10px !important;">
			        <label class="form-label" for="flag" style="margin-bottom: 5px !important;">Flag</label>
			        <input
			          class="form-control"
			          id="flag"
			          name="flag"
			          type="text"
			          maxlength="64"
			          placeholder="Ejemplo: PWNED{example_flag}"
			          required
			        />
			      </div>
			      <br>
			
			      <!-- Selector: Tipo de Flag -->
			      <div class="form-field" style="margin-bottom: -5px !important; margin-top: 10px !important;">
			        <span class="form-label" style="margin-bottom: 5px !important;">Tipo de flag</span>
			        <div class="form-checkbox" id="flag-type">
			          <input type="radio" id="user" name="flagType" value="user" checked />
			          <label for="user" style="margin-bottom: -5px !important;">User</label>
			          <input type="radio" id="root" name="flagType" value="root" />
			          <label for="root" style="margin-bottom: -5px !important;">Root</label>
			        </div>
			      </div>
			      <br>
			
			      <!-- Botones -->
			      <div class="form-btns" style="margin-bottom: 5px !important; margin-top: 10px !important;">
			        <button class="button" type="submit">Enviar</button>
			        <button class="button" type="reset">Borrar</button>
			      </div>
			
			      <!-- Footer -->
			      <div class="form-footer" style="margin-bottom: -5px !important; margin-top: 20px !important;">
			        <small style="font-size: 0.75rem !important">
			          Este formulario valida las flags automáticamente. Mostrando asi los primeros usuarios que registran la flag.
			        </small>
			      </div>
			    </form>
			  </div>
			</section>
		</section>
	</main>
	<footer>
		<img src="<%= request.getContextPath() %>/img/logo-flag-white.png" alt="Pwn3d! small footer logo" loading="lazy" style="width: 25px !important; height: 25px !important;">
		<p>© Pwn3d! 2024-2025</p>
		
		<!-- REDES SOCIALES -->
		
		<article class="project-info">
	        
	            <!-- RRSS (Redes Sociales) -->
	            
	            <div class="media-links">
	            
	                <!-- Ko-fi -->
	                
	                <a title="Support us on Ko-fi" href="https://ko-fi.com/pwn3d" target="_blank">
	                    <img width="28" height="24" src="https://storage.ko-fi.com/cdn/kofi_stroke_cup.svg" alt="Ko-fi Logo" loading="eager">
	                </a>
	
	                <!-- DISCORD -->
	                
	                <a title="Discord" href="https://discord.gg/86kj9wKkkv" target="_blank">
	                    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-brand-discord" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#5865F2" fill="none" stroke-linecap="round" stroke-linejoin="round">
	                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
	                        <circle cx="9" cy="12" r="1" />
	                        <circle cx="15" cy="12" r="1" />
	                        <path d="M7.5 7.5c3.5 -1 5.5 -1 9 0" />
	                        <path d="M7 16.5c3.5 1 6.5 1 10 0" />
	                        <path d="M15.5 17c0 1 1.5 3 2 3c1.5 0 2.833 -1.667 3.5 -3c.667 -1.667 .5 -5.833 -1.5 -11.5c-1.457 -1.015 -3 -1.34 -4.5 -1.5l-1 2.5" />
	                        <path d="M8.5 17c0 1 -1.356 3 -1.832 3c-1.429 0 -2.698 -1.667 -3.333 -3c-.635 -1.667 -.476 -5.833 1.428 -11.5c1.388 -1.015 2.782 -1.34 4.237 -1.5l1 2.5" />
	                    </svg>
	                </a>
	
	                <!-- LinkedIn -->
	                
	                <a title="LinkedIn" href="#" target="_blank">
	                    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-brand-linkedin" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#0077B5" fill="none" stroke-linecap="round" stroke-linejoin="round">
	                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
	                        <path d="M4 4m0 2a2 2 0 0 1 2 -2h12a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-12a2 2 0 0 1 -2 -2z" />
	                        <path d="M8 11l0 5" />
	                        <path d="M8 8l0 .01" />
	                        <path d="M12 16l0 -5" />
	                        <path d="M16 16v-3a2 2 0 0 0 -4 0" />
	                    </svg>
	                </a>
	
	                <!-- TELEGRAM -->
	                
	                <a title="Telegram" href="#" target="_blank">
	                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#27A7E7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
	                        <path d="M15 10l-4 4l6 6l4 -16l-18 7l4 2l2 6l3 -4" />
	                    </svg>
	                </a>
	
	                <!-- MAIL -->
	                
	                <a title="Mail" href="mailto:hello.ciberseguridad12345@gmail.com" target="_blank">
	                    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-mail" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#8a90c7" fill="none" stroke-linecap="round" stroke-linejoin="round">
	                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
	                        <rect x="3" y="5" width="18" height="14" rx="2" />
	                        <polyline points="3 7 12 13 21 7" />
	                    </svg>
	                </a>
	            </div>
				</article>
	</footer>
	
	<!-- Popup First Flags -->
	<div id="flagPopup" style="display:none; position:fixed; top:0; left:0; width:100vw; height:100vh; background:rgba(0,0,0,0.7); justify-content:center; align-items:center; z-index:9999;">
	  <div style="background:#222; color:#fff; padding:20px; border-radius:8px; max-width:300px; text-align:center; position:relative;">
	    <button onclick="closePopup()" style="position:absolute; top:8px; right:8px; background:none; border:none; color:#ec0725; font-size:18px; cursor:pointer;">×</button>
	    <h2>Primera Flag</h2>
	    <p>¡Felicitaciones por conseguir la primera flag de User/Root!</p>
	    <p><strong>First User:</strong> <span id="popupFirstUser"></span></p>
	    <p><strong>First Root:</strong> <span id="popupFirstRoot"></span></p>
	  </div>
	</div>
	
	<!-- POPUP SUBMIT WRITEUP MESSAGE -->
	
	<div id="popupMensaje" class="popup-overlay-writeup" style="display: none;">
	  <div class="popup-box-writeup">
	    <p id="popupTexto"></p>
	    <button onclick="cerrarPopup()">Cerrar</button>
	  </div>
	</div>
	
	<!--<script src="<%= request.getContextPath() %>/js/machines23.js"></script>-->
	<script src="<%= request.getContextPath() %>/js/jsMachines.jsp"></script>
	<script defer>
	const toggleBtn = document.getElementById('toggle-theme');
	const body = document.body;

	if (localStorage.getItem('theme') === 'light') {
	  body.classList.add('light-theme');
	} else {
	  body.classList.remove('light-theme');
	}

	toggleBtn.addEventListener('click', () => {
	  body.classList.toggle('light-theme');
	  const isLight = body.classList.contains('light-theme');
	  localStorage.setItem('theme', isLight ? 'light' : 'dark');
	});

	document.addEventListener("DOMContentLoaded", function () {
	  fetch('<%= request.getContextPath() %>/ultimaMaquina')
	    .then(response => response.json())
	    .then(data => {
	      const ultimoId = data.ultimoId;

	      document.querySelectorAll("tr[data-machine-id]").forEach(function (row) {
	        const machineId = row.dataset.machineId;

	        fetch('<%= request.getContextPath() %>/machineDetails?id=' + machineId)
	          .then(res => res.json())
	          .then(machine => {
	            const isNew = machine.id == ultimoId;
	            const newBadge = isNew
	              ? '<div style="position: absolute; top: 5px; left: 5px; background: red; color: white; font-weight: bold; font-size: 10px; padding: 2px 6px; border-radius: 8px;">NEW</div>'
	              : '';

	            row.innerHTML =
	              '<td class="idnum" style="position: relative;">' + newBadge +
	              '<span id="idnum">' + machine.id + '</span>' +
	              '</td>' +
	              '<td class="card">' +
	                '<button class="card-btn machineBtn" title="Ver Info!" onclick="showCard(\'' + machine.nameMachine + '\', \'' + machine.os + '\', \'' + machine.difficulty + '\', \'' + machine.creator + '\', \'' + machine.date + '\', \'' + machine.id + '\')">' +
	                  '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#3fa8f4" fill="none" stroke-linecap="round" stroke-linejoin="round">' +
	                    '<circle cx="12" cy="12" r="10" />' +
	                    '<line x1="12" y1="8" x2="12" y2="8.01" />' +
	                    '<line x1="12" y1="10" x2="12" y2="16" />' +
	                  '</svg>' +
	                '</button>' +
	              '</td>' +
	              '<td id="vm">' +
	                '<div class="vm-name-btn level-btn ' + machine.difficulty + '">' +
	                  '<img class="' + machine.difficulty + '-dots" title="' + machine.os + ' VM" alt="' + machine.os + '" src="<%= request.getContextPath() %>/img/' + machine.imgNameOs + '.svg" width="22" height="22" loading="lazy">' +
	                  '<span class="vm-name-wrapper" style="display: flex; align-items: center; gap: 0.4rem;">' +
	                    '<span class="vm-name" style="margin-right: -60px;">' + machine.nameMachine + '</span>' +
	                    '<span class="vm-size" style="margin-right: 20px; margin-left: auto;">' + machine.size + '</span>' +
	                  '</span>' +
	                '</div>' +
	              '</td>' +
	              '<td class="tested">' +
	                '<img title="Entorno 1" alt="' + machine.enviroment + ' logo" src="<%= request.getContextPath() %>/img/' + machine.enviroment + '.png" width="25" height="25">' +
	                '<img title="Entorno 2" alt="' + machine.enviroment2 + ' logo" src="<%= request.getContextPath() %>/img/' + machine.enviroment2 + '.png" width="25" height="25"' +
	                ((machine.enviroment2 && machine.enviroment2 !== "null") ? '' : ' hidden') + '>' +
	              '</td>' +
	              '<td class="md5">' +
	                '<span id="md5-hash" title="' + machine.md5 + '">' +
	                  '<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-file-md5" width="24" height="24" viewBox="0 0 24 24" stroke-width="1" stroke="#FFA500" fill="none" stroke-linecap="round" stroke-linejoin="round">' +
	                    '<path d="M14 3v4a1 1 0 0 0 1 1h4" />' +
	                    '<path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />' +
	                    '<path d="M6.5 16v-2c0 -0.5 0.5 -1 1 -1s1 0.5 1 1v2" />' +
	                    '<path d="M8.5 16v-2c0 -0.5 0.5 -1 1 -1s1 0.5 1 1v2" />' +
	                    '<path d="M11.5 16v-3h1c0.6 0 1 0.5 1 1.5s-0.4 1.5 -1 1.5h-1z" />' +
	                    '<path d="M16.5 13h-2v1.5c0.3 -0.2 0.7 -0.3 1 -0.3 0.6 0 1 0.4 1 1s-0.4 1 -1 1 -1 -0.4 -1 -1" />' +
	                  '</svg>' +
	                '</span>' +
	                '<button class="copy-btn" title="Copiar al clipboard!" onclick="copyToClipboard(this)">' +
	                  '<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-copy" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#FFB84D" fill="none" stroke-linecap="round" stroke-linejoin="round">' +
	                    '<path d="M8 8m0 2a2 2 0 0 1 2 -2h8a2 2 0 0 1 2 2v8a2 2 0 0 1 -2 2h-8a2 2 0 0 1 -2 -2z" />' +
	                    '<path d="M16 8v-2a2 2 0 0 0 -2 -2h-8a2 2 0 0 0 -2 2v8a2 2 0 0 0 2 2h2" />' +
	                  '</svg>' +
	                '</button>' +
	                '<div class="tooltip">Copied!</div>' +
	              '</td>' +
	              '<td class="writeups">' +
	                '<button class="writeup-btn" title="Ver writeups" onclick="showWriteups(\'' + machine.nameMachine + '\')">' +
	                  '<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-book" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#00ffff" fill="none" stroke-linecap="round" stroke-linejoin="round">' +
	                    '<path d="M3 19a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />' +
	                    '<path d="M3 6a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />' +
	                    '<line x1="3" y1="6" x2="3" y2="19" />' +
	                    '<line x1="12" y1="6" x2="12" y2="19" />' +
	                    '<line x1="21" y1="6" x2="21" y2="19" />' +
	                  '</svg>' +
	                '</button>' +
	                '<button class="add-writeup-btn" title="Añadir writeup" onclick="showWriteupForm(\'' + machine.nameMachine + '\')">' +
	                  '<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#3498db" fill="none" stroke-linecap="round" stroke-linejoin="round">' +
	                    '<path d="M14 3v4a1 1 0 0 0 1 1h4" />' +
	                    '<path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h6l6 6v10a2 2 0 0 1 -2 2z" />' +
	                    '<path d="M12 17v-6" />' +
	                    '<path d="M9.5 13.5l2.5 -2.5l2.5 2.5" />' +
	                  '</svg>' +
	                '</button>' +
	                '<section id="' + machine.nameMachine + '" class="modal">' +
	                  '<article class="modal-content">' +
	                    '<span class="close">&times;</span>' +
	                    '<p class="writeup-title"></p>' +
	                    '<div class="writeups-container"></div>' +
	                  '</article>' +
	                '</section>' +
	              '</td>' +
	              '<td class="first-user">' + machine.creator + '</td>' +
	              '<td class="first-user">' +
	                '<button title="Primera Flag User/Root" type="button" class="btn-flag" ' +
	                'data-first-user="' + machine.firstUser + '" ' +
	                'data-first-root="' + machine.firstRoot + '" ' +
	                'data-first-user-date="' + machine.firstUserDate + '" ' +
	                'data-first-root-date="' + machine.firstRootDate + '" ' +
	                'onclick="openPopup(this)" style="background:none; border:none; padding:0; cursor:pointer;">' +
	                  '<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 64 64" fill="none" stroke="#ec0725" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">' +
	                    '<circle cx="32" cy="36" r="20" fill="#222" stroke="#ec0725" stroke-width="3" />' +
	                    '<rect x="28" y="12" width="8" height="6" fill="#ec0725" rx="1" ry="1" />' +
	                    '<line x1="32" y1="36" x2="32" y2="20" stroke="#ec0725" stroke-width="3" />' +
	                    '<line x1="32" y1="28" x2="32" y2="16" stroke="#ec0725" stroke-width="2" />' +
	                    '<path d="M32 16 L44 22 L32 28 Z" fill="#daa04a" stroke="#daa04a" />' +
	                  '</svg>' +
	                '</button>' +
	              '</td>' +
	              '<td class="flag">' +
	                '<button class="submit-flag-btn" title="Enviar flag" onclick="showFlagForm(\'\', \'' + machine.nameMachine + '\')">' +
	                  '<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-flag-2" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#f26e56" fill="none" stroke-linecap="round" stroke-linejoin="round">' +
	                    '<path d="M5 5v16" />' +
	                    '<path d="M5 5h14l-3 5l3 5h-14" />' +
	                  '</svg>' +
	                '</button>' +
	              '</td>' +
	              '<td class="rating">' +
	                '<span class="star-rating" title="Valoración" data-vm-name="' + machine.nameMachine + '" data-already-voted="' + machine.alreadyVoted + '">' +
	                  (() => {
	                    let stars = '';
	                    let average = Math.round(machine.averageRating || 0);
	                    for (let i = 0; i < 5; i++) {
	                      stars += '<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="' + (i < average ? '#ffc107' : 'none') + '" stroke="#ffc107" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">' +
	                        '<path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />' +
	                        '</svg>';
	                    }
	                    return stars;
	                  })() +
	                '</span>' +
	              '</td>' +
	              '<td class="url">' +
	                '<a href="' + machine.downloadUrl + '" target="_blank" title="Descargar VM" style="color: white; font-weight: bold;">Download!</a>' +
	              '</td>';
	          })
	          .catch(function (err) {
	            console.error("Error al cargar máquina ID", machineId, err);
	            row.innerHTML = '<td colspan="10">⚠️ Error al cargar la máquina ' + machineId + '</td>';
	          });
	      });
	    });
	});
		
	  /* SISTEMA DE PUNTUACION DE ESTRELLAS */
	  
	  document.addEventListener("click", function (e) {
		  if (e.target.closest(".star-rating")) {
		    const container = e.target.closest(".star-rating");
		    const vmName = container.dataset.vmName;
		    const alreadyVoted = container.dataset.alreadyVoted === "true";
		
		    if (alreadyVoted) {
		      Swal.fire('Ya has valorado esta máquina.', '', 'info');
		      return;
		    }
		
		    Swal.fire({
		      title: '¿Cuántas estrellas le das?',
		      icon: 'question',
		      input: 'range',
		      inputAttributes: {
		        min: 1,
		        max: 5,
		        step: 1
		      },
		      inputValue: 3,
		      showCancelButton: true,
		      confirmButtonText: 'Enviar valoración'
		    }).then((result) => {
		      if (result.isConfirmed) {
		        fetch('<%= request.getContextPath() %>/star-rating', {
		          method: 'POST',
		          headers: {
		            'Content-Type': 'application/x-www-form-urlencoded'
		          },
		          body: 'vm_name=' + encodeURIComponent(vmName) + '&rating=' + parseInt(result.value)
		        })
		        .then(res => res.json())
		        .then(data => {
		          if (data.success) {
		            Swal.fire('¡Gracias por votar!', '', 'success');
		            container.dataset.alreadyVoted = "true";
		            updateStarDisplay(container, data.average);
		          } else {
		            Swal.fire(data.message, '', 'error');
		          }
		        });
		      }
		    });
		  }
		});

		function updateStarDisplay(container, average) {
		  let stars = '';
		  for (let i = 0; i < 5; i++) {
			  stars += '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" ' +
				         'fill="' + (i < average ? '#ffc107' : 'none') + '" ' +
				         'stroke="#ffc107" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">' +
				         '<path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 ' +
				         '9.19 8.63 2 9.24l5.46 4.73L5.82 21z" /></svg>';
		  }
		  container.innerHTML = stars;
		}
	  
	  /* SUMBIT FLAGS (SUBMIT FLAGS (SHOW FORM)) */
	  
	  // Mostrar el formulario con datos correctos
		const showFlagForm = (type, vmname) => {
		  const body = document.querySelector('body');
		  const modalSection = document.querySelector('.form-flag');      // padre oculto con display:none
		  const modal = document.querySelector('.form-container');
		  const span = modal.querySelector('.close-form-flag');
		  const title = modal.querySelector('.form-title h1');
		  const vmNameInput = document.getElementById('vmName');
		  const userRadio = document.getElementById('user');
		  const rootRadio = document.getElementById('root');
		
		  if (body && modalSection && modal && span && title && vmNameInput && userRadio && rootRadio) {
		    body.style.overflow = 'hidden';
		    modalSection.style.display = 'flex';  // <--- Aquí debe ser flex para activar el flexbox y centrar
		    modal.style.display = 'flex';
		    vmNameInput.value = vmname;
		    title.textContent = `🏴 Enviar ${type || 'flag'} para ${vmname}`;
		
		    if (type === 'user') {
		      userRadio.checked = true;
		      rootRadio.checked = false;
		    } else if (type === 'root') {
		      rootRadio.checked = true;
		      userRadio.checked = false;
		    } else {
		      userRadio.checked = false;
		      rootRadio.checked = false;
		      title.textContent = `🏴 Enviar flag para ${vmname}`;
		    }
		
		    span.onclick = function () {
		      modalSection.style.display = 'none';
		      body.style.overflow = 'visible';
		    };
		  } else {
		    console.error('Error: uno o varios elementos no encontrados.');
		  }
		};
		
		// Envío del formulario
		document.getElementById('flagForm').addEventListener('submit', async function(event) {
		  event.preventDefault();

		  const form = event.target;
		  const modal = document.querySelector('.form-container');  // Agregado para cerrar modal
		  const body = document.querySelector('body');         // Agregado para restablecer scroll

		  // Construir URLSearchParams para enviar como application/x-www-form-urlencoded
		  const formData = new URLSearchParams(new FormData(form));

		  try {
		    const response = await fetch(form.action, {
		      method: form.method,
		      headers: {
		        'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
		      },
		      body: formData.toString(),
		    });

		    const result = await response.json();

		    if (response.ok) {
		      // Cerrar modal y permitir scroll antes de mostrar popup
		      const modalSection = document.querySelector('.form-flag');

				if (modalSection) {
				  modalSection.style.display = 'none';
				}
				if (body) {
				  body.style.overflow = 'visible';
				}

		      Swal.fire({
		        icon: 'success',
		        title: '¡Éxito!',
		        text: result.message,
		        timer: 3000,
		        showConfirmButton: false
		      });
		      form.reset();

		    } else {
		      Swal.fire({
		        icon: 'error',
		        title: 'Error',
		        text: result.error || result.message
		      });
		    }

		  } catch (error) {
		    Swal.fire({
		      icon: 'error',
		      title: 'Error',
		      text: "Error de red o del servidor."
		    });
		  }
		});
			  
	  /* SUMBIT NEW VM */
	  
	  document.getElementById('wizardVmForm').addEventListener('submit', function (e) {
		  e.preventDefault();
		
		  const form = e.target;
		  const formData = new FormData(form);
		
		  const url = "<%= request.getContextPath() %>/sendNewVM";  // contexto dinámico desde JSP
		
		  fetch(url, {
		    method: 'POST',
		    body: new URLSearchParams(formData),
		    credentials: 'include'  // para enviar cookies y así el servlet pueda leer el token JWT
		  })
		  .then(response => {
		    if (response.ok) {
		      mostrarPopup("✅ Máquina enviada correctamente.");
		      form.reset();
		    } else {
		      response.text().then(msg => {
		        console.error("[ERROR] Respuesta del servidor:", msg);
		        mostrarPopup("❌ Error al enviar la máquina.");
		      });
		    }
		  })
		  .catch(error => {
		    console.error("[ERROR] Error de red:", error);
		    mostrarPopup("⚠️ Error de conexión.");
		  });
		});
	  	
	    /* POPUP SUBMIT WRITEUP */
	  
	 	function mostrarPopup(mensaje) {
		  document.getElementById('popupTexto').textContent = mensaje;
		  document.getElementById('popupMensaje').style.display = 'flex';
		}

		function cerrarPopup() {
		  document.getElementById('popupMensaje').style.display = 'none';
		}
	  
	  /* SHOW WRITEUPS */
	  
	 function showWriteups(vmName) {
		  const modal = document.getElementById(vmName);
		  if (!modal) {
		    console.error("No se encontró el modal para:", vmName);
		    return;
		  }
		
		  const container = modal.querySelector('.writeups-container');
		  if (!container) {
		    console.error("No se encontró el contenedor de writeups dentro del modal:", vmName);
		    return;
		  }
		
		  const title = modal.querySelector('.writeup-title');
		  title.textContent = 'Writeup de ' + vmName;
		
		  container.innerHTML = '<p style="text-align:center; color: gray;">Cargando...</p>';
		
		  fetch('<%= request.getContextPath() %>/getWriteupsPublic?vmName=' + encodeURIComponent(vmName))
		    .then(res => res.json())
		    .then(data => {
		      container.innerHTML = '';
		
		      if (!data || data.length === 0) {
		        container.innerHTML = '<p style="text-align:center; color: gray;">No hay writeups para esta máquina.</p>';
		      } else {
		        data.forEach(w => {
		        	let icon = w.contentType === 'Video' ? '📹' : '📄';
		        	container.innerHTML += '<p>' + '<span class="writeup-icon">' + icon + '</span>' + ' <a href="' + w.url + '" target="_blank">' + w.name + ' - ' + w.creator + '</a></p>';
		        });
		      }
		
		      // Mostrar modal añadiendo clase .show
		      modal.classList.add('show');
		
		      // Añadir el evento para cerrar modal al hacer click en la "x"
		      const closeBtn = modal.querySelector('.close');
		      if (closeBtn) {
		        closeBtn.onclick = () => modal.classList.remove('show');
		      }
		    })
		    .catch(err => {
		      console.error("Error cargando writeups:", err);
		      container.innerHTML = '<p style="color:red;">⚠️ Error al cargar writeups.</p>';
		    });
		}
	  
	  /* POPUP FIRST FLAGS */
	  
	  // Función para formatear fechas
		function formatDate(dateStr) {
		  if (!dateStr) return '';
		  const date = new Date(dateStr);
		  const options = { day: '2-digit', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit' };
		  return date.toLocaleString('es-ES', options);
		}
		
		// POPUP FIRST FLAGS
		function openPopup(button) {
		  const firstUser = button.getAttribute('data-first-user') || 'N/A';
		  const firstRoot = button.getAttribute('data-first-root') || 'N/A';
		  const firstUserDate = button.getAttribute('data-first-user-date') || '';
		  const firstRootDate = button.getAttribute('data-first-root-date') || '';
		
		  const popup = document.createElement('div');
		  popup.id = 'flagPopupDynamic';
		  popup.style.cssText =
		    'display: flex;' +
		    'position: fixed;' +
		    'top: 0; left: 0;' +
		    'width: 100vw; height: 100vh;' +
		    'background: rgba(10, 5, 20, 0.92);' +
		    'backdrop-filter: blur(6px);' +
		    'justify-content: center;' +
		    'align-items: center;' +
		    'z-index: 9999;' +
		    'animation: fadeIn 0.4s ease forwards;';
		
		  popup.innerHTML =
		    '<div style="' +
		      'background: linear-gradient(135deg, #1f103f, #2c145b);' +
		      'color: #f0f0f0;' +
		      'padding: 40px 35px;' +
		      'border-radius: 20px;' +
		      'width: 90vw;' +
		      'max-width: 450px;' +
		      'box-shadow: 0 25px 60px rgba(0,0,0,0.85);' +
		      'position: relative;' +
		      "font-family: 'Poppins', 'Segoe UI', sans-serif;" +
		    '">' +
		      '<button type="button" id="closePopupBtn" aria-label="Cerrar popup" style="' +
		        'position: absolute;' +
		        'top: 16px;' +
		        'right: 16px;' +
		        'background: none;' +
		        'border: none;' +
		        'color: #ffffff;' +
		        'font-size: 28px;' +
		        'font-weight: bold;' +
		        'cursor: pointer;' +
		        'transition: color 0.3s ease, transform 0.2s ease;' +
		      '">×</button>' +
		
		      '<h2 style="font-size: 2.1rem; font-weight: 700; color: #a78bfa; margin-bottom: 10px;">🚩 Primeras Flags</h2>' +
		      '<p style="font-size: 1rem; color: #d0cde1; margin-bottom: 30px; line-height: 2rem;">¡Los más rápidos en capturar User y Root!</p>' +
		
		      '<div style="margin-bottom: 25px; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 20px; line-height: 2rem;">' +
		        '<div style="font-size: 1rem; color: #aaa;">👤 <strong style="color:#80ffea;">First User:</strong></div>' +
		        '<div style="font-size: 1.35rem; font-weight: 600; color: #ffffff; margin-top: 5px;">' + firstUser + '</div>' +
		        '<div style="font-size: 0.9rem; color: #b3b3b3; margin-top: 6px;">🗓️ ' + formatDate(firstUserDate) + '</div>' +
		      '</div>' +
		
		      '<div style="margin-bottom: 10px; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 20px; line-height: 2rem;">' +
		        '<div style="font-size: 1rem; color: #aaa;">👑 <strong style="color:#ff7eb9;">First Root:</strong></div>' +
		        '<div style="font-size: 1.35rem; font-weight: 600; color: #ffffff; margin-top: 5px;">' + firstRoot + '</div>' +
		        '<div style="font-size: 0.9rem; color: #b3b3b3; margin-top: 6px;">🗓️ ' + formatDate(firstRootDate) + '</div>' +
		      '</div>' +
		    '</div>';
		
		  document.body.appendChild(popup);
		
		  const closeBtn = document.getElementById('closePopupBtn');
		  closeBtn.onmouseenter = function() {
		    closeBtn.style.color = '#ff4d6d';
		    closeBtn.style.transform = 'scale(1.2)';
		  };
		  closeBtn.onmouseleave = function() {
		    closeBtn.style.color = '#ffffff';
		    closeBtn.style.transform = 'scale(1)';
		  };
		  closeBtn.onclick = function() {
		    document.body.removeChild(popup);
		  };
		
		  popup.onclick = function(e) {
		    if (e.target === popup) document.body.removeChild(popup);
		  };
		
		  const styleSheet = document.createElement('style');
		  styleSheet.type = 'text/css';
		  styleSheet.innerText =
		    '@keyframes fadeIn {' +
		      'from { opacity: 0; transform: scale(0.9); }' +
		      'to { opacity: 1; transform: scale(1); }' +
		    '}';
		  document.head.appendChild(styleSheet);
		}
		
	  
	  /* POPUP INFO MACHINE [+] (SHOW) */
	  
	  document.addEventListener('DOMContentLoaded', () => {
		  document.body.addEventListener('click', function (e) {
		    const btn = e.target.closest('.machineBtn-details');
		    if (btn) {
		      const id = btn.getAttribute('data-machine-id');
		      window.location.href = '<%= request.getContextPath() %>/machineDetails/mchinesDetails.jsp?id=' + id;
		    }
		  });
		});
		
		/* STATS LOGIC SHOW */
		
		function updateVmStats() {
		  fetch('<%= request.getContextPath() %>/machines-stats')  // Ajusta la URL de tu API o servlet JSON
		    .then(function(response) {
		      if (!response.ok) throw new Error('Error en la respuesta');
		      return response.json();
		    })
		    .then(function(data) {
		      var ul = document.getElementById('vmStatsContainer');
		      var html = '';
		
		      // Badge total máquinas
		      /*html += '<span class="badge badge-vms">' +
	           data.totalMachines + ' VMs' +
	        '</span>';*/
		
		      // Recorrer dificultades
		      for (var difficulty in data.countsByDifficulty) {
		        if (data.countsByDifficulty.hasOwnProperty(difficulty)) {
		
		          // Crear clase CSS: todo minúsculas y sin espacios (por ej: "Very Easy" -> "veryeasy")
		          var classDifficulty = difficulty.toLowerCase().replace(/\s+/g, '-');
		
		          html += '<span class="badge badge-' + classDifficulty + '">' +
		           data.countsByDifficulty[difficulty] + ' ' + difficulty +
		        '</span>';
		        }
		      }
		
		      ul.innerHTML = html;
		    })
		    .catch(function(error) {
		      console.error('Error al cargar las stats:', error);
		    });
		}
		
		// Llamar a la función para cargar al cargar la página
		window.addEventListener('load', updateVmStats);
		
		/* SECCION DE IMAGEN CON ESTADISTICAS DE LAS MAQUINAS Y DIFICULTADES (LOGICA) */
		
		function loadMachineStatsUI() {
		  fetch('<%= request.getContextPath() %>/machines-stats-principal')
		    .then(function (response) {
		      if (!response.ok) throw new Error('Error al cargar las estadísticas');
		      return response.json();
		    })
		    .then(function (data) {
		      var container = document.getElementById('machinesStatsContainer');
		      var html = '';
		
		      html += '<div class="container-img-machines">';
		
		      // IZQUIERDA
		      html += '<div class="left-stats-img-machines">';
		      html += '<div class="stat-block-img-machines">';
		      html += '<div class="stat-title-img-machines">Total VMs</div><br>';
		      html += '<div class="stat-number-img-machines">' + data.totalMachines + '</div>';
		      html += '</div>';
		      html += '<div class="stat-block-img-machines">';
		      html += '<div class="stat-title-img-machines">Pwn3ds!</div><br>';
		      html += '<div class="stat-number-img-machines">' + data.pwnedMachines + '</div>';
		      html += '</div>';
		      html += '</div>';
		
		      // CENTRO (imagen)
		      html += '<div class="image-wrapper-img-machines">';
		      html += '<img src="<%= request.getContextPath() %>/img/monitor.png" class="img-machines-page-img-machines" alt="Monitor Image" />';
		      html += '<div class="overlay-text-img-machines">';
		      html += '<img src="<%= request.getContextPath() %>/img/logo-flag-white.png" width="50%" height="50%" /><br><br>Pwned!';
		      html += '</div>';
		      html += '</div>';
		
		      // DERECHA (barras de dificultad)
		      html += '<div class="right-bars-img-machines">';
		
		      var difficulties = ['Very-Easy', 'Easy', 'Medium', 'Hard'];
		      var colors = {
		        'very-easy': 'very-easy',
		        'easy': 'easy',
		        'medium': 'medium',
		        'hard': 'hard'
		      };
		
		      var totalByDifficulty = data.countsByDifficulty || {};
		      var hackedByDifficulty = data.hackedByDifficulty || {};
		
		      function normalizeKey(key) {
		        switch (key.toLowerCase().replace(/\s+/g, '')) {
		          case 'very-easy': return 'Very-Easy';
		          case 'easy': return 'Easy';
		          case 'medium': return 'Medium';
		          case 'hard': return 'Hard';
		          default: return key;
		        }
		      }
		
		      for (var i = 0; i < difficulties.length; i++) {
		        var label = difficulties[i];
		        var cssClass = label.toLowerCase().replace(/\s+/g, '-');
		        var total = totalByDifficulty[label] || 1; // prevenir división por 0
		        var hacked = hackedByDifficulty[normalizeKey(label)] || 0;
		        var percent = Math.round((hacked / total) * 100);
		
		        html += '<div class="difficulty-level-img-machines">';
		        html += '<div class="difficulty-label-img-machines">' + label + '</div>';
		        html += '<div class="progress-bar-img-machines">';
		        html += '<div class="progress-fill-img-machines ' + colors[cssClass] + '" data-width="' + percent + '"></div>';
		        html += '</div>';
		        html += '</div>';
		      }
		
		      html += '</div>'; // end right bars
		      html += '</div>'; // end container
		
		      container.innerHTML = html;
		
		      // Forzar animación
		      setTimeout(function () {
		        var bars = container.querySelectorAll('.progress-fill-img-machines');
		        bars.forEach(function (bar) {
		          var target = bar.getAttribute('data-width');
		          bar.style.width = target + '%';
		        });
		      }, 100);
		    })
		    .catch(function (err) {
		      console.error('Error al construir el bloque de estadísticas:', err);
		    });
		}
		
		// Ejecutar al cargar
		window.addEventListener('load', loadMachineStatsUI);
		
		/* TIEMPO DE CARGA DE LA PAGINA */
		 window.addEventListener('load', function() {
	      setTimeout(function() {
	        document.getElementById('loader').style.display = 'none';
	      }, 2000); // 2 segundos para simular carga
	    });
	</script>
</body>

</html>