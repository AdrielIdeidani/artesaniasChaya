package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entities.Producto;

/**
 * Servlet implementation class PreciosServlet
 */
@WebServlet("/PreciosServlet")
public class PreciosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection C=null;

	 public void destroy() {
	    	
	        try {
	    		C.close();
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	}
	        }
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PreciosServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("auction");
		HttpSession miSesion= request.getSession(false);
		String user= miSesion.getAttribute("usuario").toString();
		String contra =miSesion.getAttribute("contra").toString();

		ArrayList<Producto> prec = (ArrayList) miSesion.getAttribute("precios");
		ArrayList<Producto> prod = (ArrayList) miSesion.getAttribute("productos");

		boolean existe=false;
		if(action.contains("id")){
			int id = Integer.parseInt(request.getParameter("idSearch"));
			for(Producto p: prec) {//controlo que el producto no este ya dentro
				if(p.getId()==id) {
					existe=true;
					break;
							}
						
			}
			if (existe==false) {

				for(Producto pr:prod) {
					if(pr.getId()==id) {//como no esta agrego el producto correspondiente
						prec.add(pr);
						break;
					}
					
				}
			}
			
			
		}
		else 	if(action.contains("nombre")){
			String nombre = request.getParameter("nombreSearch");
			for(Producto p: prec) {
				if(p.getNombre().equals(nombre)) {
					existe=true;
					break;
					
					
				}
						
			}
			if (existe==false) {

				for(Producto pr:prod) {
					if(pr.getNombre().equals(nombre)) {
						prec.add(pr);
						break;
					}
					
				}
			}

	}//Fin busqueda por nombre
		else if (action.contains("eliminar")) {
			 Producto producto=null;
			 for(Producto p:prec) {
				 if (p.getId()==Integer.parseInt(request.getParameter("aux"))) {
					 producto=p;
					 break;
				 }
				 
			 }
			 prec.remove(producto);

		} //Final eliminar producto
		response.sendRedirect("Productos/precios.jsp");


		
	}

}
