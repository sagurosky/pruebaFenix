<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>..:: Registrar Escuelas Candidatas ::..</title>

<script type="text/javascript" src="<c:url  value="/static/js/jquery.js"/>"></script>
<script type="text/javascript" src="<c:url  value="/static/js/jquery.validate.js"/>"></script>
<script type="text/javascript" src="<c:url  value="/static/js/jquery-ui-1.8.5.custom.min.js"/>"></script>


<script type="text/javascript">
function chequearLongitud(obj,cant){
	if (obj.value.length > cant) {
		obj.value = obj.value.substring(0, cant);
	}
}

$(function() {
	$("#nombreLocalidad").keypress(function(){

		$("#localidadId").val("");
		$("#zonaCimientos").val("");
		$("#idZonaCimientos").val("");
		$("#nombreProvincia").val("");
		$("#provinciaId").val("");

		$("#nombreLocalidad").autocomplete({
			source: function(request, response) {
				$.ajax({
					url: "../ajax/buscarLocalidadPorNombre.do",
					dataType: "json",
					data: {
						style: "full",
						name_startsWith: request.term,
						maxRows:40
					},
					success: function(data) {
						response($.map(data.localidades, function(item) {
							return {
								label: item.nombre + ", " + item.nombreZona ,
								value: item.nombre,
								id: item.id,
								zonaCimientos: item.nombreZona,								
								idZonaCimientos: item.idZona,
								provincia: item.nombreProvincia,
								idProvincia: item.idProvincia
								
							}
						}))
					}
				})
			},
			select: function(event, ui) {
				$("#localidadId").val(ui.item.id);				
				$("#zonaCimientos").val(ui.item.zonaCimientos);
				$("#idZonaCimientos").val(ui.item.idZonaCimientos);
				$("#nombreProvincia").val(ui.item.provincia);
				$("#provinciaId").val(ui.item.idProvincia);
			}
		});
	});
});

$(function() {
	$("#nombre").keypress(function(){
	
		$("#idEscuela").val("");
	
	$("#nombre").autocomplete({
	
		source: function(request, response) {
			$.ajax({
				url: "../ajax/buscarEscuelaSeleccionNombre.do",
				dataType: "json",
				data: {
					style: "full",
					maxResults: 12,
					name_startsWith: request.term,
					idZona:$("#idZonaCimientos").val()
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
});	



$(document).ready(function(){
 	$("#altaEscuela").validate();
 });
function validarLocalidad()
{
	if ($("#nombreLocalidad").val() == '')
	{
	   	document.getElementById("seccion1").style.display="inline";
	}
	else
	{
	   	document.getElementById("seccion1").style.display="none";
	} 
}

function limpiarLocalidad(){
	$("#nombreLocalidad").val('');
	$("#localidadId").val('');
}

function chequearLocalidad(){
	if(document.getElementById("localidadId").value == ''){
		$("#nombreLocalidad").val('');
		$("#localidadId").val('');	
	}
}
function enviarForm(action){
	if(action=='alta'){
		document.forms['altaEscuela'].action ="<c:url value='/escuela/altaEscuela.do'/>";
	}
	else if(action=='volverEscuela'){
		eliminarAtributoRequired();
		document.forms['altaEscuela'].action ="<c:url value='/escuela/listaEscuelas.do'/>";
		document.forms['altaEscuela'].submit();
		return;
	}

	$('#altaEscuela').submit();
	
		
}
function eliminarAtributoRequired(){
	$('#nombre').removeClass("required");
	$('#modalidad').removeClass("required");
	$('#nivelAtiendeEscuela').removeClass("required");
	$('#cantidadDeAnios').removeClass("required");
	$('#dependencia').removeClass("required");
	$('#codigoPostal').removeClass("required");
	$('#direccionCalle').removeClass("required");
	$('#direccionNumero').removeClass("required");
	$('#nombreLocalidad').removeClass("required");
	$('#zonaCimientos').removeClass("required");
	$('#rural').removeClass("required");
	$('#subsidioEstatal').removeClass("required");
	$('#estadoEscuela').removeClass("required");
	$('#programa').removeClass("required");
}
function cambiarMotivos(){
	if(document.getElementById('idEstadoEscuela').value == 3){
		$("#motivoNoSeleccion").removeAttr("disabled");
	}else{
		$("#motivoNoSeleccion").val("");
		$("#motivoNoSeleccion").attr("disabled","disabled");
	}
}

function habilitarCampos(){
	if((document.getElementById("modalidadTrabajoEscuela").value == 4) 
			|| (document.getElementById("modalidadTrabajoEscuela").value == 5)){
		document.getElementById("comProy").disabled = false;
		document.getElementById("fase").disabled = false;
	}
	else{
		document.getElementById("comProy").disabled = true;
		document.getElementById("fase").disabled = true;
		document.getElementById("fase").value = '';
	}

	habilitarObj();
	
	if(document.getElementById("modalidadTrabajoEscuela").value != 1 && document.getElementById("modalidadTrabajoEscuela").value != ''){
		document.getElementById("matricula").disabled = false;
		document.getElementById("comPBE").disabled = false;
		document.getElementById("indicadorRepitencia").disabled = false;
		document.getElementById("indicadorAbandono").disabled = false;
		document.getElementById("porcentajeInasistencia").disabled = false;
	}
	else{
		document.getElementById("matricula").disabled = true;
		document.getElementById("comPBE").disabled = true;
		document.getElementById("indicadorRepitencia").disabled = true;
		document.getElementById("indicadorAbandono").disabled = true;
		document.getElementById("porcentajeInasistencia").disabled = true;
	}
}

function habilitarObj(){
	if(document.getElementById("fase").value == 2){
		document.getElementById("objetivoProyecto").disabled = false;
	}
	else{
		document.getElementById("objetivoProyecto").disabled = true;
		document.getElementById("objetivoProyecto").value = '';
	}
}

function validarIndicador(obj){
	if(obj.value > 100){
		obj.value = 0;
		alert("El valor debe ser entre 0 y 100");
	}
}

</script>

<script>
function verificarEscuela(){
	var xx = $("#idEscuela").val().length;
	
	if (xx>0){
		alert("Ya existe la Escuela que quer�s dar de alta, por favor verificalo");
		$("#nombre").val("");
		$("#idEscuela").val("");
		document.getElementById("nombre").focus();
	}
	
}

</script>
<style type="text/css">
	label { width: 12em; float: left; }
	label.error { float: none; color: red; padding-left: .5em; vertical-align: middle; }
	p { clear: both; }
	.submit { margin-left: 12em; }
	em { font-weight: bold; padding-right: 1em; vertical-align: top; }
</style>

</head>
<body onload="habilitarCampos()">
<div id="main-content">

<form:form id="altaEscuela" action="registrarEscuela.do" method="post" commandName="escuela" name="altaEscuela">
<form:hidden path="id"/>
<c:set var="urlRegreso" value="${urlRegreso}"></c:set>
    <fieldset style="width:600px;">
		<legend>Datos formales:</legend>
		<table>
			</br>
			<tr>
				<td><label>Localidad *</label></td>
				<td>					 
					 <c:choose>
						<c:when test="${escuela.localidad != null}">
							<input type="text" id="nombreLocalidad" value="${escuela.localidad.nombre}"  class="required"  onclick="limpiarLocalidad()" onblur="chequearLocalidad()" >
							<input type="hidden" name="localidad.id" id="localidadId" value="${escuela.localidad.id}"/>
						</c:when>
						<c:otherwise>
							<input type="hidden" name="localidad.id" id="localidadId" value="" />
							<input type="text" id="nombreLocalidad" value=""  class="required"  onclick="limpiarLocalidad()" onblur="chequearLocalidad()" />
						</c:otherwise>	
					</c:choose>
				</td>
				<td  align="right"><label>Provincia *</label></td>
				<td><c:choose>
					<c:when test="${escuela.provincia != null}">
						<input id="nombreProvincia" value="${escuela.provincia.descripcion}" disabled="disabled"/ class="required">
						<input type="hidden" name="provincia.id" id="provinciaId" value="${escuela.provincia.id}"/>
					</c:when>
					<c:otherwise>
						<input id="nombreProvincia" value=""  class="required" disabled="disabled"/>
						<input type="hidden" name="provincia.id" id="provinciaId" value="" />
					</c:otherwise>	
				</c:choose>
			</td>	
			</tr>
			<tr>
				<td><label>Zona Cimientos *</label></td>
				<td><c:choose>
					<c:when test="${escuela.zonaCimientos != null}">
						<input id="zonaCimientos" name="zonaCimientos.nombre" disabled="disabled" value="${escuela.zonaCimientos.nombre}"  class="required"/>
						<input type="hidden" name="zonaCimientos.id" 
							id="idZonaCimientos" value="${escuela.zonaCimientos.id}"/>
					</c:when>
					<c:otherwise>
						<input type="hidden" name="zonaCimientos.id" 
							id="idZonaCimientos" value=""/>
						<input id="zonaCimientos" name="zonaCimientos.nombre" value="" disabled="disabled"  class="required"/>
					</c:otherwise>	
				</c:choose>
				</td> 
			</tr>
			
			<tr>
				<td><label>Nombre (no usar comillas, ya que todo lo que est� despu�s, no se toma)*</label></td>
				<td>
				<input type="text" id="nombre"  name="nombre" class="required"  onblur="verificarEscuela()""
				onclick="verificarEscuela()"">
				<input type="hidden" name="idEscuela" 	id="idEscuela" " />
				</td>
				
	
				<td align="right"><label>CUE</label></td>
				<td><input id="cue" name="codigoUnicoEscolar" onblur="chequearLongitud(this,10);" onkeypress="chequearLongitud(this,10);" class="digits" value="${escuela.codigoUnicoEscolar}"></td>
			</tr>
			<tr>
				<td><label>Modalidad *</label></td>
				<td><select name="idModalidad" id="modalidad" class="required" style="width: 11em;">
					<option></option>
					<c:forEach items="${modalidadesEscuela}" var="modalidad">
						<c:choose>
							<c:when test="${escuela.modalidad.id == modalidad.id}">
								<option value="${modalidad.id}" selected="selected">${modalidad.valor}</option>
							</c:when>
							<c:otherwise>
								<option value="${modalidad.id}" >${modalidad.valor}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				</td>
	
				<td align="right"><label>Orientaci�n</label></td>
				<td><input type="text" id="orientacion"  name="orientacion" value="${escuela.orientacion}"></td>
			</tr>
			<tr>
				<td><label>Nivel que atiende *</label></td>
				<td><select name="idNivelAtiendeEscuela" id="nivelAtiendeEscuela" class="required" style="width: 11em;">
					<option></option>
					<c:forEach items="${nivelesEscuela}" var="nivelEscuela">
						<c:choose>
							<c:when test="${escuela.nivelAtiendeEscuela.id == nivelEscuela.id}">
								<option value="${nivelEscuela.id}" selected="selected">${nivelEscuela.valor}</option>
							</c:when>
							<c:otherwise>
								<option value="${nivelEscuela.id}" >${nivelEscuela.valor}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				</td>
	
				<td align="right"><label>Cantidad de a�os *</label></td>
				<td><select name="idCantidadDeAnios" id="cantidadDeAnios" class="required" style="width:11em">
					<option></option>
					<c:forEach items="${aniosEscuela}" var="anioEscuela">
						<c:choose>
							<c:when test="${escuela.cantidadDeAnios.id == anioEscuela.id}">
								<option value="${anioEscuela.id}" selected="selected">${anioEscuela.valor}</option>
							</c:when>
							<c:otherwise>
								<option value="${anioEscuela.id}" >${anioEscuela.valor}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				</td>
			</tr>
			<tr>
				<td><label>Dependencia *</label></td>
				<td><select name="idDependencia" id="dependencia" class="required" style="width:11em">
					<option></option>
					<c:forEach items="${dependencias}" var="dependencia">
						<c:choose>
							<c:when test="${escuela.dependencia.id == dependencia.id}">
								<option value="${dependencia.id}" selected="selected">${dependencia.valor}</option>
							</c:when>
							<c:otherwise>
								<option value="${dependencia.id}" >${dependencia.valor}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				</td>
	
				<td align="right"><label>C&oacute;digo Postal *</label></td>
				<td><input type="text" id="codigoPostal" name="codigoPostal" class="required digits" value="${escuela.codigoPostal}"></td>
			</tr>
			<tr>
				<td><label>Calle *</label></td>
				<td><input type="text" id="direccionCalle"  name="direccionCalle" class="required" value="${escuela.direccionCalle}"></td>
	
				<td align="right"><label>N&uacute;mero *</label></td>
				<td><input type="text" id="direccionNumero" name="direccionNumero" class="required digits" value="${escuela.direccionNumero}"></td>
	
			</tr>
			<tr>
				<td><label>Barrio</label></td>
				<td><input type="text" id="barrio" name="barrio" value="${escuela.barrio}"></td>
				
			</tr>		
			
			<tr>
				<td><label>Tel&eacute;fono 1</label></td>
				<td><input type="text" id="telefono1" name="telefono1" class="digits" value="${escuela.telefono1}"></td>
	
				<td align="right"><label>T&eacute;lefono 2</label></td>
				<td><input type="text" id="telefono2" name="telefono2" class="digits" value="${escuela.telefono2}"></td>
			</tr>
			<tr>
				<td><label>Mail</label></td>
				<td><input type="text" id="mail" name="mail" value="${escuela.mail}"></td>
	
				<td align="right"><label>Director</label></td>
				<td><input type="text" id="director" name="director" value="${escuela.director}"></td>
			</tr>
			<tr>
				<td><label>Celular</label></td>
				<td><input type="text" id="directorCelular" name="directorCelular" value="${escuela.directorCelular}"></td>
	
				<td align="right"><label>Mail</label></td>
				<td><input type="text" id="directorMail" name="directorMail" value="${escuela.directorMail}"></td>
			</tr>
			<tr>
				<td><label>Secretario</label></td>
				<td><input type="text" id="secretario" name="secretario" value="${escuela.secretario}"></td>
	
				<td align="right"><label>Celular</label></td>
				<td><input type="text" id="secretarioCelular" name="secretarioCelular" value="${escuela.secretarioCelular}"></td>
			</tr>
			<tr>
				<td><label>Mail</label></td>
				<td><input type="text" id="secretarioMail" name="secretarioMail" value="${escuela.secretarioMail}"></td>
	
				<td align="right"><label>Responsable</label></td>
				<td><input type="text" id="responsable" name="responsable" value="${escuela.responsable}"></td>
			</tr>
			<tr>
				<td><label>Celular</label></td>
				<td><input type="text" id="responsableCelular" name="responsableCelular" value="${escuela.responsableCelular}"></td>
	
				<td align="right"><label>Mail</label></td>
				<td><input type="text" id="responsableMail" name="responsableMail" value="${escuela.responsableMail}"></td>
			</tr>
			<tr>
				<td><label>Rural *</label></td>
				<td>	
					Si <input type="radio" value="true" id="rural" name="rural" class="required"
						<c:if test="${escuela.rural}"> checked="checked"</c:if> > 
					No<input type="radio" id="rural" value="false" name="rural"
						<c:if test="${escuela.rural == false}"> checked="checked"</c:if>></td>
	
				<td align="right"><label>Subsidio estatal *</label></td>
				<td>	Si<input type="radio" id="subsidioEstatal" value="true" name="subsidioEstatal" class="required"
						<c:if test="${escuela.subsidioEstatal}"> checked="checked"</c:if> > 
					No<input type="radio" id="subsidioEstatal" value="false" name="subsidioEstatal"
						<c:if test="${escuela.subsidioEstatal == false}"> checked="checked"</c:if>>
				</td>
			</tr>
			<tr>
				<td colspan="1">
					<label>Observaciones generales</label>
				</td>
				<td colspan="3">
					<textarea rows="4" cols="55" name="obsGenerales" id="obsGenerales" onblur="chequearLongitud(this,3000);"onkeypress="chequearLongitud(this,3000);">${escuela.obsGenerales}</textarea>			
				</td>
			</tr>
		</table>
	</fieldset> 
	<br>
	<br>
	<fieldset style="width:600px;">
		<legend>Informaci�n general Cimientos</legend>
		<br></br>
		<p>
			<label style="width: 150px">Estado escuela *</label>
			<select name="idEstadoEscuela" id="estadoEscuela" class="required" style="width: auto;" onchange="cambiarMotivos()">
				<option></option>
				<c:forEach items="${estadosEscuela}" var="estadoEscuela">
					<c:choose>
						<c:when test="${escuela.estadoEscuela.id == estadoEscuela.id}">
							<option value="${estadoEscuela.id}" selected="selected">${estadoEscuela.valor}</option>
						</c:when>
						<c:otherwise>
							<option value="${estadoEscuela.id}" >${estadoEscuela.valor}</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
		</p>
		<p>
			<label style="width: 150px">Motivo de no selecci&oacute;n </label>
			<input type="text" id="motivoNoSeleccion" name="motivoNoSeleccion" 
				<c:if test="${escuela.estadoEscuela.id != 3}"> disabled="disabled" </c:if> value="${escuela.motivoNoSeleccion}">
			
		</p>
		<p>
			<label style="width: 150px">Programa que se implementa *</label>
			<select name="idPrograma" id="programa" class="required" style="width: auto;">
				<option></option>
				<c:forEach items="${programas}" var="programa">
					<c:choose>
						<c:when test="${escuela.programa.id == programa.id}">
							<option value="${programa.id}" selected="selected">${programa.valor}</option>
						</c:when>
						<c:otherwise>
							<option value="${programa.id}" >${programa.valor}</option>
						</c:otherwise>
					</c:choose>
	
				</c:forEach>
			</select>
		</p>
		<p>
			<label style="width: 150px">Modalidad de trabajo</label>
			<select name="idModalidadTrabajoEscuela" id="modalidadTrabajoEscuela" style="width: auto;" onchange="habilitarCampos()">
				<option></option>
				<c:forEach items="${modalidadesTrabajoEscuela}" var="modalidadTrabajo">
					<c:choose>
						<c:when test="${escuela.modalidadTrabajoEscuela.id == modalidadTrabajo.id}">
							<option value="${modalidadTrabajo.id}" selected="selected">${modalidadTrabajo.valor}</option>
						</c:when>
						<c:otherwise>
							<option value="${modalidadTrabajo.id}" >${modalidadTrabajo.valor}</option>
						</c:otherwise>
					</c:choose>
	
				</c:forEach>
			</select>
		</p>
		<p>
			<label style="width: 150px">A�o comienzo del proyecto</label>
			<select name="idComProy" id="comProy" style="width: auto;" disabled="disabled">
				<option></option>
				<c:forEach items="${ciclos}" var="comProy">
					<c:choose>
						<c:when test="${escuela.comienzoProyecto.id == comProy.id}">
							<option value="${comProy.id}" selected="selected">${comProy.nombre}</option>
						</c:when>
						<c:otherwise>
							<option value="${comProy.id}" >${comProy.nombre}</option>
						</c:otherwise>
					</c:choose>
	
				</c:forEach>
			</select>
		</p>
		<p>
			<label style="width: 150px"> A�o de comienzo de PFE</label>
			<select name="idComPBE" id="comPBE" style="width: auto;" disabled="disabled">
				<option></option>
				<c:forEach items="${ciclos2}" var="comPBE">
					<c:choose>
						<c:when test="${escuela.comienzoPBE.id == comPBE.id}">
							<option value="${comPBE.id}" selected="selected">${comPBE.nombre}</option>
						</c:when>
						<c:otherwise>
							<option value="${comPBE.id}" >${comPBE.nombre}</option>
						</c:otherwise>
					</c:choose>
	
				</c:forEach>
			</select>
		</p>
		<p>
			<label style="width: 150px">Fase del proyecto</label>
			<select name="idFase" id="fase" style="width: auto;" disabled="disabled" onchange="habilitarObj()">
				<option></option>
				<c:forEach items="${fasesTrabajo}" var="fase">
					<c:choose>
						<c:when test="${escuela.faseProyecto.id == fase.id}">
							<option value="${fase.id}" selected="selected">${fase.valor}</option>
						</c:when>
						<c:otherwise>
							<option value="${fase.id}" >${fase.valor}</option>
						</c:otherwise>
					</c:choose>
	
				</c:forEach>
			</select>
		</p>
		<p>
			<label style="width: 150px">Objetivo proyecto</label>
			<textarea rows="4" cols="50" name="objetivoProyecto" id="objetivoProyecto" onblur="chequearLongitud(this,3000);"onkeypress="chequearLongitud(this,3000);" disabled="disabled">${escuela.objetivoProyecto}</textarea>			
		</p>
		<p>
			<label style="width: 150px">Observaciones</label>
			<textarea rows="4" cols="50" name="observaciones" id="observaciones" onblur="chequearLongitud(this,3000);"onkeypress="chequearLongitud(this,3000);">${escuela.observaciones}</textarea>			
		</p>
		<p>
			<label style="width: 150px">Matr&iacute;cula de la escuela</label>
			<input type="text" id="matricula" name="matricula" class="digits" value="${escuela.matricula}" maxlength="5" disabled="disabled" size="5"> Nros absolutos
		</p>
		<p>
			<label style="width: 150px">Indicadores de repitencia</label>
			<input type="text" id="indicadorRepitencia" name="indicadorRepitencia" value="${escuela.indicadorRepitencia}" onchange="validarIndicador(this)" disabled="disabled" maxlength="5" size="5" onkeypress="return validarDecimal(event, this);"> %
		</p>
		<p>
			<label style="width: 150px">Indicadores de abandono</label>
			<input type="text" id="indicadorAbandono" name="indicadorAbandono"  value="${escuela.indicadorAbandono}" onchange="validarIndicador(this)" disabled="disabled" maxlength="5" size="5" onkeypress="return validarDecimal(event, this);"> %
		</p>
		<p>
			<label style="width: 150px">Porcentaje de inasistencia</label>
			<input type="text" id="porcentajeInasistencia" name="porcentajeInasistencia"  value="${escuela.porcentajeInasistencia}" onchange="validarIndicador(this)" disabled="disabled" maxlength="5" size="5" onkeypress="return validarDecimal(event, this);"> %
		</p>
		<p>
			<label style="width: 150px">Turnos de la escuela</label>			
			<form:select path="turno">
				<form:options items="${turnos}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</p>
		<p>
			<label style="width: 150px">Espacios de apoyo a la escolaridad en la escuela</label>			
			<form:select path="espacioApoyo">
				<form:options items="${espaciosApoyo}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</p>	
	</fieldset>
		<table align="center">
			<tr>
				<td>
					<input class="ui-state-default ui-corner-all " type="button" value="Registrar" onclick="enviarForm('alta')"/>
				</td>
				<td>					
					<c:if test="${!empty urlRegreso}">
				  		<input type="reset" class="ui-state-default ui-corner-all" value="Volver" class="ui-state-default ui-corner-all" onclick="location.href='..' + '${urlRegreso}'; return false;" />
			       	</c:if>
			       	<c:if test="${empty urlRegreso}">
				  		<input class="ui-state-default ui-corner-all " type="button" value="Volver" onclick="enviarForm('volverEscuela')"/>
			       	</c:if>
				</td>
			</tr>
		</table>
		<input type="hidden" name="urlRegreso" value="${urlRegreso}"></input>
</form:form>
	
</div>
</body>
</html>