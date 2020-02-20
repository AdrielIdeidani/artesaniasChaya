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
<label for="pedidoLabel">Nro Venta:</label>
<label for="pedidoNro"></label>
</div>
<table class="table table-dark">
  <thead>
    <tr>
      <th scope="col">X</th>
      <th scope="col">Id</th>
      <th scope="col">Nombre</th>
      <th scope="col">Precio</th>
      <th scope="col">Cantidad</th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>

 
    <tr>
    <th scope="row"><input type="button" value="X"></th>
    <th><input type="search" id="idSearch" name="idSearch"></th>
    <th><input type="search" id="nombreSearch" name="nombreSearch"></th>
    
    
  </tbody>
</table>
<div style="float:right">
<button type="button" class="btn btn-dark">
<label id="total" for="total" >Total : $ </label>
<label id="totalValor" for="totalValor">0</label>
Agregar
</button>
</div>
<!-- <label >Total : $</label> style="float:right"
<label id="total" for="total" >0</label> -->

<!-- <input type="submit" value="Agregar" onclick="arrays()"> -->

</body>
</html>