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

