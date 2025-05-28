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
  
  /* BOOTSTRAP PARA LOS POPUPS */
  
  function showToast(message, type = "primary") {
  const toastEl = document.getElementById("liveToast");
  const toastBody = document.getElementById("toastBody");

  toastEl.className = "toast align-items-center text-bg-" + type + " border-0";
  toastBody.textContent = message;

  const toast = new bootstrap.Toast(toastEl);
  toast.show();
}

  