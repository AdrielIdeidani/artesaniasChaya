package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class EmpresaData {
	Connection C = null;
	ResultSet rs=null;
	PreparedStatement pstmt=null;
	
	
	public ArrayList<String> getAll(String user, String contra) throws SQLException {
		ArrayList<String> empresas = new ArrayList<String>();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
					user,contra);
		
			 

			 String query = "select distinct nombre from empresa order by 1 asc;";
				PreparedStatement pstmt = C.prepareStatement(query);
				
				rs = pstmt.executeQuery();
					 
				while(rs.next()) {
						empresas.add(rs.getString("nombre"));
				}
			rs.close();	
			pstmt.close();
			
					
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return empresas;
	}

	public ArrayList<String> getAllExceptOne(String user, String contra,String empresa) throws SQLException {
		ArrayList<String> empresas = new ArrayList<String>();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
					user,contra);
		
			 

			 String query = "select distinct nombre from empresa where nombre <> ? order by 1 asc;";
				PreparedStatement pstmt = C.prepareStatement(query);
				pstmt.setString(1,empresa);
				rs = pstmt.executeQuery();
					 
				while(rs.next()) {
						empresas.add(rs.getString("nombre"));
				}
			rs.close();	
			pstmt.close();
			
					
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return empresas;
	}
	
}
