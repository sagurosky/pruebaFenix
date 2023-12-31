<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
    <%@ taglib uri="http://displaytag.sf.net" prefix="display" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery-ui-1.8.5.custom.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/table/jquery.dataTables.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.ui.datepicker-es.js"/>"></script>
<link rel="stylesheet"
	href="<c:url  value="/static/css/cimientos/jquery-ui-1.8.5.custom.css"/>"	media="all">

<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.validate.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/static/css/displaytags.css"/>" media="all">

<style type="text/css">
table#exportacion{  
	background-color: #C0C2FF;
	border: 0;
	}
select {
	width: 148px;
}	
</style>
    
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listado de Candidatos</title>

<style type="text/css">
table#exportacion{  
	background-color: #C0C2FF;
	border: 0;
	}
	
</style>

<script type="text/javascript">

function popupListTS(idAlumno){
	$( "#dialog-confirm" ).dialog({
		resizable: false,
		height:160,
		width:550,
		modal: true,
		buttons: {
			"Asignar TS ": function() {
				//$( this ).dialog( "close" );
				
				enviarTS(idAlumno);
				$( this ).dialog( "close" );
			},
			"Cancelar": function() {
				$( this ).dialog( "close" );
			}
		}
	});
}	
function enviarTS(idAlumno){
	var select = document.getElementById("perfilTSSelect");
	var index = select.selectedIndex;
	var value = select.options[index].value;
	$('#idPerfilTS').val(value);
	enviarForm('asignarTS',idAlumno,'null');
	
}

$(function() {
	$("#convocatoria").autocomplete({
		source: function(request, response) {
			$.ajax({
				url: "../ajax/buscarConvocatoriaPorZonaYNombre.do?idZona=" + $("#zonaCimientosId").val(),
				dataType: "json",
				data: {
					style: "full",
					maxRows: 12,
					name_startsWith: request.term
				},
				success: function(data) {
					response($.map(data.json, function(item) {
						return {
							label: item.nombre,
							value: item.nombre,
							id: item.id,
							ea: item.nombre
						}
					}))
				}
			})
		},
		minLength: 2,
		select: function(event, ui) {
			$("#idConvocatoria").val(ui.item.id);
			$("#convocatoria").text(ui.item.nombre);
		}
	});
});
$(function() {

	$("#zonaCimientos").keypress(function(){
		$("#zonaCimientosId").val(0);
		$("#zonaCimientos").autocomplete({
			source: function(request, response) {
				$.ajax({
					url: "../ajax/buscarZonaPorNombre.do",
					dataType: "json",
					data: {
						style: "full",
						name_startsWith: request.term				
					},
					success: function(data) {
						response($.map(data.zonas, function(item) {
							return {
								label: item.nombre,
								value: item.nombre,
								id: item.id
							}
						}))
					}
				})
			},
			select: function(event, ui) {
				$("#zonaCimientosId").val(ui.item.id);
				$("#convocatoria").removeAttr('disabled');
				$("#escuela").removeAttr('disabled');
			}
		});
	});

});
$(function() {
	$("#escuela").autocomplete({
		source: function(request, response) {
			$.ajax({
				url: "../ajax/buscarEscuelaSeleccionNombre.do",
				dataType: "json",
				data: {
					style: "full",
					maxResults: 12,
					name_startsWith: request.term,
					idZona:$("#zonaCimientosId").val()
				},
				success: function(data) {
					response($.map(data.escuelas, function(item) {
						return {
							label: item.nombre , 
							value: item.nombre,
							id:item.id
							
						}
					}))
				}
			})
		},
		select: function(event, ui) {
			$("#idEscuela").val(ui.item.id);
		}
	});
});
$(function() {
	$("#ts").autocomplete({
		source: function(request, response) {
			$.ajax({
				url: "../ajax/buscarPerfilTSNombre.do",
				dataType: "json",
				data: {
					style: "full",
					maxResults: 12,
					name_startsWith: request.term
					
				},
				success: function(data) {
					response($.map(data.perfilTSs, function(item) {
						return {
							label: item.nombre , 
							value: item.nombre,
							id:item.id
							
						}
					}))
				}
			})
		},
		select: function(event, ui) {
			$("#idTS").val(ui.item.id);
		}
	});
});

</script>


	
<script type="text/javascript">
function validarFiltros(){
	if($('#convocatoria').val() == ''){
		$('#idConvocatoria').removeAttr('value');
	}
	if($('#alumno').val() == ''){
		$('#alumno').removeAttr('value');
	}
	if($('#escuela').val() == ''){
		$('#idEscuela').removeAttr('value');
	}
	if($('#zonaCimientos').val() == ''){
		$('#zonaCimientosId').removeAttr('value');
	}
	if($('#ts').val() == ''){
		$('#idTS').removeAttr('value');
	}
	document.forms['reporteForm'].submit();
	
}
function enviarForm(action, id, valor){
	$('#reporteForm').removeAttr('action');
	document.forms['reporteForm'].idConvocado.value = id;
	if(action == 'asignarTS'){
		document.forms['reporteForm'].action ="<c:url value='guardarPerfilTSAlumno.do'/>";
	}else{
		document.forms['reporteForm'].action ="<c:url value='/convocado/modificarConvocado.do'/>";
	}
	document.forms['reporteForm'].idValor.value = valor;
	document.forms['reporteForm'].submit();
}
function popupRechazo(idAlumno){
	var select = document.getElementById("motivoRechazoSelect");
	var index = select.selectedIndex;
	var valor = select.options[index].value;
	$("#idMotivoRechazo").val(valor);
	$( "#dialog-confirmRechazar" ).dialog({
		resizable: false,
		height:160,
		width:550,
		modal: true,
		buttons: {
			"Enviar ": function() {
				enviarForm('null',idAlumno,'12');
				
			},
			"Cancelar": function() {
				$( this ).dialog( "close" );
			}
		}
	});
	
}
function habilitarInput(){
	if($('#zonaCimientos').val() != ''){
		$("#convocatoria").removeAttr('disabled');
		$("#escuela").removeAttr('disabled');
	}
}			
</script>





</head>
<body onload="habilitarInput()">
<div class="ui-state-highlight ui-corner-all"
		style="margin-top: 10px; padding: 0 .7em; width: auto; font: normal; font-size: 13px; vertical-align: middle; height: 20px; display: none"
		id="mens" >
	<p><span class="ui-icon ui-icon-info"
		style="float: left; margin-right: .3em;"> </span> <span id="mensValue"></span></p>
</div>
<div id="main-content">
<br></br>
<center><h3>Listado de Candidatos</h3></center>
<br></br>






<form:form modelAttribute="convocado" commandName="convocado" name="reporteForm" id="reporteForm" method="post" action="listadoDeConvocados.do" >
<input type="hidden" name="idConvocado" id="idConvocado">
<input type="hidden" name="idValor" id="idValor">
<input type="hidden" name="idMotivoRechazo" id="idMotivoRechazo" >
<input type="hidden" name="idPerfilTS" id="idPerfilTS" >
<center>
	<fieldset style="font-size: 12px; margin-left: 60px; margin-right: 50px; width:980px;">
		<legend>Filtros de b&uacute;squeda</legend>
			<table id="table-informe" align="center" style="margin-left: 100px; margin-right: 60px; border-style:hidden;" width="600px">
					<tr align="center">
						<td align="left" style="font-size: 13px; font-weight: bold">Ciclos:</td>
						<td align="left">
							<select name="idCiclo" id="ciclo"  >
								<option value="0">Todos</option>
								<c:forEach items="${listaCiclos}" var="ciclo1">
									<c:choose>
										<c:when test="${ciclo.id == ciclo1.id}">
											<option value="${ciclo1.id}" selected="selected">${ciclo1.nombre}</option>
										</c:when>
										<c:otherwise>
											<option value="${ciclo1.id}" >${ciclo1.nombre}</option>
										</c:otherwise>
									</c:choose>
					
								</c:forEach>
							</select>
						
						</td>
						<td align="left" style="font-size: 13px; font-weight: bold">Zona Cimientos:</td>
						<td align="left">
				    		<input type="hidden" name="idZonaCimientos" id="zonaCimientosId" value="${zonaCimientos.id}" />
							<input type="text" id="zonaCimientos" value="${zonaCimientos.nombre}"  />
						</td>
					</tr>
				 	<tr align="center">
						<td align="left" style="font-size: 13px; font-weight: bold">Escuela:</td>
						<td align="left">
								<input type="hidden" name="idEscuela" 	id="idEscuela" value="${escuela.id}"/>
								<input id="escuela" type="text" name="escuela" disabled="disabled" value="${escuela.nombre}" disabled="disabled"/>
						</td>
						<td align="left" style="font-size: 13px; font-weight: bold">Convocatoria:</td>
						<td align="left">
							<input type="hidden" name="idConvocatoria" id="idConvocatoria" value="${convocatoria.idConvocatoria}" />
							<input type="text" id="convocatoria" disabled="disabled" value="${convocatoria.nombre}" />
						
						</td>
					</tr>
					<tr align="center">
						<td align="left" style="font-size: 13px; font-weight: bold">Candidato:</td>
						<td align="left">
								<input id="alumno" type="text" name="nombreAlumno" value="${nombreAlumno}" />
						</td>
						<td align="left" style="font-size: 13px; font-weight: bold">Estado: </td>
						<td align="left">
							<select 	name="idEstadoAlumno" id="estados"  >
								<option value="0">Todos</option>
								<c:forEach items="${listEstadoAlumnos}" var="estado1">
									<c:choose>
										<c:when test="${estado.id == estado1.id}">
											<option value="${estado.id}" selected="selected">${estado1.valor}</option>
										</c:when>
										<c:otherwise>
											<option value="${estado1.id}" >${estado1.valor}</option>
										</c:otherwise>
									</c:choose>
					
								</c:forEach>
							</select>
						
						</td>
						</tr>
						<tr align="center">
							<td align="left" style="font-size: 13px; font-weight: bold">TS Designado:</td>
							<td align="left">
								<input type="hidden" name="idTS" id="idTS" value="${perfilTS.idPerfilTS}" />
								<input type="text" id="ts" value="${perfilTS.datosPersonales.apellidoNombre}" />
							
							</td>
							<td align="left" style="font-size: 13px; font-weight: bold">Motivo de Visita: </td>
							<td align="left">
								<select 	name="idMotivoVisita" id="idMotivoVisita"  >
									<option value="0">Todos</option>
									<c:forEach items="${listMotivoVisita}" var="motivoVisita1">
										<c:choose>
											<c:when test="${motivoVisita.id == motivoVisita1.id}">
												<option value="${motivoVisita.id}" selected="selected">${motivoVisita.valor}</option>
											</c:when>
											<c:otherwise>
												<option value="${motivoVisita1.id}" >${motivoVisita1.valor}</option>
											</c:otherwise>
										</c:choose>
						
									</c:forEach>
								</select>
							
							</td>
							</tr>
							<tr align="center">
								<td align="left" style="font-size: 13px; font-weight: bold">Recomendaci&oacute;n TS: </td>
								<td align="left">
									<select name="idRecomendacionTS" id="idRecomendacionTS"  >
										<option value="0">Todos</option>
										<c:forEach items="${listRecomendacionTS}" var="recomendacionTS1">
											<c:choose>
												<c:when test="${recomendacionTS.id == recomendacionTS1.id}">
													<option value="${recomendacionTS.id}" selected="selected">${recomendacionTS.valor}</option>
												</c:when>
												<c:otherwise>
													<option value="${recomendacionTS1.id}" >${recomendacionTS1.valor}</option>
												</c:otherwise>
											</c:choose>
							
										</c:forEach>
									</select>								
								</td>
								<td align="left" style="font-size: 13px; font-weight: bold">A�o Escolar:</td>
								<td align="left">
									<select name="idAnioEscolar" id="aniosEscolares"  >
										<option value="0">Todos</option>
										<c:forEach items="${listAniosEscolares}" var="anio1">
											<c:choose>
												<c:when test="${anio.id == anio1.id}">
													<option value="${anio.id}" selected="selected">${anio1.valor}</option>
												</c:when>
												<c:otherwise>
													<option value="${anio1.id}" >${anio1.valor}</option>
												</c:otherwise>
											</c:choose>					
										</c:forEach>
									</select>							
								</td>
							</tr>
							<tr>
								<td align="left" style="font-size: 13px; font-weight: bold">EAE:</td>
									<td align="left">
										<select name="eae" id="eae" style="width:150px;">
										<c:choose>
											<c:when test="${eae == '6/6'}">
												<option value="todos">Todos</option>
												<option value="6/6" selected="selected">6/6</option>
												<option value="7/5">7/5</option>
											</c:when>
											<c:when test="${eae == '7/5'}">
												<option value="todos">Todos</option>
												<option value="6/6">6/6</option>
												<option value="7/5" selected="selected">7/5</option>
											</c:when>
											<c:otherwise>
												<option value="todos" selected="selected">Todos</option>
												<option value="6/6">6/6</option>
												<option value="7/5">7/5</option>
											</c:otherwise>
										</c:choose>
										</select>						
									</td>	
							</tr>
					<tr align="center">
						<td colspan="5">
							<input align="middle" id="buscar" type="button" onclick="validarFiltros()" value="Buscar" class="ui-state-default ui-corner-all" ></input>
						</td>
					</tr>
			</table>
	</fieldset>
</center>
<br><br>
<CENTER style="width: 1100px;">
<display:table name="convocados"  class="displayTags_wrapper" id="dto"  export="true" style="font-size: 12px; margin-left: 50px; margin-right: 50px;width:1000px; background-color: #C0C2FF;"  pagesize="50" defaultsort="50" defaultorder="ascending" requestURI="" >
	<c:set var="urlRegreso" value="/convocado/listadoDeConvocados.do"></c:set>
	<display:column property="nombreCiclo" title="Ciclo" ></display:column>
	<display:column property="nombreZona" title="Zona" ></display:column>
	<display:column property="nombreEscuela" title="Escuela" ></display:column>
	<display:column  title="A�o Adicional" media="excel">
		<c:if test="${dto.anioAdicional}">
			Si
		</c:if>
		<c:if test="${!dto.anioAdicional}">
			No
		</c:if>	
	</display:column>
	<display:column property="anioEscolar.valor" title="A�o Escolar" ></display:column>
	<display:column  title="EAE" style="width: 25%">
		${dto.eae}
	</display:column>
	<display:column  title="Candidato" media="excel">${dto.nombreAlumno}</display:column>
	<display:column  title="Candidato" style="width: 25%"  media="html">
		${dto.nombreAlumno}
			<div style="width:0.5cm" class="ui-state-default ui-corner-all" title="Detalle Alumno">
				<a  href="<c:url value='/fichaAlumno/fichaAlumnoView.do?idAlumno=${dto.idAlumno}&urlRegreso=${urlRegreso}'/>"> 
					<span class="ui-icon ui-icon-search" ></span>
				</a>		
			</div>
	</display:column>
	<display:column property="dni" title="Dni" ></display:column>
	<display:column property="estadoAlumno.valor" style="width: 15%" title="Estado" ></display:column>
	<display:column property="estadoAlumnoEntrevista.valor"   title="Estado Entrevista Selecci�n" ></display:column>
	<display:column property="nombreConvocatoria" title="�ltima Convocatoria" ></display:column>
	<display:column property="apellidoNombreTS" title="TS Designado" ></display:column>
	<display:column property="motivoEnvioTS.valor" title="Motivo env�o Visita" ></display:column>
	<display:column property="recomendacionesTS.valor" title="Recomendaci�n TS" ></display:column>
	<display:column  title="Acciones" media="html">
		<table cellspacing="0" cellpadding="0">
			<tr>
				<c:if test="${dto.estadoAlumno.id == 4}">
<!--				Lista de Espera																						-->
						<td align="left">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td style="font-size: 8px;">					
											<input type="button" value="L.E Mat" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 13) " />									 								
											<input type="button" value="Rech" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 12) " />									 								
											<input type="button" value="Apr" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 2) " />									 								
									</td>	
								</tr>
							</table>
						</td>
															
				</c:if>														
				<c:if test="${dto.estadoAlumno.id == 13}">
<!--				Lista de Espera con Materias																					-->
						<td align="left">
							<table border="0" width="195px" cellpadding="0" cellspacing="0">
								<tr>
									<td style="font-size: 8px;">					
										<input type="button" value="L.E" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 4 ) " />									 								
										<input type="button" value="Rech" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 12 )" />									 								
										<input type="button" value="Apr" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 2 ) " />
									</td>
								</tr>		
							</table>
						</td>	
				</c:if>
				<c:if test="${dto.estadoAlumno.id == 12 }">
<!--			Rechazado																																		-->
					<td align="left">
							<table border="0" width="195px" cellpadding="0" cellspacing="0">
								<tr>
									<td style="font-size: 8px;">					
										<input type="button" value="L.E" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 4 )" />									 								
										<input type="button" value="L.E Mat" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 13 ) " />									 								
										<input type="button" value="Apr" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 2 ) " />									 								
									</td>
								</tr>
							</table>
					</td>		
				</c:if>	
				<c:if test="${dto.estadoAlumno.id == 18}">
<!--			A TS o Preseleccionado																					-->
					<td align="left">
							<table border="0" width="195px" cellpadding="0" cellspacing="0">
								<tr>
									<td style="font-size: 8px;">					
										<input type="button" value="L.E" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 4 ) " />									 								
										<input type="button" value="L.E Mat" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 13 ) " />
									<c:choose>
										<c:when test="${dto.motivoEnvioTS.valor != null && dto.recomendacionesTS.valor == null}">	
										<input type="button" value="TS" class="ui-state-default ui-corner-all" onclick="popupListTS('${dto.idAlumno}')" />
										</c:when>
										<c:when test="${dto.recomendacionesTS.valor == null}">
											<input type="button" value="Rech" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 12 ) " />									 								
										</c:when>
										<c:otherwise>
											<input type="button" value="Rech" class="ui-state-default ui-corner-all" onclick="popupRechazo('${dto.idAlumno}') " />
										</c:otherwise>
									</c:choose>
										<input type="button" value="Apr" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 2 ) " />									 								
									</td>
								</tr>
							</table>
					</td>
				</c:if>
				<c:if test="${dto.estadoAlumno.id == 2}">
					<td align="left">
						<table border="0" width="195px" cellpadding="0" cellspacing="0" >
							<tr>
								<td style="font-size: 8px;">					
										<input type="button" value="L.E" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 4 ) " />									 								
										<input type="button" value="L.E Mat" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 13 ) " />									 								
										<input type="button" value="Rech" class="ui-state-default ui-corner-all" onclick="enviarForm('null','${dto.idAlumno}', 12 ) " />							 								
								</td>																													
							</tr>
						</table>
					</td>
				</c:if>																																																																		
			</tr>
		</table>
		
		
	</display:column>
	
	<display:setProperty name="basic.empty.showtable" value="true" />  
    <display:setProperty name="paging.banner.group_size" value="35" />  
    <display:setProperty name="paging.banner.item_name" value="candidatos" />  
    <display:setProperty name="paging.banner.item_names" value="candidatos" />  
    <display:setProperty name="paging.banner.onepage" value=" " />
	<display:setProperty name="export.excel.filename" value="candidatos.xls" /> 
    	
</display:table>
</center>	
	<div id="dialog-confirm" title="Asignar TS" style="display: none">
		<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 10px 45px 0;"></span>
		<span>Debe seleccionar un Trabajador Social para la asignaci&oacute;n al Candidato </span>
		<select id="perfilTSSelect">
			<c:forEach items="${listPerfilTS}" var="perfilTS" varStatus="loop">
				
				
				<option value="${perfilTS.idPerfilTS}" <c:if test="${loop.index == 0 }">selected="selected"</c:if>><span>${perfilTS.datosPersonales.apellidoNombre} </span></option>
			</c:forEach>	
		</select> 
		</p>
	</div>
	<div id="dialog-confirmRechazar" title="Rechazar Alumno" style="display: none">
		<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 10px 45px 0;"></span>
		<table>
			<tr>
				<td>
					<span>Selecci&oacute;n motivo Rechazo  </span>
				</td>
			</tr>
			<tr>
				<td>
					<select id="motivoRechazoSelect">
						<c:forEach items="${listaMotivoRechazo}" var="motivoRechazo">
							<option value="${motivoRechazo.id }">${motivoRechazo.valor}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		</p>
	</div>
	
</form:form>
</div>
</body>
</html>