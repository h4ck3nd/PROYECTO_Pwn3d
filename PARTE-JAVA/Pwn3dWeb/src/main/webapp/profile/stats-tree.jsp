<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
    <title>Árbol de Estadísticas - Pwn3d!</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssStatsTree.jsp">
</head>
<body>
<div class="tree">
    <h2 id="userTitle">Cargando...</h2>
    <div style="display: flex; justify-content: center; margin: 3rem 0;">
	  <button onclick="window.location.href='<%= request.getContextPath() %>/stats'" class="btn exit" style="font-family: 'Press Start 2P', monospace !important;">Volver</button>
	</div>
	<br>
    <div class="tree-node" id="node-info">
        <div class="branch-toggle" onclick="toggleBranch('info')">▶ Información básica</div>
        <div class="branch-content" id="info"></div>
    </div>

    <div class="tree-node" id="node-flags">
        <div class="branch-toggle" onclick="toggleBranch('flags')">▶ Flags & Puntos</div>
        <div class="branch-content" id="flags"></div>
    </div>

    <div class="tree-node" id="node-stats">
        <div class="branch-toggle" onclick="toggleBranch('stats')">▶ Actividad CTF</div>
        <div class="branch-content" id="stats"></div>
    </div>
    
    <div class="tree-node" id="node-badges">
	    <div class="branch-toggle" onclick="toggleBranch('badges')">▶ Logros obtenidos</div>
	    <div class="branch-content" id="badges"></div>
	</div>
    
</div>

<script>
	async function loadStats() {
	    const res = await fetch('<%= request.getContextPath() %>/user-stats');
	    const raw = await res.text();
	
	    try {
	        const data = JSON.parse(raw);
	        document.getElementById("userTitle").innerText = "Estadísticas de " + data.usuario;
	
	        document.getElementById("info").innerHTML =
	            "<p><span class='label'>Nombre:</span> " + data.nombre + " " + data.apellido + "</p>" +
	            "<p><span class='label'>País:</span> " + data.pais + "</p>" +
	            "<p><span class='label'>Último inicio:</span> " + data.ultimo_inicio + "</p>";
	
	            document.getElementById("flags").innerHTML =
	                "<p><span class='label'>Flags user:</span> " + data.flags_user + "</p>" +
	                "<p><span class='label'>Flags root:</span> " + data.flags_root + "</p>" +
	                "<p><span class='label'>Primeras flags user:</span> " + (data.firstUserFlags || 0) + "</p>" +
	                "<p><span class='label'>Primeras flags root:</span> " + (data.firstRootFlags || 0) + "</p>" +
	                "<p><span class='label'>Puntos totales:</span> " + data.puntos + "</p>";
	
	        document.getElementById("stats").innerHTML =
	            "<p><span class='label'>Writeups públicos:</span> " + data.total_writeups + "</p>" +
	            "<p><span class='label'>Estrellas dadas:</span> " + data.estrellas_dadas + "</p>" +
	            "<p><span class='label'>Feedbacks:</span> " + data.feedbacks + "</p>" +
	            "<p><span class='label'>Requests creadas:</span> " + data.requests + "</p>";
	
	        var badgeNames = {
	            noob: "¡Bienvenido!",
	            top1mes: "Top 1 del mes",
	            top1año: "Top 1 del año",
	            creador: "Creador de máquinas",
	            vms50: "50 máquinas hackeadas",
	            vms100: "100 máquinas hackeadas",
	            vms200: "200 máquinas hackeadas",
	            vms300: "300 máquinas hackeadas",
	            juniorvm: "Tu primera máquina",
	            escritor: "Ha escrito writeups",
	            writeups100: "100 writeups",
	            solucionador: "Primer writeup",
	            firstroot: "Primera root flag",
	            firstuser: "Primera user flag",
	            puntos100: "100 puntos",
	            puntos1000: "1000 puntos",
	            puntos2000: "2000 puntos",
	            puntos3000: "3000 puntos",
	            estrellita: "Ha dado estrellas",
	            hacker: "¡Hacker!",
	            prohacker: "¡Pro Hacker (500 máquinas)!",
	    	    aprendiz: "Aprendiz de Hacker",
	    	    "0xcoffee": "Amante del café 0xCoffee",
	    	    anonymous: "Anonymous",
	    	    FuckSystem: "Fuck the System",
	    	    god: "Dios del Hackeo"
	        };
	
	        var badgesHTML = "";
	        var hasBadges = false;
	        for (var badge in data.badges) {
	            if (data.badges[badge] === true) {
	                hasBadges = true;
	                var name = badgeNames[badge] || badge;
	                badgesHTML += "<div style='margin-bottom: 6px; font-weight: bold; color: #b48bf2;'>" +
	                              "🏅 [" + badge + "] " + name +
	                              "</div>";
	            }
	        }
	
	        if (hasBadges) {
	            document.getElementById("badges").innerHTML = badgesHTML;
	        } else {
	            document.getElementById("badges").innerHTML = "<p>No se han obtenido logros aún.</p>";
	        }
	
	    } catch (e) {
	        console.error("Error parsing JSON:", e);
	        document.body.innerHTML += "<p style='color: red;'>Error cargando estadísticas</p>";
	    }
	}

    function toggleBranch(id) {
        const node = document.getElementById("node-" + id);
        node.classList.toggle("expanded");

        const toggle = node.querySelector(".branch-toggle");
        if (node.classList.contains("expanded")) {
            toggle.innerText = "▼ " + toggle.innerText.slice(2);
        } else {
            toggle.innerText = "▶ " + toggle.innerText.slice(2);
        }
    }

    window.onload = loadStats;
</script>

</body>
</html>
