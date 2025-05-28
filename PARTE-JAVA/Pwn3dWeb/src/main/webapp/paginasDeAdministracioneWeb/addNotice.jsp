<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.NewVM" %>
<%@ page import="utils.JWTUtil" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%
    // Obtener la cookie 'token' del request
    String token = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("token".equals(cookie.getName())) {
                token = cookie.getValue();
                break;
            }
        }
    }

    // Verificar rol
    String role = null;
    boolean allowed = false;

    if (token != null && JWTUtil.validateToken(token)) {
        try {
            role = JWTUtil.getRoleFromToken(token);
            if ("admin".equals(role)) {
                allowed = true;
            }
        } catch (Exception e) {
            // Manejar error si se desea
        }
    }

    // Si no está autorizado, redirigir
    if (!allowed) {
        response.sendRedirect(request.getContextPath() + "/stats");
        return; // Termina la ejecución del JSP
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Añadir Noticia</title>
  <style>
    /* Reset */
* {
  box-sizing: border-box;
}

body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  margin: 0;
  padding: 2rem 1rem;
  background: #0d1117;
  color: #c9d1d9;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
}

h2 {
  color: #58a6ff;
  font-weight: 700;
  margin-bottom: 1.5rem;
  text-align: center;
  text-shadow: 0 1px 3px rgba(0,0,0,0.2);
}

form {
  background: #161b22;
  padding: 2rem 2.5rem;
  border-radius: 10px;
  max-width: 600px;
  width: 100%;
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.5);
  margin-top: 2rem;
}

label {
  display: block;
  margin-top: 1.25rem;
  font-weight: 600;
  color: #c9d1d9;
}

.required {
  color: #ff7b72;
  font-weight: bold;
}

input[type="text"], textarea {
  width: 100%;
  padding: 0.65rem 1rem;
  margin-top: 0.4rem;
  background-color: #0d1117;
  border: 1px solid #30363d;
  color: #f0f6fc;
  border-radius: 6px;
  font-size: 1rem;
  font-family: inherit;
  resize: vertical;
  transition: border 0.3s;
}

input[type="text"]:focus, textarea:focus {
  outline: none;
  border: 1px solid #58a6ff;
  box-shadow: 0 0 6px #58a6ff55;
}

textarea {
  min-height: 120px;
}

input[type="submit"] {
  margin-top: 2rem;
  background-color: #238636;
  border: none;
  color: white;
  padding: 0.85rem 2rem;
  font-size: 1.1rem;
  font-weight: 700;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s ease, box-shadow 0.3s ease;
  width: 100%;
}

input[type="submit"]:hover {
  background-color: #2ea043;
  box-shadow: 0 4px 12px rgba(46, 160, 67, 0.4);
}

.message {
  max-width: 600px;
  margin: 0 auto 1.5rem auto;
  padding: 0.9rem 1.2rem;
  border-radius: 6px;
  font-weight: 600;
  font-size: 1rem;
  text-align: center;
}

.message.success {
  background-color: #1f6feb22;
  color: #58a6ff;
  border: 1px solid #1f6feb88;
}

.message.error {
  background-color: #da363342;
  color: #f85149;
  border: 1px solid #da3633;
}

/* Navbar */
.navbar {
  background-color: #161b22;
  color: #c9d1d9;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1rem 2rem;
  box-shadow: 0 4px 10px rgba(0,0,0,0.6);
  border-bottom: 1px solid #30363d;
  position: sticky;
  top: 0;
  z-index: 999;
  width: 100%;
}

.navbar .logo {
  font-size: 1.4rem;
  font-weight: 700;
  color: #58a6ff;
  text-shadow: 0 0 4px rgba(88, 166, 255, 0.3);
}

.navbar nav {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
}

.navbar nav a {
  text-decoration: none;
  color: #c9d1d9;
  padding: 0.4rem 0.8rem;
  border-radius: 4px;
  transition: background-color 0.25s ease, color 0.25s ease;
  font-weight: 500;
  font-size: 0.95rem;
}

.navbar nav a:hover {
  background-color: #21262d;
  color: #58a6ff;
}

/* Responsive */
@media (max-width: 768px) {
  .navbar {
    flex-direction: column;
    align-items: flex-start;
    padding: 1rem;
  }

  .navbar nav {
    flex-direction: column;
    width: 100%;
    gap: 0.5rem;
    margin-top: 0.5rem;
  }

  .navbar nav a {
    width: 100%;
  }

  form {
    padding: 1.5rem 1.8rem;
  }
}
  </style>
</head>
<body>

<!-- Navbar -->
<header class="navbar">
    <div class="logo">🧠 VM Manager [CTF Mode]</div>
    <nav>
      <a href="#">Inicio</a>
      <a href="<%= request.getContextPath() %>/machines.jsp">Máquinas</a>
      <a href="<%= request.getContextPath() %>/paginasDeAdministracioneWeb/deletedVM.jsp">Eliminar VM</a>
      <a href="<%= request.getContextPath() %>/paginasDeAdministracioneWeb/agregarVM.jsp">Agregar VM</a>
      <a href="<%= request.getContextPath() %>/paginasDeAdministracioneWeb/addWriteupsAdmin.jsp">Agegar Writeups</a>
      <a href="<%= request.getContextPath() %>/paginasDeAdministracioneWeb/updateEstadoFeedback.jsp">Actualizar FeedBacks</a>
      <a href="<%= request.getContextPath() %>/paginasDeAdministracioneWeb/users.jsp">Usuarios</a>
      <a href="<%= request.getContextPath() %>/paginasDeAdministracioneWeb/adminDB.jsp">Administrar DDBB</a>
      <a href="<%= request.getContextPath() %>/paginasDeAdministracioneWeb/addNotice.jsp">Añadir Noticia</a>
      <a href="<%= request.getContextPath() %>/paginasDeAdministracioneWeb/addInfoNotice.jsp">Añadir Info Noticias</a>
      <a href="#">Contacto</a>
    </nav>
  </header>
  
<form action="<%= request.getContextPath() %>/addNotice" method="post" novalidate>
	
	<h2>AÑADIR NOTICIA A LA DDBB (PAGINA)</h2>
	
	<%
	    String message = (String) session.getAttribute("message");
	    if (message != null) {
	%>
	    <div class="message success"><%= message %></div>
	<%
	        session.removeAttribute("message");
	    }
	
	    String error = (String) session.getAttribute("error");
	    if (error != null) {
	%>
	    <div class="message error"><%= error %></div>
	<%
	        session.removeAttribute("error");
	    }
	%>

  <label for="vm_name">VM Name <span style="color:#ff7b72">*</span>:</label>
  <input type="text" id="vm_name" name="vm_name" required maxlength="100" placeholder="Nombre de la máquina virtual" />

  <label for="date">Date <span style="color:#ff7b72">*</span>:</label>
  <input type="text" id="date" name="date" required maxlength="50" placeholder="Fecha (ej. 30th May 9:00)" />

  <label for="creator">Creator <span style="color:#ff7b72">*</span>:</label>
  <input type="text" id="creator" name="creator" required maxlength="100" placeholder="Creador" />

  <label for="second_vm_name">Second VM Name:</label>
  <input type="text" id="second_vm_name" name="second_vm_name" maxlength="100" placeholder="Segunda máquina virtual (opcional)" />

  <label for="second_date">Second Date:</label>
  <input type="text" id="second_date" name="second_date" maxlength="50" placeholder="Fecha segunda máquina (opcional)" />

  <label for="second_creator">Second Creator:</label>
  <input type="text" id="second_creator" name="second_creator" maxlength="100" placeholder="Creador segunda máquina (opcional)" />

  <label for="description_page">Description:</label>
  <textarea id="description_page" name="description_page" maxlength="500" placeholder="Descripción o writeup (opcional)"></textarea>

  <input type="submit" value="Añadir Noticia" />
</form>

</body>
</html>
