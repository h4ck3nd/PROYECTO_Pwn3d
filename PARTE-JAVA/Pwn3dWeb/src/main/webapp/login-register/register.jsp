<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
  <title>Pwned! - Registro</title>
  <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssRegister.jsp">
</head>
<body>
  <div class="container">
    <!-- LADO IZQUIERDO CON MONITOR -->
    <div class="left-panel">
      <div class="left-content">
        <div class="page-title">Pwned!</div>
        <div class="image-box">
          <img src="<%= request.getContextPath() %>/img/monitor.png" alt="Registro CTF">
          <div class="matrix-container">
            <canvas id="matrixCanvasText"></canvas>
          </div>
        </div>
        <br><br>
        <div class="page-title"><a href="<%= request.getContextPath() %>/welcome.jsp"
		   style="display: inline-block;
		          padding: 0.4rem 1rem;
		          font-size: 0.65rem;
		          font-family: 'Press Start 2P', monospace;
		          text-decoration: none;
		          color: #d35eff;
		          background-color: #1a001f;
		          border: 1px solid #d35eff;
		          border-radius: 4px;
		          box-shadow: 0 0 6px #d35eff55;
		          transition: all 0.2s ease-in-out;">
		   ← Volver al inicio
		   </a></div>
      </div>
    </div>
	
	<!-- Imagen grande entre paneles -->
  <div class="middle-image" style="flex: 0 0 auto; display: flex; justify-content: center; align-items: center; padding: 0 10px;">
    <img src="<%= request.getContextPath() %>/img/logo-flag-white.png" alt="Imagen Grande" style="max-width: 300%; max-height: 400px; object-fit: contain;" />
  </div>
	
    <!-- LADO DERECHO CON FORMULARIO -->
    <div class="right-panel">
	  <div class="register-container">
	    <h1>REGISTRARTE EN PWNED!</h1>
	    <form method="post" action="<%= request.getContextPath() %>/register">
	      <label for="first-name">NOMBRE</label>
	      <input type="text" id="first-name" name="first-name" placeholder="nombre" required />
	
	      <label for="last-name">APELLIDOS</label>
	      <input type="text" id="last-name" name="last-name" placeholder="apellidos" required />
	
	      <label for="email">CORREO</label>
	      <input type="email" id="email" name="email" placeholder="tu@email.com" required />
	
	      <label for="username">NOMBRE DE USUARIO</label>
	      <input type="text" id="username" name="username" placeholder="username" required />
	
	      <label for="password">CONTRASEÑA</label>
			<div class="password-wrapper">
			  <input type="password" id="password" name="password" placeholder="********" required />
			  <span class="toggle-password" onclick="togglePassword('password', this)">
			    <!-- SVG Ojo abierto -->
			    <svg class="eye-icon open" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
			      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
			        d="M1.5 12s4.5-7.5 10.5-7.5S22.5 12 22.5 12s-4.5 7.5-10.5 7.5S1.5 12 1.5 12z" />
			      <circle cx="12" cy="12" r="3" stroke="currentColor" stroke-width="2" fill="none" />
			    </svg>
			    <!-- SVG Ojo cerrado -->
			    <svg class="eye-icon closed" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" style="display: none;">
			      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
			        d="M17.94 17.94A10.07 10.07 0 0112 19.5C6 19.5 1.5 12 1.5 12c.71-1.18 1.62-2.27 2.61-3.22m2.55-2.04A10.1 10.1 0 0112 4.5c6 0 10.5 7.5 10.5 7.5-.35.59-.74 1.15-1.15 1.68M3 3l18 18" />
			    </svg>
			  </span>
			</div>
			
			<label for="confirm-password">REPETIR CONTRASEÑA</label>
			<div class="password-wrapper">
			  <input type="password" id="confirm-password" name="confirm-password" placeholder="********" required />
			  <span class="toggle-password" onclick="togglePassword('confirm-password', this)">
			    <!-- SVG Ojo abierto -->
			    <svg class="eye-icon open" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
			      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
			        d="M1.5 12s4.5-7.5 10.5-7.5S22.5 12 22.5 12s-4.5 7.5-10.5 7.5S1.5 12 1.5 12z" />
			      <circle cx="12" cy="12" r="3" stroke="currentColor" stroke-width="2" fill="none" />
			    </svg>
			    <!-- SVG Ojo cerrado -->
			    <svg class="eye-icon closed" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" style="display: none;">
			      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
			        d="M17.94 17.94A10.07 10.07 0 0112 19.5C6 19.5 1.5 12 1.5 12c.71-1.18 1.62-2.27 2.61-3.22m2.55-2.04A10.1 10.1 0 0112 4.5c6 0 10.5 7.5 10.5 7.5-.35.59-.74 1.15-1.15 1.68M3 3l18 18" />
			    </svg>
			  </span>
			</div>
		  
		  <button type="button" id="generate-password-btn" class="secure-btn">
		  🔐 Recomendar contraseña segura
		</button>

		  
	      <input type="submit" value="REGÍSTRATE" />
	    </form>
	    <div class="footer">¡ÚNETE A LA RESISTENCIA!</div>
	    
	    <!-- MENSAJE DE EXITO MEDIANTE EL CONTROLADOR -->
	    
	    <%
		    String loginExit = (String) session.getAttribute("loginExit");
		    if (loginExit != null) {
		%>  
		    <br>
		    <div style="color: green; font-weight: bold; font-size: 0.8rem;">
		        <%= loginExit %>
		    </div>
		    <script>
		        // Redirige a login.jsp después de 3 segundos (3000 ms)
		        setTimeout(function() {
		            window.location.href = '<%= request.getContextPath() %>/login-register/login.jsp';
		        }, 3000);
		    </script>
		<%
		        session.removeAttribute("loginExit"); // Elimina el mensaje después de mostrarlo
		    }
		%>
	    
	    <!-- MENSAJE DE ERROR MEDIANTE EL CONTROLADOR -->
	    
	    <%
		    String loginError = (String) session.getAttribute("loginError");
		    if (loginError != null) {
		%>	
			<br>
		    <div style="color: red; font-weight: bold; font-size: 0.8rem;">
		        <%= loginError %>
		    </div>
		<%
		        session.removeAttribute("loginError"); // Elimina el mensaje después de mostrarlo
		    }
		%>
		
		<%
		    String loginErrorPass = (String) session.getAttribute("loginErrorPass");
		    if (loginErrorPass != null) {
		%>	
			<br>
		    <div style="color: red; font-weight: bold; font-size: 0.8rem;">
		        <%= loginErrorPass %>
		    </div>
		<%
		        session.removeAttribute("loginErrorPass"); // Elimina el mensaje después de mostrarlo
		    }
		%>
	    <br><br>
	    <a href="<%= request.getContextPath() %>/login-register/login.jsp" class="btn-login-small">Ya tienes una cuenta? Inicia Sesión aquí</a>
	  </div>
	</div>
  </div>
  <%
    String codigoSeguro = (String) session.getAttribute("codigoSeguro");
    if (codigoSeguro != null) {
        // Borramos para que no se vuelva a disparar al refrescar la página
        session.removeAttribute("codigoSeguro");
%>
<script>
  // Generar archivo .txt y forzar descarga
  const codigoSeguro = "<%= codigoSeguro %>";
  const usuario = "<%= session.getAttribute("usuario") != null ? session.getAttribute("usuario") : "usuario" %>";
  const contenido = "Tu código seguro para recuperar la contraseña:\n" + codigoSeguro;

  const blob = new Blob([contenido], { type: "text/plain" });
  const url = URL.createObjectURL(blob);

  const a = document.createElement("a");
  a.href = url;
  a.download = usuario + "_codigo_seguro.txt";
  document.body.appendChild(a);
  a.click();

  setTimeout(() => {
    URL.revokeObjectURL(url);
    document.body.removeChild(a);
    // Redirigir a login o donde quieras
    window.location.href = "login.jsp";
  }, 3000);
</script>
<% } %>
  <script src="<%= request.getContextPath() %>/js/jsRegister.jsp"></script>
</body>
</html>
