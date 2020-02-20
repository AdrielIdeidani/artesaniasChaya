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
<link href="Css/PagPrincipal.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</head>
<body>


 <nav class="navbar navbar-default">
        <div class="container-fluid">
          <!-- div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" 
            data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Project name</a>
          </div> -->
         <!--  <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li class="active"><a href="#">Home</a></li>
              <li><a href="#">About</a></li>
              <li><a href="#">Contact</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span 

class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="#">Action</a></li>
                  <li><a href="#">Another action</a></li>
                  <li><a href="#">Something else here</a></li>
                  <li role="separator" class="divider"></li>
                  <li class="dropdown-header">Nav header</li>
                  <li><a href="#">Separated link</a></li>
                  <li><a href="#">One more separated link</a></li>
                </ul>
              </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <li class="active"><a href="./">Default <span class="sr-only">(current)</span></a></li>
              <li><a href="../navbar-static-top/">Static top</a></li>
              <li><a href="../navbar-fixed-top/">Fixed top</a></li>
            </ul>
          </div>/.nav-collapse -->
        </div>
        <!--/.container-fluid -->
      </nav>
<!-- </div></div> -->

<div class="row">
<div class="col-lg-2"><a href="#">Back</a></div>
<!-- <div class="col-lg-auto"><input type="text" class="form-control" style="width:80%"/></div>
 --></div>

<div class="row">
<div class="col-lg-2"> </div>
<!-- <div class="col-lg-10">
  Search Page
</div> -->
</div>


<div id="wrapper">
        <!-- Sidebar -->
        <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li class="sidebar-brand">
                    <a target="iframeprincipal" href="Venta.jsp">
                       Venta
                    </a>
                </li>
                <li>
                    <a  target="iframeprincipal" href="nuevoProd.jsp">Agregar Nuevo Producto</a>
                </li>
                <li>
                    <a href="precios.jsp" target="iframeprincipal">Actualizar Precios </a>
                </li>
                <li>
                    <a target="iframeprincipal" href="stocks.jsp">Ver Stocks</a>
                </li>
                <li>
                    <a target="iframeprincipal" href="ventas.jsp">Resumenes Ventas</a>
                </li>
               
                <li>
                    <a href="modificar.jsp" target="iframeprincipal">Modificar Producto</a>
                </li>
                <li>
                    <a href="proveedores.jsp" target="iframeprincipal">Proveedores</a>
                </li>
                 <li>
                    <a href="database.jsp" target="iframeprincipal" >Acceso DB</a>
                </li>
		

		

            </ul>
        </div>
        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper">
            <div class="container-fluid">
            <iframe name="iframeprincipal" id="iframeprincipal" >
						<p>Este navegador no soparta iframes, intente visitar el sitio con otro navegador.</p>
					</iframe>
              <!--   <h1>Simple Sidebar</h1>
                <p>This template has a responsive menu toggling system. The menu will appear collapsed on smaller screens, and will appear non-collapsed on larger 

screens. When toggled using the button below, the menu will appear/disappear. On small screens, the page content will be pushed off canvas.</p>
                <p>Make sure to keep all page content within the <code>#page-content-wrapper</code>.</p> -->
		<button id="menu-toggle" class="btn btn-secondary"><i id="toggleIcon" class="fa fa-angle-double-down"></i> Toggle Menu <i class="fa fa-

filter"></i></button>                
            </div>
        </div>
        <!-- /#page-content-wrapper -->

    </div>
    <!-- /#wrapper -->
 


  <div class="footer">
    <p>Footer</p>
  </div>
<script>
$("#menu-toggle").click(function(e) {
 e.preventDefault();
	var isIE11 = !!navigator.userAgent.match(/Trident.*rv\:11\./);
	

      



        $("#toggleIcon").toggleClass("fa fa-angle-double-down fa fa-angle-double-up")
        $("#wrapper").toggleClass("toggled");

  	if(isIE11){
          if($("#wrapper").hasClass("toggled")){
	    $('#sidebar-wrapper').css("margin-left", "-268px")
	  } else {
	    $('#sidebar-wrapper').css("margin-left", "-250px")	
          }	 
	}
    });
</script>
</body>
</html>