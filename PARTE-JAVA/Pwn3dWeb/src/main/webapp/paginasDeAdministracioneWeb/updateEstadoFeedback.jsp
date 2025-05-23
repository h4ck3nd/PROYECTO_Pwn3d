<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Actualizar Estado Feedback | VM Manager [CTF Mode]</title>
    <style>
        /* Reset */
        * {
            margin: 0; padding: 0; box-sizing: border-box;
            font-family: 'Source Code Pro', monospace, monospace;
            user-select: none;
        }
        body {
            background-color: #121212;
            color: #c8c8c8;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            font-size: 16px;
        }
        header.navbar {
            background-color: #1f1f1f;
            padding: 1rem 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 2px solid #00ffea;
        }
        header .logo {
            font-weight: 700;
            font-size: 1.5rem;
            color: #00ffea;
            letter-spacing: 0.1em;
        }
        nav a {
            color: #00ffea;
            text-decoration: none;
            margin-left: 1.5rem;
            font-weight: 500;
            transition: color 0.2s ease;
        }
        nav a:hover {
            color: #0ff;
            text-shadow: 0 0 8px #00ffea;
        }
        .container {
            max-width: 480px;
            background-color: #1a1a1a;
            margin: 3rem auto;
            padding: 2rem 2.5rem;
            border-radius: 12px;
            box-shadow: 0 0 12px #00ffea88;
        }
        h1 {
            color: #00ffea;
            margin-bottom: 1.5rem;
            font-weight: 700;
            text-align: center;
            text-shadow: 0 0 10px #00ffea;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            color: #0ff;
            font-weight: 600;
        }
        input[type="number"],
        input[type="text"] {
            width: 100%;
            padding: 0.7rem 1rem;
            border: none;
            border-radius: 6px;
            background-color: #222;
            color: #0ff;
            font-size: 1rem;
            outline: none;
            box-shadow: inset 0 0 8px #00ffea;
            transition: box-shadow 0.2s ease;
        }
        input[type="number"]:focus,
        input[type="text"]:focus {
            box-shadow: 0 0 12px #00ffd1;
            background-color: #111;
        }
        button {
            margin-top: 1.8rem;
            width: 100%;
            padding: 0.75rem;
            background: linear-gradient(90deg, #00ffea, #00a9a5);
            border: none;
            border-radius: 8px;
            color: #111;
            font-weight: 700;
            font-size: 1.1rem;
            cursor: pointer;
            box-shadow: 0 0 12px #00ffeaaa;
            transition: background 0.3s ease, box-shadow 0.3s ease;
            user-select: none;
        }
        button:hover {
            background: linear-gradient(90deg, #00d8c4, #008f8a);
            box-shadow: 0 0 18px #00ffeaee;
        }
        #alert-container {
            margin-top: 1.5rem;
            font-weight: 700;
            text-align: center;
        }
        /* Alert styles */
        .alert {
            padding: 1rem 1.2rem;
            border-radius: 8px;
            box-shadow: 0 0 10px #00ffeaaa;
            user-select: text;
            max-width: 480px;
            margin: 0 auto;
        }
        .alert-success {
            background-color: #005f40;
            color: #a0ffca;
            border: 1.5px solid #00ffae;
        }
        .alert-danger {
            background-color: #5f0000;
            color: #ffb2b2;
            border: 1.5px solid #ff0000;
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro:wght@400;700&display=swap" rel="stylesheet" />
</head>
<body>
<header class="navbar">
    <div class="logo">🧠 VM Manager [CTF Mode]</div>
    <nav>
      <a href="#">Inicio</a>
      <a href="<%= request.getContextPath() %>/machines.jsp">Máquinas</a>
      <a href="<%= request.getContextPath() %>/paginasDeAdministracioneWeb/deletedVM.jsp">Eliminar VM</a>
      <a href="<%= request.getContextPath() %>/paginasDeAdministracioneWeb/agregarVM.jsp">Agregar VM</a>
      <a href="<%= request.getContextPath() %>/paginasDeAdministracioneWeb/addWriteupsAdmin.jsp">Agregar Writeups</a>
      <a href="<%= request.getContextPath() %>/paginasDeAdministracioneWeb/updateEstadoFeedback.jsp">Actualizar Feedbacks</a>
      <a href="<%= request.getContextPath() %>/paginasDeAdministracioneWeb/users.jsp">Usuarios</a>
      <a href="<%= request.getContextPath() %>/paginasDeAdministracioneWeb/adminDB.jsp">Administrar DDBB</a>
      <a href="#">Contacto</a>
    </nav>
</header>

<div class="container">
    <h1>Actualizar Estado de Feedback</h1>
    <form onsubmit="enviarFormulario(event)" autocomplete="off" spellcheck="false">
        <label for="id">ID del Feedback</label>
        <input type="number" id="id" name="id" min="1" placeholder="Ej: 42" required autofocus />
        
        <label for="estado">Nuevo Estado</label>
        <input type="text" id="estado" name="estado" maxlength="100" placeholder="Escribe el nuevo estado..." required />
        
        <button type="submit">Actualizar Estado</button>
    </form>
    <div id="alert-container"></div>
</div>

<script>
    function enviarFormulario(event) {
        event.preventDefault();
        const id = document.getElementById('id').value.trim();
        const estado = document.getElementById('estado').value.trim();

        if (!id || !estado) {
            mostrarAlerta("Todos los campos son obligatorios", "danger");
            return;
        }

        fetch('<%= request.getContextPath() %>/updateFeedbackEstado', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: "id=" + encodeURIComponent(id) + "&estado=" + encodeURIComponent(estado)
        })
        .then(res => res.json())
        .then(data => {
            if (data.success) {
                mostrarAlerta(data.message, "success");
            } else {
                mostrarAlerta(data.message || "Error al actualizar", "danger");
            }
        })
        .catch(() => {
            mostrarAlerta("Error del servidor", "danger");
        });
    }

    function mostrarAlerta(mensaje, tipo) {
        const alertContainer = document.getElementById('alert-container');
        let clase = tipo === 'success' ? 'alert-success' : 'alert-danger';
        alertContainer.innerHTML = '<div class="alert ' + clase + '" role="alert">' +
            mensaje +
            '</div>';
    }
</script>

</body>
</html>
