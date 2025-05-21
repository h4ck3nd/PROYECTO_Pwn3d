<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String nuevoCodigoSeguro = (String) session.getAttribute("nuevoCodigoSeguro");
    String usuario = (String) session.getAttribute("usuario");
    String mensajeExito = (String) session.getAttribute("ResetPasswordExit");

    // Limpiar sesión para que no se repita
    session.removeAttribute("nuevoCodigoSeguro");
    session.removeAttribute("usuario");
    session.removeAttribute("ResetPasswordExit");
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
  <title>Pwned! - Login</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cssLogin.jsp">
  <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
</head>
<body>
  <div class="container">
    <div class="left-panel">
      <div class="left-content">
        <div class="page-title">Pwned!</div>
        <div class="image-box">
          <img src="<%= request.getContextPath() %>/img/monitor.png" alt="Login CTF">
          <div class="matrix-container">
            <canvas id="matrixCanvasText"></canvas>
          </div>
        </div>
        <br><br>
        <div class="page-title"><a href="<%= request.getContextPath() %>/welcome.jsp"
		   style="display: inline-block;
		          padding: 0.4rem 1rem;
		          font-size: 0.65rem;
		          font-family: 'Press Start 2P', monospace;
		          text-decoration: none;
		          color: #d35eff;
		          background-color: #1a001f;
		          border: 1px solid #d35eff;
		          border-radius: 4px;
		          box-shadow: 0 0 6px #d35eff55;
		          transition: all 0.2s ease-in-out;">
		   ← Volver al inicio
		   </a></div>
      </div>
    </div>
	
	<!-- Imagen grande entre paneles -->
  <div class="middle-image" style="flex: 0 0 auto; display: flex; justify-content: center; align-items: center; padding: 0 10px;">
    <img src="<%= request.getContextPath() %>/img/logo-flag-white.png" alt="Imagen Grande" style="max-width: 300%; max-height: 400px; object-fit: contain;" />
  </div>
	
    <div class="right-panel">
	  <div class="login-container">
	    <h1>LOGIN</h1>
	    <form method="post" action="<%= request.getContextPath() %>/login">
	      <label for="username">USUARIO</label>
	      <input type="text" id="username" name="username" placeholder="username" required />
	
	      <label for="password">CONTRASEÑA</label>
	      <input type="password" id="password" name="password" placeholder="********" required />
	
	      <input type="submit" value="LOGIN" style="font-family: 'Press Start 2P', monospace;" />
	    </form>
	    <br>
		<!-- Enlace para abrir el popup -->
		<a href="#" class="btn-register-small" onclick="document.getElementById('popup').style.display='flex'; return false;">
		  ¿Has olvidado tu contraseña?
		</a>
		
		<!-- Popup -->
		<div id="popup" style="
		  display: none;
		  position: fixed;
		  top: 0; left: 0; right: 0; bottom: 0;
		  background: rgba(20, 0, 40, 0.9); /* Fondo oscuro con toque morado */
		  justify-content: center;
		  align-items: center;
		  z-index: 9999;
		  font-family: 'Press Start 2P', monospace;
		">
		
		  <div style="
		    background-color: #3a1f4d; /* Morado oscuro */
		    padding: 2rem;
		    border: 3px solid #9a70b3; /* Borde morado claro */
		    border-radius: 4px;
		    width: 460px;
		    max-width: 90%;
		    color: #d9c6ff; /* Texto lila suave */
		  ">
		  
		    <h3 style="text-align: center; font-size: 0.75rem; margin-bottom: 1.5rem; color: #bd00f0;">
		      🔐 Restablecer Contraseña
		    </h3>
		
		    <form method="post" action="<%= request.getContextPath() %>/reset-password" style="display: flex; flex-direction: column;">
		      <label for="code" class="label-secure">Código seguro:</label>
				<input type="text" name="code" id="code" required placeholder="Introduce tu código" class="input-secure" />
				
				<label for="new-password" class="label-secure">Nueva contraseña:</label>
				<input type="password" name="new-password" id="new-password" required placeholder="Nueva contraseña" class="input-secure" />
				
				<div class="btn-group">
				  <input type="submit" value="Restablecer" class="btn-submit" />
				  <button type="button" onclick="document.getElementById('popup').style.display='none';" class="btn-cancel">
				    Cancelar
				  </button>
				</div>
		    </form>
		
		  </div>
		</div>

	    <div class="footer">PRESIONA LOGIN PARA INGRESAR</div>
	    
	    <h2><%= mensajeExito != null ? mensajeExito : "" %></h2>
	    
	    <% if (nuevoCodigoSeguro != null && usuario != null) { %>
		    <script>
		        const codigoSeguro = "<%= nuevoCodigoSeguro %>";
		        const usuario = "<%= usuario %>";
		        const contenido = "Tu nuevo código seguro para recuperar la contraseña:\n" + codigoSeguro;
		
		        const blob = new Blob([contenido], { type: "text/plain" });
		        const url = URL.createObjectURL(blob);
		
		        const a = document.createElement("a");
		        a.href = url;
		        a.download = usuario + "_codigo_seguro.txt";
		        document.body.appendChild(a);
		        a.click();
		
		        setTimeout(() => {
		            URL.revokeObjectURL(url);
		            document.body.removeChild(a);
		            // Redirigir al login o página que quieras después
		            window.location.href = "login.jsp";
		        }, 3000);
		    </script>
		    <% } %>
	    
	    <!-- MENSAJE DE ERROR MEDIANTE EL CONTROLADOR CODIGO DE SEGURIDAD ERRONEO -->
	    
	    <%
		    String loginCodeError = (String) session.getAttribute("loginCodeError");
		    if (loginCodeError != null) {
		%>	
			<br>
		    <div style="color: red; font-weight: bold; font-size: 0.8rem;">
		        <%= loginCodeError %>
		    </div>
		<%
		        session.removeAttribute("loginCodeError"); // Elimina el mensaje después de mostrarlo
		    }
		%>
	    
	    <!-- MENSAJE DE ERROR MEDIANTE EL CONTROLADOR DEL SECURITY (TOKEN ERROR) -->
	    
	    <%
		    String tokenError = (String) session.getAttribute("tokenError");
		    if (tokenError != null) {
		%>	
			<br>
		    <div style="color: red; font-weight: bold; font-size: 0.8rem;">
		        <%= tokenError %>
		    </div>
		<%
		        session.removeAttribute("tokenError"); // Elimina el mensaje después de mostrarlo
		    }
		%>
	    
	    <!-- MENSAJE DE EXITO MEDIANTE EL CONTROLADOR DE ELIMINAR CUENTA -->
	    
	    <%
		    String deleteExit = (String) session.getAttribute("deleteExit");
		    if (deleteExit != null) {
		%>	
			<br>
		    <div style="color: green; font-weight: bold; font-size: 0.8rem;">
		        <%= deleteExit %>
		    </div>
		<%
		        session.removeAttribute("deleteExit"); // Elimina el mensaje después de mostrarlo
		    }
		%>
	    
	    <%
		    String loginErrorUser = (String) session.getAttribute("loginErrorUser");
		    if (loginErrorUser != null) {
		%>  
		    <br>
		    <div style="color: red; font-weight: bold; font-size: 0.8rem;">
		        <%= loginErrorUser %>
		    </div>
		<%
		        session.removeAttribute("loginErrorUser"); // Limpia después de mostrar
		    }
		%>
	    
	    <!-- MENSAJE DE ERROR MEDIANTE EL CONTROLADOR -->
	    
	    <%
		    String loginError = (String) session.getAttribute("loginError");
		    if (loginError != null) {
		%>	
			<br>
		    <div style="color: red; font-weight: bold; font-size: 0.8rem;">
		        <%= loginError %>
		    </div>
		<%
		        session.removeAttribute("loginError"); // Elimina el mensaje después de mostrarlo
		    }
		%>
		
	    <br>
	    <a href="<%= request.getContextPath() %>/login-register/register.jsp" class="btn-register-small">No tienes una cuenta? Registrate aquí</a>
	  </div>
	</div>

  </div>
  <script src="<%= request.getContextPath() %>/js/jsLogin.jsp"></script>
</body>
</html>