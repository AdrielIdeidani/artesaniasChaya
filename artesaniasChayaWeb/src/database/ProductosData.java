package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpSession;

import entities.Producto;
import entities.ProductoConAumentoPrecio;

public class ProductosData {
	Connection C = null;
	ResultSet rs=null;
	PreparedStatement pstmt=null;
	
	
	public ArrayList<Producto> getAll(String user, String contra) throws SQLException {
		ArrayList<Producto> prodList =null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
					user,contra);
		
			 prodList = new ArrayList<Producto>();

			 String query = "call preciosActuales();";
				PreparedStatement pstmt = C.prepareStatement(query);
				
				rs = pstmt.executeQuery();
					 
				while(rs.next()) {
						Producto prod = new Producto();
						prod.setId(rs.getString("idProducto"));
						prod.setPrecio(rs.getFloat("precio"));
						prod.setNombre(rs.getString("descripcion"));
						prod.setFecha_desde(rs.getDate("fecha_desde"));
						prod.setCategoria(rs.getString("codigo"));
						prod.setEmpresa(rs.getString("nombre"));
						prodList.add(prod);
				}
			rs.close();	
			pstmt.close();
			
					
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return prodList;
	}
	
	public ArrayList<ProductoConAumentoPrecio> getAllConAumentoPrecio(String user, String contra, String[] ids) throws SQLException {
		ArrayList<ProductoConAumentoPrecio> prodList =null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
					user,contra);
		
			 prodList = new ArrayList<ProductoConAumentoPrecio>();

			 String query = "call preciosActuales();";
				PreparedStatement pstmt = C.prepareStatement(query);
				
				rs = pstmt.executeQuery();
					 
				while(rs.next() && Arrays.asList(ids).contains(rs.getString("idProducto"))) {
						ProductoConAumentoPrecio prod = new ProductoConAumentoPrecio();
						prod.setId(rs.getString("idProducto"));
						prod.setPrecio(rs.getFloat("precio"));
						prod.setNombre(rs.getString("descripcion"));
						prod.setFecha_desde(rs.getDate("fecha_desde"));
						
						prodList.add(prod);
				}
			rs.close();	
			pstmt.close();
			
					
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return prodList;
	}
	
	
}
