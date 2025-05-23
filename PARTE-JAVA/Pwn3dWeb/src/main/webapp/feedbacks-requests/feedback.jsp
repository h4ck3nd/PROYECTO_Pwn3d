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
  <title>Feedback</title>
  <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');

    :root {
      --sidebar-color: #2c2c3a;
      --shadow-color: rgba(0, 0, 0, 0.6);
      --text-color: #ffffff;
      --highlight-color: #b98aff;
      --button-bg: #333;
      --danger-bg: #c0392b;
      --bg-hamburguer: #333;
      --color-hamburguer: #fff;
    }

    body.light-mode {
      background-color: #f0f0f0;
      color: #111;
    }

    body.light-mode .sidebar-wrapper {
      background-color: #ffffff;
      box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
    }

    body.light-mode .user-msg {
      background-color: #eaeaea;
      color: #111;
    }

    body.light-mode .admin-reply {
      background-color: #ddd;
      color: #222;
    }

    body.light-mode .nav-bar a.active {
      background-color: #a366ff;
      color: #fff;
    }

    body.light-mode .menu a {
      color: #000;
    }

    body.light-mode .menu button {
      color: #000;
      background-color: #ddd;
    }

    body.light-mode .theme-toggle button {
      background-color: #ccc;
      color: #000;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      background-color: #1c1c24;
      color: #ffffff;
      font-family: 'Press Start 2P', cursive;
      line-height: 1.6;
      padding: 20px;
      transition: all 0.3s ease;
    }

    body.sidebar-closed {
      padding-left: 20px;
    }

    h1 {
      font-size: 2.5rem;
      text-align: center;
      margin-bottom: 40px;
      color: #f0f0f0;
      text-shadow: 3px 3px #000000;
    }

    .nav-bar {
      display: flex;
      justify-content: center;
      gap: 30px;
      margin-bottom: 40px;
      margin-left: 250px;
      transition: all 0.3s ease;
    }

    .nav-bar a {
      text-decoration: none;
      color: #bfb3ff;
      background-color: transparent;
      padding: 10px 20px;
      border-radius: 4px;
      margin: 0 10px;
      border: 2px solid transparent;
      transition: all 0.3s ease;
    }

    .nav-bar a.active {
      background-color: #b98aff;
      color: #1c1c24;
    }

    .nav-bar a:hover {
      border: 2px solid #a366ff;
    }

    .container {
      max-width: 800px;
      margin-left: 650px;
      transition: all 0.3s ease;
    }

    body.sidebar-closed .container {
      margin-left: auto;
      margin-right: auto;
    }

    .title {
      font-size: 32px;
      text-align: center;
      color: #ffffff;
      margin-bottom: 50px;
    }

    .comment {
      margin-bottom: 60px;
    }

    .avatar {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      border: 2px solid #555;
      display: block;
      margin-bottom: 10px;
    }

    .username {
      font-size: 16px;
      margin-bottom: 15px;
    }

    .pink {
      color: #b98aff;
    }

    .user-msg, .admin-reply {
      background-color: #202020;
      padding: 15px;
      margin-bottom: 10px;
      font-size: 10px;
      white-space: pre-wrap;
    }

    .user-msg {
      border-right: 5px solid #333;
    }

    .admin-reply {
      background-color: #1a1a1a;
      color: #bfbfbf;
      border-left: 5px solid #555;
    }

    /* Sidebar */
    .sidebar-wrapper {
  width: 250px;
  background-color: var(--sidebar-color);
  min-height: 100vh;
  padding: 20px;
  box-shadow: 4px 0 10px var(--shadow-color);
  transition: left 0.3s ease, visibility 0.3s ease;
  position: fixed;
  top: 0;
  left: 0;
  z-index: 5;
  visibility: visible;
  pointer-events: auto;
}

.sidebar-wrapper.closed {
  left: -250px;
  visibility: hidden;
  pointer-events: none;
}


.content {
  flex: 1;
  padding: 40px;
  text-align: center;
  margin-left: 250px;
  transition: margin-left 0.3s ease;
}

body.sidebar-closed .content {
  margin-left: 0;
}


    #hamburger {
      position: absolute;
      top: 20px;
      left: 20px;
      color: var(--color-hamburguer);
      border: none;
      background-color: var(--bg-hamburguer);
      font-size: 20px;
      cursor: pointer;
      border-radius: 4px;
      z-index: 10;
      font-family: 'Press Start 2P', monospace;
    }

    .sidebar {
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .menu-close {
      background: none;
      border: none;
      color: var(--danger-bg);
      font-size: 18px;
      cursor: pointer;
      align-self: flex-start;
    }

    .profile img {
      width: 100px;
      height: auto;
      margin-bottom: 10px;
    }

    .profile p {
      font-size: 10px;
      color: var(--text-color);
      text-align: center;
    }

    .menu a {
      display: block;
      margin: 12px 0;
      color: var(--text-color);
      text-decoration: none;
      font-size: 10px;
      transition: color 0.3s ease;
    }

    .menu a:hover {
      color: var(--highlight-color);
    }

    .menu button {
      font-size: 10px;
      background-color: var(--button-bg);
      border: 2px solid var(--highlight-color);
      padding: 8px 12px;
      color: white;
      font-family: 'Press Start 2P', monospace;
      cursor: pointer;
      border-radius: 4px;
      margin-top: 10px;
      width: 100%;
    }

    #deleteBtn {
      background-color: var(--danger-bg);
      box-shadow: 0 0 10px rgba(192, 57, 43, 0.6);
      transition: transform 0.2s ease;
      font-weight: bold;
    }

    #deleteBtn:hover {
      transform: scale(1.05);
    }

    .theme-toggle button {
      margin-top: 250px;
      background-color: #333;
      color: #fff;
      border: 1px solid #888;
      padding: 8px;
      font-size: 10px;
      font-family: 'Press Start 2P', monospace;
      cursor: pointer;
    }
  </style>
</head>
<body>

<button id="hamburger" style="display: none;">☰</button>

  <div id="sidebarWrapper" class="sidebar-wrapper open">
    <aside class="sidebar">
      <button id="closeMenu" class="menu-close">❌</button>
      <div class="profile">
        <img src="<%= imgSrc %>" alt="Avatar" class="avatar-image" />
        <p><strong>User:</strong> <%= nombreUsuario %></p>
      </div>
      <hr>
      <nav class="menu">
        <a href="#">📊 Dashboard</a>
        <a href="machines.jsp">💻 Machines</a>
        <a href="#">🏆 Ranking</a>
        <form method="get" style="display:inline;">
          <button type="submit">🔓 CERRAR SESIÓN</button>
        </form>
      </nav>
      <div class="theme-toggle">
        <button id="toggle-theme">Modo Claro 🌞</button>
      </div>
    </aside>
  </div>

<nav class="nav-bar">
  <a href="<%= request.getContextPath() %>/feedbacks-requests/request.jsp">Request</a>
  <a href="<%= request.getContextPath() %>/feedbacks-requests/feedback.jsp" class="active">Feedback</a>
  <a href="<%= request.getContextPath() %>/feedbacks-requests/message-user.jsp">Message!</a>
</nav>

<div class="container">
  <h1 class="title">Feedback</h1>
  <div id="feedback-container"></div>
</div>

<script>
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
  
  /* MOSTRAR LOS FEEDBACKS DESDE LA DDBB */
  
  const feedbackContainer = document.getElementById("feedback-container");
  const contextPath = "<%= request.getContextPath() %>";
  
	fetch(contextPath + '/feedbacks')
	  .then(function(response) {
	    return response.json();
	  })
	  .then(function(feedbacks) {
	    let html = "";
	    feedbacks.forEach(function(fb) {
	      html += '<div class="comment">';
	      html +=   '<img class="avatar" src="' + contextPath + '/' + fb.avatarPath + '" alt="' + fb.username + ' avatar" />';
	      html +=   '<h2 class="username pink">' + fb.username + '</h2>';
	      html +=   '<div class="user-msg">' + fb.message + '</div>';
	      html +=   '<div class="admin-reply">' + fb.estado + '</div>';  // Mostrar siempre estado aquí
	      html += '</div>';
	    });
	    feedbackContainer.innerHTML = html;
	  })
	  .catch(function(err) {
	    feedbackContainer.innerHTML = '<p>Error al cargar los comentarios.</p>';
	    console.error(err);
	  });

</script>

</body>
</html>