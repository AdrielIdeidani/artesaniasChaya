<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>	
<meta charset="utf-8">
<title>Tabaquería Chaya</title>
<link  rel="stylesheet"- type="text/css" href="Css/Inicio.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</head>
<body>					
<div class="container">
<div class="d-flex justify-content-center h-100">
<div class="card">
<div class="card-header">
	<h3>INICIAR SESIÓN</h3>
	
</div>	

	<div class="card-body">
	<form id="form1" method="get" action="InicioServlet">
	<%
	HttpSession  miSesion= request.getSession(false);

	miSesion.removeAttribute("usuario");
	miSesion.removeAttribute("contra");

	%>
	<div class="input-group form-group">
		<div class="input-group-prepend">
		<span class="input-group-text"><i class="fas fa-user"></i></span>
	</div> 
		<input type="text" name="usuario" id="usuario" class="form-control" placeholder="Nombre de Usuario">
						
					</div>
					
	<div class="input-group form-group">
					 	<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-key"></i></span>
						</div> 
						<input type="password" id="contra" name="contra" class="form-control" placeholder="password">
					</div>

	<div class="form-group">
						<input type="submit" value="Login" class="login_btn"><!-- btn float-right  -->
					</div>
	</form>
</div>
</div>
</div>
</div>

</body>
</html>