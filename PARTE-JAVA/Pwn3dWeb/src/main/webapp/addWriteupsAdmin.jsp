<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Administrador de Writeups</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
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
      --border-color: #00ff88;
    }

    * {
      box-sizing: border-box;
    }

    body {
      font-family: 'Fira Code', monospace;
      background-color: var(--bg-color);
      color: var(--text-color);
      margin: 0;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      padding-top: 60px;
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
      font-weight: 600;
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

    h1, h2 {
      text-align: center;
      color: var(--accent);
      text-shadow: 0 0 5px var(--accent);
      margin-bottom: 0.5rem;
    }

    p {
      max-width: 600px;
      margin: 0 auto 2rem;
      text-align: center;
      color: var(--label-color);
      text-shadow: 0 0 3px var(--accent);
    }

    .container {
      flex: 1;
      max-width: 960px;
      margin: 0 auto 3rem;
      padding: 0 1rem;
    }

    button {
      background-color: transparent;
      color: var(--accent);
      border: 2px solid var(--accent);
      padding: 10px 24px;
      font-size: 1rem;
      font-weight: 600;
      border-radius: 8px;
      cursor: pointer;
      display: block;
      margin: 0 auto 1.5rem auto;
      font-family: 'Fira Code', monospace;
      text-shadow: 0 0 5px var(--accent);
      transition: all 0.3s ease;
    }

    button:hover {
      background-color: var(--accent-dark);
      color: var(--bg-color);
      transform: translateY(-2px);
      box-shadow: 0 0 15px var(--accent);
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 0;
      border: 1px solid var(--border-color);
      box-shadow: 0 0 15px rgba(57, 255, 20, 0.3);
    }

    th, td {
      padding: 12px 16px;
      border: 1px solid var(--border-color);
      text-align: left;
      font-size: 1rem;
    }

    th {
      background-color: #161616;
      color: var(--accent);
      text-shadow: 0 0 5px var(--accent);
    }

    tbody tr:hover {
      background-color: rgba(57, 255, 20, 0.1);
      cursor: pointer;
    }

    a {
      color: var(--accent);
      text-decoration: none;
      font-weight: 600;
      transition: color 0.3s ease;
    }

    a:hover {
      color: var(--accent-dark);
      text-shadow: 0 0 8px var(--accent-dark);
    }

    @media (max-width: 600px) {
      .navbar nav {
        display: none;
      }

      th, td {
        font-size: 0.9rem;
        padding: 10px 12px;
      }
    }
  </style>

  <script>
    let writeupsArr = [];

    function cargarWriteupsPublicados() {
      fetch('<%= request.getContextPath() %>/addWriteupsPublish', {
        method: 'POST'
      })
      .then(response => response.text())
      .then(js => {
        writeupsArr = []; // Limpiamos el arreglo antes de agregar nuevos writeups
        eval(js);         // El servlet envía JS que hace writeupsArr.push(writeupObj);
        mostrarWriteups();
      })
      .catch(err => {
        console.error("Error al cargar writeups publicados:", err);
      });
    }

    function mostrarWriteups() {
      const contenedor = document.getElementById("tablaWriteups");
      contenedor.innerHTML = "";

      if (writeupsArr.length === 0) {
        const fila = document.createElement("tr");
        fila.innerHTML = "<td colspan='3' style='text-align:center; color: var(--label-color); font-style: italic;'>Actualmente no hay ningún Writeup pendiente.</td>";
        contenedor.appendChild(fila);
        return;
      }

      writeupsArr.forEach(w => {
        const fila = document.createElement("tr");
        fila.innerHTML =
          "<td>" + w.name + "</td>" +
          "<td>" + w.creator + "</td>" +
          "<td><a href='" + w.url + "' target='_blank'>Ver</a></td>";
        contenedor.appendChild(fila);
      });
    }
  </script>
</head>
<body>
  <header class="navbar">
    <div class="logo">🧠 VM Manager [CTF Mode]</div>
    <nav>
      <a href="#">Inicio</a>
      <a href="<%= request.getContextPath() %>/machines.jsp">Máquinas</a>
      <a href="<%= request.getContextPath() %>/deletedVM.jsp">Eliminar VM</a>
      <a href="<%= request.getContextPath() %>/agregarVM.jsp">Agregar VM</a>
      <a href="#">Contacto</a>
    </nav>
  </header>

  <div class="container">
    <h1>Gestión de Writeups - Panel de Administrador</h1>
    <p>Esta sección permite publicar writeups pendientes enviados por usuarios.</p>

    <button onclick="cargarWriteupsPublicados()">Publicar Writeups Pendientes</button>

    <h2>Writeups Publicados</h2>
    <table>
      <thead>
        <tr>
          <th>Nombre de la Máquina</th>
          <th>Creador</th>
          <th>URL</th>
        </tr>
      </thead>
      <tbody id="tablaWriteups">
        <!-- Aquí se cargarán los writeups publicados -->
      </tbody>
    </table>
  </div>
</body>
</html>
