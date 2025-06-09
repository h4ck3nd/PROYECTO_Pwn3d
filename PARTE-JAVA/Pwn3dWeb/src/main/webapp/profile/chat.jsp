<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*, java.util.*, java.sql.*, dao.MessageDAO, conexionDDBB.ConexionDDBB" %>
<%
    Integer currentUserId = (Integer) session.getAttribute("userId");
    if (currentUserId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int otherUserId = 0;
    String otherUsername = "Usuario";
    try {
        otherUserId = Integer.parseInt(request.getParameter("id"));
        ConexionDDBB db = new ConexionDDBB();
        try (Connection conn = db.conectar()) {
            MessageDAO dao = new MessageDAO(conn);
            otherUsername = dao.obtenerNombreUsuario(otherUserId);
        }
    } catch (Exception e) {
        response.getWriter().println("Usuario no válido");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat <%= otherUsername %> - Pwn3d!</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dynamicFonts.jsp" />
    <style>
        body {
            background: #0b0b15;
            color: #e0e0ff;
            font-family: monospace;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .chat-box {
            width: 100%;
            max-width: 1200px;
            height: 95vh;
            display: flex;
            flex-direction: column;
            padding: 1.5rem;
            background-color: #141421;
            border-radius: 16px;
            box-shadow: 0 0 20px rgba(138, 43, 226, 0.3);
        }

        h2 {
            font-family: 'Press Start 2P', monospace;
            font-size: 0.8rem;
            color: #b478f1;
            text-align: center;
            margin: 0 0 1rem;
        }

        #messages {
            flex: 1;
            overflow-y: auto;
            background-color: #1a1a2f;
            padding: 1rem;
            border-radius: 12px;
        }

        .message {
		    max-width: 75%;
		    padding: 0.8rem 1.1rem;
		    border-radius: 14px;
		    margin: 0.6rem 0;
		    font-size: 0.95rem;
		    line-height: 1.4rem;
		    word-break: break-word;
		    transition: background-color 0.2s ease, box-shadow 0.2s ease;
		}

        .me {
		    background: linear-gradient(135deg, #7f5af0, #6246ea);
		    color: #ffffff;
		    margin-left: auto;
		    text-align: right;
		    border-top-right-radius: 0;
		    box-shadow: 0 0 8px rgba(127, 90, 240, 0.3);
		}
		
		.other {
		    background-color: #24243e;
		    color: #cfcfe1;
		    margin-right: auto;
		    text-align: left;
		    border-top-left-radius: 0;
		    box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
		}

        .message small {
            display: block;
            font-size: 0.85rem;
            color: #9e9e9e;
            margin-top: 0.3rem;
        }

        .input-area {
            margin-top: 1rem;
            display: flex;
            gap: 0.8rem;
        }

        #messageInput {
            flex: 1;
            font-size: 0.65rem;
            padding: 0.7rem 1rem;
            border: none;
            border-radius: 25px;
            background-color: #22223a;
            color: white;
            font-family: 'Press Start 2P', monospace;
        }

        #messageInput:focus {
            outline: 2px solid #b478f1;
        }

        button {
            font-family: 'Press Start 2P', monospace;
            font-size: 0.6rem;
            padding: 0.7rem 1.2rem;
            border: none;
            border-radius: 25px;
            background-color: #a06cd5;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #c084fc;
        }

        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-thumb {
            background: #6a0dad;
            border-radius: 4px;
        }
        .username {
		    font-size: 0.8rem;
		    font-weight: bold;
		    color: #9c8ffb;
		    margin-bottom: 0.4rem;
		    opacity: 0.9;
		}
        
    </style>
</head>
<body>

<div class="chat-box">
    <h2>Chat con <%= otherUsername %></h2>
    <div id="messages"></div>

    <div class="input-area">
        <input type="text" id="messageInput" placeholder="Escribe un mensaje..." autocomplete="off">
        <button onclick="sendMessage()">Enviar</button>
        <button onclick="window.location.href='<%= request.getContextPath() %>/profile/profile-user-public.jsp?id=<%= otherUserId %>'" 
	        style="font-family: 'Press Start 2P', monospace; 
	               font-size: 0.6rem; 
	               padding: 0.7rem 1.2rem; 
	               border: none; 
	               border-radius: 25px; 
	               background-color: #a06cd5; 
	               color: white; 
	               cursor: pointer; 
	               transition: background-color 0.3s ease;">
	    Volver
	</button>
    </div>
</div>

<script>
    const currentUserId = <%= currentUserId %>;
    const otherUserId = <%= otherUserId %>;

    function loadMessages() {
        fetch('<%= request.getContextPath() %>/getMessages?currentUserId=' + currentUserId + '&otherUserId=' + otherUserId)
            .then(res => res.json())
            .then(data => {
                const container = document.getElementById("messages");
                container.innerHTML = "";
                data.forEach(msg => {
                    const div = document.createElement("div");
                    div.className = "message " + (msg.senderId === currentUserId ? "me" : "other");

                    const readStatus = (msg.senderId === currentUserId)
                        ? (msg.isRead ? "✓ Leído" : "⌛ No leído")
                        : "";

                        div.innerHTML =
                            "<div class='username'>" + msg.senderName + "</div>" +
                            msg.content +
                            "<small>" + new Date(msg.sentAt).toLocaleString() +
                            (readStatus ? " • " + readStatus : "") + "</small>";

                    container.appendChild(div);
                });
                container.scrollTop = container.scrollHeight;
            })
            .catch(error => console.error('Error cargando mensajes:', error));
    }

    function sendMessage() {
        const content = document.getElementById("messageInput").value;
        if (content.trim() === "") return;

        const body = "senderId=" + currentUserId +
                     "&receiverId=" + otherUserId +
                     "&message=" + encodeURIComponent(content);

        fetch('<%= request.getContextPath() %>/sendMessageAjax', {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: body
        })
        .then(response => {
            if (!response.ok) throw new Error("Error al enviar");
            document.getElementById("messageInput").value = "";
            loadMessages();
        })
        .catch(error => console.error('Error enviando mensaje:', error));
    }

    setInterval(loadMessages, 2000);
    window.onload = loadMessages;
</script>

</body>
</html>