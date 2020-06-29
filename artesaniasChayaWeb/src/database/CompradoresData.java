package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpSession;

import entities.Comprador;

public class CompradoresData {
	Connection C = null;
	ResultSet rs=null;
	PreparedStatement pstmt=null;
	
	
	public ArrayList<Comprador> getAll(String user, String contra) throws SQLException {
		ArrayList<Comprador> compList =null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
					user,contra);
		
			 compList = new ArrayList<Comprador>();

			 String query = "select * from comprador where baja is null or baja ='0';";
				PreparedStatement pstmt = C.prepareStatement(query);
				
				rs = pstmt.executeQuery();
					 
				while(rs.next()) {
						Comprador comp = new Comprador();
						comp.setCodigoPostal(rs.getString("codigoPostal"));
						comp.setCuit(rs.getInt("cuit"));
						comp.setTelefono(rs.getString("telefono"));
						comp.setNombre(rs.getString("nombre"));
						comp.setMail(rs.getString("mail"));
						comp.setDireccion(rs.getString("direccion"));
						comp.setLocalidad(rs.getString("localidad"));
						
						comp.setProvincia(rs.getString("provincia"));
				
						compList.add(comp);
				}
			rs.close();	
			pstmt.close();
			
					
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return compList;
	}
	
	
	
	
	public Comprador getOne(String user, String contra, String id) throws SQLException {
		
		Comprador comp = new Comprador();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
					user,contra);
		
			 

			 String query = "select * from comprador where cuit=?;";
				PreparedStatement pstmt = C.prepareStatement(query);
				pstmt.setString(1,id );
				rs = pstmt.executeQuery();
					 
				while(rs.next()) {
						
						comp.setTelefono(rs.getString("telefono"));
						comp.setNombre(rs.getString("nombre"));
						comp.setMail(rs.getString("mail"));
						comp.setCodigoPostal(rs.getString("codigoPostal"));
						comp.setCuit(rs.getInt("cuit"));
						comp.setDireccion(rs.getString("direccion"));
						comp.setLocalidad(rs.getString("localidad"));
						comp.setProvincia(rs.getString("provincia"));
				
						
				}
			rs.close();	
			pstmt.close();
			
					
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return comp;
	}
}
