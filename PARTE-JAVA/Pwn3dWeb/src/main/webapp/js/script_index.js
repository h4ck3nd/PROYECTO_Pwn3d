const hamburger = document.getElementById("hamburger");
const closeBtn = document.getElementById("closeMenu");
const sidebarWrapper = document.getElementById("sidebarWrapper");

function openMenu() {
  sidebarWrapper.classList.remove("closed");
  sidebarWrapper.classList.add("open");
  hamburger.style.display = "none";     // Oculta el botón ☰
  closeBtn.style.display = "block";     // Muestra el botón ❌
}

function closeMenu() {
  sidebarWrapper.classList.remove("open");
  sidebarWrapper.classList.add("closed");
  hamburger.style.display = "block";    // Muestra el botón ☰
  closeBtn.style.display = "none";      // Oculta el botón ❌
}

// Eventos
hamburger.addEventListener("click", openMenu);
closeBtn.addEventListener("click", closeMenu);

// inicializacion
document.addEventListener("DOMContentLoaded", () => {
  openMenu(); // Mostramos el menú por defecto
});

// Modo claro modo Oscuro
const toggleBtn = document.getElementById('toggle-theme');
  const body = document.body;

  // Cargar tema almacenado
  if (localStorage.getItem('theme') === 'light') {
    body.classList.add('light-theme');
    toggleBtn.textContent = 'Modo Oscuro 🌙';
  }

  toggleBtn.addEventListener('click', () => {
    body.classList.toggle('light-theme');

    const isLight = body.classList.contains('light-theme');
    toggleBtn.textContent = isLight ? 'Modo Oscuro 🌙' : 'Modo Claro 🌞';
    localStorage.setItem('theme', isLight ? 'light' : 'dark');
  });
  
  /* SHOW LOGS INDEX (DASHBOARD) */
  
  // Función para escapar texto y evitar inyección HTML
    function escapeHtml(text) {
      if (!text) return '';
      return text.replace(/&/g, "&amp;")
                 .replace(/</g, "&lt;")
                 .replace(/>/g, "&gt;")
                 .replace(/"/g, "&quot;")
                 .replace(/'/g, "&#039;");
    }

    // Construye el HTML concatenado con +
	function buildLogsHTML(logs) {
	  var html = 
	    '<section class="logs" style="max-height: 400px; overflow-y: auto;">';

	  for (var i = 0; i < logs.length; i++) {
	    var log = logs[i];
	    html +=
	      '<div class="log-card">' +
	        '<img src="' + log.imgSrc + '" alt="' + escapeHtml(log.user) + '" class="log-avatar" />' +
	        '<div class="log-content">' +
	          '<p><span class="timestamp">' + escapeHtml(log.createdAt || '') + '</span></p>' +
	          '<p><strong class="hacker-name">' + escapeHtml(log.user) + '</strong> got ' +
	            '<span class="' + escapeHtml(log.tipoFlag) + '">' + escapeHtml(log.tipoFlag) + '</span> in <em>' + escapeHtml(log.vmName) + '</em></p>' +
	        '</div>' +
	      '</div>';
	  }

	  html += '</div></section>';
	  return html;
	}
