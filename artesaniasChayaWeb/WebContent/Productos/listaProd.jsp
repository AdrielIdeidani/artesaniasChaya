<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="database.ProductosData" %>
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

<a href="nuevoProd.jsp"><button type="submit" class="btn btn-secondary" id="btnModificar" name="modificar">Añadir</button></a>
<form action="../ProductosServlet" method="get" >

<table class="table table-dark">
  <thead>
    <tr>
      <th scope="col">Id</th>
      <th scope="col">Nombre</th>
      <th scope="col">Precio</th>
      <th scope="col">Stock</th>
      <th scope="col">Modificar</th>
      <th scope="col">Eliminar</th>
    </tr>
  </thead>
  <!-- <tbody> -->
	
	<%
	ProductosData pd= new ProductosData();
	ArrayList<Producto> list = pd.getAll(session.getAttribute("usuario").toString()
			,session.getAttribute("contra").toString()); 
	HttpSession  miSesion= request.getSession(false);
	miSesion.setAttribute("productos", list);
	
	for(Producto l: list){%>
		<tr>
			<td class="colClass" ><%= l.getId() %></td>
			<td ><%= l.getNombre() %></td>
			<td ><%= l.getPrecio() %></td>
			<td ><%= l.getStock() %></td>
			<td ><a href="agregarProv.jsp"><button type="submit" class="btn btn-primary" id="btnModificar"  name="modificar">Modificar</button></a></td>
			<td><button type="submit" class="btn btn-secondary" id="btnEliminar"   name="eliminar">Borrar</button></td>

		</tr>
	
	<%} %>
	
 

 
    
    
<!--   </tbody>
 --></table>
<input type="hidden" id="auction" name="auction" value="">
<input type="hidden" id="aux" name="aux" >

</form>

</body>
<script>

$(document).ready(function(){

$(".btn-secondary").click(function() {
	 var $row = $(this).closest("tr");    // Find the row
	  var $text = $row.find(".colClass").text(); // Find the text
	 $('#aux').val($row.find(".colClass").text());
	$('#auction').val("eliminar");

	
})

$(".btn-primary").click(function() {
	var $row = $(this).closest("tr");    // Find the row
	var $text = $row.find(".colClass").text(); // Find the text
	$('#aux').val($row.find(".colClass").text());
	$('#auction').val("modificar");

	
})
});

</script>
</html>