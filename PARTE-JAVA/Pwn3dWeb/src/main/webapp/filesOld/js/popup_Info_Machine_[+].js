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
		      '<br>' +
		   	  // Descripción
		      '<div class="info-row" style="margin-bottom: 10px;">' +
		        '<h3>DESCRIPCIÓN: </h3>' +
		        '<p>' + (machine.description && machine.description.trim() !== '' 
		                  ? machine.description 
		                  : 'No hay descripción para esta máquina.') + '</p>' +
		      '</div>' +
				'<br>' +
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
			      '<li><strong>Root:</strong> ' + (machine.flagsRootCount !== undefined ? machine.flagsRootCount : 'No disponible') + '</li>' +
			      '<li><strong>User:</strong> ' + (machine.flagsUserCount !== undefined ? machine.flagsUserCount : 'No disponible') + '</li>' +
			      '<li><strong>Writeups:</strong> ' + (machine.totalWriteups !== undefined ? machine.totalWriteups : 'No disponible') + '</li>' +
			    '</ul>' +
			  '</section>' +
			  '<br>' +
			  // Barras de estado
			  '<section>' +
			    '<h3>Barras de estado</h3>' +
			    '<div class="metrics">' +
			
			      '<div class="metric">' +
			        '<p><strong>Flags Users:</strong> ' + (machine.flagsUserCount !== undefined ? machine.flagsUserCount : 'N/A') + '</p>' +
			        '<div class="bar-bg"><div class="bar-fill cpu" style="width:' + (machine.flagsUserCount || 0) + '%;"></div></div>' +
			      '</div>' +
			
			      '<div class="metric">' +
			        '<p><strong>Flags Root:</strong> ' + (machine.flagsRootCount !== undefined ? machine.flagsRootCount : 'N/A') + '</p>' +
			        '<div class="bar-bg"><div class="bar-fill ram" style="width:' + (machine.flagsRootCount || 0) + '%;"></div></div>' +
			      '</div>' +
			    
			      '<div class="metric">' +
			        '<p><strong>Writeups:</strong> ' + (machine.totalWriteups !== undefined ? machine.totalWriteups : 'N/A') + '</p>' +
			        // Aquí asumo que writeupsPercent ya lo calculas aparte basado en totalWriteups y algún total general
			        '<div class="bar-bg"><div class="bar-fill disk" style="width:' + writeupsPercent + '%;"></div></div>' +
			      '</div>' +
			
			    '</div>' +
			  '</section>' +
			  '<br>' +
				// Logs recientes
			  '<section>' +
			    '<h3>Logs recientes</h3>' +
			    '<div class="logs" tabindex="0" aria-label="Lista de logs recientes">' +
			      (machine.logs && machine.logs.length > 0
			        ? machine.logs.map(log => '<p style="margin:0 0 6px 0;">' + log + '</p>').join('')
			        : '<p>No hay logs disponibles.</p>') +
			    '</div>' +
			  '</section>' +
		
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