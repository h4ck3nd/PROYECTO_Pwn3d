/* ELIMINAR CUENTA */

document.getElementById('deleteBtn').addEventListener('click', function () {
   Swal.fire({
       title: '¿Eliminar cuenta?',
       text: "Esta acción no se puede deshacer.",
       icon: 'warning',
       input: 'text',
       inputPlaceholder: 'Escribe "delete account" para confirmar',
       inputAttributes: {
           autocapitalize: 'off',
           autocorrect: 'off',
           spellcheck: 'false'
       },
       showCancelButton: true,
       confirmButtonColor: '#e55353',  // rojo vibrante pero elegante
       cancelButtonColor: '#6c757d',   // gris neutro para cancelar
       confirmButtonText: 'Sí, eliminar',
       cancelButtonText: 'Cancelar',
       background: '#1e1e2f',  // fondo oscuro azulado
       color: '#f8f9fa',       // texto claro
       customClass: {
           popup: 'swal2-dark-popup'
       },
       preConfirm: (inputValue) => {
           if (inputValue !== 'delete account') {
               Swal.showValidationMessage('La frase no coincide. Intenta de nuevo.');
           }
       }
   }).then((result) => {
       if (result.isConfirmed) {
           document.getElementById('deleteForm').submit();
       }
   });
});

/* SI NO COINCIDEN LAS CONTRASEÑAS */
 
document.getElementById('changePasswordForm').addEventListener('submit', function(e) {
  const passNueva = document.getElementById('passNueva').value.trim();
  const passConfirm = document.getElementById('passConfirm').value.trim();

  if (passNueva !== passConfirm) {
    e.preventDefault(); // detiene el envío

    CustomSwal.fire({
      icon: 'warning',
      title: 'Error',
      text: 'La nueva contraseña y su confirmación no coinciden.'
    });
  }
});

/* VALIDACION IMG */

 document.getElementById('avatarInput').addEventListener('change', function () {
     console.log("[DEBUG] Archivo seleccionado: ", this.files[0]);
     document.getElementById('avatarForm').submit();
 });
 
 /* MENU HAMBURGUESA */
 
 const hamburger = document.getElementById("hamburger");
 const closeBtn = document.getElementById("closeMenu");
 const sidebarWrapper = document.getElementById("sidebarWrapper");

 function openMenu() {
   sidebarWrapper.classList.remove("closed");
   sidebarWrapper.classList.add("open");
   hamburger.style.display = "none";     // Oculta el botón ☰
   closeBtn.style.display = "block";     // Muestra el botón ❌
 }

 function closeMenu() {
   sidebarWrapper.classList.remove("open");
   sidebarWrapper.classList.add("closed");
   hamburger.style.display = "block";    // Muestra el botón ☰
   closeBtn.style.display = "none";      // Oculta el botón ❌
 }

 // Eventos
 hamburger.addEventListener("click", openMenu);
 closeBtn.addEventListener("click", closeMenu);

 // inicializacion
 document.addEventListener("DOMContentLoaded", () => {
   openMenu(); // Mostramos el menú por defecto
 });