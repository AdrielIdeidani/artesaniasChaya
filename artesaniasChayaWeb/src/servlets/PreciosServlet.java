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

import entities.Producto;
import entities.ProductoConAumentoPrecio;

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
	int id =Integer.parseInt(request.getParameter("id"));
	Float precioActual =Float.parseFloat(request.getParameter("precioActual"));
	
	for (ProductoConAumentoPrecio p:prec) {
		if (p.getId()==id) {
			if(modo.contains("cantidad")) {
		
				p.setAumento(precioActual+Float.parseFloat(request.getParameter("textCantidad")));
			} else if (modo.contains("total")) {
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
		

		String action = request.getParameter("auction");
		HttpSession miSesion= request.getSession(false);
		String user= miSesion.getAttribute("usuario").toString();
		String contra =miSesion.getAttribute("contra").toString();

		ArrayList<ProductoConAumentoPrecio> prec = (ArrayList) miSesion.getAttribute("precios");
		ArrayList<Producto> prod = (ArrayList) miSesion.getAttribute("productos");
		ProductoConAumentoPrecio prodABorrar=null;
		boolean existe=false;
		if(action.contains("id")){
			int id = Integer.parseInt(request.getParameter("idSearch"));
			if(prec!=null) {
			for(ProductoConAumentoPrecio p: prec) {//controlo que el producto no este ya dentro
				if(p.getId()==id) {
					existe=true;
					break;
							}
						
			}
			}
			if (existe==false) {
				ProductoConAumentoPrecio pCAP= new ProductoConAumentoPrecio();

				for(Producto pr:prod) {
					if(pr.getId()==id) {//como no esta agrego el producto correspondiente
						pCAP.setId(pr.getId());
						pCAP.setPrecio(pr.getPrecio());
						pCAP.setNombre(pr.getNombre());
						pCAP.setFecha_desde(pr.getFecha_desde());
						prec.add(pCAP);
						break;
					}
					
				}
				String dir="Productos/cambioPrecio.jsp?id="+pCAP.getId()+"&precio="+pCAP.getPrecio()
				+"&nombre="+pCAP.getNombre()+"&fecha="+pCAP.getFecha_desde();
				response.sendRedirect(dir);

			}
			
			
		}
		else 	if(action.contains("nombre")){
			String nombre = request.getParameter("nombreSearch");
			for(ProductoConAumentoPrecio p: prec) {
				if(p.getNombre().equals(nombre)) {
					existe=true;
					break;
					
					
				}
						
			}
			if (existe==false) {
				ProductoConAumentoPrecio pCAP= new ProductoConAumentoPrecio();
				for(Producto pr:prod) {
					if(pr.getNombre().equals(nombre)) {
						
						pCAP.setId(pr.getId());
						pCAP.setPrecio(pr.getPrecio());
						pCAP.setNombre(pr.getNombre());
						pCAP.setFecha_desde(pr.getFecha_desde());
						prec.add(pCAP);
						break;

						//break;
						
					}
					
				}
		

				String dir="Productos/cambioPrecio.jsp?id="+pCAP.getId()+"&precio="+pCAP.getPrecio()
				+"&nombre="+pCAP.getNombre()+"&fecha="+pCAP.getFecha_desde();
				response.sendRedirect(dir);

			}

	}//Fin busqueda por nombre
		else if (action.contains("eliminar")) {
			 Producto producto=null;
			 for(ProductoConAumentoPrecio p:prec) {
				 if (p.getId()==Integer.parseInt(request.getParameter("aux"))) {
					  prodABorrar = p;
					
					 break;
				 }
				 
			 }
			 prec.remove(prodABorrar);
				response.sendRedirect("Productos/precios.jsp");

		}//Final eliminar producto
		else if(action.contains("actualizar")) {
			System.out.println("Llega al actualizar");
			System.out.println("Llega al actualizar");
			System.out.println("Llega al actualizar");
			System.out.println("Llega al actualizar");

			if(prec.isEmpty()==false) {
				System.out.println("esto nolo cumple");
				System.out.println("esto nolo cumple");
				System.out.println("esto nolo cumple");
				System.out.println("esto nolo cumple");
				System.out.println("esto nolo cumple");

				for(ProductoConAumentoPrecio p: prec) {
					try {
						Class.forName("com.mysql.jdbc.Driver");
						 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
									user,contra);
						 String query = "insert into chaya.precios values(?,curdate(),?);";
						 System.out.println("id: " + p.getId());
						 System.out.println("id: " + p.getId());
						 System.out.println("id: " + p.getId());
						 System.out.println("aumento" + p.getAumento());
						 System.out.println("aumento: " + p.getAumento());
						 System.out.println("aumento: " + p.getAumento());

							PreparedStatement pstmt = C.prepareStatement(query);
							pstmt.setInt(1, p.getId() );
							pstmt.setFloat(2, p.getAumento());

							pstmt.executeUpdate();
							pstmt.close();
					}
					catch (Exception e) {
						System.out.println("error");						System.out.println("error");
						System.out.println("error");
						System.out.println("error");
						System.out.println("error");

					}
					
					
					
				}
			prec.clear();
				
				
				
			}
			
			response.sendRedirect("Productos/precios.jsp");

		}
				

		
	}

}
