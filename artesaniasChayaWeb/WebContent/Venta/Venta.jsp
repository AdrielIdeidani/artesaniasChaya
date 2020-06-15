<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="database.ProductosData"%>
<%@ page import="entities.Producto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="database.CompradoresData" %>
<%@ page import="entities.Comprador" %>
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
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.21/datatables.min.css"/>
 
 
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.21/datatables.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.4.0/bootbox.min.js"></script>
</head>
<body>
<form  id="formCompradores" name="formCompradores" action="CompradoresServlet" method="get">
<div style="display:inline-block">
<label for="pedidoLabel">Nro Presupuesto:</label>
<label for="pedidoNro" style="color:blue">00000</label>

<%
		      String id = request.getParameter("id");
CompradoresData pd= new CompradoresData();
ArrayList<Comprador> list = pd.getAll(session.getAttribute("usuario").toString()
		,session.getAttribute("contra").toString());  
		    if (id!=null){ %>
<select class="form-control" onChange="compradorSelect(this)">
<option value="<%=request.getParameter("nombre") %>"><%=request.getParameter("nombre") %></option>

<%		for (Comprador comp:list){		%>
<option value="<%=comp.getId()%>"><%=comp.getNombre() %></option>
<%} %>
<option value="comprador">----</option>
</select>
</div>
<br>
<div class="row" >
<div class="col">
<input type="text" id="nombre" name="nombre" class="form-control" readonly placeholder="<%=request.getParameter("nombre")%>">
</div>
<div class="col">
<input type="text" id="telefono" class="form-control" name="telefono" readonly placeholder="<%=request.getParameter("telefono")%>">
</div>
<div class="col">
<input type="email" id="mail" class="form-control" name="mail" readonly placeholder="<%=request.getParameter("mail")%>">
</div>
</div>
<div class="row">
<div class="col">
<input type="text" id="direccion" name="direccion" class="form-control" readonly placeholder="<%=request.getParameter("direccion")%>">
</div>
<div class="col">
<input type="text" id="localidad" name="localidad" class="form-control" readonly placeholder="<%=request.getParameter("localidad")%>">
</div>
<div class="col">
<input type="text" id="provincia" name="provincia" class="form-control" readonly placeholder="<%=request.getParameter("provincia")%>">
</div>
</div>
<input type="hidden" id="aux" name="aux">
<input type="hidden" id="auction"  name="auction">

<%} else{ %>
<select class="form-control" onChange="compradorSelect(this)">
<option value="comprador">Poner Comprador:</option>
<%

		for (Comprador comp:list){		%>
<option value="<%=comp.getId()%>"><%=comp.getNombre() %></option>
<%} %>
</select>
</div>
<br>
<div class="row" >
<div class="col">
<input type="text" id="nombre" name="nombre" class="form-control" placeholder="Nombre">
</div>
<div class="col">
<input type="text" id="telefono" class="form-control" name="telefono" placeholder="Telefono">
</div>
<div class="col">
<input type="email" id="mail" class="form-control" name="mail" placeholder="Mail">
</div>
</div>
<div class="row">
<div class="col">
<input type="text" id="direccion" name="direccion" class="form-control" placeholder="Direccion">
</div>
<div class="col">
<input type="text" id="localidad" name="localidad" class="form-control" placeholder="Localidad">
</div>
<div class="col">
<input type="text" id="provincia" name="provincia" class="form-control" placeholder="Provincia">
</div>
</div>
<%} %>
<input type="hidden" id="aux" name="aux">
<input type="hidden" id="auction"  name="auction">

</form>
<form  id="formVenta" action="VentaServlet" method="post">

<table id="tabla" class="table table-dark" > <!-- class="table table-dark" -->
  <thead>
    <tr>
      <th scope="col">X</th>
      <th scope="col">Id</th>
      <th scope="col">Nombre</th>
      <th scope="col">Precio</th>
      <th scope="col">Cantidad</th>
      </tr>
  </thead>
  <tbody>
<% HttpSession miSesion= request.getSession(false);
ArrayList<Producto> ped =(ArrayList)miSesion.getAttribute("pedido");
ArrayList<Producto> prod = (ArrayList) miSesion.getAttribute("productos");
if(ped!=null){
	
		for(Producto l: ped){%>
<tr>
    <td scope="row"><button type="submit" id="btnEliminar" class="btn btn-outline-danger" value=<%=l.getId()%> name="eliminar">X</button></td>
    <td class="colClass"><%=l.getId() %></td>
    <td><%=l.getNombre() %></td>
    <td><%=l.getPrecio()%></td>
    <td><%=l.getCant() %></td>
    

<%} }%>
 
 
    
    
    
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
<input type="hidden" id="total" name="total" value=<%= df.format(total)%>>
<input type="button" name="Descuento" value="Descuento">
</form>
 
 
</body>
<script>
function compradorSelect(selectObject) {
	  var value = selectObject.value;  
	
	  if (value !="comprador"){
		  $('#aux').val(value);
		  $('#auction').val("venta");
		  document.getElementById("formCompradores").submit();
	   
	
} else{
	$('#auction').val("cambiarCompradorANulo");
	  document.getElementById("formCompradores").submit();
}
}


$(".btn-dark").click(function(){
	$('#auction').val("entregar");
	//bootbox.alert("Total: $" + $("#total").val());
	bootbox.confirm({
		title: "Confirmar Pedido",
	    message: "Total $" + $("#total").val() ,
	    buttons: {
	      
	        cancel: {
	            label: 'Cancelar',
	            className: 'btn-danger '
	        },
	        confirm: {
	            label: 'Entregar',
	            className: 'btn-success '
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