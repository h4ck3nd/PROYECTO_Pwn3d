/* SHOW CARD */
	function showCard(name, os, difficulty, creator, release) {
	    Swal.fire({
	        background: '#141414',
	        width: '36rem',
	        customClass: 'swal2-border',
	        padding: '3rem 0',
	        html: 
	        '<article class="card-container">' +
	            '<div class="logo-wrapper">' +
	                '<img id="card-logo" src="img/card.png" alt="VulNyx Logo" width="250" height="250">' +
	            '</div>' +
	            '<div class="card-info">' +
	                '<h1 class="card-title">' + name + '</h1>' +
	                '<div class="card-body-wrapper">' +
	                    '<table class="card-body">' +
	                        '<tbody>' +
	                            '<tr>' +
	                                '<td class="card-os">' +
	                                    '<span class="card-text">OS:</span>' +
	                                    '<span class="card-icon-wrapper">' +
	                                        '<img id="' + os + '" src="img/' + os + '.svg" alt="' + os + '">' +
	                                    '</span>' +
	                                    os +
	                                '</td>' +
	                            '</tr>' +
	                            '<tr>' +
	                                '<td class="card-creator">' +
	                                    '<span class="card-text">Creador: </span>' +
	                                    '<span>' + creator + '</span>' +
	                                '</td>' +
	                            '</tr>' +
	                            '<tr>' +
	                                '<td class="card-difficulty">' +
	                                    '<span class="card-text">Dificultad:</span>' +
	                                    '<div class="card-difficulty-text vm-name-btn level-btn ' + difficulty.toLowerCase() + '">' +
	                                        '<span class="' + difficulty.toLowerCase() + '-dots"></span>' +
	                                        '<span class="vm-name">' + difficulty + '</span>' +
	                                    '</div>' +
	                                '</td>' +
	                            '</tr>' +
	                            '<tr>' +
	                                '<td class="card-release">' +
	                                    '<span class="card-text">Lanzamiento:</span> ' + release +
	                                '</td>' +
	                            '</tr>' +
	                        '</tbody>' +
	                    '</table>' +
	                '</div>' +
	            '</div>' +
	        '</article>',
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
        document.querySelector('body').style.overflow = 'hidden';
        let modal = document.getElementById(name);
        let title = modal.querySelector('.writeup-title');
        title.textContent = "Writeups para " + name;
        let writeupsContainer = modal.querySelector('.writeups-container');
        let span = modal.querySelector('.close');
        modal.style.display = 'block';

        span.onclick = function() {
            modal.style.display = 'none';
            document.querySelector('body').style.overflow = 'visible';
        }

        if (writeupsContainer.childElementCount === 0) {
            let output = writeupsArr.filter(el => el.name === name);
            output.forEach(el => {
                let link = document.createElement('a');
                link.id = "writeup";
                link.href = el.url;
                link.target = '_blank';
                link.textContent = "by " + el.creator;
                writeupsContainer.appendChild(link);
            });
        }
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
        const title = document.querySelector('.submit-flag');
        const modal = document.querySelector('.form-flag');
        const span = modal.querySelector('.close-form');

        if (body && title && modal && span) {
            body.style.overflow = 'hidden';
            title.textContent = `Primera ${type} flag enviada por ${vmname}`;
            modal.style.display = 'block';

            span.onclick = function() {
                modal.style.display = 'none';
                body.style.overflow = 'visible';
            };
        } else {
            console.error('Error: uno o varios elementos no encontrados.');
        }
    }
