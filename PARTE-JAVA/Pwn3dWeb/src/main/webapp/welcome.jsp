<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Bienvenido | Pwn3d!</title>
  <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssWelcome.jsp">
</head>
<body>

  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg fixed-top">
    <div class="container-fluid">
      <a class="navbar-brand text-light" href="#">
		  <span class="typewriter-text">Pwn3d!</span><span class="cursor">_</span>
		</a>
      <div>
        <a href="#intro" class="nav-link d-inline">Inicio</a>
        <a href="#que-es" class="nav-link d-inline">¿Qué es?</a>
        <a href="#funciona" class="nav-link d-inline">Cómo funciona</a>
        <a href="#registro" class="nav-link d-inline">Comenzar</a>
      </div>
    </div>
  </nav>

  <!-- Hero Intro -->
  <section class="hero" id="intro">
    <h1>¡Bienvenido a Pwn3d!</h1>
    <p class="mt-4">Tu plataforma de <span style="color: #d35eff;">hacking ético</span> y retos estilo <strong>CTF</strong>.</p>
    <p>Descubre, aprende y entrena tus habilidades como profesional de ciberseguridad.</p>
    <a href="#registro" class="btn btn-purple mt-4">¡Empezar!</a>
  </section>

  <!-- ¿Qué es el Hacking Ético y CTF? -->
  <section id="que-es" class="container section text-center">
  	<h2>
	  <span class="typewriter-text">¿Qué es el Hacking Ético?</span><span class="cursor">_</span>
	</h2>
    <p class="mt-3">El hacking ético es el uso legal de técnicas de hacking para evaluar y asegurar sistemas. Se utiliza en pruebas de penetración para proteger empresas de ciberataques reales.</p>
	<br>
	<h2>
	  <span class="typewriter-text">¿Qué es un CTF?</span><span class="cursor">_</span>
	</h2>
    <p class="mt-3">"Capture The Flag" es una modalidad de entrenamiento gamificado en ciberseguridad donde el objetivo es encontrar "banderas" escondidas en entornos simulados.</p>
    <p>Perfecto tanto para principiantes como para expertos que quieren mejorar su lógica, creatividad y conocimiento técnico.</p>
  </section>

  <!-- ¿Cómo funciona? -->
  <section id="funciona" class="container section text-center">
  	<h2>
	  <span class="typewriter-text">¿Cómo funciona Pwn3d!?</span><span class="cursor">_</span>
	</h2>
    <p class="mt-3 mb-5">Una vez registrado, tendrás acceso total a la plataforma. ¡Empieza a hackear sin riesgos y de forma legal!</p>

    <div class="row text-center">
      <div class="col-md-4 mb-4">
        <div class="card card-dark p-4">
          <i class="fas fa-user-gear"></i>
          <h4 class="mt-3">Personaliza tu perfil</h4>
          <p>Haz que tu presencia destaque en la comunidad. Añade bio, redes y foto de perfil estilo hacker retro.</p>
        </div>
      </div>
      <div class="col-md-4 mb-4">
        <div class="card card-dark p-4">
          <i class="fas fa-flag-checkered"></i>
          <h4 class="mt-3">Completa retos CTF</h4>
          <p>Accede a máquinas virtuales vulnerables, resuelve desafíos prácticos y captura banderas ocultas (flags).</p>
        </div>
      </div>
      <div class="col-md-4 mb-4">
        <div class="card card-dark p-4">
          <i class="fas fa-trophy"></i>
          <h4 class="mt-3">Sube en el ranking</h4>
          <p>Compite con otros usuarios, gana puntos, desbloquea logros y demuestra tu progreso como hacker ético.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- Capturas -->
  <section class="container section text-center">
  	<h2>
	  <span class="typewriter-text">Capturas de la plataforma</span><span class="cursor">_</span>
	</h2>
    <div class="row mt-4">
      <div class="col-md-6">
        <img src="<%= request.getContextPath() %>/img/imgWelcome/machines.png" alt="Machines" class="screenshot" data-bs-toggle="modal" data-bs-target="#imgModal" data-bs-img="<%= request.getContextPath() %>/img/imgWelcome/machines.png">
      	<img src="<%= request.getContextPath() %>/img/imgWelcome/infoMachine.png" alt="infoMachine" class="screenshot" data-bs-toggle="modal" data-bs-target="#imgModal" data-bs-img="<%= request.getContextPath() %>/img/imgWelcome/infoMachine.png">
      	<img src="<%= request.getContextPath() %>/img/imgWelcome/detailsMachine.png" alt="detailsMachine" class="screenshot" data-bs-toggle="modal" data-bs-target="#imgModal" data-bs-img="<%= request.getContextPath() %>/img/imgWelcome/detailsMachine.png">
      </div>
      <div class="col-md-6">
        <img src="<%= request.getContextPath() %>/img/imgWelcome/profile.png" alt="Perfil" class="screenshot" data-bs-toggle="modal" data-bs-target="#imgModal" data-bs-img="<%= request.getContextPath() %>/img/imgWelcome/profile.png">
      	<img src="<%= request.getContextPath() %>/img/imgWelcome/filter.png" alt="filter" class="screenshot" data-bs-toggle="modal" data-bs-target="#imgModal" data-bs-img="<%= request.getContextPath() %>/img/imgWelcome/filter.png">
      </div>
    </div>
  </section>

  <!-- Registro -->
  <section id="registro" class="container section text-center">
  	<h2>
	  <span class="typewriter-text">¿Listo para comenzar?</span><span class="cursor">_</span>
	</h2>
    <p class="mt-3">Regístrate gratuitamente y accede al contenido exclusivo, retos únicos y un entorno gamificado para aprender hacking de forma divertida y legal.</p>
    <a href="<%= request.getContextPath() %>/login-register/register.jsp" class="btn btn-purple mt-3 me-2">Registrarse</a>
    <a href="<%= request.getContextPath() %>/login-register/login.jsp" class="btn btn-outline-light mt-3">Iniciar sesión</a>
  </section>

  <!-- Footer -->
  <footer>
    <p>&copy; 2025 Pwn3d! · Hecho por entusiastas del hacking. Respeta la ley, aprende, mejora.</p>
  </footer>

  <!-- Modal para imágenes ampliadas -->
  <div class="modal fade" id="imgModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl">
      <div class="modal-content bg-dark border border-purple">
        <div class="modal-body text-center">
          <img id="modalImage" src="" class="img-fluid rounded" alt="Imagen ampliada">
        </div>
      </div>
    </div>
  </div>
  <script src="<%= request.getContextPath() %>/js/jsWelcome.jsp"></script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
