package entities;

import java.sql.Date;

public class ProductoConAumentoPrecio {
	
	private String nombre,id;
	private float precio;
	private Date fecha_desde;
	private float aumento;
	private String modoAumento;
	
	
	public float getAumento() {
		return aumento;
	}
	public void setAumento(float aumento) {
		this.aumento = aumento;
	}
	public String getModoAumento() {
		return modoAumento;
	}
	public void setModoAumento(String modoAumento) {
		this.modoAumento = modoAumento;
	}
	public Date getFecha_desde() {
		return fecha_desde;
	}
	public void setFecha_desde(Date fecha_desde) {
		this.fecha_desde = fecha_desde;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
