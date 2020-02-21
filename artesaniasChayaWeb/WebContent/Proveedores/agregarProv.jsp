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
<link href="Css/PageInPanel.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</head>
<body>
<div>
		<form action="../ProveedoresServlet" method="post" >
<br>
<input type="text" id="cuit" name="cuit" class="form-control" placeholder="Cuit">
<br>
<input type="text" id="razonSocial" name="razonSocial" class="form-control" placeholder="Razon Social">
<br>
<input type="text" id="direccion" name="direccion" class="form-control" placeholder="Direccion">
<br>
<input type="text" id="telefono" class="form-control" name="telefono" placeholder="Telefono">
<br>
<input type="email" id="mail" class="form-control" name="mail" placeholder="Email">
<br>
<input type="submit" class="btn btn-primary" id="agregar" value="Agregar" style="float:right">

<input type="hidden" id="user" name="user" value=<%= session.getAttribute("usuario").toString()%> >
<input type="hidden" name="contra" id="contra" value=<%= session.getAttribute("contra").toString()%> >

</form>


<a href="proveedores.jsp"><button type="button" class="btn btn-secondary" id="volver" style="float:left">Volver</button>
</a>

</div>


</body>
</html>