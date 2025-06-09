<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reconocimientos - Pwn3d!</title>
	<link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
    <!-- Fuente retro desde Google Fonts -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssAppreciation.jsp" />
</head>
<body>

<header>
    <h1>Reconocimiento Paginas de CTFs - Hacking Ético</h1>
    <nav>
        <a href="<%= request.getContextPath() %>/stats">Volver</a>
    </nav>
</header>

<div class="container">
    <div class="platform-card">
        <img src="<%= request.getContextPath() %>/img/logosPaginas/dockerlabs.png" alt="Dockerlabs">
        <h2>Dockerlabs</h2>
        <p>Entornos de laboratorio ligeros con contenedores para pruebas rápidas de CTFs.</p>
    </div>
    <div class="platform-card">
        <img src="<%= request.getContextPath() %>/img/logosPaginas/hackmyvm.png" alt="HackMyVM">
        <h2>HackMyVM</h2>
        <p>Máquinas vulnerables creadas por la comunidad para aprender hacking ético.</p>
    </div>
    <div class="platform-card">
        <img src="<%= request.getContextPath() %>/img/logosPaginas/vulnyx.png" alt="Vulnyx">
        <h2>Vulnyx</h2>
        <p>Plataforma emergente con desafíos técnicos enfocados en pentesting.</p>
    </div>
    <div class="platform-card">
        <img src="<%= request.getContextPath() %>/img/logosPaginas/vulnhub.ico" alt="VulnHub">
        <h2>VulnHub</h2>
        <p>Repositorio clásico de máquinas vulnerables descargables para pruebas locales.</p>
    </div>
    <div class="platform-card">
        <img src="<%= request.getContextPath() %>/img/logosPaginas/tryhackme.png" alt="TryHackMe">
        <h2>TryHackMe</h2>
        <p>Rutas de aprendizaje guiadas y laboratorios interactivos para todos los niveles.</p>
    </div>
    <div class="platform-card">
        <img src="<%= request.getContextPath() %>/img/logosPaginas/hackthebox.png" alt="Hack The Box">
        <h2>Hack The Box</h2>
        <p>Plataforma con laboratorios avanzados y competiciones de hacking realistas.</p>
    </div>
    <div class="platform-card">
        <img src="<%= request.getContextPath() %>/img/logosPaginas/rootme.png" alt="Root Me">
        <h2>Root Me</h2>
        <p>Rica en categorías y retos para aprender hacking ofensivo y defensivo.</p>
    </div>
    <div class="platform-card">
        <img src="<%= request.getContextPath() %>/img/logosPaginas/bugbountylabs.png" alt="BugBountyLabs">
        <h2>BugBountyLabs</h2>
        <p>Laboratorios centrados en simulaciones de programas de bug bounty reales.</p>
    </div>
    <div class="platform-card">
        <img src="<%= request.getContextPath() %>/img/logosPaginas/thehackerslabs.png" alt="TheHackersLabs">
        <h2>TheHackersLabs</h2>
        <p>Plataforma con labs técnicos de explotación y reconocimiento variados.</p>
    </div>
</div>

<footer>
    © 2025 - Página de Reconocimiento de CTFs Éticos | by d1se0
</footer>

</body>
</html>
