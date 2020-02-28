<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="database.ProductosData"%>
<%@ page import="entities.Producto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
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
 
<link href="Css/PageInPanel.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.4.0/bootbox.min.js"></script>
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
    <td><%=l.getCant() %></td>
    

<%} }%>
 
    <tr>
    <th scope="row"></th>
    <th><input type="search" id="idSearch" name="idSearch" list="id" onChange="idBusqueda()" placeholder="Busqueda por Id"></th>
    <th><input type="search" id="nombreSearch" name="nombreSearch" list="nombre" placeholder="Busqueda por Nombre " onchange="nombreBusqueda()"></th>
<td></td>
<td></td>
</tr>
    
    
    
  </tbody>
</table>

<div style="float:right">
<%
float total=0;
for(Producto p:ped){
	total = total + (p.getCant()*p.getPrecio());
	
}
 DecimalFormat df = new DecimalFormat("#.##");%>

<button type="button" class="btn btn-dark">
Total : $
<%=df.format(total)%>
<br>
<b>Agregar</b>
</button>
</div>
<input type="hidden" id="auction" name="auction" value="">
<input type="hidden" id="aux" name="aux"  >
<input type="hidden" id="total" name="total" value=<%=df.format(total)%>>

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

$(".btn-dark").click(function(){
	$('#auction').val("entregar");
	//bootbox.alert("Total: $" + $("#total").val());
	var act;
	bootbox.confirm({
		title: "Confirmar Pedido",
	    message: "Total $" + $("#total").val() ,
	    buttons: {
	        confirm: {
	            label: 'Entregar',
	            className: 'btn-success'
	        },
	        cancel: {
	            label: 'Cancelar',
	            className: 'btn-danger'
	        }
	    },
	    callback: function (result) {
	    	if(result) document.getElementById("formVenta").submit();
	    	
	      //  console.log('This was logged in the callback: ' + result);
	    }
	});
	
	
	
})
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