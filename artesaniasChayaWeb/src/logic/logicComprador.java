package logic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import entities.Comprador;

public class logicComprador {
	Connection C=null;
	PreparedStatement pstmt =null;
	ResultSet rs=null;
	HttpSession miSesion=null;
	String resultado;
	String idPedNuevo=null;
	
	public String eliminar(String user, String contra, String id)  {
		resultado=null;
		try {
				
			 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
						user,contra);
			 String query = "update chaya.comprador set baja=1 where cuit=?;";
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
	
	public String modificar(String user, String contra,String idOrg,String id, String nombre,String telefono
			,String mail,String direccion,String localidad, String codigoPostal,String provincia)  {
		resultado=null;
		try {
				
			 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
						user,contra);
			 String query = "update chaya.comprador set cuit=?,nombre=?, telefono=?,mail=?,direccion=?,localidad=?,codigoPostal=?,provincia =? where cuit=?";
				PreparedStatement pstmt = C.prepareStatement(query);
				
				pstmt.setString(1, id);
				pstmt.setString(2, nombre);
				pstmt.setString(3, telefono);
				pstmt.setString(4, mail);
				pstmt.setString(5, direccion);
				pstmt.setString(6, localidad);
				pstmt.setString(7, codigoPostal);
				pstmt.setString(8, provincia);
				pstmt.setString(9, idOrg);

				pstmt.executeUpdate();
				pstmt.close();
				C.close();
			} catch (SQLException e) {
				resultado=e.getMessage();
				e.printStackTrace();
			}
		return resultado;
	}
	
	public String agregar(String user, String contra, String id,String nombre,String telefono
			,String mail,String direccion,String localidad, String codigoPostal,String provincia)  {
		resultado=null;
		try {
				
			 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
						user,contra);
			 String query = "insert into chaya.comprador (cuit,nombre,telefono,mail,direccion,localidad,codigoPostal,provincia) values (?,?,?,?,?,?,?,?);";
				PreparedStatement pstmt = C.prepareStatement(query);
				
				pstmt.setString(1, id);
				pstmt.setString(2, nombre);
				pstmt.setString(3, telefono);
				pstmt.setString(4, mail);
				pstmt.setString(5, direccion);
				pstmt.setString(6, localidad);
				pstmt.setString(7, codigoPostal);
				pstmt.setString(8, provincia);
				
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
