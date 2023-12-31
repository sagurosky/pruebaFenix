<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="<c:url value="/static/css/demos.css"/>" media="all" />
<title>Registrar Datos Personales</title>

<script type="text/javascript" src="<c:url  value="/static/js/jquery.validate.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/validador.js"/>"></script>

<style type="text/css">
	label { width: 10em; float: left; }
	label.error { float: none; color: red; padding-left: .5em; vertical-align: top; }
	p { clear: both; }
	.submit { margin-left: 12em; }
	em { font-weight: bold; padding-right: 1em; vertical-align: top; }
</style>

<script>

//DMS codigo original
// $(document).ready(function(){
// 	$("#registraPersona").validate();
//     $("#fechaNacimiento").datepicker({
//   		changeMonth: true,
//   		changeYear: true
// 	});
// });


$(document).ready(function(){
	//$("#registraPersona").validate(); DMS 15/9/22 reemplazo validate por valid de la funcion enviar (daba error)
    $("#fechaNacimiento").datepicker({
  		changeMonth: true, 
  		changeYear: true
	});
});


//DMS 15/9/22 antes de hacer un submit doy vuelta el valor de la fecha para que el validador
//funcione bien, luego lo normalizo para que llegue bien al controlador

function enviar(){
	
	voltearFecha();
	 
	 
	  if($("#registraPersona").valid()){
			voltearFecha();
			document.getElementById("registraPersona").submit(); 
		}else voltearFecha();
}

function voltearFecha(){
	  var fecha=$("#fechaNacimiento").val();
	  fecha=fecha.toString();
	  var dia=fecha.slice(0,2);
	  var mes=fecha.slice(3,5);
	  var anio=fecha.slice(6,10);
	  var barra=fecha.slice(2,3);
	fecha=mes+barra+dia+barra+anio;  
	document.getElementById("fechaNacimiento").value=fecha;
	console.log(fecha);
}




</script>
<script type="text/javascript">
function cerrar(cerrar,cuil){
	if(window.opener != null){
		if(cerrar != null && cerrar){
			window.opener.document.getElementById("cuit_cuil").value = cuil;
			window.close();
		}
	}
}	
</script>
<script>
	function verificarCuil(){
		if($("#SexoM").attr("checked")){
			generarCuil("true");
		}
		if($("#SexoF").attr("checked")){
			generarCuil("false");
		}
	}

	var digito;
	function generarCuil(valueRadio){
		var cuil;//Esto se tieenq que cargar con el cuil generado
		var xy;
		value = $('#dni').val();
		if(value.length > 0){ //Se ingres� al menos un digito del dni
			if(valueRadio == "true")
			{ //Masculino			
				cuil = value;
				xy = 20;
				cuil = calcular( xy, cuil);
			}
			else
			{
				if(valueRadio == "false")
				{						//fememino
					cuil = value;
					xy = 27;
					cuil = calcular( xy, cuil );
				}			
			}
		}
		else{
			$('#nuevoCuil').val(" "); // No se ingres� al menos un numero de dni por lo que no se puede calcular el cuil
		}
			
		if(isNaN( digito ) ){
			$('#nuevoCuil').val(" ");
		}
		else{
			$('#nuevoCuil').val(cuil);
		}
					
	}
	
	function formatear(xy, cuil, digito) {
		return (xy + "-" + cuil + "-" + digito);		
		
		}
	
	function validar () {
		var error = false; /* No se detecto error hasta el momento, no se vio que falten datos */
		var faltantes = "Faltan: ";

		if (document.getElementById("dni").value == ""){
			error = true;
			faltantes += " N� de Documento \n";
			}
		
		if (error == true) {			/* Si hay error es porque entre en algun if, entonces muestro con alert lo que falta y devuelvo false para que no funcione el submit del formulario */
				alert (faltantes);
				return false;			/* El submit del formulario no funciona porque tiene un return validar() <-- y return false hace que no submitee que es lo que pasa en este caso */
			} else {
					return true;
				}
	}

</script>

</head>
<body onload="cerrar(${cerrarPopup},${cuil});">

<form id="registraPersona" class="cmxform" action="<c:url value='/perfilPadrino/registrarPersonaPadrino.do' />" method="post">

<div id="main-content">
<br></br>
<br></br>
<h1>Carga de Datos Personales</h1>

    <table width="120" border="0" align="left" cellpadding="0" cellspacing="0" id="table-forms">
		<tr>
			<td><strong><label for="nombre">Nombre    (*):</label></strong></td>
			<td><input type="text" name="nombre" id="nombre" class="text-input required" /></td>
		</tr>
		<tr>
			<td><strong><label for="apellido">Apellido    (*):</label></strong></td>
			<td><input type="text" name="apellido" id="apellido" class="text-input required" /></td>
		</tr>
		<tr>
			<td><strong><label for="dni">DNI    (*):</label></strong></td>
			<td><input type="text" name="dni" id="dni" class="digits text-input required" 
					maxlength="8" onblur="verificarCuil()" onkeyup="verificarCuil()" value="${dni}"/></td>
		</tr>
		<tr>
			<td><label for="direccion">Direcci�n:</label></td>
			<td><input type="text" name="direccion" id="direccion" class="text-input" /></td>
		</tr>
		<tr>
			<td><label for="codigoPostal">C&oacute;digo Postal:</label></td>
			<td><input type="text" name="codigoPostal" id="codigoPostal" class="text-input" /></td>
		</tr>
		<tr>
			<td><label for="telefono">Tel�fono:</label></td>
			<td><input type="text" name="telefono" id="telefono" class="text-input" /></td>
		</tr>
		<tr>
			<td><label for="celular">Celular:</label></td>
			<td><input type="text" name="celular" id="celular" class="text-input" /></td>
		</tr>
		<tr>
			<td><label for="fechaNacimiento">Fecha de Nacimiento:</label></td>
			<td><input name="fechaNacimiento" id="fechaNacimiento" class="text-input date" /> dd/mm/aaaa<br></td>
		</tr>
		<tr>
			<td><label for="sexo">Sexo:</label></td>
			<td>
				M<input type="radio" id="SexoM" name="sexo"  onclick="generarCuil(this.value)" value="true" class="required"> 
				F<input type="radio" id="SexoF" name="sexo"  onclick="generarCuil(this.value)" value="false" class="required">
			</td>
		</tr>
		<tr>
			<td width="100"><strong><label>Cuil (*):</label></strong></td>
			<td width="600">
				<input type="text" name="cuil" id="nuevoCuil"  readonly="readonly" class="required text-input" value="${cuil}" >
			</td>
		</tr>
		<tr>
			<td><label for="mail">Mail:</label></td>
			<td><input type="text" name="mail" id="mail" class="text-input" /></td>
		</tr>
		<tr>
			<td colspan="2">
				<label style="width:980px;font-size:10px;"><b>Recuerda que las direcciones de mail deben separarse con punto y coma (;)</b></label>
			</td>
		</tr>
		<tr>
	        <td>&nbsp;</td>
	        <td>&nbsp;</td>
      	</tr>
      	<tr>
	        <td>&nbsp;</td>
	        <td>&nbsp;</td>
      	</tr>
      	<tr>
	        <td colspan="2">
		        <table width="550" border="0" align="left" cellpadding="0" cellspacing="0" id="table-botons-small">
		          <tr>
		      		<td width="330" height="0" align="left" valign="middle"><input class="ui-state-default ui-corner-all " type="submit" value="Registrar" /></td>		
				  </tr>		
				</table> 
			</td>
		</tr>
	</table>
	</div>
	<input type="hidden" name="popup" value="${popup}"/>
</form>

</body>
</html>