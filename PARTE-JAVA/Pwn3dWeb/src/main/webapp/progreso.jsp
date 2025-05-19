<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="dao.FotoDAO" %>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    UsuarioJWT usuarioJWT = null;

	try {
	    usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
	} catch (Exception e) {
	    // Redirigir al servlet de logout en vez de al .jsp
	    response.sendRedirect(request.getContextPath() + "/logout");
	    return;
	}

    // Validar que userId no sea null ni vacío
    if (usuarioJWT.getUserId() == null || usuarioJWT.getUserId().isEmpty()) {
        out.println("<p>Error: El ID de usuario no está disponible en el token.</p>");
        return;
    }

    // Crear una instancia del DAO y obtener la foto de perfil
    FotoDAO fotoDAO = new FotoDAO();
    String photoPath = fotoDAO.obtenerRutaFotoPerfil(usuarioJWT.getUserId());

    // Si no tiene foto de perfil, establecer una imagen por defecto
    if (photoPath == null || photoPath.isEmpty()) {
        photoPath = "img/Profile.png";  // Ruta de la imagen por defecto
    }
    
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
<title>HACKEND - PROGRESO PERFIL</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/progreso.css">
<link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">
<style>
* {
			font-family: 'VT323', monospace !important;
			font-size: 20px;
		}
	.btn-exportar-update {
		color: white;
		border: none;
		font-weight: bold;
		background-color: transparent;
		font-size: 20px;
		cursor: pointer;
		align-content: center;
		text-align: center;
		align-items: center;
	}
	.form-exportar-update {
		align-content: center;
		text-align: center;
		align-items: center;
		width: 55%;
		padding: 14px 0;
		background-color: #007bff !important;
		border: none;
		border-radius: 8px;
		cursor: pointer;
		transition: background-color 0.3s ease !important;
	}
	.form-exportar-update:hover {
		background-color: #0056b3 !important;
	}
	.btn-update {
		display: block;
		background-color: #4f4f4f;
		color: #f0f0f0;
		text-decoration: none;
		text-align: center;
		padding: 10px 20px;
		border: 1px solid #444;
		font-family: 'VT323', monospace;
		font-size: 30px !important;
		border-radius: 5px;
		width: fit-content;
		margin: 0 auto;
		transition: background-color 0.3s ease, transform 0.2s ease;
	}
	.grafico-container {
		font-family: 'VT323', monospace !important;
		max-width: 600px;
		margin: 60px auto;
		padding: 20px;
		background: #333;
		border: 1px solid #eaeaea;
		border-radius: 12px;
		text-align: center;
	}
</style>
</head>
<body>
	<header class="main-header">
	<img src="<%= request.getContextPath() %>/<%= photoPath %>" alt="Foto de perfil" class="profile-image-update">
	<div class="left-text" style="font-size: 42px !important;">PROGRESO</div>
	<h1 class="titulo" style="font-size: 42px !important;">HACKEND</h1>
	<div class="window-buttons">
		<button class="btn minimizar">-</button>
		<button class="btn maximizar">O</button>
		<button onclick="window.location.href='<%= request.getContextPath() %>/profile.jsp'" class="btn cerrar">X</button>
	</div>
</header>
	<!-- Formulario oculto para enviar el ID del usuario -->
	<form id="autoSubmitForm" action="<%= request.getContextPath() %>/obtener-puntos" method="post">
	    <input type="hidden" name="userId" value="<%= usuarioJWT.getUserId() %>" />
	    <button type="submit" class="btn-update">ACTUALIZAR PAGINA</button>
	</form>
	<section class="grafico-container">
		<h2>Progreso en Laboratorios</h2>
		<canvas id="labChart" width="400" height="400"></canvas>
	</section>
	<main class="columns-container">
		<!-- Hacking Web -->
		<section class="lab-column">
			<h2>Hacking Web</h2>
			<p id="puntos-hacking" class="puntuacion-total">
			  Puntuación: ${puntosHackingWeb} / ${puntosTotalesLab1}
			</p>
			<div class="lab-card">
				<h3>Hacking Web</h3>
				<p>Pagina Hacking Web</p>
			</div>
		</section>

		<!-- DockerPwned -->
		<section class="lab-column">
			<h2>DockerPwned</h2>
			<p id="puntos-docker" class="puntuacion-total">
			  Puntuación: ${puntosDockerPwned} / ${puntosTotalesLab2}
			</p>
			<div class="lab-card">
				<h3>DockerPwned</h3>
				<p>Pagina DockerPwned</p>
			</div>
		</section>

		<!-- OvaLabs -->
		<section class="lab-column">
			<h2>OvaLabs</h2>
			<p id="puntos-ova" class="puntuacion-total">
			  Puntuación: ${puntosOvaLabs} / ${puntosTotalesLab3}
			</p>
			<div class="lab-card">
				<h3>OvaLabs</h3>
				<p>Pagina OvaLabs</p>
			</div>
		</section>
		
		<!-- Timelabs -->
		<section class="lab-column">
			<h2>Timelabs</h2>
			<p id="puntos-timelabs" class="puntuacion-total">
			  Puntuación: ${puntosTimelabs} / ${puntosTotalesLab4}
			</p>
			<div class="lab-card">
				<h3>Timelabs</h3>
				<p>Pagina Timelabs</p>
			</div>
		</section>
	</main>
	<div class="contenedor-exportar">
	  <form method="get" action="http://localhost:8089/exportarPDF" class="form-exportar-update">
	    <input type="hidden" name="user_id" value="<%= usuarioJWT.getUserId() %>">
	    <input type="hidden" name="usuarioNombre" value="<%= usuarioJWT.getNombre() %>">
	    <input type="hidden" name="usuarioApellidos" value="<%= usuarioJWT.getApellidos() %>">
	    <input type="hidden" name="usuarioEmail" value="<%= usuarioJWT.getEmail() %>">
	
	    <button type="submit" class="btn-exportar-update">📄 Exportar a PDF</button>
	  </form>
	</div>
	<footer class="footer"> &copy; 2025 Hackend. Todos los
		derechos reservados. 
	</footer>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
	//QUESO ESTADISTICAS
	const puntosPorLaboratorio = [
	  "${puntosXSS1}",  // Foro-xss (Hacking Web)
	  "${puntosSQLi1}", // Amashop (Hacking Web)
	  "${puntosOR1}", // Separo (Hacking Web)
	  "${puntosBAC1}",  // Hacking_community (Hacking Web)
	  "${puntosXPATH1}",  // CineHub (Hacking Web)
	  "${puntosForceBrute1}",  // RetroGame (Hacking Web)
	  "${puntosPyz1}",  // WhatsApp Fake (Hacking Web)
	  "${puntosLenguaje1}",  // RouterOS (Hacking Web)
	  "${puntosCommandInjection1}",  // HackGame (Hacking Web)
	  "${puntosR00tless}",  // r00tless (DockerPwned)
	  "${puntosCrackoff}",	// crackoff (DockerPwned)
	  "${puntosHackmedaddy}",	// hackmedaddy (DockerPwned)
	  "${puntosGoodness}",  // Goodness (OvaLabs)
	  "${puntosCineHack}",  // CineHack (Timelabs)
	].map(Number); // Convertimos a números
	
	const ctx = document.getElementById('labChart').getContext('2d');
	const labChart = new Chart(ctx, {
	  type: 'pie',
	  data: {
	    labels: [
	      'foro-xss (Hacking Web)',
	      'amashop (Hacking Web)',
	      'separo (Hacking Web)',
	      'hacking_community (Hacking Web)',
	      'CineHub (Hacking Web)',
	      'RetroGame (Hacking Web)',
	      'WhatsApp Fake (Hacking Web)',
	      'RouterOS (Hacking Web)',
	      'HackGame (Hacking Web)',
	      'RCE (DockerPwned)',
	      'r00tless (DockerPwned)',
	      'crackoff (DockerPwned)',
	      'hackmedaddy (DockerPwned)',
	      'goodness (OvaLabs)',
	      'cinehack (Timelabs)',
	    ],
	    datasets: [{
	      label: 'Distribución de Laboratorios',
	      data: puntosPorLaboratorio,
	      backgroundColor: [
	        '#66bb6a', '#81c784', '#a5d6a7', '#48e05f', '#14be2e', '#7ebd88', '#2b7136', '#31f550', '#9cd4a5',  // Hacking Web - VERDE
	        '#64b5f6', '#24a5d5', '#3c7e97', '#71b8d3',   // DockerPwned - AZUL
	        '#ffb74d',               					  // OvaLabs - NARANJA
	        '#d83333',               					  // Timelabs - ROJO
	      ],
	      borderColor: '#ffffff',
	      borderWidth: 2
	    }]
	  },
	  options: {
	    responsive: true,
	    plugins: {
	      legend: {
	        position: 'bottom',
	        labels: {
	          color: '#f5f6f8',
	          font: { size: 14 }
	        }
	      },
	      tooltip: {
	        callbacks: {
	          label: function(context) {
	            const label = context.label || '';
	            const index = context.dataIndex; // Obtener el índice de cada laboratorio
	            const valor = puntosPorLaboratorio[index]; // Obtener el valor correcto de puntos
	            return `${label}: ${valor} puntos`; // Muestra el nombre y los puntos
	          }
	        }
	      }
	    }
	  }
	});
</script>
<script src="<%= request.getContextPath() %>/js/progreso.js"></script>
</body>
</html>