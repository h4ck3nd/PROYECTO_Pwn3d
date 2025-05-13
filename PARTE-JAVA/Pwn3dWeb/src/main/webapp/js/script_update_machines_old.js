/* SHOW CARD */
function showCard(name, os, difficulty, creator, release) {
    Swal.fire({
        background: '#1e1e1e',
        width: '38rem',
        customClass: 'swal2-border',
        padding: '2.5rem',
        html:
        '<div class="card-container">' +
            '<div class="logo-section">' +
                '<img id="card-logo" src="img/card1.png" alt="VulNyx Logo" width="250" height="250">' +
            '</div>' +
            '<div class="info-section">' +
                '<h1 class="card-title">' + name + '</h1>' +
                '<div class="card-details">' +
                    '<div class="info-item">' +
                        '<div class="info-label">OS:</div>' +
                        '<div class="info-content">' +
                            '<img src="img/' + os + '.svg" alt="' + os + '" class="os-icon">' +
                            '<span>' + os + '</span>' +
                        '</div>' +
                    '</div>' +
                    '<div class="info-item">' +
                        '<div class="info-label">Creador:</div>' +
                        '<div class="info-content">' + creator + '</div>' +
                    '</div>' +
                    '<div class="info-item difficulty-item">' +
                        '<div class="info-label">Dificultad:</div>' +
                        '<div class="difficulty-level ' + difficulty.toLowerCase() + '">' +
                            '<span class="' + difficulty.toLowerCase() + '-card"> </span>' +
                            '<span style="font-size: 0.9rem; font-weight: bold;"> ' + difficulty + '</span>' +
                        '</div>' +
                    '</div>' +
                    '<div class="info-item">' +
                        '<div class="info-label">Lanzamiento:</div>' +
                        '<div class="info-content">' + release + '</div>' +
                    '</div>' +
                '</div>' +
            '</div>' +
        '</div>',
        showConfirmButton: false,
        showCloseButton: true
    });
}


    /* COPY MD5 */
    function copyToClipboard(button) {
        const md5HashElement = button.previousElementSibling;
        const md5Hash = md5HashElement.getAttribute('title');
        navigator.clipboard.writeText(md5Hash);

        const tooltip = button.nextElementSibling;
        tooltip.style.visibility = 'visible';
        tooltip.style.opacity = '1';
        setTimeout(() => {
            tooltip.style.visibility = 'hidden';
            tooltip.style.opacity = '0';
        }, 2000);
    }

    /* FILTER TABLE */
	function openFilterPopup() {
	  document.getElementById("filterPopup").style.display = "flex";
	}

	function closeFilterPopup() {
	  document.getElementById("filterPopup").style.display = "none";
	}

	function applyFilters() {
	  const difficultyFilters = ['very-easy', 'easy', 'medium', 'hard'];
	  const osFilters = ['linux', 'windows'];

	  const activeDifficulties = difficultyFilters.filter(id => document.getElementById(id).checked);
	  const activeOS = osFilters.filter(id => document.getElementById(id).checked);

	  const rows = document.getElementById('vm-table').getElementsByTagName('tr');

	  for (let i = 1; i < rows.length; i++) {
	    const row = rows[i];
	    const vmCell = row.querySelector('.vm-name-btn');
	    const osImg = row.querySelector('.vm-name-btn img');

	    const difficultyMatch = activeDifficulties.length === 0 ||
	      activeDifficulties.some(d => vmCell.classList.contains(d));

	    const osMatch = activeOS.length === 0 ||
	      (osImg && osImg.title && activeOS.some(os => osImg.title.toLowerCase().includes(os)));

	    row.style.display = (difficultyMatch && osMatch) ? '' : 'none';
	  }

	  closeFilterPopup(); // Cerrar después de aplicar
	}

	
	/* SUBMIT VM (SHOW FORM) */
	const showVMForm = () => {
	  const modal = document.querySelector('.form-vm');
	  const body = document.body;

	  modal.style.display = 'flex';
	  body.style.overflow = 'hidden';

	  const span = modal.querySelector('.close-form');
	  const closeModal = () => {
	    modal.style.display = 'none';
	    body.style.overflow = 'visible';
	  };

	  span.onclick = closeModal;

	  // Cierra si se hace clic fuera del contenido
	  const handleClickOutside = (e) => {
	    if (e.target === modal) {
	      closeModal();
	      window.removeEventListener('click', handleClickOutside);
	    }
	  };

	  window.addEventListener('click', handleClickOutside);
	};
    
    /* SHOW WRITEUPS */
	
	function showWriteups(name) {
	    const modal = document.getElementById(name);
	    const title = modal.querySelector('.writeup-title');
	    const writeupsContainer = modal.querySelector('.writeups-container');
	    const closeBtn = modal.querySelector('.close');

	    // Bloquear scroll de fondo
	    document.body.style.overflow = 'hidden';

	    // Establecer título
	    title.textContent = "Writeups para " + name;

	    // Limpiar writeups anteriores si los hay
	    writeupsContainer.innerHTML = '';

	    // Obtener writeups relacionados
	    const filteredWriteups = writeupsArr.filter(el => el.name === name);

	    if (filteredWriteups.length === 0) {
	        const noResult = document.createElement('p');
	        noResult.textContent = "No hay writeups disponibles para esta máquina.";
	        noResult.style.color = "#bbb";
	        noResult.style.textAlign = "center";
	        writeupsContainer.appendChild(noResult);
	    } else {
	        filteredWriteups.forEach(el => {
	            const link = document.createElement('a');
	            link.href = el.url;
	            link.target = '_blank';
	            link.textContent = `by ${el.creator}`;
	            writeupsContainer.appendChild(link);
	        });
	    }

	    // Mostrar modal
	    modal.style.display = 'flex';

	    // Cerrar modal al hacer clic en el botón de cierre
	    closeBtn.onclick = () => {
	        modal.style.display = 'none';
	        document.body.style.overflow = 'visible';
	    };

	    // Cerrar modal al hacer clic fuera del contenido
	    window.onclick = (e) => {
	        if (e.target === modal) {
	            modal.style.display = 'none';
	            document.body.style.overflow = 'visible';
	        }
	    };
	}

	/* SUBMIT WRITEUP (SHOW FORM) */
	const showWriteupForm = (name) => {
	  const modal = document.querySelector('.form-writeup');
	  const body = document.body;

	  // Mostrar el modal y desactivar el desplazamiento de la página
	  modal.style.display = 'flex';
	  body.style.overflow = 'hidden';

	  // Cambiar el título dinámicamente
	  const title = modal.querySelector('h1');
	  title.textContent = "Nuevo envío de writeup para " + name;

	  // Función para cerrar el modal
	  const span = modal.querySelector('.close-form');
	  const closeModal = () => {
	    modal.style.display = 'none';
	    body.style.overflow = 'visible';
	  };

	  // Cerrar al hacer clic en el botón de cierre
	  span.onclick = closeModal;

	  // Cerrar al hacer clic fuera del contenido del modal
	  const handleClickOutside = (e) => {
	    if (e.target === modal) {
	      closeModal();
	      window.removeEventListener('click', handleClickOutside);
	    }
	  };

	  window.addEventListener('click', handleClickOutside);
	};
 	
	/* SUBMIT FLAGS (SHOW FORM) */
	const showFlagForm = (type, vmname) => {
	  const body = document.querySelector('body');
	  const modal = document.querySelector('.form-flag');
	  const span = modal.querySelector('.close-form');
	  const title = modal.querySelector('.form-title h1');

	  if (body && modal && span && title) {
	    body.style.overflow = 'hidden';
	    title.textContent = `🏴 Enviar ${type} flag para ${vmname}`;
	    modal.style.display = 'flex'; // ← esto centra el modal con flexbox
	    span.onclick = function () {
	      modal.style.display = 'none';
	      body.style.overflow = 'visible';
	    };
	  } else {
	    console.error('Error: uno o varios elementos no encontrados.');
	  }
	};
