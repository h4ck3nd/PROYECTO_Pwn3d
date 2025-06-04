<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
  <title>Detalles Machine - Pwn3d!</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssMachineDetails.jsp">
</head>
<body>

  <h2 id="animatedTitle">Información detallada de la máquina</h2>

  <div id="machineDetailsContainer" class="machine-info">
    <!-- Se cargará aquí el contenido -->
  </div>

  <script>
    const contextPath = "<%= request.getContextPath() %>";
    const urlParams = new URLSearchParams(window.location.search);
    const machineId = urlParams.get('id');

    if (!machineId) {
      document.getElementById('machineDetailsContainer').innerHTML = "<p>No se proporcionó ID de máquina.</p>";
    } else {
      fetch(contextPath + "/machineDetails?id=" + machineId)
        .then(response => {
          if (!response.ok) throw new Error("No se pudo obtener la información");
          return response.json();
        })
        .then(machine => {
          renderMachineDetails(machine);
        })
        .catch(error => {
          document.getElementById('machineDetailsContainer').innerHTML = "<p>Error: " + error.message + "</p>";
        });
    }

    function renderMachineDetails(machine) {
    	  var maxWriteups = 100;
    	  var writeupsPercent = machine.totalWriteups ? Math.min(100, (machine.totalWriteups / maxWriteups) * 100) : 0;

    	  var machineImageUrl = machine.nameMachine
    	    ? contextPath + '/img/' + machine.nameMachine.toLowerCase() + '.png'
    	    : contextPath + '/img/logo-flag-white.png';
		
    	    const firstRootName = machine.firstRoot || 'N/A';
    	    const firstUserName = machine.firstUser || 'N/A';

    	    const firstRootHTML = (firstRootName !== 'N/A' && machine.firstRootId)
    	      ? '<a href="' + contextPath + '/profile/profile-user-public.jsp?id=' + machine.firstRootId + '" style="color:#fff; text-decoration:none;">' + firstRootName + '</a>'
    	      : '<span style="color:#fff;">' + firstRootName + '</span>';

    	    const firstUserHTML = (firstUserName !== 'N/A' && machine.firstUserId)
    	      ? '<a href="' + contextPath + '/profile/profile-user-public.jsp?id=' + machine.firstUserId + '" style="color:#fff; text-decoration:none;">' + firstUserName + '</a>'
    	      : '<span style="color:#fff;">' + firstUserName + '</span>';
    	    
    	  var html = '';

    	  // Contenedor flex para info e imagen
    	  html += '<div class="machine-info">';

    	  // Columna izquierda con la info de la máquina
    	  html += '<div class="info-column">';

    	  html += '<p class="machine-name"><span id="typewriter"></span><span class="cursor">_</span></p>';

    	  html += '<div class="description-text">' +
    	  			'<p>DESCRIPCIÓN:</p>' +
    	            ((machine.description && machine.description.trim() !== '') ? machine.description : 'No hay descripción para esta máquina.') +
    	          '</div>';

    	  html += '<div class="info-row">' +
    	            '<span title="' + (machine.md5 || '') + '" style="display:flex; align-items:center; gap: 0.3rem;">' +
    	              '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" stroke="#b47aff" fill="none" stroke-width="1" stroke-linecap="round" stroke-linejoin="round">' +
    	                '<path d="M14 3v4a1 1 0 0 0 1 1h4"/>' +
    	                '<path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z"/>' +
    	                '<path d="M6.5 16v-2c0 -0.5 0.5 -1 1 -1s1 0.5 1 1v2"/>' +
    	                '<path d="M8.5 16v-2c0 -0.5 0.5 -1 1 -1s1 0.5 1 1v2"/>' +
    	                '<path d="M11.5 16v-3h1c0.6 0 1 0.5 1 1.5s-0.4 1.5 -1 1.5h-1z"/>' +
    	                '<path d="M16.5 13h-2v1.5c0.3 -0.2 0.7 -0.3 1 -0.3 0.6 0 1 0.4 1 1s-0.4 1 -1 1 -1 -0.4 -1 -1"/>' +
    	              '</svg>' +
    	              '<span style="color:#d1b3ff; font-weight:600;">MD5: </span><span>' + (machine.md5 || 'Sin MD5') + '</span>' +
    	            '</span>' +
    	          '</div>';

    	 html += '<div class="info-row horizontal-row">' +
    	          '<p>ENTORNOS:</p>' +
    	          '<img src="' + contextPath + '/img/' + (machine.enviroment || '') + '.png" width="28" height="28" alt="Entorno 1" />' +
    	          '<img src="' + contextPath + '/img/' + (machine.enviroment2 || '') + '.png" width="28" height="28" alt="Entorno 2" ' +
    	          ((machine.enviroment2 === undefined || machine.enviroment2 === "null") ? 'hidden' : '') + ' />' +
    	        '</div>';

    	html += '<div class="info-row horizontal-row">' +
    	          '<p>S.O.:</p>' +
    	          '<img src="' + contextPath + '/img/' + (machine.os || '') + '.svg" width="24" height="24" alt="Sistema operativo" />' +
    	        '</div>';


    	        html +=
    	        	  '<div class="creator-info ' + (machine.difficulty || '') + '" style="margin-top: 1rem; display: flex; align-items: center; gap: 1rem; font-family: \'Press Start 2P\', monospace !important; color: #d1b3ff;">' +
    	        	    '<img class="' + (machine.difficulty || '') + '-dots" src="' + contextPath + '/img/' + (machine.imgNameOs || '') + '.svg" width="28" height="28" alt="Icono dificultad" style="flex-shrink: 0;" />' +
    	        	    '<div style="display: flex; flex-direction: column; gap: 0.2rem;">' +
    	        	      '<span style="font-weight: 600; font-size: 0.8rem;">Creador: <span style="font-weight: 400;">' + (machine.creator || 'Desconocido') + '</span></span>' +
    	        	      '<span style="font-weight: 600; font-size: 0.8rem;">Fecha: <span style="font-weight: 400;">' + (machine.date || 'N/A') + '</span></span>' +
    	        	    '</div>' +
    	        	  '</div>';
    	          
    	  html += "<button " +
    	          "onclick=\"window.location.href='" + machine.downloadUrl + "'\" " +
    	          "title='" + machine.downloadUrl + "'" +
    	          "style=\"font-family: 'Press Start 2P', monospace; background: linear-gradient(90deg, #7f6aadcc, #bb88ffcc); border: none; border-radius: 12px; padding: 0.8rem 1.6rem; color: #fff; font-weight: 700; font-size: 1rem; cursor: pointer; text-shadow: 1px 1px 2px #59397a; box-shadow: 0 0 8px #bca0ffcc; transition: background 0.3s ease;\" " +
    	          "onmouseover=\"this.style.background='linear-gradient(90deg, #bb88ffcc, #ddaaffcc)'\" " +
    	          "onmouseout=\"this.style.background='linear-gradient(90deg, #7f6aadcc, #bb88ffcc)'\">" +
    	          "Descargar" +
    	          "</button>";
    	          
    	          html += '<section style="margin-top:1.5rem;">' +
    	          '<h3>Flags y Writeups generales</h3>' +

    	          '<div style="display:flex; align-items:center; gap:0.8rem; margin-bottom:0.8rem;">' +
    	            '<svg width="30" height="30" viewBox="0 0 24 24" fill="#bb88ff" xmlns="http://www.w3.org/2000/svg">' +
    	              '<text x="3" y="18" font-family="monospace" font-size="18" fill="#bb88ff">#</text>' +
    	            '</svg>' +
    	            '<strong>ID //</strong> ' + (machine.id || 'No disponible') +
    	          '</div>' +

    	          '<div style="display:flex; align-items:center; gap:0.8rem; margin-bottom:0.8rem;">' +
    	          '<svg width="20" height="20" viewBox="0 0 24 24" fill="#dd88ff" xmlns="http://www.w3.org/2000/svg">' +
    	            '<path d="M12 2C8.13 2 5 5.13 5 9c0 2.6 1.5 4.8 3.7 5.7V18H8v2h8v-2h-0.7v-3.3c2.2-0.9 3.7-3.1 3.7-5.7 0-3.87-3.13-7-7-7zM9 9.5a1.5 1.5 0 1 1 3 0 1.5 1.5 0 0 1-3 0zm6 0a1.5 1.5 0 1 1 3 0 1.5 1.5 0 0 1-3 0zM12 12a3 3 0 0 0-3 3h6a3 3 0 0 0-3-3z"/>' +
    	          '</svg>' +
    	          '<strong>Root //</strong> ' + (machine.flagsRootCount !== undefined ? machine.flagsRootCount : 'No disponible') +
    	        '</div>' +

    	          '<div style="display:flex; align-items:center; gap:0.8rem; margin-bottom:0.8rem;">' +
    	            '<svg width="20" height="20" viewBox="0 0 24 24" fill="#aa77ff" xmlns="http://www.w3.org/2000/svg">' +
    	              '<path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>' +
    	            '</svg>' +
    	            '<strong>User //</strong> ' + (machine.flagsUserCount !== undefined ? machine.flagsUserCount : 'No disponible') +
    	          '</div>' +

    	          '<div style="display:flex; align-items:center; gap:0.8rem;">' +
    	            '<svg width="20" height="20" viewBox="0 0 24 24" fill="#cc99ff" xmlns="http://www.w3.org/2000/svg">' +
    	              '<path d="M4 6h16v2H4V6zm0 5h16v2H4v-2zm0 5h16v2H4v-2z"/>' +
    	            '</svg>' +
    	            '<strong>Writeups //</strong> ' + (machine.totalWriteups !== undefined ? machine.totalWriteups : 'No disponible') +
    	          '</div>' +

    	        '</section>';


    	  html += '<section>' +
    	          '<h3>Barras de estado</h3>' +
    	          '<div class="metrics">' +
    	            '<div class="metric">' +
    	              '<p><strong>Flags Users:</strong> ' + (machine.flagsUserCount ?? 'N/A') + '</p>' +
    	              '<div class="bar-bg"><div class="bar-fill cpu" style="width:' + (machine.flagsUserCount || 0) + '%;"></div></div>' +
    	            '</div>' +
    	            '<div class="metric">' +
    	              '<p><strong>Flags Root:</strong> ' + (machine.flagsRootCount ?? 'N/A') + '</p>' +
    	              '<div class="bar-bg"><div class="bar-fill ram" style="width:' + (machine.flagsRootCount || 0) + '%;"></div></div>' +
    	            '</div>' +
    	            '<div class="metric">' +
    	              '<p><strong>Writeups:</strong> ' + (machine.totalWriteups ?? 'N/A') + '</p>' +
    	              '<div class="bar-bg"><div class="bar-fill disk" style="width:' + writeupsPercent + '%;"></div></div>' +
    	            '</div>' +
    	          '</div>' +
    	        '</section>';

    	        if (machine.logs && machine.logs.length > 0) {
    	        	  html += '<section style="margin-top:1.5rem;">' +
    	        	            '<h3>Logs</h3>' +
    	        	            '<div class="logs">';
    	        	  machine.logs.forEach(function(log) {
    	        	    html += '<p>' + log + '</p>';
    	        	  });
    	        	  html += '</div></section>';
    	        	} else {
    	        	  html += '<section style="margin-top:1.5rem;">' +
    	        	            '<h3>Logs</h3>' +
    	        	            '<div class="logs">' +
    	        	              '<p>No hay logs recientes</p>' +
    	        	            '</div>' +
    	        	          '</section>';
    	        	}

    	  html += '</div>'; // cierre info-column
    	          
    	  html +=
    		  '<div style="flex: 2; display: flex; flex-direction: column; align-items: center; gap: 1rem;">' +
    		    '<div class="image-column">' +
    		      '<img src="' + machineImageUrl + '" alt="Imagen máquina"' +
    		      ' onerror="this.onerror=null;this.src=\'' + contextPath + '/img/logo-flag-white.png\';" />' +
    		    '</div>' +

    		    // NUEVA SECCIÓN PARA firstRoot Y firstUser
    		    '<div style="width: 90%; padding: 1.2rem 1.5rem; color: #fff; font-family: \'Press Start 2P\', monospace; text-align: center; margin-top: 1.5rem;">' +
				  '<h4 style="margin: 0 0 1rem 0; font-size: 2rem; color: #fff; text-shadow: 1px 1px 4px #5e37a5;">Primeras Flags</h4>' +
				  '<br>' +
				// First Root
				  '<div style="text-align: center; margin-bottom: 1rem;">' +
				    '<p style="margin: 0; font-size: 1.3rem; display: inline-flex; align-items: center; justify-content: center; gap: 0.6rem;">' +
				      '<strong>First Root:</strong>' +
				      '<img class="' + (machine.firstRootIsProHacker ? "prohacker-border" : "") + '" src="' + (machine.firstRootImg ? contextPath + '/' + machine.firstRootImg : contextPath + '/imgProfile/default.png') + '" alt="Foto First Root" ' +
				           'style="width: 30px; height: 30px; border-radius: 50%; object-fit: cover; box-shadow: 0 0 4px #a362ff;" />' +
				           firstRootHTML +
				    '</p>' +
				  '</div>' +

				  // First User
				  '<div style="text-align: center;">' +
				    '<p style="margin: 0; font-size: 1.3rem; display: inline-flex; align-items: center; justify-content: center; gap: 0.6rem;">' +
				      '<strong>First User:</strong>' +
				      '<img class="' + (machine.firstUserIsProHacker ? "prohacker-border" : "") + '" src="' + (machine.firstUserImg ? contextPath + '/' + machine.firstUserImg : contextPath + '/imgProfile/default.png') + '" alt="Foto First User" ' +
				           'style="width: 30px; height: 30px; border-radius: 50%; object-fit: cover; box-shadow: 0 0 4px #a362ff;" />' +
				           firstUserHTML +
				    '</p>' +
				  '</div>' +
				  '<br>' + '<br>' +

    		    '<button ' +
    		      'onclick="window.location.href=\'<%= request.getContextPath() %>/machines.jsp\'" ' +
    		      'style="font-family: \'Press Start 2P\', monospace; background: linear-gradient(90deg, #7f6aadcc, #bb88ffcc); border: none; border-radius: 12px; padding: 0.8rem 1.6rem; color: #fff; font-weight: 700; font-size: 1.3rem; cursor: pointer; text-shadow: 1px 1px 2px #59397a; box-shadow: 0 0 8px #bca0ffcc; transition: background 0.3s ease;" ' +
    		      'onmouseover="this.style.background=\'linear-gradient(90deg, #bb88ffcc, #ddaaffcc)\'" ' +
    		      'onmouseout="this.style.background=\'linear-gradient(90deg, #7f6aadcc, #bb88ffcc)\'">' +
    		      'Volver' +
    		    '</button>' +
    		  '</div>';




    	  html += '</div>'; // cierre machine-info

    	  document.getElementById('machineDetailsContainer').innerHTML = html;
    	  
    	  const machineName = machine.nameMachine != null ? machine.nameMachine : "Nombre no disponible";
    	  const typewriterEl = document.getElementById('typewriter');

    	  let i = 0;

    	  function typeWriter() {
    	    if (i < machineName.length) {
    	      typewriterEl.textContent += machineName.charAt(i);
    	      i++;
    	      setTimeout(typeWriter, 100); // velocidad de escritura en ms
    	    }
    	  }

    	  // Limpia y comienza el efecto
    	  typewriterEl.textContent = '';
    	  typeWriter();
    	}


  </script>

</body>
</html>