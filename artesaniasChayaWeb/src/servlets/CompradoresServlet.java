package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.CompradoresData;
import entities.Comprador;
import logic.logicComprador;

/**
 * Servlet implementation class CompradoresServlet
 */
@WebServlet("/CompradoresServlet")
public class CompradoresServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub


		String auction =request.getParameter("auction");
		HttpSession miSesion= request.getSession(false);
		String user= miSesion.getAttribute("usuario").toString();
		String contra =miSesion.getAttribute("contra").toString();
		CompradoresData cd= new CompradoresData();
		logicComprador lc= new logicComprador();
		//Redirige para modificar el comprador
		if(auction.contains("modificar")) {

				response.sendRedirect("Compradores/agregarComp.jsp?idComprador="+request.getParameter("aux"));

		}
		else if(auction.contains("eliminar")) {
			String resultado=lc.eliminar(user,contra,request.getParameter("aux"));
			
			response.sendRedirect("Compradores/compradores.jsp");
		}
		else if (auction.contains("venta")) {
			System.out.println("venta");
			Comprador comp= new Comprador();
			try {
				 comp = cd.getOne(user,contra,request.getParameter("aux"));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			miSesion.setAttribute("comprador", String.valueOf(comp.getCuit()));
			
			response.sendRedirect("Venta/Venta.jsp?id="+comp.getCuit()+"&nombre="+comp.getNombre()+"&direccion="+
			comp.getDireccion()+"&localidad="+comp.getLocalidad()+"&provincia="+comp.getProvincia()+"&telefono="
			+comp.getTelefono()+"&mail="+comp.getMail()+"&cuit="+comp.getCuit()+"&codigoPostal="+comp.getCodigoPostal());
			
		}
		else if (auction.contains("cambiarCompradorANulo")) {
			String cuit="-1"; //-1 o 0
			miSesion.setAttribute("comprador", cuit);
			response.sendRedirect("Venta/Venta.jsp?cuit="+request.getParameter("cuit")+"&nombre="+
			request.getParameter("nombre")+"&telefono="+
			request.getParameter("telefono")+"&mail="+
			request.getParameter("mail")+"&direccion="+
			request.getParameter("direccion")+"&localidad="+
			request.getParameter("localidad")+"&provincia="+
			request.getParameter("provincia")+"&codigoPostal="+
			request.getParameter("codigoPostal"));
			
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String auction =request.getParameter("auction");
		HttpSession miSesion= request.getSession(false);
		String user= miSesion.getAttribute("usuario").toString();
		String contra =miSesion.getAttribute("contra").toString();
		logicComprador lc= new logicComprador();
		if (auction.contains("agregar")) {
			String resultado=lc.agregar(user, contra,request.getParameter("id"), request.getParameter("nombre"), request.getParameter("telefono")
					, request.getParameter("mail"), request.getParameter("direccion"),
					request.getParameter("localidad"),request.getParameter("codigoPostal"), request.getParameter("provincia"));
			if(resultado==null) {
				response.sendRedirect("Compradores/compradores.jsp");
			}
			else {
				//REDIRECCIONAR CON EL ERROR
			}
			
		}
		else if (auction.contains("modificar")) {
			
			String resultado = lc.modificar(user, contra, request.getParameter("aux"), request.getParameter("id"),
					request.getParameter("nombre"), request.getParameter("telefono")
					, request.getParameter("mail"), request.getParameter("direccion"),
					request.getParameter("localidad"),request.getParameter("codigoPostal"), request.getParameter("provincia"));
			
			System.out.println("resultado");
			System.out.println(resultado);
			
					if(resultado==null) { 
						response.sendRedirect("Compradores/compradores.jsp");
					}
		}
	}

}
