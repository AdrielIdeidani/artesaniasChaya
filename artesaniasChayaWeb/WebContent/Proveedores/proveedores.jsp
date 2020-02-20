<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="database.ProveedoresData" %>
<%@ page import="entities.Proveedor" %>

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
<link href="Css/PageInPanel.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</head>
<body>
<a href="agregarProv.jsp"><button type="submit"  id="btnModificar" name="modificar">A�adir</button></a>

<table class="table table-dark">

  <thead>
    <tr>
      <th scope="col">Cuit</th>
      <th scope="col">Razon Social</th>
      <th scope="col">Telefono</th>
      <th scope="col">Direccion</th>
      <th scope="col">Email</th>
      <th scope="col">Modificar</th>
      
    </tr>
  </thead>
  <tbody>
	<%
	ProveedoresData pd= new ProveedoresData();
	ArrayList<Proveedor> list = pd.getAll(session.getAttribute("usuario").toString()
			,session.getAttribute("contra").toString()); 
	for(Proveedor l: list){%>
		<tr>
			<td><%= l.getCuit() %></td>
			<td><%= l.getRazonSocial() %></td>
			<td><%= l.getTelefono() %></td>
			<td><%= l.getDireccion() %></td>
			<td><%= l.getEmail()%></td>
			<td><a href="agregarProv.jsp"><button type="submit"  id="btnModificar" class="btnClass" value="<%=Integer.toString(l.getCuit())%>" name="modificar">Modificar</button></a></td>

		</tr>
	
	<%} %>


    
  </tbody>
</table>
</body>
</html>