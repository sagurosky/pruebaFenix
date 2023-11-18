<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="softek" uri="/softtek-fwk.tld"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Convocatoria</title>

<style type="text/css">
	input[name=search_browser]{	
		font-size: x-small;
		color: gray;
		font-style: italic; 
	}
	
	table#laTabla{
		 background-color: #C0C2FF;
		 border: 0;
	}
</style>

<script type="text/javascript">
$(function() {
	TableToolsInit.sSwfPath = '<c:url  value="/static/js/table/tabletools/swf/ZeroClipboard.swf"/>'
		
	oTable = $('#laTabla').dataTable( {
		"oLanguage": {
		"sLengthMenu": 'Mostrar <select>'+
		'<option value="25">25</option>'+
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
		"iDisplayLength": 25,
		"sDom": '<"H"Tl>rt<"F"ip>'
	});
	
});
</script>
<script type="text/javascript"
	src="<c:url  value="/static/js/table/funcionesTabla.js"/>"></script>

<script type="text/javascript">
function enviarForm(action, id){
	if(action=='modificar'){
		document.forms['form'].action ="<c:url value='/convocatoria/modificarConvocatoriaView.do'/>";
	}else if(action=='eliminar'){
		document.forms['form'].action ="<c:url value='/convocatoria/eliminarConvocatoria.do'/>";
	}else if(action == 'enviar'){
		document.forms['form'].action ="<c:url value='/convocatoria/altaConvocatoriaView.do'/>";
	}
	document.forms['form'].idConvocatoria.value = id;
	document.forms['form'].submit();
}
</script>
</head>

<body>
<div id="main-content">
<br>
<CENTER>
<table style="margin-left: 50px; margin-right: 50px;">
<tr >
<td style="vertical-align: top">
<div class="ui-state-default ui-corner-all" >
<h3 align="center">Listado de Convocatorias</h3>
</div>
<form method="post"  name="form" id="form">
<input type="hidden" id="idConvocatoria" name="idConvocatoria">
<div class="ui-state-default ui-corner-all" align="center">
	<table align="center">
		<tr>
			<td>
				<sec:authorize access="not hasRole('EA')">	
					<input type="button" value="Alta" class="ui-state-default ui-corner-all"  onclick="enviarForm('enviar','null')" />
				</sec:authorize>
			</td>
		</tr>
	</table>
</div>
<table align="center"  class="dataTables_wrapper" id="laTabla" width="100%" cellspacing="1">

		<thead align="center">
			<!-- Panel de funciones	-->
			<tr id="fxs" style="display: none;">
				<c:forEach begin="0" end="4" var="loop">
					<td>
						<div class="ui-state-default ui-corner-all" style="height: 40px;">
							<div title="subtotalizar columna"> 
								<a href="#ancla" onclick="subtotalizarColumna(${loop})">subtotalizar</a>				
							</div>
							<div title="agrupar columna"> 
								<a href="#" onclick="agruparColumna(${loop})">agrupar</a>				
							</div>
						</div>
					</td>
				</c:forEach>
					<td>
					<div class="ui-state-default ui-corner-all" style="width: auto; height: 40px;">
					</div>
				</td>
			</tr>
			<!-- Botones para mostrar funciones	-->
			<tr>
				<c:forEach begin="0" end="5">
					<td><div class="ui-state-default ui-corner-all" title="mostrar funciones">
						<a onclick="hacerToggle()"><span class="ui-icon ui-icon-triangle-1-s"> 
						</span></a></div>
					</td>
				</c:forEach>
			</tr>
			<!-- Columnas -->
			<tr>
				<th>id</th>
				<th>Nombre Convocatoria</th>
				<th>Zona</th>
				<th>Escuela</th>
				<th>Ciclo Programa</th>
				<th>Fecha Inicio</th>
				<th>Acciones</th>
			</tr>
			<tr>
				<td><input name="search_browser" value="Buscar" class="search_init"/></td>
				<td><input name="search_browser" value="Buscar" class="search_init"/></td>
				<td><input name="search_browser" value="Buscar" class="search_init"/></td>
				<td><input name="search_browser" value="Buscar" class="search_init"/></td>
				<td><input name="search_browser" value="Buscar" class="search_init"/></td>
				<td><input name="search_browser" value="Buscar" class="search_init"/></td>
				<td></td>
			</tr>
		</thead>
		<tbody align="center">
			<c:forEach items="${listaConvocatoria}" var="convocatoria">
				<tr>
					<td align="left" valign="middle" style="font-size: 14px" class="col0">&nbsp;${convocatoria.idConvocatoria}&nbsp;</td>
					<td align="left" valign="middle" style="font-size: 14px" class="col0">&nbsp;${convocatoria.nombre}&nbsp;</td>
					<td align="left" valign="middle" style="font-size: 14px" class="col1">&nbsp;${convocatoria.zonaCimientos.nombre}&nbsp;</td>
					<td align="left" valign="middle" style="font-size: 14px" class="col2">&nbsp;${convocatoria.escuela.nombre}&nbsp;</td>
					<td align="left" valign="middle" style="font-size: 14px" class="col3">&nbsp;${convocatoria.cicloPrograma.nombre}&nbsp;</td>
					<td align="left" valign="middle" style="font-size: 14px" class="col4">&nbsp;<fmt:formatDate value="${convocatoria.fechaInicio}" pattern="dd/MM/yyyy"/>&nbsp;</td>
					<td align="center"  style="border: 0">
						<table>
							<tr>
							<td>
								<div  style= width:0.5cm class="ui-state-default ui-corner-all" > 
									<a  onclick="enviarForm('modificar','${convocatoria.idConvocatoria}')"> 
									<span class="ui-icon ui-icon-pencil" > 
									</span></a>				
								</div>
							</td>
							<!-- 
							<td>
								<div  style= width:0.5cm class="ui-state-default ui-corner-all" > 
									<a  onclick="enviarForm('eliminar','${convocatoria.idConvocatoria}')" > 
									<span class="ui-icon ui-icon-trash" > 
									</span></a>				
								</div>
							</td>
							 -->	
							</tr>
						</table>
					</td>
				</tr>
			</c:forEach>
	</tbody>
</table>
<div class="ui-state-default ui-corner-all" align="center">
	<table align="center">
		<tr>
			<td>
				
				<sec:authorize access="not hasRole('EA')">	
					<input type="button" value="Alta" class="ui-state-default ui-corner-all"  onclick="enviarForm('enviar','null')" />
				</sec:authorize>
			</td>
		</tr>
	</table>
</div>
</form>
</td>
</tr>
</table>
<br><br>
<a name="ancla"></a>
<div id="contenedor" style="width: 60%;">

</div>
</CENTER>	
</div>
</body>
</html>