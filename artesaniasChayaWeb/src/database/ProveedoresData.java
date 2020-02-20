package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entities.Proveedor;

public class ProveedoresData {
	Connection C = null;
	ResultSet rs=null;
	PreparedStatement pstmt=null;
	
	
	public ArrayList<Proveedor> getAll(String user, String contra) throws SQLException {
ArrayList<Proveedor> provList =null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
					user,contra);
		
			 provList = new ArrayList<Proveedor>();
				String query = "SELECT * FROM chaya.proveedor;";
				PreparedStatement pstmt = C.prepareStatement(query);
				
				rs = pstmt.executeQuery();
					 
				while(rs.next()) {
						Proveedor prov = new Proveedor();
						prov.setCuit(rs.getInt("cuitProveedor"));
						prov.setDireccion(rs.getString("direccion"));
						prov.setRazonSocial(rs.getString("razon_social"));
						prov.setTelefono(rs.getString("telefono"));
						provList.add(prov);
				}
			rs.close();	
			pstmt.close();
		
		
	}catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		return provList;

}
	
}
