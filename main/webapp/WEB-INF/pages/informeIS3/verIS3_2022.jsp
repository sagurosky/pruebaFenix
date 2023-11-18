<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Ver Informe de Seguimiento N�3</title>

<style>
	 span{ background-color: yellow; }
</style>
		<style type="text/css">
			.ui-dropdownchecklist-text {
				font-size: 11px;
			}
		</style>
		<script type="text/javascript" src="<c:url  value="/static/js/funcionesIS3.js"/>"></script>
		<script type="text/javascript" src="<c:url  value="/static/js/jquery.blockUI.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/static/js/ui.dropdownchecklist.js"/>"></script>
		<script type="text/javascript">
			function chequearLongitud(obj)
			{
				if (obj.value.length > 10000) 
				{
					obj.value = obj.value.substring(0, 10000);
				}
			}
		</script>
	</head>
	<body>
		<div id="main-content">
			<form id="modificarInformeIS3" class="cmxform" action="" method="post">
				<h1 id="titulo-informe">:: Informe de Seguimiento N� 3 ::</h1>
				<c:set var="urlRegreso" value="${urlRegreso}"></c:set>
				<input type="hidden" id="estadoEntrevista" name="estadoEntrevista" value="${estadoEntrevista}"></input>
				<input type="hidden" id="evalRenovacionBeca" name="evalRenovacionBeca" value="${evalRenovacionBeca}"></input>
				<table border="0" align="left" cellpadding="0" cellspacing="0" id="table-informe">
					<tr>
						<td colspan="2">
							<label>Ver ${informe.estado.valor}</label>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>
							<label>Ciclo lectivo</label>
							<label>${informe.cicloActual.nombre}</label>
						</td>
					</tr> 
					<tr>
						<td colspan="2">
							<h1 id="subtitulo-informe">Mis datos</h1>
						</td>
					</tr>
					<tr>
						<td>
							<table width="200" border="0" align="left" cellpadding="0" cellspacing="0" id="table-forms">		
								<tr>
									<td colspan="2">
										${becado.datosPersonales.nombre}&nbsp;${becado.datosPersonales.apellido}
									</td>
								</tr>		
								<c:if test="${tieneFoto == true}">
									<tr>				
										<td colspan="2">
											<img src="../fichaAlumno/mostrarImagen.do?dni=${becado.datosPersonales.dni}" width="100px">
										</td>
									</tr>
								</c:if>
								<c:if test="${tieneFoto == false}">			
									<tr>
										<td colspan="2">
											<img src="../fichaAlumno/mostrarImagen.do?dni=0" width="100px">
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<label>
												Recuerda que si no cargaste una foto, �sta es la que se enviar� en el Informe al padrino.<img src="../static/images/atencion.gif" width=10>
											</label>
										</td>
									</tr>	
								</c:if>	
								<tr>
									<td colspan="2"> 
										Nac� el: <fmt:formatDate value="${becado.datosPersonales.fechaNacimiento}" pattern="dd/MM/yyyy"/>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										Tengo: ${edad} a�os
									</td>
								</tr>
								<tr>	
									<td colspan="2">
										Vivo en: ${becado.datosPersonales.localidad.nombre}
									</td>
								</tr>
								
								<tr>	
									<td colspan="2">
										Curso: 
										<c:if test="${empty boletin}">
											${becado.anioEscolar.valor}
										</c:if>
										<c:if test="${!empty boletin}">
											${boletin.ano.valor}
										</c:if>
									</td>	
								</tr>		
								<c:if test="${!empty becado.responsable2}">
									<tr>
										<td colspan="2">
											Viene a las entrevistas:					
											${becado.responsable2.nombre }&nbsp;${becado.responsable2.apellido}
										</td>				
									</tr>
									<c:if test="${!empty becado.responsable2.idVinculo}">
										<tr>
											<td colspan="2">
												V&iacute;nculo 
												${becado.responsable2.idVinculo.valor}
											</td>
										</tr>
									</c:if>
								</c:if>
								<c:if test="${empty becado.responsable2}">
									<tr>
										<td colspan="2">
											Viene a las entrevistas:				
											${becado.responsable1.nombre }&nbsp;${becado.responsable1.apellido}
										</td>					
									</tr>
									<c:if test="${!empty becado.responsable1.idVinculo}">
										<tr>
											<td colspan="2">
												V&iacute;nculo: 
												${becado.responsable1.idVinculo.valor}
											</td>
										</tr>
									</c:if>
								</c:if>
								<tr>
									<td colspan="2">
										Fecha incorporaci�n al Programa: 
										${periodoFechaPBE}
									</td>
								</tr>	
								<c:if test="${!empty periodoFechaReincorporacionPBE}">
									<tr>
										<td colspan="2">
											Fecha reincorporaci�n al Programa 
											${periodoFechaReincorporacionPBE}
										</td>
									</tr>
								</c:if>	
								<tr>
									<td colspan="2"><h1 id="subtitulo-informe"><label>Mi escuela</label></h1></td>
								</tr>
								<tr>
									<td>
										<table width="200" border="0" align="left" cellpadding="0" cellspacing="0" id="table-forms"> 
											<c:if test="${empty escuela.modalidadTrabajoEscuela}">
												<tr>
													<td nowrap="nowrap">Nombre:</td>
													<td>
														<input type="text" class="required" readonly="readonly" size="100" style="border:0;" name="escuelaNombre"
															value="${becado.escuela.nombre}"/>
													</td>
												</tr>
												<tr>
													<td nowrap="nowrap">Modalidad de trabajo:</td>
													<td>
														<input type="text" class="required" readonly="readonly" size="45" style="border:0;" name="modalidadTrabajoEscuela"
															value="${becado.escuela.modalidadTrabajoEscuela}"></input>
													</td>
												</tr>
												<tr>
													<td nowrap="nowrap">El programa se implementa desde:</td>
													<td>
														<input type="text" class="required" readonly="readonly" size="45" style="border:0;" name="escuelaComienzoPBE"
															value="${becado.escuela.comienzoPBE.nombre}"/>
													</td>
												</tr>
												<tr>
													<td nowrap="nowrap">Matricula total:</td>
													<td>
														<input type="text" class="required" readonly="readonly" size="45" style="border:0;" name="escuelaMatricula"
															value="${becado.escuela.matricula}"/>
													</td>
												</tr>	
												<tr>
													<td nowrap="nowrap">Becados por Cimientos:</td>
													<td>
														<input type="text" class="required" readonly="readonly" size="45" style="border:0;" name="cantidadBecados"
															value="${cantidadBecadosCimiento}"/>
													</td>
												</tr>											
											</c:if>
											<c:if test="${!empty escuela.modalidadTrabajoEscuela.id && escuela.modalidadTrabajoEscuela.id == 1}">
												<tr>
													<td nowrap="nowrap">Nombre:</td>
													<td>
														<input type="text" class="required" readonly="readonly" size="100" style="border:0;" name="escuelaNombre"
															value="${becado.escuela.nombre}"/>
													</td>
												</tr>
												<tr>
													<td nowrap="nowrap">Modalidad de trabajo:</td>
													<td>
														<input type="text" class="required" readonly="readonly" size="45" style="border:0;" name="modalidadTrabajoEscuela"
															value="${becado.escuela.modalidadTrabajoEscuela.valor}"></input>
													</td>
												</tr>
												<tr>				
													<td colspan="2">
														<img src="../escuela/mostrarImagen.do" align="middle" width="90px" height="90px">
													</td>
												</tr>
												<tr>
													<td nowrap="nowrap">Becados por Cimientos:</td>
													<td>
														<input type="text" class="required" readonly="readonly" size="45" style="border:0;" name="cantidadBecados"
															value="${cantidadBecadosCimiento}"/>
													</td>
												</tr>							
											</c:if>		
											<c:if test="${!empty escuela.modalidadTrabajoEscuela.id && escuela.modalidadTrabajoEscuela.id != 1}">
												<tr>
													<td nowrap="nowrap">Nombre3:</td>
													<td>
														<input type="text" class="required" readonly="readonly" size="100" style="border:0;" name="escuelaNombre"
															value="${becado.escuela.nombre}"/>
													</td>
												</tr>
												<tr>
													<td nowrap="nowrap">Modalidad de trabajo:</td>
													<td>
														<input type="text" class="required" readonly="readonly" size="45" style="border:0;" name="modalidadTrabajoEscuela"
															value="${becado.escuela.modalidadTrabajoEscuela.valor}"></input>
													</td>
												</tr>
												<tr>
													<td nowrap="nowrap">El programa se implementa desde:</td>
													<td>
														<input type="text" class="required" readonly="readonly" size="45" style="border:0;" name="escuelaComienzoPBE"
															value="${becado.escuela.comienzoPBE.nombre}"/>
													</td>
												</tr>
												<tr>
													<td nowrap="nowrap">Matricula total:</td>
													<td>
														<input type="text" class="required" readonly="readonly" size="45" style="border:0;" name="escuelaMatricula"
															value="${becado.escuela.matricula}"/>
													</td>
												</tr>	
												<tr>
													<td nowrap="nowrap">Becados por Cimientos:</td>
													<td>
														<input type="text" class="required" readonly="readonly" size="45" style="border:0;" name="cantidadBecados"
															value="${cantidadBecadosCimiento}"/>
													</td>
												</tr>	
											</c:if>				
										</table>
									</td>
								</tr>
					
							<tr>
								<td colspan="2"><h1 id="subtitulo-informe"><label>Principal Habilidad Socio-Emocional trabajada en la segunda parte del a�o</label></h1></td>
							</tr>
							<tr>
								<td>					
									<input type="text" size="50" id="hsTrabajarA�o" name="hsTrabajarA�o" value="${hsTrabajarA�o}" readonly="readonly" style="border: 0;">		
								</td>
							</tr>	
							<c:if test="${becado.anioEscolar.id==13 || becado.anioEscolar.id==14 || becado.anioEscolar.id==15}">
								<tr>
									<td colspan="2"><h1 id="subtitulo-informe"><label>Proyecci�n post-escolar del alumno</label></h1></td>
								</tr>	
								<tr>
									<td colspan="2">
										<input type="text" size="50" id="sarpepe" name="sarpepe" value="${sarpepe}" readonly="readonly" style="border: 0;">	 
									</td>
								</tr>									
							</c:if>	
							<c:if test="${becado.anioEscolar.id!=13 && becado.anioEscolar.id!=14 && becado.anioEscolar.id!=15}">
								
									<td colspan="2">
										<input type="hidden" size="50" id="sarpepe" name="sarpepe" value="0" readonly="readonly" style="border: 0;">	 
									</td>
																	
							</c:if>				
							<tr>
								<td colspan="2">
									<input type="hidden" name="mensajePadrino" id="mensajePadrino" value="">
									<h1 id="subtitulo-informe"><label>Resultado A�o Escolar Diciembre</label></h1>
								</td>
							</tr>
							<tr>
								<td colspan="2" width="860">
									${informe.situacionRenovacion}
								</td>
							</tr>					
							<tr>
								<td colspan="2"><h1 id="subtitulo-informe"><label>Trabajo de acompa�amiento realizado durante la segunda parte del a�o</label></h1></td>
							</tr>
							<tr>
								<td colspan="2">
									<textarea cols="60" rows="5"  class="required" name="qtam" id="qtam" 
										onblur="eliminarEnter(this);chequearLongitudTextarea(this,10000);" 
										onkeypress="textareaSinEnter(event.keyCode,this);chequearLongitudTextarea(this,10000);"
										onkeyup="textareaSinEnter(event.keyCode,this);chequearLongitudTextarea(this,10000);">${qtam}</textarea>					
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<label>
										Debido al cambio de formato del IS3 la cantidad m�xima de caracteres que podr�s escribir en este campo es 10000.
									</label>
								</td>
							</tr>
							<tr>
								<td colspan="2"><h1 id="subtitulo-informe"><label>Observaciones sobre la trayectoria y asistencia</label></h1></td>
							</tr>		
							<tr>
								<td colspan="2">
									<textarea cols="60" rows="5"  name="osme" id="osme" >${osme}</textarea> 					 										
								</td>
							</tr>
							<tr>
								<td colspan="2"><h1 id="subtitulo-informe"><label>Aprendizajes, logros y oportunidades de mejora para continuar trabajando</label></h1></td>
							</tr>		
							<tr>
								<td colspan="2">
									<textarea cols="60" rows="5"  name="alo" id="alo" >${alo}</textarea> 					 										
								</td>
							</tr>		
							<c:choose>
								<c:when test="${estadoEntrevista != '3' && tieneSuspensiones == false}">
									<tr>
										<td colspan="2"><h1 id="subtitulo-informe"><label>Tuve suspensi�n de beca</label></h1></td>
									</tr>
									<tr>
										<td>
											<table width="200" border="0" align="left" cellpadding="0" cellspacing="0" id="table-forms"> 
												<tr>
													<td width="50">
														Cantidad:
													</td>
													<td>
														${informe.suspensionesCantidad}
													</td>
												</tr>
												<tr>
													<td>
														Mes/es:
													</td>
													<td>
														${informe.suspensionesPeriodo}
													</td>
												</tr>
												<tr>
													<td>
														Motivo/s:
													</td>
													<td width="800">
														${informe.suspensiones}
													</td>
												</tr>			
											</table>
										</td>
									</tr>						
								</c:when>											
								<c:when test="${estadoEntrevista == '3' && tieneSuspensiones == true}">
									<tr>
										<td colspan="2"><h1 id="subtitulo-informe"><label>Tuve suspensi�n de beca</label></h1></td>
									</tr>
									<tr>
										<td>
											<table width="200" border="0" align="left" cellpadding="0" cellspacing="0" id="table-forms"> 
												<tr>
													<td width="50">
														Cantidad:
													</td>
													<td>
														${informe.suspensionesCantidad}
													</td>
												</tr>
												<tr>
													<td>
														Mes/es:
													</td>
													<td>
														${informe.suspensionesPeriodo}
													</td>
												</tr>
												<tr>
													<td>
														Motivo/s:
													</td>
													<td width="800">
														${informe.suspensiones}
													</td>
												</tr>			
											</table>
										</td>
									</tr>						
								</c:when>						
							</c:choose>														
							<tr>
								<td colspan="2"><h1 id="subtitulo-informe"><label>Situaci�n renovaci�n</label></h1></td>
							</tr>
							<tr>
								<td colspan="2">
									${informe.evalRenovacionBeca}
								</td>
							</tr>
							<c:choose>
								<c:when test="${estadoEntrevista == '3' && evalRenovacionBeca == 'No renueva'}">
									<tr>
										<td colspan="2"><h1 id="subtitulo-informe"><label>Motivo no renovaci�n</label></h1></td>
									</tr>
									<tr>
										<td colspan="2">
											${informe.motivoNoRenovacion}
										</td>
									</tr>							
								</c:when>
								<c:when test="${estadoEntrevista != '3' && evalRenovacionBeca == 'No renueva'}">
									<tr>
										<td colspan="2"><h1 id="subtitulo-informe"><label>Motivo no renovaci�n</label></h1></td>
									</tr>							
									<tr>
										<td colspan="2">
											${informe.motivoNoRenovacion}
										</td>
									</tr>			
								</c:when>						
							</c:choose>							
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
					 	       <td colspan="2">
					 	       		<table align="left">
					 	       			<tr>
										  <td width="50" align="left" valign="middle">
									       	<center>
												<input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="history.back();" />
											</center>
									       </td>
					 	       			</tr>
					 	       		</table>			
						       </td>
						  </tr>
					</table>
				</td>
			</tr>												   
		</table>					
	</form>
</div>
</body>
</html>

