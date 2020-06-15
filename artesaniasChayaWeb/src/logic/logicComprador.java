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
	
	
	
	public String agregar(String user, String contra, String nombre,String telefono
			,String mail,String direccion,String localidad,String provincia)  {
		resultado=null;
		try {
				
			 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
						user,contra);
			 String query = "insert into chaya.comprador (nombre,telefono,mail,direccion,localidad,provincia) values (?,?,?,?,?,?);";
				PreparedStatement pstmt = C.prepareStatement(query);
				
				pstmt.setString(1, nombre);
				pstmt.setString(2, telefono);
				pstmt.setString(3, mail);
				pstmt.setString(4, direccion);
				pstmt.setString(5, localidad);
				pstmt.setString(6, provincia);
				
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
