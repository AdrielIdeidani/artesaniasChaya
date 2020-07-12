<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="database.PresupuestoData" %>
<%@ page import="entities.Presupuesto" %>
<%@ page import="entities.Producto" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Tabaqueria Chaya</title>

 <script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/esm/popper-utils.js" ></script>
   <link href="../Css/PageInPanel.css" rel="stylesheet" type="text/css"/>  
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.21/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.21/datatables.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.4.0/bootbox.min.js"></script> 
</head>
<body>
<%PresupuestoData pd = new PresupuestoData(); 
HttpSession miSesion= request.getSession(false);
ArrayList<Presupuesto> presupuestos = new ArrayList<Presupuesto>();
presupuestos =pd.getVendidoBetween(session.getAttribute("usuario").toString()
		,session.getAttribute("contra").toString(), "5000", "-1"); %>
<table class="table table-bordered table-sm" id="tabla">
  <thead>
    <tr>
      <th scope="col">Id</th>
      <th scope="col">Comprador</th>
      <th scope="col">Fecha</th>
      <th scope="col">Total</th>
      <th scope="col"></th>
      
    </tr>
  </thead>
  <tbody>
  
  <%for(Presupuesto l: presupuestos){%>
		<tr class="collapse2">
			<td class="colClass" ><%= String.valueOf(l.getNro()) %></td>
			<td ><%= l.getNombre() %></td>
			<td ><%= l.getFecha() %></td>
			<td ><%=l.getSubtotal() - l.getDescuento() %></td>
			<td><input type="submit" value="PDF" class="btn btn-info"></td>
		</tr>

		<%for (Producto prod:l.getProds()){ %>
		 <tr class="comun">
			<td> <%= prod.getId() %></td>
			<td><%=prod.getNombre() %></td>
			<td><%=prod.getCant() + " x " + prod.getPrecio() %></td>
			<td><%=prod.getCant()*prod.getPrecio() %>
			<td></td>
		</tr> 
  <%}} %>
  </tbody>
  </table>
<script>
$('#dtBasicExample').DataTable();
$('.dataTables_length').addClass('bs-select');
$(document).ready(function() {
	/*  */
	    $('#tabla').DataTable( {
	    	scrollY: '500px',
	    	"bSort": false,
	        paging:   false,
	       info:     false,
	       searching: true
	    } );
} );
	
</script>	
</body>
</html>