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
 * Servlet implementation class VentaServlet
 */
@WebServlet("/VentaServlet")
public class VentaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection C=null;
    /**
     * @see HttpServlet#HttpServlet()
     */
	 public void destroy() {
	    	
	        try {
	    		C.close();
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	}
	        }
    public VentaServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("auction");
		HttpSession miSesion= request.getSession(false);
		String user= miSesion.getAttribute("usuario").toString();
		String contra =miSesion.getAttribute("contra").toString();
		@SuppressWarnings({ "unchecked", "rawtypes" })
		ArrayList<Producto> ped = (ArrayList) miSesion.getAttribute("pedido");
		boolean existe=false;
		if(action.contains("id")){
			int id = Integer.parseInt(request.getParameter("idSearch"));
			for(Producto p: ped) {
				if(p.getId()==id) {
					existe=true;
					break;
					
					
				}
						
			}
			if (existe==false) {
				@SuppressWarnings({ "rawtypes", "unchecked" })
				ArrayList<Producto> prod = (ArrayList) miSesion.getAttribute("productos");

				for(Producto pr:prod) {
					if(pr.getId()==id) {
						ped.add(pr);
						break;
					}
					
				}
			}
			
			
		} else 	if(action.contains("nombre")){
			String nombre = request.getParameter("nombreSearch");
			for(Producto p: ped) {
				if(p.getNombre().equals(nombre)) {
					existe=true;
					break;
					
					
				}
						
			}
			if (existe==false) {
				@SuppressWarnings({ "unchecked", "rawtypes" })
				ArrayList<Producto> prod = (ArrayList) miSesion.getAttribute("productos");

				for(Producto pr:prod) {
					if(pr.getNombre().equals(nombre)) {
						ped.add(pr);
						break;
					}
					
				}
			}

	}//Fin busqueda por nombre
		else if (action.contains("eliminar")) {
			HttpSession miSession= request.getSession(false);
			 ped =(ArrayList)miSesion.getAttribute("pedido");
			 ArrayList<Producto> prod = (ArrayList) miSesion.getAttribute("productos");
			 Producto producto=null;
			 for(Producto p:prod) {
				 if (p.getId()==Integer.parseInt(request.getParameter("aux"))) {
					 producto=p;
					 break;
				 }
				 
			 }
			 ped.remove(producto);

		} //Final eliminar producto
		response.sendRedirect("Venta.jsp");

	}
}
