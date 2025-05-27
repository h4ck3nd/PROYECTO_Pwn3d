<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.JWTUtil" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%
    // Seguridad: verificar si el usuario tiene un token válido
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

    boolean allowed = false;
    if (token != null && JWTUtil.validateToken(token)) {
        try {
            String role = JWTUtil.getRoleFromToken(token);
            if ("admin".equals(role)) {
                allowed = true;
            }
        } catch (Exception e) {}
    }

    if (!allowed) {
        response.sendRedirect(request.getContextPath() + "/stats");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Usuarios Registrados</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #1e1e1e;
            color: #fff;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: #2c2c2c;
        }
        th, td {
            padding: 10px;
            border: 1px solid #444;
        }
        th {
            background-color: #333;
        }
        .navbar {
  background: #111;
  padding: 1rem 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 2px solid #ff4f87;
  font-family: 'Press Start 2P', monospace;
}

.logo {
  color: #ff4f87;
  font-size: 1rem;
  text-transform: uppercase;
}

.logo small {
  font-size: 0.6rem;
  color: #ccc;
  margin-left: 0.5rem;
}

.navbar nav a {
  color: #ccc;
  text-decoration: none;
  margin-left: 1.5rem;
  font-size: 0.75rem;
  transition: color 0.3s, border-bottom 0.3s;
  position: relative;
}

.navbar nav a:hover {
  color: #ff4f87;
}

.navbar nav a::after {
  content: '';
  display: block;
  width: 0%;
  height: 2px;
  background: #ff4f87;
  transition: width 0.3s;
  position: absolute;
  bottom: -4px;
  left: 0;
}

.navbar nav a:hover::after {
  width: 100%;
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
      <a href="#">Contacto</a>
    </nav>
  </header>
<br>
    <h2>Usuarios registrados</h2>
    <table id="userTable">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Usuario</th>
            <th>Email</th>
            <th>Password (SHA-256)</th>
            <th>Rol</th>
            <th>Puntos</th>
            <th>País</th>
        </tr>
        </thead>
        <tbody id="userTableBody">
        <!-- Usuarios se insertarán aquí dinámicamente -->
        </tbody>
    </table>

    <script>
	    fetch('<%= request.getContextPath() %>/users')
	        .then(res => res.json())
	        .then(users => {
	            console.log(users);
	            const tbody = document.getElementById('userTableBody');
	            users.forEach(u => {
	                const row = document.createElement('tr');
	                row.innerHTML =
	                    "<td>" + u.id + "</td>" +
	                    "<td>" + u.nombre + "</td>" +
	                    "<td>" + u.apellido + "</td>" +
	                    "<td>" + u.usuario + "</td>" +
	                    "<td>" + u.email + "</td>" +
	                    "<td>" + u.password + "</td>" +
	                    "<td>" + u.rol + "</td>" +
	                    "<td>" + u.puntos + "</td>" +
	                    "<td>" + (u.pais || '') + "</td>";
	                tbody.appendChild(row);
	            });
	        })
	        .catch(err => {
	            console.error('Error cargando usuarios:', err);
	        });
	</script>
</body>
</html>
