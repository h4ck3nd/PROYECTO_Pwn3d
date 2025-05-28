<%@ page import="conexionDDBB.ConexionDDBB" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String message = null;

    String cambiarEstadoId = request.getParameter("id_estado");
    String accionEstado = request.getParameter("accion_estado");

    if (cambiarEstadoId != null && accionEstado != null) {
        ConexionDDBB db = new ConexionDDBB();
        Connection conn = db.conectar();
        try {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE info_notices_machines SET estado = ? WHERE id = ?");
            ps.setString(1, accionEstado); // 'publico' o 'privado'
            ps.setInt(2, Integer.parseInt(cambiarEstadoId));
            int updated = ps.executeUpdate();
            if (updated > 0) {
                message = "Estado del ID " + cambiarEstadoId + " actualizado a " + accionEstado + ".";
            } else {
                message = "No se encontró un registro con ese ID.";
            }
        } catch (SQLException e) {
            message = "Error al actualizar estado: " + e.getMessage();
        } finally {
            db.cerrarConexion();
        }
    } else if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("vm_name") != null) {
        // Lógica de inserción de nueva noticia
        String description = request.getParameter("description");
        String vmName = request.getParameter("vm_name");
        String date = request.getParameter("date");
        String os = request.getParameter("os");
        String difficulty = request.getParameter("difficulty");
        String environment = request.getParameter("environment");
        String secondEnvironment = request.getParameter("second_environment");
        String pathInfoNotice = request.getParameter("pathInfoNotice");

        if (description != null && vmName != null && date != null) {
            ConexionDDBB db = new ConexionDDBB();
            Connection conn = db.conectar();

            try {
                conn.setAutoCommit(false);

                // Paso 1: Poner todo en privado
                PreparedStatement ps1 = conn.prepareStatement("UPDATE info_notices_machines SET estado = 'privado'");
                ps1.executeUpdate();

                // Paso 2: Insertar la nueva noticia
                PreparedStatement ps2 = conn.prepareStatement(
                    "INSERT INTO info_notices_machines " +
                    "(description, vm_name, date, time_created, estado, os, difficulty, environment, second_environment, path_info_notice) " +
                    "VALUES (?, ?, ?, CURRENT_TIMESTAMP, 'publico', ?, ?, ?, ?, ?)"
                );
                ps2.setString(1, description);
                ps2.setString(2, vmName);
                ps2.setString(3, date);
                ps2.setString(4, os);
                ps2.setString(5, difficulty);
                ps2.setString(6, environment);
                ps2.setString(7, secondEnvironment);
                ps2.setString(8, pathInfoNotice != null && !pathInfoNotice.isEmpty()
                              ? "img/notices/" + pathInfoNotice : null);

                ps2.executeUpdate();
                conn.commit();
                message = "Noticia añadida correctamente.";
            } catch (SQLException e) {
                conn.rollback();
                message = "Error al insertar: " + e.getMessage();
            } finally {
                db.cerrarConexion();
            }
        } else {
            message = "Por favor, completa todos los campos obligatorios.";
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Añadir Noticia</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #0d1117;
      color: #c9d1d9;
      padding: 2rem;
    }
    form {
      background: #161b22;
      padding: 2rem;
      border-radius: 10px;
      max-width: 600px;
      margin: 0 auto;
    }
    label {
      display: block;
      margin-top: 1rem;
    }
    input, textarea, select {
      width: 100%;
      padding: 0.5rem;
      margin-top: 0.3rem;
      background: #0d1117;
      border: 1px solid #30363d;
      color: #c9d1d9;
      border-radius: 5px;
    }
    input[type="submit"] {
      margin-top: 2rem;
      background: #238636;
      color: white;
      font-weight: bold;
      border: none;
      cursor: pointer;
    }
    .message {
      max-width: 600px;
      margin: 1rem auto;
      padding: 1rem;
      text-align: center;
      border-radius: 5px;
    }
    .success { background-color: #1f6feb22; color: #58a6ff; }
    .error { background-color: #da363342; color: #f85149; }
    
    /* Estilos generales navbar */
	.navbar {
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	  background-color: #0d1117;
	  padding: 1rem 2rem;
	  box-shadow: 0 2px 8px rgba(0,0,0,0.7);
	  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	  position: sticky;
	  top: 0;
	  z-index: 100;
	  font-size: 0.85rem;
	}
	
	.navbar .logo {
	  font-weight: 700;
	  font-size: 1.5rem;
	  color: #58a6ff;
	  user-select: none;
	}
	
	.navbar nav {
	  display: flex;
	  gap: 1.2rem;
	}
	
	.navbar nav a {
	  color: #c9d1d9;
	  text-decoration: none;
	  font-weight: 500;
	  padding: 0.3rem 0.6rem;
	  border-radius: 6px;
	  transition: background-color 0.25s ease, color 0.25s ease;
	}
	
	.navbar nav a:hover,
	.navbar nav a:focus {
	  background-color: #238636;
	  color: #ffffff;
	  outline: none;
	  cursor: pointer;
	}
	
	/* Responsive básico: en pantallas muy pequeñas, las opciones se apilan */
	@media (max-width: 600px) {
	  .navbar {
	    flex-direction: column;
	    align-items: flex-start;
	  }
	  .navbar nav {
	    flex-direction: column;
	    width: 100%;
	    margin-top: 0.8rem;
	  }
	  .navbar nav a {
	    padding: 0.8rem 1rem;
	    border-radius: 0;
	    border-bottom: 1px solid #30363d;
	  }
	  .navbar nav a:last-child {
	    border-bottom: none;
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
  
<h2 style="text-align: center;">Añadir Nueva Info Noticia</h2>

<% if (message != null) { %>
  <div class="message <%= message.contains("correctamente") ? "success" : "error" %>">
    <%= message %>
  </div>
<% } %>

<form method="post">
  <label for="description">Descripción *</label>
  <textarea name="description" id="description" required maxlength="500"></textarea>

  <label for="vm_name">Nombre de la VM *</label>
  <input type="text" name="vm_name" id="vm_name" required maxlength="100" />

  <label for="date">Fecha *</label>
  <input type="text" name="date" id="date" required maxlength="50" placeholder="Ej. 28 de Mayo 2025" />

  <label for="os">Sistema Operativo</label>
  <select name="os" id="os">
  	<option value="Linux">Linux</option>
    <option value="Windows">Windows</option>
    <option value="Otro">Otro</option>
  </select>

  <label for="difficulty">Dificultad</label>
  <select name="difficulty" id="difficulty">
  	<option value="Muy Facil">Muy Fácil</option>
    <option value="Facil">Fácil</option>
    <option value="Media">Media</option>
    <option value="Dificil">Difícil</option>
  </select>
  
  <label for="environment">Entorno</label>
  <select name="environment" id="environment">
    <option value="Docker">Docker</option>
    <option value="VMWare">VMWare</option>
    <option value="Virtual Box">Virtual Box</option>
    <option value="Otro">Otro</option>
  </select>

  <label for="second_environment">Segundo Entorno (opcional)</label>
  <select name="second_environment" id="second_environment">
    <option value="">Ninguno</option>
    <option value="Docker">Docker</option>
    <option value="VMWare">VMWare</option>
    <option value="Virtual Box">Virtual Box</option>
    <option value="Otro">Otro</option>
  </select>
  
  <label for="pathInfoNotice">Nombre de Imagen de Portada</label>
  <input type="text" name="pathInfoNotice" id="pathInfoNotice" placeholder="Ej. test.png" maxlength="255" />
  
  <input type="submit" value="Añadir Noticia" />
</form>

<!-- FORMULARIO PARA PONER EN PUBLICO -->
<form method="post">
  <label for="id_estado">ID de la noticia a poner en <strong>público</strong>:</label>
  <input type="number" name="id_estado" required />
  <input type="hidden" name="accion_estado" value="publico" />
  <input type="submit" value="Poner en público" />
</form>

<!-- FORMULARIO PARA PONER EN PRIVADO -->
<form method="post">
  <label for="id_estado">ID de la noticia a poner en <strong>privado</strong>:</label>
  <input type="number" name="id_estado" required />
  <input type="hidden" name="accion_estado" value="privado" />
  <input type="submit" value="Poner en privado" />
</form>

</body>
</html>
