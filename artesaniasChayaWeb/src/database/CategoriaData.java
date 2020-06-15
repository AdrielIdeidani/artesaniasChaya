package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entities.Comprador;

public class CategoriaData {
	Connection C = null;
	ResultSet rs=null;
	PreparedStatement pstmt=null;
	
	
	public ArrayList<String> getAll(String user, String contra) throws SQLException {
		ArrayList<String> categorias = new ArrayList<String>();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
					user,contra);
		
			 

			 String query = "select distinct codigo from categoria order by 1 asc;";
				PreparedStatement pstmt = C.prepareStatement(query);
				
				rs = pstmt.executeQuery();
					 
				while(rs.next()) {
						categorias.add(rs.getString("codigo"));
				}
			rs.close();	
			pstmt.close();
			
					
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return categorias;
	}
	
	public ArrayList<String> getAllExceptOne(String user, String contra, String codigo) throws SQLException {
		ArrayList<String> categorias = new ArrayList<String>();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
					user,contra);
		
			 

			 String query = "select distinct codigo from categoria where codigo <> ? order by 1 asc;";
				PreparedStatement pstmt = C.prepareStatement(query);
				pstmt.setString(1,codigo);
				rs = pstmt.executeQuery();
					 
				while(rs.next()) {
						categorias.add(rs.getString("codigo"));
				}
			rs.close();	
			pstmt.close();
			
					
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return categorias;
	}
}
