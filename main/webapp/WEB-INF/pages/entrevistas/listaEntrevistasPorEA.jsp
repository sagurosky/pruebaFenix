<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Espacio de acompaņamiento</title>

<script type="text/javascript">
$(function() {
	$('#tablaEntrevistas').dataTable( {
		"oLanguage": {
		"sLengthMenu": 'Mostrar <select>'+
		'<option value="50>50</option>'+
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
<center>
	<h1>
		Lista de Entrevistas Por EA
	</h1>
</center>
<br>
<center><h1>${ea.datosPersonales.nombre}&nbsp;${ea.datosPersonales.apellido}</h1></center>
<br>
<CENTER>
<table align="center" >
<tr align="center">
<td style="vertical-align: middle;" align="center">
	<table class="dataTables_wrapper" width="630px" border="0" id="tablaEntrevistas"> 

		<thead align="center">
			<tr>
				<th>Alumno</th>
				<th>Periodo </th>
				<th>Tipo </th>
				<th>Estado </th>
				<th>Fecha Carga</th>
				<th>Acciones</th>
			</tr>
		</thead>
		<tbody align="center">
			<c:forEach items="${entrevistas}" var="e">
				<tr>
					<td align="center" valign="middle" style="font-size: 14px">&nbsp;${e.perfilAlumno.datosPersonales.apellido},${e.perfilAlumno.datosPersonales.nombre}</td>
					<td align="center" valign="middle" style="font-size: 14px">&nbsp;${e.periodoDePago.nombre}&nbsp;</td>
					<td align="center" valign="middle" style="font-size: 14px">&nbsp;${e.tipoEntrevista.valor}&nbsp;</td>
					<td align="center" valign="middle" style="font-size: 14px">&nbsp;${e.estadoEntrevista.valor}&nbsp;</td>
					<td align="center" valign="middle" style="font-size: 14px"><fmt:formatDate value="${e.fechaCarga}" pattern="dd/MM/yyyy"/>&nbsp;</td>
					<td>
						<div  style= width:0.5cm class="ui-state-default ui-corner-all" > 
							<a  onclick="location.href='../entrevistas/verEntrevistasView.do?entrevistaId=${e.id}&tipoEntrevistaId=${e.tipoEntrevista.id}&retorno=rr'; return false;"> 
							<span class="ui-icon ui-icon-zoomin" title="Ver Entrevista"> 
							</span></a>				
						</div>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
<br />

<br />
<table align="center">
	<tr>
		<c:if test="${retorno == 'cpbe'}">
			<td>
				<input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../entrevistas/listarTodosEas.do'; return false;" />
			</td>
		</c:if>
		<c:if test="${retorno != 'cpbe'}">
			<td>
				<input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../entrevistas/listarEas.do'; return false;" />
			</td>
		</c:if>
	</tr>
</table>

</td>
</tr>
</table>
</CENTER>	
</div>
</body>
</html>