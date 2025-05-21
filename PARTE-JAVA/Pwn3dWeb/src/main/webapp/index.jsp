<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="dao.ImgProfileDAO" %>
<%@ page import="model.ImgProfile" %>
<%@ page import="dao.EditProfileDAO" %>
<%@ page import="utils.JWTUtil" %>
<%@ page import="java.util.Map" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%
    String token = null; // Declarada fuera para ser accesible globalmente
    Integer userId = null;
    String nombreUsuario = "Invitado";

    try {
        javax.servlet.http.Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (javax.servlet.http.Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token == null || !JWTUtil.validateToken(token)) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        userId = JWTUtil.getUserIdFromToken(token);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        // Extraer el nombre desde los claims del token
        Map<String, Object> claims = JWTUtil.getAllClaims(token);
        if (claims != null && claims.get("usuario") != null) {
            nombreUsuario = (String) claims.get("usuario");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/logout");
        return;
    }

    ImgProfileDAO imgDao = new ImgProfileDAO();
    ImgProfile img = imgDao.getImgProfileByUserId(userId);
    imgDao.cerrarConexion();

    String imgSrc = (img != null && img.getPathImg() != null && !img.getPathImg().isEmpty())
        ? request.getContextPath() + "/" + img.getPathImg()
        : request.getContextPath() + "/imgProfile/default.png";
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
  <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
  <title>HackMyVM Replica - Vulnyx Style</title>
  <style>
:root {
  /* Oscuro por defecto */
  --color-background: #2c2b30;
  --color-sidebar-bg: #333333;
  --color-text-aside: #fff;
  --color-text: #fff;
  --color-text-muted: #6a0dad;
  --color-accent: #ff4f87;
  --color-accent-alt: #8340c4;
  --color-dot: #c9aee0;
  --color-hover-bg: #2a2a2a;
  --color-card-bg: #1a1a1a;
  --color-download-bg: #c9aee0;
  --color-shadow: rgba(0, 0, 0, 0.3);
  --color-border: #333;
  --color-gray-dark: #444;
  --color-timestamp: #888;
  --color-root: #9b6ad1;
  --color-user: #00ffff;
}

.light-theme {
  --color-background: #f4f4f4;
  --color-sidebar-bg: #ffffff;
  --color-text: #111;
  --color-dot: #a46cc5;
  --color-text-aside: #000;
  --color-text-muted: #555;
  --color-accent: #d13a6f;
  --color-accent-alt: #c13c5d;
  --color-hover-bg: #f0f0f0;
  --color-card-bg: #ffffff;
  --color-shadow: rgba(0, 0, 0, 0.1);
  --color-border: #ddd;
  --color-gray-dark: #ccc;
  --color-timestamp: #777;
  --color-root: #5a2a7c;
  --color-user: #000fff;
}
    /* Reset básico */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      background-color: var(--color-background);
      color: var(--color-text);
      font-family: 'Press Start 2P', monospace !important;
      line-height: 1.75rem;
    }

    .app {
      display: flex;
      min-height: 100vh;
    }

    /* Contenido del menú */
    .sidebar {
      position: relative;
      height: 100%;
      padding: 20px;
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }

    .sidebar a {
      color: var(--color-text-aside) !important;
      text-decoration: none;
      padding: 10px 0;
      display: flex;
      align-items: center;
      gap: 10px;
      transition: color 0.2s ease;
    }

    .sidebar a:hover {
      color: var(--color-accent);
    }

    /* Botón de cerrar dentro del menú */
    .menu-close {
      position: absolute;
      top: 10px;
      left: 10px;
      font-size: 1.0rem;
      background: none;
      color: var(--color-text);
      border: none;
      cursor: pointer;
      z-index: 2001;
      display: none;
    }

    /* Mostrar botón de cerrar solo cuando el menú está abierto */
    .sidebar-wrapper.open .menu-close {
      display: block;
    }

    /* Botón de hamburguesa (☰) */
    .menu-toggle {
      position: fixed;
      top: 20px;
      left: 20px;
      font-size: 2rem;
      background: none;
      color: var(--color-text);
      border: none;
      cursor: pointer;
      z-index: 2000;
      display: none;
    }

    /* Mostrar hamburguesa solo cuando el menú está cerrado */
    .sidebar-wrapper.closed + .menu-toggle {
      display: block;
    }

    /* Menú lateral */
    .sidebar-wrapper {
      position: fixed;
      top: 0;
      left: 0;
      width: 240px;
      height: 100vh;
      background-color: var(--color-sidebar-bg);
      overflow-y: auto;
      z-index: 1000;
      transition: transform 0.3s ease;
    }

    /* Menú abierto */
    .sidebar-wrapper.open {
      transform: translateX(0);
    }

    /* Menú cerrado */
    .sidebar-wrapper.closed {
      transform: translateX(-100%);
    }

    .sidebar-wrapper.closed ~ .main-content {
      margin-left: 0;
    }

    .main-content {
      flex: 1;
      padding: 40px;
      margin-left: 240px;
    }

    /* En pantallas pequeñas, el contenido debe ajustarse */
    @media (max-width: 768px) {
      .main-content {
        margin-left: 0;
        padding: 60px 20px 20px;
      }
    }

    .profile {
      text-align: center;
    }

    .profile img {
      width: 80px;
      height: 80px;
      border-radius: 50%;
      margin-bottom: 10px;
    }

    .avatar {
      border-radius: 50%;
      width: 80px;
      height: 80px;
    }

    .username {
      margin-top: 10px;
      font-weight: bold;
      font-size: 0.95rem;
    }

    .menu {
      display: flex;
      flex-direction: column;
      gap: 12px;
      margin-top: 80px;
    }

    .menu a {
      color: var(--color-text-muted);
      text-decoration: none;
      font-size: 0.9rem;
      transition: color 0.2s ease;
    }

    .menu a:hover {
      color: var(--color-text);
    }

    .hero {
      display: flex;
      align-items: center;
      justify-content: space-between;
      flex-wrap: wrap;
      margin-bottom: 40px;
    }

    .title {
      font-size: 2.5rem;
      font-weight: 700;
    }

    .dot {
      color: var(--color-dot);
    }

    .vm-info h2, .vm-info h3 {
      margin: 5px 0;
      font-weight: 500;
    }

    .vm-info h3 {
      margin-top: 10px;
    }

    .btn {
      margin-top: 10px;
      padding: 6px 14px;
      border: none;
      border-radius: 8px;
      font-weight: bold;
      cursor: pointer;
    }

    .download {
      background-color: var(--color-download-bg);
      color: var(--color-text);
    }

    .schedule {
      background-color: var(--color-gray-dark);
      color: var(--color-text);
    }

    .stats {
      display: flex;
      gap: 30px;
      margin-bottom: 40px;
    }

    .stat h3 {
      color: var(--color-text-muted);
      margin: 0;
    }

    .stat p {
      font-size: 1.5rem;
      font-weight: bold;
      margin: 5px 0 0;
    }

    .log-cards {
      display: flex;
      flex-direction: column;
      gap: 16px;
    }

    .log-card {
      display: flex;
      align-items: flex-start;
      background-color: var(--color-card-bg);
      padding: 14px 18px;
      border-radius: 10px;
      box-shadow: 0 2px 5px var(--color-shadow);
      transition: background 0.2s ease;
    }

    .log-card:hover {
        background-color: var(--color-hover-bg);
    }

    .log-avatar {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      margin-right: 16px;
      border: 2px solid var(--color-border);
    }

    .theme-toggle {
  margin-top: auto;
  padding-top: 20px;
  border-top: 1px solid var(--color-border);
}

#toggle-theme {
  background-color: var(--color-gray-dark);
  color: var(--color-text);
  border: none;
  padding: 10px 16px;
  border-radius: 8px;
  cursor: pointer;
  width: 100%;
  font-size: 0.9rem;
  transition: background 0.3s ease;
}

#toggle-theme:hover {
  background-color: var(--color-accent);
}

    .log-content {
      display: flex;
      flex-direction: column;
    }

    .timestamp {
      font-size: 0.8rem;
      color: var(--color-timestamp);
      margin-bottom: 4px;
    }

    .hacker-name {
        color: var(--color-text);
      font-weight: 600;
    }

    .root {
      color: var(--color-root);
      font-weight: bold;
    }

    .user {
      color: var(--color-user);
      font-weight: bold;
    }
  </style>
  
</head>
<body>

<!-- MENU DE HABURGUESA -->

    <button id="hamburger" class="menu-toggle" style="display: none;">☰</button>
  <div class="app">
    <div id="sidebarWrapper" class="sidebar-wrapper open">
        <aside class="sidebar">
          <!-- Botón de cerrar -->
          <button id="closeMenu" class="menu-close">❌</button>
          <div class="profile">
            <img src="<%= imgSrc %>" alt="Avatar" class="avatar-image" />
            <p><strong>Username:</strong> <%= nombreUsuario %></p>
          </div>
          <hr>
      <nav class="menu">
      <!-- Seccion Usuarios -->
      	<a href="<%= request.getContextPath() %>/perfil">Mi Cuenta</a>
        <a href="#">📊 Dashboard</a>
        <a href="<%= request.getContextPath() %>/machines.jsp">💻 Machines</a>
        <a href="#">🏆 Ranking</a>
        <!--<hr/>  -->
        <!-- Seccion de Autenticacion -->
        <!--<a href="#">⚙️ Settings</a>-->
        
        <!-- BOTON/FORMULARIO PARA CERRAR SESION DEL USUSARIO ACTUAL POR ID -->
        
        <form action="<%= request.getContextPath() %>/logout" method="get" style="display:inline;">
		    <button type="submit" style="
		        font-size: 0.6rem;
		        background-color: #ff3333;
		        border: 2px solid #aa0000;
		        padding: 6px 12px;
		        color: white;
		        font-family: 'Press Start 2P', monospace;
		        cursor: pointer;
		        border-radius: 4px;
		        margin-left: 10px;">
		        🔓 CERRAR SESIÓN
		    </button>
		</form>
      </nav>
      <div class="theme-toggle">
        <button id="toggle-theme">Modo Claro 🌞</button>
      </div>
    </aside>
</div>
    <main class="main-content">
      <header class="hero">
        <h1 class="title">Pwn3d!<span class="dot">.</span></h1>
        <div class="vm-info">
          <h2>Last VM: <span>Pycrt.</span></h2>
          <button class="btn download">Download</button>
          <h3>Next Release: <span>14th May 09:00 CET</span></h3>
          <p>🏠 Homelab by <strong>2020G675</strong></p>
          <button class="btn schedule">Schedule</button>
        </div>
      </header>

      <section class="stats">
        <div class="stat"><h3>VMs</h3><p>298</p></div>
        <div class="stat"><h3>Hackers</h3><p>18403</p></div>
        <div class="stat"><h3>Challenges</h3><p>89</p></div>
        <div class="stat"><h3>Writeups</h3><p>2360</p></div>
      </section>

      <section class="logs">
        <h2>Logs<span class="dot">.</span></h2>
        <div class="log-cards">
          <div class="log-card">
            <img src="https://i.pravatar.cc/40?u=eureka" alt="Eureka" class="log-avatar">
            <div class="log-content">
              <p><span class="timestamp">2025-05-10 13:03</span></p>
              <p><strong class="hacker-name">Eureka</strong> got <span class="root">root</span> in <em>Noob</em></p>
            </div>
          </div>
      
          <div class="log-card">
            <img src="https://i.pravatar.cc/40?u=2020g675" alt="2020G675" class="log-avatar">
            <div class="log-content">
              <p><span class="timestamp">2025-05-10 12:43</span></p>
              <p><strong class="hacker-name">2020G675</strong> got <span class="root">root</span> in <em>Pycrt</em></p>
            </div>
          </div>
      
          <div class="log-card">
            <img src="https://i.pravatar.cc/40?u=yliken" alt="Yliken" class="log-avatar">
            <div class="log-content">
              <p><span class="timestamp">2025-05-10 11:22</span></p>
              <p><strong class="hacker-name">Yliken</strong> got <span class="user">user</span> in <em>Airbind</em></p>
            </div>
          </div>
        </div>
      </section>
    </main>
    <script>
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
    </script>
</body>
</html>