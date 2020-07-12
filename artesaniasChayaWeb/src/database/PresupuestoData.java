package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entities.Presupuesto;
import entities.Producto;

public class PresupuestoData {
	Connection C = null;
	ResultSet rs=null;
	PreparedStatement pstmt=null;
	public ArrayList<Presupuesto> getVendidoBetween(String user, String contra,String desde,String hasta) throws SQLException {
		ArrayList<Presupuesto> listaPres = new ArrayList<Presupuesto>();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
					user,contra);
		
			String query ="call presupuestosBetween(?,?)";
			 PreparedStatement pstmt = C.prepareStatement(query);
			 
				pstmt.setString(1, desde);
				pstmt.setString(2, hasta);
				rs = pstmt.executeQuery();
				
		
				while (rs.next()) {
					Presupuesto pres = new Presupuesto();
					pres.setCodigoPostal(rs.getString("codigoPostal"));
					pres.setCuit(rs.getString("cuit"));
					pres.setDescuento(rs.getDouble("descontado"));
					pres.setDireccion(rs.getString("direccion"));
					pres.setFecha(rs.getDate("fecha").toLocalDate());
					pres.setLocalidad(rs.getString("localidad"));
					pres.setMail(rs.getString("mail"));
					pres.setNombre(rs.getString("nombre"));
					pres.setNro(rs.getInt("idPresupuesto"));
					pres.setProvincia(rs.getString("provincia"));
					pres.setSubtotal(rs.getDouble("subtotal"));
					pres.setTelefono(rs.getString("telefono"));
					ArrayList<Producto>aux = new ArrayList<Producto>();
					pres.setProds(aux);
					listaPres.add(pres);
					
					
					
				}
				
				rs.close();	
				pstmt.close();
				 query ="call prodsPres(?,?)";
				 
				for(Presupuesto p:listaPres) {
					 pstmt = C.prepareStatement(query);
					 
						pstmt.setInt(1, p.getNro());
						pstmt.setDate(2, java. sql. Date. valueOf(p.getFecha()));
						rs = pstmt.executeQuery();
						while(rs.next()) {
							Producto prod = new Producto();
							prod.setId(rs.getString("idProducto"));
							prod.setNombre(rs.getString("descripcion"));
							prod.setPrecio(rs.getFloat("precio"));
							prod.setCant(rs.getInt("cantidad"));
							p.getProds().add(prod);
							
						}
				}
				
				rs.close();	
				pstmt.close();

			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listaPres;
	}

}
