package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entities.Producto;
import entities.ProductoConAumentoPrecio;
import logic.IniciarSesion;

/**
 * Servlet implementation class InicioServlet
 */
@WebServlet("/InicioServlet")
public class InicioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String contra= request.getParameter("contra");
		String user =request.getParameter("usuario");

		IniciarSesion ini = new IniciarSesion();
		if(ini.iniciar(user, contra)) {
			HttpSession miSesion = request.getSession(true);
			miSesion.setAttribute("usuario", user);
			miSesion.setAttribute("contra", contra);
			ArrayList<Producto> prod = new ArrayList<Producto>();
			ArrayList<ProductoConAumentoPrecio> pr = new ArrayList<ProductoConAumentoPrecio>();
			miSesion.setMaxInactiveInterval(900);//15 min antes de invalidad la sesion
			miSesion.setAttribute("pedido", prod );
			miSesion.setAttribute("precios", pr );
			response.sendRedirect("PagPrincipal.jsp");


		}
		else
			response.sendRedirect("ErrorInicio.jsp");
			}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
