<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib uri="http://displaytag.sf.net" prefix="display" %> 
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"   %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="<c:url value="/static/js/jquery.effects.core.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/jquery.ui.position.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/jquery.ui.widget.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/jquery.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/jquery-ui-1.8.5.custom.min.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/static/css/cimientos/jquery-ui-1.8.5.custom.css"/>" media="all">
<script src="<c:url value="/static/js/jquery.alerts.js" />" type="text/javascript" ></script>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="<c:url value="/static/css/displaytags.css"/>" media="all">
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.alerts.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/validador.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery-ui-1.8.5.custom.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.dataTables.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.ui.datepicker-es.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.validate.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.ui.tabs.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.ui.draggable.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.effects.core.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.ui.position.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.ui.widget.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.ui.accordion.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/table/jquery.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/table/jquery.dataTables.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/table/ColVis.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/table/tabletools/js/TableTools.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/table/tabletools/ZeroClipboard/ZeroClipboard.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/table/tabletools/js/TableTools.min.js"/>"></script>
<link rel="stylesheet"
	href="<c:url  value="/static/css/styles.css"/>" media="all">
<link rel="stylesheet"
	href="<c:url  value="/static/css/table.css"/>"	media="all">
<link rel="stylesheet"
	href="<c:url  value="/static/css/jquery.ui.accordion.css"/>"	media="all">
<link rel="stylesheet"
	href="<c:url  value="/static/css/cimientos/jquery-ui-1.8.5.custom.css"/>" media="all">
<link rel="stylesheet"
	href="<c:url  value="/static/css/blitzer/jquery-ui-1.8.5.custom.css"/>"	media="all">
<link rel="stylesheet"
	href="<c:url  value="/static/css/ui-lightness/jquery-ui-1.8.5.custom.css"/>" media="all">
<link rel="stylesheet"
	href="<c:url  value="/static/css/ui-lightness/jquery.alerts.css"/>"	media="all">
<link rel="stylesheet"
	href="<c:url  value="/static/js/table/tabletools/css/TableTools.css"/>"	media="all">
	


</head>
<style type="text/css">
table#exportacion{  
	background-color: #C0C2FF;
	border: 0;
	}
	
</style>
<script type="text/javascript">

$(function() {
	$("#padrino").autocomplete({
		source: function(request, response) {
			$.ajax({
				url: "../ajax/buscarPadrinosPorNombre.do",
				dataType: "json",
				data: {
					style: "full",
					maxRows: 15,
					name_startsWith: request.term
				},
				success: function(data) {
					response($.map(data.padrinos, function(item) {
						return {
							label: item.nombre,
							value: item.nombre,
							id: item.id
						}
					}))
				}
			})
		},
		minLength: 2,
		select: function(event, ui) {
			$("#idPadrino").val(ui.item.id);
		},
		open: function() {
			$(this).removeClass("ui-corner-all").addClass("ui-corner-top");
		},
		close: function() {
			$(this).removeClass("ui-corner-top").addClass("ui-corner-all");
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
			}
		});
	});

});
	
/**
 * Este metodo busca por ajax y arma un select filtrando por zona
 *@parameter: IdZona
 *@paramter url
 *@parameter IdSelect(id del combo para armar)
 * NOTA:El objeto Json devuelto tiene que tener por nombre json y 
 */	
function buscarDatosAjaxCombo(idZona,url,idSelect){
	$.ajax({
		url: url+"?idZona="+idZona,
		dataType: "json",
		data: {
			style: "full"
		},
		success:
			function(data) {
			$('#removerOption').remove();
		//	document.formEx.idSelect.options.length = 0;
				for(var i= 0 ; i < data.json.length ; i++){
					//Este metodo es que el popula el combo de eas 
					populateCombos(data.json[i].id,data.json[i].nombre,idSelect);
				}
			
			}
	});
}
/**
 * Este metodo arma los combos 
 */
function populateCombos(id,nombre,idSelect){
	
	var option =document.createElement('option');
	option.id="removerOption";
	option.text=nombre;
	option.value=id;
	var select=document.getElementById(idSelect);
	try
	  {
	  	select.add(option,null); 
	  }
	catch(ex)
	  {
	  	select.add(option); 
	  }
}

$(function() {
	$("#ea").autocomplete({
		source: function(request, response) {
			$.ajax({
				url: "../ajax/buscarEAPorNombre.do" ,
				dataType: "json",
				data: {
					style: "full",
					maxRows: 12,
					name_startsWith: request.term
				},
				success: function(data) {
					response($.map(data.eas, function(item) {
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
			$("#idEa").val(ui.item.id);
			$("#ea").text(ui.item.nombre);
		}
	});
});

function validarFiltros(ea){
	
	if($('#zonaCimientos').val() == ''){
		$('#zonaCimientosId').removeAttr('value');
	}
	if($('#padrino').val() == ''){
		$('#idPadrino').removeAttr('value');
	}
	
	if(ea != '')
		document.forms['formEx'].action = "../reporteBecadosAB/reporteBecadosABPaginadoViewEa.do";
	else
		document.forms['formEx'].action = "../reporteBecadosAB/reporteBecadosPaginadoABViewRr.do";	
	document.forms['formEx'].submit();
	
}

function disbledInput(){
	if($('#zonaCimientos').val() == ''){
		$('#zonaCimientosId').removeAttr('value');
	}
}

function enviarForm(action, id){
	
	if(action=='verEscuela'){
			document.forms['formEx'].action ="<c:url value='/escuela/modificarEscuela.do'/>";
			document.forms['formEx'].idEscuela.value = id;
	}
	document.forms['formEx'].submit();
}
</script>

<body>
<br><br>
<center>
	<h3 align="center">Listado de Becados 
		<c:if test="${!empty ea}">
			del EA: ${ea.datosPersonales.apellido}, ${ea.datosPersonales.nombre}
		</c:if>
		<c:if test="${!empty rr}">
			del RR: ${rr.datosPersonales.apellido},  ${rr.datosPersonales.nombre}
		</c:if>
	</h3>
</center>
<br><br>
<form method="post" name="formEx" id="formEx" action="<c:url value='/reporteBecadosAB/reporteBecadosABPaginadoViewEa.do'/>">
<fieldset style="font-size: 12px; margin-left: 60px; margin-right: 50px; width:980px;">


<table id="table-informe" align="center" style="margin-left: 100px; margin-right: 60px; border-style:hidden;" width="600px">
	 	<tr align="center">
	 		<td align="left" style="font-size: 13px; font-weight: bold">Alumno:</td>
			<td align="left">
				<input id="alumno" width="150px;" type="text" name="nombreAlumno" value="${nombreAlumno}" />
			</td>
			<td align="left" style="font-size: 13px; font-weight: bold">Estado Alumno:</td>
			<td align="left">
				<select name="idEstadoAlumno" id="estados"  >
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
			<td align="left" style="font-size: 13px; font-weight: bold">A�o Adicional:</td>
			<td align="left">
				<select name="anioAdicional" id="anioAdicional">
					<option value="Todos">Todos</option>
					<c:forEach items="${listAdicional}" var="adicional1">
						<c:choose>
							<c:when test="${adicional == adicional1}">
								<option value="${adicional}" selected="selected">${adicional1}</option>
							</c:when>
							<c:otherwise>
								<option value="${adicional1}" >${adicional1}</option>
							</c:otherwise>
						</c:choose>					
					</c:forEach>
				</select>			
			</td>
		</tr>			
		<tr align="center">
			<td align="left" style="font-size: 13px; font-weight: bold">Zona Cimientos:</td>
			<td align="left">
	    			<input type="hidden" name="idZonaCimientos" id="zonaCimientosId" value="${zonaCimientos.id}" />
					<input type="text" id="zonaCimientos" value="${zonaCimientos.nombre}" onchange="disbledInput()" />					
			</td>
			<td align="left" style="font-size: 13px; font-weight: bold">Padrino:</td>
			<td align="left">
				<input type="hidden" name="idPadrino" id="idPadrino" value="${padrino.id}" />
				<c:choose>
					<c:when test="${padrino.datosPersonales != null}">
						<input type="text" id="padrino" value="${padrino.datosPersonales.apellido},${padrino.datosPersonales.nombre}" />
					</c:when>
					<c:when test="${padrino.empresa != null}">
						<input type="text" id="padrino" value="${padrino.empresa.denominacion}" />
					</c:when>
					<c:otherwise>
						<input type="text" id="padrino" value="${padrino.datosPersonales.nombre}" />
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<c:if test="${empty ea}">
			<tr align="center">
				</td>
				<td align="left" style="font-size: 13px; font-weight: bold">EA:</td>
				<td align="left">
					<input type="hidden" name="idEa" id="idEa" value="${idEa}" />
					<input type="text" id="ea" name="ea" value="${nombreEa}" />
				</td>
			</tr>
		</c:if>	
		<tr align="center">
			<td colspan="4">
				<input align="middle" id="buscar" type="button" onclick="validarFiltros('${ea}')" value="Buscar" class="ui-state-default ui-corner-all" ></input>
			</td>
		</tr>
</table>
</fieldset>
<br><br>
<CENTER style="width: 1100px;">
<display:table name="alumnos" export="true" class="displayTags_wrapper" id="dto"  style="font-size: 12px; margin-left: 50px; margin-right: 50px;width:1000px; background-color: #C0C2FF;"  pagesize="50" defaultsort="50" defaultorder="ascending" requestURI="" >
	<c:choose>
		<c:when test="${!empty rr && empty ea}">
			<c:set var="urlRegreso" value="/reporteBecadosAB/reporteBecadosPaginadoABViewRr.do"></c:set>
			<display:column sortable="true" sortProperty="datosPersonales.apellido" headerClass="sortable" title="EA" >${dto.nombreEa}</display:column>
		</c:when>
		<c:otherwise>
			<c:set var="urlRegreso" value="/reporteBecadosAB/reporteBecadosABPaginadoViewEa.do"></c:set>
		</c:otherwise>	
	</c:choose>	
	<display:column property="nombreZona" sortable="true" sortProperty="localidad.zona" headerClass="sortable" title="Zona" ></display:column>
	<display:column title="Alumno" media="excel">${dto.nombreAlumno}</display:column>
	<display:column  sortable="true" sortProperty="persona.apellido"  headerClass="sortable" title="Alumno" media="html">
		${dto.nombreAlumno}
		<div style="width:0.5cm" class="ui-state-default ui-corner-all" title="Detalle Alumno">
			<a  href="<c:url value='/fichaAlumno/fichaAlumnoView.do?idAlumno=${dto.id}&urlRegreso=${urlRegreso}'/>"> 
				<span class="ui-icon ui-icon-search" ></span>
			</a>		
		</div>
	</display:column>	
	<display:column property="tipoDni.valor" title="Tipo de Dni" ></display:column>
	<display:column property="dni" sortable="true" sortProperty="persona.dni"  headerClass="sortable" title="N� de Documento" ></display:column>
	<display:column sortable="true" sortProperty="fechaPBE"  headerClass="sortable" title="Fecha de Incorporaci�n al PFE">
		<fmt:formatDate pattern="dd/MM/yyyy" value="${dto.fechaPBE}" ></fmt:formatDate>
	</display:column>
	<display:column title="Estado Alumno" >
		<c:if test="${dto.estadoAlumno.id == 20 || dto.estadoAlumno.id == 22}">
			${dto.estadoRenovacion.valor}
		</c:if>
		<c:if test="${dto.estadoAlumno.id != 20 && dto.estadoAlumno.id != 22}">
			${dto.estadoAlumno.valor}
		</c:if>	
	</display:column>
	<display:column sortable="true" sortProperty="escuela.nombre"  headerClass="sortable" title="Escuela" media="excel">
		${dto.nombreEscuela}
	</display:column>	
	<display:column sortable="true" sortProperty="escuela.nombre"  headerClass="sortable" title="Escuela" media="html">
		${dto.nombreEscuela}
		<!-- >div style= width:0.5cm class="ui-state-default ui-corner-all" > 
			<a onclick="enviarForm('verEscuela','${dto.idEscuela}')"> 
				<span class="ui-icon ui-icon-search" title="Ver Ficha Escuela"></span>
			</a>				
		</div-->		
	</display:column>
	<display:column property="anioEscolar.valor" title="A�o Escolar" ></display:column>
	<display:column title="A�o Adicional" >
		<c:if test="${dto.anioAdicional}">
			Si
		</c:if>
		<c:if test="${!dto.anioAdicional}">
			No
		</c:if>	
	</display:column>
	<display:column property="nombrePadrino" title="Padrino" ></display:column>
					
	<display:setProperty name="basic.empty.showtable" value="true" />  
    <display:setProperty name="paging.banner.group_size" value="35" />  
    <display:setProperty name="paging.banner.item_name" value="alumnos" />  
    <display:setProperty name="paging.banner.item_names" value="alumnos" />  
    <display:setProperty name="paging.banner.onepage" value=" " />
    <display:setProperty name="export.excel.filename" value="alumnos.xls" />    	
   
</display:table>
</CENTER>
<input type="hidden" name="idEscuela" id="idEscuela">
<input type="hidden" name="urlRegreso" value="${urlRegreso}"></input>
</form>
</body>
</html>