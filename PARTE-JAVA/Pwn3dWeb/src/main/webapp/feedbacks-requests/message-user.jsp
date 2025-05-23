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
  <meta charset="UTF-8">
  <title>Feedback - Morado</title>
  <!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
  @font-face {
	  font-family: 'Press Start 2P';
	  src: url('../fonts/PressStart2P-Regular.ttf') format('truetype');
	  font-weight: normal;
	  font-style: normal;
	}
	
    :root {
      --bg-color: #1e1c26;
      --sidebar-color: #2a2734;
      --text-color: #bfb3ff;
      --highlight-color: #a366ff;
      --button-bg: #aa00aa;
      --button-hover: #c299ff;
      --danger-bg: #c0392b;
      --shadow-color: rgba(0,0,0,0.5);
      --bg-hamburguer: transparent;
      --color-hamburguer: #fff;
    }

    .light-theme {
      --bg-color: #f0f0f0;
      --sidebar-color: #ffffff;
      --text-color: #222;
      --highlight-color: #7c4dff;
      --button-bg: #7c4dff;
      --button-hover: #b299ff;
      --danger-bg: #e74c3c;
      --shadow-color: rgba(0,0,0,0.1);
      --bg-hamburguer: transparent;
      --color-hamburguer: #000;
    }

body {
  background-color: var(--bg-color);
  color: var(--text-color);
  font-family: 'Press Start 2P', monospace;
  margin: 0;
  padding: 0;
  display: flex;
}

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

    nav {
      margin-bottom: 40px;
    }

    nav a {
      text-decoration: none;
      color: var(--text-color);
      background-color: transparent;
      padding: 10px 20px;
      border-radius: 4px;
      margin: 0 10px;
      border: 2px solid transparent;
      transition: all 0.3s ease;
    }

    nav a.active {
      background-color: var(--highlight-color);
      color: #fff;
    }

    nav a:hover {
      border: 2px solid var(--highlight-color);
    }

    .title {
      font-size: 28px;
      margin-bottom: 30px;
    }

    .box {
      max-width: 700px;
      margin: 0 auto;
      background-color: var(--sidebar-color);
      border: 1px solid var(--highlight-color);
      padding: 25px;
      text-align: left;
      color: var(--text-color);
      font-size: 12px;
      line-height: 1.8em;
    }

textarea, select, button.send-btn {
  display: block;
  margin: 30px auto;
  width: 100%;
  max-width: 500px;
  min-width: 300px;
  background-color: var(--bg-color);
  border: 1px solid var(--highlight-color);
  color: var(--text-color);
  padding: 10px;
  font-family: 'Press Start 2P', monospace;
  font-size: 10px;
  resize: none;
}


    button.send-btn {
      background-color: var(--highlight-color);
      border: none;
      color: white;
      cursor: pointer;
      width: 100px;
      transition: background 0.3s;
    }

    button.send-btn:hover {
      background-color: var(--button-hover);
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

  <div class="content">
    <nav>
      <a href="<%= request.getContextPath() %>/feedbacks-requests/request.jsp">Request</a>
	  <a href="<%= request.getContextPath() %>/feedbacks-requests/feedback.jsp">Feedback</a>
	  <a href="<%= request.getContextPath() %>/feedbacks-requests/message-user.jsp" class="active">Message!</a>
    </nav>

    <div class="title">Message</div>

    <div class="box">
      ¡Pídenos lo que quieras!<br>
      Ej1: Quiero más máquinas virtuales de Wordpress.<br>
      Ej2: Quiero más retos de programación.<br><br>

      ¿Quieres darnos tu opinión? ¡La apreciamos mucho!<br>
      Ej1: Me encanta la comunidad.<br>
      Ej2: ¡Usa IRC en lugar de Discord!
	</div>
    
    <br>
	<div id="alert-container" style="max-width: 500px; margin: 0 auto;"></div>
	
    <textarea rows="8" placeholder="Type your message..."></textarea>

    <select>
      <option>Request</option>
      <option>Feedback</option>
    </select>

    <button class="send-btn">ENVIAR</button>
  </div>

  <script>
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
    
    /* SEND MESSAGE LOGICA */

    const contextPath = "<%= request.getContextPath() %>";

	document.querySelector(".send-btn").addEventListener("click", function () {
	  const mensaje = document.querySelector("textarea").value.trim();
	  const tipo = document.querySelector("select").value;
	  const alertContainer = document.getElementById("alert-container");
	
	  if (!mensaje) {
	    showAlert("Mensaje vacío", "danger");
	    return;
	  }
	
	  const url = tipo === "Request" ? "/request" : "/feedback";
	
	  fetch(contextPath + url, {
	    method: "POST",
	    headers: {
	      'Content-Type': 'application/x-www-form-urlencoded'
	    },
	    body: "mensaje=" + encodeURIComponent(mensaje) + "&tipo=" + encodeURIComponent(tipo)
	  })
	    .then(function (res) {
	      return res.json();
	    })
	    .then(function (data) {
	      if (data.success) {
	        showAlert(data.message, "success");
	        document.querySelector("textarea").value = "";
	      } else {
	        showAlert(data.message || "Error al enviar", "danger");
	      }
	    })
	    .catch(function () {
	      showAlert("Error del servidor", "danger");
	    });
	
	  function showAlert(message, type) {
	    alertContainer.innerHTML =
	      '<div class="alert alert-' + type + ' alert-dismissible fade show" role="alert">' +
	        message +
	        '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
	      '</div>';
	  }
	});
  </script>

</body>
</html>