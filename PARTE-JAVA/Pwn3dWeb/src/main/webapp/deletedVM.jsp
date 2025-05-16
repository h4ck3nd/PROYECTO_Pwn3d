<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Cookie[] cookies = request.getCookies();
    String token = null;
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("token".equals(c.getName())) {
                token = c.getValue();
            }
        }
    }

    if (token == null) {
    	String contextPath = request.getContextPath();
    	response.sendRedirect(contextPath + "/login-register/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Añadir VM</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Fira+Code:wght@400;600&display=swap');

    :root {
        --bg-color: #0e0e0e;
        --form-bg: #161616;
        --text-color: #39ff14;
        --accent: #39ff14;
        --accent-dark: #2bdc0c;
        --input-bg: #1b1b1b;
        --label-color: #9aff8a;
        --navbar-bg: #111;
    }

    * {
        box-sizing: border-box;
    }

    body {
        font-family: 'Fira Code', monospace;
        background-color: var(--bg-color);
        color: var(--text-color);
        margin: 0;
        height: 100vh;
        display: flex;
        flex-direction: column;
    }

    .container {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 40px 20px;
        margin-top: 80px;
    }

    .navbar {
        position: fixed;
        top: 0;
        width: 100%;
        background-color: var(--navbar-bg);
        padding: 1rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 8px rgba(0, 255, 0, 0.3);
        z-index: 1000;
    }

    .navbar .logo {
        color: var(--accent);
        font-weight: bold;
        font-size: 1.3rem;
        letter-spacing: 1px;
    }

    .navbar nav a {
        color: var(--text-color);
        margin-left: 1.5rem;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.2s ease;
    }

    .navbar nav a:hover {
        color: var(--accent);
        text-shadow: 0 0 5px var(--accent);
    }

    form {
        background-color: var(--form-bg);
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 0 25px rgba(0, 255, 0, 0.2);
        width: 100%;
        max-width: 800px;
        border: 1px solid var(--accent);
    }

    h2 {
        text-align: center;
        color: var(--accent);
        margin-bottom: 20px;
        text-shadow: 0 0 5px var(--accent);
    }

    .form-group {
        display: flex;
        flex-direction: column;
        margin-bottom: 20px;
    }

    label {
        color: var(--label-color);
        font-weight: 600;
        margin-bottom: 6px;
        text-shadow: 0 0 3px var(--accent);
    }

    .input-wrapper {
        display: flex;
        align-items: center;
        background-color: var(--input-bg);
        border: 1px solid #00ff88;
        border-radius: 6px;
        padding: 10px;
        box-shadow: inset 0 0 10px rgba(0, 255, 0, 0.2);
        transition: box-shadow 0.3s ease;
    }

    .input-wrapper input,
    .input-wrapper select {
        background: transparent;
        border: none;
        outline: none;
        color: var(--text-color);
        width: 100%;
        font-size: 1rem;
        font-family: 'Fira Code', monospace;
    }

    .input-wrapper input::placeholder {
        color: #54ff8f;
    }

    .input-wrapper:focus-within {
        border-color: var(--accent);
        box-shadow: 0 0 10px var(--accent);
    }

    button[type="submit"] {
        background-color: transparent;
        color: var(--accent);
        border: 2px solid var(--accent);
        padding: 14px;
        width: 100%;
        font-size: 1rem;
        font-weight: bold;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
        font-family: 'Fira Code', monospace;
        text-shadow: 0 0 5px var(--accent);
    }

    button[type="submit"]:hover {
        background-color: var(--accent-dark);
        color: var(--bg-color);
        transform: translateY(-2px);
        box-shadow: 0 0 15px var(--accent);
    }

    @media (max-width: 600px) {
        .navbar nav {
            display: none;
        }

        form {
            padding: 20px;
        }

        .navbar {
            flex-direction: column;
            align-items: flex-start;
        }
    }
    .input-wrapper select {
        background-color: var(--input-bg);
        color: var(--text-color);
        border: 1px solid #00ff88;
        padding: 10px;
        border-radius: 6px;
        font-size: 1rem;
        font-family: 'Fira Code', monospace;
        width: 100%;
        appearance: none;
        -webkit-appearance: none;
        -moz-appearance: none;
        position: relative;
    }

    .input-wrapper select:focus {
        outline: none;
        border-color: var(--accent);
        box-shadow: 0 0 6px var(--accent);
    }

    .input-wrapper select option {
        background-color: var(--input-bg);
        color: var(--text-color);
        padding: 10px;
    }

    .input-wrapper select option:hover {
        background-color: #333;
    }

    /* Añadimos una flecha estilizada al select */
    .input-wrapper select::after {
        content: '\2193'; /* flecha hacia abajo */
        position: absolute;
        top: 50%;
        right: 10px;
        transform: translateY(-50%);
        color: var(--text-color);
        font-size: 1.2rem;
    }
    .input-wrapper svg {
        width: 18px; /* Ajustamos el tamaño del ícono */
        height: 18px; /* Ajustamos el tamaño del ícono */
        fill: var(--accent); /* Ponemos el color del ícono en verde neón */
        margin-right: 10px; /* Espacio entre el ícono y el campo de texto */
        transition: fill 0.2s ease; /* Efecto suave cuando pasa el cursor */
    }

    .input-wrapper:hover svg {
        fill: var(--accent-dark); /* Color del ícono cambia al pasar el cursor */
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
        <a href="<%= request.getContextPath() %>/agregarVM.jsp">Añadir VM</a>
        <a href="#">Contacto</a>
    </nav>
</header>
<div class="container">
<form id="deleteForm" action="<%= request.getContextPath() %>/eliminarMaquina" method="post" style="max-width: 400px; margin: 0 auto;">
    <div class="form-group">
        <label for="idInput" style="color: #9aff8a; margin-bottom: 6px; display: block;">ID de la máquina</label>
        <div class="input-wrapper" style="display: flex; align-items: center; background-color: #1b1b1b; border: 1px solid #00ff88; border-radius: 6px; padding: 10px; box-shadow: inset 0 0 10px rgba(0, 255, 0, 0.2);">
            <input 
                id="idInput"
                name="id"
                value="${machine.id}"
                placeholder="Ej: 13"
                style="background: transparent; border: none; outline: none; color: #39ff14; width: 100%; font-size: 1rem; font-family: 'Fira Code', monospace;" 
            />
        </div>
    </div>

    <button 
        type="button" 
        id="deleteBtn"
        style="background-color: crimson; color: white; border: none; padding: 12px 20px; border-radius: 8px; cursor: pointer; width: 100%; margin-top: 12px; font-family: 'Fira Code', monospace; font-weight: bold; box-shadow: 0 0 10px rgba(255, 0, 0, 0.6); transition: transform 0.2s ease;"
        onmouseover="this.style.transform='scale(1.05)'"
        onmouseout="this.style.transform='scale(1)'"
    >
        🗑️ Eliminar
    </button>
</form>
</div>
<br>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    document.getElementById('deleteBtn').addEventListener('click', function () {
        Swal.fire({
            title: '¿Eliminar máquina?',
            text: "Esta acción no se puede deshacer.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#39ff14',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, eliminar',
            background: '#0e0e0e',
            color: '#39ff14',
            customClass: {
                popup: 'neon-popup'
            }
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('deleteForm').submit();
            }
        });
    });
</script>
</body>
</html>