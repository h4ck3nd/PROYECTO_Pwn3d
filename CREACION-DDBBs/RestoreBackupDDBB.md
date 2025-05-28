# Restaurar un archivo `.backup` en PostgreSQL 17 usando PgAdmin 4

Este documento explica cómo realizar un **Restore** de un archivo `.backup` en **PostgreSQL 17** usando **PgAdmin 4**, asegurándote de que la versión correcta del binario esté configurada, lo cual es importante cuando trabajas con múltiples versiones de PostgreSQL en el mismo sistema.

## 📌 Requisitos previos

- Tener instalado PostgreSQL 17 en tu sistema. [Descargar Instalador para PostgreSQL 17](https://drive.google.com/file/d/1vT9p-JnP-QtLzmNnrDaolxa65-m8FZTe/view?usp=sharing)
- Disponer del archivo `.backup` generado previamente desde PostgreSQL.
- Tener acceso a PgAdmin 4.

---

## 🔧 1. Configurar la ruta del binario de PostgreSQL 17

Esto es necesario para que PgAdmin 4 use las utilidades (como `pg_restore`) correspondientes a PostgreSQL 17.

1. Abre **PgAdmin 4**.
2. Ve a la barra de menú:  
   `File` → `Preferences` → `Paths` → `Binary Paths`.

   ![image](https://github.com/user-attachments/assets/bdd4cdbc-5bb8-4e3b-a382-8d43f041d852)

   ![image](https://github.com/user-attachments/assets/e5d50243-5bff-4333-a06b-9e3933cc190d)
   
4. En la sección **PostgreSQL Binary Paths**:
   - Haz clic en el ícono de agregar (➕) si no aparece la versión 17.
   - Establece la ruta del binario. Por defecto, si instalaste PostgreSQL en Windows, la ruta suele ser:
     ```
     C:\Program Files\PostgreSQL\17\bin
     ```
   - Marca la casilla `Set as default`.
   - Haz clic en **Save** para guardar la configuración.

---

## 🧪 2. Verificar que se esté utilizando PostgreSQL 17

1. Crea una base de datos vacía desde PgAdmin.
2. Abre el **Query Tool** (herramienta de consulta).
3. Ejecuta la siguiente consulta:

   ```sql
   SELECT version();
   ```
   
4. Verifica que la salida indique algo como:

   ```csharp
   PostgreSQL 17.x on x86_64-pc-windows, compiled by ...
   ```

   Esto confirma que estás utilizando la versión correcta del binario.

---

## ♻️ 3. Restaurar el archivo `.backup`

Con la configuración y verificación completadas, ahora puedes restaurar la base de datos:

1. Haz clic derecho sobre la base de datos vacía que creaste.
2. Selecciona Restore.
3. En el diálogo que se abre:
  - En el campo Format, selecciona `Custom or tar`.
  - En Filename, selecciona el archivo `.backup` desde tu sistema de archivos.
  - En Restore Options, marca las opciones necesarias, como:
    - `Clean before restore` si quieres borrar lo que haya previamente.
    - `Create database` si estás restaurando directamente una base de datos completa.
4. Haz clic en Restore.

---

## ✅ Confirmar la restauración

Una vez finalizado el proceso:
- Puedes actualizar los objetos desde el panel izquierdo (clic derecho → Refresh).
- Verifica que las tablas, funciones, esquemas y datos han sido restaurados correctamente.
- Si hubo errores, consulta el log que muestra PgAdmin en la parte inferior.

---

## 📝 Notas adicionales

- Asegúrate de que el archivo `.backup` fue generado con `pg_dump` desde `PostgreSQL 17` o compatible.
- No puedes restaurar directamente una base de datos `.backup` de una versión más reciente (ej. 17) en una versión anterior (ej. 16) sin errores o conflictos. En ese caso deberías usar `pg_dump` con formato SQL o migrar datos manualmente.

---

## 📂 Referencia de rutas

```
Plataforma	Ruta común del binario

Windows	  C:\Program Files\PostgreSQL\17\bin
Linux	    /usr/lib/postgresql/17/bin/ (según distro)
MacOS	    /Library/PostgreSQL/17/bin o vía Homebrew
```
