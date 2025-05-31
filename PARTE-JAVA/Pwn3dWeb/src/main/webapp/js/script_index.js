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
  
  
