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

import entities.Comprador;
import entities.Producto;
import entities.ProductoConAumentoPrecio;
import logic.logicPedidos;

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
//		HttpSession miSesion= request.getSession(false);
//		String user= miSesion.getAttribute("usuario").toString();
//		String contra =miSesion.getAttribute("contra").toString();
//		ArrayList<Producto> ped = (ArrayList) miSesion.getAttribute("pedido");
//
//		int idVenta=0;
//		float total = 0;
//		 DecimalFormat df = new DecimalFormat("#.##");
//		 for(Producto p:ped) {
//			 total = total + (p.getCant()*p.getPrecio());
//			 
//		 }
//
//			try {
//				Class.forName("com.mysql.jdbc.Driver");
//				 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
//							user,contra);
//				 PreparedStatement pstmt = C.prepareStatement("insert into chaya.venta (total,fecha_hora) values (?,now())",
//							Statement.RETURN_GENERATED_KEYS);	
//					//pstmt.setObject(1,request.getParameter("total")) ;
//					pstmt.setFloat(1,total );
//					
//					pstmt.executeUpdate();
//					ResultSet rs = pstmt.getGeneratedKeys();	
//					if(rs.next()) {
//						System.out.println("Pone el idVenta");
//					 idVenta= Integer.parseInt(rs.getString(1));
//					}
//		
//					String query = "call lineaVentaStock(?,?,?);"; //Crea las lineas venta y actualiza stock
//						for(Producto p: ped) {
//							if(idVenta!=0 &&p.getCant()>0) {
//								
//					
//
//							pstmt = C.prepareStatement(query);	
//							pstmt.setObject(1, idVenta );
//							pstmt.setObject(2, p.getId());
//							pstmt.setInt(3, p.getCant());
//						
//							pstmt.executeUpdate();
//							}
//					}
//						pstmt.close();
//						ped.clear();
//			}
//			catch (Exception e) {
//				e.printStackTrace();
//				System.out.println("error");						System.out.println("error");
//				System.out.println("error");
//				System.out.println("error");
//				System.out.println("error");
//
//			}

	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("auctionVenta");

		HttpSession miSesion= request.getSession(false);
		String user= miSesion.getAttribute("usuario").toString();
		String contra =miSesion.getAttribute("contra").toString();
		ArrayList<Producto> ped = (ArrayList) miSesion.getAttribute("pedido");
		 ArrayList<Producto> prod = (ArrayList) miSesion.getAttribute("productos");
		 logicPedidos lp = new logicPedidos();

		 String nombre,cuit,direccion,telefono,mail,localidad,provincia,codigoPostal;
		boolean existe=false;

		cuit= request.getParameter("cuit");
		nombre =request.getParameter("nombre");
		direccion=request.getParameter("direccion");
		telefono=request.getParameter("telefono");
		mail=request.getParameter("mail");
		localidad=request.getParameter("localidad");
		provincia=request.getParameter("provincia");
		codigoPostal=request.getParameter("codigoPostal");

		String cantidades= request.getParameter("cantsHidden");

		
		String[] cants =	cantidades.split("\\s*,\\s*");
		
		for(int i=0;i<ped.size();i++) {
			ped.get(i).setCant(Integer.parseInt(cants[i]));
			
		}
		
	
		miSesion.setAttribute("pedido", ped);
		
		

		 if (action.contains("eliminar")) {

			 Producto producto=null;

			 for(Producto p:prod) {
				 if (p.getId().equals(request.getParameter("auxVenta"))) {
			
					 producto=p;
					 break;
				 }
				 
			 }
			 producto.setCant(1);
	
				 ped.remove(producto);
			miSesion.setAttribute("pedido", ped);

			 

		} //Final eliminar producto
		else if (action.contains("entregar")) {
			 cuit = miSesion.getAttribute("comprador").toString();


			if (cuit.contentEquals("-1")) {
				System.out.println("Equal -1 (agregado a mano)");


			}
			else {
				System.out.println("Hay un comprador!");
			}
			
			
			double total= 0;
			for (Producto p:ped) {
				total+= p.getCant()*p.getPrecio();
				
			}
			
	
			String radio = request.getParameter("radio");
			double descuento=0;
			
			
		if(radio.equals("cantidad")) {
			 descuento =Double.parseDouble(request.getParameter("textCantidad"));
			 total-=descuento;
			 

				
			
		}
		else if (radio.equals("total")) {
			descuento =Double.parseDouble(request.getParameter("textTotal"));
			total=descuento;
		}
		else if (radio.equals("porcentaje")) {
			descuento =Double.parseDouble(request.getParameter("textPorcentaje"));
			total= total - (total*descuento/100);
		
		}
		
	
		String resultado = lp.entregar(user,contra,ped,descuento,total,"1");
		if(resultado ==null) {
			ped.clear();
			miSesion.setAttribute("pedido", ped);
			
		}
		
		
	
		}

		else if (action.contains("agregar")) {
			String id= request.getParameter("idsHidden");

			String[] ids =	id.split("\\s*,\\s*");
			
			for (String id1: ids) {
				for(Producto p: prod) {
					if (p.getId().equals(id1)) {
						ped.add(p);
						break;
						
					}
				}
				}
			miSesion.setAttribute("pedido", ped);

		}
		response.sendRedirect("Venta/Venta.jsp?cuit="+cuit+"&nombre="+nombre+"&mail="+mail+
				"&telefono="+telefono+"&direccion="+direccion+"&localidad="+localidad+"&provincia="+
				provincia+"&codigoPostal="+codigoPostal);

	}
}
