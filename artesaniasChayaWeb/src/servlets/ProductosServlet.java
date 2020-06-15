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

import logic.logicProductos;

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
logicProductos lp = new logicProductos();

if (action.contains("eliminar")) {
	String resultado=lp.borrar(user, contra, request.getParameter("aux"));
	
	
	
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
		
		
		
		HttpSession miSesion= request.getSession(false);
		String user= miSesion.getAttribute("usuario").toString();
		String contra =miSesion.getAttribute("contra").toString();
		logicProductos lp = new logicProductos();
		if (request.getParameter("auction").contains("agregar")) {
			String resultado= lp.agregar(user,contra,
					request.getParameter("id"),Double.parseDouble(request.getParameter("precio")),
					request.getParameter("nombre"),request.getParameter("empresa"),request.getParameter("categoria"));
		
			
			
		}else if(request.getParameter("auction").contains("modificar")) {
			
			String resultado=lp.modificar(user,contra,
					request.getParameter("id"),request.getParameter("nombre"),
					request.getParameter("empresa"),request.getParameter("categoria"),request.getParameter("aux"));
			
		}
		
		response.sendRedirect("Productos/listaProd.jsp");
	}

}
