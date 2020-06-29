<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="entities.Producto" %>
<%@ page import="database.CategoriaData" %>
<%@ page import="database.EmpresaData" %>
<%@ page import="database.ProductosData" %>

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
</head>
<body>
<div>
		<form action="../ProductosServlet" method="post" >
			<%
			CategoriaData pd= new CategoriaData();
			ArrayList<String> list = pd.getAll(session.getAttribute("usuario").toString()
					,session.getAttribute("contra").toString()); 
			
			
			EmpresaData ed= new EmpresaData();
			ArrayList<String> listEmp = ed.getAll(session.getAttribute("usuario").toString()
					,session.getAttribute("contra").toString()); 
			
		String idProducto = request.getParameter("idProducto");
		    if (idProducto!=null){
		    	ProductosData pd2= new ProductosData();
		    	HttpSession miSesion= request.getSession(false);
		    	ArrayList<Producto> pro = pd2.getAll(session.getAttribute("usuario").toString()
						,session.getAttribute("contra").toString());
		    Producto prod=null;	
		    for (Producto p:pro){
		    	if(p.getId().equals(idProducto)){

		    		prod=p;
		    		break;
		    	}

		    	}
		    ArrayList<String> listCategoriaExcept = pd.getAllExceptOne(session.getAttribute("usuario").toString()
					,session.getAttribute("contra").toString(), prod.getCategoria());
		    ArrayList<String> listEmpresaExcept =ed.getAllExceptOne(session.getAttribute("usuario").toString()
					,session.getAttribute("contra").toString(), prod.getEmpresa());
		    
		    %>

<h4 class="small" >Para actualizar el precio ir a la seccion correspondiente</h4>
<br>

<label for="Categoría">Categoría</label>
<select id="categoria" name="categoria">
<option value="<%=prod.getCategoria() %>"><%=prod.getCategoria() %></option>
<% for(int i =0;i<listCategoriaExcept.size();i++){
	%>
	<option value="<%=listCategoriaExcept.get(i) %>"><%=listCategoriaExcept.get(i) %></option>
	
	
<% }%>
<option value="-1">Nueva Categoría</option>

</select>     
<label for="Empresa">Empresa</label>
<select id="empresa" name="empresa">
<option value="<%=prod.getEmpresa()%>"><%=prod.getEmpresa() %></option>
<% for(int i =0;i<listEmpresaExcept.size();i++){
	%>
	<option value="<%=listEmpresaExcept.get(i) %>"><%=listEmpresaExcept.get(i) %></option>
	
	
<% }%>
<option value="-1">Nueva Empresa</option>
</select>
<h5 class="small">Id</h5>
<input type="text" id="id" name="id" class="form-control" placeholder="Id" value=<%= prod.getId().replace(prod.getCategoria(), "") %>>
<h5 class="small">Nombre</h5>
<input type="text" id="nombre" name="nombre" class="form-control" placeholder="Nombre" value=<%=prod.getNombre() %>>

<input type="hidden" id="auction" name="auction" value="modificar">
<input type="hidden" id="aux" name="aux" value= <%=prod.getId() %>>
<input type="submit" class="btn btn-primary" id="Actualizar" value="Actualizar" style="float:right">

<%} else {%>

	
<label for="Categoría">Categoría</label>
<select id="categoria" name="categoria">
<option value="0">----</option>
<% for(int i =0;i<list.size();i++){
	%>
	<option value="<%=list.get(i) %>"><%=list.get(i) %></option>
	
	
<% }%>
<option value="-1">Nueva Categoria</option>

</select>     
<label for="Empresa">Empresa</label>
<select id="empresa" name="empresa">
<option value="0">----</option>
<% for(int i =0;i<listEmp.size();i++){
	%>
	<option value="<%=listEmp.get(i) %>"><%=listEmp.get(i) %></option>
	
	
<% }%>
<option value="-1">Nueva Empresa</option>
</select>


<input type="text" id="id" name="id" class="form-control" placeholder="Id" >
<br>
<input type="text" id="nombre" name="nombre" class="form-control" placeholder="Nombre" >
<br>
<input type="text" id="precio" name="precio" class="form-control" placeholder="Precio" >
<br>

<input type="hidden" id="auction" name="auction" value="agregar">
<input type="submit" class="btn btn-primary" id="agregar" value="Agregar" style="float:right">

<br>
<%} %>



</form>


<a href="listaProd.jsp"><button type="button" class="btn btn-secondary" id="volver" style="float:left">Volver</button>
</a>

</div>

</body>
</html>