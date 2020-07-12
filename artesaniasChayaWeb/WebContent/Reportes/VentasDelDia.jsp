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
<style>
body {font-family: Arial;}

tr.collapse2.even, tr.collapse2.odd {
    background-color: #add8e6;
    cursor: pointer;
    color: black;
}
.collapse2{
	background-color: #add8e6;
	cursor:pointer;
	color:black;
}
/* Style the tab */
.tab {
  overflow: hidden;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
}

/* Style the buttons inside the tab */
.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current tablink class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
  display: none;
  padding: 6px 12px;
  border: 1px solid #ccc;
  border-top: none;
}
</style>
</head>
<body>
<form  id="formVenta" action="../VentaServlet" method="get">

<!-- <h2>Tabs</h2>
<p>Click on the buttons inside the tabbed menu:</p> -->

<div class="tab">
  <button class="tablinks" onclick="openCity(event, 'Hoy')">Hoy</button>
  <button class="tablinks" onclick="openCity(event, 'Ayer')">Ayer</button>
  <button class="tablinks" onclick="openCity(event, 'Ultimos 7 dias')">Ultimos 7 dias</button>
  <button class="tablinks" onclick="openCity(event, 'Todos')">Todos</button>
</div>
<%PresupuestoData pd = new PresupuestoData(); 
HttpSession miSesion= request.getSession(false);
ArrayList<Presupuesto> presupuestos = new ArrayList<Presupuesto>();
presupuestos =pd.getVendidoBetween(session.getAttribute("usuario").toString()
		,session.getAttribute("contra").toString(), "5000", "-1");
miSesion.setAttribute("presupuestos", presupuestos);
String aux; //Para buscar en el Todos
%>	    	
<div id="Hoy" class="tabcontent">
<%  presupuestos =pd.getVendidoBetween(session.getAttribute("usuario").toString()
		,session.getAttribute("contra").toString(), "0", "-1"); %>
<table class="table table-bordered table-sm" id="tablaHoy">
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
		</tr>
  <%}} %>
  </tbody>
  </table>

</div>

<div id="Ayer" class="tabcontent">
 <% presupuestos =pd.getVendidoBetween(session.getAttribute("usuario").toString()
		,session.getAttribute("contra").toString(), "1", "0"); %>
<table class="table table-bordered table-sm" id="tablaAyer">
  <thead>
    <tr>
      <th scope="col">Id</th>
      <th scope="col">Comprador</th>
      <th scope="col">Fecha</th>
      <th scope="col">Total</th>
      <th></th>
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
		</tr>
  <%}} %>
  </tbody>
  </table>
</div>

<div id="Ultimos 7 dias" class="tabcontent">
  <% presupuestos =pd.getVendidoBetween(session.getAttribute("usuario").toString()
		,session.getAttribute("contra").toString(), "7", "0"); %>
<table class="table  table-bordered table-sm" id="tabla7">
  <thead>
    <tr>
      <th scope="col">Id</th>
      <th scope="col">Comprador</th>
      <th scope="col">Fecha</th>
      <th scope="col">Total</th>
      <th></th>
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
		</tr>
  <%}} %>
  </tbody>
  </table>
</div>
<div id="Todos" class="tabcontent">
<h5 style="font-size: 14px;">Si se busca un producto en especifico solo se van a mostrar esos productos y los pedidos donde aparece. El resto de
productos de ese pedido estaran ocultos</h5>
 <% presupuestos =pd.getVendidoBetween(session.getAttribute("usuario").toString()
		,session.getAttribute("contra").toString(), "5000", "-1"); %>
<table class="table  table-bordered table-sm" id="tablaTodos">
  <thead>
    <tr>
      <th scope="col">Id</th>
      <th scope="col">Comprador</th>
      <th scope="col">Fecha</th>
      <th scope="col">Total</th>
       <th scope="col">PDF</th>
       <th scope="col" style="display: none"></th>
       
    </tr>
  </thead>
  <tbody>
  
  <%for(Presupuesto l: presupuestos){
  aux="";%>
  <%for (Producto prod:l.getProds()){ 
  aux=aux.concat(prod.getId()).concat(prod.getNombre());
  }
  %>
		<tr class="collapse2">
			<td class="colClass" ><%= String.valueOf(l.getNro()) %></td>
			<td ><%= l.getNombre() %></td>
			<td ><%= l.getFecha() %></td>
			<td ><%=l.getSubtotal() - l.getDescuento() %></td>
			<td><input type="submit" value="PDF" class="btn btn-info"></td>
			<td style="display: none"><%=aux %></td>
		</tr>
		<%for (Producto prod:l.getProds()){ %>
		<tr class="comun">
			<td> <%= prod.getId() %></td>
			<td><%=prod.getNombre() %></td>
			<td><%=prod.getCant() + " x " + prod.getPrecio() %></td>
			<td><%=prod.getCant()*prod.getPrecio() %>
			<td></td>
			<td style="display: none"><%=  String.valueOf(l.getNro()).concat(l.getNombre()).
			concat(String.valueOf(l.getFecha())).concat(l.getLocalidad())			%></td>
			
		</tr>
  <%}} %>
  </tbody>
  </table>
</div>
<input type="hidden" name="aux" id="aux" value="">
</form>

<script>
$(document).ready(function(){
	 $('#tablaTodos').DataTable( {
		    "paging":   false,
		    "scrollY": '440px',
		    "bSort": false,
		    //"ordering": false,
		    "info":     false
		} ); 

});
$(".btn-info").click(function() {
	var $row = $(this).closest("tr");    // Find the row
	var $text = $row.find(".colClass").text(); // Find the text
	$('#aux').val($row.find(".colClass").text());

})
$('.collapse2').click(function() { 
	$(this).nextUntil('tr.collapse2').slideToggle(10);
			}	)
function openCity(evt, cityName) {
	evt.preventDefault();
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }
  document.getElementById(cityName).style.display = "block";
  evt.currentTarget.className += " active";

/* 	 $('#tablaTodos').DataTable( {
	    "paging":   false,
	    "scrollY": '490px',
	    "bSort": false,
	    //"ordering": false,
	    "info":     false
	} );  */
   if(cityName=='Todos'){
 
} 
}
</script>
</body>
</html>