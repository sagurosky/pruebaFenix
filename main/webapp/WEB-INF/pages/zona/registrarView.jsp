<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>..:: Registrar Zona Cimientos ::..</title>

<script src="<c:url value="/static/js/jquery.alerts.js" />" type="text/javascript" ></script>

<style type="text/css">
	label { width: 10em; float: left; }
	label.error { float: none; color: red; padding-left: .5em; vertical-align: top; }
	p { clear: both; }
	.submit { margin-left: 12em; }
	em { font-weight: bold; padding-right: 1em; vertical-align: top; }
</style>
 
<script>
$(document).ready(function(){
	$("#altaZona").validate();
	
	$("#agregarLocalidad").click(function () {
		incrementarCounter();
		var selectVinculo ='<tr id="fila'+ counter +'"><td><select name="localidades" class="required select">'+
						   '<c:forEach var="localidad" items="${localidades}"><option value="${localidad.id}">${localidad.nombre}</option></c:forEach>'+
						   '</select></td></tr>';
		
		$('#tablaLocalidades').append(selectVinculo);
		
	});
	
	$("#eliminarLocalidad").click(function () {
		if(counter > 1){
			$("#fila" + counter).remove();
			counter--;
		}else{
			jAlert('warning',"Debe haber al menos 1 localidad", 'Atenci�n!');
		}
	});
	
	$("#registrar").click(function () {
		var localidades = $(".select");
		var hayRepetidos = false;
		if(localidades.length != 0){
			for(i = 0; i < localidades.length; i++){
				for(j = 0; j < localidades.length; j++){
					if((localidades[i].value == localidades [j].value) && (i != j)){
						hayRepetidos = true;
					}
				}
			}
			if(hayRepetidos){
				jAlert('warning',"Usted ha ingresado localidades repetidas", 'Atenci�n!');
			}else{
				$("#altaZona").submit();
			}
		}else{
			jAlert('warning',"Agregue al menos 1 localidad", 'Atenci�n!');
		}
	});
	
});

var counter = 1;

function incrementarCounter(){
	counter++;
}

</script>

</head>
<body>
<div id="main-content">
<form id="altaZona" class="cmxform" action="<c:url value='/zona/registrar.do' />" method="post">
<fieldset>
	<legend>Alta de Zona Cimientos</legend>
    <table width="120" border="0" align="left" cellpadding="0" cellspacing="0" id="table-forms">
						
		<tr>
		<td width="150">Nombre *</td>
		<td width="600"><input name="nombre" id="nombre" type="text" class="required"/></td>
		</tr> 
		<tr>
			<td>Categor&iacute;as</td>
			<td>
			<select name="categoria" style="width: 140px;">
				<c:forEach var="cat" items="${categorias}">
					<option selected="selected" value="${cat.id}">${cat.valor}</option>
				</c:forEach>
			</select>
			</td>
		</tr>
		<tr>
			<td>EAE</td>
			<td>
			<select name="eae" style="width: 140px;">
				<option value="6/6">6/6</option>
  				<option value="7/5">7/5</option>
			</select>
			</td>
		</tr>
		<tr>
	        <td>&nbsp;</td>
	        <td>&nbsp;</td>
      	</tr>
		<tr>
			<td valign="top">Localidades</td>
			<td>
				<table id="tablaLocalidades">
					<tr id="fila1">
						<td>
							<select name="localidades" class="required select">
								<c:forEach var="localidad" items="${localidades}">
									<option value="${localidad.id}">${localidad.nombre}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
	  		<td colspan="2" height="25px;">&nbsp;</td>
	  	</tr>
	 	<tr>
	    	<td colspan="2"><input type="button" id="agregarLocalidad" value="Agregar" class="ui-state-default ui-corner-all">
	    	<input type="button" id="eliminarLocalidad" value="Eliminar" class="ui-state-default ui-corner-all"></td>
	  	</tr>
	  	<tr>
	  		<td colspan="2">&nbsp;</td>
	  	</tr>
      	<tr>
        	<td colspan="2">
		        <table width="800" border="0" align="right" cellpadding="0" cellspacing="0" id="table-botons-small">
		        	<tr>
						<td width="50" height="0" align="center" valign="middle"><input class="ui-state-default ui-corner-all " type="button" id="registrar" value="Registrar" /></td>
						<td width="50" align="center" valign="middle"><input type="button" value="Cancelar" class="ui-state-default ui-corner-all" 
					       onclick="location.href='../zona/listaZonas.do'; return false;" /></td>
			            <td width="292" height="30" align="center" valign="middle">&nbsp;</td>
					</tr>		
				</table> 
			</td>
		</tr>
	</table>
	<br></br>
</fieldset>
</form>
</div>
</body>
</html>