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
    ctx.fillStyle = "#a300c3"; // Letras tipo terminal
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
	  toast.style.backgroundColor = success ? "#2b2440" : "#4a1f33";  // fondo oscuro morado / rojo oscuro
	  toast.style.color = success ? "#b695f6" : "#e46f7c";             // texto morado claro / rojo pastel
	  toast.style.padding = "10px 24px";
	  toast.style.border = success ? "2px solid #7e57c2" : "2px solid #d94e5b"; // borde morado / rojo
	  toast.style.borderRadius = "6px";
	  toast.style.fontSize = "0.65rem";
	  toast.style.fontFamily = "'Press Start 2P', monospace";
	  toast.style.zIndex = "9999";
	  toast.style.opacity = "0.95";
	  toast.style.boxShadow = success 
	    ? "0 0 10px 2px #b695f6aa" 
	    : "0 0 10px 2px #e46f7caa"; // sombra suave
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