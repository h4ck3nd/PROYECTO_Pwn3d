<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<meta http-equiv="content-type" content="text/html;charset=UTF-8" />
<head>
<meta charset="utf-8">
<link rel="icon" href="<%= request.getContextPath() %>/img/logo1.ico">
<link rel="canonical" href="<%= request.getContextPath() %>/machines.jsp">
<title>Pwn3d!</title>
<script async defer src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_machines134.css">
</head>

<body>
	<header>
	    <section class="header-container">
	    
	        <!-- LOGO -->
	        
	        <article class="logo-wrapper">
	            <img class="logo" alt="Pwn3d! website logo" src="img/banner.png">
	        </article>
		
			<!-- BOTÓN AGRUPADO -->
			
		    <div class="header-controls">
		      <!-- BOTÓN MODO CLARO/OSCURO -->
		      <button id="toggle-theme" class="toggle-button" aria-label="Toggle theme">
		        <svg viewBox="0 0 100 100" class="theme-icon">
		          <circle cx="50" cy="50" r="40" class="circle-bg" />
		          <path d="M50,10 A40,40 0 1,1 49.9,10 Z" class="half" />
		        </svg>
		      </button>
			</div>
			
			<!-- SECCION PARA ENVIAR VM -->
			
			<section class="form-vm">
			  <div class="form-container">
			  <span class="close-form" style="margin-bottom: -30px !important; margin-top: -20px !important; margin-right: -15px !important;">&times;</span>
			    <div class="form-title">
			      <h1 style="font-size: 20px !important; color: #3379ac !important; font-style: bold !important; margin-bottom: -20px !important;" >Nuevo envío de VM</h1>
			    </div>
			    <p class="form-description" style="font-size: 15px !important; margin-bottom: -17px !important;">
			      Complete el formulario con toda la información sobre su máquina virtual. Si desea comentarios sobre su subida, contáctenos.
			    </p>
			    <form class="form submit-form" id="vmForm">
			      <!-- Name + Creator -->
			      <div class="form-section" style="margin-bottom: -15px !important;">
			        <div class="form-field-group">
			          <div class="form-field">
			            <label class="form-label" for="name" style="margin-bottom: -5px !important;">Nombre</label>
			            <input class="form-control" id="name" name="Name" type="text" maxlength="20" placeholder="Nombre de la maquina" required autocomplete="off" />
			          </div>
			          <div class="form-field">
			            <label class="form-label" for="vm-creator" style="margin-bottom: -5px !important;">Creador</label>
			            <input class="form-control" id="vm-creator" name="Creator" type="text" maxlength="15" placeholder="Nombre de usuario" required />
			          </div>
			        </div>
			      </div>
			
			      <!-- Level + URL -->
			      
			      <div class="form-section" style="margin-bottom: -15px !important;">
			        <div class="form-field-group">
			          <div class="form-field">
			          <br>
			            <label class="form-label" for="level" style="margin-bottom: -5px !important;">Dificultad</label>
			            <select class="form-control" id="level" name="Level" required>
			              <option value="Very-Easy">Very Easy</option>
			              <option value="Easy">Easy</option>
			              <option value="Medium">Medium</option>
			              <option value="Hard">Hard</option>
			            </select>
			          </div>
			          <div class="form-field">
			          <br>
			            <label class="form-label" for="vm-url" style="margin-bottom: -5px !important;">VM URL</label>
			            <input class="form-control" id="vm-url" name="URL" type="url" pattern="https?://.+" placeholder="URL de VM publica" required />
			          </div>
			        </div>
			      </div>
			
			      <!-- Flags -->
			      
			      <div class="form-section" style="margin-bottom: -15px !important;">
			        <div class="form-field-group">
			          <div class="form-field">
			          <br>
			            <label class="form-label" for="user-flag" style="margin-bottom: -5px !important;">Flag Usuario</label>
			            <input class="form-control" id="user-flag" name="UserFlag" type="text" maxlength="32" placeholder="Flag del usuario" required />
			          </div>
			          <div class="form-field">
			          <br>
			            <label class="form-label" for="root-flag" style="margin-bottom: -5px !important;">Flag Root</label>
			            <input class="form-control" id="root-flag" name="RootFlag" type="text" maxlength="32" placeholder="Flag de root" required />
			          </div>
			        </div>
			      </div>
			
			      <!-- Writeup + Contact -->
			      
			      <div class="form-section" style="margin-bottom: -15px !important;">
			        <div class="form-field-group">
			          <div class="form-field">
			          <br>
			            <label class="form-label" for="writeup" style="margin-bottom: -5px !important;">Writeup URL</label>
			            <input class="form-control" id="writeup-url" name="Solution" type="url" pattern="https?://.+" placeholder="URL del writeup" required />
			          </div>
			          <div class="form-field">
			          <br>
			            <label class="form-label" for="contact" style="margin-bottom: -5px !important;">Contacto</label>
			            <input class="form-control" id="contact" name="Contact" type="text" maxlength="32" placeholder="email, Discord, etc..." required />
			          </div>
			        </div>
			      </div>
			
			      <!-- Tags -->
			      
			      <div class="form-section">
			        <div class="form-field">
			        <br>
			          <label class="form-label" for="tags" style="margin-bottom: -5px !important;">Tags</label>
			          <textarea class="form-control" id="tags" name="Tags" maxlength="200" rows="2" placeholder="Tags separadas por comas" required></textarea>
			        </div>
			      </div>
			
			      <!-- Buttons -->
			      
			      <br>
			      <div class="form-btns" style="margin-bottom: -5px !important;">
			        <button class="button" type="submit">Enviar</button>
			        <button class="button" type="reset">Borrar</button>
			      </div>
			
			      <!-- Footer -->
			      
			      <div class="form-footer" style="margin-bottom: -15px !important;">
			        <small>Por favor, lea nuestras <a href="https://vulnyx.com/rules/" target="_blank"><strong>Reglas</strong></a> antes de enviar una nueva VM.</small>
			      </div>
			    </form>
			  </div>
			</section>
			</section>
		</header>
	<main>
		<section class="wrapper">
			<article class="actions">
			
				<!-- BARRA DE BUSQUEDA -->
					
				    <div id="vm-search-wrapper" style="margin-right: 300px">
				        <div class="search-icon">
				            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-search" width="24" height="24" viewBox="0 0 24 24" stroke-width="2.5" stroke="#999999" fill="none" stroke-linecap="round" stroke-linejoin="round">
				                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
				                <path d="M10 10m-7 0a7 7 0 1 0 14 0a7 7 0 1 0 -14 0" />
				                <path d="M21 21l-6 -6" />
				            </svg>
				        </div>
				        <input id="vm-search" type="text" placeholder="Buscar por nombre..." aria-label="search" />
				        <button class="clear-search" title="Clear search" onclick="clearSearch()">Clear</button>
				    </div>
				
				<!-- HEADER ENCIMA DE LA ZONA DE MAQUINAS -->
				
				<div class="filters">
				
				<!-- STATS -->
				
				<ul class="vm-stats">
				    <li title="Total VMs"><span class="badge badge-vms">9 VMs</span></li>
				    <span class="badge badge-very-easy">
					  <svg class="wave" viewBox="0 0 120 28" preserveAspectRatio="none">
					    <defs>
					      <linearGradient id="waveColor" gradientTransform="rotate(90)">
					        <stop offset="0%" stop-color="rgba(255,255,255,0.3)" />
					        <stop offset="100%" stop-color="rgba(255,255,255,0.05)" />
					      </linearGradient>
					    </defs>
					    <path class="wave-path wave1" d="M0 16 Q 30 6 60 16 T 120 16 V 28 H 0 Z" fill="url(#waveColor)" />
					    <path class="wave-path wave2" d="M0 16 Q 30 6 60 16 T 120 16 V 28 H 0 Z" fill="url(#waveColor)" />
					  </svg>
					  1 Very Easy
					</span>
				    <span class="badge badge-easy">
					  <svg class="wave" viewBox="0 0 120 28" preserveAspectRatio="none">
					    <defs>
					      <linearGradient id="waveColor" gradientTransform="rotate(90)">
					        <stop offset="0%" stop-color="rgba(255,255,255,0.3)" />
					        <stop offset="100%" stop-color="rgba(255,255,255,0.05)" />
					      </linearGradient>
					    </defs>
					    <path class="wave-path wave1" d="M0 16 Q 30 6 60 16 T 120 16 V 28 H 0 Z" fill="url(#waveColor)" />
					    <path class="wave-path wave2" d="M0 16 Q 30 6 60 16 T 120 16 V 28 H 0 Z" fill="url(#waveColor)" />
					  </svg>
					  2 Easy
					</span>
				    <li title="Medium VMs"><span class="badge badge-medium">4 Medium</span></li>
				    <li title="Hard VMs"><span class="badge badge-hard">2 Hard</span></li>
				    <li title="Total Writeups"><span class="badge badge-writeups">42 Writeups</span></li>
				</ul>
				
				    <div class="filter-wrapper" onmouseleave="hideFilters()">
				        
				        <!-- Botón para abrir el popup -->
				        
						<button type="button" class="filter-by" onclick="openFilterPopup()">Filtrar</button>
						
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
							<th class="flag">Primer User</th>
							<th class="first-user">Primer Root</th>
							<th class="first-root">Flag</th>
							<th id="writeups">Descarga</th>
						</tr>
					</thead>
					
					<!-- MAQUINAS -->
					
					<tbody>
						<script>
						    let writeupsArr = [];
						    let writeupObj = {};
						</script>
						
						<tr class="row">
						    <!-- # -->
						    <td class="idnum">
						        <span id="idnum">1</span>
						    </td>
						
						    <!-- CARD -->
						    <td class="card">
						        <button class="card-btn" title="Show card!" onclick="showCard('Lower5', 'Linux', 'Very-Easy', 'd4t4s3c', '09 Apr 2025')">
						            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#3fa8f4" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <circle cx="12" cy="12" r="10" stroke="#3fa8f4" stroke-width="1.5" fill="none"/>
									  <line x1="12" y1="8" x2="12" y2="8.01" stroke="#3fa8f4" stroke-width="1.5"/>
									  <line x1="12" y1="10" x2="12" y2="16" stroke="#3fa8f4" stroke-width="1.5"/>
									</svg>
						        </button>
						    </td>
						
						    <!-- NAME/SIZE -->
						    
						    <td id="vm">
							  <div class="vm-name-btn level-btn very-easy">
							    <img class="very-easy-dots" title="LinuxVM" alt="Linuxicon" src="<%= request.getContextPath() %>/img/Linux.svg" width="22" height="22" loading="lazy">
							    <span class="vm-name-wrapper" style="display: flex; align-items: center;">
							      <span class="vm-name" style="margin-right: -60px;">Lower5</span>
							      <span class="vm-size" style="margin-right: 20px; margin-left: auto;">1.8GB</span>
							    </span>
							  </div>
							</td>
						
						    <!-- TESTED -->
						    
						    <td class="tested">
						        <img title="VirtualBox" alt="VirtualBox logo" src="<%= request.getContextPath() %>/img/vbox.png" width="25" height="25">
						        <img title="VMware" alt="VMware logo" src="<%= request.getContextPath() %>/img/vmware.png" width="25" height="25">
						    </td>
						
						    <!-- MD5 -->
						    
						    <td class="md5">
						        <span id="md5-hash" title="65015966EDD9A1A8ACE257DA2F0D9730">
						            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-file-info" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round" stroke-linejoin="round">
						                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
						                <path d="M14 3v4a1 1 0 0 0 1 1h4" />
						                <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />
						                <path d="M11 14h1v4h1" />
						                <path d="M12 11h.01" />
						            </svg>
						        </span>
						        <button class="copy-btn" title="Copy to clipboard!" onclick="copyToClipboard(this)">
						            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-copy" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round" stroke-linejoin="round">
						                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
						                <path d="M8 8m0 2a2 2 0 0 1 2 -2h8a2 2 0 0 1 2 2v8a2 2 0 0 1 -2 2h-8a2 2 0 0 1 -2 -2z" />
						                <path d="M16 8v-2a2 2 0 0 0 -2 -2h-8a2 2 0 0 0 -2 2v8a2 2 0 0 0 2 2h2" />
						            </svg>
						        </button>
						        <div class="tooltip">Copied!</div>
						    </td>
							
							<!-- WRITEUPS -->
						    <td class="writeups">
						        <script>
						            writeupObj = {
						                name: "Lower5",
						                creator: "d4t4s3c",
						                url: "https://d4t4s3c.com/vulnyx/2025/04/09/Lower5/"
						            };
						            writeupsArr.push(writeupObj);
						        </script>
						        <script>
						            writeupObj = {
						                name: "Lower5",
						                creator: "ll104567",
						                url: "https://www.bilibili.com/video/BV1widPYcEVr"
						            };
						            writeupsArr.push(writeupObj);
						        </script>
						        <button class="writeup-btn" title="Show writeups" onclick="showWriteups('Lower5')">
						            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-book" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#b3da49" fill="none" stroke-linecap="round" stroke-linejoin="round">
						                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
						                <path d="M3 19a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
						                <path d="M3 6a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
						                <line x1="3" y1="6" x2="3" y2="19" />
						                <line x1="12" y1="6" x2="12" y2="19" />
						                <line x1="21" y1="6" x2="21" y2="19" />
						            </svg>
						        </button>
						        <button class="add-writeup-btn" title="Add writeup" onclick="showWriteupForm('Lower5')">
						            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#49da57" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
									  <path d="M14 3v4a1 1 0 0 0 1 1h4" />
									  <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h6l6 6v10a2 2 0 0 1 -2 2z" />
									  <path d="M12 17v-6" />
									  <path d="M9.5 13.5l2.5 -2.5l2.5 2.5" />
									</svg>
						        </button>
						        
						        <!-- MODAL FOR WRITEUPS -->
						        
						        <section id="Lower5" class="modal">
						            <article class="modal-content">
						                <span class="close">&times;</span>
						                <p class="writeup-title"></p>
						                <div class="writeups-container"></div>
						            </article>
						        </section>
							
						    <!-- FIRST USER -->
						    <td class="first-user">suraxddq</td>
						
						    <!-- FIRST ROOT -->
						    <td class="first-user">suraxddq</td>
							
							<td class="flag">
							
								<!-- BOTON ENVIAR FLAG -->
						        
						        <button class="submit-flag-btn" title="Enviar flag" onclick="showFlagForm('user/root', 'Lower5')">
								  <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-flag-2" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#f26e56" fill="none" stroke-linecap="round" stroke-linejoin="round">
								    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
								    <path d="M5 5v16" />
								    <path d="M5 5h14l-3 5l3 5h-14" />
								  </svg>
								</button>
							</td>
						        
						        <!-- DOWNLOAD -->
						    
						    <td class="url">
						        <a href="https://vulnyx.com/file/Lower5.php" target="_blank" title="Download VM">
						            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-download" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#d9534f" fill="none" stroke-linecap="round" stroke-linejoin="round">
						                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
						                <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2 -2v-2" />
						                <path d="M7 11l5 5l5 -5" />
						                <path d="M12 4l0 12" />
						            </svg>
						        </a>
						    </td>
						    </td>
						<tr class="row">
					    <!-- # -->
					    <td class="idnum">
					        <span id="idnum">2</span>
					    </td>
					
					    <!-- CARD -->
					    <td class="card">
					        <button class="card-btn" title="Show card!"
					            onclick="showCard('Change','Windows','Medium','d4t4s3c','08 Mar 2025')">
					            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#3fa8f4" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <circle cx="12" cy="12" r="10" stroke="#3fa8f4" stroke-width="1.5" fill="none"/>
									  <line x1="12" y1="8" x2="12" y2="8.01" stroke="#3fa8f4" stroke-width="1.5"/>
									  <line x1="12" y1="10" x2="12" y2="16" stroke="#3fa8f4" stroke-width="1.5"/>
									</svg>
					        </button>
					    </td>
					
					    <!-- NAME/SIZE -->
						    
						    <td id="vm">
							  <div class="vm-name-btn level-btn medium">
							    <img class="medium-dots" title="WindowsVM" alt="Windows" src="<%= request.getContextPath() %>/img/Windows.svg" width="22" height="22" loading="lazy">
							    <span class="vm-name-wrapper" style="display: flex; align-items: center; gap: 0.4rem;">
							      <span class="vm-name" style="margin-right: -60px;">Change</span>
							      <span class="vm-size" style="margin-right: 20px; margin-left: auto;">7.7GB</span>
							    </span>
							  </div>
							</td>
					
					    <!-- TESTED -->
					    
					    <td class="tested">
					        <img title="VirtualBox" alt="VirtualBox logo" src="<%= request.getContextPath() %>/img/vbox.png" width="25" height="25">
					    </td>
					
					    <!-- MD5 -->
					    <td class="md5">
					        <span id="md5-hash" title="B11BED45EF5A1066C68FAE86F398D5CB">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-file-info" width="24"
					                height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round"
					                stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M14 3v4a1 1 0 0 0 1 1h4" />
					                <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />
					                <path d="M11 14h1v4h1" />
					                <path d="M12 11h.01" />
					            </svg>
					        </span>
					        <button class="copy-btn" title="Copy to clipboard!" onclick="copyToClipboard(this)">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-copy" width="24" height="24"
					                viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round"
					                stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path
					                    d="M8 8m0 2a2 2 0 0 1 2 -2h8a2 2 0 0 1 2 2v8a2 2 0 0 1 -2 2h-8a2 2 0 0 1 -2 -2z" />
					                <path
					                    d="M16 8v-2a2 2 0 0 0 -2 -2h-8a2 2 0 0 0 -2 2v8a2 2 0 0 0 2 2h2" />
					            </svg>
					        </button>
					        <div class="tooltip">Copied!</div>
					    </td>
					
					    <!-- WRITEUPS -->
					    <td class="writeups">
					        <script>
					            writeupObj = {
					                name: "Change",
					                creator: "d4t4s3c",
					                url: "https://d4t4s3c.com/vulnyx/2025/03/08/Change/"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = {
					                name: "Change",
					                creator: "hyh",
					                url: "https://www.hyhforever.top/vulnyx-change"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = {
					                name: "Change",
					                creator: "PL4GU3",
					                url: "https://youtu.be/cfHYpcP5Tdc"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <button class="writeup-btn" title="Show writeups" onclick="showWriteups('Change')">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-book" width="24" height="24"
					                viewBox="0 0 24 24" stroke-width="1.5" stroke="#b3da49" fill="none" stroke-linecap="round"
					                stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M3 19a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
					                <path d="M3 6a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
					                <line x1="3" y1="6" x2="3" y2="19" />
					                <line x1="12" y1="6" x2="12" y2="19" />
					                <line x1="21" y1="6" x2="21" y2="19" />
					            </svg>
					        </button>
					        <button class="add-writeup-btn" title="Add writeup" onclick="showWriteupForm('Change')">
					            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#49da57" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
									  <path d="M14 3v4a1 1 0 0 0 1 1h4" />
									  <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h6l6 6v10a2 2 0 0 1 -2 2z" />
									  <path d="M12 17v-6" />
									  <path d="M9.5 13.5l2.5 -2.5l2.5 2.5" />
									</svg>
					        </button>
					        <section id="Change" class="modal">
					            <article class="modal-content">
					                <span class="close">&times;</span>
					                <p class="writeup-title"></p>
					                <div class="writeups-container"></div>
					            </article>
					        </section>
					        
					        <!-- FIRST USER -->
					    <td class="first-user">Flo2699</td>
					
					    <!-- FIRST ROOT -->
					    <td class="first-user">Flo2699</td>
					        
					        <td class="flag">
							
								<!-- BOTON ENVIAR FLAG -->
						        
						        <button class="submit-flag-btn" title="Enviar flag" onclick="showFlagForm('user/root', 'Changue')">
								  <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-flag-2" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#f26e56" fill="none" stroke-linecap="round" stroke-linejoin="round">
								    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
								    <path d="M5 5v16" />
								    <path d="M5 5h14l-3 5l3 5h-14" />
								  </svg>
								</button>
							</td>
					        
					        <!-- DOWNLOAD -->
					    
					    <td class="url">
					        <a href="https://vulnyx.com/file/Change.php" target="_blank" title="Download VM">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-download" width="24"
					                height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#d9534f" fill="none" stroke-linecap="round"
					                stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2 -2v-2" />
					                <path d="M7 11l5 5l5 -5" />
					                <path d="M12 4l0 12" />
					            </svg>
					        </a>
					    </td>
					    </td>
						<tr class="row">
					    <!-- # -->
					    <td class="idnum"><span id="idnum">3</span></td>
					
					    <!-- CARD -->
					    <td class="card">
					        <button class="card-btn" title="Show card!" onclick="showCard('Anon', 'Linux', 'Medium', 'd4t4s3c', '05 Feb 2025')">
					            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#3fa8f4" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <circle cx="12" cy="12" r="10" stroke="#3fa8f4" stroke-width="1.5" fill="none"/>
									  <line x1="12" y1="8" x2="12" y2="8.01" stroke="#3fa8f4" stroke-width="1.5"/>
									  <line x1="12" y1="10" x2="12" y2="16" stroke="#3fa8f4" stroke-width="1.5"/>
									</svg>
					        </button>
					    </td>
					
					    <!-- NAME/SIZE -->
						    
						    <td id="vm">
							  <div class="vm-name-btn level-btn medium">
							    <img class="medium-dots" title="LinuxVM" alt="Linux" src="<%= request.getContextPath() %>/img/Linux.svg" width="22" height="22" loading="lazy">
							    <span class="vm-name-wrapper" style="display: flex; align-items: center; gap: 0.4rem;">
							      <span class="vm-name" style="margin-right: -60px;">Anon</span>
							      <span class="vm-size" style="margin-right: 20px; margin-left: auto;">1.5GB</span>
							    </span>
							  </div>
							</td>
					
					    <!-- TESTED -->
					    
					    <td class="tested">
					        <img title="VirtualBox" alt="VirtualBox logo" src="<%= request.getContextPath() %>/img/vbox.png" width="25" height="25">
					        <img title="VMware" alt="VMware logo" src="<%= request.getContextPath() %>/img/vmware.png" width="25" height="25">
					    </td>
					
					    <!-- MD5 -->
					    <td class="md5">
					        <span id="md5-hash" title="74849CA997AA235CF3E47914F158024A">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-file-info" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M14 3v4a1 1 0 0 0 1 1h4" />
					                <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />
					                <path d="M11 14h1v4h1" />
					                <path d="M12 11h.01" />
					            </svg>
					        </span>
					        <button class="copy-btn" title="Copy to clipboard!" onclick="copyToClipboard(this)">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-copy" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M8 8m0 2a2 2 0 0 1 2 -2h8a2 2 0 0 1 2 2v8a2 2 0 0 1 -2 2h-8a2 2 0 0 1 -2 -2z" />
					                <path d="M16 8v-2a2 2 0 0 0 -2 -2h-8a2 2 0 0 0 -2 2v8a2 2 0 0 0 2 2h2" />
					            </svg>
					        </button>
					        <div class="tooltip">Copied!</div>
					    </td>
					
					    <!-- WRITEUPS -->
					    <td class="writeups">
					        <script>
					            writeupObj = { name: "Anon", creator: "suraxddq", url: "https://byte-mind.net/vulnyx-machines-anon-writeup" };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = { name: "Anon", creator: "ll104567", url: "https://www.bilibili.com/video/BV1VhN7e5Ehw" };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = { name: "Anon", creator: "PL4GU3", url: "https://youtu.be/7VKb3Po7fd8" };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = { name: "Anon", creator: "MatthyGD", url: "https://www.youtube.com/watch?v=_YqXlvukKE0" };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = { name: "Anon", creator: "sunset", url: "https://www.sunset-blog.top/baji/vulnyx/Anon%20193b61af4289808d9254cfc427e4931b.html" };
					            writeupsArr.push(writeupObj);
					        </script>
					
					        <button class="writeup-btn" title="Show writeups" onclick="showWriteups('Anon')">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-book" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#b3da49" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M3 19a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
					                <path d="M3 6a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
					                <line x1="3" y1="6" x2="3" y2="19" />
					                <line x1="12" y1="6" x2="12" y2="19" />
					                <line x1="21" y1="6" x2="21" y2="19" />
					            </svg>
					        </button>
					
					        <button class="add-writeup-btn" title="Add writeup" onclick="showWriteupForm('Anon')">
					            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#49da57" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
									  <path d="M14 3v4a1 1 0 0 0 1 1h4" />
									  <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h6l6 6v10a2 2 0 0 1 -2 2z" />
									  <path d="M12 17v-6" />
									  <path d="M9.5 13.5l2.5 -2.5l2.5 2.5" />
									</svg>
					        </button>
					
					        <section id="Anon" class="modal">
					            <article class="modal-content">
					                <span class="close">&times;</span>
					                <p class="writeup-title"></p>
					                <div class="writeups-container"></div>
					            </article>
					        </section>
					        
					        <!-- FIRST USER -->
					    <td class="first-user">flower</td>
					
					    <!-- FIRST ROOT -->
					    <td class="first-user">lvzhouhang</td>
					        
					        <td class="flag">
							
								<!-- BOTON ENVIAR FLAG -->
						        
						        <button class="submit-flag-btn" title="Enviar flag" onclick="showFlagForm('user/root', 'Anon')">
								  <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-flag-2" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#f26e56" fill="none" stroke-linecap="round" stroke-linejoin="round">
								    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
								    <path d="M5 5v16" />
								    <path d="M5 5h14l-3 5l3 5h-14" />
								  </svg>
								</button>
							</td>
					        
					        <!-- DOWNLOAD -->
					    
					    <td class="url">
					        <a href="https://vulnyx.com/file/Anon.php" target="_blank" title="Download VM">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-download" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#d9534f" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2 -2v-2" />
					                <path d="M7 11l5 5l5 -5" />
					                <path d="M12 4l0 12" />
					            </svg>
					        </a>
					    </td>
					    </td>
						<tr class="row">
					    <!-- # -->
					    <td class="idnum">
					        <span id="idnum">4</span>
					    </td>
					    
					    <!-- CARD -->
					    <td class="card">
					        <button class="card-btn" title="Show card!" onclick="showCard('Hit', 'Linux', 'Easy', 'd4t4s3c', '04 Feb 2025')">
					            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#3fa8f4" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <circle cx="12" cy="12" r="10" stroke="#3fa8f4" stroke-width="1.5" fill="none"/>
									  <line x1="12" y1="8" x2="12" y2="8.01" stroke="#3fa8f4" stroke-width="1.5"/>
									  <line x1="12" y1="10" x2="12" y2="16" stroke="#3fa8f4" stroke-width="1.5"/>
									</svg>
					        </button>
					    </td>
					    
					    <!-- NAME/SIZE -->
						    
						    <td id="vm">
							  <div class="vm-name-btn level-btn easy">
							    <img class="easy-dots" title="LinuxVM" alt="Linux" src="<%= request.getContextPath() %>/img/Linux.svg" width="22" height="22" loading="lazy">
							    <span class="vm-name-wrapper" style="display: flex; align-items: center; gap: 0.4rem;">
							      <span class="vm-name" style="margin-right: -60px;">Hit</span>
							      <span class="vm-size" style="margin-right: 20px; margin-left: auto;">1.2GB</span>
							    </span>
							  </div>
							</td>
					    
					    <!-- TESTED -->
					    
					    <td class="tested">
					        <img title="VirtualBox" alt="VirtualBox logo" src="<%= request.getContextPath() %>/img/vbox.png" width="25" height="25">
					        <img title="VMware" alt="VMware logo" src="<%= request.getContextPath() %>/img/vmware.png" width="25" height="25">
					    </td>
					    
					    <!-- MD5 -->
					    <td class="md5">
					        <span id="md5-hash" title="75841477B83B8C86A6719F43B1A9A457">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-file-info" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M14 3v4a1 1 0 0 0 1 1h4" />
					                <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />
					                <path d="M11 14h1v4h1" />
					                <path d="M12 11h.01" />
					            </svg>
					        </span>
					        <button class="copy-btn" title="Copy to clipboard!" onclick="copyToClipboard(this)">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-copy" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M8 8m0 2a2 2 0 0 1 2 -2h8a2 2 0 0 1 2 2v8a2 2 0 0 1 -2 2h-8a2 2 0 0 1 -2 -2z" />
					                <path d="M16 8v-2a2 2 0 0 0 -2 -2h-8a2 2 0 0 0 -2 2v8a2 2 0 0 0 2 2h2" />
					            </svg>
					        </button>
					        <div class="tooltip">Copied!</div>
					    </td>
					    
					    <!-- WRITEUPS -->
					    <td class="writeups">
					        <script>
					            writeupObj = {
					                name: "Hit",
					                creator: "ll104567",
					                url: "https://www.bilibili.com/video/BV1m7NAedEuh"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = {
					                name: "Hit",
					                creator: "MatthyGD",
					                url: "https://www.youtube.com/watch?v=Lzrhk3O67YA"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <button class="writeup-btn" title="Show writeups" onclick="showWriteups('Hit')">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-book" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#b3da49" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M3 19a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
					                <path d="M3 6a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
					                <line x1="3" y1="6" x2="3" y2="19" />
					                <line x1="12" y1="6" x2="12" y2="19" />
					                <line x1="21" y1="6" x2="21" y2="19" />
					            </svg>
					        </button>
					        <button class="add-writeup-btn" title="Add writeup" onclick="showWriteupForm('Hit')">
					            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#49da57" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
									  <path d="M14 3v4a1 1 0 0 0 1 1h4" />
									  <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h6l6 6v10a2 2 0 0 1 -2 2z" />
									  <path d="M12 17v-6" />
									  <path d="M9.5 13.5l2.5 -2.5l2.5 2.5" />
									</svg>
					        </button>
					        <section id="Hit" class="modal">
					            <article class="modal-content">
					                <span class="close">&times;</span>
					                <p class="writeup-title"></p>
					                <div class="writeups-container"></div>
					            </article>
					        </section>
					        
					        <!-- FIRST USER -->
					    <td class="first-user">maciiii___</td>
					    
					    <!-- FIRST ROOT -->
					    <td class="first-user">maciiii___</td>
					        
					        <td class="flag">
							
								<!-- BOTON ENVIAR FLAG -->
						        
						        <button class="submit-flag-btn" title="Enviar flag" onclick="showFlagForm('user/root', 'Hit')">
								  <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-flag-2" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#f26e56" fill="none" stroke-linecap="round" stroke-linejoin="round">
								    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
								    <path d="M5 5v16" />
								    <path d="M5 5h14l-3 5l3 5h-14" />
								  </svg>
								</button>
							</td>
					        
					        <!-- DOWNLOAD -->
					    
					    <td class="url">
					        <a href="https://vulnyx.com/file/Hit.php" target="_blank" title="Download VM">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-download" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#d9534f" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2 -2v-2" />
					                <path d="M7 11l5 5l5 -5" />
					                <path d="M12 4l0 12" />
					            </svg>
					        </a>
					    </td>
					        
					    </td>
						<tr class="row">
					    <!-- # -->
					    <td class="idnum"><span id="idnum">5</span></td>
					    
					    <!-- CARD -->
					    <td class="card">
					        <button class="card-btn" title="Show card!" onclick="showCard(
					            'Matrix',
					            'Linux',
					            'Medium',
					            'Lenam',
					            '30 Jan 2025'
					        )">
					            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#3fa8f4" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <circle cx="12" cy="12" r="10" stroke="#3fa8f4" stroke-width="1.5" fill="none"/>
									  <line x1="12" y1="8" x2="12" y2="8.01" stroke="#3fa8f4" stroke-width="1.5"/>
									  <line x1="12" y1="10" x2="12" y2="16" stroke="#3fa8f4" stroke-width="1.5"/>
									</svg>
					        </button>
					    </td>
					    
					    <!-- NAME/SIZE -->
						    
						    <td id="vm">
							  <div class="vm-name-btn level-btn medium">
							    <img class="medium-dots" title="LinuxVM" alt="Linux" src="<%= request.getContextPath() %>/img/Linux.svg" width="22" height="22" loading="lazy">
							    <span class="vm-name-wrapper" style="display: flex; align-items: center; gap: 0.4rem;">
							      <span class="vm-name" style="margin-right: -60px;">Matrix</span>
							      <span class="vm-size" style="margin-right: 20px; margin-left: auto;">750MB</span>
							    </span>
							  </div>
							</td>
					    
					    <!-- TESTED -->
					    
					    <td class="tested">
					        <img title="VirtualBox" alt="VirtualBox logo" src="<%= request.getContextPath() %>/img/vbox.png" width="25" height="25">
					        <img title="VMware" alt="VMware logo" src="<%= request.getContextPath() %>/img/vmware.png" width="25" height="25">
					    </td>
					    
					    <!-- MD5 -->
					    <td class="md5">
					        <span id="md5-hash" title="7231B02B3C522DD4AE19917C13FB53F2">
					            <svg xmlns="http://www.w3.org/2000/svg"
					                class="icon icon-tabler icon-tabler-file-info" width="24"
					                height="24" viewBox="0 0 24 24" stroke-width="1.5"
					                stroke="#dad049" fill="none" stroke-linecap="round"
					                stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M14 3v4a1 1 0 0 0 1 1h4" />
					                <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />
					                <path d="M11 14h1v4h1" />
					                <path d="M12 11h.01" />
					            </svg>
					        </span>
					        <button class="copy-btn" title="Copy to clipboard!" onclick="copyToClipboard(this)">
					            <svg xmlns="http://www.w3.org/2000/svg"
					                class="icon icon-tabler icon-tabler-copy" width="24"
					                height="24" viewBox="0 0 24 24" stroke-width="1.5"
					                stroke="#dad049" fill="none" stroke-linecap="round"
					                stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M8 8m0 2a2 2 0 0 1 2 -2h8a2 2 0 0 1 2 2v8a2 2 0 0 1 -2 2h-8a2 2 0 0 1 -2 -2z" />
					                <path d="M16 8v-2a2 2 0 0 0 -2 -2h-8a2 2 0 0 0 -2 2v8a2 2 0 0 0 2 2h2" />
					            </svg>
					        </button>
					        <div class="tooltip">Copied!</div>
					    </td>
					    
					    <!-- WRITEUPS -->
					    <td class="writeups">
					        <script>
					            writeupObj = {
					                name: "Matrix",
					                creator: "MatthyGD",
					                url: "https://www.youtube.com/watch?v=fc6YmdAzP7s"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = {
					                name: "Matrix",
					                creator: "ll104567",
					                url: "https://www.bilibili.com/video/BV1escFeSEKM"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = {
					                name: "Matrix",
					                creator: "suraxddq",
					                url: "https://byte-mind.net/vulnyx-machines-matrix-writeup"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = {
					                name: "Matrix",
					                creator: "Lenam (EN)",
					                url: "https://len4m.github.io/posts/matrix-writeup-vulnyx-en"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = {
					                name: "Matrix",
					                creator: "Lenam (ES)",
					                url: "https://len4m.github.io/es/posts/matrix-writeup-vulnyx-es"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <button class="writeup-btn" title="Show writeups" onclick="showWriteups('Matrix')">
					            <svg xmlns="http://www.w3.org/2000/svg"
					                class="icon icon-tabler icon-tabler-book" width="24"
					                height="24" viewBox="0 0 24 24" stroke-width="1.5"
					                stroke="#b3da49" fill="none" stroke-linecap="round"
					                stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M3 19a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
					                <path d="M3 6a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
					                <line x1="3" y1="6" x2="3" y2="19" />
					                <line x1="12" y1="6" x2="12" y2="19" />
					                <line x1="21" y1="6" x2="21" y2="19" />
					            </svg>
					        </button>
					        <button class="add-writeup-btn" title="Add writeup" onclick="showWriteupForm('Matrix')">
					            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#49da57" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
									  <path d="M14 3v4a1 1 0 0 0 1 1h4" />
									  <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h6l6 6v10a2 2 0 0 1 -2 2z" />
									  <path d="M12 17v-6" />
									  <path d="M9.5 13.5l2.5 -2.5l2.5 2.5" />
									</svg>
					        </button>
					        <section id="Matrix" class="modal">
					            <article class="modal-content">
					                <span class="close">&times;</span>
					                <p class="writeup-title"></p>
					                <div class="writeups-container"></div>
					            </article>
					        </section>
					        
					        <!-- FIRST USER -->
					    <td class="first-user">suraxddq</td>
					    
					    <!-- FIRST ROOT -->
					    <td class="first-user">suraxddq</td>
					        
					        <td class="flag">
							
								<!-- BOTON ENVIAR FLAG -->
						        
						        <button class="submit-flag-btn" title="Enviar flag" onclick="showFlagForm('user/root', 'Matrix')">
								  <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-flag-2" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#f26e56" fill="none" stroke-linecap="round" stroke-linejoin="round">
								    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
								    <path d="M5 5v16" />
								    <path d="M5 5h14l-3 5l3 5h-14" />
								  </svg>
								</button>
							</td>
					        
					        <!-- DOWNLOAD -->
					    
					    <td class="url">
					        <a href="https://vulnyx.com/file/Matrix.php" target="_blank" title="Download VM">
					            <svg xmlns="http://www.w3.org/2000/svg"
					                class="icon icon-tabler icon-tabler-download" width="24"
					                height="24" viewBox="0 0 24 24" stroke-width="1.5"
					                stroke="#d9534f" fill="none" stroke-linecap="round"
					                stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2 -2v-2" />
					                <path d="M7 11l5 5l5 -5" />
					                <path d="M12 4l0 12" />
					            </svg>
					        </a>
					    </td>
					        
					    </td>
						<tr class="row">
					    <!-- # -->
					    <td class="idnum">
					        <span id="idnum">6</span>
					    </td>
					
					    <!-- CARD -->
					    <td class="card">
					        <button class="card-btn" title="Show card!" onclick="showCard('Tunnel', 'Linux', 'Hard', 'd4t4s3c', '13 Dec 2024')">
					            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#3fa8f4" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <circle cx="12" cy="12" r="10" stroke="#3fa8f4" stroke-width="1.5" fill="none"/>
									  <line x1="12" y1="8" x2="12" y2="8.01" stroke="#3fa8f4" stroke-width="1.5"/>
									  <line x1="12" y1="10" x2="12" y2="16" stroke="#3fa8f4" stroke-width="1.5"/>
									</svg>
					        </button>
					    </td>
					
					    <!-- NAME/SIZE -->
						    
						    <td id="vm">
							  <div class="vm-name-btn level-btn hard">
							    <img class="hard-dots" title="LinuxVM" alt="Linux" src="<%= request.getContextPath() %>/img/Linux.svg" width="22" height="22" loading="lazy">
							    <span class="vm-name-wrapper" style="display: flex; align-items: center; gap: 0.4rem;">
							      <span class="vm-name" style="margin-right: -60px;">Tunnel</span>
							      <span class="vm-size" style="margin-right: 20px; margin-left: auto;">1.2GB</span>
							    </span>
							  </div>
							</td>
					
					    <!-- TESTED -->
					    
					    <td class="tested">
					        <img title="VirtualBox" alt="VirtualBox logo" src="<%= request.getContextPath() %>/img/vbox.png" width="25" height="25">
					        <img title="VMware" alt="VMware logo" src="<%= request.getContextPath() %>/img/vmware.png" width="25" height="25">
					    </td>
					
					    <!-- MD5 -->
					    <td class="md5">
					        <span id="md5-hash" title="3D5D92A73B8130FB1DEA281993A8F5FD">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-file-info" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M14 3v4a1 1 0 0 0 1 1h4" />
					                <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />
					                <path d="M11 14h1v4h1" />
					                <path d="M12 11h.01" />
					            </svg>
					        </span>
					        <button class="copy-btn" title="Copy to clipboard!" onclick="copyToClipboard(this)">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-copy" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M8 8m0 2a2 2 0 0 1 2 -2h8a2 2 0 0 1 2 2v8a2 2 0 0 1 -2 2h-8a2 2 0 0 1 -2 -2z" />
					                <path d="M16 8v-2a2 2 0 0 0 -2 -2h-8a2 2 0 0 0 -2 2v8a2 2 0 0 0 2 2h2" />
					            </svg>
					        </button>
					        <div class="tooltip">Copied!</div>
					    </td>
					
					    <!-- WRITEUPS -->
					    <td class="writeups">
					        <script>
					            writeupObj = {
					                name: "Tunnel",
					                creator: "ll104567",
					                url: "https://www.bilibili.com/video/BV16QBGYgE8A"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = {
					                name: "Tunnel",
					                creator: "MatthyGD",
					                url: "https://www.youtube.com/watch?v=JyQ7YVqDarc"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <button class="writeup-btn" title="Show writeups" onclick="showWriteups('Tunnel')">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-book" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#b3da49" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M3 19a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
					                <path d="M3 6a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
					                <line x1="3" y1="6" x2="3" y2="19" />
					                <line x1="12" y1="6" x2="12" y2="19" />
					                <line x1="21" y1="6" x2="21" y2="19" />
					            </svg>
					        </button>
					        <button class="add-writeup-btn" title="Add writeup" onclick="showWriteupForm('Tunnel')">
					            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#49da57" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
									  <path d="M14 3v4a1 1 0 0 0 1 1h4" />
									  <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h6l6 6v10a2 2 0 0 1 -2 2z" />
									  <path d="M12 17v-6" />
									  <path d="M9.5 13.5l2.5 -2.5l2.5 2.5" />
									</svg>
					        </button>
					        <section id="Tunnel" class="modal">
					            <article class="modal-content">
					                <span class="close">&times;</span>
					                <p class="writeup-title"></p>
					                <div class="writeups-container"></div>
					            </article>
					        </section>
					        
					        <!-- FIRST USER -->
					    <td class="first-user">ll104567</td>
					
					    <!-- FIRST ROOT -->
					    <td class="first-user">ll104567</td>
					        
					        <td class="flag">
							
								<!-- BOTON ENVIAR FLAG -->
						        
						        <button class="submit-flag-btn" title="Enviar flag" onclick="showFlagForm('user/root', 'Tunnel')">
								  <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-flag-2" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#f26e56" fill="none" stroke-linecap="round" stroke-linejoin="round">
								    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
								    <path d="M5 5v16" />
								    <path d="M5 5h14l-3 5l3 5h-14" />
								  </svg>
								</button>
							</td>
					        
					        <!-- DOWNLOAD -->
					    
					    <td class="url">
					        <a href="https://vulnyx.com/file/Tunnel.php" target="_blank" title="Download VM">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-download" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#d9534f" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2 -2v-2" />
					                <path d="M7 11l5 5l5 -5" />
					                <path d="M12 4l0 12" />
					            </svg>
					        </a>
					    </td>
					    </td>
						<tr class="row">
					    <!-- # -->
					    <td class="idnum">
					        <span id="idnum">7</span>
					    </td>
					
					    <!-- CARD -->
					    <td class="card">
					        <button class="card-btn" title="Show card!" onclick="showCard('War', 'Windows', 'Easy', 'd4t4s3c', '07 Dec 2024')">
					            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#3fa8f4" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <circle cx="12" cy="12" r="10" stroke="#3fa8f4" stroke-width="1.5" fill="none"/>
									  <line x1="12" y1="8" x2="12" y2="8.01" stroke="#3fa8f4" stroke-width="1.5"/>
									  <line x1="12" y1="10" x2="12" y2="16" stroke="#3fa8f4" stroke-width="1.5"/>
									</svg>
					        </button>
					    </td>
					
					    <!-- NAME/SIZE -->
						    
						    <td id="vm">
							  <div class="vm-name-btn level-btn easy">
							    <img class="easy-dots" title="WindowsVM" alt="Windows" src="<%= request.getContextPath() %>/img/Windows.svg" width="22" height="22" loading="lazy">
							    <span class="vm-name-wrapper" style="display: flex; align-items: center; gap: 0.4rem;">
							      <span class="vm-name" style="margin-right: -60px;">War</span>
							      <span class="vm-size" style="margin-right: 20px; margin-left: auto;">7.2GB</span>
							    </span>
							  </div>
							</td>
					
					    <!-- TESTED -->
					    
					    <td class="tested">
					        <img title="VirtualBox" alt="VirtualBox logo" src="<%= request.getContextPath() %>/img/vbox.png" width="25" height="25">
					    </td>
					
					    <!-- MD5 -->
					    <td class="md5">
					        <span id="md5-hash" title="A48B73FBA9796957C86C19F8758CC9E5">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-file-info" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M14 3v4a1 1 0 0 0 1 1h4" />
					                <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />
					                <path d="M11 14h1v4h1" />
					                <path d="M12 11h.01" />
					            </svg>
					        </span>
					        <button class="copy-btn" title="Copy to clipboard!" onclick="copyToClipboard(this)">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-copy" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M8 8m0 2a2 2 0 0 1 2 -2h8a2 2 0 0 1 2 2v8a2 2 0 0 1 -2 2h-8a2 2 0 0 1 -2 -2z" />
					                <path d="M16 8v-2a2 2 0 0 0 -2 -2h-8a2 2 0 0 0 -2 2v8a2 2 0 0 0 2 2h2" />
					            </svg>
					        </button>
					        <div class="tooltip">Copied!</div>
					    </td>
					
					    <!-- WRITEUPS -->
					    <td class="writeups">
					        <script>
					            writeupObj = {
					                name: "War",
					                creator: "d4t4s3c",
					                url: "https://d4t4s3c.com/vulnyx/2024/12/07/War/"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = {
					                name: "War",
					                creator: "ll104567",
					                url: "https://www.bilibili.com/video/BV1bzqJYBEjf"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = {
					                name: "War",
					                creator: "beafn28",
					                url: "https://beafn28.gitbook.io/beafn28/writeups/vulnyx/war"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <button class="writeup-btn" title="Show writeups" onclick="showWriteups('War')">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-book" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#b3da49" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M3 19a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
					                <path d="M3 6a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
					                <line x1="3" y1="6" x2="3" y2="19" />
					                <line x1="12" y1="6" x2="12" y2="19" />
					                <line x1="21" y1="6" x2="21" y2="19" />
					            </svg>
					        </button>
					        <button class="add-writeup-btn" title="Add writeup" onclick="showWriteupForm('War')">
					            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#49da57" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
									  <path d="M14 3v4a1 1 0 0 0 1 1h4" />
									  <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h6l6 6v10a2 2 0 0 1 -2 2z" />
									  <path d="M12 17v-6" />
									  <path d="M9.5 13.5l2.5 -2.5l2.5 2.5" />
									</svg>
					        </button>
					        <section id="War" class="modal">
					            <article class="modal-content">
					                <span class="close">&times;</span>
					                <p class="writeup-title"></p>
					                <div class="writeups-container"></div>
					            </article>
					        </section>
					        
					        <!-- FIRST USER -->
					    <td class="first-user">minidump</td>
					
					    <!-- FIRST ROOT -->
					    <td class="first-user">minidump</td>
					        
					        <td class="flag">
							
								<!-- BOTON ENVIAR FLAG -->
						        
						        <button class="submit-flag-btn" title="Enviar flag" onclick="showFlagForm('user/root', 'War')">
								  <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-flag-2" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#f26e56" fill="none" stroke-linecap="round" stroke-linejoin="round">
								    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
								    <path d="M5 5v16" />
								    <path d="M5 5h14l-3 5l3 5h-14" />
								  </svg>
								</button>
							</td>
					        
					        <!-- DOWNLOAD -->
					    
					    <td class="url">
					        <a href="https://vulnyx.com/file/War.php" target="_blank" title="Download VM">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-download" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#d9534f" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2 -2v-2" />
					                <path d="M7 11l5 5l5 -5" />
					                <path d="M12 4l0 12" />
					            </svg>
					        </a>
					    </td>
						<tr class="row">
					    <!-- # -->
					    <td class="idnum">
					        <span id="idnum">8</span>
					    </td>
					
					    <!-- CARD -->
					    <td class="card">
					        <button class="card-btn" title="Show card!" onclick="showCard('Manager', 'Linux', 'Hard', 'd4t4s3c', '29 Nov 2024')">
					            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#3fa8f4" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <circle cx="12" cy="12" r="10" stroke="#3fa8f4" stroke-width="1.5" fill="none"/>
									  <line x1="12" y1="8" x2="12" y2="8.01" stroke="#3fa8f4" stroke-width="1.5"/>
									  <line x1="12" y1="10" x2="12" y2="16" stroke="#3fa8f4" stroke-width="1.5"/>
									</svg>
					        </button>
					    </td>
					
					    <!-- NAME/SIZE -->
						    
						    <td id="vm">
							  <div class="vm-name-btn level-btn hard">
							    <img class="hard-dots" title="LinuxVM" alt="Linux" src="<%= request.getContextPath() %>/img/Linux.svg" width="22" height="22" loading="lazy">
							    <span class="vm-name-wrapper" style="display: flex; align-items: center; gap: 0.4rem;">
							      <span class="vm-name" style="margin-right: -60px;">Manager</span>
							      <span class="vm-size" style="margin-right: 20px; margin-left: auto;">1.8GB</span>
							    </span>
							  </div>
							</td>
					
					    <!-- TESTED -->
					    
					    <td class="tested">
					        <img title="VirtualBox" alt="VirtualBox logo" src="<%= request.getContextPath() %>/img/vbox.png" width="25" height="25">
					        <img title="VMware" alt="VMware logo" src="<%= request.getContextPath() %>/img/vmware.png" width="25" height="25">
					    </td>
					
					    <!-- MD5 -->
					    <td class="md5">
					        <span id="md5-hash" title="EE5082F8354628AC353D9FEF6EB8784C">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-file-info" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M14 3v4a1 1 0 0 0 1 1h4" />
					                <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />
					                <path d="M11 14h1v4h1" />
					                <path d="M12 11h.01" />
					            </svg>
					        </span>
					        <button class="copy-btn" title="Copy to clipboard!" onclick="copyToClipboard(this)">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-copy" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M8 8m0 2a2 2 0 0 1 2 -2h8a2 2 0 0 1 2 2v8a2 2 0 0 1 -2 2h-8a2 2 0 0 1 -2 -2z" />
					                <path d="M16 8v-2a2 2 0 0 0 -2 -2h-8a2 2 0 0 0 -2 2v8a2 2 0 0 0 2 2h2" />
					            </svg>
					        </button>
					        <div class="tooltip">Copied!</div>
					    </td>
					
					    <!-- WRITEUPS -->
					    <td class="writeups">
					        <script>
					            writeupObj = {
					                name: "Manager",
					                creator: "ll104567",
					                url: "https://www.bilibili.com/video/BV1uiznY7Eaj"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <script>
					            writeupObj = {
					                name: "Manager",
					                creator: "pointedsec",
					                url: "https://pointedsec.github.io/writeups/manager---vulnyx"
					            };
					            writeupsArr.push(writeupObj);
					        </script>
					        <button class="writeup-btn" title="Show writeups" onclick="showWriteups('Manager')">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-book" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#b3da49" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M3 19a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
					                <path d="M3 6a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
					                <line x1="3" y1="6" x2="3" y2="19" />
					                <line x1="12" y1="6" x2="12" y2="19" />
					                <line x1="21" y1="6" x2="21" y2="19" />
					            </svg>
					        </button>
					        <button class="add-writeup-btn" title="Add writeup" onclick="showWriteupForm('Manager')">
					            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#49da57" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
									  <path d="M14 3v4a1 1 0 0 0 1 1h4" />
									  <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h6l6 6v10a2 2 0 0 1 -2 2z" />
									  <path d="M12 17v-6" />
									  <path d="M9.5 13.5l2.5 -2.5l2.5 2.5" />
									</svg>
					        </button>
					        <section id="Manager" class="modal">
					            <article class="modal-content">
					                <span class="close">&times;</span>
					                <p class="writeup-title"></p>
					                <div class="writeups-container"></div>
					            </article>
					        </section>
					        
					        <!-- FIRST USER -->
					    <td class="first-user">softyhack</td>
					
					    <!-- FIRST ROOT -->
					    <td class="first-user">ll104567</td>
					        
					        <td class="flag">
							
								<!-- BOTON ENVIAR FLAG -->
						        
						        <button class="submit-flag-btn" title="Enviar flag" onclick="showFlagForm('user/root', 'Manager')">
								  <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-flag-2" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#f26e56" fill="none" stroke-linecap="round" stroke-linejoin="round">
								    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
								    <path d="M5 5v16" />
								    <path d="M5 5h14l-3 5l3 5h-14" />
								  </svg>
								</button>
							</td>
					        
					        <!-- DOWNLOAD -->
					    
					    <td class="url">
					        <a href="https://vulnyx.com/file/Manager.php" target="_blank" title="Download VM">
					            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-download" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#d9534f" fill="none" stroke-linecap="round" stroke-linejoin="round">
					                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
					                <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2 -2v-2" />
					                <path d="M7 11l5 5l5 -5" />
					                <path d="M12 4l0 12" />
					            </svg>
					        </a>
					    </td>
						<tr class="row">
						  <!-- # -->
						  <td class="idnum">
						    <span id="idnum">9</span>
						  </td>
						  
						  <!-- CARD -->
						  <td class="card">
						    <button class="card-btn" title="Show card!" onclick="showCard('Controler', 'Windows', 'Medium', 'd4t4s3c', '23 Oct 2024')">
						      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#3fa8f4" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <circle cx="12" cy="12" r="10" stroke="#3fa8f4" stroke-width="1.5" fill="none"/>
									  <line x1="12" y1="8" x2="12" y2="8.01" stroke="#3fa8f4" stroke-width="1.5"/>
									  <line x1="12" y1="10" x2="12" y2="16" stroke="#3fa8f4" stroke-width="1.5"/>
									</svg>
						    </button>
						  </td>
						  
						  <!-- NAME/SIZE -->
						    
						    <td id="vm">
							  <div class="vm-name-btn level-btn medium">
							    <img class="medium-dots" title="WindowsVM" alt="Windows" src="<%= request.getContextPath() %>/img/Windows.svg" width="22" height="22" loading="lazy">
							    <span class="vm-name-wrapper" style="display: flex; align-items: center; gap: 0.4rem;">
							      <span class="vm-name" style="margin-right: -60px;">Controler</span>
							      <span class="vm-size" style="margin-right: 20px; margin-left: auto;">5.0GB</span>
							    </span>
							  </div>
							</td>
						  
						  <!-- TESTED -->
						  
						  <td class="tested">
						    <img title="VirtualBox" alt="VirtualBox logo" src="<%= request.getContextPath() %>/img/vbox.png" width="25" height="25">
						  </td>
						  
						  <!-- MD5 -->
						  <td class="md5">
						    <span id="md5-hash" title="73ECC9FD5D9CEC03A67124D9BE5A2151">
						      <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-file-info" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round" stroke-linejoin="round">
						        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
						        <path d="M14 3v4a1 1 0 0 0 1 1h4" />
						        <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />
						        <path d="M11 14h1v4h1" />
						        <path d="M12 11h.01" />
						      </svg>
						    </span>
						    <button class="copy-btn" title="Copy to clipboard!" onclick="copyToClipboard(this)">
						      <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-copy" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#dad049" fill="none" stroke-linecap="round" stroke-linejoin="round">
						        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
						        <path d="M8 8m0 2a2 2 0 0 1 2 -2h8a2 2 0 0 1 2 2v8a2 2 0 0 1 -2 2h-8a2 2 0 0 1 -2 -2z" />
						        <path d="M16 8v-2a2 2 0 0 0 -2 -2h-8a2 2 0 0 0 -2 2v8a2 2 0 0 0 2 2h2" />
						      </svg>
						    </button>
						    <div class="tooltip">Copied!</div>
						  </td>
						  
						  <!-- WRITEUPS -->
						  <td class="writeups">
						    <script>
						      writeupObj = {
						        name: "Controler",
						        creator: "d4t4s3c",
						        url: "https://d4t4s3c.com/vulnyx/2024/10/23/Controler/"
						      };
						      writeupsArr.push(writeupObj);
						    </script>
						    <script>
						      writeupObj = {
						        name: "Controler",
						        creator: "pointedsec",
						        url: "https://pointedsec.github.io/writeups/controler---vulnyx"
						      };
						      writeupsArr.push(writeupObj);
						    </script>
						    <script>
						      writeupObj = {
						        name: "Controler",
						        creator: "ll104567",
						        url: "https://www.bilibili.com/video/BV1ZeqUYeEcj"
						      };
						      writeupsArr.push(writeupObj);
						    </script>
						    <script>
						      writeupObj = {
						        name: "Controler",
						        creator: "J4ckie0x17",
						        url: "https://j4ckie0x17.gitbook.io/notes-pentesting/writeups/vulnyx/controler"
						      };
						      writeupsArr.push(writeupObj);
						    </script>
						    <script>
						      writeupObj = {
						        name: "Controler",
						        creator: "miguel0x1985",
						        url: "https://github.com/miguellofredo85/PwnLabs/blob/main/Vulnyx/Controller%20AD.pdf"
						      };
						      writeupsArr.push(writeupObj);
						    </script>
						    
						    <button class="writeup-btn" title="Show writeups" onclick="showWriteups('Controler')">
						      <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-book" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#b3da49" fill="none" stroke-linecap="round" stroke-linejoin="round">
						        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
						        <path d="M3 19a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
						        <path d="M3 6a9 9 0 0 1 9 0a9 9 0 0 1 9 0" />
						        <line x1="3" y1="6" x2="3" y2="19" />
						        <line x1="12" y1="6" x2="12" y2="19" />
						        <line x1="21" y1="6" x2="21" y2="19" />
						      </svg>
						    </button>
						    <button class="add-writeup-btn" title="Add writeup" onclick="showWriteupForm('Controler')">
						      <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#49da57" fill="none" stroke-linecap="round" stroke-linejoin="round">
									  <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
									  <path d="M14 3v4a1 1 0 0 0 1 1h4" />
									  <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h6l6 6v10a2 2 0 0 1 -2 2z" />
									  <path d="M12 17v-6" />
									  <path d="M9.5 13.5l2.5 -2.5l2.5 2.5" />
									</svg>
						    </button>
						    
						    <section id="Controler" class="modal">
						      <article class="modal-content">
						        <span class="close">&times;</span>
						        <p class="writeup-title"></p>
						        <div class="writeups-container"></div>
						      </article>
						    </section>
						    
						    <!-- FIRST USER -->
						  <td class="first-user">Rev3rKh1ll</td>
						  
						  <!-- FIRST ROOT -->
						  <td class="first-user">Rev3rKh1ll</td>
						    
						    <td class="flag">
							
								<!-- BOTON ENVIAR FLAG -->
						        
						        <button class="submit-flag-btn" title="Enviar flag" onclick="showFlagForm('user/root', 'Controler')">
								  <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-flag-2" width="22" height="22" viewBox="0 0 24 24" stroke-width="1.5" stroke="#f26e56" fill="none" stroke-linecap="round" stroke-linejoin="round">
								    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
								    <path d="M5 5v16" />
								    <path d="M5 5h14l-3 5l3 5h-14" />
								  </svg>
								</button>
							</td>
						    
						    <!-- DOWNLOAD -->
						  
						  <td class="url">
						    <a href="https://vulnyx.com/file/Controler.php" target="_blank" title="Download VM">
						      <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-download" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#d9534f" fill="none" stroke-linecap="round" stroke-linejoin="round">
						        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
						        <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2 -2v-2" />
						        <path d="M7 11l5 5l5 -5" />
						        <path d="M12 4l0 12" />
						      </svg>
						    </a>
						  </td>
					</tbody>
				</table>
				<p id="search-message">
					No hay coincidencias para <span id="query"></span>. Pruebe con otra búsqueda.
				</p>
			</div>
			
			<!-- SECCION DE ENVIAR WRITEUP -->
			
			<section class="form-writeup">
			  <div class="form-container">
			    <!-- Título y botón de cierre -->
			    <span class="close-form" style="margin-bottom: -30px !important; margin-top: -20px !important; margin-right: -15px !important;">&times;</span>
			    <div class="form-title">
			      <h1 style="font-size: 20px !important; color: #3379ac !important; font-style: bold !important; margin-bottom: -20px !important;">Nuevo envío de writeup </h1>
			    </div>
			
			    <!-- Descripción -->
			    <p class="form-text" style="font-size: 15px !important; margin-bottom: -17px !important;">
			      Complete todos los campos del formulario con la información de su informe. Después de la revisión, si el informe cumple con nuestras reglas de envío, el artículo estará disponible públicamente en el sitio web para cualquier usuario.
			    </p>
			
			    <!-- Formulario -->
			    <form class="form submit-form" id="writeupForm">
			      <!-- Campos del formulario -->
			      <div class="form-field" style="margin-bottom: -15px !important; margin-top: 5px !important;">
			        <label class="form-label" for="writeup-creator" style="margin-bottom: -5px !important;">Creador</label>
			        <input
			          class="form-control"
			          id="writeup-creator"
			          name="Creator"
			          type="text"
			          maxlength="15"
			          placeholder="Nombre de usuario"
			          required
			        />
			      </div>
				<br>
			      <div class="form-field" style="margin-bottom: -15px !important; margin-top: 10px !important;">
			        <label class="form-label" for="writeup-url" style="margin-bottom: -5px !important;">URL</label>
			        <input
			          class="form-control"
			          id="writeup-url"
			          name="URL"
			          type="url"
			          pattern="https?://.+"
			          placeholder="URL del writeup"
			          required
			        />
			      </div>
				<br>
			      <div class="form-field" style="margin-bottom: -15px !important; margin-top: 10px !important;">
			        <span class="form-label" style="margin-bottom: -5px !important;">Tipo de contenido</span>
			        <div class="form-checkbox" id="content-type">
			          <input
			            type="radio"
			            id="text"
			            name="ContentType"
			            value="Text"
			            checked
			          />
			          <label for="text" style="margin-bottom: -5px !important;">Texto</label>
			          <input type="radio" id="video" name="ContentType" value="Video" />
			          <label for="video" style="margin-bottom: -5px !important;">Video</label>
			        </div>
			      </div>
				<br>
			      <div class="form-field" style="margin-bottom: -15px !important; margin-top: 10px !important;">
			        <label class="form-label" for="language" style="margin-bottom: -5px !important;">Idioma</label>
			        <select class="form-control" id="language" name="Language" required>
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
				<br>
			      <div class="form-field" style="margin-bottom: -15px !important; margin-top: 10px !important;">
			        <label class="form-label" for="opinion" style="margin-bottom: -5px !important;">Opinion (Opcional)</label>
			        <textarea
			          class="form-control"
			          id="opinion"
			          name="Opinion"
			          maxlength="2000"
			          rows="2"
			          placeholder="Tu opinión solo se compartirá con el equipo de Pwn3d! y será útil como retroalimentación. Usted es libre de revisar o calificar la máquina como desee."
			        ></textarea>
			      </div>
				<br>
			      <!-- Botones -->
			      <div class="form-btns" style="margin-bottom: -5px !important; margin-top: 10px !important;">
			        <button class="button" type="submit">Enviar</button>
			        <button class="button" type="reset">Borrar</button>
			      </div>
			
			      <!-- Footer -->
			      <div class="form-footer" style="margin-bottom: -15px !important; margin-top: 20px !important;"">
			        <small>
			          Por favor, lea nuestras
			          <a href="https://vulnyx.com/rules/" target="_blank">
			            <strong>Reglas</strong>
			          </a>
			          antes de enviar un nuevo writeup.
			        </small>
			      </div>
			    </form>
			  </div>
			</section>
			
			<!-- SECCION DE ENVIAR FLAGs -->
			
			<section class="form-flag">
			  <div class="form-container">
			    <!-- Botón de cierre -->
			    <span class="close-form" style="margin-bottom: -30px !important; margin-top: -20px !important; margin-right: -15px !important;">&times;</span>
			
			    <!-- Título -->
			    <div class="form-title">
			      <h1 style="font-size: 20px !important; color: #f26e56 !important; font-style: bold !important; margin-bottom: -20px !important;">Enviar Flag</h1>
			    </div>
			
			    <!-- Descripción -->
			    <p class="form-text" style="font-size: 15px !important; margin-bottom: -17px !important;">
			      Ingrese su nombre de usuario y la flag correspondiente. Este formulario es solo informativo y no garantiza prioridad si otros ya enviaron antes.
			    </p>
			
			    <!-- Formulario -->
			    <form class="form submit-form" id="flagForm">
			      <!-- Campo: Usuario -->
			      <div class="form-field" style="margin-bottom: -15px !important; margin-top: 5px !important;">
			        <label class="form-label" for="username" style="margin-bottom: -5px !important;">Usuario</label>
			        <input
			          class="form-control"
			          id="username"
			          name="Username"
			          type="text"
			          maxlength="15"
			          placeholder="Nombre de usuario"
			          required
			          autocomplete="username"
			        />
			      </div>
			      <br>
			
			      <!-- Campo: Flag -->
			      <div class="form-field" style="margin-bottom: -15px !important; margin-top: 10px !important;">
			        <label class="form-label" for="flag" style="margin-bottom: -5px !important;">Flag</label>
			        <input
			          class="form-control"
			          id="flag"
			          name="Flag"
			          type="text"
			          maxlength="64"
			          placeholder="Ejemplo: PWNED{example_flag}"
			          required
			        />
			      </div>
			      <br>
			
			      <!-- Selector: Tipo de Flag -->
			      <div class="form-field" style="margin-bottom: -15px !important; margin-top: 10px !important;">
			        <span class="form-label" style="margin-bottom: -5px !important;">Tipo de flag</span>
			        <div class="form-checkbox" id="flag-type">
			          <input type="radio" id="user" name="FlagType" value="user" checked />
			          <label for="user" style="margin-bottom: -5px !important;">User</label>
			          <input type="radio" id="root" name="FlagType" value="root" />
			          <label for="root" style="margin-bottom: -5px !important;">Root</label>
			        </div>
			      </div>
			      <br>
			
			      <!-- Botones -->
			      <div class="form-btns" style="margin-bottom: -5px !important; margin-top: 10px !important;">
			        <button class="button" type="submit">Enviar</button>
			        <button class="button" type="reset">Borrar</button>
			      </div>
			
			      <!-- Footer -->
			      <div class="form-footer" style="margin-bottom: -15px !important; margin-top: 20px !important;">
			        <small>
			          Este formulario no valida las flags automáticamente. En un futuro se planea un sistema en tiempo real para mostrar el primero en enviarla.
			        </small>
			      </div>
			    </form>
			  </div>
			</section>
		</section>
	</main>
	<footer>
		<img src="<%= request.getContextPath() %>/img/logo1.ico" alt="Pwn3d! small footer logo" loading="lazy" style="width: 25px !important; height: 30px !important;">
		<p>© Pwn3d! 2024-2025</p>
		
		<!-- REDES SOCIALES -->
		
		<article class="project-info">
	        
	            <!-- RRSS (Redes Sociales) -->
	            
	            <div class="media-links">
	            
	                <!-- Ko-fi -->
	                
	                <a title="Support us on Ko-fi" href="https://ko-fi.com/vulnyx" target="_blank">
	                    <img width="28" height="24" src="https://storage.ko-fi.com/cdn/kofi_stroke_cup.svg" alt="Ko-fi Logo" loading="eager">
	                </a>
	
	                <!-- DISCORD -->
	                
	                <a title="Discord" href="https://discord.gg/qdm3bN3Emb" target="_blank">
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
	                
	                <a title="LinkedIn" href="https://www.linkedin.com/company/vulnyx-official/" target="_blank">
	                    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-brand-linkedin" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#0077B5" fill="none" stroke-linecap="round" stroke-linejoin="round">
	                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
	                        <path d="M4 4m0 2a2 2 0 0 1 2 -2h12a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-12a2 2 0 0 1 -2 -2z" />
	                        <path d="M8 11l0 5" />
	                        <path d="M8 8l0 .01" />
	                        <path d="M12 16l0 -5" />
	                        <path d="M16 16v-3a2 2 0 0 0 -4 0" />
	                    </svg>
	                </a>
	
	                <!-- INSTAGRAM -->
	                
	                <a title="Instagram" href="https://www.instagram.com/vulnyxofficial/" target="_blank">
	                    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-brand-instagram" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#F56040" fill="none" stroke-linecap="round" stroke-linejoin="round">
	                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
	                        <path d="M4 4m0 4a4 4 0 0 1 4 -4h8a4 4 0 0 1 4 4v8a4 4 0 0 1 -4 4h-8a4 4 0 0 1 -4 -4z" />
	                        <path d="M12 12m-3 0a3 3 0 1 0 6 0a3 3 0 1 0 -6 0" />
	                        <path d="M16.5 7.5l0 .01" />
	                    </svg>
	                </a>
	
	                <!-- X (TWITTER) -->
	                
	                <a title="X" href="https://x.com/VulNyxOfficial" target="_blank">
	                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#ffffff" fill="none" stroke-linecap="round" stroke-linejoin="round">
	                        <path d="M4 4l11.733 16h4.267l-11.733 -16z"></path>
	                        <path d="M4 20l6.768 -6.768m2.46 -2.46l6.772 -6.772"></path>
	                    </svg>
	                </a>
	
	                <!-- TELEGRAM -->
	                
	                <a title="Telegram" href="https://t.me/VulNyx" target="_blank">
	                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#27A7E7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
	                        <path d="M15 10l-4 4l6 6l4 -16l-18 7l4 2l2 6l3 -4" />
	                    </svg>
	                </a>
	
	                <!-- MAIL -->
	                
	                <a title="Mail" href="mailto:hello@vulnyx.com" target="_blank">
	                    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-mail" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#8a90c7" fill="none" stroke-linecap="round" stroke-linejoin="round">
	                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
	                        <rect x="3" y="5" width="18" height="14" rx="2" />
	                        <polyline points="3 7 12 13 21 7" />
	                    </svg>
	                </a>
	
	                <!-- RSS -->
	                
	                <a title="RSS" href="https://vulnyx.com/feed/rss.xml" target="_blank">
	                    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-rss" width="24" height="24" viewBox="0 0 24 24" stroke-width="1.5" stroke="#00b341" fill="none" stroke-linecap="round" stroke-linejoin="round">
	                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
	                        <path d="M5 19m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0" />
	                        <path d="M4 4a16 16 0 0 1 16 16" />
	                        <path d="M4 11a9 9 0 0 1 9 9" />
	                    </svg>
	                </a>
	            </div>
				</article>
	</footer>
	<script src="<%= request.getContextPath() %>/js/machines23.js"></script>
	<script>
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
	</script>

</body>
</html>