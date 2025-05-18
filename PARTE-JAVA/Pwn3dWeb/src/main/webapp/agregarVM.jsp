<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return; // Termina la ejecución del JSP
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
    .margin {
    	margin-top: -30px;
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
        <a href="<%= request.getContextPath() %>/deletedVM.jsp">Eliminar VM</a>
        <a href="<%= request.getContextPath() %>/addWriteupsAdmin.jsp">Agegar Writeups</a>
        <a href="#">Contacto</a>
    </nav>
</header>
<div class="container">
<form id="machineForm" action="<%= request.getContextPath() %>/machines" method="POST">
    <h2>➤ Ingreso de Máquina Virtual</h2>

    <!-- Campo con ícono de ID -->
    <div class="form-group">
        <label for="id">ID de la Máquina:</label>
        <div class="input-wrapper">
            <svg width="20" height="20" viewBox="0 0 24 24"><path d="M3 4v16h18V4H3zm2 2h14v12H5V6zm4 2v2h6V8H9z"/></svg>
            <input type="text" id="id" name="id" placeholder="1, 2, 3..." required>
        </div>
    </div>

    <div class="form-group">
        <label for="name_machine">Nombre de la máquina:</label>
        <div class="input-wrapper">
            <svg width="20" height="20" viewBox="0 0 24 24"><path d="M4 4h16v2H4zm0 4h10v2H4zm0 4h16v2H4zm0 4h10v2H4z"/></svg>
            <input type="text" id="name_machine" name="name_machine" placeholder="testMachine" required>
        </div>
    </div>

    <div class="form-group">
        <label for="size">Tamaño:</label>
        <div class="input-wrapper">
            <input type="text" id="size" name="size" placeholder="1.2GB, 200MB..." required>
        </div>
    </div>

    <div class="form-group">
        <label for="os">Sistema Operativo:</label>
        <div class="input-wrapper">
            <select id="os" name="os" required>
                <option value="" disabled selected>Selecciona la S.O.</option>
                <option value="Linux">Linux</option>
                <option value="Windows">Windows</option>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label for="enviroment">Entorno:</label>
        <div class="input-wrapper">
            <select id="enviroment" name="enviroment" required>
                <option value="" disabled selected>Selecciona el Entorno</option>
                <option value="vbox">Virtual Box</option>
                <option value="vmware">VMWare</option>
                <option value="docker">Docker</option>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label for="enviroment2">Entorno 2 (OPCIONAL):</label>
        <div class="input-wrapper">
            <select id="enviroment2" name="enviroment2">
                <option value="" disabled selected>Selecciona el Entorno 2</option>
                <option value="vbox">Virtual Box</option>
                <option value="vmware">VMWare</option>
                <option value="docker">Docker</option>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label for="creator">Creador:</label>
        <div class="input-wrapper">
            <input type="text" id="creator" name="creator" placeholder="username..." required>
        </div>
    </div>

    <div class="form-group">
        <label for="difficulty_card">Dificultad Tarjeta:</label>
        <div class="input-wrapper">
            <select id="difficulty_card" name="difficulty_card" required>
                <option value="" disabled selected>Selecciona la dificultad</option>
                <option value="Very-Easy">Very Easy</option>
                <option value="Easy">Easy</option>
                <option value="Medium">Medium</option>
                <option value="Hard">Hard</option>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label for="difficulty">Dificultad:</label>
        <div class="input-wrapper">
            <select id="difficulty" name="difficulty" required>
                <option value="" disabled selected>Selecciona la dificultad</option>
                <option value="very-easy">Very Easy</option>
                <option value="easy">Easy</option>
                <option value="medium">Medium</option>
                <option value="hard">Hard</option>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label for="date">Fecha:</label>
        <div class="input-wrapper">
            <input type="date" id="date" name="date" required>
        </div>
    </div>

    <div class="form-group">
        <label for="md5">MD5 Hash:</label>
        <div class="input-wrapper">
            <input type="text" id="md5" name="md5" placeholder="ABCDEFGHIJKLMNÑOPQRSTUVWXYZ..." required>
        </div>
    </div>

    <div class="form-group">
        <label for="writeup_url">URL del Writeup:</label>
        <div class="input-wrapper">
            <input type="url" id="writeup_url" name="writeup_url" placeholder="https://test.com/" required>
        </div>
    </div>

    <div class="form-group">
        <label for="first_user">Primer usuario:</label>
        <div class="input-wrapper">
            <input type="text" id="first_user" name="first_user" placeholder="user...">
        </div>
    </div>

    <div class="form-group">
        <label for="first_root">Primer root:</label>
        <div class="input-wrapper">
            <input type="text" id="first_root" name="first_root" placeholder="user...">
        </div>
    </div>

    <div class="form-group">
        <label for="img_name_os">Imagen del sistema operativo (nombre de archivo):</label>
        <div class="input-wrapper">
            <select id="img_name_os" name="img_name_os" required>
                <option value="" disabled selected>Selecciona la Imagen del S.O.</option>
                <option value="Linux">Linux</option>
                <option value="Windows">Windows</option>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label for="download_url">URL de descarga:</label>
        <div class="input-wrapper">
            <input type="url" id="download_url" name="download_url" placeholder="https://test.com/download" required>
        </div>
    </div>

    <button type="submit">Enviar</button>
</form>
</div>

<div class="container margin">
	<form action="<%= request.getContextPath() %>/publishVM" method="POST">
	  <h2>Cambiar estado (Publicado) de VM por ID</h2>
	  <label for="vmIdInput">ID de la VM:</label>
	  <input type="number" id="vmIdInput" name="id" min="1" style="background: #1b1b1b; color: #4be979;" required />
	  <br><br>
	  <button type="submit">Publicar</button>
	</form>
</div>

</body>
</html>