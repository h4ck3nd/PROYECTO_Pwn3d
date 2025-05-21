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
    ctx.fillStyle = "#a300c3"; // Letras moradas
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