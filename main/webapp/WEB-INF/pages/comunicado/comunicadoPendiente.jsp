<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>
	..:: Comunicado de Renovaci�n Pendiente ::..
</title>
<script type="text/javascript"	src="<c:url value="/static/js/funcionesEntrevista.js"/>"></script>
<style>
	 span{ background-color: yellow; }
</style>
<script type="text/javascript">
$(function() {
	$('#tabla1').dataTable( {
		"sDom": '<"H"l>rt<"F"ip>',
		"oLanguage": {
		"sLengthMenu": 'Mostrar <select>'+
		'<option value="25">25</option>' +
		'<option value="50">50</option>'+
		'<option value="75">75</option>'+
		'<option value="100">100</option>'+
		'<option value="-1">Todos</option>'+
		'</select> registros por hoja',
		"sZeroRecords": "No se encontraron registros",
		"sInfo": "Mostrando del _START_ al _END_ de _TOTAL_ registros",
		"sInfoEmtpy": "Mostrando 0 registros",
		"sInfoFiltered": "(filtrado de _MAX_ registros totales)",
		"sSearch": "Buscar",
		"oPaginate": {
			"sFirst":    "Primera",
			"sPrevious": "Anterior",
			"sNext":     "Siguiente",
			"sLast":     "Ultima"
		}
		
		},
		"bJQueryUI": true,
		"sPaginationType": "full_numbers",
		"iDisplayLength": 25
	});
	});
</script>
</head>
<body>
<div id="main-content">
<form:form modelAttribute="pendiente" id="alta" name="alta" cssClass="cmxform" commandName="pendiente" method="post" action="">
<h1 id="titulo-informe">:: Comunicado Pendiente ::</h1>
	<table border="0" align="left" cellpadding="0" cellspacing="0" id="table-informe">
		<tr>
		<td colspan="2"><h1 id="subtitulo-informe"><label>Datos del Alumno</label></h1></td>
		</tr>
		
		<tr>
		<td width="150">Alumno:</td>
		<td width="600"><label>${pendiente.becado.datosPersonales.nombre},&nbsp;${pendiente.becado.datosPersonales.apellido}</label></td>
		</tr>
		
		
    	<tr>
		<td >Ciclo Lectivo:</td>
		<td ><label>${pendiente.cicloActual.nombre}</label></td>
		</tr>
	
		<tr>
		<td >Zona:</td>
		<td ><label>${pendiente.becado.escuela.localidad.zona.nombre}</label>
		</td>
		</tr>
		
		<tr>
		<td >A�o:</td>
		<td ><label>${pendiente.becado.anioEscolar.valor}</label>
		</td>
		</tr>
		
		<tr>
		<td >Estado de Renovaci�n:</td>
		<td ><label>${pendiente.er.evaluacionRenovacion.valor}</label>
		</td>
		</tr>
		
		<tr>
		<td >Motivo de Pendiente:</td>
		<td ><label>${pendiente.er.motivoPendiente.valor}</label>
		</td>
		</tr>
		
		<c:if test="${!empty pendiente.er.motivoOtro}">
		<tr>
		<td >Motivo de Pendiente:</td>
		<td ><label>${pendiente.er.motivoPendiente.valor}</label>
		</td>
		</tr>
		
		<tr>
		<td >Texto al Padrino:<img src="../static/images/atencion.gif" width=10></td>
		<td ><label>${pendiente.er.mensajePadrino}</label>
		</td>
		</tr>
		</c:if>
		
		<tr>
        	<td>&nbsp;</td>
     	</tr>
    	
       <tr>
        <td colspan="2">
        <table width="800" border="0" align="right" cellpadding="0" cellspacing="0" id="table-botons-small">
          <tr>

		    <td width="50" height="0" align="center" valign="middle"><input type="button" value="Volver" class="ui-state-default ui-corner-all"	
		    	onclick="location.href='../comunicado/listaPendientes.do'; return false;"/></td>
		   </tr>	
	   </table>
	   <input type="hidden" name="idComunicado" ></input>
		</td>
	  </tr>
</table>
</form:form>
</div>
</body>
</html>