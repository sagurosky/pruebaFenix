<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>..:: Encuentro Grupal ::..</title>
<style type="text/css">
	label { width: 10em; float: left; }
	label.error { float: none; color: red; padding-left: .5em; vertical-align: top; }
	p { clear: both; }
	.submit { margin-left: 12em; }
	em { font-weight: bold; padding-right: 1em; vertical-align: top; }
</style>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery-ui-1.8.5.custom.min.js"/>"></script>
	<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.ui.datepicker-es.js"/>"></script>
<link rel="stylesheet"
	href="<c:url  value="/static/css/cimientos/jquery-ui-1.8.5.custom.css"/>"	media="all">
<script type="text/javascript" src="<c:url  value="/static/js/jquery.validate.js"/>"></script> 
<script type="text/javascript">
	$(function() {
		$("#grupal").validate();
		$('#fecha').datepicker({
			changeMonth: true,
			changeYear: true,
		 	yearRange:'-1:+1'
		});
	});
</script>
 <script>
 function chequearLongitud(obj){
		if (obj.value.length > 10000) {
		obj.value = obj.value.substring(0, 10000);
		}
	}
 </script>
 <script type="text/javascript">
$(function() {
	 
	$("#escuela").autocomplete({
		source: function(request, response) {
			$.ajax({
				url: "../ajax/buscarEscuelaPorEA.do?idEA=" + $("#idEA").val(),
				dataType: "json",
				data: {
					style: "full",
					maxRows: 12,
					name_startsWith: request.term
				},
				success: function(data) {
					response($.map(data.escuelas, function(item) {
						return {
							label: item.labelEscuelaZona,
							value: item.labelEscuelaZona,
							id: item.id
						}
					}))
				}
			})
		},
		minLength: 2,
		select: function(event, ui) {
			$("#lugarE").val(ui.item.id);
		}
	});



});

</script>
  
 
</head>
<body>
<div id="main-content">

	<h1 id="titulo-informe">Alta Encuentro Grupal</h1>

<form id="grupal" class="cmxform" action="<c:url value='/entrevistas/guardarGrupal.do' />" method="post">
	<table align="left" id="table-informe">
		
		<tr>
			<td>
				<b>Becados:</b>
				<ol>
					<c:forEach items="${alumnos}" var="a">
						<li><b>&nbsp;${a.datosPersonales.nombre}&nbsp;${a.datosPersonales.apellido}</b></li>
					</c:forEach>
				</ol>
			</td>
		</tr>
		<tr>
			<td>
				<b>Otros Participantes:</b><br>
					<input type="checkbox" name="op1" id="op1" value="RA"> RA<br>
					<input type="checkbox" name="op2" id="op2" value="Invitado Externo"> Invitado Externo<br>
					<input type="checkbox" name="op3" id="op3" value="Referentes Escolares"> Referentes Escolares
			</td>
		</tr>	

		<c:if test="${periodo != null}">
			<tr>		
				<td>Periodo Espacio de encuentro Grupal</td>
				<td>
					<b>${periodo.nombre}</b>
				</td>
			</tr>
		</c:if>
		<tr>
			<td>Fecha Realizaci&oacuten</td>
			<td>		
				<input id="fecha" name="fecha" class="date required" value="${fecha}"/>
			</td>
		</tr>
		<tr>
			<td>Lugar Espacio de acompaņamiento</td>
			<td>	
				<input type="text" id="escuela" size="39" class="required" />
				<input type="hidden" class="required" id="lugarE" name="lugarE"></input>
			</td>
		</tr>
		<tr>
			<td>Tipo de encuentro</td>
			<td>
				<select id="tipoEncuento" name="tipoEncuentro">
					<option value="0">Seleccionar</option>
					<option value="Grupal en Escuela">Grupal en Escuela</option>				
					<option value="Visita a Empresa">Visita a Empresa</option>
					<option value="Visita a Universidad">Visita a Universidad</option>
					<option value="Salida recreativa">Salida Recreativa</option>
					<option value="Encuentro Red Egresados">Encuentro Red Egresados</option>
					<option value="Otro">Otro</option>
				</select>
			</td>
		</tr>			
		<tr>
			<td>Objetivo del encuentro y temas desarrollados</td>
			<td>						   
				<textarea rows="4" cols="30" name="objetivo" id="objetivo" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"></textarea>
			</td>
		</tr>
		<tr>
			<td>Temas desarrollados</td>
			<td>						   
				<textarea rows="4" cols="30" name="temas" id="temas" onblur="chequearLongitud(this);"onkeypress="chequearLongitud(this);"></textarea>
			</td>
		</tr>
		<tr>
			<td>Observaciones generales</td>
			<td>						   
				<textarea rows="4" cols="30" name="observaciones" id="observaciones" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"></textarea>
			</td>
		</tr>
		<tr>
			<td align="center">
				<input class="ui-state-default ui-corner-all " type="submit" value="Guardar" />
			</td>
			<td align="left">
				<input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../entrevistas/listarBecados.do'; return false;" />
			</td>
		</tr>
	</table>
	<input type="hidden" id="alumnosSeleccionados" name="alumnosSeleccionados" value="${alumnosSeleccionados}"/>
</form>
<input id="idEA" type="hidden" value="${idEA}"/>
</div>
</body>
</html>