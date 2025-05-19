/* SHOW CARD */
function showCard(name, os, difficulty, creator, release, id) {
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
				'<div style="display: flex; align-items: center;">' +
				'<button class="machineBtn" title="Ver más info" style="background:none; border:none; padding:0; cursor:pointer; margin-bottom:1rem; margin-right:10px;" aria-label="Ver más información" data-machine-id="' + id + '" onclick="showMachinePopup(\'' + id + '\')">' +
				    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 60 60">' +
				      '<circle cx="30" cy="30" r="28" fill="none" stroke="#00ff00" stroke-width="3" />' +
				      '<line x1="30" y1="18" x2="30" y2="42" stroke="#00ff00" stroke-width="4" stroke-linecap="round" />' +
				      '<line x1="18" y1="30" x2="42" y2="30" stroke="#00ff00" stroke-width="4" stroke-linecap="round" />' +
				    '</svg>' +
				  '</button>' +
					'<h1 class="card-title" style="font-size: clamp(1rem, 4vw, 1.5rem); max-width: calc(100vw - 120px); overflow: hidden; text-overflow: ellipsis;">' + name + '</h1>' +
				'</div>' +
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
	
	/* SUBMIT WRITEUP (SHOW/SUBMIT FORM) */

	document.getElementById('writeupForm').addEventListener('submit', function (e) {
	  e.preventDefault();

	  const form = e.target;
	  const formData = new FormData(form);
	  formData.append("vmName", form.dataset.vmname);

	  const contextPath = window.location.pathname.split("/")[1]; // e.g. 'pwn3d'
	  const url = `/${contextPath}/sendWriteup`;

	  fetch(url, {
	    method: 'POST',
	    body: new URLSearchParams(formData)
	  }).then(response => {
	    if (response.ok) {
	      mostrarPopup("✅ Writeup enviado correctamente.");
	      form.reset();
	    } else {
	      response.text().then(msg => {
	        console.error("[ERROR] Respuesta del servidor:", msg);
	        mostrarPopup("❌ Error al enviar el writeup.");
	      });
	    }
	  }).catch(error => {
	    console.error("[ERROR] Error en fetch:", error);
	    mostrarPopup("⚠️ Error de conexión.");
	  });
	});

	// 👉 Mueve esta función FUERA del event listener:
	function showWriteupForm(vmname) {
	  const modal = document.querySelector('.form-writeup');
	  modal.style.display = 'flex';
	  document.body.style.overflow = 'hidden';

	  modal.querySelector('.vb-title').textContent = `Enviar nuevo writeup para ${vmname}`;
	  document.getElementById('writeupForm').dataset.vmname = vmname;
	}
	
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
	        const regex = /showCard\('([^']*)',\s*'([^']*)',\s*'([^']*)',\s*'([^']*)',/;
	        const match = onclickAttr.match(regex);
	        if (match) {
	          nameText = match[1].toLowerCase();
	          difficulty = match[3].toLowerCase();
	          creator = match[4].toLowerCase();
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

	    // Mostrar mensaje si no hay resultados
	    const searchMessage = document.getElementById("search-message");
	    const querySpan = document.getElementById("query");

	    let visibleCount = 0;
	    tableRows.forEach(row => {
	      if (row.style.display !== "none") visibleCount++;
	    });

	    if (visibleCount === 0 && filter !== "") {
	      querySpan.textContent = this.value;
	      searchMessage.style.display = "block";
	    } else {
	      searchMessage.style.display = "none";
	    }
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
