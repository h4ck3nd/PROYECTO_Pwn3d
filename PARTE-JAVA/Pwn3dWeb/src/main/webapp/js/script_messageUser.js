const hamburger = document.getElementById('hamburger');
    const sidebarWrapper = document.getElementById('sidebarWrapper');
    const closeMenu = document.getElementById('closeMenu');
    const toggleThemeBtn = document.getElementById('toggle-theme');

    function updateHamburgerVisibility() {
      hamburger.style.display = sidebarWrapper.classList.contains('closed') ? 'block' : 'none';
    }

    hamburger.addEventListener('click', () => {
      sidebarWrapper.classList.remove('closed');
      updateHamburgerVisibility();
    });

    closeMenu.addEventListener('click', () => {
      sidebarWrapper.classList.add('closed');
      updateHamburgerVisibility();
    });

    // Modo claro/oscuro con almacenamiento en localStorage
    function toggleTheme() {
      document.body.classList.toggle('light-theme');
      const isLight = document.body.classList.contains('light-theme');
      localStorage.setItem('theme', isLight ? 'light' : 'dark');
      toggleThemeBtn.textContent = isLight ? 'Modo Oscuro 🌙' : 'Modo Claro 🌞';
    }

    toggleThemeBtn.addEventListener('click', toggleTheme);

    // Aplicar tema guardado al cargar
    window.onload = function () {
      if (localStorage.getItem('theme') === 'light') {
        document.body.classList.add('light-theme');
        toggleThemeBtn.textContent = 'Modo Oscuro 🌙';
      }
      updateHamburgerVisibility();
    };

    function updateHamburgerVisibility() {
  const isClosed = sidebarWrapper.classList.contains('closed');
  hamburger.style.display = isClosed ? 'block' : 'none';

  if (isClosed) {
    document.body.classList.add('sidebar-closed');
  } else {
    document.body.classList.remove('sidebar-closed');
  }
}
    