-- CREATE DATABASE pwn3d;

--=============INFORMACION DE LAS MAQUINAS===============

DROP TABLE IF EXISTS machines;
CREATE TABLE machines (
    id SERIAL PRIMARY KEY,
    name_machine VARCHAR(100),
    size VARCHAR(20),
    os VARCHAR(20),
    enviroment VARCHAR(20),
    enviroment2 VARCHAR(20),
    creator VARCHAR(100),
    difficulty_card VARCHAR(20),
    difficulty VARCHAR(20),
    date VARCHAR(20),
    md5 VARCHAR(64),
    writeup_url TEXT,
    first_user VARCHAR(100),
    first_root VARCHAR(100),
    img_name_os VARCHAR(100),
    download_url TEXT
);

ALTER TABLE machines ALTER COLUMN id TYPE VARCHAR(50);
ALTER TABLE machines ADD COLUMN description TEXT NULL;

--INSERTs de ejemplo

INSERT INTO machines (id, name_machine, size, os, enviroment, enviroment2, creator, difficulty_card, difficulty, date, md5, writeup_url, first_user, first_root, img_name_os, download_url) VALUES (1, 'Lower5', '1.8GB', 'Linux', 'vbox', 'vmware', 'd4t4s3c', 'Very-Easy', 'very-easy', '09 Apr 2025', '65015966EDD9A1A8ACE257DA2F0D9730', 'https://test.com/', 'suraxddq', 'suraxddq', 'Linux', 'https://vulnyx.com/file/Lower5.php');
INSERT INTO machines (id, name_machine, size, os, enviroment, enviroment2, creator, difficulty_card, difficulty, date, md5, writeup_url, first_user, first_root, img_name_os, download_url) VALUES (2, 'Change', '7.7GB', 'Windows', 'vbox', null, 'd4t4s3c', 'Medium', 'medium', '08 Mar 2025', 'B11BED45EF5A1066C68FAE86F398D5CB', 'https://test.com/', 'Flo2699', 'Flo2699', 'Windows', 'https://vulnyx.com/file/Change.php');
INSERT INTO machines (id, name_machine, size, os, enviroment, enviroment2, creator, difficulty_card, difficulty, date, md5, writeup_url, first_user, first_root, img_name_os, download_url) VALUES (3, 'Anon', '1.5GB', 'Linux', 'vbox', 'vmware', 'd4t4s3c', 'Medium', 'medium', '05 Feb 2025', '74849CA997AA235CF3E47914F158024A', 'https://test.com/', 'flower', 'lvzhouhang', 'Linux', 'https://vulnyx.com/file/Anon.php');
INSERT INTO machines (id, name_machine, size, os, enviroment, enviroment2, creator, difficulty_card, difficulty, date, md5, writeup_url, first_user, first_root, img_name_os, download_url) VALUES (4, 'Hit', '1.2GB', 'Linux', 'vbox', 'vmware', 'd4t4s3c', 'Easy', 'easy', '04 Feb 2025', '75841477B83B8C86A6719F43B1A9A457', 'https://test.com/', 'maciiii___', 'maciiii___', 'Linux', 'https://vulnyx.com/file/Hit.php');
INSERT INTO machines (id, name_machine, size, os, enviroment, enviroment2, creator, difficulty_card, difficulty, date, md5, writeup_url, first_user, first_root, img_name_os, download_url) VALUES (5, 'Matrix', '750MB', 'Linux', 'vbox', 'vmware', 'Lenam', 'Medium', 'medium', '30 Jan 2025', '7231B02B3C522DD4AE19917C13FB53F2', 'https://test.com/', 'suraxddq', 'suraxddq', 'Linux', 'https://vulnyx.com/file/Matrix.php');
INSERT INTO machines (id, name_machine, size, os, enviroment, enviroment2, creator, difficulty_card, difficulty, date, md5, writeup_url, first_user, first_root, img_name_os, download_url) VALUES (6, 'Tunnel', '1.2GB', 'Linux', 'vbox', 'vmware', 'd4t4s3c', 'Hard', 'hard', '13 Dec 2024', '3D5D92A73B8130FB1DEA281993A8F5FD', 'https://test.com/', 'll104567', 'll104567', 'Linux', 'https://vulnyx.com/file/Tunnel.php');
INSERT INTO machines (id, name_machine, size, os, enviroment, enviroment2, creator, difficulty_card, difficulty, date, md5, writeup_url, first_user, first_root, img_name_os, download_url) VALUES (7, 'War', '7.2GB', 'Windows', 'vbox', null, 'd4t4s3c', 'Easy', 'easy', '07 Dec 2024', 'A48B73FBA9796957C86C19F8758CC9E5', 'https://test.com/', 'minidump', 'minidump', 'Windows', 'https://vulnyx.com/file/War.php');
INSERT INTO machines (id, name_machine, size, os, enviroment, enviroment2, creator, difficulty_card, difficulty, date, md5, writeup_url, first_user, first_root, img_name_os, download_url) VALUES (8, 'Manager', '1.8GB', 'Linux', 'vbox', 'vmware', 'd4t4s3c', 'Hard', 'hard', '29 Nov 2024', 'EE5082F8354628AC353D9FEF6EB8784C', 'https://test.com/', 'softyhack', 'll104567', 'Linux', 'https://vulnyx.com/file/Manager.php');
INSERT INTO machines (id, name_machine, size, os, enviroment, enviroment2, creator, difficulty_card, difficulty, date, md5, writeup_url, first_user, first_root, img_name_os, download_url) VALUES (9, 'Controler', '5.0GB', 'Windows', 'vbox', null, 'd4t4s3c', 'Medium', 'medium', '23 Oct 2024', '73ECC9FD5D9CEC03A67124D9BE5A2151', 'https://test.com/', 'Rev3rKh1ll', 'Rev3rKh1ll', 'Windows', 'https://vulnyx.com/file/Controler.php');

ALTER TABLE machines
ADD COLUMN user_flag VARCHAR(255) DEFAULT '',
ADD COLUMN root_flag VARCHAR(255) DEFAULT '';

--=============TABLA DE USUARIOS===============
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    rol VARCHAR(20) DEFAULT 'user',
    cookie TEXT,
    flags_user INT DEFAULT 0,
    flags_root INT DEFAULT 0,
    ultimo_inicio TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE users ADD code_secure VARCHAR(255);
ALTER TABLE users ADD COLUMN puntos INT DEFAULT 0;
ALTER TABLE users ADD COLUMN pais VARCHAR(50);
ALTER TABLE users ADD COLUMN loves INTEGER DEFAULT 0;

-- TABLA WRITEUPS ENVIADOS POR EL USUARIO (POR DEFECTO PENDIENTE)

DROP TABLE IF EXISTS writeups;
CREATE TABLE writeups (
    id SERIAL PRIMARY KEY,
    url VARCHAR(500) NOT NULL,
    vm_name VARCHAR(100) NOT NULL,
    user_id INT NOT NULL,
    creator VARCHAR(100) NOT NULL,
    content_type VARCHAR(20) NOT NULL,
    language VARCHAR(20) NOT NULL,
    opinion TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE writeups
ADD COLUMN estado VARCHAR(20) DEFAULT 'Pendiente';

-- TABLA PARA LOS WRITEUPS PUBLICADOS POR EL ADMINISTRADOR

DROP TABLE IF EXISTS writeups_public;
CREATE TABLE writeups_public (
    id SERIAL PRIMARY KEY,
    url TEXT NOT NULL,
    vm_name VARCHAR(100) NOT NULL,
    user_id INTEGER NOT NULL,
    creator VARCHAR(100) NOT NULL,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE writeups_public
ADD COLUMN content_type VARCHAR(20) NOT NULL DEFAULT 'text';
ALTER TABLE writeups_public
ADD COLUMN language VARCHAR(20) NOT NULL DEFAULT 'desconocido';

-- TABLA PARA EL ENVIO DE NUEVAS VMs

DROP TABLE IF EXISTS new_vm;
CREATE TABLE new_vm (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  name_vm VARCHAR(50) NOT NULL,
  difficulty VARCHAR(20) NOT NULL,
  creator VARCHAR(50) NOT NULL,
  url_vm TEXT NOT NULL,
  user_flag VARCHAR(64) NOT NULL,
  root_flag VARCHAR(64) NOT NULL,
  url_writeup TEXT,
  contact VARCHAR(100),
  tags VARCHAR(255),
  estado VARCHAR(20) DEFAULT 'Pendiente',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLA DE FLAGS

DROP TABLE IF EXISTS flags;
CREATE TABLE flags (
    id SERIAL PRIMARY KEY,
    id_user INT NOT NULL,
    vm_name VARCHAR(255) NOT NULL,
    username VARCHAR(50) NOT NULL,
    tipo_flag VARCHAR(10) CHECK (tipo_flag IN ('user', 'root')) NOT NULL,
    flag VARCHAR(255) NOT NULL,
    first_flag_user BOOLEAN NOT NULL,
    first_flag_root BOOLEAN NOT NULL
);
ALTER TABLE flags ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- TABLA ImgPath (FOTO DE PERFIL)

DROP TABLE IF EXISTS imgProfile;
CREATE TABLE imgProfile (
    id SERIAL PRIMARY KEY,
    user_id INT UNIQUE NOT NULL,
    pathImg VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- TABLA PARA EL PERFIL (SISTEMA LINKS)

DROP TABLE IF EXISTS editProfile;
CREATE TABLE editProfile (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    social_icon VARCHAR(255) NOT NULL,
    title_social VARCHAR(100) NOT NULL,
    url_social VARCHAR(255) NOT NULL,
    estado VARCHAR(10) NOT NULL DEFAULT 'Privado' CHECK (estado IN ('Publico','Privado')),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- TABLA DE REQUESTS (JUNTO CON MESSAGES)

DROP TABLE IF EXISTS requests;
CREATE TABLE requests (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    message TEXT NOT NULL,
    estado VARCHAR(20) DEFAULT 'En progreso',
    time_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE requests ADD COLUMN loves INTEGER DEFAULT 0;

-- TABLA DE FEEDBACKS (JUNTO CON MESSAGES)

DROP TABLE IF EXISTS feedbacks;
CREATE TABLE feedbacks (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  message TEXT NOT NULL,
  estado VARCHAR(50) DEFAULT 'Por contestar...',
  time_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLA DE ME GUSTAS (REQUESTS)

DROP TABLE IF EXISTS request_loves;
CREATE TABLE request_loves (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    request_id INTEGER NOT NULL,
    UNIQUE(user_id, request_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (request_id) REFERENCES requests(id)
);

-- TABLA PARA LAS ESTRELLAS DE LAS MAQUINAS

DROP TABLE IF EXISTS stars_machines;
CREATE TABLE stars_machines (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    vm_name VARCHAR(255) NOT NULL,
    number_stars INTEGER CHECK (number_stars >= 1 AND number_stars <= 5),
    time_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, vm_name)
);

-- TABLA DE NOTICIAS DE LA PAGINA PRINCIPAL

CREATE TABLE notices (
    id SERIAL PRIMARY KEY,
    vm_name VARCHAR(100) NOT NULL,
    date VARCHAR(50) NOT NULL,
    creator VARCHAR(100) NOT NULL,
    second_vm_name VARCHAR(100),
    second_date VARCHAR(50),
    second_creator VARCHAR(100),
    created_notice TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description_page TEXT,
    estado VARCHAR(10) NOT NULL
);

-- TABLA AÑADIR INFORMACION DE LA MAQUINA DE LAS NOTICIAS

CREATE TABLE info_notices_machines (
    id SERIAL PRIMARY KEY,
    description TEXT,
    vm_name VARCHAR(100) NOT NULL,
    date TEXT NOT NULL,
    time_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) CHECK (estado IN ('publico', 'privado')) NOT NULL,
    os VARCHAR(50),
    difficulty VARCHAR(50)
);
ALTER TABLE info_notices_machines
ADD COLUMN environment VARCHAR(100);
ALTER TABLE info_notices_machines
ADD COLUMN second_environment VARCHAR(100);
ALTER TABLE info_notices_machines
ADD COLUMN path_info_notice TEXT;
ALTER TABLE info_notices_machines
ADD COLUMN creator VARCHAR(100);

-- TABLA DE BADGES (LOGROS DE LA PAGINA)

CREATE TABLE badges (
    id SERIAL PRIMARY KEY,
    userId INT UNIQUE NOT NULL,
    top1mes BOOLEAN DEFAULT FALSE,
    creador BOOLEAN DEFAULT FALSE,
    "100VMs" BOOLEAN DEFAULT FALSE,
    "200VMs" BOOLEAN DEFAULT FALSE,
    "300VMs" BOOLEAN DEFAULT FALSE,
    "50VMs" BOOLEAN DEFAULT FALSE,
    juniorVM BOOLEAN DEFAULT FALSE,
    hacker BOOLEAN DEFAULT FALSE,
    proHacker BOOLEAN DEFAULT FALSE,
    escritor BOOLEAN DEFAULT FALSE,
    "100Writeups" BOOLEAN DEFAULT FALSE,
    firstRoot BOOLEAN DEFAULT FALSE,
    firstUser BOOLEAN DEFAULT FALSE,
    solucionador BOOLEAN DEFAULT FALSE,
    noob BOOLEAN DEFAULT FALSE,
    top1año BOOLEAN DEFAULT FALSE,
    "1000puntos" BOOLEAN DEFAULT FALSE,
    "100puntos" BOOLEAN DEFAULT FALSE,
    "2000puntos" BOOLEAN DEFAULT FALSE,
    "3000puntos" BOOLEAN DEFAULT FALSE,
    estrellita BOOLEAN DEFAULT FALSE
);
ALTER TABLE badges RENAME COLUMN "100VMs" TO vms100;
ALTER TABLE badges RENAME COLUMN "200VMs" TO vms200;
ALTER TABLE badges RENAME COLUMN "300VMs" TO vms300;
ALTER TABLE badges RENAME COLUMN "50VMs" TO vms50;
ALTER TABLE badges RENAME COLUMN "100Writeups" TO writeups100;
ALTER TABLE badges RENAME COLUMN "100puntos" TO puntos100;
ALTER TABLE badges RENAME COLUMN "1000puntos" TO puntos1000;
ALTER TABLE badges RENAME COLUMN "2000puntos" TO puntos2000;
ALTER TABLE badges RENAME COLUMN "3000puntos" TO puntos3000;
ALTER TABLE badges
ADD COLUMN aprendiz BOOLEAN DEFAULT FALSE,
ADD COLUMN "0xcoffee" BOOLEAN DEFAULT FALSE,
ADD COLUMN anonymous BOOLEAN DEFAULT FALSE,
ADD COLUMN "FuckSystem" BOOLEAN DEFAULT FALSE,
ADD COLUMN god BOOLEAN DEFAULT FALSE;

-- TABLA LOVES DE USERS PUBLICS

DROP TABLE IF EXISTS lovesusers;
CREATE TABLE lovesusers (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    user_id_guest INTEGER NOT NULL,
    loves INTEGER DEFAULT 1,
    UNIQUE(user_id, user_id_guest), -- Solo un love por visitante
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id_guest) REFERENCES users(id) ON DELETE CASCADE
);

-- TABLA DONDE SE GUARDAN LOS MENSAJES

CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    sender_id INTEGER NOT NULL REFERENCES users(id),
    receiver_id INTEGER NOT NULL REFERENCES users(id),
    content TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE
);
