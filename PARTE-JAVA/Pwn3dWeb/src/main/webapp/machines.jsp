<%@page import="controller.MachineDetailsServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Machine" %>
<%@ page import="utils.JWTUtil" %>
<%@ page import="javax.servlet.http.Cookie" %>

<%
	Machine machine = null;
%>
<!DOCTYPE html>
<html lang="es">
<meta http-equiv="content-type" content="text/html;charset=UTF-8" />
<head>
<meta charset="utf-8">
<link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
<link rel="canonical" href="<%= request.getContextPath() %>/machines.jsp">
<title>Pwn3d!</title>
<script async defer src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<!--<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_machines134.css">-->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssMachines.jsp">
</head>

<body>
	<header>
	    <section class="header-container">
		
			<!-- BOTÓN AGRUPADO -->
			
		    <div class="header-controls">
		    
		    <!-- LOGO -->
	        
	        <article class="pwned-header">
	            <!-- <img class="logo" alt="Pwn3d! website logo" src="<%= request.getContextPath() %>/img/banner.png"> -->
  				<img src="<%= request.getContextPath() %>/img/logo-flag-white.png" alt="Pwned Icon" class="pwned-icon" />
	            <h2 class="pwned-title"></h2>
	        </article>
	        
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
				    String token = null;
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
				      onclick="window.location.href='<%= request.getContextPath() %>/agregarVM.jsp'">
				      Agregar VM
				    </button>
				<% } %>
			</div>
			
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
			              <label for="wizard-vm-url">VM URL</label>
			              <input id="wizard-vm-url" name="URL" type="url" pattern="https?://.+" placeholder="URL de VM pública" required />
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
			              <label for="wizard-writeup-url">Writeup URL</label>
			              <input id="wizard-writeup-url" name="Solution" type="url" pattern="https?://.+" placeholder="URL del writeup" />
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
			</section>
		</header>
	<main>
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
			      <button class="vb-close" onclick="document.querySelector('.form-writeup').style.display='none'">×</button>
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
			      Ingrese su nombre de usuario y la flag correspondiente. Este formulario es solo informativo y no garantiza prioridad si otros ya enviaron antes.
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
			          Este formulario no valida las flags automáticamente. En un futuro se planea un sistema en tiempo real para mostrar el primero en enviarla.
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
	  
	  document.addEventListener("DOMContentLoaded", function() {
		    document.querySelectorAll("tr[data-machine-id]").forEach(function(row) {
		        var machineId = row.dataset.machineId;

		        fetch('<%= request.getContextPath() %>/machineDetails?id=' + machineId)
		            .then(function(res) {
		                return res.json();
		            })
		            .then(function(machine) {
		                // Construir dinámicamente el contenido HTML con la concatenación de cadenas
		                row.innerHTML = 
		                    '<td class="idnum">' +
		                        '<span id="idnum">' + machine.id + '</span>' +
		                    '</td>' +
		                    '<td class="card">' +
		                        '<button class="card-btn machineBtn" title="Ver Info!" ' +
		                            'onclick="showCard(\'' + machine.nameMachine + '\', \'' + machine.os + '\', \'' + machine.difficulty + '\', \'' + machine.creator + '\', \'' + machine.date + '\', \'' + machine.id + '\')">' +
		                            '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#3fa8f4" fill="none" stroke-linecap="round" stroke-linejoin="round">' +
		                                '<circle cx="12" cy="12" r="10" />' +
		                                '<line x1="12" y1="8" x2="12" y2="8.01" />' +
		                                '<line x1="12" y1="10" x2="12" y2="16" />' +
		                            '</svg>' +
		                        '</button>' +
		                    '</td>' +
		                    '<td id="vm">' +
		                        '<div class="vm-name-btn level-btn ' + machine.difficulty + '">' +
		                            '<img class="' + machine.difficulty + '-dots" title="' + machine.os + ' VM" ' +
		                                'alt="' + machine.os + '" src="<%= request.getContextPath() %>/img/' + machine.imgNameOs + '.svg" width="22" height="22" loading="lazy">' +
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
			                '<td class="first-user">' + machine.creator + '</td>' +
		                    //'<td class="first-user">' + machine.firstUser + '</td>' +
		                    //'<td class="first-user">' + machine.firstRoot + '</td>' +
		                    '<td class="first-user">' +
							  '<button title="Primera Flag User/Root" type="button" class="btn-flag" ' +
							  'data-first-user="' + machine.firstUser + '" ' +
							  'data-first-root="' + machine.firstRoot + '" ' +
							  'onclick="openPopup(this)" ' +
							  'style="background:none; border:none; padding:0; cursor:pointer;">' +
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
		                    '<td class="url">' +
		                        '<a href="' + machine.downloadUrl + '" target="_blank" title="Descargar VM">' +
		                            '<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-download" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#d9534f" fill="none" stroke-linecap="round" stroke-linejoin="round">' +
		                                '<path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2 -2v-2" />' +
		                                '<path d="M7 11l5 5l5 -5" />' +
		                                '<path d="M12 4l0 12" />' +
		                            '</svg>' +
		                        '</a>' +
		                    '</td>';
		            })
		            .catch(function(err) {
		                console.error("Error al cargar máquina ID", machineId, err);
		                row.innerHTML = '<td colspan="10">⚠️ Error al cargar la máquina ' + machineId + '</td>';
		            });
		    });
		});
		
	  /* SUMBIT FLAGS (SUBMIT FLAGS (SHOW FORM)) */
	  
	  // Mostrar el formulario con datos correctos
		const showFlagForm = (type, vmname) => {
		  const body = document.querySelector('body');
		  const modal = document.querySelector('.form-flag');
		  const span = modal.querySelector('.close-form-flag');
		  const title = modal.querySelector('.form-title h1');
		  const vmNameInput = document.getElementById('vmName');
		  const userRadio = document.getElementById('user');
		  const rootRadio = document.getElementById('root');
		
		  if (body && modal && span && title && vmNameInput && userRadio && rootRadio) {
		    body.style.overflow = 'hidden';
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
		      // Ninguno seleccionado por defecto, que el usuario elija
		      userRadio.checked = false;
		      rootRadio.checked = false;
		      title.textContent = `🏴 Enviar flag para ${vmname}`;
		    }
		
		    span.onclick = function () {
		      modal.style.display = 'none';
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
		      alert(result.message);
		      form.reset();
		    } else {
		      alert(result.error || result.message);
		    }
		  } catch (error) {
		    alert("Error de red o del servidor.");
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
	  
	  function openPopup(button) {
		  const firstUser = button.getAttribute('data-first-user') || 'N/A';
		  const firstRoot = button.getAttribute('data-first-root') || 'N/A';
		
		  const popup = document.createElement('div');
		  popup.id = 'flagPopupDynamic';
		  popup.style.cssText =
		    'display:flex;' +
		    'position:fixed;top:0;left:0;width:100vw;height:100vh;' +
		    'background:linear-gradient(135deg, rgba(0,0,0,0.85), rgba(20,20,20,0.9));' +
		    'justify-content:center;align-items:center;' +
		    'z-index:9999;' +
		    'line-height: 2.3rem;' +
		    'animation:fadeIn 0.4s ease forwards;';
		
		  popup.innerHTML =
		    '<div style="' +
		      'background:#121212;' +
		      'color:#f0f0f0;' +
		      'padding:40px 35px;' +
		      'border-radius:20px;' +
		      'max-width:400px;width:90vw;' +
		      'box-shadow:0 15px 40px rgba(0,0,0,0.8);' +
		      'border:2px solid rgba(255,255,255,0.05);' +
		      'backdrop-filter: blur(8px);' +
		      'text-align:center;' +
		      'position:relative;' +
		      'font-family:Poppins,Segoe UI,Tahoma,sans-serif;' +
		    '">' +
		      '<button id="closePopupBtn" aria-label="Cerrar popup" style="' +
		        'position:absolute;top:14px;right:14px;' +
		        'background:#ec0725;border:none;' +
		        'color:#fff;font-size:22px;' +
		        'width:36px;height:36px;' +
		        'border-radius:50%;cursor:pointer;' +
		        'transition:all 0.3s ease;' +
		        'box-shadow:0 4px 10px rgba(0,0,0,0.5);' +
		      '">×</button>' +
		      '<div style="margin-bottom:20px;">' +
		        '<div style="font-size:2.2rem; color:#f5a623; font-weight:800;">Primeras Flags</div>' +
		        '<p style="font-size:1.05rem; margin-top:10px; color:#ccc;">¡Los más rápidos en capturar User y Root!</p>' +
		      '</div>' +
		      '<div style="margin:15px 0;">' +
		        '<span style="font-size:1rem; color:#aaa;">👤 <strong style="color:#60d394;">First User:</strong></span><br>' +
		        '<span style="font-size:1.1rem; font-weight:600; color:#fff;">' + firstUser + '</span>' +
		      '</div>' +
		      '<div style="margin:15px 0;">' +
		        '<span style="font-size:1rem; color:#aaa;">👑 <strong style="color:#ee6055;">First Root:</strong></span><br>' +
		        '<span style="font-size:1.1rem; font-weight:600; color:#fff;">' + firstRoot + '</span>' +
		      '</div>' +
		    '</div>';
		
		  document.body.appendChild(popup);
		
		  const closeBtn = document.getElementById('closePopupBtn');
		  closeBtn.onmouseenter = function () {
		    closeBtn.style.backgroundColor = '#a9041b';
		    closeBtn.style.transform = 'scale(1.1)';
		  };
		  closeBtn.onmouseleave = function () {
		    closeBtn.style.backgroundColor = '#ec0725';
		    closeBtn.style.transform = 'scale(1)';
		  };
		  closeBtn.onclick = function () {
		    document.body.removeChild(popup);
		  };
		
		  popup.onclick = function (e) {
		    if (e.target === popup) {
		      document.body.removeChild(popup);
		    }
		  };
		
		  const styleSheet = document.createElement('style');
		  styleSheet.type = 'text/css';
		  styleSheet.innerText =
		    '@keyframes fadeIn {' +
		    '  from { opacity: 0; transform: scale(0.95); }' +
		    '  to { opacity: 1; transform: scale(1); }' +
		    '}';
		  document.head.appendChild(styleSheet);
		}
	  
	  /* POPUP INFO MACHINE [+] (SHOW) */
	  
	  /* Función para abrir el popup con la info de la máquina */
		function openMachinePopup(machine) {
		  // Eliminar popup anterior si existe
		  const existingPopup = document.getElementById('machinePopupDynamic');
		  if (existingPopup) existingPopup.remove();
		  
		  // Barra de progreso
		  const maxWriteups = 100; // define el máximo para el porcentaje
		  const writeupsPercent = machine.totalWriteups ? Math.min(100, (machine.totalWriteups / maxWriteups) * 100) : 0;
		  
		  // Crear popup principal
		  const popup = document.createElement('div');
		  popup.id = 'machinePopupDynamic';
		  popup.setAttribute('role', 'dialog');
		  popup.setAttribute('aria-modal', 'true');
		  popup.tabIndex = -1;
		
		  // HTML interno del popup con estructura y clases para CSS externo
		  popup.innerHTML =
		    '<div class="popup-container">' +
		
		      '<button id="closeMachinePopupBtn" class="close-btn-info" aria-label="Cerrar popup">&times;</button>' +
		
		      '<h2>Información detallada de la máquina</h2>' +
		
		      '<p class="machine-name">' + (machine.nameMachine || 'Nombre no disponible') + '</p>' +
		
		      // MD5 hash con icono
		      '<div class="info-row">' +
		        '<span id="md5-hash" title="' + (machine.md5 || '') + '" aria-label="MD5 hash">' +
		          '<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-file-md5" width="24" height="24" viewBox="0 0 24 24" stroke-width="1" stroke="#FFA500" fill="none" stroke-linecap="round" stroke-linejoin="round">' +
		            '<path d="M14 3v4a1 1 0 0 0 1 1h4" />' +
		            '<path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />' +
		            '<path d="M6.5 16v-2c0 -0.5 0.5 -1 1 -1s1 0.5 1 1v2" />' +
		            '<path d="M8.5 16v-2c0 -0.5 0.5 -1 1 -1s1 0.5 1 1v2" />' +
		            '<path d="M11.5 16v-3h1c0.6 0 1 0.5 1 1.5s-0.4 1.5 -1 1.5h-1z" />' +
		            '<path d="M16.5 13h-2v1.5c0.3 -0.2 0.7 -0.3 1 -0.3 0.6 0 1 0.4 1 1s-0.4 1 -1 1 -1 -0.4 -1 -1" />' +
		          '</svg>' +
		        '</span>' +
		        '<br>' +
		        '<span>' + 'MD5: ' + '</span>' +
		        '<span>' + (machine.md5 || 'Sin MD5') + '</span>' +
		      '</div>' +
		
		      // Entornos y SO
		      '<div class="info-row-1">' +
				  '<p style="margin:0;">ENTORNOS:</p>' +
				  '<img title="Entorno 1" alt="' + (machine.enviroment || '') + ' logo" src="' + '<%= request.getContextPath() %>/img/' + (machine.enviroment || '') + '.png" width="25" height="25" />' +
				
				  '<img title="Entorno 2" alt="' + (machine.enviroment2 || '') + ' logo" src="' + '<%= request.getContextPath() %>/img/' + (machine.enviroment2 || '') + '.png" width="25" height="25" ' +
				    ((!machine.enviroment2 || machine.enviroment2 === 'null') ? 'hidden' : '') + ' />' +
				
				  '</div>' +  // Cierra div de ENTORNOS
				
				  '<div class="info-row-2" style="margin-top: 10px;">' + // Nueva línea para S.O.
				    '<p style="margin:0;">S.O.:</p>' +
				    '<img alt="' + (machine.os || '') + '" src="' + '<%= request.getContextPath() %>/img/' + (machine.os || '') + '.svg" width="22" height="22" loading="lazy" style="align-items: center; display: flex; margin-bottom: 5px;" />' +
				'</div>' +
		
		      // Difficulty + Creator + Date
		      '<div class="level-btn ' + (machine.difficulty || '') + '">' +
		        '<img class="' + (machine.difficulty || '') + '-dots" title="' + (machine.os || '') + ' VM" alt="VM difficulty dots" src="<%= request.getContextPath() %>/img/' + (machine.imgNameOs || '') + '.svg" width="22" height="22" loading="lazy" />' +
		        '<span>Creador: ' + (machine.creator || 'Desconocido') + '</span>' +
		        '<span class="date">Fecha: ' + (machine.date || 'N/A') + '</span>' +
		      '</div>' +
		
		      // Flags y Writeups generales
		      '<section>' +
		        '<h3>Flags y Writeups generales</h3>' +
		        '<ul>' +
		          '<li><strong>ID:</strong> ' + (machine.id || 'No disponible') + '</li>' +
		          '<li><strong>Root:</strong> ' + (machine.location || 'No disponible') + '</li>' +
		          '<li><strong>User:</strong> ' + (machine.type || 'No disponible') + '</li>' +
		          '<li><strong>Writeups:</strong> ' + (machine.totalWriteups !== undefined ? machine.totalWriteups : 'No disponible') + '</li>' +
		        '</ul>' +
		      '</section>' +
		      '<br>' +
		      // Barras de estado
		      '<section>' +
		        '<h3>Barras de estado</h3>' +
		        '<div class="metrics">' +
		
		          '<div class="metric">' +
		            '<p><strong>Flags Users:</strong> ' + (machine.cpu || 'N/A') + '</p>' +
		            '<div class="bar-bg"><div class="bar-fill cpu" style="width:' + (machine.cpuPercent || 0) + '%;"></div></div>' +
		          '</div>' +
		
		          '<div class="metric">' +
		            '<p><strong>Flags Root:</strong> ' + (machine.cpu || 'N/A') + '</p>' +
		            '<div class="bar-bg"><div class="bar-fill ram" style="width:' + (machine.ramPercent || 0) + '%;"></div></div>' +
		          '</div>' +
				
		          '<div class="metric">' +
			          '<p><strong>Writeups:</strong> ' + (machine.totalWriteups !== undefined ? machine.totalWriteups : 'N/A') + '</p>' +
			          '<div class="bar-bg"><div class="bar-fill disk" style="width:' + writeupsPercent + '%;"></div></div>' +
			        '</div>' +
		
		        '</div>' +
		      '</section>' +
		      '<br>' +
		      // Logs recientes
		      '<section>' +
		        '<h3>Logs recientes</h3>' +
		        '<div class="logs" tabindex="0" aria-label="Logs recientes">' +
		          (machine.logs && machine.logs.length > 0
		            ? machine.logs.map(log => '<p style="margin:0 0 6px 0;">' + log + '</p>').join('')
		            : '<p>No hay logs disponibles.</p>') +
		        '</div>' +
		      '</section>' +
				'<br>' +
		      // Botones acciones
		      '<div class="actions">' +
		        '<button class="close-info" type="button">Cerrar</button>' +
		      '</div>' +
		
		    '</div>';
		
		  document.body.appendChild(popup);
		
		  // Eventos cerrar popup
		  const closeBtn = document.getElementById('closeMachinePopupBtn');
		  closeBtn.onclick = function () {
		    popup.remove();
		  };
		
		  // Cerrar popup haciendo click fuera del contenido
		  popup.onclick = function (e) {
		    if (e.target === popup) popup.remove();
		  };
		}
		
		/* Función para obtener datos del servidor y mostrar el popup */
		function showMachinePopup(machineId) {
		  console.log('Solicitando info para máquina con ID:', machineId);
		  fetch('<%= request.getContextPath() %>/machineDetails?id=' + machineId)
		    .then(response => {
		      if (!response.ok) throw new Error('Error al obtener datos');
		      return response.json();
		    })
		    .then(data => openMachinePopup(data))
		    .catch(err => alert('No se pudo cargar la información de la máquina: ' + err.message));
		}
		
		// Asignar evento a los botones con clase machineBtn
		document.querySelectorAll('.machineBtn').forEach(btn => {
		  btn.addEventListener('click', () => {
		    const id = btn.getAttribute('data-machine-id');
		    showMachinePopup(id);
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
		      html += '<span class="badge badge-vms">' +
		        '<svg class="wave" viewBox="0 0 120 28" preserveAspectRatio="none">' +
		          '<defs>' +
		            '<linearGradient id="waveColor" gradientTransform="rotate(90)">' +
		              '<stop offset="0%" stop-color="rgba(255,255,255,0.3)" />' +
		              '<stop offset="100%" stop-color="rgba(255,255,255,0.05)" />' +
		            '</linearGradient>' +
		          '</defs>' +
		          '<path class="wave-path wave1" d="M0 16 Q 30 6 60 16 T 120 16 V 28 H 0 Z" fill="url(#waveColor)" />' +
		          '<path class="wave-path wave2" d="M0 16 Q 30 6 60 16 T 120 16 V 28 H 0 Z" fill="url(#waveColor)" />' +
		        '</svg>' +
		        data.totalMachines + ' VMs' +
		      '</span>';
		
		      // Recorrer dificultades
		      for (var difficulty in data.countsByDifficulty) {
		        if (data.countsByDifficulty.hasOwnProperty(difficulty)) {
		
		          // Crear clase CSS: todo minúsculas y sin espacios (por ej: "Very Easy" -> "veryeasy")
		          var classDifficulty = difficulty.toLowerCase().replace(/\s+/g, '-');
		
		          html += '<span class="badge badge-' + classDifficulty + '">' +
		            '<svg class="wave" viewBox="0 0 120 28" preserveAspectRatio="none">' +
		              '<defs>' +
		                '<linearGradient id="waveColor" gradientTransform="rotate(90)">' +
		                  '<stop offset="0%" stop-color="rgba(255,255,255,0.3)" />' +
		                  '<stop offset="100%" stop-color="rgba(255,255,255,0.05)" />' +
		                '</linearGradient>' +
		              '</defs>' +
		              '<path class="wave-path wave1" d="M0 16 Q 30 6 60 16 T 120 16 V 28 H 0 Z" fill="url(#waveColor)" />' +
		              '<path class="wave-path wave2" d="M0 16 Q 30 6 60 16 T 120 16 V 28 H 0 Z" fill="url(#waveColor)" />' +
		            '</svg>' +
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
	</script>
</body>
</html>