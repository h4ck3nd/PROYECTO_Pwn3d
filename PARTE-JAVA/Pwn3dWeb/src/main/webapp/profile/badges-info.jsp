<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Logros - Descripciones y Objetivos</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
    
    <!-- Incluye Bootstrap CSS y JS en tu proyecto -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        body {
            background-color: #2c2c3a;
            color: #cfcfcf;
            font-family: 'Press Start 2P', cursive;
            display: flex;
            justify-content: center;
            padding: 40px 20px;
            min-height: 100vh;
            margin: 0;
        }

        .container {
            max-width: 900px;
            width: 100%;
        }

        h2 {
            color: #7f5af0;
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2.5rem;
            text-shadow: 0 0 8px #9b59b6;
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
            font-family: 'Press Start 2P', cursive;
            display: block;
            margin: 0 auto 3rem auto;
            max-width: 150px;
        }

        .btn.exit:hover {
            background: linear-gradient(135deg, #9b59b6, #6e40e1);
            box-shadow: 0 6px 15px rgba(155, 89, 182, 0.8);
        }

        .btn.exit:active {
            background: #5b2dbd;
            box-shadow: 0 2px 5px rgba(91, 45, 189, 0.9);
        }

        .achievements-list {
		    display: grid;
		    grid-template-columns: 1fr 1fr; /* Dos columnas iguales */
		    gap: 1.8rem 2.5rem; /* Espacio vertical y horizontal */
		}
		
		@media (max-width: 700px) {
		    .achievements-list {
		        grid-template-columns: 1fr; /* En móvil 1 columna */
		    }
		}


        .achievement-title {
            color: #b48bf2;
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 0 0 6px #9b59b6cc;
        }

        .achievement-code {
            font-family: monospace;
            background: #7f5af066;
            border-radius: 5px;
            color: #d6caff;
            padding: 0.15rem 0.5rem;
            font-weight: 700;
            margin-bottom: 0.8rem;
            display: inline-block;
            letter-spacing: 0.1rem;
        }

        .achievement-desc {
            font-size: 0.9rem;
            line-height: 1.4;
            color: #dcd6f7;
            user-select: none;
        }
        .achievement-card {
		    position: relative; /* Para posicionar la imagen absolutamente dentro */
		    background: #3b3b56;
		    border-radius: 15px;
		    padding: 1.6rem 1.8rem;
		    box-shadow: 0 0 10px #7f5af0aa;
		    border: 2px solid #7f5af0;
		    transition: transform 0.3s ease, box-shadow 0.3s ease;
		    cursor: default;
		    overflow: visible; /* Para que la imagen pueda sobresalir */
		}
		
		.achievement-card:hover {
		    transform: scale(1.05);
		    box-shadow: 0 0 20px #9b59b6dd;
		}
		
		.achievement-icon {
		    position: absolute; /* Posición absoluta para colocarla en la esquina */
		    top: 0;
		    right: 0;
		    width: 50px; /* Tamaño base */
		    height: auto;
		    transform: translate(50%, -50%); /* Mueve la imagen medio fuera a la derecha y arriba */
		    max-width: 20vw; /* Responsive: no más del 20% del ancho viewport */
		    max-height: 20vh;
		    transition: width 0.3s ease; /* Para suavizar el cambio de tamaño */
		}
		
		/* Ajuste en pantallas pequeñas */
		@media (max-width: 600px) {
		    .achievement-icon {
		        width: 30px;
		        max-width: 30vw;
		        max-height: 15vh;
		    }
		}
		
		.img-thumbnail {
			background: transparent;
			border: none;
			z-index: 1000;
		}
		/* Fondo oscuro y morado para el modal */
	  #imageModal .modal-content {
	    background-color: #1a1a2e; /* oscuro azul-morado */
	    border-radius: 0.5rem;
	    border: 2px solid #6a0dad; /* morado */
	  }
	  /* Cabecera del modal */
	  #imageModal .modal-header {
	    background-color: #3c1361; /* morado oscuro */
	    border-bottom: 1px solid #6a0dad;
	  }
	  /* Título en color claro */
	  #imageModal .modal-title {
	    color: #d8b8ff; /* lavanda claro */
	    font-weight: 600;
	  }
	  /* Botón cerrar estilo claro para contraste */
	  #imageModal .btn-close {
	    filter: invert(100%) brightness(150%);
	  }
	  /* Modal body centrado y con padding */
	  #imageModal .modal-body {
	    padding: 2rem;
	  }
	  /* Imagen más grande dentro del modal */
	  #modalImage {
	    max-width: 100%; /* más ancho que el 100% habitual */
	    max-height: 90vh; /* que no sobresalga mucho verticalmente */
	    border-radius: 0.5rem;
	  }
	  /* Fondo oscuro del backdrop (opcional para más contraste) */
	  .modal-backdrop.show {
	    background-color: rgba(26, 26, 46, 0.85);
	  }
    </style>
</head>
<body>
    <div class="container">
        <h2>Logros y Cómo Conseguirlos</h2>

        <button onclick="window.location.href='<%= request.getContextPath() %>/stats'" class="btn exit">
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
		    <div class="achievement-code">[puntos4000]</div>
		    <img
		      title="puntos4000"
		      src="<%= request.getContextPath() %>/img/badges/puntos4000.svg"
		      alt="Icono 4000 puntos"
		      class="achievement-icon img-thumbnail"
		      style="cursor:pointer;"
		      data-bs-toggle="modal"
		      data-bs-target="#imageModal"
		      data-bs-imgsrc="<%= request.getContextPath() %>/img/badges/puntos4000.svg"
		      data-bs-imgalt="Icono 4000 puntos"
		    />
		    <div class="achievement-title">4000 puntos</div>
		    <div class="achievement-desc">
		      Lleva tu progreso al máximo con 4000 puntos acumulados.
		    </div>
		  </div>
		</div>
    </div>
    
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
