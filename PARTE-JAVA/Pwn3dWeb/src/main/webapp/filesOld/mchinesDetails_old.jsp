<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Detalles de la Máquina</title>
  <style>
  /* Fuente retro clásica */
@font-face {
  font-family: 'Press Start 2P';
  src: url('../fonts/PressStart2P-Regular.ttf') format('truetype');
  font-weight: normal;
  font-style: normal;
}

/* BODY general */
body {
  font-family: 'Press Start 2P', monospace !important;
  background-color: #1e1b27;
  color: #b0a0c6;
  margin: 0;
  padding: 2rem 4rem 4rem 4rem;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  /* Text shadow muy sutil para darle profundidad retro */
  text-shadow: 0 0 2px #3a2f4d;
}

/* TÍTULO ANIMADO */
#animatedTitle {
  font-size: 2.8rem;
  font-weight: 800;
  color: #cba9ff;
  margin-bottom: 3rem;
  text-align: left;
  width: 100%;
  user-select: none;
  /* Sombra clásica retro, menos glow más sombra definida */
  text-shadow:
    1px 1px 0 #59397a,
    2px 2px 3px #7a5ab8;
}

/* Contenedor principal */
.machine-info {
  width: 100vw;
  max-width: 1600px;
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 3rem;
  padding: 0 4rem;
  box-sizing: border-box;
}

/* Columna de info */
.info-column {
  flex: 3;
  display: flex;
  flex-direction: column;
  gap: 2rem;
  line-height: 1.6;
  color: #d3b9ff;
  font-size: 1.15rem;
  user-select: text;
  max-width: 900px;
}

/* Títulos secundarios */
.info-column h3 {
  font-weight: 700;
  color: #bb88ff;
  border-bottom: 3px solid #7744ff66;
  padding-bottom: 0.5rem;
  margin-bottom: 1.3rem;
  font-size: 1.5rem;
  user-select: none;
  /* Borde con efecto pixelado */
  border-image: repeating-linear-gradient(
    to right,
    #7744ff 0,
    #7744ff 2px,
    transparent 2px,
    transparent 4px
  ) 10;
}

/* Listas de info */
.info-list {
  list-style: none;
  padding-left: 0;
  margin: 0;
}

.info-list li {
  margin-bottom: 0.9rem;
  display: flex;
  align-items: center;
  gap: 1rem;
  color: #e3d0ff;
  font-weight: 500;
}

/* Íconos */
.info-list li img {
  width: 28px;
  height: 28px;
  filter: drop-shadow(0 0 5px #8a6fd1cc);
  border-radius: 5px;
  /* Borde pixelado ligero */
  border: 1.5px solid #7f6aad;
}

/* Nombre máquina */
.machine-name {
  font-size: 2.6rem;
  font-weight: 900;
  color: #ddaaff;
  text-shadow:
    1px 1px 0 #59397a,
    2px 2px 4px #7a5ab8;
  margin-bottom: 1.5rem;
  user-select: none;
}

/* Texto de descripción */
.description-text {
  color: #e0caff;
  font-weight: 500;
  white-space: pre-wrap;
  line-height: 1.6;
  font-size: 1.25rem;
  max-width: 850px;
}

/* Columna de imagen */
.image-column {
  flex: 2;
  position: relative;
  display: flex;
  justify-content: flex-end;
  align-items: center;
  max-height: 700px;
  overflow: hidden;
  filter: drop-shadow(0 0 25px #7a5ab866);
  border: 2px solid #7a5ab866;
  border-radius: 16px;
  background: #2d2940;
}

/* Imagen */
.image-column img {
  max-height: 700px;
  max-width: 100%;
  border-radius: 15px;
  object-fit: contain;
  filter: brightness(0.85) blur(1.2px);
  transition: filter 0.4s ease;
  cursor: default;
  border: 3px solid #7a5ab844;
  box-shadow:
    inset 0 0 10px #7a5ab855,
    0 0 6px #7a5ab866;
}

.image-column img:hover {
  filter: brightness(1) blur(0);
  box-shadow:
    inset 0 0 14px #bca0ffcc,
    0 0 12px #bca0ffcc;
}

/* Métricas */
.metrics {
  display: flex;
  gap: 2rem;
  flex-wrap: wrap;
  margin-top: 2rem;
}

/* Cada métrica */
.metric {
  background: transparent;
  color: #c8b3ff;
  font-weight: 600;
  font-size: 1.1rem;
  min-width: 140px;
  user-select: none;
  padding: 0;
  box-shadow: none;
  flex: none;
  display: flex;
  flex-direction: column;
}

/* Texto métrica */
.metric p {
  margin: 0 0 0.4rem 0;
  font-weight: 700;
  color: #bb88ff;
  text-shadow:
    1px 1px 0 #59397a,
    2px 2px 6px #7a5ab8aa;
}

/* Fondo barra de progreso */
.bar-bg {
  background: linear-gradient(
    90deg,
    #553f99cc,
    #6650a4cc
  );
  border-radius: 14px;
  overflow: hidden;
  height: 18px;
  width: 100%;
  box-shadow:
    inset 1px 1px 5px #4a3874cc,
    inset -1px -1px 5px #7f6aadcc;
}

/* Barra de progreso relleno */
.bar-fill {
  height: 100%;
  border-radius: 14px;
  transition: width 0.7s ease;
  box-shadow: 0 0 10px #8a6fd1cc;
}

/* Diferentes colores para las barras */
.bar-fill.cpu {
  background: linear-gradient(90deg, #a48affcc, #7f6aadcc);
  box-shadow: 0 0 15px #8a6fd1cc;
}

.bar-fill.ram {
  background: linear-gradient(90deg, #c288ffcc, #a375d6cc);
  box-shadow: 0 0 15px #ab88ffcc;
}

.bar-fill.disk {
  background: linear-gradient(90deg, #e28affcc, #c775d6cc);
  box-shadow: 0 0 15px #d07affcc;
}

/*LOGS*/
.logs {
  background: transparent;
  padding: 0.5rem 1rem;
  border-radius: 8px;
  max-height: 220px;
  overflow-y: auto;
  color: #c4b3ffcc;
  font-size: 1rem;
  line-height: 1.5;
  white-space: pre-wrap;
  user-select: text;
  box-shadow: inset 0 0 8px #553f99aa;
  margin-top: 1rem;  /* mejor margin dentro del section */
  border-top: 1px solid #553f99cc;
}

/* Dots de dificultad */
.easy-dots {
  background: #28a745cc;
  box-shadow: 0 0 10px #28a745aa;
}
.medium-dots {
  background: #fbc801cc;
  box-shadow: 0 0 10px #fbc801aa;
}
.hard-dots {
  background: #cf8181cc;
  box-shadow: 0 0 10px #cf8181aa;
}
.very-easy-dots {
  background: #16fff1cc;
  box-shadow: 0 0 10px #16fff1aa;
}
.easy-dots,
.medium-dots,
.hard-dots,
.very-easy-dots {
  width: 26px;
  height: 26px;
  padding: 0.15rem;
  border-radius: 50%;
}

/* Etiquetas dificultad */
.easy {
  color: white;
  background: linear-gradient(to right, rgba(112, 229, 140, 0.25), #28a74522);
  border-radius: 7px;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.3);
  padding: 0.3rem 1rem;
}
.medium {
  color: white;
  background: linear-gradient(to right, rgba(225, 179, 0, 0.25), #e1b30022);
  border-radius: 7px;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.3);
  padding: 0.3rem 1rem;
}
.hard {
  color: white;
  background: linear-gradient(to right, rgba(178, 0, 0, 0.25), #b200001a);
  border-radius: 7px;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.3);
  padding: 0.3rem 1rem;
}
.very-easy {
  color: white;
  background: linear-gradient(to right, rgba(42, 206, 171, 0.25), #2aceab22);
  border-radius: 7px;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.3);
  padding: 0.3rem 1rem;
}

/* Botones retro pixelados */
button {
  font-family: 'Press Start 2P', monospace;
  font-size: 1rem;
  color: #d3b9ff;
  background: linear-gradient(145deg, #4e3c88, #37275d);
  border: 3px solid #7a5ab8;
  border-radius: 4px;
  box-shadow:
    inset 2px 2px 3px #2e2155,
    3px 3px 5px #775fc5aa;
  padding: 0.8rem 1.5rem;
  cursor: pointer;
  transition: all 0.3s ease;
  user-select: none;
  text-shadow: 0 0 3px #bb99ffaa;
}

button:hover {
  background: linear-gradient(145deg, #5d4fcf, #4b3db8);
  box-shadow:
    inset 3px 3px 5px #462e90,
    4px 4px 10px #a090ffbb;
  color: #f0e5ff;
}

/* Inputs retro */
input[type="text"], input[type="number"], textarea {
  font-family: 'Press Start 2P', monospace;
  background: #2d2940;
  border: 2px solid #7a5ab8;
  color: #cbbfff;
  padding: 0.7rem 1rem;
  font-size: 1rem;
  border-radius: 6px;
  box-shadow:
    inset 1px 1px 3px #6650a4cc;
  transition: border-color 0.3s ease, box-shadow 0.3s ease;
  user-select: text;
}

input[type="text"]:focus, input[type="number"]:focus, textarea:focus {
  outline: none;
  border-color: #bba0ff;
  box-shadow:
    0 0 12px #bba0ffcc,
    inset 1px 1px 4px #d7c9ffcc;
  background: #372f5c;
  color: #ede9ff;
}

/* Scrollbars personalizadas */
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}
::-webkit-scrollbar-track {
  background: #2d2940;
  border-radius: 6px;
}
::-webkit-scrollbar-thumb {
  background: #7a5ab8cc;
  border-radius: 6px;
  box-shadow: 0 0 6px #7a5ab8bb inset;
}
::-webkit-scrollbar-thumb:hover {
  background: #bba0ffcc;
}

/* Responsive adaptativo como el original */
@media (max-width: 1300px) {
  #animatedTitle {
    font-size: 2.2rem;
    margin-bottom: 2.5rem;
    padding: 0 2rem;
  }
  .machine-info {
    flex-direction: column;
    padding: 0 2rem;
    gap: 3rem;
    width: 100%;
    max-width: 100vw;
  }
  .info-column {
    max-width: 100%;
    flex: none;
    width: 100%;
  }
  .image-column {
    max-height: 450px;
    flex: none;
    width: 100%;
    justify-content: center;
  }
  .image-column img {
    max-height: 450px;
  }
  .metrics {
    justify-content: flex-start;
  }
}

@media (max-width: 600px) {
  #animatedTitle {
    font-size: 1.8rem;
    margin-bottom: 2rem;
    padding: 0 1rem;
  }
  .machine-name {
    font-size: 2rem;
  }
  .description-text {
    font-size: 1.1rem;
  }
  .info-list li {
    font-size: 1rem;
    gap: 0.6rem;
  }
  .metrics {
    flex-direction: column;
    gap: 1rem;
  }
}
.horizontal-row {
  display: flex;
  align-items: center;
  gap: 1rem;
  flex-wrap: nowrap;
  padding: 0.4rem 0;
}

.horizontal-row p {
  margin: 0;
  font-weight: 700;
  color: #a27bbc; /* morado suave, clásico */
  text-shadow:
    1px 1px 0 #59397a; /* sombra discreta para profundidad */
  user-select: none;
  min-width: 90px; /* etiquetas con ancho fijo */
  font-size: 1.1rem;
  font-family: 'Press Start 2P', monospace;
}

.horizontal-row img {
  padding: 2px;
  transition: transform 0.25s;
  border-radius: 10px;
  background: transparent;
  cursor: default;
}

.horizontal-row img:hover {
  transform: scale(1.1);
}
  .cursor {
  display: inline-block;
  animation: blink 1s step-start infinite;
  font-weight: bold;
  color: #b47aff; /* color del cursor */
}

@keyframes blink {
  50% { opacity: 0; }
  100% { opacity: 1; }
}
  
</style>
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
    	    ? contextPath + '/img/' + machine.nameMachine + '.png'
    	    : contextPath + '/img/logo-flag-white.png';
		
    	  
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
				      '<img src="' + (machine.firstRootImg ? contextPath + '/' + machine.firstRootImg : contextPath + '/imgProfile/default.png') + '" alt="Foto First Root" ' +
				           'style="width: 30px; height: 30px; border-radius: 50%; object-fit: cover; box-shadow: 0 0 4px #a362ff;" />' +
				      '<span>' + (machine.firstRoot || 'N/A') + '</span>' +
				    '</p>' +
				  '</div>' +

				  // First User
				  '<div style="text-align: center;">' +
				    '<p style="margin: 0; font-size: 1.3rem; display: inline-flex; align-items: center; justify-content: center; gap: 0.6rem;">' +
				      '<strong>First User:</strong>' +
				      '<img src="' + (machine.firstUserImg ? contextPath + '/' + machine.firstUserImg : contextPath + '/imgProfile/default.png') + '" alt="Foto First User" ' +
				           'style="width: 30px; height: 30px; border-radius: 50%; object-fit: cover; box-shadow: 0 0 4px #a362ff;" />' +
				      '<span>' + (machine.firstUser || 'N/A') + '</span>' +
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