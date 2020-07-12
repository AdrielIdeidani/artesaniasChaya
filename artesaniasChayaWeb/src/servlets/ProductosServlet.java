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
	
	
	if(resultado== null) {
	response.sendRedirect("Productos/listaProd.jsp");
	}
	else {
		response.sendRedirect("Productos/listaProd.jsp?resultado="+resultado);
			}
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
		String resultado="";
		boolean bandera =false;
		if (request.getParameter("auction").contains("agregar")) {
			String empresa= request.getParameter("empresa");
			String categoria =request.getParameter("categoria");
			String precio =request.getParameter("precio");
			String nombre= request.getParameter("nombre");
			String id=request.getParameter("id");
			if(empresa.contentEquals("") || categoria.contentEquals("")) {
				resultado=resultado.concat("\nFaltó asignar empresa y/o categoria!");
				bandera=true;

			}
			
				
				if(nombre.contentEquals("")) {
					resultado=resultado.concat("\nFalta asignar nombre al producto!");

					bandera=true;

				}
			
				 if(id.contentEquals("")) {
					 resultado= resultado.concat("\nFalta asignar un id al producto!");
						bandera=true;
						

				 }
				 if(precio.contentEquals("")) {
					 resultado=resultado.concat("\nAsigne un precio al producto");
						bandera=true;

				 }
				if(bandera==false) {

					resultado= lp.agregar(user,contra,id
							,Double.parseDouble(precio),
					nombre,empresa,categoria);
					

				}
		
			
			
		}else if(request.getParameter("auction").contains("modificar")) {
			
			
			
			
			 resultado=lp.modificar(user,contra,
					request.getParameter("id"),request.getParameter("nombre"),
					request.getParameter("empresa"),request.getParameter("categoria"),request.getParameter("aux"));
			
		}
		if (bandera==false && resultado==null) {
			response.sendRedirect("Productos/listaProd.jsp");

		}
		else {

		response.sendRedirect("Productos/listaProd.jsp?resultado="+resultado);
		}
	}

}
