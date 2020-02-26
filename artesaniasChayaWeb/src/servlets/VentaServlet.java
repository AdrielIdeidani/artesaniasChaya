package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
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
		HttpSession miSesion= request.getSession(false);
		String user= miSesion.getAttribute("usuario").toString();
		String contra =miSesion.getAttribute("contra").toString();
		ArrayList<Producto> ped = (ArrayList) miSesion.getAttribute("pedido");
//		System.out.println(request.getParameter("total"));
//		System.out.println(request.getParameter("total"));
//		System.out.println(request.getParameter("total"));
//		System.out.println(request.getParameter("total"));
		int idVenta=0;
		float total = 0;
		 DecimalFormat df = new DecimalFormat("#.##");
		 for(Producto p:ped) {
			 total = total + (p.getCant()*p.getPrecio());
			 
		 }

			try {
				Class.forName("com.mysql.jdbc.Driver");
				 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
							user,contra);
				 PreparedStatement pstmt = C.prepareStatement("insert into chaya.venta (total,fecha_hora) values (?,now())",
							Statement.RETURN_GENERATED_KEYS);	
System.out.println("Llega antes de poner el parametro");
					//pstmt.setObject(1,request.getParameter("total")) ;
					pstmt.setFloat(1,total );
					
System.out.println("llega dsp de poner el parametro");
					pstmt.executeUpdate();
					System.out.println("dsp del executeUpdate");
					ResultSet rs = pstmt.getGeneratedKeys();	
					System.out.println("dsp del get generated keys");
					if(rs.next()) {
						System.out.println("Pone el idVenta");
					 idVenta= Integer.parseInt(rs.getString(1));
					}
		
					String query = "insert into chaya.lineasventa values (?,?,?);";
						for(Producto p: ped) {
							if(idVenta!=0 &&p.getCant()>0) {
								
					

							pstmt = C.prepareStatement(query);	
							pstmt.setObject(1, idVenta );
							pstmt.setObject(2, p.getId());
							pstmt.setInt(3, p.getCant());
							pstmt.executeUpdate();
							}
					}
						pstmt.close();
						ped.clear();
			}
			catch (Exception e) {
				e.printStackTrace();
				System.out.println("error");						System.out.println("error");
				System.out.println("error");
				System.out.println("error");
				System.out.println("error");

			}

	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("auction");
		HttpSession miSesion= request.getSession(false);
		ArrayList<Producto> ped = (ArrayList) miSesion.getAttribute("pedido");
		boolean existe=false;
		if(action.contains("id")){
			int id = Integer.parseInt(request.getParameter("idSearch"));
			for(Producto p: ped) {
				if(p.getId()==id) {
					existe=true;
					p.setCant(p.getCant()+1);
					break;
					
					
				}
						
			}
			if (existe==false) {
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
					p.setCant(p.getCant()+1);
					existe=true;
					break;
					
					
				}
						
			}
			if (existe==false) {
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
	
			 if(producto.getCant()>1) {
				 producto.setCant(producto.getCant()-1);
 
			 }
			 else if (producto.getCant()==1) {
				 ped.remove(producto);

			 }

		} //Final eliminar producto
		else if (action.contains("entregar")) {
		

			doGet(request, response);
		}
		response.sendRedirect("Venta.jsp");

	}
}
