package logic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpSession;

import database.ProductosData;
import entities.Producto;
import entities.ProductoConAumentoPrecio;

public class logicProductos {
	Connection C=null;
	PreparedStatement pstmt =null;
	ResultSet rs=null;
	HttpSession miSesion=null;
	String resultado;
	String idPedNuevo=null;
	
	public String actualizarPrecios(String user, String contra, ArrayList<ProductoConAumentoPrecio> prods) {
		resultado=null;
		try {
			
			 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
						user,contra);
			 String query = "insert into chaya.precios(idProducto,fecha_desde,precio) values(?,now(),?) ";
				
			 for(ProductoConAumentoPrecio pr:prods) {
				 PreparedStatement pstmt = C.prepareStatement(query);
				 
					pstmt.setString(1, pr.getId());
					pstmt.setDouble(2, pr.getAumento());
					pstmt.executeUpdate();
					pstmt.close();
			 }
			 
				
				
				
				C.close();
			} catch (SQLException e) {
				resultado=e.getMessage();
				e.printStackTrace();
			}
		return resultado;
	}
	public ArrayList<ProductoConAumentoPrecio> asignarNuevosPreciosCantidad(String user, String contra, String[] ids, String aumento) throws SQLException {
		resultado=null;
		ArrayList<ProductoConAumentoPrecio> prodList = new ArrayList<ProductoConAumentoPrecio> ();
		ProductosData pd = new ProductosData();
		ArrayList<Producto> prods = pd.getAll(user, contra);
		
		for (String id : ids) {
			System.out.println("Id original " + id);
			for (Producto pro:prods) {
				System.out.println("Id productos " + pro.getId());
				if(id.equals(pro.getId())) {
					System.out.println("Entro!");
					ProductoConAumentoPrecio prodAum= new ProductoConAumentoPrecio();
					prodAum.setId(id);
					prodAum.setFecha_desde(pro.getFecha_desde());
					prodAum.setAumento(pro.getPrecio()+Float.parseFloat(aumento));
					prodAum.setPrecio(pro.getPrecio());
					prodAum.setNombre(pro.getNombre());
					prodAum.setModoAumento("Cantidad");
					System.out.println(prodAum.getId() + "Id");
					prodList.add(prodAum);
					break;
				}
				
			}
			
		}
		

		return prodList;

	}
	
	public ArrayList<ProductoConAumentoPrecio> asignarNuevosPreciosPorcentaje(String user, String contra, String[] ids, String aumento) throws SQLException {
		resultado=null;
		ArrayList<ProductoConAumentoPrecio> prodList = new ArrayList<ProductoConAumentoPrecio> ();
		ProductosData pd = new ProductosData();
		ArrayList<Producto> prods = pd.getAll(user, contra);
		
		for (String id : ids) {
			//System.out.println("Id original " + id);
			for (Producto pro:prods) {
				//System.out.println("Id productos " + pro.getId());
				if(id.equals(pro.getId())) {
					//System.out.println("Entro!");
					ProductoConAumentoPrecio prodAum= new ProductoConAumentoPrecio();
					prodAum.setId(id);
					prodAum.setFecha_desde(pro.getFecha_desde());
					prodAum.setAumento(pro.getPrecio()+ Float.parseFloat(aumento)*pro.getPrecio()/100);
					prodAum.setPrecio(pro.getPrecio());
					prodAum.setNombre(pro.getNombre());
					prodAum.setModoAumento("Porcentaje");
					//System.out.println(prodAum.getId() + "Id");
					prodList.add(prodAum);
					break;
				}
				
			}
			
		}
		

		return prodList;

	}
	
	
	public ArrayList<ProductoConAumentoPrecio> asignarNuevosPreciosTotal(String user, String contra, String[] ids, String aumento) throws SQLException {
		resultado=null;
		ArrayList<ProductoConAumentoPrecio> prodList = new ArrayList<ProductoConAumentoPrecio> ();
		ProductosData pd = new ProductosData();
		ArrayList<Producto> prods = pd.getAll(user, contra);
		
		for (String id : ids) {
			//System.out.println("Id original " + id);
			for (Producto pro:prods) {
				//System.out.println("Id productos " + pro.getId());
				if(id.equals(pro.getId())) {
					//System.out.println("Entro!");
					ProductoConAumentoPrecio prodAum= new ProductoConAumentoPrecio();
					prodAum.setId(id);
					prodAum.setFecha_desde(pro.getFecha_desde());
					prodAum.setAumento(Float.parseFloat(aumento));
					prodAum.setPrecio(pro.getPrecio());
					prodAum.setNombre(pro.getNombre());
					prodAum.setModoAumento("Porcentaje");
					//System.out.println(prodAum.getId() + "Id");
					prodList.add(prodAum);
					break;
				}
				
			}
			
		}
		

		return prodList;

	}
	
	
	public String agregar(String user, String contra, String codigo, double precio,
			String descripcion, String empresa, String categoria)  {
		resultado=null;
		try {
				
			 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
						user,contra);
			 String query = "call crearProd(?,?,?,?,?)";
				PreparedStatement pstmt = C.prepareStatement(query);
				
				pstmt.setString(1, codigo);
				pstmt.setString(2, descripcion);
				pstmt.setDouble(3, precio);
				pstmt.setString(4, categoria);
				pstmt.setString(5, empresa);

				
				pstmt.executeUpdate();
				pstmt.close();
				C.close();
			} catch (SQLException e) {
				resultado=e.getMessage();
				e.printStackTrace();
			}
		return resultado;
	}
	
	public String modificar(String user, String contra, String codigo, 
			String descripcion, String empresa, String categoria, String idViejo)  {
		resultado=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
						user,contra);
			 
			 	String query = "call updateProducto(?,?,?,?,?)";
				PreparedStatement pstmt = C.prepareStatement(query);
				pstmt.setString(1, categoria.concat(codigo) );
				pstmt.setString(2, descripcion);
				pstmt.setString(3, categoria);
				pstmt.setString(4, empresa );
				pstmt.setString(5, idViejo);

				pstmt.executeUpdate();
				pstmt.close();
		}
		catch (Exception e) {
			resultado=e.getMessage();
			e.printStackTrace();
		}
		return resultado;
	}
	
	
	public String borrar(String user, String contra, String id)  {
		resultado=null;
		try {
				
			 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
						user,contra);
			 String query = "delete from producto where idProducto=?";
				PreparedStatement pstmt = C.prepareStatement(query);
				
				pstmt.setString(1, id);
				

				
				pstmt.executeUpdate();
				pstmt.close();
				C.close();
			} catch (SQLException e) {
				resultado=e.getMessage();
				e.printStackTrace();
			}
		return resultado;
	}
}
