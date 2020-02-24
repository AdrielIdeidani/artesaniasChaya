<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="entities.Producto" %>

<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Artesanias Chaya</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
<link href="Css/PageInPanel.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</head>
<body>
<div>
		<form action="../ProductosServlet" method="post" >
			<%
		String idProducto = request.getParameter("idProducto");
		    if (idProducto!=null){
		    	HttpSession miSesion= request.getSession(false);
		    	ArrayList<Producto> pro =(ArrayList)miSesion.getAttribute("productos");
		    Producto prod=null;	
		    for (Producto p:pro){
		    	if(p.getId()==Integer.parseInt(idProducto)){
		    	
		    	}
		    		prod=p;
		    		break;

		    	}
		    	
		    
		    
		    %>
<h4 >Solo cambiar el stock aca si no se puede registrar con una compra a un proveedor</h4>   
<h4 class="small" >Para actualizar el precio ir a la seccion correspondiente</h4>
<br>	    
<h5 class="small">Id</h5>
<input type="text" id="id" name="id" class="form-control" placeholder="Id" value=<%= prod.getId() %>>
<h5 class="small">Nombre</h5>
<input type="text" id="nombre" name="nombre" class="form-control" placeholder="Nombre" value=<%=prod.getNombre() %>>
<h5 class="small">Stock</h5>
<input type="text" id="stock" class="form-control" name="stock" placeholder="Stock" value=<%=prod.getStock() %>>
<br>
<input type="hidden" id="auction" name="auction" value="modificar">
<input type="hidden" id="aux" name="aux" value= <%=prod.getId() %>>
<%} else {%>

<input type="text" id="id" name="id" class="form-control" placeholder="Id" >
<br>
<input type="text" id="nombre" name="nombre" class="form-control" placeholder="Nombre" >
<br>
<input type="text" id="precio" name="precio" class="form-control" placeholder="Precio" >
<br>
<input type="text" id="stock" class="form-control" name="stock" placeholder="Stock">
<h5 class="small">Iniciar en 0 si luego se registra la compra al proveedor</h5>
<input type="hidden" id="auction" name="auction" value="agregar">

<br>
<%} %>
<input type="submit" class="btn btn-primary" id="agregar" value="Agregar" style="float:right">

<input type="hidden" id="user" name="user" value=<%= session.getAttribute("usuario").toString()%> >
<input type="hidden" name="contra" id="contra" value=<%= session.getAttribute("contra").toString()%> >

</form>


<a href="listaProd.jsp"><button type="button" class="btn btn-secondary" id="volver" style="float:left">Volver</button>
</a>

</div>

</body>
</html>