package modelo;

import java.sql.Date;

public class Producto {
	
	private int idProducto;
	private String nombre;
	private int cantidad;
	private double precio;
	private Date fechaCreacion;
	private Date fechaActualizacion;
	
	public Producto() {
		
	}
	
	public Producto(int idProducto, String nombre, int cantidad, double precio, Date fechaCreacion,
			Date fechaActualizacion) {
		super();
		this.idProducto = idProducto;
		this.nombre = nombre;
		this.cantidad = cantidad;
		this.precio = precio;
		this.fechaCreacion = fechaCreacion;
		this.fechaActualizacion = fechaActualizacion;
	}

	public int getIdProducto() {
		return idProducto;
	}

	public void setIdProducto(int idProducto) {
		this.idProducto = idProducto;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public int getCantidad() {
		return cantidad;
	}

	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}

	public double getPrecio() {
		return precio;
	}

	public void setPrecio(double precio) {
		this.precio = precio;
	}

	public Date getFechaCreacion() {
		return fechaCreacion;
	}

	public void setFechaCreacion(Date fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}

	public Date getFechaActualizacion() {
		return fechaActualizacion;
	}

	public void setFechaActualizacion(Date fechaActualizacion) {
		this.fechaActualizacion = fechaActualizacion;
	}

	@Override
	public String toString() {
		return "PRODUCTO: " + "\n" 
				+ "\t" + "ID:" + this.idProducto + "\n"
				+ "\t" + "Nombre: " + this.nombre + "\n"
				+ "\t" + "Cantidad: " + this.cantidad + "\n"
				+ "\t" + "Precio: " + this.precio + "\n"
				+ "\t" + "Fecha de Creacion: " + this.fechaCreacion + "\n"
				+ "\t" + "Fecha de Actualizacion: " + this.fechaActualizacion + "\n";
	}
	
}