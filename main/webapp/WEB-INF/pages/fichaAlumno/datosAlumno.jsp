<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Datos Personales</title>
<script type="text/javascript" src="<c:url  value="/static/js/jquery.blockUI.js"/>"></script>
<script type="text/javascript">
$(document).ready(function(){

	$("#tabsDatos").tabs();
	$("button").button();
			
	$("#fechaDeNacimiento").datepicker({
		changeMonth: true,
	 	changeYear: true,
	 	yearRange:'1994:'+ new Date()	
	});

	$("#fechaNacimientoRes").datepicker({
		changeMonth: true,
	 	changeYear: true,
	 	yearRange:'1920:'+ new Date()	
	});	
});


function mostrar(idx){

	var selector;
		switch (idx) {
		case 1:
			selector = "#datosCandidato";
			break
		case 2:
			selector = "#responsable";
			break
		case 3:
			selector = "#escuela";
			break
		case 4:
			selector = "#fichaFamiliar";
		}

		$(selector).toggle("blind");
}

function validarExtension(){
	if(!document.getElementById("foto").value.length==0){
		 var a = document.getElementById("foto").value;
		 a1 = a.indexOf('.JPG');
		 a2 = a.indexOf('.jpg');
		 if ((a1 < 0) && (a2 <0)) {
			 alert("Imagen no v�lida");
			 document.getElementById("foto").value = "";
		 } 
		document.getElementById("foto").focus();
		return false;
	}
}

</script>

</head>
<body>

 
				
<input type="hidden" name="idAlumno" value="${perfilAlumno.id}"></input><br></br>
<input type="hidden" id="urlRegreso" name="urlRegreso" value="${urlRegreso}"></input>
<input type="hidden" id="nroCuentaRA" name="nroCuentaRA" value="${perfilAlumno.responsable1.nroCuenta}"></input>

<div id="accordion" style="width: auto;">
	
	  	<h3  class="ui-accordion-header  ui-state-default ui-corner-all"  align="left" ><a href="#" onclick="mostrar(1)" >Ficha  del Candidato</a></h3>
			<div id="datosCandidato" style="width: auto; height:auto; overflow:scroll;">
			  	<jsp:include page="tabAlumno/datosPersonales.jsp"></jsp:include>
			</div>
			
		<h3  class="ui-accordion-header  ui-state-default ui-corner-all" align="left"  ><a href="#" onclick="mostrar(2)">Ficha  del Resposanble Adulto</a></h3>
			<div id="responsable" style="width: auto; height:auto; overflow:scroll;">	
				<jsp:include page="tabAlumno/responsableAlumno.jsp"></jsp:include>
			</div>

		<h3  class="ui-accordion-header  ui-state-default ui-corner-all" align="left"><a href="#" onclick="mostrar(3)">Escuela</a></h3>
			<div id="escuela" style="width: auto; height:auto; overflow:scroll;">
				<jsp:include page="tabAlumno/escuelaAlumno.jsp" ></jsp:include>
			</div>
			
		<h3  class="ui-accordion-header  ui-state-default ui-corner-all" align="left"><a href="#" onclick="mostrar(4)">Ficha Familiar</a></h3>
			<div id="fichaFamiliar" style="width: auto; height:auto; overflow:scroll;">
				<jsp:include page="tabAlumno/fichaFamiliarAlumno.jsp" ></jsp:include>
			</div>
		
		<h3 class="ui-accordion-header  ui-state-default ui-corner-all"align="left"><a href="#" onclick="mostrar(5)">Evaluaci�n del Candidato</a></h3>
				<div id="observacionesGenerales"style="width: auto; height: auto; overflow: scroll;">
					<jsp:include page="tabAlumno/observacionesGenerales.jsp"></jsp:include>
				</div>	
		
</div>


</body>
</html>