<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="database.ProductosData"%>
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
<label for="pedidoLabel">Nro Venta:</label>
<label for="pedidoNro"></label>
</div>
<form  id="formVenta" action="VentaServlet" method="post">
<table class="table table-dark">
  <thead>
    <tr>
      <th scope="col">X</th>
      <th scope="col">Id</th>
      <th scope="col">Nombre</th>
      <th scope="col">Precio</th>
      <th scope="col">Cantidad</th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
<% HttpSession miSesion= request.getSession(false);
ArrayList<Producto> ped =(ArrayList)miSesion.getAttribute("pedido");
ArrayList<Producto> prod = (ArrayList) miSesion.getAttribute("productos");
if(ped!=null){
	

		for(Producto l: ped){%>
<tr>
    <td scope="row"><button type="submit" id="btnEliminar" class="btn btn-outline-danger" value=<%=Integer.toString(l.getId())%> name="eliminar">X</button></td>
    <td class="colClass"><%=l.getId() %></td>
    <td><%=l.getNombre() %></td>
    <td><%=l.getPrecio()%></td>
    <td></td>
    

<%} }%>
 
    <tr>
    <th scope="row"></th>
    <th><input type="search" id="idSearch" name="idSearch" list="id" onChange="idBusqueda()" placeholder="Busqueda por Id"></th>
    <th><input type="search" id="nombreSearch" name="nombreSearch" list="nombre" placeholder="Busqueda por Nombre " onchange="nombreBusqueda()"></th>

    
    
    
  </tbody>
</table>

<div style="float:right">
<button type="button" class="btn btn-dark">
<label id="total" for="total" >Total : $ </label>
<label id="totalValor" for="totalValor">0</label>
Agregar
</button>
</div>
<input type="hidden" id="auction" name="auction" value="">
<input type="hidden" id="aux" name="aux" >

</form>
<!-- <label >Total : $</label> style="float:right"
<label id="total" for="total" >0</label> -->

<!-- <input type="submit" value="Agregar" onclick="arrays()"> -->
 <datalist id="id">
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

 </datalist>
 
 
</body>
<script>
//SI POR EJEMPLO ESTOY ESCRIBIENDO EL CODIGO 11
// Y DE LA NADA DEJO DE ESCRIBIR AHI Y ME PONGO A BUSCAR EL PRODUCTO POR LA DESCRIPCION 
//VA A BUSCAR ALGUN PRODUCTO CON EL CODIGO 11 Y SI LO HAY LO AGREGA. CAMBIARLO

$(".btn-outline-danger").click(function() {
	
	$('#auction').val("eliminar");
	 var $row = $(this).closest("tr");    // Find the row
	  var $text = $row.find(".colClass").text(); // Find the text
	 $('#aux').val($row.find(".colClass").text());
	document.getElementById("formVenta").submit();
})
function idBusqueda(){
	

	$('#auction').val("id");
	
	document.getElementById("formVenta").submit();
	

	
}
function nombreBusqueda(){
	$('#auction').val("nombre");
	document.getElementById("formVenta").submit();
	

}


</script>
</html>