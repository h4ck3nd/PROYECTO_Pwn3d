<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
    <title>Info Máquinas Docker - Pwn3d!</title>
    <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #1e1b27;
            color: #eee;
            font-family: 'Press Start 2P', monospace !important;
            padding: 30px;
            line-height: 1.8;
        }

        h1, h2, h3 {
            color: #c792ea;
            text-align: center;
        }

        .content {
            max-width: 900px;
            margin: auto;
            background: #1e1e2f;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(130, 90, 200, 0.5);
        }

        .terminal-box {
            background-color: #000;
            color: #00ff90;
            font-size: 0.75rem;
            padding: 15px;
            margin: 20px 0;
            border-radius: 10px;
            border-left: 5px solid #c792ea;
            overflow-x: auto;
            white-space: pre-wrap;
        }

        .note-box {
            background-color: #2c2c3c;
            border-left: 5px solid #ff6ec7;
            padding: 15px;
            margin: 20px 0;
            color: #ffc;
            font-size: 0.65rem;
        }

        ul {
            padding-left: 20px;
            font-size: 0.7rem;
        }

        a {
            color: #bb86fc;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
        .description {
        	align-content: center;
        	text-align: center;
        }
        
        .center-button-container {
		  display: flex;
		  justify-content: center;
		  align-items: center;
		  margin-right: 15rem;
		}
        
        .exit-btn {
		  display: flex;
		  width: 8.5rem;
		  height: 2rem;
		  cursor: pointer;
		  font-size: 1rem;
		  border-radius: 0.35rem;
		  padding: 1.2rem;
		  border: 1px solid #444;
		  background-color: #390056;
		  color: var(--color-filter-text);
		  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.5);
		  overflow: hidden;
		  transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
		  margin-left: clamp(1rem, 10vw, 55rem);
		  margin-right: clamp(-2rem, -5vw, -16rem);
		  white-space: nowrap;
		  font-family: 'Press Start 2P', monospace !important;
		  align-content: center;
		  text-align: center;
		  align-items: center;
		}
		
		.exit-btn::before {
		  content: "";
		  position: absolute;
		  top: 50%;
		  left: 50%;
		  width: 0%;
		  height: 0%;
		  background: radial-gradient(circle, #edabff -30%, transparent 90%);
		  transform: translate(-50%, -50%);
		  opacity: 0;
		  transition: width 0.4s ease, height 0.4s ease, opacity 0.4s ease;
		  pointer-events: none;
		}
		
		.exit-btn:hover {
		  background-color: #3a3a3a;
		  transform: scale(1.03);
		  box-shadow: 0 0 12px #edabff;
		}
		
		.exit-btn:hover::before {
		  width: 220%;
		  height: 220%;
		  opacity: 1;
		}
    </style>
</head>
<body>
<div class="content">
    <h1>Pwn3d! - Despliegue de Máquinas en Docker</h1>
    
    <div class="center-button-container">
	    <button 
			type="button" 
			class="exit-btn" 
			onclick="window.location.href='<%= request.getContextPath() %>/machines.jsp'">
			Volver
		</button>
	</div>

    <h2>¿Qué es esto?</h2>
    <p class="description">Esta guía está orientada a quienes deseen ejecutar máquinas CTF de forma local utilizando Docker. Está especialmente pensada para quienes descargan máquinas (Docker) desde nuestra plataforma comprimidas en formato <strong>.zip</strong>.</p>

    <h2>Pasos para ejecutar una máquina</h2>
    <ol>
        <li>Descarga el archivo <strong>.zip</strong> desde la página correspondiente.</li>
        <li>Descomprime el archivo:</li>
        <div class="terminal-box"> $ unzip maquina.zip</div>

        <li>Ejecuta el script automático con el archivo de la máquina .tar:</li>
        <div class="terminal-box"> $ bash auto_run.sh maquina.tar</div>

        <li>¡Listo! El contenedor debería estar corriendo.</li>
    </ol>

    <div class="note-box">
        Asegúrate de tener Docker instalado y corriendo en tu sistema. Puedes comprobarlo con:
        <div class="terminal-box">$ docker --version</div>
    </div>

    <h2>Compatibilidad</h2>
    <p class="description">Nuestras máquinas están preparadas para entornos Linux y Windows. El script detectará el sistema base y realizará la ejecución automáticamente si tu sistema es compatible.</p>

    <h2>Normas de uso</h2>
    <ul>
        <li>Este script ha sido creado con fines <strong>educativos</strong> y de <strong>pentesting ético</strong>.</li>
        <li>No se permite el uso comercial sin consentimiento previo.</li>
        <li>Si reutilizas este script o partes de su lógica, por favor da créditos a <strong>Pwn3d!</strong>.</li>
        <li>No compartas ni redistribuyas las máquinas sin autorización.</li>
    </ul>

    <div class="note-box">
        "El hacking ético no es solo una habilidad, es una responsabilidad."
    </div>

    <h2>Sobre Pwn3d!</h2>
    <p class="description">Pwn3d! es una plataforma de aprendizaje para entusiastas del hacking ético, CTFs y análisis de vulnerabilidades. Nuestro objetivo es brindar retos realistas, tanto en entornos Docker como máquinas OVA.</p>

    <p style="text-align: center; font-size: 0.65rem; margin-top: 40px;">&copy; 2025 Pwn3d! - Todos los derechos reservados.</p>
</div>
</body>
</html>
