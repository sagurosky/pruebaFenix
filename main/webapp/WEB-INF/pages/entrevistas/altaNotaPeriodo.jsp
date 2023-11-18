<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>..:: Registrar Nota ::..</title>

<style type="text/css">
	label { width: 10em; float: left; }
	label.error { float: none; color: red; padding-left: .5em; vertical-align: top; }
	p { clear: both; }
	.submit { margin-left: 12em; }
	em { font-weight: bold; padding-right: 1em; vertical-align: top; }
</style>

<script type="text/javascript" src="<c:url  value="/static/js/jquery.blockUI.js"/>"></script>
<script type="text/javascript">

	function guardarNotas(action,id)
	{

		  var idsPrimerTrimestre = new Array();
		  var idsSegundoTrimestre = new Array();
		  var idsTercerTrimestre = new Array();
		  var idsNotasFinal = new Array();
		  var idsNotasDiciembre = new Array();
		  var idsNotasMarzo = new Array();
		  var idsEstadosMaterias = new Array();
		  
		  var notasPrimerTrimestre = new Array();
		  var notasSegundoTrimestre = new Array();
		  var notasTercerTrimestre = new Array();
		  var notasFinal = new Array();
		  var notasDiciembre = new Array();
		  var notasMarzo = new Array();		  
		  
		  var indice=0;
		  var filasIds = $('#tabla td[name="idsPrimero"]').each(function(){ idsPrimerTrimestre[indice] = $(this).text(); indice++; });
		  indice=0;
		  var filasIds = $('#tabla td[name="idsSegundo"]').each(function(){ idsSegundoTrimestre[indice] = $(this).text(); indice++; });
		  indice=0;
		  var filasIds = $('#tabla td[name="idsTercero"]').each(function(){ idsTercerTrimestre[indice] = $(this).text(); indice++; });
		  var indice=0;
		  var filasIds = $('#tabla td[name="idsFinal"]').each(function(){ idsNotasFinal[indice] = $(this).text(); indice++; });
		  indice=0;
		  var filasIds = $('#tabla td[name="idsDiciembre"]').each(function(){ idsNotasDiciembre[indice] = $(this).text(); indice++; });
		  indice=0;
		  var filasIds = $('#tabla td[name="idsMarzo"]').each(function(){ idsNotasMarzo[indice] = $(this).text(); indice++; });		  
		  indice=0;
		  var filasIds = $('#tabla select[id="idsEstados"]').each(function(){ idsEstadosMaterias[indice] = $(this).val(); indice++; });
		
		  indice=0;
		  var filasNotas = $('#tabla input[name="notasPrimero"]').each(function(){ notasPrimerTrimestre[indice] = $(this).val(); indice++; });
		  indice=0;
		  var filasNotas = $('#tabla input[name="notasSegundo"]').each(function(){ notasSegundoTrimestre[indice] = $(this).val(); indice++; });
		  indice=0;
		  var filasNotas = $('#tabla input[name="notasTercero"]').each(function(){ notasTercerTrimestre[indice] = $(this).val(); indice++; });
		  indice=0;
		  var filasNotas = $('#tabla input[name="notasFinal"]').each(function(){ notasFinal[indice] = $(this).val(); indice++; });
		  indice=0;
		  var filasNotas = $('#tabla input[name="notasDiciembre"]').each(function(){ notasDiciembre[indice] = $(this).val(); indice++; });
		  indice=0;
		  var filasNotas = $('#tabla input[name="notasMarzo"]').each(function(){ notasMarzo[indice] = $(this).val(); indice++; });
		
		if(action = 'ids')
		{
			document.forms['altaNotaPeriodo'].action = "../entrevistas/registrarDatosNotaPeriodo.do";
				
		}
		document.forms['altaNotaPeriodo'].idAlumno.value = id;
		document.forms['altaNotaPeriodo'].idsPrimero.value = idsPrimerTrimestre;
		document.forms['altaNotaPeriodo'].idsSegundo.value = idsSegundoTrimestre;
		document.forms['altaNotaPeriodo'].idsTercero.value = idsTercerTrimestre;
		document.forms['altaNotaPeriodo'].idsFinal.value = idsNotasFinal;
		document.forms['altaNotaPeriodo'].idsDiciembre.value = idsNotasDiciembre;
		document.forms['altaNotaPeriodo'].idsMarzo.value = idsNotasMarzo;
		document.forms['altaNotaPeriodo'].idsEstado.value = idsEstadosMaterias;
		document.forms['altaNotaPeriodo'].notasPrimero.value = notasPrimerTrimestre;		
		document.forms['altaNotaPeriodo'].notasSegundo.value = notasSegundoTrimestre;
		document.forms['altaNotaPeriodo'].notasTercero.value = notasTercerTrimestre;
		document.forms['altaNotaPeriodo'].notasFinal.value = notasFinal;
		document.forms['altaNotaPeriodo'].notasDiciembre.value = notasDiciembre;
		document.forms['altaNotaPeriodo'].notasMarzo.value = notasMarzo;
		$.blockUI();
		document.forms['altaNotaPeriodo'].submit();
	}
</script>
</head>
<body>

<form id="altaNotaPeriodo" action="<c:url value='/entrevistas/registrarDatosNotaPeriodo.do' />" method="post">
<h1 id="titulo-informe-popup">Registro de Notas</h1>
<br></br>
	
			<h1>Materias:</h1>
			<br></br>
		
			<c:if test="${!empty notaMateriasPrimero}">
				
				<table id="tabla">
				<c:forEach var="notaMateria"  items="${notaMateriasPrimero}">
					
					<tr>
						<td ><label>${notaMateria.materia.nombre}</label></td>
						<td name="idsPrimero" style="visibility: hidden;" >${notaMateria.id}</td>
						<c:if test="${notaMateria.id != 1842}">		
						<td >
				        	<select id="calificacion" name="notasPrimero">
								<c:forEach var="calif" items="${calificaciones}">
									
										<c:if test="${calif.id == notaMateria.calificacion.id}">
											<option selected="selected" value="${calif.id}">${calif.valor}</option>
										</c:if>
										<c:if test="${calif.id != notaMateria.calificacion.id}">
											<option value="${calif.id}">${calif.valor}</option>
										</c:if>					
									
								</c:forEach>
							</select>						
						</td>
						</c:if>
					</tr>
					
				</c:forEach>
				</table>
				
			</c:if>
			<c:if test="${!empty notaMateriasSegundo}">
				<table id="tabla">
				<c:forEach var="notaMateria" items="${notaMateriasSegundo}">
				
					<tr>
						<td ><label>${notaMateria.materia.nombre}</label></td>
						<td name="idsSegundo" style="visibility: hidden;" >${notaMateria.id}</td>
						<td >				        	
						<select id="calificacion" name="notasSegundo">
								<c:forEach var="calif" items="${calificaciones}">
									<c:if test="${calif.id == notaMateria.calificacion.id}">
										<option selected="selected" value="${calif.id}">${calif.valor}</option>
									</c:if>
									<c:if test="${calif.id != notaMateria.calificacion.id}">
										<option value="${calif.id}">${calif.valor}</option>
									</c:if>					
								</c:forEach>
							</select>
						</td>
						<td></td>
					</tr>				
				</c:forEach>
				</table>
			</c:if>
			<c:if test="${!empty notaMateriasTercero}">
				<table id="tabla">
				<c:forEach var="notaMateria" items="${notaMateriasTercero}">
					<tr>
						<td ><label>${notaMateria.materia.nombre}</label></td>
						<td name="idsTercero" style="visibility: hidden;" >${notaMateria.id}</td>
						<td >				        	
						<select id="calificacion" name="notasTercero">
								<c:forEach var="calif" items="${calificaciones}">
									<c:if test="${calif.id == notaMateria.calificacion.id}">
										<option selected="selected" value="${calif.id}">${calif.valor}</option>
									</c:if>
									<c:if test="${calif.id != notaMateria.calificacion.id}">
										<option value="${calif.id}">${calif.valor}</option>
									</c:if>					
								</c:forEach>
							</select>
						</td>
					</tr>				
				</c:forEach>
				</table>
			</c:if>
			<c:if test="${!empty notaMateriasFinal}">
				
				<table id="tabla">
				<c:forEach var="notaMateria"  items="${notaMateriasFinal}">
					<tr>
						<td ><label>${notaMateria.materia.nombre}</label></td>
						<td name="idsFinal" style="visibility: hidden;" >${notaMateria.id}</td>
						<td >				        	
						<select id="calificacion" name="notasFinal">
								<c:forEach var="calif" items="${calificaciones}">
									<c:if test="${calif.id == notaMateria.calificacion.id}">
										<option selected="selected" value="${calif.id}">${calif.valor}</option>
									</c:if>
									<c:if test="${calif.id != notaMateria.calificacion.id}">
										<option value="${calif.id}">${calif.valor}</option>
									</c:if>					
								</c:forEach>
							</select>
						</td>
					</tr>
				</c:forEach>
				</table>
				
			</c:if>			
			<c:if test="${!empty notaMateriasDiciembre}">
				
				<table id="tabla">
				<c:forEach var="notaMateria" varStatus="row" items="${notaMateriasDiciembre}">
					<tr>
						<td ><label>${notaMateria.materia.nombre}</label></td>
						<td name="idsDiciembre" style="visibility: hidden;" >${notaMateria.id}</td>
						<td>
						<c:if test="${notasNoAprueba.materias[row.index].noAprueba}">
							<select id="calificacion" name="notasDiciembre" style="width: 100px;">
								<c:forEach var="calif" items="${calificaciones}">
									<c:if test="${calif.id == notaMateria.calificacion.id}">
										<option selected="selected" value="${calif.id}">${calif.valor}</option>
									</c:if>
									<c:if test="${calif.id != notaMateria.calificacion.id}">
										<option value="${calif.id}">${calif.valor}</option>
									</c:if>					
								</c:forEach>
							</select>							
						</c:if>
						<c:if test="${!notasNoAprueba.materias[row.index].noAprueba}">
						<input type="hidden" id="calificacion" value="15" name="notasDiciembre" />
							<select disabled="disabled" style="width: 100px;">
								<option selected="selected" value=""></option>
							</select>		
						</c:if>
						</td>
					</tr>
				</c:forEach>
				</table>
				
			</c:if>		
			<c:if test="${!empty notaMateriasMarzo}">
				
				<table id="tabla">
				<c:forEach var="notaMateria" varStatus="row"  items="${notaMateriasMarzo}">
					<tr>
						<td ><label>${notaMateria.materia.nombre}</label></td>
						<td name="idsMarzo" style="visibility: hidden;" >${notaMateria.id}</td>
						<td >	
						<c:if test="${notasNoAprueba.materias[row.index].noAprueba}">
							<select id="calificacion" name="notasMarzo" style="width: 100px;">
								<c:forEach var="calif" items="${calificaciones}">
									<c:if test="${calif.id == notaMateria.calificacion.id}">
										<option selected="selected" value="${calif.id}">${calif.valor}</option>
									</c:if>
									<c:if test="${calif.id != notaMateria.calificacion.id}">
										<option value="${calif.id}">${calif.valor}</option>
									</c:if>					
								</c:forEach>
							</select>						
						</c:if>
						<c:if test="${!notasNoAprueba.materias[row.index].noAprueba}">
						<input type="hidden" id="calificacion" value="15" name="notasMarzo" />
							<select disabled="disabled" style="width: 100px;">
								<option selected="selected" value=""></option>
							</select>		
						</c:if>						
						</td>
					</tr>
				</c:forEach>
				</table>
				
			</c:if>							
	 
        <table width="200" border="0" align="left" cellpadding="0" cellspacing="0" id="table-botons-small">
          <tr>
            <td width="50" height="0" align="center" valign="middle">
            	<input class="ui-state-default ui-corner-all " type="button" onclick="guardarNotas('ids', '${alumno.id}');"  value="Guardar" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
			<td width="50" align="center" valign="middle">
				<input type="button" value="Cancelar" class="ui-state-default ui-corner-all" 
		       onclick="location.href='../entrevistas/modificarBoletinView.do?idAlumno=${alumno.id}'; return false;" />
		     </td>
            <td width="292"  align="center" valign="middle">&nbsp;</td>
			<td>
				<input type="hidden" name="idAlumno" value="${alumno.id}"/>
				<input type="hidden" name="idsPrimero" value="${idsPrimerTrimestre}"/>
				<input type="hidden" name="idsSegundo" value="${idsSegundoTrimestre}"/>
				<input type="hidden" name="idsTercero" value="${idsTercerTrimestre}"/>
				<input type="hidden" name="idsFinal" value="${idsNotasFinal}"/>
				<input type="hidden" name="idsDiciembre" value="${idsNotasDiciembre}"/>
				<input type="hidden" name="idsMarzo" value="${idsNotasMarzo}"/>				
				<input type="hidden" name="idsEstado" value="${idsEstados}"/>
				<input type="hidden" name="notasPrimero" value="${notasPrimerTrimestre}"/>
				<input type="hidden" name="notasSegundo" value="${notasSegundoTrimestre}"/>
				<input type="hidden" name="notasTercero" value="${notasTercerTrimestre}"/>
				<input type="hidden" name="notasFinal" value="${notasFinal}"/>
				<input type="hidden" name="notasDiciembre" value="${notasDiciembre}"/>
				<input type="hidden" name="notasMarzo" value="${notasMarzo}"/>				
		    </td>
		</tr>
		</table>      	
		
</form>

</body>
</html>