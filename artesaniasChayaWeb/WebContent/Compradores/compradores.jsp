<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="database.CompradoresData" %>
<%@ page import="entities.Comprador" %>

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
<link href="../Css/PageInPanel.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.21/datatables.min.css"/>
 
 
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.21/datatables.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</head>
<body>
<a href="agregarComp.jsp"><button type="submit" class="btn btn-secondary" id="btnModificar" name="modificar">Añadir</button></a>
<form action="../CompradoresServlet" method="get" >

<table id="tabla" class="table table-striped table-bordered table-sm" style="width:100%">
	<col style="width:13%">
	<col style="width:19%">
	<col style="width:9%">
	<col style="width:22%">
	<col style="width:30%">
	<col style="width:4%">
	<col style="width:3%">
  <thead>
    <tr>
      <th scope="col" >Cuit/Cuil</th>
      <th scope="col" >Nombre</th>
      <th scope="col"> Telefono</th>
      <th scope="col" >Mail</th>
      <th scope="col"  >Direccion</th>
      <th scope="col" colspan="2" >Accion</th>
      
    </tr>
  </thead>
  <tbody>
	<%
	CompradoresData pd= new CompradoresData();
	ArrayList<Comprador> list = pd.getAll(session.getAttribute("usuario").toString()
			,session.getAttribute("contra").toString()); 
	HttpSession miSesion= request.getSession(false);
	miSesion.setAttribute("compradores", list);
	for(Comprador l: list){%>
		<tr>
			<td  class="colClass"> <%= l.getCuit() %></td> 
			<td ><%= l.getNombre() %></td>
			<td ><%= l.getTelefono() %></td>
			<td ><%= l.getMail() %></td>
			<td ><%= l.getDireccion() +", " + l.getLocalidad() + " " + l.getCodigoPostal() +", "+ l.getProvincia()%> </td>
			<td ><button type="submit" class="btn btn-primary" id="btnModificar"   name="modificar">Modificar</button></td>  <%-- value="<%= Integer.toString(l.getId()) %>" --%>
			<td><button type="submit" class="btn btn-secondary" id="btnEliminar"  name="eliminar">Borrar</button></td>

		</tr>
	
	<%} %>


    
 </tbody>
</table>
<input type="hidden" id="auction" name="auction" value="">
<input type="hidden" id="aux" name="aux" >
</form>
</body>
<script>

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

$(document).ready(function(){
	$('#dtBasicExample').DataTable();
	$('.dataTables_length').addClass('bs-select');

	
    $('#tabla').DataTable( {
        "paging":   false,
        //"ordering": false,
        "info":     false
    } );



	
	});

</script>
</html>