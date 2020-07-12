package logic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import entities.Producto;

public class logicPedidos {
	Connection C=null;
	PreparedStatement pstmt =null;
	ResultSet rs=null;
	HttpSession miSesion=null;
	String resultado;
	
	public String entregar(String user, String contra, ArrayList<Producto> ped,double descuento,double total,String idComprador) {
	int idPedido=-100;
	resultado=null;
		try {
			
			 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
						user,contra);
			 String query = "insert into presupuesto (fechaHora, subtotal,descontado,idComprador) "
			 		+ "values (now(), ?,?,?)";
			 PreparedStatement pstmt = C.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
				
				pstmt.setDouble(1, total+descuento);
				pstmt.setDouble(2, descuento);
				pstmt.setString(3, idComprador);
				pstmt.executeUpdate();
				ResultSet rs = pstmt.getGeneratedKeys();	
				
				if(rs.next()) {
				idPedido=rs.getInt(1);
				resultado= String.valueOf(idPedido);
				}

				System.out.println("idPedido " +idPedido);
				pstmt.close();
				query = "insert into chaya.lineapresupuesto values (?,?,?);";
				for(Producto p:ped) {
					pstmt = C.prepareStatement(query);	
					pstmt.setInt(1, idPedido );
					pstmt.setString(2, p.getId()); 
					pstmt.setInt(3, p.getCant()); 
					pstmt.executeUpdate();
					
					
				}
				System.out.println("crea las lineas del presupuesto");
				pstmt.close(); 
				 rs.close();		
				 C.close();
		
		
		
		} catch (SQLException e) {
			resultado="-1";
			System.out.println("Error log pedidos");
			System.out.println("Error log pedidos");
			System.out.println("Error log pedidos");
			System.out.println("Error log pedidos");

			
			e.printStackTrace();
		}
		
		
		return resultado;
	}

}
