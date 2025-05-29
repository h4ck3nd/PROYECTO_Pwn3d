<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Árbol de Estadísticas</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
    <style>
        body {
            background-color: #2c2c3a;
            color: #cfcfcf;
            font-family: 'Press Start 2P', cursive;
            display: flex;
            justify-content: center;
            padding: 40px;
        }

        .tree {
            max-width: 800px;
            width: 100%;
        }

        .tree-node {
            margin-left: 20px;
            border-left: 2px solid #7f5af0;
            padding-left: 15px;
            position: relative;
            margin-top: 10px;
        }

        .tree-node::before {
            content: "";
            position: absolute;
            left: -2px;
            top: 0;
            bottom: 0;
            width: 2px;
            background-color: #7f5af0;
            animation: pulse 3s infinite;
        }

        .branch-toggle {
            cursor: pointer;
            margin-bottom: 5px;
            display: inline-block;
            font-weight: bold;
            color: #7f5af0;
            user-select: none;
        }

        .branch-content {
            display: none;
            margin-top: 5px;
        }

        .expanded .branch-content {
            display: block;
            animation: fadeIn 0.4s ease-in;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.3; }
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-5px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .label {
            color: #b48bf2;
            font-weight: bold;
        }

        h2 {
            color: #7f5af0;
            text-align: center;
        }
        .btn.exit {
	    background: linear-gradient(135deg, #6e40e1, #9b59b6);
	    border: none;
	    color: #e0d7f5;
	    padding: 0.6rem 1.4rem;
	    font-weight: 600;
	    font-size: 1rem;
	    border-radius: 8px;
	    cursor: pointer;
	    box-shadow: 0 4px 10px rgba(110, 64, 225, 0.6);
	    transition: background 0.3s ease, box-shadow 0.3s ease;
	    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	  }
	
	  .btn.exit:hover {
	    background: linear-gradient(135deg, #9b59b6, #6e40e1);
	    box-shadow: 0 6px 15px rgba(155, 89, 182, 0.8);
	  }
	
	  .btn.exit:active {
	    background: #5b2dbd;
	    box-shadow: 0 2px 5px rgba(91, 45, 189, 0.9);
	  }
    </style>
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
	            prohacker: "¡Pro Hacker (500 máquinas)!"
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
