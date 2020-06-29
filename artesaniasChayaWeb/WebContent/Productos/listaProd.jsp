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
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/esm/popper-utils.js" ></script>
 
<link href="../Css/PageInPanel.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.4.0/bootbox.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.21/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.21/datatables.min.js"></script>
</head>
<body>

<a href="nuevoProd.jsp"><button type="submit" class="btn btn-secondary" id="btnModificar" name="modificar">Añadir</button></a>
<form id="formProd" action="../ProductosServlet" method="get" >

<table class="table table-striped table-bordered table-sm" id="tabla">
  <thead>
    <tr>
      <th scope="col">Id</th>
      <th scope="col">Nombre</th>
      <th scope="col">Precio</th>
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
			<td ><button type="submit" class="btn btn-primary" id="btnModificar"  name="modificar">Modificar</button></td>
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
$(document).ready(function() {
    $('#tabla').DataTable( {
        "paging":   false,
        //"ordering": false,
        "info":     false
    } );
} );
$(".btn-primary").click(function() {
	var $row = $(this).closest("tr");    // Find the row
	var $text = $row.find(".colClass").text(); // Find the text
	$('#aux').val($row.find(".colClass").text());
	$('#auction').val("modificar");
	

})
$(document).ready(function(){

$(".btn-secondary").click(function() {
	 var $row = $(this).closest("tr");    // Find the row
	  var $text = $row.find(".colClass").text(); // Find the text
	  $('#aux').val($row.find(".colClass").text());
		$('#auction').val("eliminar");
		
	
	

	
})


});

</script>
</html>