<%@page import="database.CompradoresData"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="entities.Comprador" %>

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
<link href="../Css/PageInPanel.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<style>
form{
line-height:0.7}
</style>
</head>
<body>
<div>
		<form action="../CompradoresServlet" method="post" >
		<%	
		String idComprador = request.getParameter("idComprador");
		

		    if (idComprador!=null){
		    	HttpSession miSesion= request.getSession(false);
		    	CompradoresData cd= new CompradoresData();
		    	Comprador comp = cd.getOne(session.getAttribute("usuario").toString()
						,session.getAttribute("contra").toString(),idComprador);
		 
		    
		    %>
<br>
<div style="display:inline">
<h5 class="small" ><b>Cuit/Cuil</b></h5>
<input type="text" id="id" name="id" class="form-control" placeholder="Id"  maxlength="20"	value=<%=comp.getCuit() %> >
</div>
<br>
<h5 class="small"><b>Nombre</b></h5>
<input type="text" id="nombre" name="nombre" class="form-control" maxlength="45" placeholder="Nombre" value="<%=comp.getNombre() %>">
<br>
<h5 class="small"><b>Direccion</b></h5>
<input type="text" id="direccion" name="direccion" class="form-control" maxlength="45" placeholder="Direccion" value="<%=comp.getDireccion() %>">
<br>
<h5 class="small"><b>Localidad</b></h5>
<input type="text" id="localidad" name="localidad" class="form-control" maxlength="45" placeholder="Localidad" value="<%=comp.getLocalidad() %>">
<br>
<h5 class="small"><b>Codigo Postal</b></h5>
<input type="text" id="codigoPostal" class="form-control" name="codigoPostal" maxlength="45" placeholder="Codigo Postal" value="<%=comp.getCodigoPostal() %>">
<br>
<h5 class="small"><b>Provincia</b></h5>
<input type="text" id="provincia" name="provincia" class="form-control" maxlength="45" placeholder="Provincia" value="<%=comp.getProvincia() %>">
<br>
<h5 class="small"><b>Telefono</b></h5>
<input type="text" id="telefono" class="form-control" name="telefono" maxlength="45" placeholder="Telefono" value="<%=comp.getTelefono() %>">
<br>
<h5 class="small"><b>Mail</b></h5>
<input type="email" id="mail" class="form-control" name="mail" maxlength="45" placeholder="Email" value="<%=comp.getMail() %>">
<br>
<input type="hidden" id="auction" name="auction" value="modificar">
<input type="hidden" id="aux" name="aux" value= "<%=comp.getCuit() %>">
<input type="submit" class="btn btn-primary" id="agregar" value="Actualizar" style="float:right">

<%} else {%>
<br>
<input type="text" id="id" name="id" maxlength="20" class="form-control" placeholder="Cuit">
<br> 
<input type="text" id="nombre" name="nombre" maxlength="45" class="form-control" placeholder="Nombre">
<br>
<input type="text" id="direccion" name="direccion" maxlength="45"  class="form-control" placeholder="Direccion">
<br>
<input type="text" id="localidad" name="localidad" maxlength="45" class="form-control" placeholder="Localidad">
<br>
<input type="text" id="codigoPostal" name="codigoPostal" maxlength="45" class="form-control" placeholder="Codigo Postal">
<br>
<input type="text" id="provincia" name="provincia" maxlength="45" class="form-control" placeholder="Provincia">
<br>
<input type="text" id="telefono" class="form-control" maxlength="45" name="telefono" placeholder="Telefono">
<br>
<input type="email" id="mail" class="form-control" maxlength="45" name="mail" placeholder="Mail">
<br>
<input type="hidden" id="auction" name="auction" value="agregar">
<input type="submit" class="btn btn-primary" id="agregar" value="Agregar" style="float:right">

<%} %>


</form>


<a href="compradores.jsp"><button type="button" class="btn btn-secondary" id="volver" style="float:left">Volver</button>
</a>

</div>


</body>
</html>