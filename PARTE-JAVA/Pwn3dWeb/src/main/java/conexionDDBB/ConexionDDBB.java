package conexionDDBB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDDBB {
	/*============================================================================
	 * Constantes con los parámetros necesarios para conectarse a la base de datos
	   DRIVER: clase del driver JDBC de PostgreSQL
	   URL: dirección del servidor y base de datos
	   USER: usuario de la base de datos
	   PASSWORD: contraseña del usuario
	 * ============================================================================*/
	private static final String DRIVER = "org.postgresql.Driver";
	private static final String URL = "jdbc:postgresql://localhost:5432/hackend";
	private static final String USER = "postgres";
	private static final String PASSWORD = "1234";
	
	/* ==================================================================
	 * Objeto que almacenará la conexión establecida con la base de datos
	 * ==================================================================*/
	private Connection conexion = null;
	
	/* ==================================================================
	    Bloque estático que carga el driver JDBC al iniciar la clase
		Es necesario para que el DriverManager pueda utilizarlo
	   ==================================================================
	 */
	
	static{
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/* ==================================================================
	   Método que establece la conexión con la base de datos
	   Devuelve un objeto Connection si la conexión es exitosa
	   ==================================================================
	 */
	public Connection conectar() {
		try {
			conexion = DriverManager.getConnection(URL, USER, PASSWORD);
			System.out.println("Conexión a BDDD OK");
		} catch (SQLException e) {
			System.err.println("Error en la conexión a BBDD");
			e.printStackTrace();
		}
		return conexion;
	}
	
	/* ===================================================================
	    Método que cierra la conexión con la base de datos
		Imprime mensajes según si el cierre fue exitoso o no
	   ==================================================================
	 */
	public void cerrarConexion() {
		try {
			conexion.close();
			System.out.println("¡¡Conexión con BBDD cerrada!!");
		} catch (SQLException e) {
			System.err.println("Error al cerrar la BBDD");
			e.printStackTrace();
		}
	}

}