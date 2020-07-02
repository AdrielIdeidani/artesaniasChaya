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
<style type="text/css">

/* body{
background: black;
} */



 
</style>
<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/esm/popper-utils.js" ></script>
 

<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
 
<link href="Venta.css" rel="stylesheet"> <!-- type="text/css"/> -->
<script type="text/javascript" src="//cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.4.0/bootbox.min.js"></script>
</head>
<body>
<form  id="formCompradores" name="formCompradores" action="../CompradoresServlet" method="get">
<div style="display:inline-block">
<!-- <label for="pedidoLabel">Nro Presupuesto:</label>
<label for="pedidoNro" style="color:blue">00000</label> -->
<%
ProductosData pd2= new ProductosData();
ArrayList<Producto> listP = pd2.getAll(session.getAttribute("usuario").toString()
		,session.getAttribute("contra").toString());  
%>
<%
HttpSession miSesion= request.getSession(false);
	     /*  String id = request.getParameter("id"); */
CompradoresData pd= new CompradoresData();

String cuit = miSesion.getAttribute("comprador").toString();
String nombreText,cuitText,telefonoText,mailText,direccionText,localidadText,provinciaText,codigoText;
System.out.println(cuit);
System.out.println(cuit);
System.out.println(cuit);
System.out.println(cuit);

//Apenas carga o cuando ponemos en un comprador vacio

/* if (request.getParameter("cuit").toString()!=""){
	 cuitText=request.getParameter("cuit").toString();
} else cuitText=""; */
if(cuit.equals("0")){


 	 cuitText="";
 	 nombreText="";
	 telefonoText="";
	 mailText="";
	 direccionText="";
	 localidadText="";
	 provinciaText= ""; 
	 codigoText="";
}	
else if(cuit.equals("-1")){
	 cuitText=request.getParameter("cuit").toString();
	 nombreText=request.getParameter("nombre").toString();
	 telefonoText=request.getParameter("telefono").toString();
	 mailText=request.getParameter("mail").toString();
	 direccionText=request.getParameter("direccion").toString();
	 localidadText=request.getParameter("localidad").toString();
	 provinciaText= request.getParameter("provincia").toString(); 
	 codigoText=request.getParameter("codigoPostal").toString();

}
else{
	Comprador c = pd.getOne(session.getAttribute("usuario").toString()
			,session.getAttribute("contra").toString(), cuit);
	 cuitText=String.valueOf(c.getCuit());
	 nombreText=c.getNombre();
	 telefonoText=c.getTelefono();
	 mailText=c.getMail();
	 direccionText=c.getDireccion();
	 localidadText=c.getLocalidad();
	 provinciaText=c.getProvincia();
	 codigoText=c.getCodigoPostal();
	
}

ArrayList<Comprador> list = pd.getAll(session.getAttribute("usuario").toString()
		,session.getAttribute("contra").toString());   %>
		
<%
if (cuit.equals("0")){
%>
<select class="form-control" onChange="compradorSelect(this)">
<option value="comprador" >Comprador:</option>
<%		for (Comprador comp:list){		%>
<option value="<%=comp.getCuit()%>"><%=comp.getNombre() %></option>
<%} %>
<option value="comprador" >-----</option>

</select>
<%
}else if (cuit.equals("-1")){
%>
<select class="form-control" onChange="compradorSelect(this)">
<option >Agregando Comprador</option>
<%		for (Comprador comp:list){		%>
<option value="<%=comp.getCuit()%>"><%=comp.getNombre() %></option>
<%} %>
<!-- <option value="comprador" >-----</option>
 --></select>
<%} else{ %>

<select class="form-control" onChange="compradorSelect(this)">
<option value="<%=request.getParameter("nombre") %>"><%=request.getParameter("nombre") %></option>

<%		for (Comprador comp:list){		%>
<option value="<%=comp.getCuit() %>"><%=comp.getNombre() %></option>
<%} %>
<option value="comprador" >Otro</option>
</select>


<%} %>
<%-- <select class="form-control" onChange="compradorSelect(this)">
<option value="<%=request.getParameter("nombre") %>"><%=request.getParameter("nombre") %></option>

<%		for (Comprador comp:list){		%>
<option value="<%=comp.getCuit()%>"><%=comp.getNombre() %></option>
<%} %>
<option value="comprador" >----</option>
</select> --%>
</div>
<%-- <%} %> --%>
<br>
<div class="row" >
<div class="col">
<label for="nombre">Nombre:</label>
<input type="text" id="nombre" name="nombre" class="form-control" value="<%= nombreText %>"  placeholder="<%= nombreText%>"> <!-- request.getParameter("nombre") -->
</div>
<div class="col">
<label for="cuit">Cuit/Cuil:</label>
<input type="text" id="cuit" name="cuit" class="form-control" value="<%=cuitText %>" placeholder="<%=cuitText%>">
</div>
<div class="col">
<label for="telefono">Telefono:</label>
<input type="text" id="telefono" class="form-control" name="telefono"  value="<%=telefonoText %>" placeholder="<%=telefonoText%>">
</div>

<div class="col">
<label for="mail ">Mail:</label>

<input type="email" id="mail" class="form-control" name="mail" value="<%=mailText %>"  placeholder="<%=mailText%>">
</div>
</div>
<div class="row">
<div class="col">
<label for="direccion">Direccion:</label>
<input type="text" id="direccion" name="direccion" class="form-control" value="<%=direccionText %>"  placeholder="<%=direccionText%>">
</div>
<div class="col">
<label for="localidad">Localidad:</label>
<input type="text" id="localidad" name="localidad" class="form-control" value="<%=localidadText %>" placeholder="<%=localidadText%>">
</div>
<div class="col">
<label for="codigoPostal">CP:</label>
<input type="text" id="codigoPostal" name="codigoPostal" class="form-control" value="<%=codigoText %>" placeholder="<%=codigoText%>">
</div>
<div class="col">
<label for="provincia">Provincia:</label>
<input type="text" id="provincia" name="provincia" class="form-control"  value="<%=provinciaText %>" placeholder="<%=provinciaText%>">
</div>
</div>
<input type="hidden" id="aux" name="aux">
<input type="hidden" id="auction"  name="auction">

<input type="hidden" id="aux" name="aux">
<input type="hidden" id="auction"  name="auction">

</form>

<form  id="formVenta" action="../VentaServlet" method="post">


<div class="modal" id="modalDescuento">

<div class="modal-dialog2">
      <div class="modal-content2" style="width:600px;height:200px;">

        <div class="modal-header2">
          <h4 class="modal-title2">Descuentos</h4>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body2" style="max-height:100%">
<div class="form-check">
  <input class="form-check-input" type="radio"  value="cantidad" name="radio" id="cantidad">
  <label id="labelCantidad" class="form-check-label" for="cantidad">
   Descuento fijo
  </label>
  <input type="text" style="display:none " id="textCantidad" name="textCantidad" placeholder="Descontar en:">
</div>
<div class="form-check">
  <input class="form-check-input" type="radio"  value="total" name="radio"  id="total" >
  <label id="labelTotal" class="form-check-label" for="total">
	Nuevo Precio
  </label>
    <input type="text" style="display:none " id="textTotal" name="textTotal" placeholder="Nuevo Total:">
  
</div>

<div class="form-check">
  <input class="form-check-input" type="radio"  value="porcentaje" name="radio"  id="porcentaje" >
  <label id="labelPorcentaje" class="form-check-label" for="porcentaje">
	Descontar en Porcentaje
  </label>
    <input type="text"  id="textPorcentaje"  name="textPorcentaje" placeholder="Descontar en %:">
</div>
<div class="form-check">
  <input class="form-check-input" type="radio"  checked value="sinDescuento" name="radio"  id="sinDescuento" >
<label id="labelSin" class="form-check-label" for="sinDescuento">
	Sin Descuento
  </label>
  
</div>
<b>Subtotal:</b> $<label for="totalLabelModal" id="totalLabelModal" class="totalLabel" style="color: green">0</label>

<input type="submit" class="btn btn-primary" onclick="entregar()" id="agregar" value="OK" style="float:right">
<input type="button" class="btn btn-danger" id="cancelar" value="Cancelar" style="float:right" data-dismiss="modal">



               </div>
        
      </div>
    </div>
      </div>
        


<div class="modal" id="myModal" >
    <div class="modal-dialog2">
      <div class="modal-content2" style="width:800px;height:600px;">

        <div class="modal-header2">
          <h4 class="modal-title2">Seleccionar Productos</h4>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body2" style="max-height:100%">
        
        
        
              
   
  
        <!-- <div id="tabla_filter" class="dataTables_filter">
        <label>
        Buscar:
        <input type="search" class placeholder aria-controls="tablaAgregar">
        </label>
        
        </div> -->
       <table id="tablaAgregar" class="table table-striped table-bordered table-sm" ><!-- cellspacing="0" width="100%"> -->
  <thead>
    <tr>
	  <th scope="col" style="width:38px" ></th>
      <th scope="col" style="width:188px">Id</th>
      <th scope="col" style="width:301px">Descripcion</th>
      <th scope="col" style="width:74px">Precio</th>
<!--       <th scope="col">Cantidad</th>
 -->     </tr>
      </thead>
<tbody>
<% ProductosData pdData= new ProductosData();

ArrayList<Producto> ped =(ArrayList)miSesion.getAttribute("pedido");
ArrayList<Producto> prod = (ArrayList) miSesion.getAttribute("productos");
ArrayList<Producto> listProds = pdData.getAll(session.getAttribute("usuario").toString()
		,session.getAttribute("contra").toString()); 

for(Producto l:listProds){
	String bandera="0";
	for (Producto p:ped){
		if(l.getId().equals(p.getId())){
			bandera="1";
			break;
			
		}
		
	}
	if(bandera=="0"){
		
	
	%>
<tr>
	<td class="colCheck"><input type="checkbox" id="<%=l.getId() %>" name="<%=l.getId() %>" value="<%=l.getId()%>"></td>
	<td class="colId"><%=l.getId() %></td>
	<td class="colClass"><%=l.getNombre() %></td>
	<td class="colClass"><%=l.getPrecio() %></td>
<!-- 	<td>0</td>
 --></tr>
    <%}} %>
    </tbody>
    </table>
        <input type="button" class="btn btn-danger" id="cancelar" value="Cancelar" style="float:right" data-dismiss="modal">
        <input type="submit" class="btn btn-primary aceptar" id="Aceptar" value="Aceptar" style="float:right" >
        
              </div>
        
      </div>
    </div>
      </div>

<div class="table-wrapper-scroll-y my-custom-scrollbar">
<table id="tablaProds" class="table display table-striped table-bordered  mb-0 table-sm " > <!-- class="table table-dark" -->
  <thead>
    <tr>
      <th scope="col" width="5%">X</th>
      <th scope="col" width="15%">Id</th>
      <th scope="col" width="35%">Nombre</th>
      <th scope="col" width="22%">Precio</th>
      <th scope="col" class="colCant" width="23%">Cantidad</th>
      </tr>
  </thead>
  <tbody>
<% /* HttpSession miSesion= request.getSession(false); */

if(ped!=null){
	
		for(Producto l: ped){%>
<tr>
    <td  scope="row"><button type="submit" id="btnEliminar" class="btn btn-outline-danger eliminar" value=<%=l.getId()%> name="eliminar">X</button></td>
    <td  class="colClass"><%=l.getId() %></td>
    <td ><%=l.getNombre() %></td>
    <td  class="colPrecio"><%=l.getPrecio()%></td>
    <td  class="colCant"><input type="number" name="colCant" value="<%=l.getCant() %>" onkeyup="cantidades()" onInput="cantidades()" onChange="cantidades()" min="1"></td>
    

<%} }%>
 
 <tr>
 <td colspan="2"><input type="button" class="btn btn-secondary" data-toggle="modal" onclick="mostrar()" data-target="#myModal" value="Agregar Productos" id="agregarProds" name="agregarProds"></td>
 </tr>
    
    
    
  </tbody>
</table>
</div>
<div style="float:right">
<!-- <b>Subtotal:</b> $<label for="subtotalLabel" id="subtotalLabel">0</label>
&emsp;
&emsp;
&emsp;&emsp;
<button type="button" class="btn btn-info" data-toggle="modal"  data-target="#modalDescuento" id="btnDescuento">
<b>Descuento</b>
</button>$<label for="descuentoLabel" id="descuentoLabel">0</label> -->
&emsp;
&emsp;
&emsp;&emsp;
<b>Total:</b> $<label for="totalLabel" id="totalLabel" class="totalLabel" style="color: green">0</label>
&emsp;
&emsp;
&emsp;&emsp;
<button type="button" class="btn btn-info" id="ShowButton" data-toggle="modal"  data-target="#modalDescuento">
<b>Continuar</b>

</button>
&emsp;
&emsp;&emsp;&emsp;
</div>
<input type="hidden" id="cantsHidden" name="cantsHidden" value="999">
<input type="hidden" id="idsHidden" name="idsHidden" value="">


<input type="hidden" id="cuitHidden" name="cuitHidden" value="">
<input type="hidden" id="nombreHidden" name="nombreHidden" value="">
<input type="hidden" id="telefonoHidden" name="telefonoHidden" value="">
<input type="hidden" id="mailHidden" name="mailHidden" value="">
<input type="hidden" id="direccionHidden" name="direccionHidden" value="">
<input type="hidden" id="localidadHidden" name="localidadHidden" value="">
<input type="hidden" id="provinciaHidden" name="provinciaHidden" value="">
<input type="hidden" id="codigoHidden" name="codigoHidden" value="">




<input type="hidden" id="auctionVenta" name="auctionVenta" value="">
<input type="hidden" id="auxVenta" name="auxVenta"  >
<%-- <input type="hidden" id="total" name="total" value=<%= df.format(total)%>>
 --%>
</form>
 
 
</body>
<script>
$(document).ready(function() {
	
	var value = "<%=cuit%>" ;
	if(value>-1){

		$("#nombre").prop("readonly", true);
		$("#cuit").prop("readonly", true);
		$("#mail").prop("readonly", true);
		$("#telefono").prop("readonly", true);
		$("#direccion").prop("readonly", true);
		$("#localidad").prop("readonly", true);
		$("#provincia").prop("readonly", true);
		$("#codigoPostal").prop("readonly", true);

	
	}
	cantidades();

	$("#sinDescuento").click(function(){
		document.getElementById("textPorcentaje").style.display = "none";
		document.getElementById("textTotal").style.display = "none";
		document.getElementById("porcentaje").style.display = "block";
		document.getElementById("total").style.display = "block";
		document.getElementById("cantidad").style.display = "block";
		document.getElementById("labelTotal").style.display = "block";
		document.getElementById("labelPorcentaje").style.display = "block";
		document.getElementById("labelCantidad").style.display = "block";
		document.getElementById("textCantidad").style.display = "none";
	})
	
	$("#cantidad").click(function(){
		//Oculto los otros text box
		document.getElementById("textPorcentaje").style.display = "none";
		document.getElementById("textTotal").style.display = "none";
		document.getElementById("porcentaje").style.display = "block";
		document.getElementById("total").style.display = "block";
		document.getElementById("labelTotal").style.display = "block";
		document.getElementById("labelPorcentaje").style.display = "block";
		//Oculto el Radio seleccionado
		document.getElementById("cantidad").style.display = "none";
		document.getElementById("labelCantidad").style.display = "none";
		document.getElementById("textCantidad").style.display = "block";
	})
	$("#total").click(function(){
		document.getElementById("textPorcentaje").style.display = "none";
		document.getElementById("textCantidad").style.display = "none";
		document.getElementById("porcentaje").style.display = "block";
		document.getElementById("cantidad").style.display = "block";
		document.getElementById("labelPorcentaje").style.display = "block";
		document.getElementById("labelCantidad").style.display = "block";
		//Oculto el Radio seleccionado
		document.getElementById("total").style.display = "none";
		document.getElementById("labelTotal").style.display = "none";
		document.getElementById("textTotal").style.display = "block";
	})
	$("#porcentaje").click(function(){
		//Oculto los otros text box
		document.getElementById("textTotal").style.display = "none";
		document.getElementById("textCantidad").style.display = "none";
		document.getElementById("total").style.display = "block";
		document.getElementById("cantidad").style.display = "block";
		document.getElementById("labelTotal").style.display = "block";
		document.getElementById("labelCantidad").style.display = "block";
		//Oculto el Radio seleccionado
		document.getElementById("porcentaje").style.display = "none";
		document.getElementById("labelPorcentaje").style.display = "none";
		document.getElementById("textPorcentaje").style.display = "block";
	})
	
	
	
	document.getElementById("textPorcentaje").style.display = "none";
	document.getElementById("textTotal").style.display = "none";
	document.getElementById("textCantidad").style.display = "none";
	$(".total").off( "submit" );
	$(".porcentaje").off( "submit" );
	$(".cantidad").off( "submit" );
	$(".sinDescuento").off( "submit" );

	
	$('#tablaProds').DataTable( {
		 	/* "scrollY":        '200px',
	        "scrollCollapse": true,
	        "paging":         false */

    } );
	

} );


function mostrar(){
	
    $('#tablaAgregar').DataTable( {
    	
 /*    	"filter": true,
    	"bFilter":true, */
    	 "scrollY": '350px',
/*     	"scrollCollapse": true, 
 */        "paging":   false,
        "info":     false
    } );

	
}
function cantidades(){
/* alert("Cantidades!"); */
	var cants = new Array();
	var total = 0;
		$('#tablaProds tbody tr').each(function() {
			var aux=$(this).find(".colCant input").val();
				cants.push(aux);
				if(isNaN(aux)){
					
				}
				
				
				else {total = total + parseInt(aux) * parseInt($(this).find(".colPrecio").text	()); /*  */
				}
	});
	$("#cantsHidden").val(cants);
/* 	document.querySelector('#ShowButton').value = total;
 */	/* document.getElementById("subtotalLabel").innerHTML = total ; */

	document.getElementById("totalLabel").innerHTML = total ; /* - document.getElementById("descuentoLabel").innerHTML */
	document.getElementById("totalLabelModal").innerHTML = total ; 
 
	setTimeout(function(){
		document.querySelector('#ShowButton').value = total;
  
		}, 0);
	$('#cuitHidden').val(document.getElementById('cuit').value);
	$('#nombreHidden').val(document.getElementById('nombre').value);
	$('#telefonoHidden').val(document.getElementById('telefono').value);
	$('#mailHidden').val(document.getElementById('mail').value);
	$('#direccionHidden').val(document.getElementById('direccion').value);
	$('#localidadHidden').val(document.getElementById('localidad').value);
	$('#provinciaHidden').val(document.getElementById('provincia').value);
	$('#codigoPostalHidden').val(document.getElementById('codigoPostal').value);
	//alert(total);
	//alert(cants);
} 


$("#tablaAgregar tbody tr ").click(function(){
	var $row = $(this).closest("tr"); 
	var check= $row.find(".colCheck :checked").length;
	
	//Sin checkear
	if(check=='0'){
		$row.find("td:first input:checkbox").prop("checked", true);
		//alert("NO");
	}
	else $row.find(".colCheck :checked").prop("checked", false);

	 //alert("Si");
	//alert(check);
	
});

/* $('#dtBasicExample').DataTable();
$('.dataTables_length').addClass('bs-select'); */


function entregar(){
	

	$('#cuitHidden').val(document.getElementById('cuit').value);
	$('#nombreHidden').val(document.getElementById('nombre').value);
	$('#telefonoHidden').val(document.getElementById('telefono').value);
	$('#mailHidden').val(document.getElementById('mail').value);
	$('#direccionHidden').val(document.getElementById('direccion').value);
	$('#localidadHidden').val(document.getElementById('localidad').value);
	$('#provinciaHidden').val(document.getElementById('provincia').value);
	$('#codigoPostalHidden').val(document.getElementById('codigoPostal').value);
		
	
/* 	$('#cuitHidden').val(document.getElementById('cuit').value);
	$('#nombreHidden').val(document.getElementById('nombre').value);
	$('#telefonoHidden').val(document.getElementById('telefono').value);
	$('#mailHidden').val(document.getElementById('mail').value);
	$('#direccionHidden').val(document.getElementById('direccion').value);
	$('#localidadHidden').val(document.getElementById('localidad').value);
	$('#provinciaHidden').val(document.getElementById('provincia').value);
	$('#codigoPostalHidden').val(document.getElementById('codigoPostal').value); */

	
	$('#auctionVenta').val("entregar");

	document.getElementById("formVenta").submit();

	
	
 } 
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

/* $(".btn-info").click(function(){
	alert("descuento");
	
});
 */
 $(".btn-secondary").click(function(){
	cantidades(); 
 });
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
	
	
	
});


$(".aceptar").click(function() {
	//alert("aceptar");
	$('#auctionVenta').val("agregar");
	var ids = new Array();
	
	$('#tablaAgregar tbody tr').each(function() {
		var check=$(this).find(".colCheck :checked").length;
		if (check=='1'){
			ids.push($(this).find(".colId").text());
		}
		
		
	})
	//alert(ids);
	$("#idsHidden").val(ids);
	cantidades();

//alert("Entra");
})

$(".btn-outline-danger").click(function() {
	cantidades();
	$('#auctionVenta').val("eliminar");
	 var $row = $(this).closest("tr");    // Find the row
	  var $text = $row.find(".colClass").text(); // Find the text
	 $('#auxVenta').val($row.find(".colClass").text());
	 //alert($('#auxVenta').val());
	document.getElementById("formVenta").submit();
})
/* function idBusqueda(){
	

	$('#auction').val("id");
	
	document.getElementById("formVenta").submit();
	

	
}
function nombreBusqueda(){
	$('#auction').val("nombre");
	document.getElementById("formVenta").submit();
	

} */


</script>
</html>