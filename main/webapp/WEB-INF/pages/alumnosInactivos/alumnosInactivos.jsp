<%@page import="org.cimientos.intranet.modelo.perfil.PerfilAlumno"%>
<%@page import="org.cimientos.intranet.modelo.persona.Persona"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="mif" uri="/list-operator.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="org.cimientos.intranet.utils.*" %>
<%@ page import="org.cimientos.intranet.modelo.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript"
	src="<c:url value="/static/js/jquery.effects.core.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/static/js/jquery.ui.position.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/static/js/jquery.ui.widget.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/static/js/jquery.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/static/js/jquery-ui-1.8.5.custom.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/static/js/jquery.ui.datepicker-es.js"/>"></script>
<link rel="stylesheet"
	href="<c:url value="/static/css/cimientos/jquery-ui-1.8.5.custom.css"/>"
	media="all">
<script src="<c:url value="/static/js/jquery.alerts.js" />"
	type="text/javascript"></script>

<link rel="stylesheet"
	href="<c:url value="/static/css/displaytags.css"/>" media="all">
</head>
<style type="text/css">
table#exportacion {
	background-color: #C0C2FF;
	border: 0;
}
</style>

<script>
	function edad() {
		var edad1 = 10;
		return edad;

	}
</script>

<script>
	function cambio() {
		var arr=new Array();
		var anio
		 $("input[name='edad[]']").each(function()
		 {  
			 
			
		    var valor=$(this).attr('value');
		    anio=valor.substring(0,4);
		    //document.write(val);
		    //arr.Push(val);
		    $("input[name='edad[]']").val(anio);
		 });

	}
</script>

<script>
	function cambio2() {
		alert("entre");
		var anio;
		$(function () {
	      
	          $("#pp input").each(function (index) {
	        	  var valor=$(this).attr('value');
	        	  anio=valor.substring(0,4);
	        	  //$(this).removeClass();
	              //$(this).addClass("parrafo");
	              //$(this).text('Parrafo ' + index);
	          	  $(this).val(anio);
	          	  alert(anio);
	          })
	     
	 })


	}
</script>

<script type="text/javascript">
	$(document).ready(function() {
		$("#fechaDesde").datepicker({
			changeMonth : true,
			changeYear : true,
			yearRange : '-5:+1'
		});
		$("#fechaHasta").datepicker({
			changeMonth : true,
			changeYear : true,
			yearRange : '-5:+1'
		});
	});

	$(function() {
		$("#padrino").autocomplete({
			source : function(request, response) {
				$.ajax({
					url : "../ajax/buscarTodosPadrinosPorNombre.do",
					dataType : "json",
					data : {
						style : "full",
						maxRows : 15,
						name_startsWith : request.term
					},
					success : function(data) {
						response($.map(data.padrinos, function(item) {
							return {
								label : item.nombre,
								value : item.nombre,
								id : item.id
							}
						}))
					}
				})
			},
			minLength : 2,
			select : function(event, ui) {
				$("#idPadrino").val(ui.item.id);
			},
			open : function() {
				$(this).removeClass("ui-corner-all").addClass("ui-corner-top");
			},
			close : function() {
				$(this).removeClass("ui-corner-top").addClass("ui-corner-all");
			}
		});
	});
	$(function() {

		$("#zonaCimientos").keypress(function() {
			$("#zonaCimientosId").val(0);
			$("#zonaCimientos").autocomplete({
				source : function(request, response) {
					$.ajax({
						url : "../ajax/buscarTodasZonaPorNombre.do",
						dataType : "json",
						data : {
							style : "full",
							name_startsWith : request.term
						},
						success : function(data) {
							response($.map(data.zonas, function(item) {
								return {
									label : item.nombre,
									value : item.nombre,
									id : item.id
								}
							}))
						}
					})
				},
				select : function(event, ui) {
					$("#zonaCimientosId").val(ui.item.id);
				}
			});
		});

	});

	$(function() {

		$("#provincia").keypress(function() {
			$("#provinciaId").val(0);
			$("#provincia").autocomplete({
				source : function(request, response) {
					$.ajax({
						url : "../ajax/buscarProvincia.do",
						dataType : "json",
						data : {
							style : "full",
							name_startsWith : request.term
						},
						success : function(data) {
							response($.map(data.zonas, function(item) {
								return {
									label : item.nombre,
									value : item.nombre,
									id : item.id
								}
							}))
						}
					})
				},
				select : function(event, ui) {
					$("#provinciaId").val(ui.item.id);
				}
			});
		});

	});

	$(function() {
		$("#ea").autocomplete({
			source : function(request, response) {
				$.ajax({
					url : "../ajax/buscarTodosEAPorNombre.do",
					dataType : "json",
					data : {
						style : "full",
						maxRows : 12,
						name_startsWith : request.term
					},
					success : function(data) {
						response($.map(data.eas, function(item) {
							return {
								label : item.nombre,
								value : item.nombre,
								id : item.id,
								ea : item.ea
							}
						}))
					}
				})
			},
			minLength : 2,
			select : function(event, ui) {
				$("#idEA").val(ui.item.id);
				$("#ea").text(ui.item.ea);
			}
		});
	});

	$(function() {
		$("#escuela").autocomplete({
			source : function(request, response) {
				$.ajax({
					url : "../ajax/buscarEscuelasPorNombre.do",
					dataType : "json",
					data : {
						style : "full",
						maxRows : 12,
						name_startsWith : request.term
					},
					success : function(data) {
						response($.map(data.escuelas, function(item) {
							return {
								label : item.nombre,
								value : item.nombre,
								id : item.id,
								escuela : item.nombre
							}
						}))
					}
				})
			},
			minLength : 2,
			select : function(event, ui) {
				$("#idEscuela").val(ui.item.id);
				$("#escuela").text(ui.item.nombre);
			}
		});
	});

	function validarFiltros() {
		if ($('#ea').val() == '') {
			$('#idEA').removeAttr('value');
		}
		if ($('#zonaCimientos').val() == '') {
			$('#zonaCimientosId').removeAttr('value');
		}
		if ($('#padrino').val() == '') {
			$('#idPadrino').removeAttr('value');
		}
		if ($('#escuela').val() == '') {
			$('#idEscuela').removeAttr('value');
		}
		document.forms['formEx'].submit();

	}

	function validarEntero(campo, valor) {
		if (isNaN(valor)) { //Compruebo si es un valor num�rico 
			$('#' + campo).val(" "); //entonces (no es numero) borro el numero 
		} else {
			$('#' + campo).val(valor);
		}
	}

	$(function() {
		$("#cicloId")
				.change(
						function(evt) {
							evt.preventDefault()
							$
									.ajax({
										type : "GET",
										url : "../ajax/obtenerListaPeriodos.do",
										data : {
											idCiclo : $("#cicloId").val()
										},
										dataType : "json",
										success : function(data) {
											var options = '';
											options += '<option value="" selected="selected">Todos</option>'
											$(data.periodos)
													.each(
															function() {
																options += '<option value="' + this.id + '">'
																		+ this.nombre
																		+ '</option>';
															});
											$("select#periodoId").html(options);

										}
									})
						})
	});

	$(function() {
		$("#cicloIdEgreso")
				.change(
						function(evt) {
							evt.preventDefault()
							$
									.ajax({
										type : "GET",
										url : "../ajax/obtenerListaPeriodos.do",
										data : {
											idCiclo : $("#cicloIdEgreso").val()
										},
										dataType : "json",
										success : function(data) {
											var options = '';
											options += '<option value="" selected="selected">Todos</option>'
											$(data.periodos)
													.each(
															function() {
																options += '<option value="' + this.id + '">'
																		+ this.nombre
																		+ '</option>';
															});
											$("select#periodoIdEgreso").html(
													options);

										}
									})
						})
	});

	function validarReincorporacion(id) {
		$("#dialog-confirm")
				.dialog(
						{
							resizable : false,
							height : 160,
							width : 550,
							modal : true,
							buttons : {
								"Reincorporar Alumno" : function() {
									$(this).dialog("close");
									document.forms['formEx'].action = "../alumnosInactivos/reincorporaralumno.do";
									document.forms['formEx'].idAlumno.value = id;
									document.forms['formEx'].submit();
									$.blockUI();
								},
								"Cancelar" : function() {
									$(this).dialog("close");
								}
							}
						});
	}

	function validarPeriodoEgreso() {
		if (document.getElementById('situacion').value == 4) {
			$("#cicloIdEgreso").removeAttr("disabled");
			$("#periodoIdEgreso").removeAttr("disabled");
		} else {
			$("#cicloIdEgreso").val("");
			$("#cicloIdEgreso").attr("disabled", "disabled");
			$("#periodoIdEgreso").val("");
			$("#periodoIdEgreso").attr("disabled", "disabled");
		}
	}
</script>

<body onload="validarPeriodoEgreso()" >
	
	<br>
	<br>
	<center>
		<h3>Listado de Alumnos Inactivos</h3>
	</center>
	<br>
	<br>
	<form method="post" name="formEx" id="formEx"
		action="<c:url value='/alumnosInactivos/listaAlumnosInactivos.do'/>">
		<center>
			<fieldset style="font-size: 12px; width: 980px;">

				<input type="hidden" name="idAlumno" />
				<table id="table-informe" align="center"
					style="margin-left: 100px; margin-right: 60px; border-style: hidden;"
					width="600px">
					<tr align="center">
						<td align="left" style="font-size: 13px; font-weight: bold">Alumno:</td>
						<td align="left"><input id="alumno" width="150px;"
							type="text" name="nombreAlumno" value="${nombreAlumno}" /></td>
						<td align="left" style="font-size: 13px; font-weight: bold">DNI
							Alumno:</td>
						<td align="left"><input id="dni" width="150px;" type="text"
							onkeyup="validarEntero(this.id, this.value)" maxlength="8"
							name="dniAlumno" value="${dniAlumno}" /></td>
					</tr>
					<tr>
						<td align="left" style="font-size: 13px; font-weight: bold">Estado
							Alumno:</td>
						<td align="left"><select name="idEstadoAlumno" id="estados">
								<option value="0">Todos</option>
								<c:forEach items="${listEstadoAlumnos}" var="estado1">
									<c:choose>
										<c:when test="${estado.id == estado1.id}">
											<option value="${estado.id}" selected="selected">${estado1.valor}</option>
										</c:when>
										<c:otherwise>
											<option value="${estado1.id}">${estado1.valor}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
						</select></td>
						<td align="left" style="font-size: 13px; font-weight: bold">Sexo:</td>
						<td align="left"><select name="sexo" id="sexo">
								<option value="Todos">Todos</option>
								<c:forEach items="${listSexo}" var="sexo1">
									<c:choose>
										<c:when test="${sexo == sexo1}">
											<option value="${sexo}" selected="selected">${sexo1}</option>
										</c:when>
										<c:otherwise>
											<option value="${sexo1}">${sexo1}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td align="left" style="font-size: 13px; font-weight: bold">Cantidad
							Previas:</td>
						<td align="left"><select name="cantPrevias" id="cantPrevias">
								<option value="0">Todos</option>
								<c:forEach items="${listaPrevias}" var="listaP">
									<c:choose>
										<c:when test="${previa == listaP}">
											<option value="${previa}" selected="selected">${listaP}</option>
										</c:when>
										<c:otherwise>
											<option value="${listaP}">${listaP}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
						</select></td>
						<td align="left" style="font-size: 13px; font-weight: bold">Escuela:</td>
						<td align="left"><input type="text" value="${escuela}"
							id="escuela" name="escuela" size="21"> <input
							name="idEscuela" value="${idEscuela}" id="idEscuela"
							type="hidden"></td>
					</tr>
					<tr align="center">
						<td align="left" style="font-size: 13px; font-weight: bold">A�o
							Escolar:</td>
						<td align="left"><select name="idAnioEscolar"
							id="aniosEscolares">
								<option value="0">Todos</option>
								<c:forEach items="${listAniosEscolares}" var="anio1">
									<c:choose>
										<c:when test="${anio.id == anio1.id}">
											<option value="${anio.id}" selected="selected">${anio1.valor}</option>
										</c:when>
										<c:otherwise>
											<option value="${anio1.id}">${anio1.valor}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
						</select></td>
						<td align="left" style="font-size: 13px; font-weight: bold">Situaci�n
							Escolar:</td>
						<td align="left"><select name="idSituacionAlumno"
							id="situacion" onchange="validarPeriodoEgreso()">
								<option value="0">Todos</option>
								<c:forEach items="${listSituacionAlumnos}" var="situacion1">
									<c:choose>
										<c:when test="${situacion.id == situacion1.id}">
											<option value="${situacion.id}" selected="selected">${situacion1.valor}</option>
										</c:when>
										<c:otherwise>
											<option value="${situacion1.id}">${situacion1.valor}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
						</select></td>
					</tr>
					<tr align="center">
						<td align="left" style="font-size: 13px; font-weight: bold">Ciclo
							egreso:</td>
						<td align="left"><select id="cicloIdEgreso"
							name="cicloIdEgreso" disabled="disabled" style="width: 150px;">
								<option value="0">Todos</option>
								<c:forEach var="ciclo" items="${ciclos}">
									<c:if test="${ciclo.id == cicloIdEgreso}">
										<option selected="selected" id="ciclo" value="${ciclo.id}">${ciclo.nombre}</option>
									</c:if>
									<c:if test="${ciclo.id != cicloIdEgreso}">
										<option id="ciclo" value="${ciclo.id}">${ciclo.nombre}</option>
									</c:if>
								</c:forEach>
						</select></td>
						<td align="left" style="font-size: 13px; font-weight: bold">Periodo
							egreso:</td>
						<td align="left"><select id="periodoIdEgreso"
							name="periodoIdEgreso" disabled="disabled" style="width: 150px;">
								<option value="0">Todos</option>
								<c:forEach var="periodo" items="${periodosEgreso}">
									<c:if test="${periodo.id == periodoIdEgreso}">
										<option selected="selected" id="periodo" value="${periodo.id}">${periodo.nombre}</option>
									</c:if>
									<c:if test="${periodo.id != periodoIdEgreso}">
										<option id="tipo" value="${periodo.id}">${periodo.nombre}</option>
									</c:if>
								</c:forEach>
						</select></td>
					</tr>
					<tr align="center">
						<td align="left" style="font-size: 13px; font-weight: bold">Ciclo
							baja:</td>
						<td align="left"><select id="cicloId" name="cicloId"
							style="width: 150px;">
								<option value="0">Todos</option>
								<c:forEach var="ciclo" items="${ciclos}">
									<c:if test="${ciclo.id == cicloId}">
										<option selected="selected" id="ciclo" value="${ciclo.id}">${ciclo.nombre}</option>
									</c:if>
									<c:if test="${ciclo.id != cicloId}">
										<option id="ciclo" value="${ciclo.id}">${ciclo.nombre}</option>
									</c:if>
								</c:forEach>
						</select></td>
						<td align="left" style="font-size: 13px; font-weight: bold">Periodo
							baja:</td>
						<td align="left"><select id="periodoId" name="periodoId"
							style="width: 150px;">
								<option value="0">Todos</option>
								<c:forEach var="periodo" items="${periodos}">
									<c:if test="${periodo.id == periodoId}">
										<option selected="selected" id="periodo" value="${periodo.id}">${periodo.nombre}</option>
									</c:if>
									<c:if test="${periodo.id != periodoId}">
										<option id="tipo" value="${periodo.id}">${periodo.nombre}</option>
									</c:if>
								</c:forEach>
						</select></td>
					</tr>
					<tr align="center">
						<td align="left" width="230"
							style="font-size: 13px; font-weight: bold">Ult. Act. Desde:</td>
						<td align="left" width="300"><input name="fechaDesde"
							id="fechaDesde" class="text-input date"
							value="<fmt:formatDate value="${fechaDesde}" pattern="dd/MM/yyyy"/>" />dd/mm/aaaa
						</td>
						<td align="left" width="230"
							style="font-size: 13px; font-weight: bold">Ult. Act. Hasta:</td>
						<td align="left" width="300"><input name="fechaHasta"
							id="fechaHasta" class="text-input date"
							value="<fmt:formatDate value="${fechaHasta}" pattern="dd/MM/yyyy"/>" />dd/mm/aaaa
						</td>
					</tr>
					<tr align="center">
						<td align="left" style="font-size: 13px; font-weight: bold">Tipo
							de Padrino:</td>
						<td align="left"><select id="tipoId" name="tipoId"
							class="required" style="width: 150px;">
								<option value="0">Todos</option>
								<c:forEach var="tipo" items="${tipos}">
									<c:if test="${tipo.id == tipoId}">
										<option selected="selected" id="tipo" value="${tipo.id}">${tipo.valor}</option>
									</c:if>
									<c:if test="${tipo.id != tipoId}">
										<option id="tipo" value="${tipo.id}">${tipo.valor}</option>
									</c:if>
								</c:forEach>
						</select></td>
						<td align="left" style="font-size: 13px; font-weight: bold">Padrino:</td>
						<td align="left"><input type="hidden" name="idPadrino"
							id="idPadrino" value="${padrino.id}" /> <c:choose>
								<c:when test="${padrino.datosPersonales != null}">
									<input type="text" id="padrino"
										value="${padrino.datosPersonales.apellido}, ${padrino.datosPersonales.nombre}" />
								</c:when>
								<c:when test="${padrino.empresa != null}">
									<input type="text" id="padrino"
										value="${padrino.empresa.denominacion}" />
								</c:when>
								<c:otherwise>
									<input type="text" id="padrino"
										value="${padrino.datosPersonales.nombre}" />
								</c:otherwise>
							</c:choose></td>
					</tr>
					<tr align="center">
						<td align="left" style="font-size: 13px; font-weight: bold">Zona
							Cimientos:</td>
						<td align="left"><input type="hidden" name="idZonaCimientos"
							id="zonaCimientosId" value="${zonaCimientos.id}" /> <input
							type="text" id="zonaCimientos" value="${zonaCimientos.nombre}" />
						</td>
						<td align="left" style="font-size: 13px; font-weight: bold">Provincia:</td>
						<td align="left"><input type="hidden" name="idProvincia"
							id="provinciaId" value="${provincia.id}" /> <input type="text"
							id="provincia" value="${provincia.descripcion}" /></td>
					</tr>
					<tr align="center">
						<td align="left" style="font-size: 13px; font-weight: bold">EA:</td>
						<td align="left"><input type="text" value="${ea}" id="ea"
							name="ea" size="21"> <input name="idEA" value="${idEA}"
							id="idEA" type="hidden"></td>
						
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
						<td colspan="4"><input align="middle" id="buscar"
							type="button" onclick="validarFiltros()" value="Buscar"
							class="ui-state-default ui-corner-all"></input></td>
					</tr>
				</table>

			</fieldset>
			<br> <br>
			<h5>Este listado tiene una exportaci�n especial a excel que
				incluye la actualizaci�n de los datos post PFE<img src="../static/images/atencion.gif" width=10></h5>
		</center>
		<br> <br>
		
		<CENTER style="width: 1210px;">
			<display:table name="alumnos" export="true"
				class="displayTags_wrapper" id="dto"
				style="font-size: 12px; width:1100px; background-color: #C0C2FF;"
				pagesize="50" requestURI="">
				<c:set var="urlRegreso"
					value="/alumnosInactivos/listaAlumnosInactivos.do"></c:set>
				<display:column property="id" title="Id Alumno" media="excel"></display:column>
				<display:column title="Alumno" media="excel">${dto.datosPersonales.apellido},${dto.datosPersonales.nombre}</display:column>
				<display:column style="width: 18%" headerClass="sortable"
					title="Alumno" media="html">
    	${dto.datosPersonales.apellido},${dto.datosPersonales.nombre}
    	<div style="width: 0.5cm" class="ui-state-default ui-corner-all"
						title="Detalle Alumno">
						<a
							href="<c:url value='/fichaAlumno/fichaAlumnoView.do?idAlumno=${dto.id}&urlRegreso=${urlRegreso}'/>">
							<span class="ui-icon ui-icon-search"></span>
						</a>
					</div>
				</display:column>
				<display:column title="Sexo" media="excel">
					<c:if test="${dto.datosPersonales.sexo}">
			Masculino
		</c:if>
					<c:if test="${!dto.datosPersonales.sexo}">
			Femenino
		</c:if>
				</display:column>
				<display:column property="datosPersonales.dni"
					title="N� de Documento" media="excel"></display:column>
				<display:column property="datosPersonales.fechaNacimiento"
					format="{0,date,dd-MM-yyyy}" title="Fecha de nacimiento"
					media="excel"></display:column>
				<display:column title="Edad actual" >
 		 			${dto.datosPersonales.edad} 		 		
 				</display:column>
				<display:column property="datosPersonales.telefono" media="excel"
					title="Tel�fono"></display:column>
				<display:column property="datosPersonales.mail" title="Email"
					media="excel"></display:column>
				<display:column property="anioEscolar.valor" title="A�o Escolar"></display:column>
				<display:column property="eae" title="EAE"></display:column>
				<display:column title="A�o Adicional" media="excel">
					<c:if test="${dto.anioAdicional}">
			Si
		</c:if>
					<c:if test="${!dto.anioAdicional}">
			No
		</c:if>
				</display:column>
				<display:column property="escuela.nombre" title="Escuela"></display:column>
				<display:column property="escuela.zonaCimientos.nombre" title="Zona"></display:column>
				<display:column property="datosPersonales.localidad.nombre"
					title="Localidad" media="excel"></display:column>
				<display:column
					property="datosPersonales.localidad.provincia.descripcion"
					title="Provincia" media="excel"></display:column>
				<display:column title="EA">
					<c:if test="${!empty dto.ea}">
			${dto.ea.datosPersonales.apellido}, ${dto.ea.datosPersonales.nombre}
		</c:if>
				</display:column>
				<display:column title="Per�odo Baja">
					<c:if test="${!empty dto.periodoDeBaja}">
			${dto.periodoDeBaja.nombre} ${dto.periodoDeBaja.ciclo.nombre}
		</c:if>
					<c:if test="${empty dto.periodoDeBaja}">
			No aplica
		</c:if>
				</display:column>
				<display:column property="estadoAlumno.valor" title="Estado Alumno"></display:column>
				<display:column property="motivoBaja" title="Motivo de Baja"></display:column>
				<display:column title="Situacion Escolar actual">
					<c:if test="${!empty dto.situacionEscolar}">
			${dto.situacionEscolar.valor}
		</c:if>
					<c:if test="${empty dto.situacionEscolar}">
			No aplica
		</c:if>
				</display:column>
				<display:column title="Per�odo Egreso">
					<c:if test="${!empty dto.periodoDeEgreso}">
			${dto.periodoDeEgreso.nombre} ${dto.periodoDeEgreso.ciclo.nombre}
		</c:if>
					<c:if test="${empty dto.periodoDeEgreso}">

					</c:if>
				</display:column>
				<display:column title="Ciclo Egreso" media="excel">
					<c:if test="${!empty dto.periodoDeEgreso}">
			${dto.periodoDeEgreso.ciclo.nombre}
		</c:if>
					<c:if test="${empty dto.periodoDeEgreso}">

					</c:if>
				</display:column>

				<display:column property="ultimaActualizacion"
					format="{0,date,dd-MM-yyyy}"
					title="Actualizaci�n situaci�n escolar"></display:column>
				<display:column title="Situaci�n actual" media="excel">

					<c:if test="${dto.situacionActual!=null }">
						<c:if test="${dto.situacionActual=='TRABAJA' }">
				TRABAJA
			</c:if>
						<c:if test="${dto.situacionActual=='ESTUDIA' }">
				ESTUDIA
			</c:if>
						<c:if test="${dto.situacionActual=='TRABAJAESTUDIA' }">
				TRABAJA Y ESTUDIA
			</c:if>
						<c:if test="${dto.situacionActual=='NITRABAJANIESTUDIA' }">
				NI TRABAJA NI ESTUDIA
			</c:if>
						<c:if test="${dto.situacionActual=='OTRO' }">
				OTRO
			</c:if>
						<c:if test="${dto.situacionActual=='SINDATO' }">
				SIN DATO
			</c:if>
					</c:if>
					<c:if test="${dto.situacionActual==null }">

					</c:if>
				</display:column>
				<display:column property="otraSituacion" media="excel"
					title="Otra situaci�n actual"></display:column>

				<display:column property="ultimaActualizacion" media="excel"
					format="{0,date,dd-MM-yyyy}"
					title="Ultima actualizaci�n de situaci�n actual"></display:column>

				<display:column title="Proyecci�n deseada" media="excel">
					<c:if test="${dto.proyeccionDeseada!=null }">
						<c:if test="${dto.proyeccionDeseada=='TRABAJAR' }">
				TRABAJAR
			</c:if>
						<c:if test="${dto.proyeccionDeseada=='ESTUDIAR' }">
				ESTUDIAR
			</c:if>
						<c:if test="${dto.proyeccionDeseada=='TRABAJARESTUDIAR' }">
				TRABAJAR Y ESTUDIAR
			</c:if>
						<c:if test="${dto.proyeccionDeseada=='NITRABAJARESTUDIAR' }">
				NI TRABAJAR NI ESTUDIAR
			</c:if>
						<c:if test="${dto.proyeccionDeseada=='OTRO' }">
				OTRO
			</c:if>
						<c:if test="${dto.proyeccionDeseada=='SINDATO' }">
				SIN DATO
			</c:if>
					</c:if>
					<c:if test="${dto.proyeccionDeseada==null }">

					</c:if>


				</display:column>
				<display:column property="otraProyeccion" media="excel"
					title="Otra proyecci�n deseada"></display:column>
				<display:column property="obsPostPBE" media="excel"
					title="Observaciones"></display:column>
				<display:column property="fechaProyeccionDeseada" media="excel"
					format="{0,date,dd-MM-yyyy}"
					title="�ltima actualizaci�n de proyecci�n deseada"></display:column>

				<display:column title="Padrino">
		${dto.nombrePadrinoHistorial}		
	</display:column>

				<display:column title="Tipo padrino" media="excel">
		${dto.tipoPadrinoHistorial}
	</display:column>
				<display:column media='excel' title="Id Plat"
					sortProperty="idPlataforma" sortable="true" headerClass="sortable">
    	${dto.idPlataformaPadrinoHistorial}
    </display:column>



				<display:column media="html" headerClass="sortable" title="Acciones">
					<sec:authorize access="hasRole('SuperUsuario')">
						<c:if test="${dto.estadoAlumno.id != 9}">
							<div style="width: 0.5cm" class="ui-state-default ui-corner-all"
								title="Reincorporar">
								<a onclick="validarReincorporacion('${dto.id}')"> <span
									class="ui-icon ui-icon-pencil"></span>
								</a>
							</div>
						</c:if>
					</sec:authorize>
				</display:column>


				<display:setProperty name="basic.empty.showtable" value="true" />
				<display:setProperty name="paging.banner.group_size" value="35" />
				<display:setProperty name="paging.banner.item_name" value="alumnos" />
				<display:setProperty name="paging.banner.item_names" value="alumnos" />
				<display:setProperty name="paging.banner.onepage" value=" " />
				<display:setProperty name="export.excel.filename"
					value="alumnosInactivos.xls" />

			</display:table>
		</CENTER>
		<div style="display: none;" id="dialog-confirm"
			title="Desea reincorporar el alumno seleccionado?">
			<div id="left-content">
				<table border="0" align="left" cellpadding="0" cellspacing="0">
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td><span class="ui-icon ui-icon-alert"
							style="float: left; margin: 0 7px 40px 0;">Esta acci�n
							enviar� al alumno al listado de candidatos. Desea continuar?</td>
					</tr>
				</table>
			</div>
		</div>
	</form>

</body>
</html>