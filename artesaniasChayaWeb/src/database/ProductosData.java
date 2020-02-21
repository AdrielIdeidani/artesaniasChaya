package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpSession;

import entities.Producto;

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
//				String query = "drop temporary table if exists tfecha;" +
//				"create temporary table tfecha"+ 
//				"select idProducto, max(fecha_desde) as fecha_desde from precios"+
//				"	group by 1;"+
//
//				"drop temporary table if exists tprecio;"+
//				"create temporary table tprecio"+
//				"select t.idProducto, pro.descripcion,pro.stock,precio"+
//				"from precios p"+
//				"inner join tfecha t on p.idProducto = t.idProducto"+
//				"inner join producto pro on pro.idProducto= p.idProducto"+
//				"where p.fecha_desde = t.fecha_desde;"+
//				 
//				"select * from tprecio;";
			 String query = "call preciosActuales();";
				PreparedStatement pstmt = C.prepareStatement(query);
				
				rs = pstmt.executeQuery();
					 
				while(rs.next()) {
						Producto prod = new Producto();
						prod.setId(rs.getInt("idProducto"));
						prod.setNombre(rs.getString("descripcion"));
						prod.setPrecio(rs.getFloat("precio"));
						prod.setStock(rs.getInt("stock"));
						prodList.add(prod);
				}
			rs.close();	//Si los saco de aca tira error, pero para mi no deberian aca e ir en el finally
			pstmt.close();
			
					
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return prodList;
	}
}
