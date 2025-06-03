<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.ImgProfileDAO" %>
<%@ page import="model.ImgProfile" %>
<%@ page import="utils.JWTUtil" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.User" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%
    String token = null;
    Integer userId = null;
    String nombreUsuario = "Invitado";
    User usuario = null;

    try {
        javax.servlet.http.Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (javax.servlet.http.Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token == null || !JWTUtil.validateToken(token)) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        userId = JWTUtil.getUserIdFromToken(token);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        Map<String, Object> claims = JWTUtil.getAllClaims(token);
        if (claims != null && claims.get("usuario") != null) {
            nombreUsuario = (String) claims.get("usuario");
        }

        // Obtener todos los usuarios y buscar el actual
        UserDAO userDao = new UserDAO();
        List<User> usuarios = userDao.getAllUsers();
        for (User u : usuarios) {
            if (u.getId() == userId) {
                usuario = u;
                break;
            }
        }

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/logout");
        return;
    }

    // Obtener imagen de perfil
    ImgProfileDAO imgDao = new ImgProfileDAO();
    ImgProfile img = imgDao.getImgProfileByUserId(userId);
    imgDao.cerrarConexion();

    String imgSrc = (img != null && img.getPathImg() != null && !img.getPathImg().isEmpty())
        ? request.getContextPath() + "/" + img.getPathImg()
        : request.getContextPath() + "/imgProfile/default.png";

    // País
    String pais = usuario.getPais();
    String iso = (pais != null && !pais.trim().isEmpty()) ? pais.toLowerCase() : null;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Perfil | HackMyVM</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
    <style>
        body {
            background-color: #1e1b27;
            font-family: 'Press Start 2P', monospace;
            color: #d6d6d6;
            margin: 0 15rem;
            padding: 60px 8%;
            text-shadow: 1px 1px 1px #000000;
        }

        .profile-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
        }

        .stats-section, .trophies-section {
            width: 25%;
            min-width: 220px;
        }

        .avatar-section {
            text-align: center;
            flex: 1;
        }

        .avatar-img {
            width: 220px;
            height: 220px;
            border-radius: 50%;
            border: 6px solid #cb9cf0;
            object-fit: cover;
            background-color: #2c323e;
        }

        .username-title {
            font-size: 18px;
            color: #cb9cf0;
            margin-bottom: 10px;
        }

        .btn-love {
		    background-color: transparent;
		    border-radius: 5px;
		    color: #cb9cf0;
		    border: 2px solid #cb9cf0;
		    padding: 10px 20px;
		    font-size: 11px;
		    margin-top: 10px;
		    font-family: 'Press Start 2P', monospace;
		    cursor: pointer;
		    transition: all 0.3s ease;
		}
		.btn-love:hover {
		    background-color: #cb9cf0;
		    color: #000;
		}
		
		.btn-love:hover svg {
		    fill: #000;
		}
		
		.btn-message {
		    background-color: transparent;
		    border-radius: 5px;
		    color: #cb9cf0;
		    border: 2px solid #cb9cf0;
		    padding: 10px 20px;
		    font-size: 11px;
		    margin-top: 10px;
		    font-family: 'Press Start 2P', monospace;
		    cursor: pointer;
		    transition: all 0.3s ease;
		}
		.btn-message:hover {
		    background-color: #cb9cf0;
		    color: #000;
		}
		
		.btn-message:hover svg {
		    stroke: #000;
		}

        .quote {
            font-size: 8px;
            color: #999;
            margin-top: 10px;
        }

        ul.stats-list {
            list-style: none;
            padding-left: 0;
            font-size: 10px;
            line-height: 1.8;
        }

        .trophy-icons {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            margin-top: 10px;
        }

        .trophy-icons img {
            width: 28px;
            height: 28px;
            image-rendering: pixelated;
            padding: 2px;
        }

        .machines-section {
            margin-top: 70px;
            text-align: center;
            max-height: 400px; /* o el valor que prefieras */
		    overflow-y: auto;
		    /*border: 1px solid #6f42c1;*/ /* opcional: para delimitar visualmente */
		    padding-right: 5px; /* espacio para scroll */
        }
        
        .machines-section::-webkit-scrollbar {
		    width: 6px;
		}
		
		.machines-section::-webkit-scrollbar-thumb {
		    background-color: #6f42c1;
		    border-radius: 3px;
		}
		
		.machines-section::-webkit-scrollbar-track {
		    background-color: #1e1b27;
		}
        

        .machines-title {
            font-size: 16px;
            color: #cb9cf0;
            margin-bottom: 15px;
        }

        .machines-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 11px;
        }

        .machines-table th, .machines-table td {
            padding: 10px;
            border-bottom: 1px solid #6f42c1;
            text-align: center;
        }

        a {
            color: #cb9cf0;
        }

        @media screen and (max-width: 900px) {
            .profile-header {
                flex-direction: column;
                align-items: center;
            }

            .stats-section, .trophies-section {
                width: 100%;
                text-align: center;
                margin-top: 30px;
            }
        }
    </style>
</head>
<body>

<!-- PROFILE HEADER -->
<div class="profile-header">

    <!-- STATS LEFT -->
    <div class="stats-section">
        <div class="username-title">#61 <%= nombreUsuario %> 
        <% if (iso != null) { %>
		    <img src="<%= request.getContextPath() %>/img/flags/<%= iso %>.svg"
		         alt="<%= pais %>" 
		         style="vertical-align: middle;" 
		         width="20px" 
		         height="20px">
		<% } %>
        </div>
       <div style="display: flex; align-items: center;">
		    <span id="user-rank" style="font-size: 15px; color: #fff8fd; margin-right: 8px;"></span>
		    <span id="points-user" style="background:#cb9cf0; color:#000; padding:2px 6px; font-size: 9px; border-radius: 10px; text-shadow: none;">
		    	<!-- SECCION DE PUNTOS -->
		    </span>
		</div>

        <br>
        <button class="btn-love">
        	<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="#cb9cf0">
			  <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 
			           2 5.42 4.42 3 7.5 3c1.74 0 3.41 0.81 4.5 2.09 
			           C13.09 3.81 14.76 3 16.5 3 
			           19.58 3 22 5.42 22 8.5 
			           c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
			</svg>
 			Dar Love
 		</button>
        <br><br>
        <div style="margin-top: 15px; color: #cb9cf0;">Stadisticas<span style="color: white;">.</span></div>
        <ul class="stats-list" id="stats-list">
		    <!-- Aquí se inyectarán las estadísticas dinámicamente -->
		</ul>
    </div>

    <!-- AVATAR CENTER -->
    <div class="avatar-section">
        <img src="<%= imgSrc %>" alt="Avatar" class="avatar-img">
        <div class="quote">– Informacion de <%= nombreUsuario %>.</div>
        <button class="btn-message">
	        <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="none" stroke="#cb9cf0" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24">
			  <circle cx="12" cy="12" r="10"/>
			  <line x1="2" y1="12" x2="22" y2="12"/>
			  <path d="M12 2a15.3 15.3 0 0 1 0 20"/>
			  <path d="M12 2a15.3 15.3 0 0 0 0 20"/>
			</svg>
	 		Enviar Mensaje
 		</button>
 		<br><br><br><br>
    </div>
	
    <!-- TROPHIES + RR.SS. agrupados -->
	<div class="trophies-section">
	    <!-- Logros -->
	    <div style="color: #cb9cf0; margin-bottom: 10px;">Logros<span style="color: white;">.</span></div>
	    <div class="trophy-icons" id="trophy-icons">
	        <!-- JS insertará aquí las imágenes -->
	    </div>
		
		<br><br>
		
	    <!-- RR.SS. -->
	    <div style="color: #cb9cf0; margin: 20px 0 10px;">RR<span style="color: white;">.</span>SS<span style="color: white;">.</span></div>
	    <div class="trophy-icons" id="rrss-icons">
	        <!-- JS insertará aquí las imágenes -->
	    </div>
	</div>



</div>


<!-- MACHINES SECTION -->
<div class="machines-section">
    <div class="machines-title">Maquinas<span style="color: white;">.</span></div>
    <table class="machines-table">
        <thead>
            <tr>
                <th>Nombre VM</th>
                <th>Descargar</th>
                <th>Tamaño</th>
            </tr>
        </thead>
        <tbody id="machines-body">
            <!-- JS insertará aquí -->
        </tbody>
    </table>
</div>

<!-- WRITEUPS SECTION -->
<div class="machines-section">
    <div class="machines-title">Writeups<span style="color: white;">.</span></div>
    <table class="machines-table">
        <thead>
            <tr>
                <th>Nombre VM</th>
                <th>Link</th>
                <th>Idioma</th>
            </tr>
        </thead>
        <tbody id="writeups-body">
            <!-- JS insertará aquí -->
        </tbody>
    </table>
</div>

<script>
	async function loadStats() {
	    const res = await fetch('<%= request.getContextPath() %>/user-stats');
	    const raw = await res.text();
	
	    try {
	        const data = JSON.parse(raw);
	
	        var statsHTML = ""
	            + "<li>Total Root: " + data.flags_root + "</li>"
	            + "<li>Total User: " + data.flags_user + "</li>"
	            + "<li>Primeras Root: " + (data.firstRootFlags || 0) + "</li>"
	            + "<li>Primeras User: " + (data.firstUserFlags || 0) + "</li>"
	            + "<li>Writeups: " + data.total_writeups + "</li>"
	            + "<li>VMs Creadas: " + data.vms_creadas + "</li>"
	            + "<br>"
	            + "<li>"
	            + "    <svg xmlns='http://www.w3.org/2000/svg' width='15' height='15' viewBox='0 0 24 24' fill='#cb9cf0' style='vertical-align: middle; margin-right: 5px;'>"
	            + "        <path d='M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 "
	            + "                 2 5.42 4.42 3 7.5 3c1.74 0 3.41 0.81 4.5 2.09 "
	            + "                 C13.09 3.81 14.76 3 16.5 3 "
	            + "                 19.58 3 22 5.42 22 8.5 "
	            + "                 c0 3.78-3.4 6.86-8.55 11.54L12 21.35z'/>"
	            + "    </svg> "
	            + data.loves
	            + "</li>";
	
	        document.getElementById("stats-list").innerHTML = statsHTML;
	        
	        var pointsHTML = ""
	            + '<span>'
	            + data.puntos + ' pts'
	            + '</span>';
	
	        document.getElementById("points-user").innerHTML = pointsHTML;
	        
	        var badgeContainer = document.getElementById("trophy-icons");
	        badgeContainer.innerHTML = ""; // Limpia los logros anteriores

	        for (var badge in data.badges) {
	            if (data.badges[badge] === true) {
	                var img = document.createElement("img");
	                img.src = "<%= request.getContextPath() %>/img/badges/" + badge + ".svg";
	                img.alt = badge;
	                img.title = badge;
	                img.style.imageRendering = "pixelated";
	                img.width = 28;
	                img.height = 28;
	                badgeContainer.appendChild(img);
	            }
	        }
	        
	     // RR.SS.
	        var rrssContainer = document.getElementById("rrss-icons");
	        rrssContainer.innerHTML = ""; // Limpiar

	        if (data.redes_privadas) {
	            rrssContainer.innerHTML = "<span style='font-size: 10px; color: #aaa;'>Redes sociales en privado</span>";
	        } else {
	            for (var icon in data.redes) {
	                var url = data.redes[icon];
	                var link = document.createElement("a");
	                link.href = url;
	                link.target = "_blank";
	                link.style.marginRight = "8px";

	                var img = document.createElement("img");
	                img.src = "<%= request.getContextPath() %>/img/icons/" + icon;
	                img.alt = icon;
	                img.title = icon;
	                img.style.width = "24px";
	                img.style.height = "24px";

	                link.appendChild(img);
	                rrssContainer.appendChild(link);
	            }
	        }
	        
	        document.getElementById("user-rank").innerText = "[" + data.rango + "]";
	        
	     	// MÁQUINAS CREADAS
	        var machinesBody = document.getElementById("machines-body");
	        machinesBody.innerHTML = "";

	        if (Array.isArray(data.machines) && data.machines.length > 0) {
	            data.machines.forEach(function(machine) {
	                var row = "<tr>"
	                        + "<td style='color:#6efdee;'>" + machine.name + "</td>"
	                        + "<td><a href='" + machine.url + "' target='_blank'>Descargar</a></td>"
	                        + "<td>" + machine.size + "</td>"
	                        + "</tr>";
	                machinesBody.innerHTML += row;
	            });
	        } else {
	            machinesBody.innerHTML = "<tr><td colspan='3' style='color: #888;'>No hay máquinas creadas.</td></tr>";
	        }

	     	// WRITEUPS PUBLICADOS
	        var writeupsBody = document.getElementById("writeups-body");
	        writeupsBody.innerHTML = "";

	        if (Array.isArray(data.writeups) && data.writeups.length > 0) {
	            data.writeups.forEach(function(writeup) {
	                var row = "<tr>"
	                        + "<td style='color:#6efdee;'>" + writeup.vm + "</td>"
	                        + "<td><a href='" + writeup.url + "' target='_blank'>Leer</a></td>"
	                        + "<td>" + writeup.lang + "</td>"
	                        + "</tr>";
	                writeupsBody.innerHTML += row;
	            });
	        } else {
	            writeupsBody.innerHTML = "<tr><td colspan='3' style='color: #888;'>No hay writeups publicados.</td></tr>";
	        }
	
	    } catch (e) {
	        console.error("Error parsing stats JSON:", e);
	        document.getElementById("stats-list").innerHTML =
	            "<li style='color:red;'>Error al cargar estadísticas</li>";
	    }
	}
	
	window.onload = loadStats;
</script>
</body>
</html>
