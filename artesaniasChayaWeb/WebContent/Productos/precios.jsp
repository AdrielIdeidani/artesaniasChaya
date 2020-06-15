<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="entities.ProductoConAumentoPrecio" %>
 <%@ page import="entities.Producto"%>
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
</head>
<body>
 
<form action="../PreciosServlet" id="formPrecio" method="post" >
<!-- <input type="search" id="idSearch" name="idSearch" onChange="idBusqueda()" list="id" placeholder="Busqueda por Id">
<input type="search" id="nombreSearch" list="nombre"  name="nombreSearch" placeholder="Busqueda por Nombre " onchange="nombreBusqueda()"> -->

<table class="table table-dark">
  <thead>
    <tr>
      <th scope="col">X</th>
      <th scope="col">Id</th>
      <th scope="col">Nombre</th>
      <th scope="col">Precio</th>
      <th scope="col">Ultima Actualizacion</th>
      <th scope="col">Nuevo Valor</th>
    </tr>
  </thead>
  <tbody>
  
  <% HttpSession miSesion= request.getSession(false);
ArrayList<ProductoConAumentoPrecio> precios =(ArrayList)miSesion.getAttribute("precios");
/* ArrayList<Producto> prod = (ArrayList) miSesion.getAttribute("productos"); */
if(precios!=null){
	
		for(ProductoConAumentoPrecio l: precios){%>
<tr>
    <td scope="row"><button type="submit" id="btnEliminar" class="btn btn-outline-danger" value=<%=l.getId()%> name="eliminar">X</button></td>
    <td class="colClass"><%=l.getId() %></td>
    <td ><%=l.getNombre() %></td>
    <td class="colPrecio"><%=l.getPrecio()%></td>
    <td><%= l.getFecha_desde()%></td>
    <td><b><font color="green" ><%=l.getAumento() %></font></b>
  
			

</tr>
<%} }%>

  </tbody>
</table>


<input type="submit" class="btn btn-primary" id="actualizar" value="Actualizar" style="float:right">
<a href="seleccionarProductosCambioPrecio.jsp" class="btn btn-secondary" style="float:right">Agregar</a>
<input type="hidden" id="auction" name="auction" value="">
<input type="hidden" id="aux" name="aux" >

</form>
<!-- 
con el buscador ya se de nombre o por el id del producto
que aparezca en una lista
y que pueda decidir si aumentarlo por una cantidad especifica
o que aumente su valor en un porcentaje.
Que en la lista se vaya viendo los productos que cambiarian de valor, cuanto valian, cuanto subirian
y a cuanto quedarian. Que se hagan todas las actualizaciones juntas cuando haga click.


 -->
  <%-- <datalist id="id">
 <%

	for(Producto l: prod){%>
 
	<option value=<%=l.getId() %>>
 	<%} %>

 </datalist>
  <datalist id="nombre">
 <%

	for(Producto l: prod) {%>
 
 	<option value= <%=l.getNombre() %>>
 	<%} %>

 </datalist> --%>
  
</body>
<script>



$(".btn-primary").click(function(){
	$("#auction").val("actualizar");
	
	
});



$(".btn-outline-danger").click(function() {
	
	$('#auction').val("eliminar");
	 var $row = $(this).closest("tr");    // Find the row
	  var $text = $row.find(".colClass").text(); // Find the text
	 $('#aux').val($row.find(".colClass").text());
	document.getElementById("formPrecio").submit();
})
function idBusqueda(){
	
	$('#auction').val("id");
	
	document.getElementById("formPrecio").submit();
	

	
}
function nombreBusqueda(){
	$('#auction').val("nombre");
	document.getElementById("formPrecio").submit();
	

}

</script>
</html>