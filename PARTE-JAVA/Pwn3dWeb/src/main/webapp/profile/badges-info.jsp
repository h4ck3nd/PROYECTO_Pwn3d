<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
    <title>Badges Info - Pwn3d!</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
    
    <!-- Incluye Bootstrap CSS y JS en tu proyecto -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssBadgesInfo.jsp">
</head>
<body>
    <div class="container">
    	
    	<!-- Barra de mini opciones -->
	  <nav class="mini-nav">
	    <button onclick="scrollToSection('logros')">Logros</button>
	    <button onclick="scrollToSection('logros-desbloqueados')">Logros Obtenidos</button>
	    <button onclick="scrollToSection('recompensas')">Recompensas</button>
	  </nav>
    	<br>
        <h2 id="logros">Logros y Cómo Conseguirlos</h2>

        <button onclick="window.location.href='<%= request.getContextPath() %>/profile/profile.jsp'" class="btn exit">
            Volver
        </button>

        <div class="achievements-list d-flex flex-wrap gap-3">
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[noob]</div>
		    <img
		      title="noob"
		      src="<%= request.getContextPath() %>/img/badges/noob.svg"
		      alt="Icono"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/noob.svg"
		      data-bs-imgalt="Icono noob"
		    />
		    <div class="achievement-title">¡Bienvenido!</div>
		    <div class="achievement-desc">
		      Consigue tu primer logro simplemente por unirte y comenzar a usar la plataforma.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[top1mes]</div>
		    <img
		      title="top1mes"
		      src="<%= request.getContextPath() %>/img/badges/top1mes.svg"
		      alt="Icono Top 1 del mes"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/top1mes.svg"
		      data-bs-imgalt="Icono Top 1 del mes"
		    />
		    <div class="achievement-title">Top 1 del mes</div>
		    <div class="achievement-desc">Sé el usuario con más puntos acumulados en el ranking del mes.</div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[top1año]</div>
		    <img
		      title="top1año"
		      src="<%= request.getContextPath() %>/img/badges/top1año.svg"
		      alt="Icono Top 1 del año"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/top1año.svg"
		      data-bs-imgalt="Icono Top 1 del año"
		    />
		    <div class="achievement-title">Top 1 del año</div>
		    <div class="achievement-desc">Llega a la cima del ranking anual y demuestra tu constancia y habilidad.</div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[creador]</div>
		    <img
		      title="creador"
		      src="<%= request.getContextPath() %>/img/badges/creador.svg"
		      alt="Icono Creador de máquinas"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/creador.svg"
		      data-bs-imgalt="Icono Creador de máquinas"
		    />
		    <div class="achievement-title">Creador de máquinas</div>
		    <div class="achievement-desc">
		      Publica y comparte tus propias máquinas para que otros usuarios las resuelvan.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[vms50]</div>
		    <img
		      title="vms50"
		      src="<%= request.getContextPath() %>/img/badges/vms50.svg"
		      alt="Icono 50 máquinas hackeadas"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/vms50.svg"
		      data-bs-imgalt="Icono 50 máquinas hackeadas"
		    />
		    <div class="achievement-title">50 máquinas hackeadas</div>
		    <div class="achievement-desc">
		      Completa con éxito la resolución de 50 máquinas en la plataforma.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[vms100]</div>
		    <img
		      title="vms100"
		      src="<%= request.getContextPath() %>/img/badges/vms100.svg"
		      alt="Icono 100 máquinas hackeadas"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/vms100.svg"
		      data-bs-imgalt="Icono 100 máquinas hackeadas"
		    />
		    <div class="achievement-title">100 máquinas hackeadas</div>
		    <div class="achievement-desc">
		      Supera el hito de 100 máquinas resueltas y sube tu nivel de experto.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[vms200]</div>
		    <img
		      title="vms200"
		      src="<%= request.getContextPath() %>/img/badges/vms200.svg"
		      alt="Icono 200 máquinas hackeadas"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/vms200.svg"
		      data-bs-imgalt="Icono 200 máquinas hackeadas"
		    />
		    <div class="achievement-title">200 máquinas hackeadas</div>
		    <div class="achievement-desc">
		      Mantén tu ritmo y alcanza las 200 máquinas solucionadas.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[vms300]</div>
		    <img
		      title="vms300"
		      src="<%= request.getContextPath() %>/img/badges/vms300.svg"
		      alt="Icono 300 máquinas hackeadas"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/vms300.svg"
		      data-bs-imgalt="Icono 300 máquinas hackeadas"
		    />
		    <div class="achievement-title">300 máquinas hackeadas</div>
		    <div class="achievement-desc">
		      Un auténtico hacker profesional, con 300 máquinas resueltas.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[juniorvm]</div>
		    <img
		      title="juniorvm"
		      src="<%= request.getContextPath() %>/img/badges/juniorvm.svg"
		      alt="Icono Tu primera máquina"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/juniorvm.svg"
		      data-bs-imgalt="Icono Tu primera máquina"
		    />
		    <div class="achievement-title">Tu primera máquina</div>
		    <div class="achievement-desc">
		      Completa tu primera máquina y comienza tu camino como hacker.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[escritor]</div>
		    <img
		      title="escritor"
		      src="<%= request.getContextPath() %>/img/badges/escritor.svg"
		      alt="Icono Ha escrito writeups"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/escritor.svg"
		      data-bs-imgalt="Icono Ha escrito writeups"
		    />
		    <div class="achievement-title">Ha escrito writeups</div>
		    <div class="achievement-desc">
		      Publica tu primer writeup para ayudar a la comunidad.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[writeups100]</div>
		    <img
		      title="writeups100"
		      src="<%= request.getContextPath() %>/img/badges/writeups100.svg"
		      alt="Icono 100 writeups"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/writeups100.svg"
		      data-bs-imgalt="Icono 100 writeups"
		    />
		    <div class="achievement-title">100 writeups</div>
		    <div class="achievement-desc">
		      Comparte tus conocimientos con 100 writeups publicados.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[solucionador]</div>
		    <img
		      title="solucionador"
		      src="<%= request.getContextPath() %>/img/badges/solucionador.svg"
		      alt="Icono Primer writeup"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/solucionador.svg"
		      data-bs-imgalt="Icono Primer writeup"
		    />
		    <div class="achievement-title">Primer writeup</div>
		    <div class="achievement-desc">
		      Publica tu primer writeup y marca la diferencia.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[firstroot]</div>
		    <img
		      title="firstroot"
		      src="<%= request.getContextPath() %>/img/badges/firstroot.svg"
		      alt="Icono Primera root flag"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/firstroot.svg"
		      data-bs-imgalt="Icono Primera root flag"
		    />
		    <div class="achievement-title">Primera root flag</div>
		    <div class="achievement-desc">
		      Consigue tu primera bandera root en cualquier máquina.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[firstuser]</div>
		    <img
		      title="firstuser"
		      src="<%= request.getContextPath() %>/img/badges/firstuser.svg"
		      alt="Icono Primera user flag"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/firstuser.svg"
		      data-bs-imgalt="Icono Primera user flag"
		    />
		    <div class="achievement-title">Primera user flag</div>
		    <div class="achievement-desc">
		      Consigue tu primera bandera user para demostrar tu habilidad.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[puntos100]</div>
		    <img
		      title="puntos100"
		      src="<%= request.getContextPath() %>/img/badges/puntos100.svg"
		      alt="Icono 100 puntos"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/puntos100.svg"
		      data-bs-imgalt="Icono 100 puntos"
		    />
		    <div class="achievement-title">100 puntos</div>
		    <div class="achievement-desc">
		      Acumula un total de 100 puntos en la plataforma.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[puntos1000]</div>
		    <img
		      title="puntos1000"
		      src="<%= request.getContextPath() %>/img/badges/puntos1000.svg"
		      alt="Icono 1000 puntos"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/puntos1000.svg"
		      data-bs-imgalt="Icono 1000 puntos"
		    />
		    <div class="achievement-title">1000 puntos</div>
		    <div class="achievement-desc">
		      Lleva tu puntuación más allá con 1000 puntos acumulados.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[puntos2000]</div>
		    <img
		      title="puntos2000"
		      src="<%= request.getContextPath() %>/img/badges/puntos2000.svg"
		      alt="Icono 2000 puntos"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/puntos2000.svg"
		      data-bs-imgalt="Icono 2000 puntos"
		    />
		    <div class="achievement-title">2000 puntos</div>
		    <div class="achievement-desc">
		      Alcanzar los 2000 puntos requiere constancia y dedicación.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[puntos3000]</div>
		    <img
		      title="puntos3000"
		      src="<%= request.getContextPath() %>/img/badges/puntos3000.svg"
		      alt="Icono 3000 puntos"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/puntos3000.svg"
		      data-bs-imgalt="Icono 3000 puntos"
		    />
		    <div class="achievement-title">3000 puntos</div>
		    <div class="achievement-desc">
		      Demuestra tu maestría alcanzando los 3000 puntos en la plataforma.
		    </div>
		  </div>
		
		  <div class="achievement-card" style="width: 48%;">
		    <div class="achievement-code">[estrellita]</div>
		    <img
		      title="puntos4000"
		      src="<%= request.getContextPath() %>/img/badges/estrellita.svg"
		      alt="Icono estrellita"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/estrellita.svg"
		      data-bs-imgalt="Icono estrellita"
		    />
		    <div class="achievement-title">Primera estrellita</div>
		    <div class="achievement-desc">
		      Da tu primera estrellita valorando una maquina y el trabajo del creador.
		    </div>
		  </div>
		  
		  <div class="achievement-card" style="width: 48%;">
			  <div class="achievement-code">[hacker]</div>
			  <img
			    title="hacker"
			    src="<%= request.getContextPath() %>/img/badges/hacker.svg"
			    alt="Icono hacker"
			    class="achievement-icon img-thumbnail"
			    style="cursor:pointer;"
			    data-bs-toggle="modal"
			    data-bs-target="#imageModal"
			    data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/hacker.svg"
			    data-bs-imgalt="Icono hacker"
			  />
			  <div class="achievement-title">¡Hacker!</div>
			  <div class="achievement-desc">
			    Has demostrado habilidades de hacker avanzadas.
			  </div>
			</div>
			
			<div class="achievement-card" style="width: 48%;">
			  <div class="achievement-code">[prohacker]</div>
			  <img
			    title="prohacker"
			    src="<%= request.getContextPath() %>/img/badges/prohacker.svg"
			    alt="Icono prohacker"
			    class="achievement-icon img-thumbnail"
			    style="cursor:pointer;"
			    data-bs-toggle="modal"
			    data-bs-target="#imageModal"
			    data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/prohacker.svg"
			    data-bs-imgalt="Icono prohacker"
			  />
			  <div class="achievement-title">¡Pro Hacker (500 máquinas)!</div>
			  <div class="achievement-desc">
			    Has hackeado más de 500 máquinas, ¡eres un Pro Hacker!
			  </div>
			</div>
			
			<div class="achievement-card" style="width: 48%;">
			  <div class="achievement-code">[aprendiz]</div>
			  <img
			    title="aprendiz"
			    src="<%= request.getContextPath() %>/img/badges/aprendiz.svg"
			    alt="Icono aprendiz"
			    class="achievement-icon img-thumbnail"
			    style="cursor:pointer;"
			    data-bs-toggle="modal"
			    data-bs-target="#imageModal"
			    data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/aprendiz.svg"
			    data-bs-imgalt="Icono aprendiz"
			  />
			  <div class="achievement-title">Aprendiz de Hacker</div>
			  <div class="achievement-desc">
			    Estás empezando tu camino en el mundo del hacking.
			  </div>
			</div>
			
			<div class="achievement-card" style="width: 48%;">
			  <div class="achievement-code">[0xcoffee]</div>
			  <img
			    title="0xcoffee"
			    src="<%= request.getContextPath() %>/img/badges/0xcoffee.svg"
			    alt="Icono 0xcoffee"
			    class="achievement-icon img-thumbnail"
			    style="cursor:pointer;"
			    data-bs-toggle="modal"
			    data-bs-target="#imageModal"
			    data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/0xcoffee.svg"
			    data-bs-imgalt="Icono 0xcoffee"
			  />
			  <div class="achievement-title">Amante del café 0xCoffee</div>
			  <div class="achievement-desc">
			    Porque el café es el mejor compañero para hackear.
			  </div>
			</div>
			
			<div class="achievement-card" style="width: 48%;">
			  <div class="achievement-code">[anonymous]</div>
			  <img
			    title="anonymous"
			    src="<%= request.getContextPath() %>/img/badges/anonymous.svg"
			    alt="Icono anonymous"
			    class="achievement-icon img-thumbnail"
			    style="cursor:pointer;"
			    data-bs-toggle="modal"
			    data-bs-target="#imageModal"
			    data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/anonymous.svg"
			    data-bs-imgalt="Icono anonymous"
			  />
			  <div class="achievement-title">Anonymous</div>
			  <div class="achievement-desc">
			    El espíritu libre e impredecible del hacking.
			  </div>
			</div>
			
			<div class="achievement-card" style="width: 48%;">
			  <div class="achievement-code">[FuckSystem]</div>
			  <img
			    title="FuckSystem"
			    src="<%= request.getContextPath() %>/img/badges/FuckSystem.svg"
			    alt="Icono FuckSystem"
			    class="achievement-icon img-thumbnail"
			    style="cursor:pointer;"
			    data-bs-toggle="modal"
			    data-bs-target="#imageModal"
			    data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/FuckSystem.svg"
			    data-bs-imgalt="Icono FuckSystem"
			  />
			  <div class="achievement-title">Fuck the System</div>
			  <div class="achievement-desc">
			    Desafías todas las reglas establecidas.
			  </div>
			</div>
			
			<div class="achievement-card" style="width: 48%;">
			  <div class="achievement-code">[god]</div>
			  <img
			    title="god"
			    src="<%= request.getContextPath() %>/img/badges/god.svg"
			    alt="Icono god"
			    class="achievement-icon img-thumbnail"
			    style="cursor:pointer;"
			    data-bs-toggle="modal"
			    data-bs-target="#imageModal"
			    data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/god.svg"
			    data-bs-imgalt="Icono god"
			  />
			  <div class="achievement-title">Dios del Hackeo</div>
			  <div class="achievement-desc">
			    Nivel máximo alcanzado en el mundo del hacking.
			  </div>
			</div>
		  
		</div>
		<br><br><br><br>
		<h2 id="logros-desbloqueados">LOGROS OBTENIDOS/DESBLOQUEADOS</h2>
		<br><br>
		<div id="badges-container" class="gadgets-achievements d-flex flex-wrap gap-3"></div>
		
		<br><br><br><br>
		<h2 id="recompensas">RECOMPENSAS POR LOGROS</h2>
		<br><br>
		
		<div id="reward-prohacker" class="reward-card">
		  <div class="reward-header">[ProHacker]</div>
		  <div class="reward-description">
		    La recompensa tras obtener el logro <strong>ProHacker</strong> es un aura luminosa roja alrededor de tu foto de perfil.
		  </div>
		  <img
		    id="avatar-prohacker"
		    src="<%= request.getContextPath() %>/imgProfile/default.png"
		    alt="Avatar ProHacker"
		    class="avatar-image"
		  />
		  <div id="prohacker-status" class="reward-status">Bloqueado</div>
		</div>
		
    </div>
    
    

	<script>
	const badgeNames = {
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
	
	async function loadUserBadges() {
	    try {
	        const res = await fetch('<%= request.getContextPath() %>/user-stats-badges');
	        if (!res.ok) throw new Error("Error al obtener badges");

	        const badges = await res.json();

	        const container = document.getElementById("reward-prohacker");
	        const avatar = document.getElementById("avatar-prohacker");
	        const statusText = document.getElementById("prohacker-status");

	        if (badges.prohacker === true) {
	            avatar.classList.add("prohacker-border");
	            avatar.style.opacity = "1";

	            container.classList.remove("prohacker-locked");
	            container.classList.add("prohacker-unlocked");

	            statusText.textContent = "Desbloqueado";
	            statusText.style.color = "#4a6600";  // verde-amarillo
	        } else {
	        	avatar.classList.add("prohacker-border");
	            avatar.style.opacity = "1";
	            
	            container.classList.add("prohacker-locked");

	            statusText.textContent = "Bloqueado";
	            statusText.style.color = "#666";
	        }



	        const containerBadges = document.getElementById("badges-container");
	        containerBadges.innerHTML = "";

	        for (const badge in badgeNames) {
	            const obtained = badges[badge] === true;

	            const div = document.createElement("div");
	            div.className = "gadget-achievement " + (obtained ? "obtained" : "locked");
	            div.innerHTML =
	                '<img src="<%= request.getContextPath() %>/img/badges/' + badge + '.svg" ' +
	                'alt="Logro ' + badge + '" ' +
	                'title="' + badgeNames[badge] + '" ' +
	                'class="gadget-icon" />' +
	                '<div class="gadget-title">' + badgeNames[badge] + '</div>' +
	                '<div class="gadget-status">' + (obtained ? "Logro obtenido" : "Bloqueado") + '</div>';

	            containerBadges.appendChild(div);
	        }

	    } catch (e) {
	        console.error(e);
	        document.getElementById("badges-container").innerHTML = "<p>Error cargando badges.</p>";
	    }
	}
	
	window.onload = loadUserBadges;
	</script>

	<script>
	  function scrollToSection(id) {
	    const section = document.getElementById(id);
	    if (section) {
	      section.scrollIntoView({ behavior: 'smooth' });
	    }
	  }
	</script>

    <!-- Modal Bootstrap para mostrar la imagen ampliada -->
	<div
	  class="modal fade"
	  id="imageModal"
	  tabindex="-1"
	  aria-labelledby="imageModalLabel"
	  aria-hidden="true"
	>
	  <div class="modal-dialog modal-dialog-centered modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="imageModalLabel">Imagen ampliada</h5>
	        <button
	          type="button"
	          class="btn-close"
	          data-bs-dismiss="modal"
	          aria-label="Cerrar"
	        ></button>
	      </div>
	      <div class="modal-body text-center">
	        <img src="" alt="" id="modalImage" class="img-fluid" />
	      </div>
	    </div>
	  </div>
	</div>
	
	<script>
	  const imageModal = document.getElementById("imageModal");
	  imageModal.addEventListener("show.bs.modal", (event) => {
	    const button = event.relatedTarget;
	    const imgSrc = button.getAttribute("data-bs-imgsrc");
	    const imgAlt = button.getAttribute("data-bs-imgalt") || "";
	    const modalImage = imageModal.querySelector("#modalImage");
	    const modalTitle = imageModal.querySelector(".modal-title");
	
	    modalImage.src = imgSrc;
	    modalImage.alt = imgAlt;
	    modalTitle.textContent = button.title || "Imagen ampliada";
	  });
	</script>
</body>
</html>
