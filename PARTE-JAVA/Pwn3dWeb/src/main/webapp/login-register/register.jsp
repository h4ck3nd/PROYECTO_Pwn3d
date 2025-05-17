<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
  <title>Pwned! - Registro</title>
  <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
  <style>
  * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      min-height: 100vh;
      background-color: #1a1a1a;
      color: #ffffff;
      font-family: 'Press Start 2P', monospace;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    /* LADO IZQUIERDO */
    .container {
      display: flex;
      width: 100%;
    }
    
    .left-panel {
      flex: 0.7;
      display: flex;
      text-align: center;
      justify-content: center;
      align-items: center;
      padding: 4rem;
      margin-right: 0;
    }

    .left-content {
      text-align: center;
    }

    .page-title {
      font-size: 1rem;
      color: #ffffff;
      margin-bottom: 1.5rem;
    }

    .image-box img {
      max-width: 100%;
      height: auto;
    }

    .image-box {
      position: relative;
      width: 100%;
      max-width: 580px;
      margin: 0 auto;
    }

    .matrix-container {
      position: absolute;
      top: 20.5%;
      left: 20.5%;
      width: 59%;
      height: 49%;
      background-color: transparent;
      overflow: hidden;
      z-index: 2;
    }

    #matrixCanvasText {
      width: 100%;
      height: 100%;
      display: block;
    }

    /* PANEL DERECHO */
    .right-panel {
      flex: 0.9;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      padding-top: 2rem;
    }

    .register-container {
      background-color: #2c2c2c;
      padding: 2rem;
      border: 3px solid #ffffff;
      border-radius: 4px;
      width: 400px;
      max-width: 95%;
      text-align: center;
    }

    h1 {
      font-size: 1rem;
      margin-bottom: 2rem;
      color: #ffffff;
    }

    form {
      display: flex;
      flex-direction: column;
    }

    label {
      font-size: 0.6rem;
      text-align: left;
      margin-bottom: 0.3rem;
      color: #e0e0e0;
    }

    input[type="text"],
    input[type="password"],
    input[type="email"] {
      padding: 0.5rem;
      margin-bottom: 1rem;
      border: 2px solid #555;
      background-color: #000;
      color: #00ff00;
      font-family: 'Press Start 2P', monospace;
      font-size: 0.7rem;
      outline: none;
      border-radius: 2px;
    }

    input::placeholder {
      color: #007700aa;
    }

    input[type="submit"] {
      padding: 0.8rem;
      background-color: #ffffff;
      color: #000000;
      font-weight: bold;
      border: 2px solid #000;
      border-radius: 2px;
      cursor: pointer;
      font-size: 0.7rem;
      transition: background-color 0.2s ease;
    }

    input[type="submit"]:hover {
      background-color: #e0e0e0;
    }

    .footer {
      margin-top: 1.5rem;
      font-size: 0.5rem;
      color: #999999;
    }

    /* RESPONSIVE */
    @media (max-width: 800px) {
      body {
        flex-direction: column;
        align-items: stretch;
      }
    
      .container {
        flex-direction: column;
        height: auto;
      }
    
      .left-panel {
        border-right: none;
        border-bottom: 3px solid #ffffff;
        padding: 1rem;
        height: auto;
      }
    
      .right-panel {
        height: auto;
        padding: 1rem;
      }
    
      .matrix-container {
        top: 18%;
        left: 15%;
        width: 70%;
        height: 50%;
      }
    }
	.btn-login-small {
		font-size: 0.6rem;
    	text-decoration: none;
    	color: white;
	}
	.btn-login-small:hover {
		color: gray;
	}
	
	.password-wrapper {
	  position: relative;
	}
	
	.password-wrapper input[type="password"],
	.password-wrapper input[type="text"] {
	  width: 100%;
	  padding-right: 2.5rem;
	}
	
	.toggle-password {
	  position: absolute;
	  right: 10px;
	  top: 35%;
	  transform: translateY(-50%);
	  cursor: pointer;
	  color: #00ff00;
	}
	
	.eye-icon {
	  width: 18px;
	  height: 18px;
	  display: inline-block;
	}
	
	.secure-btn {
	  margin-bottom: 1rem;
	  font-size: 0.65rem;
	  font-family: 'Press Start 2P', monospace;
	  background-color: #00ff00;
	  color: #000;
	  border: 2px solid #00ff00;
	  padding: 10px 14px;
	  border-radius: 4px;
	  cursor: pointer;
	  transition: all 0.3s ease;
	  display: inline-flex;
	  align-items: center;
	  gap: 6px;
	}
	
	.secure-btn:hover {
	  background-color: transparent;
	  color: #00ff00;
	}
  </style>
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
      </div>
    </div>
	
	<!-- Imagen grande entre paneles -->
  <div class="middle-image" style="flex: 0 0 auto; display: flex; justify-content: center; align-items: center; padding: 0 10px;">
    <img src="<%= request.getContextPath() %>/img/logo-flag-white.png" alt="Imagen Grande" style="max-width: 300%; max-height: 400px; object-fit: contain;" />
  </div>
	
    <!-- LADO DERECHO CON FORMULARIO -->
    <div class="right-panel">
	  <div class="register-container">
	    <h1>REGISTER TO PWNED!</h1>
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
  <script>
  const canvas = document.getElementById("matrixCanvasText");
  const ctx = canvas.getContext("2d");

  const phrases = [
    "Iniciando protocolo de registro...",
    "Estableciendo conexión con la base de datos...",
    "Cargando entorno de laboratorio...",
    "Autenticando nuevo agente...",
    "Registro de usuario Pwned! listo para comenzar."
  ];

  let lineY = 40;
  let currentPhraseIndex = 0;
  let currentCharIndex = 0;

  function resizeCanvas() {
    canvas.width = canvas.offsetWidth;
    canvas.height = canvas.offsetHeight;
    ctx.font = "7px 'Press Start 2P', monospace";
  }

  function clearLine(y) {
    ctx.clearRect(0, y - 16, canvas.width, 24); // Fondo transparente
  }

  function drawText(text, y) {
    const textWidth = ctx.measureText(text).width;
    const x = (canvas.width - textWidth) / 2;
    ctx.fillStyle = "#00FF00"; // Letras tipo terminal
    ctx.fillText(text, x, y);
  }

  function typePhrase() {
    const currentPhrase = phrases[currentPhraseIndex];
    const typedText = currentPhrase.slice(0, currentCharIndex + 1);

    clearLine(lineY);
    drawText(typedText, lineY);

    currentCharIndex++;

    if (currentCharIndex < currentPhrase.length) {
      setTimeout(typePhrase, 60 + Math.random() * 40);
    } else {
      currentCharIndex = 0;
      currentPhraseIndex++;

      if (currentPhraseIndex >= phrases.length) {
        setTimeout(() => {
          ctx.clearRect(0, 0, canvas.width, canvas.height);
          restartTyping();
        }, 1500);
      } else {
        lineY += 30;
        if (lineY > canvas.height - 20) {
          ctx.clearRect(0, 0, canvas.width, canvas.height);
          lineY = 40;
        }
        setTimeout(typePhrase, 1000);
      }
    }
  }

  function restartTyping() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    currentPhraseIndex = 0;
    currentCharIndex = 0;
    lineY = 40;
    typePhrase();
  }

  window.addEventListener("resize", () => {
    resizeCanvas();
    restartTyping();
  });

  resizeCanvas();
  restartTyping();
  
//Genera una contraseña segura aleatoria
  function generateSecurePassword(length = 12) {
    const chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{}|;:,.<>?";
    let password = "";
    for (let i = 0; i < length; i++) {
      password += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return password;
  }

  // Mostrar mensaje temporal con la contraseña
	function showToast(message, success = true) {
	  const toast = document.createElement("div");
	  toast.textContent = message;
	  toast.style.position = "fixed";
	  toast.style.bottom = "20px";
	  toast.style.left = "50%";
	  toast.style.transform = "translateX(-50%)";
	  toast.style.backgroundColor = success ? "#111" : "#400";
	  toast.style.color = success ? "#0f0" : "#f00";
	  toast.style.padding = "10px 20px";
	  toast.style.border = success ? "1px solid #0f0" : "1px solid #f00";
	  toast.style.borderRadius = "6px";
	  toast.style.fontSize = "0.65rem";
	  toast.style.fontFamily = "'Press Start 2P', monospace";
	  toast.style.zIndex = "9999";
	  toast.style.opacity = "0.95";
	  toast.style.transition = "opacity 0.5s ease";
	
	  document.body.appendChild(toast);
	
	  setTimeout(() => {
	    toast.style.opacity = "0";
	    setTimeout(() => document.body.removeChild(toast), 500);
	  }, 4000);
	}

	//Copiar texto al portapapeles
	  function copyToClipboard(text) {
	    navigator.clipboard.writeText(text).then(() => {
	      showToast(`Contraseña generada y copiada al portapapeles.`);
	    }).catch(err => {
	      console.error('Error al copiar: ', err);
	      showToast("No se pudo copiar al portapapeles.", false);
	    });
	  }

	  // Validar longitud mínima y coincidencia
	  document.querySelector("form").addEventListener("submit", function(e) {
	    const password = document.getElementById("password").value;
	    const confirmPassword = document.getElementById("confirm-password").value;

	    if (password.length < 8) {
	      e.preventDefault();
	      showToast("La contraseña debe tener al menos 8 caracteres.", false);
	      return false;
	    }
	    if (password !== confirmPassword) {
	      e.preventDefault();
	      showToast("Las contraseñas no coinciden.", false);
	      return false;
	    }
	  });

  // Generar y usar la contraseña segura
  document.getElementById("generate-password-btn").addEventListener("click", function() {
    const newPassword = generateSecurePassword();
    document.getElementById("password").value = newPassword;
    document.getElementById("confirm-password").value = newPassword;
    copyToClipboard(newPassword);
  });
  
  /* VISIBILIDAD DE CONTRASEÑA */
  
  function togglePassword(fieldId, iconSpan) {
  const input = document.getElementById(fieldId);
  const openEye = iconSpan.querySelector(".eye-icon.open");
  const closedEye = iconSpan.querySelector(".eye-icon.closed");

  const isHidden = input.type === "password";
  input.type = isHidden ? "text" : "password";

  openEye.style.display = isHidden ? "none" : "inline-block";
  closedEye.style.display = isHidden ? "inline-block" : "none";
}
  </script>
</body>
</html>
