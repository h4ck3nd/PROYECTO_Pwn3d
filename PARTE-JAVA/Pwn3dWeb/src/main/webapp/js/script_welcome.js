/* LOGICA IMAGEN AUMENTADA */
    
  	// Cargar imagen al modal
    document.querySelectorAll('.screenshot').forEach(img => {
      img.addEventListener('click', () => {
        const src = img.getAttribute('data-bs-img');
        document.getElementById('modalImage').src = src;
      });
    });
  	
  	/* LOGICA PALABRA ESCRIBIENDOSE */
  	
  	document.addEventListener("DOMContentLoaded", () => {
	    const elements = document.querySelectorAll(".typewriter-text");
	
	    elements.forEach(el => {
	      const fullText = el.textContent;
	      el.textContent = ""; // Limpia el contenido inicial
	
	      let i = 0;
	      function type() {
	        if (i < fullText.length) {
	          el.textContent += fullText.charAt(i);
	          i++;
	          setTimeout(type, 80);
	        }
	      }
	
	      type();
	    });
	  });