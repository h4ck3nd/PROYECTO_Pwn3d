<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
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

    <!-- LADO DERECHO CON FORMULARIO -->
    <div class="right-panel">
      <div class="register-container">
        <h1>REGISTER TO PWNED!</h1>
        <form>
          <label for="first-name">NOMBRE</label>
          <input type="text" id="first-name" name="first-name" placeholder="nombre" required />

          <label for="last-name">APELLIDOS</label>
          <input type="text" id="last-name" name="last-name" placeholder="apellidos" required />

          <label for="email">CORREO</label>
          <input type="email" id="email" name="email" placeholder="tu@email.com" required />

          <label for="username">NOMBRE DE USUARIO</label>
          <input type="text" id="username" name="username" placeholder="username" required />

          <label for="password">CONTRASEÑA</label>
          <input type="password" id="password" name="password" placeholder="********" required />

          <label for="confirm-password">REPETIR CONTRASEÑA</label>
          <input type="password" id="confirm-password" name="confirm-password" placeholder="********" required />

          <input type="submit" value="REGÍSTRATE" />
        </form>
        <div class="footer">¡ÚNETE A LA RESISTENCIA!</div>
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
  </script>
</body>
</html>
