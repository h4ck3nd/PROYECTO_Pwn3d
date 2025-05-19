package controlador;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductoDAO;
import modelo.Producto;

/**
 * Servlet implementation class ProductoControlador
 */
@WebServlet("/ProductoControlador")
public class ProductoControlador extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductoControlador() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String opcion = request.getParameter("opcion");
		
		// Si la opción es crearTabla, creamos la tabla y redirigimos a index.jsp
        if (opcion != null && opcion.equalsIgnoreCase("crearTabla")) {
            System.out.println("Has pulsado la opción crearTabla.");
            ProductoDAO productoDAO = new ProductoDAO();
            if (productoDAO.createTable()) {
                System.out.println("Tabla PRODUCTO creada correctamente!!");
            }
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("vistas/index.jsp");
            requestDispatcher.forward(request, response);
        }
        // Si la opción es insertar, redirigimos a insertar.jsp
        else if (opcion.equalsIgnoreCase("insertar")) {
        	System.out.println("HAS PULSADO LA OPCION INSERTAR");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("vistas/insertar.jsp");
            requestDispatcher.forward(request, response);
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String opcion = request.getParameter("opcion");
		
		Date fechaActual = new Date();
				
		if(opcion.equalsIgnoreCase("insertar")) {
			ProductoDAO productoDAO = new ProductoDAO();
			Producto producto = new Producto();
			// Cogemos los datos introducidos en la interfaz HTML
			producto.setNombre(request.getParameter("nombre")); // El valor de "name"
			producto.setCantidad(Integer.valueOf(request.getParameter("cantidad"))); //Castear el valor en Entero
			producto.setPrecio(Double.valueOf(request.getParameter("precio")));
			producto.setFechaCreacion(new java.sql.Date(fechaActual.getTime()));
			
			if(productoDAO.insertar(producto)) {
				System.out.println("Producto insertado correctamente");
			}
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("vistas/index.jsp");
			requestDispatcher.forward(request, response);
		}
	}

}