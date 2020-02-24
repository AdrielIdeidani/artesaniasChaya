package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ProductosServlet
 */
@WebServlet("/ProductosServlet")
public class ProductosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection C=null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductosServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
 public void destroy() {
    	
        try {
    		C.close();
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
        }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

String action = request.getParameter("auction");
HttpSession miSesion= request.getSession(false);
String user= miSesion.getAttribute("usuario").toString();
String contra =miSesion.getAttribute("contra").toString();


if (action.contains("eliminar")) {
	
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
					user,contra);
		 String query = "Delete from chaya.producto where idProducto=?";
			PreparedStatement pstmt = C.prepareStatement(query);
			pstmt.setString(1, request.getParameter("aux") );

			pstmt.executeUpdate();
			pstmt.close();
			
		
	}
	catch (Exception e) {
		System.out.println("Tira Error");

	}
	
	response.sendRedirect("Productos/listaProd.jsp");
}//Fin del elimnar
else if (action.contains("modificar")) {
	response.sendRedirect("Productos/nuevoProd.jsp?idProducto="+request.getParameter("aux"));

}
		 
}





	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String user= request.getParameter("user");
		String contra =request.getParameter("contra");
		
		if (request.getParameter("auction").contains("agregar")) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
						user,contra);
			 
			 String query = "call crearProd(?,?,?,?);";
				PreparedStatement pstmt = C.prepareStatement(query);
				pstmt.setString(1, request.getParameter("id") );
				pstmt.setString(2, request.getParameter("nombre"));
				pstmt.setString(3, request.getParameter("stock"));
				pstmt.setString(4, request.getParameter("precio") );

				pstmt.executeUpdate();
				pstmt.close();
				
			
		}
		catch (Exception e) {
			System.out.println("Tira Error");

		}
		}else if(request.getParameter("auction").contains("modificar")) {
			try {
				Class.forName("com.mysql.jdbc.Driver");
				 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
							user,contra);
				 
				 String query = "update chaya.producto set idProducto=?, descripcion=?,stock=? where idProducto=?;";
					PreparedStatement pstmt = C.prepareStatement(query);
					pstmt.setString(1, request.getParameter("id") );
					pstmt.setString(2, request.getParameter("nombre"));
					pstmt.setString(3, request.getParameter("stock"));
					pstmt.setString(4, request.getParameter("aux") );

					pstmt.executeUpdate();
					pstmt.close();
			}
			catch (Exception e) {
				
			}
		}
		
		response.sendRedirect("Productos/listaProd.jsp");
	}

}
