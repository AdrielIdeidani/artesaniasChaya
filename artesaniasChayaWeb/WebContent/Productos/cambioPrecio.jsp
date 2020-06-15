<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</head>
<body>
 <form action="../PreciosServlet" class="formPrecio" id="formPrecio" method="get">
<div>
<div>
<h5 style="display:inline">Id: </h5>
<%=request.getParameter("id") %>
<h5 style="display:inline"> Nombre: </h5>
 <%=request.getParameter("nombre") %>
</div>

<br>
<div> 
<h5 style="display:inline">Precio Actual:  		
</h5>
<%=request.getParameter("precio") %>	
<h5 style="display:inline">Ultimo Aumento:  
</h5>
<%=request.getParameter("fecha") %>
</div>

<br>

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
<input type="submit" class="btn btn-primary" id="agregar" value="OK" style="float:right">
</div>
<input type="hidden" name="id" value=<%=request.getParameter("id") %>>
<input type="hidden" name="precioActual" value=<%=request.getParameter("precio") %>>

</form>

</body>



<script >


$(document).ready(function() {
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
});
</script>
</html>