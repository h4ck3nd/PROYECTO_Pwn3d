<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Añadir VM</title>
</head>
<body>
<h2>Añadir Nueva VM</h2>

<form id="machineForm" action="<%= request.getContextPath() %>/submitMachineData" method="POST">
    <h2>Formulario para Ingresar Datos de la Máquina</h2>
  
    <!-- ID -->
    <label for="id">ID de la Máquina:</label>
    <input type="text" id="id" name="id" required><br><br>

    <!-- Nombre de la máquina -->
    <label for="name_machine">Nombre de la máquina:</label>
    <input type="text" id="name_machine" name="name_machine" required><br><br>
	
	<!-- Tamaño -->
    <label for="size">Tamaño:</label>
    <input type="number" id="size" name="size" required><br><br>
	
    <!-- Sistema operativo -->
    <label for="os">Sistema Operativo:</label>
    <input type="text" id="os" name="os" required><br><br>
    
    <!-- Entorno -->
    <label for="enviroment">Entorno:</label>
    <input type="text" id="enviroment" name="enviroment" required><br><br>

    <!-- Creador -->
    <label for="creator">Creador:</label>
    <input type="text" id="creator" name="creator" required><br><br>

    <!-- Dificultad -->
    <label for="difficulty">Dificultad:</label>
    <input type="text" id="difficulty" name="difficulty" required><br><br>

    <!-- Fecha -->
    <label for="date">Fecha:</label>
    <input type="date" id="date" name="date" required><br><br>

    <!-- MD5 -->
    <label for="md5">MD5 Hash:</label>
    <input type="text" id="md5" name="md5" required><br><br>

    <!-- Writeup URL -->
    <label for="writeup_url">URL del Writeup:</label>
    <input type="url" id="writeup_url" name="writeup_url" required><br><br>

    <!-- Primer usuario -->
    <label for="first_user">Primer usuario:</label>
    <input type="text" id="first_user" name="first_user" required><br><br>

    <!-- Primer root -->
    <label for="first_root">Primer root:</label>
    <input type="text" id="first_root" name="first_root" required><br><br>

    <!-- Imagen del sistema operativo -->
    <label for="img_name_os">Imagen del sistema operativo (nombre de archivo):</label>
    <input type="text" id="img_name_os" name="img_name_os" required><br><br>

    <!-- URL de descarga -->
    <label for="download_url">URL de descarga:</label>
    <input type="url" id="download_url" name="download_url" required><br><br>

    <button type="submit">Enviar</button>
</form>

</body>
</html>
