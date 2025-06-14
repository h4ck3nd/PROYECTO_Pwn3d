<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Perfil - HackMyVM Clone</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');

body {
  margin: 0;
  font-family: 'Press Start 2P', cursive;
  background-color: #1e1e26;
  color: #d0aaff;
}

.profile-section,
.logs-section {
  font-family: 'Press Start 2P', cursive !important;
}


.container {
  display: flex;
  height: 100vh;
  overflow: hidden;
}

.sidebar {
  width: 250px;
  background-color: #14141b;
  color: #d0aaff;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 20px 0;
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  transition: all 0.3s ease;
}

.profile .avatar {
  width: 100px;
  height: 100px;
  border-radius: 50%;
}

.profile h2 {
  font-size: 12px;
  margin-top: 10px;
  text-align: center;
}

.sidebar nav ul {
  list-style: none;
  padding: 0;
  margin-top: 20px;
  width: 100%;
}

.sidebar nav ul li {
  padding: 10px 20px;
  cursor: pointer;
  transition: background 0.2s;
}

.sidebar nav ul li:hover {
  background-color: #282840;
}

.menu-btn {
  position: fixed;
  top: 15px;
  left: 15px;
  background-color: #cba6f7;
  color: #1e1e2e;
  border: none;
  padding: 10px 14px;
  font-size: 18px;
  border-radius: 6px;
  cursor: pointer;
  z-index: 1000;
}

.close-btn {
  background: none;
  border: none;
  color: #cdd6f4;
  font-size: 18px;
  position: absolute;
  top: 10px;
  left: 10px;
  cursor: pointer;
}

#sidebar {
  transition: transform 0.3s ease;
}

#sidebar.hidden {
  transform: translateX(-100%);
}

.sidebar.hidden {
  width: 0;
  overflow: hidden;
  transform: translateX(-100%);
}

.content {
  margin-left: 300px;
  padding: 20px 30px; /* Aquí el margen lateral */
  overflow-y: auto;
  flex: 1;
  transition: all 0.3s ease;
}

/* Centramos cuando el sidebar está oculto */
.container.sidebar-hidden .content {
  margin-left: 0;
}

.profile-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #2a2a3d;
  padding: 20px;
  border-radius: 10px;
}

.profile-section {
  background-color: #1a1a2e;
  padding: 20px;
  border-radius: 10px;
  max-width: 900px;
  margin: 0 auto 30px auto;
  color: #cdd6f4;
  font-family: monospace;
}

.profile-card {
  display: flex;
  align-items: center;
  gap: 30px;
  background-color: #26263b;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 0 10px rgba(203, 166, 247, 0.2);
}

.profile-avatar {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid #cba6f7;
}

.profile-info {
  flex: 1;
}

.profile-username {
  font-size: 24px;
  margin: 0;
  color: #cba6f7;
}

.profile-badges {
  margin: 10px 0;
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}

.badge {
  background-color: #45475a;
  padding: 5px 10px;
  border-radius: 5px;
  font-size: 12px;
  color: #f5e0dc;
  text-transform: uppercase;
  border: 1px solid #6c7086;
  display: inline-flex;
  align-items: center;
  gap: 5px;
}

/* Colores personalizados por insignia */
.badge.brain {
  background-color: #b4befe;
  color: #1e1e2e;
}

.badge.active {
  background-color: #f38ba8;
  color: #1e1e2e;
}

.badge.pro {
  background-color: #94e2d5;
  color: #1e1e2e;
}

.badge.vip {
  background-color: #cba6f7;
  color: #1e1e2e;
}

.badge.root {
  background-color: #f9e2af;
  color: #1e1e2e;
}

.badge.top {
  background-color: #fab387;
  color: #1e1e2e;
}

.badge.first {
  background-color: #f5c2e7;
  color: #1e1e2e;
}

.badge.precise {
  background-color: #a6e3a1;
  color: #1e1e2e;
}

.profile-stats {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
  gap: 15px;
  margin-top: 20px;
}

.stat {
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: #313244;
  padding: 10px;
  border-radius: 8px;
  text-align: center;
}

.stat strong {
  font-size: 14px;
  color: #cdd6f4;
  margin-bottom: 5px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.stat span {
  font-size: 18px;
  font-weight: bold;
  color: #cba6f7;
}


.title h1 {
  font-size: 18px;
  color: #caa6ff;
  margin: 0;
}

.title .rank {
  color: #ff6fff;
}

.title .points {
  color: #e0c4ff;
  font-size: 12px;
  margin-left: 10px;
}

.love-btn {
  margin-top: 10px;
  background: none;
  border: 1px solid #d0aaff;
  color: #d0aaff;
  padding: 5px 10px;
  cursor: pointer;
  font-size: 10px;
}

.love-btn:hover {
  background-color: #2e2e4d;
}

.avatar-big img {
  width: 120px;
  border-radius: 100%;
}

.machines {
  display: flex;
  flex-direction: column;
  gap: 40px;
  margin-top: 40px;
}


.machines h2 {
  font-size: 20px;
  color: #e3caff;
  border-bottom: 2px solid #5e3b94;
  padding-bottom: 5px;
  text-align: center;
}

.machine-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.machine-item {
  display: flex;
  align-items: center;
  background-color: #26263b;
  padding: 15px;
  border-radius: 10px;
  justify-content: space-between;
  transition: background 0.2s;
}

.machine-item:hover {
  background-color: #2f2f48;
}

.machine-item img {
  width: 64px;
  height: 64px;
  border-radius: 8px;
  margin-right: 15px;
}

.machine-info {
  flex-grow: 1;
  text-align: left;
}

.machine-info h3 {
  margin: 0;
  color: #d8baff;
  font-size: 14px;
}

.machine-info p {
  margin: 5px 0 0;
  font-size: 10px;
  color: #aaa;
}

.machine-meta {
  display: flex;
  gap: 10px;
  align-items: center;
  font-size: 10px;
}

.machine-meta .type {
  background-color: #43316c;
  padding: 2px 6px;
  border-radius: 4px;
  color: #d0aaff;
}

.machine-meta .difficulty {
  padding: 2px 6px;
  border-radius: 4px;
  color: #fff;
}

.difficulty.easy {
  background-color: #43a047;
}

.difficulty.medium {
  background-color: #fb8c00;
}

.difficulty.hard {
  background-color: #e53935;
}

.machine-meta .points {
  background-color: #5e3b94;
  padding: 2px 6px;
  border-radius: 4px;
}

.machine-meta .badge {
  font-size: 14px;
}

.logs-section {
  background-color: #1a1a2e;
  padding: 20px;
  border-radius: 10px;
  color: #cdd6f4;
  font-family: monospace;
  display: flex;
  flex-direction: column;
  gap: 15px;
  box-sizing: border-box;
  margin-top: 40px;
  width: 100%;
  margin-left: 0;   /* ✅ Esto permite que se adapte automáticamente */
  margin-right: 30px;
}


.logs-section h2 {
  margin-bottom: 10px;
  font-size: 20px;
  color: #cba6f7;
  border-bottom: 1px solid #6c7086;
  padding-bottom: 5px;
  text-align: center;
}

@media (max-width: 768px) {
  .logs-section {
    margin-right: 15px;
  }
}

.log-item {
  background-color: #26263b;
  width: 100%;               /* Ocupa todo el ancho disponible */
  padding: 10px 15px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
  box-sizing: border-box;
}

.log-time {
  font-size: 12px;
  color: #9399b2;
  white-space: nowrap;
}

.log-text {
  flex: 1;
  text-align: center;
  font-size: 14px;
}

.log-avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  object-fit: cover;
}

  </style>
</head>
<body>
  <!-- Botón de hamburguesa -->
<button id="toggle-menu" class="menu-btn" style="display: none;">☰</button>
  <div class="container">
    <!-- Botón de cerrar dentro del aside -->
    <aside class="sidebar">
      <button id="close-menu" class="close-btn">✖</button>
      <div class="profile">
        <img src="monitor.png" alt="Avatar" class="avatar" />
        <h2>y0 ivang@mez!</h2>
      </div>
      <nav>
        <ul>
          <li>🏠 Dashboard</li>
          <li>🖥️ Machines</li>
          <li>📈 Leaderboard</li>
          <li>✉️ Feedback</li>
          <li>⚙️ Settings</li>
          <li>🚪 Cerrar Sesion</li>
        </ul>
      </nav>
    </aside>

    <main class="content">
      <section class="profile-header">
        <div class="profile-section">
  <div class="profile-card">
    <img src="monitor.PNG" alt="Profile Picture" class="profile-avatar" />
    <div class="profile-info">
      <h1 class="profile-username">primary</h1>
      <div class="profile-badges">
  <span class="badge brain">🧠 Brainstorm</span>
  <span class="badge active">🔥 Most Active</span>
  <span class="badge pro">🛡️ Pro Hacker</span>
  <span class="badge vip">💎 VIP</span>
  <span class="badge root">💀 Root User</span>
  <span class="badge top">🥇 Top Ranker</span>
  <span class="badge first">🚩 First Blood</span>
  <span class="badge precise">🎯 Precision</span>
</div>
      <div class="profile-stats">
  <div class="stat">
    <strong>Rank</strong>
    <span>#42</span>
  </div>
  <div class="stat">
    <strong>Score</strong>
    <span>1380</span>
  </div>
  <div class="stat">
    <strong>Machines</strong>
    <span>38</span>
  </div>
  <div class="stat">
    <strong>Rooted</strong>
    <span>35</span>
  </div>
  <div class="stat">
    <strong>First Bloods</strong>
    <span>5</span>
  </div>
</div>
    </div>
  </div>
</div>
      </section>
      <section class="machines">
  <h2>Machines</h2>
  <div class="machine-list">
    <div class="machine-item">
      <img src="machine1.png" alt="Machine 1" />
      <div class="machine-info">
        <h3>Knock-Knock</h3>
        <p>Resolved on: 2023-09-10</p>
      </div>
      <div class="machine-meta">
        <span class="type">Linux</span>
        <span class="difficulty easy">Easy</span>
        <span class="points">20 pts</span>
        <span class="badge">🥇</span>
      </div>
    </div>
  </div>
  <div class="machine-item">
      <img src="machine2.png" alt="Machine 2" />
      <div class="machine-info">
        <h3>Incognito</h3>
        <p>Resolved on: 2023-09-08</p>
      </div>
      <div class="machine-meta">
        <span class="type">Windows</span>
        <span class="difficulty medium">Medium</span>
        <span class="points">40 pts</span>
        <span class="badge">🥈</span>
      </div>
    </div>

    <div class="machine-item">
  <img src="machine3.png" alt="Machine 3" />
  <div class="machine-info">
    <h3>ShadowRoot</h3>
    <p>Resolved on: 2023-08-21</p>
  </div>
  <div class="machine-meta">
    <span class="type">Linux</span>
    <span class="difficulty hard">Hard</span>
    <span class="points">60 pts</span>
    <span class="badge">🥇</span>
  </div>
</div>

<div class="machine-item">
  <img src="machine4.png" alt="Machine 4" />
  <div class="machine-info">
    <h3>BlueReign</h3>
    <p>Resolved on: 2023-07-14</p>
  </div>
  <div class="machine-meta">
    <span class="type">Windows</span>
    <span class="difficulty medium">Medium</span>
    <span class="points">40 pts</span>
    <span class="badge">🥈</span>
  </div>
</div>

<div class="machine-item">
  <img src="machine5.png" alt="Machine 5" />
  <div class="machine-info">
    <h3>Oblivion</h3>
    <p>Resolved on: 2023-06-30</p>
  </div>
  <div class="machine-meta">
    <span class="type">Linux</span>
    <span class="difficulty easy">Easy</span>
    <span class="points">20 pts</span>
    <span class="badge">🥉</span>
  </div>
</div>

<div class="machine-item">
  <img src="machine6.png" alt="Machine 6" />
  <div class="machine-info">
    <h3>DataLeak</h3>
    <p>Resolved on: 2023-06-10</p>
  </div>
  <div class="machine-meta">
    <span class="type">Windows</span>
    <span class="difficulty medium">Medium</span>
    <span class="points">40 pts</span>
    <span class="badge">🥈</span>
  </div>
</div>

<div class="machine-item">
  <img src="machine7.png" alt="Machine 7" />
  <div class="machine-info">
    <h3>NightFall</h3>
    <p>Resolved on: 2023-05-28</p>
  </div>
  <div class="machine-meta">
    <span class="type">Linux</span>
    <span class="difficulty hard">Hard</span>
    <span class="points">60 pts</span>
    <span class="badge">🥇</span>
  </div>
</div>

<div class="machine-item">
  <img src="machine8.png" alt="Machine 8" />
  <div class="machine-info">
    <h3>Overload</h3>
    <p>Resolved on: 2023-05-10</p>
  </div>
  <div class="machine-meta">
    <span class="type">Windows</span>
    <span class="difficulty easy">Easy</span>
    <span class="points">20 pts</span>
    <span class="badge">🥉</span>
  </div>
</div>

<div class="machine-item">
  <img src="machine9.png" alt="Machine 9" />
  <div class="machine-info">
    <h3>EchoVault</h3>
    <p>Resolved on: 2023-04-15</p>
  </div>
  <div class="machine-meta">
    <span class="type">Linux</span>
    <span class="difficulty medium">Medium</span>
    <span class="points">40 pts</span>
    <span class="badge">🥈</span>
  </div>
</div>

<div class="machine-item">
  <img src="machine10.png" alt="Machine 10" />
  <div class="machine-info">
    <h3>HexGate</h3>
    <p>Resolved on: 2023-03-30</p>
  </div>
  <div class="machine-meta">
    <span class="type">Windows</span>
    <span class="difficulty hard">Hard</span>
    <span class="points">60 pts</span>
    <span class="badge">🥇</span>
  </div>
</div>

<div class="machine-item">
  <img src="machine11.png" alt="Machine 11" />
  <div class="machine-info">
    <h3>SilentStorm</h3>
    <p>Resolved on: 2023-03-12</p>
  </div>
  <div class="machine-meta">
    <span class="type">Linux</span>
    <span class="difficulty easy">Easy</span>
    <span class="points">20 pts</span>
    <span class="badge">🥉</span>
  </div>
</div>

<div class="machine-item">
  <img src="machine12.png" alt="Machine 12" />
  <div class="machine-info">
    <h3>ZeroTrace</h3>
    <p>Resolved on: 2023-02-25</p>
  </div>
  <div class="machine-meta">
    <span class="type">Windows</span>
    <span class="difficulty medium">Medium</span>
    <span class="points">40 pts</span>
    <span class="badge">🥈</span>
  </div>
</div>
<div class="logs-section">
  <h2>Logs</h2>
  <div class="log-item">
    <span class="log-time">2025-06-03 18:42</span>
    <span class="log-text"><strong>primary</strong> got root in <strong>Devoops</strong></span>
    <img class="log-avatar" src="avatar.png" alt="primary avatar" />
  </div>
  <div class="log-item">
    <span class="log-time">2025-06-02 21:13</span>
    <span class="log-text"><strong>primary</strong> got root in <strong>Oblivion</strong></span>
    <img class="log-avatar" src="avatar.png" alt="primary avatar" />
  </div>
  <div class="log-item">
    <span class="log-time">2025-06-01 16:08</span>
    <span class="log-text"><strong>primary</strong> got root in <strong>ShadowRoot</strong></span>
    <img class="log-avatar" src="avatar.png" alt="primary avatar" />
  </div>
  </div>
</section>
</div>
    </main>
<script>
  const toggleBtn = document.getElementById('toggle-menu');
  const closeBtn = document.getElementById('close-menu');
  const sidebar = document.querySelector('.sidebar');
  const container = document.querySelector('.container');

  toggleBtn.addEventListener('click', () => {
    sidebar.classList.remove('hidden');
    toggleBtn.style.display = 'none';
    container.classList.remove('sidebar-hidden');
  });

  closeBtn.addEventListener('click', () => {
    sidebar.classList.add('hidden');
    toggleBtn.style.display = 'block';
    container.classList.add('sidebar-hidden');
  });
</script>


</body>
</html>