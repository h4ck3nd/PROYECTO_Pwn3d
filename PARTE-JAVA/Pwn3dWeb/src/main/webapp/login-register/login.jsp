<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
  <title>Pwned! - Login</title>
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

    /* LADO IZQUIERDO */
    .container {
	  display: flex;
	  width: 100%;
	}
	
	.left-panel {
	  flex: 0.7; /* Más espacio que la derecha */
	  display: flex;
	  text-align: center;
	  justify-content: center;
	  align-items: center;
	  padding: 4rem;
	  margin-right: 0; /* Quita esto */
	}
	
	.right-panel {
	  flex: 0.9; /* Menos espacio */
	  display: flex;
	  justify-content: center;
	  align-items: flex-start; /* Esto hace que esté arriba */
	  padding-top: 4rem;
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

    /* LADO DERECHO */
    .right-panel {
	  flex: 1; /* O incluso menos si quieres aún más enfasis en el monitor */
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  background-color: #1a1a1a;
	}

    .login-container {
      background-color: #2c2c2c;
      padding: 2rem;
      text-align: center;
      align-content: center;
      border: 3px solid #ffffff;
      border-radius: 4px;
      width: 460px;
      height: 500px;
      max-width: 90%;
      text-align: center;
    }

    h1 {
      font-size: 1rem;
      margin-bottom: 4rem;
      margin-top: -4rem;
      color: #ffffff;
    }

    form {
      display: flex;
      flex-direction: column;
    }

    label {
      font-size: 0.6rem;
      text-align: left;
      margin-bottom: 0.5rem;
      color: #e0e0e0;
    }

    input[type="text"],
    input[type="password"] {
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

    input[type="text"]::placeholder,
    input[type="password"]::placeholder {
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

    @media (max-width: 800px) {
      body, .container {
        flex-direction: column;
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
    }

.image-box {
  position: relative;
  width: 100%;
  max-width: 580px; /* Tamaño original de la imagen */
  margin: 0 auto;
}

.image-box img {
  width: 100%;
  height: auto;
  display: block;
}

.matrix-container {
  position: absolute;
  top: 20.5%;    /* Ajusta según la pantalla del monitor */
  left: 20.5%;   /* Ajusta según los bordes del marco */
  width: 59%;    /* Ajusta al ancho visible del monitor */
  height: 49%;   /* Ajusta al alto visible del monitor */
  background-color: transparent;
  overflow: hidden;
  z-index: 2;
}

#matrixCanvasText {
  width: 100%;
  height: 100%;
  display: block;
}

/* Responsivo */
@media (max-width: 768px) {
  .matrix-container {
    background-color: transparent;
  }
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
    
    .btn-register-small {
    	font-size: 0.6rem;
    	text-decoration: none;
    	color: white;
    }
	.btn-register-small:hover {
		color: gray;
	}
  </style>
</head>
<body>
  <div class="container">
    <div class="left-panel">
      <div class="left-content">
        <div class="page-title">Pwned!</div>
        <div class="image-box">
          <img src="<%= request.getContextPath() %>/img/monitor.png" alt="Login CTF">
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
	
    <div class="right-panel">
	  <div class="login-container">
	    <h1>CTF SYSTEM LOGIN</h1>
	    <form method="post" action="<%= request.getContextPath() %>/login">
	      <label for="username">USUARIO</label>
	      <input type="text" id="username" name="username" placeholder="username" required />
	
	      <label for="password">CONTRASEÑA</label>
	      <input type="password" id="password" name="password" placeholder="********" required />
	
	      <input type="submit" value="LOGIN" />
	    </form>
	    <div class="footer">PRESIONA LOGIN PARA INGRESAR</div>
	    
	    <!-- MENSAJE DE ERROR MEDIANTE EL CONTROLADOR DEL SECURITY (TOKEN ERROR) -->
	    
	    <%
		    String tokenError = (String) session.getAttribute("tokenError");
		    if (tokenError != null) {
		%>	
			<br>
		    <div style="color: red; font-weight: bold; font-size: 0.8rem;">
		        <%= tokenError %>
		    </div>
		<%
		        session.removeAttribute("tokenError"); // Elimina el mensaje después de mostrarlo
		    }
		%>
	    
	    <!-- MENSAJE DE EXITO MEDIANTE EL CONTROLADOR DE ELIMINAR CUENTA -->
	    
	    <%
		    String deleteExit = (String) session.getAttribute("deleteExit");
		    if (deleteExit != null) {
		%>	
			<br>
		    <div style="color: green; font-weight: bold; font-size: 0.8rem;">
		        <%= deleteExit %>
		    </div>
		<%
		        session.removeAttribute("deleteExit"); // Elimina el mensaje después de mostrarlo
		    }
		%>
	    
	    <%
		    String loginErrorUser = (String) session.getAttribute("loginErrorUser");
		    if (loginErrorUser != null) {
		%>  
		    <br>
		    <div style="color: red; font-weight: bold; font-size: 0.8rem;">
		        <%= loginErrorUser %>
		    </div>
		<%
		        session.removeAttribute("loginErrorUser"); // Limpia después de mostrar
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
		
	    <br><br>
	    <a href="<%= request.getContextPath() %>/login-register/register.jsp" class="btn-register-small">No tienes una cuenta? Registrate aquí</a>
	  </div>
	</div>

  </div>
  <script>
  const canvas = document.getElementById("matrixCanvasText");
  const ctx = canvas.getContext("2d");

  function resizeCanvas() {
    canvas.width = canvas.offsetWidth;
    canvas.height = canvas.offsetHeight;
    ctx.font = "7px 'Press Start 2P', monospace"; // Se reinicia fuente en resize
  }

  window.addEventListener("resize", () => {
    resizeCanvas();
    restartTyping();
  });

  resizeCanvas();

  const phrases = [
    "Verificando credenciales...",
    "Conectando al servidor seguro...",
    "Iniciando entorno de captura de flags...",
    "Autenticación en curso...",
    "Acceso concedido. Bienvenido a Pwned!"
  ];

  let lineY = 40;
  let currentPhraseIndex = 0;
  let currentCharIndex = 0;

  function clearLine(y) {
    ctx.clearRect(0, y - 16, canvas.width, 24); // Mantiene transparencia
  }

  function drawText(text, y) {
    const textWidth = ctx.measureText(text).width;
    const x = (canvas.width - textWidth) / 2;
    ctx.fillStyle = "#00FF00"; // Letras verdes
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
          ctx.clearRect(0, 0, canvas.width, canvas.height); // Limpieza final transparente
          restartTyping();
        }, 1500);
      } else {
        lineY += 30;
        if (lineY > canvas.height - 20) {
          ctx.clearRect(0, 0, canvas.width, canvas.height); // Reinicio de pantalla transparente
          lineY = 40;
        }
        setTimeout(typePhrase, 1000);
      }
    }
  }

  function restartTyping() {
    ctx.clearRect(0, 0, canvas.width, canvas.height); // Inicio en limpio
    currentPhraseIndex = 0;
    currentCharIndex = 0;
    lineY = 40;
    typePhrase();
  }

  restartTyping();
</script>
</body>
</html>