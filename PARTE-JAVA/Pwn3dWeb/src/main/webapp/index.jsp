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
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssIndex.jsp">
  
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
    <script src="<%= request.getContextPath() %>/js/jsIndex.jsp"></script>
</body>
</html>