<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="<%= request.getContextPath() %>/img/logo-flag-white.ico">
    <title>Política Legal - Pwn3d!</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
    <style>
        body {
            background-color: #1e1b27;
            color: #dcd0ff;
            font-family: 'Press Start 2P', monospace !important;
            font-size: 0.8rem;
            line-height: 1.7;
            padding: 2rem;
        }

        h1, h2, h3 {
            color: #b682ff;
        }

        a {
            color: #c48fff;
        }

        .container {
            max-width: 900px;
            margin: auto;
            background-color: #1f1b2e;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 0 18px #7a52d8;
        }

        .highlight {
            color: #ffb7ff;
        }

        ul li {
            margin-bottom: 0.8rem;
        }

        footer {
            text-align: center;
            margin-top: 3rem;
            font-size: 0.9rem;
            color: #888;
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
	<br>
	<div class="center-button-container">
	    <button 
			type="button" 
			class="exit-btn" 
			onclick="window.location.href='<%= request.getContextPath() %>/stats'">
			Volver
		</button>
	</div>
	<br><br>
    <div class="container">
        <h1>Política Legal y Términos de Uso</h1>
        <p>Bienvenido a <strong class="highlight">Pwn3d!</strong>, una plataforma orientada a la formación en ciberseguridad ofensiva, hacking ético y pruebas CTF (Capture The Flag), desarrollada por <strong>d1se0</strong>.</p>

        <h2>1. Finalidad del Sitio</h2>
        <p>Pwn3d! tiene como propósito exclusivo la <strong>educación, formación y concienciación</strong> en materia de seguridad informática. Las prácticas ofrecidas están dirigidas a usuarios que deseen mejorar sus habilidades bajo principios legales y éticos.</p>

        <h2>2. Legislación Aplicable</h2>
        <ul>
            <li><strong>Ley Orgánica 3/2018</strong>, de Protección de Datos Personales y garantía de los derechos digitales (LOPDGDD).</li>
            <li><strong>Reglamento (UE) 2016/679</strong> (RGPD).</li>
            <li><strong>Ley 34/2002</strong>, de Servicios de la Sociedad de la Información y del Comercio Electrónico (LSSI-CE).</li>
            <li><strong>Código Penal Español</strong>, artículos 197 y 264 sobre acceso ilícito y daños a sistemas informáticos.</li>
        </ul>

        <h2>3. Compromiso del Usuario</h2>
        <p>Todo usuario se compromete a:</p>
        <ul>
            <li>Utilizar los laboratorios únicamente con fines educativos.</li>
            <li>No extrapolar los conocimientos adquiridos a entornos o sistemas no autorizados.</li>
            <li>No vulnerar ni intentar vulnerar servicios, servidores o usuarios del entorno fuera de los entornos virtualizados proporcionados.</li>
        </ul>

        <h2>4. Exclusión de Responsabilidad</h2>
        <p>El creador, d1se0, y el equipo de desarrollo de Pwn3d! declinan toda responsabilidad derivada del uso indebido de la plataforma por parte de terceros. La ejecución de técnicas ofensivas fuera de este entorno formativo puede constituir un delito penal y será responsabilidad exclusiva del infractor.</p>

        <h2>5. Protección de Datos</h2>
        <p>Este sitio almacena datos mínimos necesarios para la funcionalidad del sistema (nombre de usuario, puntuación, badges, logs de acceso, etc.). En ningún caso se cederán datos a terceros. Puedes ejercer tus derechos de acceso, rectificación y cancelación escribiendo a <a href="mailto:ciberseguridad12345@gmail.com">ciberseguridad12345@gmail.com</a>.</p>

        <h2>6. Seguridad y Protección Activa</h2>
        <p>Se han implementado políticas de seguridad como:</p>
        <ul>
            <li>Prevención de ataques XSS, CSRF y SQL Injection a través de validación y escape de entradas.</li>
            <li>Cifrado de contraseñas con algoritmos robustos.</li>
            <li>Control de sesiones, detección de accesos sospechosos y logs con trazabilidad completa.</li>
        </ul>

        <h2>7. Derechos de Propiedad</h2>
        <p>Todos los laboratorios, textos, imágenes, scripts y contenido técnico han sido desarrollados por d1se0, y están protegidos por las leyes de propiedad intelectual. No está permitido reproducir, redistribuir ni comercializar los contenidos sin autorización explícita.</p>

        <h2>8. Modificaciones</h2>
        <p>Pwn3d! se reserva el derecho de modificar en cualquier momento los términos de uso o esta política legal, informando de ello a través del portal.</p>

        <footer style="font-size: 0.6rem;">
            &copy; 2025 Pwn3d! · Desarrollado por d1se0 · Ciberseguridad Ética y Formación Técnica
        </footer>
    </div>
</body>
</html>
