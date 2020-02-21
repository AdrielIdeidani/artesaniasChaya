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
  Busqueda por Id: <input type="search" id="idSearch" name="idSearch">
  Busqueda por Nombre: <input type="search" id="nombreSearch" name="nombreSearch">

<form action="../ProductosServlet" method="post" >
<table class="table table-dark">
  <thead>
    <tr>
      <th scope="col">Id</th>
      <th scope="col">Nombre</th>
      <th scope="col">Precio</th>
      <th scope="col">Cantidad Disponible</th>
      <th scope="col">Modificar</th>
    </tr>
  </thead>
  <tbody>

  </tbody>
</table>
<input type="submit" class="btn btn-primary" id="agregar" value="Actualizar" style="float:right">

</form>
<!-- 
con el buscador ya se de nombre o por el id del producto
que aparezca en una lista
y que pueda decidir si aumentarlo por una cantidad especifica
o que aumente su valor en un porcentaje.
Que en la lista se vaya viendo los productos que cambiarian de valor, cuanto valian, cuanto subirian
y a cuanto quedarian. Que se hagan todas las actualizaciones juntas cuando haga click.


 -->
</body>
</html>