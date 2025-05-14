<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Añadir VM</title>
</head>
<body>
<h2>Añadir Nueva VM</h2>

<form id="machineForm" action="<%= request.getContextPath() %>/machines" method="POST">
    <h2>Formulario para Ingresar Datos de la Máquina</h2>
  
    <!-- ID -->
    <label for="id">ID de la Máquina:</label>
    <input type="text" id="id" name="id" placeholder="1, 2, 3..." required><br><br>

    <!-- Nombre de la máquina -->
    <label for="name_machine">Nombre de la máquina:</label>
    <input type="text" id="name_machine" name="name_machine" placeholder="testMachine" required><br><br>
	
	<!-- Tamaño -->
    <label for="size">Tamaño:</label>
    <input type="text" id="size" name="size" placeholder="1.2GB, 200MB..." required><br><br>
	
	<!-- Sistema operativo -->
	<label for="os">Sistema Operativo:</label>
	<select id="os" name="os" required>
	    <option value="" disabled selected>Selecciona la S.O.</option>
	    <option value="Linux">Linux</option>
	    <option value="Windows">Windows</option>
	</select>
	<br><br>
    
    <!-- Entorno -->
    <label for="enviroment">Entorno:</label>
    <select id="enviroment" name="enviroment" required>
	    <option value="" disabled selected>Selecciona la Entorno</option>
	    <option value="vbox">Virtual Box</option>
	    <option value="vmware">VMWare</option>
	    <option value="docker">Docker</option>
	</select>
	<br><br>
	
	<!-- Entorno 2 -->
    <label for="enviroment2">Entorno 2 (OPCIONAL):</label>
    <select id="enviroment2" name="enviroment2">
	    <option value="" disabled selected>Selecciona la Entorno 2</option>
	    <option value="vbox">Virtual Box</option>
	    <option value="vmware">VMWare</option>
	    <option value="docker">Docker</option>
	</select>
	<br><br>

    <!-- Creador -->
    <label for="creator">Creador:</label>
    <input type="text" id="creator" name="creator" placeholder="username..." required><br><br>

	<!-- Dificultad -->
	<label for="difficulty_card">Dificultad Tarjeta:</label>
	<select id="difficulty_card" name="difficulty_card" required>
	    <option value="" disabled selected>Selecciona la dificultad</option>
	    <option value="Very-Easy">Very Easy</option>
	    <option value="Easy">Easy</option>
	    <option value="Medium">Medium</option>
	    <option value="Hard">Hard</option>
	</select>
	<br><br>

    <!-- Dificultad -->
	<label for="difficulty">Dificultad:</label>
	<select id="difficulty" name="difficulty" required>
	    <option value="" disabled selected>Selecciona la dificultad</option>
	    <option value="very-easy">Very Easy</option>
	    <option value="easy">Easy</option>
	    <option value="medium">Medium</option>
	    <option value="hard">Hard</option>
	</select>
	<br><br>

    <!-- Fecha -->
    <label for="date">Fecha:</label>
    <input type="date" id="date" name="date" required><br><br>

    <!-- MD5 -->
    <label for="md5">MD5 Hash:</label>
    <input type="text" id="md5" name="md5" placeholder="ABCDEFGHIJKLMNÑOPQRSTUVWXYZ..." required><br><br>

    <!-- Writeup URL -->
    <label for="writeup_url">URL del Writeup:</label>
    <input type="url" id="writeup_url" name="writeup_url" placeholder="https://test.com/" required><br><br>

    <!-- Primer usuario -->
    <label for="first_user">Primer usuario:</label>
    <input type="text" id="first_user" name="first_user" placeholder="user..." required><br><br>

    <!-- Primer root -->
    <label for="first_root">Primer root:</label>
    <input type="text" id="first_root" name="first_root" placeholder="user..." required><br><br>

    <!-- Imagen del sistema operativo -->
    <label for="img_name_os">Imagen del sistema operativo (nombre de archivo):</label>
    <select id="img_name_os" name="img_name_os" required>
	    <option value="" disabled selected>Selecciona la Imagen del S.O.</option>
	    <option value="Linux">Linux</option>
	    <option value="Windows">Windows</option>
	</select>
    <br><br>

    <!-- URL de descarga -->
    <label for="download_url">URL de descarga:</label>
    <input type="url" id="download_url" name="download_url" placeholder="https://test.com/download" required><br><br>

    <button type="submit">Enviar</button>
</form>

</body>
</html>
