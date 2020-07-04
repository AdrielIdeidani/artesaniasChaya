package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.ForEach;

import database.ProductosData;
import entities.Producto;
import entities.ProductoConAumentoPrecio;
import logic.PresupuestoPDF;
import logic.logicProductos;

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
	

		String modo=request.getParameter("radio");
		HttpSession miSesion= request.getSession(false);
		ArrayList<ProductoConAumentoPrecio> prec = (ArrayList) miSesion.getAttribute("precios");
	String id =request.getParameter("id");
	Float precioActual =Float.parseFloat(request.getParameter("precioActual"));
	
	for (ProductoConAumentoPrecio p:prec) {
		if (p.getId()==id) {
			if(modo.contains("cantidad")) {
		
				p.setAumento(precioActual+Float.parseFloat(request.getParameter("textCantidad")));
			}
			else if (modo.contains("total")) {
				p.setAumento(Float.parseFloat(request.getParameter("textTotal")));
				
			}
			else if (modo.contains("porcentaje")) {
				p.setAumento(precioActual
						+ (precioActual/100)* Float.parseFloat(request.getParameter("textPorcentaje")
						));
				
				
			}
			
			
		}
		
	}
	
		response.sendRedirect("Productos/precios.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession miSesion= request.getSession(false);
		String user= miSesion.getAttribute("usuario").toString();
		String contra =miSesion.getAttribute("contra").toString();
		
				
		String action = request.getParameter("auction");
		logicProductos lp= new logicProductos();
		
		System.out.println(action);
		if(action.contains("actualizar")) {
			ArrayList<ProductoConAumentoPrecio> actualizar = (ArrayList) miSesion.getAttribute("precios");
			String resultado =null;
			 resultado= lp.actualizarPrecios(user, contra, actualizar);
			if(resultado==null) {
				ArrayList<ProductoConAumentoPrecio> prec = new ArrayList<ProductoConAumentoPrecio>();
				miSesion.setAttribute("precios", prec);
			}
			
			
		}
		else if (action.contains("lista")) {
			System.out.println("servlet lista");
			System.out.println("servlet lista");
			System.out.println("servlet lista");
			System.out.println("servlet lista");
			System.out.println("servlet lista");

			PresupuestoPDF pdf = new PresupuestoPDF();
			try {
				pdf.crearLista(user,contra);
			} catch (IOException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
		}
		else if (action.contains("eliminar")){
			ArrayList<ProductoConAumentoPrecio> eliminar = (ArrayList) miSesion.getAttribute("precios");
			String aux = request.getParameter("aux");
			for(ProductoConAumentoPrecio pr:eliminar) {
				if (pr.getId().equals(aux)) {
					eliminar.remove(pr);
					break;
				}
				
			}
			miSesion.setAttribute("precios", eliminar);
			
			
			
			
		}
		else {
			String id= request.getParameter("idsHidden");
			ArrayList<ProductoConAumentoPrecio> prec = (ArrayList) miSesion.getAttribute("precios");
			
			
			
			String[] ids =	id.split("\\s*,\\s*");
			System.out.println(ids[0]);
			
			String radio = request.getParameter("radio");
			String aumento ;
			ArrayList<ProductoConAumentoPrecio> prods=null;
			if(radio.equals("cantidad")) {
			
				
					try {
						prods = lp.asignarNuevosPreciosCantidad(user, contra, ids,request.getParameter("textCantidad"));
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			
			
			
			
			
			
			} else if (radio.equals("total")) {
			System.out.println("total : " + request.getParameter("textTotal"));
			System.out.println("total : " + request.getParameter("textTotal"));
			System.out.println("total : " + request.getParameter("textTotal"));
			System.out.println("total : " + request.getParameter("textTotal"));

			try {
				prods = lp.asignarNuevosPreciosTotal(user, contra, ids,request.getParameter("textTotal"));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
				
			}else if (radio.equals("porcentaje")) {
			
			try {
				prods = lp.asignarNuevosPreciosPorcentaje(user, contra, ids,request.getParameter("textPorcentaje"));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
				
			}
			
			for (ProductoConAumentoPrecio p:prods) {
				prec.add(p);
			}
			miSesion.setAttribute("precios", prec );

		}
		
		response.sendRedirect("Productos/precios.jsp");
//		

		
	}

}
