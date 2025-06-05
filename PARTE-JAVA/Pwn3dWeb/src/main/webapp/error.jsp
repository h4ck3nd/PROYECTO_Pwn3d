<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
    <title>Error - Pwn3d!</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
    <style>
        body {
            background-color: #1e1b27;
            color: #cb9cf0;
            font-family: 'Press Start 2P', monospace;
            text-align: center;
            padding-top: 100px;
        }
        .error-container {
            background-color: #2d2a3f;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 10px #cb9cf0;
            display: inline-block;
        }
        .btn-purple {
            background-color: #cb9cf0;
            color: #000;
            border: none;
            font-size: 12px;
            padding: 10px 20px;
            font-family: 'Press Start 2P', monospace;
            margin-top: 30px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-purple:hover {
            background-color: #b678f2;
            color: #000;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>⚠️ Usuario no encontrado</h1>
        <p style="font-size: 10px; color: #eee;">No se pudo cargar el perfil solicitado.</p>
        <a href="<%= request.getContextPath() %>/stats" class="btn-purple">← Volver a estadísticas</a>
    </div>
</body>
</html>
