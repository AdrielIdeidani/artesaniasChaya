package entities;

import java.sql.Date;

public class Producto {
	private int id, stock,cant;
	

	private String nombre;
	private float precio;
	private Date fecha_desde;
	
	public Producto() {
		this.cant=1;
	}
	public int getCant() {
		return cant;
	}
	public void setCant(int cant) {
		this.cant = cant;
	}
	public Date getFecha_desde() {
		return fecha_desde;
	}
	public void setFecha_desde(Date fecha_desde) {
		this.fecha_desde = fecha_desde;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}



	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public float getPrecio() {
		return precio;
	}
	public void setPrecio(float precio) {
		this.precio = precio;
	}
}
