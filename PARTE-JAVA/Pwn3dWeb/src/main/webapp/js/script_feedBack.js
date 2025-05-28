const hamburger = document.getElementById('hamburger');
  const sidebarWrapper = document.getElementById('sidebarWrapper');
  const closeMenu = document.getElementById('closeMenu');
  const toggleTheme = document.getElementById('toggle-theme');

  function updateSidebarState() {
    const isClosed = sidebarWrapper.classList.contains('closed');
    hamburger.style.display = isClosed ? 'block' : 'none';
    document.body.classList.toggle('sidebar-closed', isClosed);
  }

  hamburger.addEventListener('click', () => {
    sidebarWrapper.classList.remove('closed');
    updateSidebarState();
  });

  closeMenu.addEventListener('click', () => {
    sidebarWrapper.classList.add('closed');
    updateSidebarState();
  });

  toggleTheme.addEventListener('click', () => {
    document.body.classList.toggle('light-mode');
    toggleTheme.textContent = document.body.classList.contains('light-mode') 
      ? 'Modo Oscuro 🌙' 
      : 'Modo Claro 🌞';
  });

  sidebarWrapper.classList.remove('closed');
  updateSidebarState();