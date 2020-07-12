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
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.CompradoresData;
import entities.Comprador;
import entities.Presupuesto;
import entities.Producto;
import entities.ProductoConAumentoPrecio;
import logic.PresupuestoPDF;
import logic.logicComprador;
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
		System.out.println("entra al doget");
		HttpSession miSesion= request.getSession(false);
		ArrayList<Presupuesto> presupuestos= (ArrayList)miSesion.getAttribute("presupuestos");
		String aux = request.getParameter("aux");
		Presupuesto presupuesto=null;
		for(Presupuesto p:presupuestos) {
			if(aux.contentEquals(String.valueOf(p.getNro()))) {
				presupuesto=p;
				break;
			}
		}
		PresupuestoPDF pdf= new PresupuestoPDF();
		pdf.crearPresupuesto(presupuesto);
		response.sendRedirect("Reportes/VentasDelDia.jsp");
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("auctionVenta");
		logicComprador lc = new logicComprador();
		HttpSession miSesion= request.getSession(false);
		String user= miSesion.getAttribute("usuario").toString();
		String contra =miSesion.getAttribute("contra").toString();
		ArrayList<Producto> ped = (ArrayList) miSesion.getAttribute("pedido");
		 ArrayList<Producto> prod = (ArrayList) miSesion.getAttribute("productos");
		 logicPedidos lp = new logicPedidos();

		 String nombre,cuit,direccion,telefono,mail,localidad,provincia,codigoPostal;

		cuit= request.getParameter("cuitHidden");
		nombre =request.getParameter("nombreHidden");
		direccion=request.getParameter("direccionHidden");
		telefono=request.getParameter("telefonoHidden");
		mail=request.getParameter("mailHidden");
		localidad=request.getParameter("localidadHidden");
		provincia=request.getParameter("provinciaHidden");
		codigoPostal=request.getParameter("codigoPostalHidden");


		String cantidades= request.getParameter("cantsHidden");
		String resultado=null;
		
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
			String aux = miSesion.getAttribute("comprador").toString();
			 String nroComprador;
	
			if (aux.contentEquals("-1") ) {
				String base ="9999";
				nroComprador = base.concat(cuit);
				 resultado= lc.agregarNulo(user, contra,
						nroComprador,nombre,telefono,mail, direccion, localidad, codigoPostal, provincia);
				
				System.out.println("Equal -1 (agregado a mano)");


			}
			else {
				nroComprador= cuit;
				CompradoresData cd = new CompradoresData();
				try {
					Comprador comp = cd.getOne(user, contra, nroComprador);
					nombre=comp.getNombre();
					telefono=comp.getTelefono();
					mail=comp.getMail();
					direccion=comp.getDireccion();
					localidad=comp.getLocalidad();
					codigoPostal=comp.getCodigoPostal();
					provincia=comp.getProvincia();
					System.out.println("Hay un comprador!");

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(nombre==null) nombre="--";
			if(telefono==null) telefono="--";
			if(mail==null) mail="--";
			if(direccion==null) direccion="--";
			if(localidad==null) localidad="--";
			if(codigoPostal==null) codigoPostal="--";
			if(provincia==null) provincia="--";

			
			double total= 0;
			double totalSinDescuento=0;
			for (Producto p:ped) {
				total+= p.getCant()*p.getPrecio();
				 totalSinDescuento=total;
			}
			
	
			String radio = request.getParameter("radio");
			double descuento=0;
			
			
		if(radio.equals("cantidad")) {
			 descuento =Double.parseDouble(request.getParameter("textCantidad"));
			 total-=descuento;
			 

				
			
		}
		else if (radio.equals("total")) {
			descuento =Double.parseDouble(request.getParameter("textTotal"));
			double auxDcto=total;
			total=descuento;
			descuento=auxDcto-descuento;
		}
		else if (radio.equals("porcentaje")) {
			descuento =Double.parseDouble(request.getParameter("textPorcentaje"));
			total= total - (total*descuento/100);
		
		}
		
	
		resultado = lp.entregar(user,contra,ped,descuento,total,cuit);
		if(Integer.parseInt(resultado)>-1 ) {
			Presupuesto pres = new Presupuesto();
			pres.setNro(Integer.parseInt(resultado));
			resultado=null;
			pres.setNombre(nombre);
			pres.setCodigoPostal(codigoPostal);
			pres.setCuit(cuit);
			pres.setDireccion(direccion);
			pres.setLocalidad(localidad);
			pres.setMail(mail);
			pres.setProvincia(provincia);
			pres.setTelefono(telefono);
			pres.setSubtotal(totalSinDescuento);
			pres.setDescuento(descuento);
			pres.setProds(ped);
			pres.setFecha(java.time.LocalDate.now());
			PresupuestoPDF p = new PresupuestoPDF();
			p.crearPresupuesto(pres);
			
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
		 if(resultado==null) {
				response.sendRedirect("Venta/Venta.jsp?cuit="+cuit+"&nombre="+nombre+"&mail="+mail+
						"&telefono="+telefono+"&direccion="+direccion+"&localidad="+localidad+"&provincia="+
						provincia+"&codigoPostal="+codigoPostal);
		 }
		 
		 else{ response.sendRedirect("Venta/Venta.jsp?cuit="+cuit+"&nombre="+nombre+"&mail="+mail+
				"&telefono="+telefono+"&direccion="+direccion+"&localidad="+localidad+"&provincia="+
				provincia+"&codigoPostal="+codigoPostal+"&resultado="+resultado);}

	}
}
