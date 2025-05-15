/* SHOW CARD */
function showCard(name, os, difficulty, creator, release) {
    Swal.fire({
        background: '#1e1e1e',
        width: '45rem',
        customClass: 'swal2-border',
        padding: '2.5rem',
        html:
            '<div class="card-container">' +
                '<div class="logo-section">' +
                    '<img src="img/card1.png" alt="VulNyx Logo" class="card-logo">' +
                '</div>' +
                '<div class="info-section">' +
                    '<h1 class="card-title">' + name + '</h1>' +
                    '<div class="card-details">' +
                        '<div class="info-item">' +
                            '<div class="info-label">OS:</div>' +
                            '<div class="info-content">' +
                                '<img src="img/' + os + '.svg" alt="' + os + '" class="os-icon">' +
                                '<span style="margin-bottom: -3px !important;">' + os + '</span>' +
                            '</div>' +
                        '</div>' +
                        '<div class="info-item">' +
                            '<div class="info-label">Creador:</div>' +
                            '<div class="info-content" style="font-size: 1.1rem !important;">' + creator + '</div>' +
                        '</div>' +
                        '<div class="info-item difficulty-item">' +
                            '<div class="info-label">Dificultad:</div>' +
                            '<div class="difficulty-level ' + difficulty.toLowerCase() + '" style="margin-left: 10px !important;">' +
                                '<span class="' + difficulty.toLowerCase() + '-card"> </span>' +
                                '<span style="font-size: 0.7rem; font-weight: bold; white-space: nowrap;"> ' + difficulty + '</span>' +
                            '</div>' +
                        '</div>' +
                        '<div class="info-item">' +
                            '<div class="info-label">Lanzamiento:</div>' +
                            '<div class="info-content" id="date-card">' + release + '</div>' +
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
	  const popup = document.getElementById("filterPopup");
	  if (popup) {
	    popup.style.display = "flex";
	  }
	}

	function applyFilters() {
	  const difficultyFilters = ['very-easy', 'easy', 'medium', 'hard'];
	  const osFilters = ['linux', 'windows'];
	  const sizeSort = document.getElementById('sizeSort').value;

	  const activeDifficulties = difficultyFilters.filter(id => document.getElementById(id).checked);
	  const activeOS = osFilters.filter(id => document.getElementById(id).checked);

	  const table = document.getElementById('vm-table');
	  const rows = Array.from(table.getElementsByTagName('tr')).slice(1); // Ignorar encabezado

	  let filteredRows = rows.filter(row => {
	    const vmCell = row.querySelector('.vm-name-btn');
	    const osImg = row.querySelector('.vm-name-btn img');

	    const difficultyMatch = activeDifficulties.length === 0 ||
	      activeDifficulties.some(d => vmCell.classList.contains(d));

	    const osMatch = activeOS.length === 0 ||
	      (osImg && osImg.title && activeOS.some(os => osImg.title.toLowerCase().includes(os)));

	    return difficultyMatch && osMatch;
	  });

	  if (sizeSort) {
	    filteredRows.sort((a, b) => {
	      const sizeA = getSizeInMB(a.querySelector('.vm-size')?.textContent);
	      const sizeB = getSizeInMB(b.querySelector('.vm-size')?.textContent);
	      return sizeSort === 'asc' ? sizeA - sizeB : sizeB - sizeA;
	    });
	  }

	  rows.forEach(row => row.style.display = 'none'); // Ocultar todos
	  filteredRows.forEach(row => {
	    table.appendChild(row); // Reordenar y mostrar
	    row.style.display = '';
	  });

	  closeFilterPopup();
	}
	function closeFilterPopup() {
	  const popup = document.getElementById("filterPopup");
	  if (popup) {
	    popup.style.display = "none";
	  }
	}


	function getSizeInMB(sizeText) {
	  if (!sizeText) return 0;
	  const size = sizeText.trim().toUpperCase();
	  if (size.endsWith("GB")) return parseFloat(size) * 1024;
	  if (size.endsWith("MB")) return parseFloat(size);
	  return 0;
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

	const showWriteupForm = (vmname) => {
	  const modal = document.querySelector('.form-writeup');
	  const body = document.body;

	  if (!modal) {
	    console.error("No se encontró el formulario .form-writeup");
	    return;
	  }

	  // Mostrar modal y desactivar scroll
	  modal.style.display = 'flex';
	  body.style.overflow = 'hidden';

	  // Cambiar el título dinámicamente
	  const title = modal.querySelector('.vb-title');
	  if (title) {
	    title.textContent = `Enviar nuevo writeup para ${vmname}`;
	  }

	  // Cerrar al hacer clic en la X
	  const closeBtn = modal.querySelector('.vb-close');
	  const closeModal = () => {
	    modal.style.display = 'none';
	    body.style.overflow = 'visible';
	  };
	  if (closeBtn) closeBtn.onclick = closeModal;

	  // Cerrar al hacer clic fuera del contenedor del modal
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
	  const span = modal.querySelector('.close-form-flag');
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
	
	/* SEARCH LOGIC */
	
	document.addEventListener("DOMContentLoaded", function () {
	    const searchInput = document.getElementById("vm-search");
	    const tableRows = document.querySelectorAll("#vm-table tbody .row");

	    searchInput.addEventListener("input", function () {
	        const filter = this.value.toLowerCase().trim();

	        tableRows.forEach(row => {
	            const vmNameCell = row.querySelector(".vm-name");
	            const button = row.querySelector(".card-btn");
	            let nameText = "", difficulty = "", creator = "";

	            if (vmNameCell) {
	                nameText = vmNameCell.textContent.toLowerCase();
	            }

	            if (button) {
	                const onclickAttr = button.getAttribute("onclick");
	                const regex = /showCard\('([^']*)',\s*'[^']*',\s*'([^']*)',\s*'([^']*)',\s*'[^']*'\)/;
	                const match = onclickAttr.match(regex);
	                if (match) {
	                    // match[1] = name, match[2] = difficulty, match[3] = creator
	                    nameText = match[1].toLowerCase();
	                    difficulty = match[2].toLowerCase();
	                    creator = match[3].toLowerCase();
	                }
	            }

	            if (
	                nameText.includes(filter) ||
	                difficulty.includes(filter) ||
	                creator.includes(filter)
	            ) {
	                row.style.display = "";
	            } else {
	                row.style.display = "none";
	            }
	        });
	    });
	});

	function clearSearch() {
	    const searchInput = document.getElementById("vm-search");
	    searchInput.value = "";
	    searchInput.dispatchEvent(new Event('input'));
	}

	
	/* ESCRITURA DE TEXTO */
	
	document.addEventListener('DOMContentLoaded', () => {
	  const titleEl = document.querySelector('.pwned-title');
	  const text = 'PWNED!';
	  let index = 0;

	  function type() {
	    if (index <= text.length) {
	      titleEl.innerHTML = text.slice(0, index) + '<span class="cursor">_</span>';
	      index++;
	      setTimeout(type, 150);
	    } else {
	      // Mantener el texto completo con cursor parpadeando
	      titleEl.innerHTML = text + '<span class="cursor">_</span>';
	    }
	  }

	  type();
	});
