<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="entities.ProductoConAumentoPrecio" %>
 <%@ page import="entities.Producto"%>
<%@ page import="database.ProductosData"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Tabaquería Chaya</title>
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
<form action="../PreciosServlet" id="formPrecio" method="post" >

 <div class="modal" id="myModal">
    <div class="modal-dialog2">
      <div class="modal-content2">

        <div class="modal-header2">
          <h4 class="modal-title2">Aumentar Precio</h4>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body2" >
         
         <div class="form-check">
  <input class="form-check-input" type="radio"  value="cantidad" name="radio" id="cantidad">
  <label id="labelCantidad" class="form-check-label" for="cantidad">
   Aumentar en una Cantidad
  </label>
  <input type="text" style="display:none " id="textCantidad" name="textCantidad" placeholder="Aumentar en:">
</div>
<div class="form-check">
  <input class="form-check-input" type="radio"  value="total" name="radio"  id="total" >
  <label id="labelTotal" class="form-check-label" for="total">
	Nuevo Precio
  </label>
    <input type="text" style="display:none " id="textTotal" name="textTotal" placeholder="Aumentar a:">
  
</div>
<div class="form-check">
  <input class="form-check-input" type="radio"  value="porcentaje" name="radio"  id="porcentaje" >
  <label id="labelPorcentaje" class="form-check-label" for="porcentaje">
	Aumentar en Porcentaje
  </label>
    <input type="text"  id="textPorcentaje"  name="textPorcentaje" placeholder="Aumentar en %:">
</div>
<input type="submit" class="btn btn-primary" onclick="entregar()" id="agregar" value="OK" style="float:right">
<input type="button" class="btn btn-danger" id="cancelar" value="Cancelar" style="float:right" data-dismiss="modal">

</div>
 
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer2">
       
<!--          <label id="totalModal" for="totalModal" style="top:5px; left:5px; position:relative text-align: left " >0</label>
 -->      	 
      	 <!-- <button type="button" onclick="entregar()" class="btn btn-primary" data-dismiss="modal">Agregar y Entregar</button>
      	  <button type="button" onclick="agregar()" class="btn btn-success" data-dismiss="modal">Agregar</button>
      	 <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
      	 -->
        </div>
        
      </div>
    </div>
  



<!-- <form action="../PreciosServlet" id="formPrecio" method="post" >
 --><table id="tabla" class="table table-striped table-bordered table-sm" ><!-- cellspacing="0" width="100%"> -->
  <thead>
    <tr>
	  <th scope="col"></th>
      <th scope="col">Id</th>
      <th scope="col">Descripcion</th>
      <th scope="col">Empresa</th>
      <th scope="col">Precio Actual</th>
      <th scope="col">Ultima Actualizacion</th>
      
    </tr>
   </thead>
<tbody>
<% ProductosData pd= new ProductosData();
HttpSession miSesion= request.getSession(false);
ArrayList<ProductoConAumentoPrecio> precios =(ArrayList)miSesion.getAttribute("precios");

ArrayList<Producto> list = pd.getAll(session.getAttribute("usuario").toString()
		,session.getAttribute("contra").toString()); 

for(Producto l:list){
	String bandera="0";
	for(ProductoConAumentoPrecio p:precios){
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
	<td class="colClass"><%=l.getEmpresa() %></td>
	<td class="colClass"><%=l.getPrecio() %></td>
	<td class="colClass"><%=l.getFecha_desde() %></td>
	
	</tr>
	
<%}}%>

  </tbody>


</tbody>
	
</table>
<a href="precios.jsp"><button type="button" class="btn btn-secondary" id="volver" style="float:left">Volver</button></a>
<input type="button" value="Agregar" class="btn btn-primary btnAgregar" id="btnAgregar" data-toggle="modal" style="float:right" data-target="#myModal">
<input type="hidden" id="idsHidden" name="idsHidden" value="">
<input type="hidden" id="auction" name="auction" value="seleccionar">

</form>
<script>


function entregar(){
	//alert("entregar");

	var ids = new Array();
	$('#tabla tbody tr').each(function() {
		var check=$(this).find(".colCheck :checked").length;
		if (check=='1'){
			ids.push($(this).find(".colId").text());
		}
		
		
	})
	//alert(ids);
	$("#idsHidden").val(ids);
	document.getElementById("formPrecio").submit();

	}

$(document).ready(function () {

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
	
	$("#tabla tbody tr .colClass,#tabla tbody tr .colId").click(function(){
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
		
	})
	
	
$('#dtBasicExample').DataTable();
$('.dataTables_length').addClass('bs-select');
});
$(document).ready(function() {
    $('#tabla').DataTable( {
        "paging":   false,
        //"ordering": false,
        "info":     false
    } );
} );


</script>

</body>
</html>