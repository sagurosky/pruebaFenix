<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>..:: Espacio de acompa�amiento Individual ::..</title>
<link rel="stylesheet" href="<c:url  value="/static/css/cimientos/jquery-ui-1.8.5.custom.css"/>"	media="all">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">

<link href="//cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@3/dark.css" rel="stylesheet">
</head>
<!-- body  onload="cargarDatos();"-->
<body>

<div class="container-fluid">

<div class="row">
	<div class="col-lg-2">
		<br>
		<div class="position-fixed">
			<img src="../fichaAlumno/mostrarImagen.do?dni=${alumno.datosPersonales.dni}" width="100px">	
			<br><br>	
			<div class="form-group">			
					<input type="button" class="btn btn-secondary" value="Construcci�n" 	onclick="guardar('c','${tipoPerfil}');">
			</div>
			<div class="form-group">				
					<c:if test="${tipoPerfil == 'rr'}">
						<input type="button" class="btn btn-secondary " value="Finalizar" class="ui-state-default ui-corner-all" onclick="guardarAprobar('f','${tipoPerfil}');" />
					</c:if>
					<c:if test="${tipoPerfil == 'ea'}">
						<input type="button" class="btn btn-secondary " value="Finalizar" class="ui-state-default ui-corner-all" onclick="guardarAprobar('f','${tipoPerfil}');" />
					</c:if>
														
					<c:if test="${tipoPerfil == 'superUsuario'}">
						<input type="button" class="btn btn-secondary" value="Finalizar" class="ui-state-default ui-corner-all" onclick="guardarAprobar('f','${tipoPerfil}');" />
					</c:if>
			</div>
			<div class="form-group">				
					<c:if test="${tipoPerfil == 'rr'}">
						<input type="button" class="btn btn-secondary " value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../entrevistas/listaEntrevistasAprobar.do'; return false;" />
					</c:if>
					<c:if test="${tipoPerfil == 'ea'}">
						<input type="button" class="btn btn-secondary" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../entrevistas/listarBecados.do'; return false;" />
					</c:if>	
					<c:if test="${tipoPerfil == 'superUsuario'}">
							<input type="button" class="btn btn-secondary" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../exportacionEntrevistas/verExportarEntrevistas.do'; return false;" />
					</c:if>	
				
			</div>
		</div>
	</div>
<div class="col-lg-10">

	<form:form id="altaEntrevistaIndividual" commandName="entrevista" modelAttribute="entrevista" cssClass="cmxform" method="post" action="guardar.do?alumnoId=${alumno.id}&EA=${ea}">
		
	
		<div class="card-body p-3 my-3 bg-secondary text-white">
		  <h3 title="IdAlumno=${alumno.id}">Espacio de acompa�amiento Individual - ${periodo.nombre} ${periodo.ciclo.nombre}  ${entrevista.periodoDePago.nombre} ${entrevista.periodoDePago.ciclo.nombre} - ${entrevista.estadoEntrevista.valor}<br>${alumno.datosPersonales.nombre}&nbsp;${alumno.datosPersonales.apellido}</h3>
			Fecha Incorporaci�n PFE: <fmt:formatDate value="${alumno.fechaPBE}" pattern="dd/MM/yyyy"/>
			<br>Escuela: ${alumno.escuela.nombre}<br>
			A�o Escolar: ${alumno.anioEscolar.valor} - 
			A�o Egreso:		
			<c:if test="${alumno.escuela.zonaCimientos.eae=='6/6'}">
		    	<c:if test="${alumno.anioAdicional}">
					${alumno.beca.ciclo.nombre+14-alumno.anioEscolar.id+1} 
				</c:if>
				<c:if test="${!alumno.anioAdicional}">
					${alumno.beca.ciclo.nombre+14-alumno.anioEscolar.id} 
				</c:if>
			</c:if>
			<c:if test="${alumno.escuela.zonaCimientos.eae=='7/5'}">
		    	<c:if test="${alumno.anioAdicional}">
					${alumno.beca.ciclo.nombre+13-alumno.anioEscolar.id+1} 
				</c:if>
				<c:if test="${!alumno.anioAdicional}">
					${alumno.beca.ciclo.nombre+13-alumno.anioEscolar.id} 
				</c:if>
			</c:if>	
			<c:if test="${alumno.anioAdicional==true}">
				 - Tiene a�o adicional
			</c:if>
			<c:if test="${alumno.anioAdicional==false}">
				- No tiene a�o adicional
			</c:if>			
			<br>
			
			<c:if test="${entrevista.excepcion==true}">
				 Renovado por excepci�n
			</c:if>
			<c:if test="${entrevista.excepcion==false}">
				
			</c:if>	
			
				
		</div>
		
		
	
		<c:if test="${boletin=='sinBoletin' && periodo.nombre=='Enero'}">						
			<table>	
				<tr>
					<td colspan="2"><b><img src="../static/images/atencion.gif" width=10><font color="red"  size="2">�Atenci�n! Deber�s cargar el primer trimestre completo del bolet�n para poder generar la entrevista de Enero.</font></b> </td>
				</tr>						
				<tr>
					<td colspan="2"><b><font color="red"  size="2"></font></b></td>
				</tr>	
				<tr><td></td></tr>
				<tr>
					<td  width="50">
						<center>
							<c:if test="${tipoPerfil == 'rr'}">
								<input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../entrevistas/listaEntrevistasAprobar.do'; return false;" />
							</c:if>
							<c:if test="${tipoPerfil == 'ea'}">
								<input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../entrevistas/listarBecados.do'; return false;" />
							</c:if>	
							<c:if test="${tipoPerfil == 'superUsuario'}">
									<input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../exportacionEntrevistas/verExportarEntrevistas.do'; return false;" />
							</c:if>	
						</center>
					</td>		
				</tr>	
			</table>
		</c:if>
		<c:if test="${boletin=='incompleto' && periodo.nombre=='Enero'}">						
			<table>	
				<tr>
					<td colspan="2"><b><img src="../static/images/atencion.gif" width=10><font color="red"  size="2">�Atenci�n! Te faltan completar notas en el primer trimestre del bolet�n para poder generar la entrevista de Enero.</font></b> </td>
				</tr>						
				<tr>
					<td colspan="2"><b><font color="red"  size="2"></font></b></td>
				</tr>	
				<tr><td></td></tr>
				<tr>
					<td  width="50">
						<center>
							<c:if test="${tipoPerfil == 'rr'}">
								<input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../entrevistas/listaEntrevistasAprobar.do'; return false;" />
							</c:if>
							<c:if test="${tipoPerfil == 'ea'}">
								<input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../entrevistas/listarBecados.do'; return false;" />
							</c:if>	
							<c:if test="${tipoPerfil == 'superUsuario'}">
									<input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../exportacionEntrevistas/verExportarEntrevistas.do'; return false;" />
							</c:if>	
						</center>
					</td>		
				</tr>
			</table>
		</c:if>
	
		<div class="card bg-info text-white">
			<div class="card-body">Datos Generales</div>
		</div>	
		<br>
		<c:if test="${periodo.nombre!='Enero'|| (boletin=='completo' && periodo.nombre=='Enero')}">	
			<c:if test="${entrevista.entrevistaGrupal != null}">
				<c:set var="isGrupal" value="true"></c:set>			
			</c:if>
			
			<c:if test="${entrevista.entrevistaGrupal == null}">
				<c:set var="isGrupal" value="false"></c:set>
			</c:if>	
			
			<c:if test="${periodo.nombre=='Enero'}">						
				<c:if test="${alumno.situacionEscolar=='PROMOVIDO_CON_PREVIAS'}">
					<img src="../static/images/atencion.gif" width=10>�Atenci�n! Record� actualizar el registro de materias previas para este alumno en su bolet�n del ciclo actual
					(si a�n no lo generaste, deber�s hacerlo desde tu panel)	
				</c:if>		 
			</c:if>				
							
	  		<div class="form-group form-inline">
		  		<label for="sel1" class="text-danger">Tipo encuentro<br>acompa�amiento &nbsp;&nbsp;</label>
		  		<select class="form-control" id="tipoEncuentroAcompanamiento" name="tipoEncuentroAcompanamiento" style='width:auto'>						
					<c:choose>
	   					<c:when test="${entrevista.tipoEncuentroAcompanamiento == 'Encuentro Individual'}">
	      						<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Encuentro Individual" selected="selected">Encuentro Individual</option>
							<option Value="Encuentro grupal">Encuentro grupal</option>									
							<option Value="Intercambio virtual" >Intercambio virtual</option>									
					    	<option Value="Otro">Otro</option>							    	
					    </c:when>																		
					    <c:when test="${entrevista.tipoEncuentroAcompanamiento == 'Encuentro grupal'}">
	      						<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Encuentro Individual">Encuentro Individual</option>
							<option Value="Encuentro grupal" selected="selected">Encuentro grupal</option>									
							<option Value="Intercambio virtual" >Intercambio virtual</option>									
					    	<option Value="Otro">Otro</option>								    	
					    </c:when>						
					    <c:when test="${entrevista.tipoEncuentroAcompanamiento == 'Intercambio virtual'}">
	      						<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Encuentro Individual">Encuentro Individual</option>
							<option Value="Encuentro grupal">Encuentro grupal</option>									
							<option Value="Intercambio virtual"  selected="selected">Intercambio virtual</option>									
					    	<option Value="Otro">Otro</option>								    	
					    </c:when>													    
					    <c:when test="${entrevista.tipoEncuentroAcompanamiento == 'Otro'}">
	      						<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Encuentro Individual">Encuentro Individual</option>
							<option Value="Encuentro grupal">Encuentro grupal</option>									
							<option Value="Intercambio virtual" >Intercambio virtual</option>									
					    	<option Value="Otro"  selected="selected">Otro</option>									    	
					    </c:when>	
					    <c:otherwise>
					    	<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Encuentro Individual" >Encuentro Individual</option>
							<option Value="Encuentro grupal">Encuentro grupal</option>									
							<option Value="Intercambio virtual" >Intercambio virtual</option>									
					    	<option Value="Otro">Otro</option>		
					    </c:otherwise>					
					</c:choose>
				<!--  /form:select-->		
				</select>	
			</div>
			
			<!-- div class="form-group form-inline">		
				<label for="sel1">Tuvo m�s de un Encuentro de acompa�amiento en el mes? &nbsp;&nbsp; </label>
				<select class="form-control" id="masDeUnEncuentro" name="masDeUnEncuentro" style='width:auto'>							
					<c:choose>
						<c:when test="${entrevista.masDeUnEncuentro == 'Si'}">
	       						<option value="0">Seleccione una opci&oacute;n:</option>
								<option value="Si" selected="selected">Si</option>
								<option value="No" >No</option>    	
					    </c:when>													    
					    <c:when test="${entrevista.masDeUnEncuentro == 'No'}">
	       						<option value="0">Seleccione una opci&oacute;n:</option>
								<option value="Si" >Si</option>
								<option value="No" selected="selected">No</option>    	
					    </c:when>									
					    <c:otherwise>
					    		<option value="0">Seleccione una opci&oacute;n:</option>
								<option value="Si" >Si</option>
								<option value="No" >No</option>
					    </c:otherwise>								
					</c:choose>									
				</select>
			</div-->
			
				
						
			<div class="form-group form-inline">
				<label class="text-danger">Particip� Becado &nbsp; &nbsp;</label>						
				<!-- form:checkbox path="participoBecado" id="participoBecado" onclick="habilitarCamposBecado(this)"/-->										
				<select class="form-control" id="participoBecado" name="participoBecado" style='width:auto'>							
					<c:choose>
						<c:when test="${entrevista.participoBecado == 'true'}">
								<option value="1" selected="selected">Si</option>
								<option value="0" >No</option>    	
					    </c:when>													    
					    <c:when test="${entrevista.participoBecado == 'false'}">       						
								<option value="1" >Si</option>
								<option value="0" selected="selected">No</option>    	
					    </c:when>													    								
					</c:choose>			
				</select>		
			</div>
						
			<div class="form-group form-inline">
				<label class="text-danger">Motivo Ausencia &nbsp;&nbsp;&nbsp;</label>			
				<select class="form-control" name="motivoAusencia" id="motivoAusencia" style='width:auto'>
				<!-- >form:select path="motivoAusencia" id="motivoAusencia" class="required"-->
					<c:choose>
	   					<c:when test="${entrevista.motivoAusencia == 'ENFERMEDAD'}">
	      						<option value=0>Seleccione una opci&oacute;n:</option>
							<option value=1 selected="selected">Razones de salud propia o de terceros</option>
							<option Value=2> in justificaci�n-se desconoce el motivo</option>
							<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
							<option Value=4 >Otros</option>
							<option Value=5 disabled="disabled">No corresponde</option>								
					    	<option Value=6>Cuidado-ayuda a terceros</option>
					    	<option Value=7>Motivos laborales</option>
					    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
					    	<option Value=9>Dificultades en el traslado</option>
					    	<option Value=10>Realizaci�n de tr�mites</option>
					    	<option Value=11>Factores clim�ticos</option>
					    	<option Value=12>Viaje a otra localidad</option>
					    	<option Value=13>No demuestra inter�s-compromiso</option>
					    </c:when>
					    <c:when test="${entrevista.motivoAusencia == 'EVENTUALIDAD'}">
	      						<option value=0>Seleccione una opci&oacute;n:</option>
							<option Value=1>Razones de salud propia o de terceros</option>
							<option Value=2  selected="selected">Sin justificaci�n-se desconoce el motivo</option>
							<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
							<option Value=4 >Otros</option>
							<option Value=5 disabled="disabled">No corresponde</option>								
					    	<option Value=6>Cuidado-ayuda a terceros</option>
					    	<option Value=7>Motivos laborales</option>
					    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
					    	<option Value=9>Dificultades en el traslado</option>
					    	<option Value=10>Realizaci�n de tr�mites</option>
					    	<option Value=11>Factores clim�ticos</option>
					    	<option Value=12>Viaje a otra localidad</option>
					    	<option Value=13>No demuestra inter�s-compromiso</option>
					    </c:when>
					    <c:when test="${entrevista.motivoAusencia == 'INASISTENCIA'}">
	      						<option value=0>Seleccione una opci&oacute;n:</option>
							<option Value=1>Razones de salud propia o de terceros</option>
							<option Value=2 selected="selected">Sin justificaci�n-se desconoce el motivo</option>
							<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
							<option Value=4 >Otros</option>
							<option Value=5 disabled="disabled">No corresponde</option>								
					    	<option Value=6>Cuidado-ayuda a terceros</option>
					    	<option Value=7>Motivos laborales</option>
					    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
					    	<option Value=9>Dificultades en el traslado</option>
					    	<option Value=10>Realizaci�n de tr�mites</option>
					    	<option Value=11>Factores clim�ticos</option>
					    	<option Value=12>Viaje a otra localidad</option>
					    	<option Value=13>No demuestra inter�s-compromiso</option>
					    </c:when>
					    <c:when test="${entrevista.motivoAusencia == 'CUIDADO'}">
	      						<option value=0>Seleccione una opci&oacute;n:</option>
							<option Value=1>Razones de salud propia o de terceros</option>
							<option Value=3 selected="selected">Sin justificaci�n-se desconoce el motivo</option>
							<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
							<option Value=4 >Otros</option>
							<option Value=5 disabled="disabled">No corresponde</option>								
					    	<option Value=6  selected="selected">Cuidado-ayuda a terceros</option>
					    	<option Value=7>Motivos laborales</option>
					    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
					    	<option Value=9>Dificultades en el traslado</option>
					    	<option Value=10>Realizaci�n de tr�mites</option>
					    	<option Value=11>Factores clim�ticos</option>
					    	<option Value=12>Viaje a otra localidad</option>
					    	<option Value=13>No demuestra inter�s-compromiso</option>
					    </c:when>
					    <c:when test="${entrevista.motivoAusencia == 'MOTIVOSLABORALES'}">
	      						<option value=0>Seleccione una opci&oacute;n:</option>
							<option Value=1>Razones de salud propia o de terceros</option>
							<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
							<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
							<option Value=4 >Otros</option>
							<option Value=5 disabled="disabled">No corresponde</option>								
					    	<option Value=6>Cuidado-ayuda a terceros</option>
					    	<option Value=7  selected="selected">Motivos laborales</option>
					    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
					    	<option Value=9>Dificultades en el traslado</option>
					    	<option Value=10>Realizaci�n de tr�mites</option>
					    	<option Value=11>Factores clim�ticos</option>
					    	<option Value=12>Viaje a otra localidad</option>
					    	<option Value=13>No demuestra inter�s-compromiso</option>
					    </c:when>
					    <c:when test="${entrevista.motivoAusencia == 'DESCONOCIMIENTO'}">
	      						<option value=0>Seleccione una opci&oacute;n:</option>
							<option Value=1>Razones de salud propia o de terceros</option>
							<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
							<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
							<option Value=4 >Otros</option>
							<option Value=5 disabled="disabled">No corresponde</option>								
					    	<option Value=6>Cuidado-ayuda a terceros</option>
					    	<option Value=7>Motivos laborales</option>
					    	<option Value=8 selected="selected">Desconocimiento, olvido o confusi�n fecha entrevista</option>
					    	<option Value=9>Dificultades en el traslado</option>
					    	<option Value=10>Realizaci�n de tr�mites</option>
					    	<option Value=11>Factores clim�ticos</option>
					    	<option Value=12>Viaje a otra localidad</option>
					    	<option Value=13>No demuestra inter�s-compromiso</option>
					    </c:when>
					    <c:when test="${entrevista.motivoAusencia == 'DIFICULTADES'}">
	      						<option value=0>Seleccione una opci&oacute;n:</option>
							<option Value=1>Razones de salud propia o de terceros</option>
							<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
							<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
							<option Value=4 >Otros</option>
							<option Value=5 disabled="disabled">No corresponde</option>								
					    	<option Value=6>Cuidado-ayuda a terceros</option>
					    	<option Value=7>Motivos laborales</option>
					    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
					    	<option Value=9  selected="selected">Dificultades en el traslado</option>
					    	<option Value=10>Realizaci�n de tr�mites</option>
					    	<option Value=11>Factores clim�ticos</option>
					    	<option Value=12>Viaje a otra localidad</option>
					    	<option Value=13>No demuestra inter�s-compromiso</option>
					    </c:when>
					    <c:when test="${entrevista.motivoAusencia == 'TRAMITES'}">
	      						<option value=0>Seleccione una opci&oacute;n:</option>
							<option Value=1>Razones de salud propia o de terceros</option>
							<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
							<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
							<option Value=4 >Otros</option>
							<option Value=5 disabled="disabled">No corresponde</option>								
					    	<option Value=6>Cuidado-ayuda a terceros</option>
					    	<option Value=7>Motivos laborales</option>
					    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
					    	<option Value=9>Dificultades en el traslado</option>
					    	<option Value=10 selected="selected">Realizaci�n de tr�mites</option>
					    	<option Value=11>Factores clim�ticos</option>
					    	<option Value=12>Viaje a otra localidad</option>
					    	<option Value=13>No demuestra inter�s-compromiso</option>
					    </c:when>
					    <c:when test="${entrevista.motivoAusencia == 'FACTORESCLIMATICOS'}">
	      						<option value=0>Seleccione una opci&oacute;n:</option>
							<option Value=1>Razones de salud propia o de terceros</option>
							<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
							<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
							<option Value=4 >Otros</option>
							<option Value=5 disabled="disabled">No corresponde</option>								
					    	<option Value=6>Cuidado-ayuda a terceros</option>
					    	<option Value=7>Motivos laborales</option>
					    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
					    	<option Value=9>Dificultades en el traslado</option>
					    	<option Value=10>Realizaci�n de tr�mites</option>
					    	<option Value=11 selected="selected">Factores clim�ticos</option>
					    	<option Value=12>Viaje a otra localidad</option>
					    	<option Value=13>No demuestra inter�s-compromiso</option>
					    </c:when>
					    <c:when test="${entrevista.motivoAusencia == 'VIAJEAOTRALOCALIDAD'}">
	      						<option value=0>Seleccione una opci&oacute;n:</option>
							<option Value=1>Razones de salud propia o de terceros</option>
							<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
							<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
							<option Value=4 >Otros</option>
							<option Value=5 disabled="disabled">No corresponde</option>								
					    	<option Value=6>Cuidado-ayuda a terceros</option>
					    	<option Value=7>Motivos laborales</option>
					    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
					    	<option Value=9>Dificultades en el traslado</option>
					    	<option Value=10>Realizaci�n de tr�mites</option>
					    	<option Value=11>Factores clim�ticos</option>
					    	<option Value=12 selected="selected">Viaje a otra localidad</option>
					    	<option Value=13>No demuestra inter�s-compromiso</option>
					    </c:when>
					    <c:when test="${entrevista.motivoAusencia == 'NODEMUESTRAINTERES'}">
	      						<option value=0>Seleccione una opci&oacute;n:</option>
							<option Value=1 selected="selected">Razones de salud propia o de terceros</option>
							<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
							<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
							<option Value=4 >Otros</option>
							<option Value=5 disabled="disabled">No corresponde</option>								
					    	<option Value=6>Cuidado-ayuda a terceros</option>
					    	<option Value=7>Motivos laborales</option>
					    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
					    	<option Value=9>Dificultades en el traslado</option>
					    	<option Value=10>Realizaci�n de tr�mites</option>
					    	<option Value=11>Factores clim�ticos</option>
					    	<option Value=12>Viaje a otra localidad</option>
					    	<option Value=13 selected="selected">No demuestra inter�s-compromiso</option>
					    </c:when>
					    <c:otherwise>
	      						<option value=0>Seleccione una opci&oacute;n:</option>
							<option Value=1>Razones de salud propia o de terceros</option>
							<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
							<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
							<option Value=4 >Otros</option>
							<option Value=5 disabled="disabled">No corresponde</option>								
					    	<option Value=6>Cuidado-ayuda a terceros</option>
					    	<option Value=7>Motivos laborales</option>
					    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
					    	<option Value=9>Dificultades en el traslado</option>
					    	<option Value=10>Realizaci�n de tr�mites</option>
					    	<option Value=11>Factores clim�ticos</option>
					    	<option Value=12>Viaje a otra localidad</option>
					    	<option Value=13>No demuestra inter�s-compromiso</option>
					    </c:otherwise>
					</c:choose>
				</select>
				<!-- /form:select-->
			</div>
			<div class="form-group form-inline">		
				<label>Otro Motivo &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>										
				<form:textarea path="otroMotivoAusencia" class="form-control" name="otroMotivoAusencia" id="otroMotivoAusencia" rows="4" style="width:270px" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
			</div>				
			
			<div class="form-group form-inline">
				<label class="text-danger">Participaci�n RA &nbsp;&nbsp;</label>
				<select  class="form-control"  id="motivoAusenciaRa2" name="motivoAusenciaRa2" style='width:auto'>
					<c:choose>
						<c:when test="${entrevista.motivoAusenciaRa2 == 'Presente'}">
	       						<option value='0'>Seleccione una opci&oacute;n:</option>
								<option value='Presente' selected="selected">Presente</option>
								<option value='Ausente' >Ausente</option>
								<option value='No fue convocado' >No fue convocado</option>    	
					    </c:when>													    
					    <c:when test="${entrevista.motivoAusenciaRa2 == 'Ausente'}">
	       						<option value='0'>Seleccione una opci&oacute;n:</option>
								<option value='Presente' >Presente</option>
								<option value='Ausente' selected="selected">Ausente</option>
								<option value='No fue convocado' >No fue convocado</option>    	
					    </c:when>								
					    <c:when test="${entrevista.motivoAusenciaRa2 == 'No fue convocado'}">
	       						<option value='0'>Seleccione una opci&oacute;n:</option>
								<option value='Presente' >Presente</option>
								<option value='Ausente' >Ausente</option>
								<option value='No fue convocado' selected="selected">No fue convocado</option>    	
					    </c:when>									
					    <c:otherwise>
					    		<option value='0'>Seleccione una opci&oacute;n:</option>
								<option value='Presente' >Presente</option>
								<option value='Ausente' >Ausente</option>
								<option value='No fue convocado'>No fue convocado</option>
					    </c:otherwise>								
					</c:choose>				
				</select>
			</div>

	
	<div class="card bg-info text-white">
			<div class="card-body">Datos Escolares</div>
	</div>
	<br>
	<c:if test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">
	<div class="form-group form-inline">
		<label class="text-danger">Actualizaci�n Situaci�n Escolar 2020 �Cu�l fue el resultado escolar del ciclo 2020? &nbsp;&nbsp;</label>
		<select  class="form-control"  id="motivoAusenciaRa2" name="motivoAusenciaRa2" style='width:auto'>
			<c:choose>
				<c:when test="${entrevista.motivoAusenciaRa2 == 'Promovido sin adeudar materias'}">
      						<option value='0'>Seleccione una opci&oacute;n:</option>
						<option value='Promovido sin adeudar materias' selected="selected">Promovido sin adeudar materias</option>
						<option value='Promovido con materias a rendir' >Promovido con materias a rendir</option>
						<option value='Repiti�'>Repiti�</option>    	
			    </c:when>													    
			    <c:when test="${entrevista.motivoAusenciaRa2 == 'Promovido con materias a rendir'}">
      						<option value='0'>Seleccione una opci&oacute;n:</option>
						<option value='Promovido sin adeudar materias' selected="selected">Promovido sin adeudar materias</option>
						<option value='Promovido con materias a rendir' >Promovido con materias a rendir</option>
						<option value='Repiti�'>Repiti�</option>    	
			    </c:when>								
			    <c:when test="${entrevista.motivoAusenciaRa2 == 'Repiti�'}">
      						<option value='0'>Seleccione una opci&oacute;n:</option>
						<option value='Promovido sin adeudar materias'>Promovido sin adeudar materias</option>
						<option value='Promovido con materias a rendir' >Promovido con materias a rendir</option>
						<option value='Repiti�'  selected="selected">Repiti�</option>      	
			    </c:when>									
			    <c:otherwise>
			    		<option value='0'>Seleccione una opci&oacute;n:</option>
						<option value='Promovido sin adeudar materias'>Promovido sin adeudar materias</option>
						<option value='Promovido con materias a rendir' >Promovido con materias a rendir</option>
						<option value='Repiti�'>Repiti�</option>  
			    </c:otherwise>								
			</c:choose>				
		</select>
	</div>
	</c:if>
	
	
	<div class="form-group">
		<label for="uname">Orientaci�n Escolar: ${alumno.escuela.modalidadEscolar.valor}</label>										
	</div>
	 
	<div class="form-group form-inline"> 
		<label for="uname">Inasistencias mensuales &nbsp;&nbsp;</label>
		<form:input path="cantidadInasistencias" class="form-control" name="cantidadInasistencias" id="cantidadInasistencias" onkeypress="return validarDecimal(event, this);" onchange="habilitarMotivoInasistencias(this)" size="5"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<label for="uname">Principal motivo de inasistencia &nbsp;&nbsp;</label>	
		
		<select class="form-control" name="motivoInasistenciaR" id="motivoInasistenciaR" style='width:auto'>
			<c:choose>
 				<c:when test="${entrevista.motivoInasistenciaR == 'Llegada tarde'}">
    				<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde" selected="selected">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Se qued� dormido/a'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a" selected="selected">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Cuidado-ayuda a terceros'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" selected="selected" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Dificultades en el traslado'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado" selected="selected">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Factores clim�ticos'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos" selected="selected">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Motivos laborales'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales" selected="selected">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Razones de salud propia'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia" selected="selected">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Viaje a otra localidad'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad" selected="selected">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Realizaci�n de tr�mites personales'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales" selected="selected">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Otro'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro" selected="selected">Otro</option>							    	
			    </c:when>		
			    <c:otherwise>
				    <option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>		
				</c:otherwise>
			</c:choose>
		</select>			
	</div>				
	
	
	<div class="card bg-info text-white">
			<div class="card-body">Acompa�amiento</div>
	</div>
	<br>	

	<c:if test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">
		<div class="form-group form-inline">
			<label>Evaluaci�n del compromiso del EP con el programa &nbsp;&nbsp;</label>			
			<select class="form-control" style='width:auto' id="ecabp" name="ecabp">					
				<c:if test="${entrevista.ecabp == 'Malo'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Malo" selected="selected">Malo</option>
					<option value="Regular">Regular</option>
					<option value="Bueno">Bueno</option>
					<option value="Muy Bueno">Muy Bueno</option>
					<option value="Excelente">Excelente</option>
				</c:if>
				<c:if test="${entrevista.ecabp == 'regular'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Malo">Malo</option>
					<option value="Regular" selected="selected">Regular</option>
					<option value="Bueno">Bueno</option>
					<option value="Muy Bueno">Muy Bueno</option>
					<option value="Excelente">Excelente</option>
				</c:if>
				<c:if test="${entrevista.ecabp == 'Bueno'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Malo">Malo</option>
					<option value="Regular">Regular</option>
					<option value="Bueno" selected="selected">Bueno</option>
					<option value="Muy Bueno">Muy Bueno</option>
					<option value="Excelente">Excelente</option>
				</c:if>
				<c:if test="${entrevista.ecabp == 'Muy Bueno'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Malo">Malo</option>
					<option value="Regular">Regular</option>
					<option value="Bueno">Bueno</option>
					<option value="Muy Bueno" selected="selected">Muy Bueno</option>
					<option value="Excelente">Excelente</option>
				</c:if>
				<c:if test="${entrevista.ecabp == 'Excelente'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Malo">Malo</option>
					<option value="Regular">Regular</option>
					<option value="Bueno">Bueno</option>
					<option value="Muy Bueno">Muy Bueno</option>
					<option value="Excelente" selected="selected">Excelente</option>
				</c:if>
				
				<c:if test="${entrevista.ecabp != 'Malo' && entrevista.ecabp != 'Regular'  && entrevista.ecabp != 'Bueno'  && entrevista.ecabp != 'Muy Bueno'  && entrevista.ecabp != 'Excelente'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Malo">Malo</option>
					<option value="Regular">Regular</option>
					<option value="Bueno">Bueno</option>
					<option value="Muy Bueno">Muy Bueno</option>
					<option value="Excelente">Excelente</option>
				</c:if>						
			</select>
		</div>			
		<div class="form-group form-inline">
			<label>Evaluaci�n del compromiso del RA con el programa &nbsp;&nbsp;</label>			
				<select id="vcrae" name="vcrae" style='width:auto' class="form-control">					
	  				<c:if test="${entrevista.vcrae == 'Malo'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="Malo" selected="selected">Malo</option>
						<option value="Regular">Regular</option>
						<option value="Bueno">Bueno</option>
						<option value="Muy Bueno">Muy Bueno</option>
						<option value="Excelente">Excelente</option>
					</c:if>
					<c:if test="${entrevista.vcrae == 'Regular'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="Malo">Malo</option>
						<option value="Regular" selected="selected">Regular</option>
						<option value="Bueno">Bueno</option>
						<option value="Muy Bueno">Muy Bueno</option>
						<option value="Excelente">Excelente</option>
					</c:if>
					<c:if test="${entrevista.vcrae == 'Bueno'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="Malo">Malo</option>
						<option value="Regular">Regular</option>
						<option value="Bueno" selected="selected">Bueno</option>
						<option value="Muy Bueno">Muy Bueno</option>
						<option value="Excelente">Excelente</option>
					</c:if>
					<c:if test="${entrevista.vcrae == 'Muy Bueno'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="Malo">Malo</option>
						<option value="Regular">Regular</option>
						<option value="Bueno">Bueno</option>
						<option value="Muy Bueno" selected="selected">Muy Bueno</option>
						<option value="Excelente">Excelente</option>
					</c:if>
					<c:if test="${entrevista.vcrae == 'Excelente'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="Malo">Malo</option>
						<option value="Regular">Regular</option>
						<option value="Bueno">Bueno</option>
						<option value="Muy Bueno">Muy Bueno</option>
						<option value="Excelente" selected="selected">Excelente</option>
					</c:if>					
					<c:if test="${entrevista.vcrae != 'Malo' && entrevista.vcrae != 'Regular'  && entrevista.vcrae != 'Bueno'  && entrevista.vcrae != 'Muy Bueno'  && entrevista.vcrae != 'Excelente'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="Malo">Malo</option>
						<option value="Regular">Regular</option>
						<option value="Bueno">Bueno</option>
						<option value="Muy Bueno">Muy Bueno</option>
						<option value="Excelente">Excelente</option>
					</c:if>						
				</select>		
		</div>		
	</c:if>
	
	
	<c:if test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">
		<div class="form-group form-inline">
			<label> Seguimiento del prop�sito anual y desaf�os a trabajar en el segundo semestre &nbsp;&nbsp;</label>			
			<form:textarea path="propositoAnual" class="form-control"  id="propositoAnual" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>										
		</div>
		
		<div class="form-group form-inline">
			<label class="text-danger">�Qu� trabajaste en el acompa�amiento<br>en esta primer parte del a�o? &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>			
			<form:textarea path="qtam" class="form-control"  id="qtam" name="qtam" rows="4" cols="50" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/> &nbsp;&nbsp;	
			<font size="1">Atenci�n. Este campo va al Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>		
		</div>
	</c:if>
	
	<div class="form-group form-inline">
		<c:choose>
		   	<c:when test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">
				<label class="text-danger">Observaciones sobre rendimiento escolar<br>y asistencia en esta primera parte del a�o  &nbsp;&nbsp;</label>					
			</c:when>
			<c:otherwise>		
				<label class="text-danger">Observaciones sobre rendimiento escolar<br>y asistencia &nbsp;&nbsp;</label>					
			</c:otherwise>
		</c:choose>
		<form:textarea path="osme" class="form-control" id="osme" rows="4" cols="50" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/> &nbsp;&nbsp;	
		<c:if test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">
			<font size="1">Atenci�n. Este campo va al Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
		</c:if>
	</div>
	
		
	<div class="form-group form-inline">
		<c:choose>
		   	<c:when test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">
				<label class="text-danger">Principal HSE trabajada en esta primer parte del a�o  &nbsp;&nbsp;</label>		
			</c:when>
			<c:otherwise>
				<label class="text-danger">Principal HSE trabajada &nbsp;&nbsp;</label>
			</c:otherwise>		
		</c:choose>	
		<select  name="hsTrabajarA�o" id="hsTrabajarA�o" style='width:auto' class="form-control"> 
			<c:choose>
  				<c:when test="${entrevista.hsTrabajarA�o == 'Autoconcepto,0'}">
    				<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Autoconcepto" selected="selected">Autoconcepto</option>
					<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
					<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
					<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
			    	<option Value="Toma de decisiones">Toma de decisiones</option>
			    	<option Value="Otra">Otra</option>				    	  						    
			    </c:when>	
			    <c:when test="${entrevista.hsTrabajarA�o == 'Planificaci�n y organizaci�n del tiempo,0'}">
    				<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Autoconcepto" >Autoconcepto</option>
					<option Value="Planificaci�n y organizaci�n del tiempo" selected="selected">Planificaci�n y organizaci�n del tiempo</option>									
					<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
					<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
			    	<option Value="Toma de decisiones">Toma de decisiones</option>
			    	<option Value="Otra">Otra</option>				    	  						    
			    </c:when>	
			    <c:when test="${entrevista.hsTrabajarA�o == 'Relaciones interpersonales,0'}">
    				<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Autoconcepto">Autoconcepto</option>
					<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
					<option Value="Relaciones interpersonales"  selected="selected">Relaciones interpersonales</option>
					<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
			    	<option Value="Toma de decisiones">Toma de decisiones</option>
			    	<option Value="Otra">Otra</option>				    	  						    
			    </c:when>	
			    <c:when test="${entrevista.hsTrabajarA�o == 'Responsabilidad y autonom�a,0'}">
     				<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Autoconcepto">Autoconcepto</option>
					<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
					<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
					<option Value="Responsabilidad y autonom�a" selected="selected">Responsabilidad y autonom�a</option>								
			    	<option Value="Toma de decisiones">Toma de decisiones</option>
			    	<option Value="Otra">Otra</option>				    	  						    
			    </c:when>	
			    <c:when test="${entrevista.hsTrabajarA�o == 'Toma de decisiones,0'}">
     				<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Autoconcepto">Autoconcepto</option>
					<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
					<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
					<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
			    	<option Value="Toma de decisiones" selected="selected">Toma de decisiones</option>
			    	<option Value="Otra">Otra</option>				    	  						    
			    </c:when>					    
			    <c:when test="${entrevista.hsTrabajarA�o == 'Otra,0'}">
     				<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Autoconcepto">Autoconcepto</option>
					<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
					<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
					<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
			    	<option Value="Toma de decisiones" >Toma de decisiones</option>
			    	<option Value="Otra" selected="selected">Otra</option>				    	  						    
			    </c:when>
			   	<c:otherwise>
			    	<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Autoconcepto">Autoconcepto</option>
					<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
					<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
					<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
			    	<option Value="Toma de decisiones">Toma de decisiones</option>
			    	<option Value="Otra">Otra</option>		
			    </c:otherwise>		
			</c:choose>
		</select>
		<div class="form-group form-inline">		
			<label>&nbsp;&nbsp;Otra&nbsp; &nbsp;</label>										
			<form:textarea path="observacionesGenerales" class="form-control" name="observacionesGenerales" id="observacionesGenerales" rows="4" style="width:270px" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
		</div>
		
		
		
	</div>
		
	<div class="form-group form-inline">
		<c:choose>
			<c:when test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">
				<label>Principales Contenidos trabajados en esta primer parte del a�o  &nbsp;&nbsp;</label>
			</c:when>
			<c:otherwise>			
				<label>Principal Contenido trabajado &nbsp;&nbsp;</label>
			</c:otherwise>
		</c:choose>	
				<form:select path="contenidosTrabajarEnElAnio" style='width:auto' class="form-control">
				<form:options items="${contenidosTrabajarEnElAnio}" itemLabel="valor" itemValue="id"/>				
		</form:select>
	</div>
	
	<div class="form-group form-inline">
		<label>Otro contenido trabajado &nbsp;&nbsp;</label>										
		<form:input path="motivoInasistencia" id="motivoInasistencia"  class="form-control" style="width:500px;"/>
	</div>
	
	<c:if test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">	
		<div class="form-group form-inline">	
			<label class="text-danger">�Usaste el fichero en esta primer parte del a�o? &nbsp;&nbsp;</label>			
			<form:checkbox path="usasteFichero" id="usasteFichero" style='width:auto' class="form-control"/>
		</div>
		<div class="form-group form-inline">	
			<label class="text-danger">�Completaste la br�jula con el EP en esta primer parte del a�o? &nbsp;&nbsp;</label>			
			<form:checkbox path="brujula" id="brujula" style='width:auto' class="form-control" />
		</div>
		<div class="form-group form-inline">	
			<label class="text-danger">�El EP particip� del Apoyo Escolar Virtual? &nbsp;&nbsp;</label>			
			<form:checkbox path="brujula" id="brujula" style='width:auto' class="form-control" />
		</div>
	</c:if>
	
	<!-- ESTO SOLO ES PARA LOS EGRESADOS -->
		
		<c:set var="egreso" value="${0}"/>
		<c:if test="${alumno.escuela.zonaCimientos.eae=='6/6'}">
	    	<c:if test="${alumno.anioAdicional}">
				<c:set var="egreso" value="${alumno.beca.ciclo.nombre+14-alumno.anioEscolar.id+1}" />
				
			</c:if>
			<c:if test="${!alumno.anioAdicional}">
				
				<c:set var="egreso" value="${alumno.beca.ciclo.nombre+14-alumno.anioEscolar.id}" />
			</c:if>
		</c:if>
		<c:if test="${alumno.escuela.zonaCimientos.eae=='7/5'}">
	    	<c:if test="${alumno.anioAdicional}">
				
				<c:set var="egreso" value="${alumno.beca.ciclo.nombre+13-alumno.anioEscolar.id+1}" />
			</c:if>
			<c:if test="${!alumno.anioAdicional}">
				<c:set var="egreso" value="${alumno.beca.ciclo.nombre+13-alumno.anioEscolar.id}" />
			</c:if>
		</c:if>
		<input type="hidden" id="anioEgreso" name="anioEgreso" value="${egreso}">
		<c:if test="${(egreso==2021 || egreso==2022) && (entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio') }">
			<div class="card bg-light text-dark">
    			<div class="card-body">Egreso: ${egreso} 						
					<div class="form-group form-inline">
						<label class="text-danger">Proyecci�n post-escolar del EP  &nbsp;&nbsp;</label>	
						<select id="sarpepe" name="sarpepe" style='width:auto' class="form-control">				
			  					<c:if test="${entrevista.sarpepe == 'Tiene pensado estudiar'}">
								<option value="0" >Seleccione una opci�n</option>
								<option value="Tiene pensado estudiar" selected="selected">Tiene pensado estudiar</option>
								<option value="Tiene pensado estudiar y trabajar">Tiene pensado estudiar y trabajar</option>
								<option value="Tiene pensado trabajar">Tiene pensado trabajar</option>
								<option value="Aun no lo sabe">Aun no lo sabe</option>
							</c:if>
							<c:if test="${entrevista.sarpepe == 'Tiene pensado estudiar y trabajar'}">
								<option value="0" >Seleccione una opci�n</option>
								<option value="Tiene pensado estudiar">Tiene pensado estudiar</option>
								<option value="Tiene pensado estudiar y trabajar" selected="selected">Tiene pensado estudiar y trabajar</option>
								<option value="Quiere trabajar">Quiere trabajar</option>
								<option value="Aun no lo sabe">Aun no lo sabe</option>
							</c:if>
							<c:if test="${entrevista.sarpepe == 'Tiene pensado trabajar'}">
								<option value="0" >Seleccione una opci�n</option>
								<option value="Tiene pensado estudiar">Tiene pensado estudiar</option>
								<option value="Tiene pensado estudiar y trabajar">Tiene pensado estudiar y trabajar</option>
								<option value="Tiene pensado trabajar"  selected="selected">Tiene pensado trabajar</option>
								<option value="Aun no lo sabe">Aun no lo sabe</option>
							</c:if>
							<c:if test="${entrevista.sarpepe == 'Aun no lo sabe'}">
								<option value="0" >Seleccione una opci�n</option>
								<option value="Tiene pensado estudiar">Tiene pensado estudiar</option>
								<option value="Tiene pensado estudiar y trabajar">Tiene pensado estudiar y trabajar</option>
								<option value="Tiene pensado trabajar">Tiene pensado trabajar</option>
								<option value="Aun no lo sabe" selected="selected">Aun no lo sabe</option>
							</c:if>
							<c:if test="${entrevista.sarpepe != 'Tiene pensado estudiar' && entrevista.sarpepe != 'Tiene pensado estudiar y trabajar' 
									&& entrevista.sarpepe != 'Tiene pensado trabajar' && entrevista.sarpepe != 'Aun no lo sabe'}">
								<option value="0" >Seleccione una opci�n</option>
									<option value="Tiene pensado estudiar">Tiene pensado estudiar</option>
									<option value="Tiene pensado estudiar y trabajar">Tiene pensado estudiar y trabajar</option>
									<option value="Tiene pensado trabajar">Tiene pensado trabajar</option>
									<option value="Aun no lo sabe">Aun no lo sabe</option>
							</c:if>				
						</select>
					</div>
					
					<div class="form-group form-inline">					
						<label>En caso de que quiera estudiar, �qu� tipo de estudios?  &nbsp;&nbsp;</label>			
						<select id="te" name="te" style='width:auto' class="form-control">				
			  					<c:if test="${entrevista.te == 'Universitarios'}">
								<option value="0" >Seleccione una opci�n</option>
								<option value="Universitarios" selected="selected">Universitarios</option>
								<option value="Terciarios">Terciarios</option>
								<option value="Curso-oficio">Curso-oficio</option>
								<option value="Aun no lo sabe">Aun no lo sabe</option>
							</c:if>
							<c:if test="${entrevista.te == 'Terciarios'}">
								<option value="0" >Seleccione una opci�n</option>
								<option value="Universitarios">Universitarios</option>
								<option value="Terciarios" selected="selected">Terciarios</option>
								<option value="Curso-oficio">Curso-oficio</option>
								<option value="Aun no lo sabe">Aun no lo sabe</option>
							</c:if>
							<c:if test="${entrevista.te == 'Curso-oficio'}">
								<option value="0" >Seleccione una opci�n</option>
								<option value="Universitarios">Universitarios</option>
								<option value="Terciarios">Terciarios</option>
								<option value="Curso-oficio" selected="selected">Curso-oficio</option>
								<option value="Aun no lo sabe">Aun no lo sabe</option>
							</c:if>
							<c:if test="${entrevista.te == 'Aun no lo sabe'}">
								<option value="0" >Seleccione una opci�n</option>
								<option value="Universitarios">Universitarios</option>
								<option value="Terciarios" selected="selected">Terciarios</option>
								<option value="Curso-oficio">Curso-oficio</option>
								<option value="Aun no lo sabe"  selected="selected">Aun no lo sabe</option>
							</c:if>
							<c:if test="${entrevista.te != 'Si' && entrevista.te != 'No' }">
								<option value="0" >Seleccione una opci�n</option>
									<option value="Universitarios">Universitarios</option>
									<option value="Terciarios">Terciarios</option>
									<option value="Curso-oficio">Curso-oficio</option>
									<option value="Aun no lo sabe">Aun no lo sabe</option>
							</c:if>				
						</select>			
					</div>
					
					<div class="form-group form-inline">
						<label>Especificar �rea de estudios, si lo sabe &nbsp;&nbsp;</label>								
						<select id="ie" name="ie" style='width:auto' class="form-control">				
			  				<c:choose>
			   					<c:when test="${entrevista.ie == 'Agronom�a'}">
									<option value="0" >Seleccione una opci�n</option>
									<option value="Agronom�a" selected="selected">Agronom�a</option>
									<option value="Arquitectura">Arquitectura</option>
									<option value="Ciencias Econ�micas, marketing y negocios">Ciencias Econ�micas, marketing y negocios</option>
									<option value="Ciencias exactas y naturales">Ciencias exactas y naturales</option>
									<option value="Ciencias sociales, arte y humanidades">Ciencias sociales, arte y humanidades</option>
									<option value="Derecho">Derecho</option>
									<option value="Ingenier�a">Ingenier�a</option>
									<option value="Medicina y Ciencias de la salud">Medicina y Ciencias de la salud</option>
									<option value="Psicolog�a">Psicolog�a</option>
									<option value="Otra">Otra</option>
								</c:when>
								<c:when test="${entrevista.ie == 'Arquitectura'}">
									<option value="0" >Seleccione una opci�n</option>
									<option value="Agronom�a">Agronom�a</option>
									<option value="Arquitectura"  selected="selected">Arquitectura</option>
									<option value="Ciencias Econ�micas, marketing y negocios">Ciencias Econ�micas, marketing y negocios</option>
									<option value="Ciencias exactas y naturales">Ciencias exactas y naturales</option>
									<option value="Ciencias sociales, arte y humanidades">Ciencias sociales, arte y humanidades</option>
									<option value="Derecho">Derecho</option>
									<option value="Ingenier�a">Ingenier�a</option>
									<option value="Medicina y Ciencias de la salud">Medicina y Ciencias de la salud</option>
									<option value="Psicolog�a">Psicolog�a</option>
									<option value="Otra">Otra</option>
								</c:when>
								<c:when test="${entrevista.ie == 'Ciencias Econ�micas, marketing y negocios'}">
									<option value="0" >Seleccione una opci�n</option>
									<option value="Agronom�a">Agronom�a</option>
									<option value="Arquitectura">Arquitectura</option>
									<option value="Ciencias Econ�micas, marketing y negocios"  selected="selected">Ciencias Econ�micas, marketing y negocios</option>
									<option value="Ciencias exactas y naturales">Ciencias exactas y naturales</option>
									<option value="Ciencias sociales, arte y humanidades">Ciencias sociales, arte y humanidades</option>
									<option value="Derecho">Derecho</option>
									<option value="Ingenier�a">Ingenier�a</option>
									<option value="Medicina y Ciencias de la salud">Medicina y Ciencias de la salud</option>
									<option value="Psicolog�a">Psicolog�a</option>
									<option value="Otra">Otra</option>
								</c:when>
								<c:when test="${entrevista.ie == 'Ciencias exactas y naturales'}">
									<option value="0" >Seleccione una opci�n</option>
									<option value="Agronom�a">Agronom�a</option>
									<option value="Arquitectura">Arquitectura</option>
									<option value="Ciencias Econ�micas, marketing y negocios">Ciencias Econ�micas, marketing y negocios</option>
									<option value="Ciencias exactas y naturales" selected="selected">Ciencias exactas y naturales</option>
									<option value="Ciencias sociales, arte y humanidades">Ciencias sociales, arte y humanidades</option>
									<option value="Derecho">Derecho</option>
									<option value="Ingenier�a">Ingenier�a</option>
									<option value="Medicina y Ciencias de la salud">Medicina y Ciencias de la salud</option>
									<option value="Psicolog�a">Psicolog�a</option>
									<option value="Otra">Otra</option>
								</c:when>
								<c:when test="${entrevista.ie == 'Ciencias sociales, arte y humanidades'}">
									<option value="0" >Seleccione una opci�n</option>
									<option value="Agronom�a">Agronom�a</option>
									<option value="Arquitectura">Arquitectura</option>
									<option value="Ciencias Econ�micas, marketing y negocios">Ciencias Econ�micas, marketing y negocios</option>
									<option value="Ciencias exactas y naturales">Ciencias exactas y naturales</option>
									<option value="Ciencias sociales, arte y humanidades" selected="selected">Ciencias sociales, arte y humanidades</option>
									<option value="Derecho">Derecho</option>
									<option value="Ingenier�a">Ingenier�a</option>
									<option value="Medicina y Ciencias de la salud">Medicina y Ciencias de la salud</option>
									<option value="Psicolog�a">Psicolog�a</option>
									<option value="Otra">Otra</option>
								</c:when>
								<c:when test="${entrevista.ie == 'Derecho'}">
									<option value="0" >Seleccione una opci�n</option>
									<option value="Agronom�a">Agronom�a</option>
									<option value="Arquitectura">Arquitectura</option>
									<option value="Ciencias Econ�micas, marketing y negocios">Ciencias Econ�micas, marketing y negocios</option>
									<option value="Ciencias exactas y naturales">Ciencias exactas y naturales</option>
									<option value="Ciencias sociales, arte y humanidades">Ciencias sociales, arte y humanidades</option>
									<option value="Derecho" selected="selected">Derecho</option>
									<option value="Ingenier�a">Ingenier�a</option>
									<option value="Medicina y Ciencias de la salud">Medicina y Ciencias de la salud</option>
									<option value="Psicolog�a">Psicolog�a</option>
									<option value="Otra">Otra</option>
								</c:when>
								<c:when test="${entrevista.ie == 'Ingenier�a'}">
									<option value="0" >Seleccione una opci�n</option>
									<option value="Agronom�a">Agronom�a</option>
									<option value="Arquitectura">Arquitectura</option>
									<option value="Ciencias Econ�micas, marketing y negocios">Ciencias Econ�micas, marketing y negocios</option>
									<option value="Ciencias exactas y naturales">Ciencias exactas y naturales</option>
									<option value="Ciencias sociales, arte y humanidades">Ciencias sociales, arte y humanidades</option>
									<option value="Derecho">Derecho</option>
									<option value="Ingenier�a" selected="selected">Ingenier�a</option>
									<option value="Medicina y Ciencias de la salud">Medicina y Ciencias de la salud</option>
									<option value="Psicolog�a">Psicolog�a</option>
									<option value="Otra">Otra</option>
								</c:when>
								<c:when test="${entrevista.ie == 'Medicina y Ciencias de la salud'}">
									<option value="0" >Seleccione una opci�n</option>
									<option value="Agronom�a">Agronom�a</option>
									<option value="Arquitectura">Arquitectura</option>
									<option value="Ciencias Econ�micas, marketing y negocios">Ciencias Econ�micas, marketing y negocios</option>
									<option value="Ciencias exactas y naturales">Ciencias exactas y naturales</option>
									<option value="Ciencias sociales, arte y humanidades">Ciencias sociales, arte y humanidades</option>
									<option value="Derecho">Derecho</option>
									<option value="Ingenier�a">Ingenier�a</option>
									<option value="Medicina y Ciencias de la salud" selected="selected">Medicina y Ciencias de la salud</option>
									<option value="Psicolog�a">Psicolog�a</option>
									<option value="Otra">Otra</option>
								</c:when>
								<c:when test="${entrevista.ie == 'Psicolog�a'}">
									<option value="0" >Seleccione una opci�n</option>
									<option value="Agronom�a">Agronom�a</option>
									<option value="Arquitectura">Arquitectura</option>
									<option value="Ciencias Econ�micas, marketing y negocios">Ciencias Econ�micas, marketing y negocios</option>
									<option value="Ciencias exactas y naturales">Ciencias exactas y naturales</option>
									<option value="Ciencias sociales, arte y humanidades">Ciencias sociales, arte y humanidades</option>
									<option value="Derecho">Derecho</option>
									<option value="Ingenier�a">Ingenier�a</option>
									<option value="Medicina y Ciencias de la salud">Medicina y Ciencias de la salud</option>
									<option value="Psicolog�a" selected="selected">Psicolog�a</option>
									<option value="Otra">Otra</option>
								</c:when>
								<c:when test="${entrevista.ie == 'Otra'}">
									<option value="0" >Seleccione una opci�n</option>
									<option value="Agronom�a" selected="selected">Agronom�a</option>
									<option value="Arquitectura">Arquitectura</option>
									<option value="Ciencias Econ�micas, marketing y negocios">Ciencias Econ�micas, marketing y negocios</option>
									<option value="Ciencias exactas y naturales">Ciencias exactas y naturales</option>
									<option value="Ciencias sociales, arte y humanidades">Ciencias sociales, arte y humanidades</option>
									<option value="Derecho">Derecho</option>
									<option value="Ingenier�a">Ingenier�a</option>
									<option value="Medicina y Ciencias de la salud">Medicina y Ciencias de la salud</option>
									<option value="Psicolog�a">Psicolog�a</option>
									<option value="Otra" selected="selected">Otra</option>
								</c:when>					
								<c:otherwise>
									<option value="0" >Seleccione una opci�n</option>
									<option value="Agronom�a">Agronom�a</option>
									<option value="Arquitectura">Arquitectura</option>
									<option value="Ciencias Econ�micas, marketing y negocios">Ciencias Econ�micas, marketing y negocios</option>
									<option value="Ciencias exactas y naturales">Ciencias exactas y naturales</option>
									<option value="Ciencias sociales, arte y humanidades">Ciencias sociales, arte y humanidades</option>
									<option value="Derecho">Derecho</option>
									<option value="Ingenier�a">Ingenier�a</option>
									<option value="Medicina y Ciencias de la salud">Medicina y Ciencias de la salud</option>
									<option value="Psicolog�a">Psicolog�a</option>
									<option value="Otra">Otra</option>
								</c:otherwise>	
							</c:choose>					
						</select>						
					</div>
					
					<div class="form-group form-inline">
						<label>Especificar nombre de Estudios o Carrera que le interesa</label>	
						<form:input path="ie" id="ie"  style="width:auto;" class="form-control"/>
					</div>	
					<div class="form-group form-inline">
						<label>Si ya lo tiene definido, especificar Instituci�n</label>	
						<form:input path="facebook" id="facebook"  style="width:auto;" class="form-control"/>
					</div>				
					
					<div class="form-group form-inline">	
						<label class="text-danger">�Tiene su CV armado?  &nbsp;&nbsp;</label>
						<form:checkbox path="cv" id="cv" style='width:auto' class="form-control"/>
					
						<label class="text-danger">&nbsp;&nbsp; Celular  &nbsp;&nbsp;</label>										
						<form:input path="celular" id="celular"  style="width:auto;" class="form-control"/>					
					</div>
					<div class="form-group form-inline">
						<label>Correo electr�nico &nbsp;&nbsp;</label>
						<form:input path="dirMail" class="form-control" name="dirMail" id="dirMail" style="width:500px;" />				
					
					</div>
				</div>
			</div>
		</c:if>
	
		<c:if test="${egreso!=2021 && egreso!=2022 }">
			<input type="hidden" id="sarpepe" value="0">
			<input type="hidden" id="te" value="0">
			<input type="hidden" id="ie" value="">
			<input type="hidden" id="cv" value="0">
			<input type="hidden" id="celular" name="celular" value="">										
		</c:if>		
		
	</c:if>
	
	<c:if test="${entrevista.entrevistaGrupal != null}">					
		<div class="form-group form-inline">
			<c:set var="isGrupal" value="true"></c:set>
				<c:choose>
			   		<c:when test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">
						<label class="text-danger">Objetivo del encuentro de julio y actividad implementada &nbsp;&nbsp;</label>												   					
					</c:when>
					<c:otherwise>				
						<label class="text-danger">Objetivo del encuentro y actividad implementada &nbsp;&nbsp;</label>												   					
					</c:otherwise>
				</c:choose>
				<textarea rows="4" cols="50" id="objetivoEncuentro" name="objetivoEncuentro"    class="form-control">${entrevista.objetivoEncuentro}</textarea> 
		</div>
	</c:if>
	
	<c:if test="${entrevista.entrevistaGrupal == null}">			
		<div class="form-group form-inline">
			<c:choose>
		   		<c:when test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">
					<label class="text-danger">Objetivo del encuentro de julio y actividad implementada &nbsp;&nbsp;</label>												   					
				</c:when>
				<c:otherwise>				
					<label class="text-danger">Objetivo del encuentro y actividad implementada &nbsp;&nbsp;</label>												   					
				</c:otherwise>
			</c:choose>
			<textarea rows="4" cols="50" id="objetivoEncuentro" name="objetivoEncuentro"   class="form-control">${entrevista.objetivoEncuentro}</textarea> 		
		</div>
	</c:if>
	
	<div class="form-group form-inline">
		<label>Situaci�n de Riesgo extra-escolar &nbsp;&nbsp;</label>						
		<form:select path="situacionCrisis" style='width:auto' class="form-control">
			<form:options items="${situacionCrisis}" itemLabel="valor" itemValue="id"/>				
		</form:select>							
	</div>
	
	<div class="form-group form-inline">
		<label>Situacion de Riesgo &nbsp;&nbsp;</label>						
		<form:select path="situacionCrisis" style='width:auto' class="form-control">
			<form:options items="${situacionCrisis}" itemLabel="valor" itemValue="id"/>				
		</form:select>							
	</div>
		
	<c:if test="${entrevista.periodoDePago.nombre!='Julio' && periodo.nombre!='Julio'}">			
		<input type="hidden" name="corroboradoBoletin" id="corroboradoBoletin"  value="No"/>
		<input type="hidden" name="situacionCrisis" id="situacionCrisis" value="">									
		<input type="hidden" name="ossr" id="ossr" value="">				
		<input type="hidden" name="dirMail" id="dirMail"  value=""/>					
		<input type="hidden" name="facebook" id="facebook"  value=""/>				
		<input type="hidden" name="sarpepe" id="sarpepe"  value=""/>		
		<input type="hidden" name="celular" id="celular"  value=""/>			
		<input type="hidden" name="hsTrabajarA�o" id="hsTrabajarA�o" value="0"/>													
	</c:if>
		
	<div class="form-group form-inline">
		<label>Ampliar informaci�n sobre la situaci�n de riesgo seleccionada &nbsp;&nbsp;</label>				
		<form:textarea path="ossr" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);" style='width:auto' class="form-control"/>
	</div>	
	
	<c:if test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">	
		<input type="hidden" id="osare" name="osare" value="">							
	</c:if>
	
	<c:if test="${!entrevista.periodoDePago.nombre=='Julio' || !periodo.nombre=='Julio' }">	
		<label>Observac.sobre alumnos<br>renovados p/excepci�n</label>			
		<form:textarea path="osare" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
	</c:if>
	
	
	
	<div class="form-group form-inline">
		<label>Evaluacion Cobro de Beca  &nbsp;&nbsp;</label>		
		<form:select style='width:auto' path="evaluacionCobroBeca" id="evaluacionCobroBeca" class="form-control">
		<form:option value="">Seleccione una opci�n...</form:option>
		<form:options items="${evaluacionCobroBeca}" itemLabel="valor" itemValue="id"/>				
		</form:select>
		
	</div>	
	
	<div class="form-group form-inline">	
		<label>Motivo de Suspensi�n  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>		
		<form:select style='width:auto' path="motivoSuspension" id="motivoSuspension"  class="form-control">
		<form:option value="">Seleccione una opci�n...</form:option>
		<form:options items="${motivoSuspension}" itemLabel="valor" itemValue="id"/>				
		</form:select>
	</div>
	
	<div class="form-group form-inline">	
		<label>Motivo de Cesaci�n  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>		
		<form:select style='width:auto' path="motivoCesacion" id="motivoCesacion"  class="form-control">
		<form:option value="">Seleccione una opci�n...</form:option>
		<form:options items="${motivoCesacion}" itemLabel="valor" itemValue="id"/>				
		</form:select>
		
	</div>	
	
	<c:if test="${tipoPerfil != 'ea'}">  	
		<div class="form-group form-inline">				
			<label>Paga Entrevista  &nbsp;&nbsp;</label>
			<form:checkbox path="pagaEntrevista" checked="checked" style='width:auto' class="form-control"/>
		</div>
	</c:if>
	
	<div class="form-group form-inline">
		<label>Comentarios de revisi�n, intercambio RR - EA  &nbsp;&nbsp;</label>
		<form:textarea path="comentariosRevision" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);" style='width:auto' class="form-control"/>
	</div>	
	
	<!-- hidden obligatorios -->
	<input id="idEA" type="hidden" value="${idEA}"/>
	<input id="fechaActual" type="hidden" value="${fechaActual}">
	<input id="isGrupal" type="hidden" value="${isGrupal}"/>
	<input type="hidden" id="horaProxEntrevista" name="horaProxEntrevista" value="12:00">
	<input type="hidden" id="lugarProximaEntrevista" name="lugarProximaEntrevista" value="${alumno.escuela.nombre}">
	<input type="hidden" id="idProxima" name="lugarProximaEntrevista.id" value="${alumno.escuela.id}">
	<input type="hidden" name="valorGuardar" />
	<input type="hidden" name="valorPerfil" />		
	<input type="hidden" value="${boletin}">
	<form:hidden path="id"/>
	<form:hidden path="fechaCarga"/>
	<form:hidden path="periodoDePago"/>
	<input type="hidden" id="entrevistaReprogramada" name="entrevistaReprogramada">
	<input type="hidden" id="masDeUnEncuentro" name="masDeUnEncuentro" size="39" value="0" />
	<input type="hidden" id="participoBecadoX" name="participoBecadoX" value="${entrevista.participoBecado}">		
	<input type="hidden" id="motivoNoConvocatoria" name="motivoNoConvocatoria" value="${entrevista.motivoNoConvocatoria}">
	<input type="hidden" value="${entrevista.participoRA}">						
	<input type="hidden" id="motivoAusenciaRA" name="motivoAusenciaRA" value="${entrevista.motivoAusenciaRA}">
	<input type="hidden" id="cpaEA" name="cpaEA" value="0">
	<!-- input type="hidden" id="motivoInasistencia" name="motivoInasistencia"-->	
	<input type="hidden" id="periodo" name="periodo" value="${entrevista.periodoDePago.nombre}${periodo.nombre}">
	<input type="hidden" id="estrategiaComp" name="estrategiaComp" value="1">
	<input type="hidden" name="contenidosTrabajarDuranteAnio" id="contenidosTrabajarDuranteAnio" value="0">
	<input type="hidden" name="compromisoRA" id="compromisoRA" value="1">		
	<input type="hidden" id="masDeUnEncuentro" name="masDeUnEncuentro" value="0">
	<input type="hidden" id="telFijo" value="0">
	<input type="hidden" id="tma" value="0">

</form:form>
</div>
</div>
</div>

<script type="text/javascript" src="<c:url  value="/static/js/jquery.validate.js"/>"></script>
<script type="text/javascript" src="<c:url  value="/static/js/validador.js"/>"></script>
<!--  script type="text/javascript" src="<c:url  value="/static/js/funcionesEntrevista.js"/>"></script-->
<script type="text/javascript" src="<c:url  value="/static/js/jquery.blockUI.js"/>"></script>
 <script type="text/javascript" src="<c:url  value="/static/js/dFilter.js"/>"></script>
 
 
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<!-- sweetalert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
 
<script>
$(document).ready(() => {
	
	var select = $("#motivoAusencia").val();
	var participoAB=($("#participoBecado").val());
	var observacionesGenerales=$("#hsTrabajarA�o").val();
	if(participoAB==="1"){
 	   $("#motivoAusencia").prop('disabled', true); 
 	   $("#otroMotivoAusencia").prop('readonly', true);
 	   $("#motivoAusencia").val("0");
 	   $("#otroMotivoAusencia").val("");
    }else{
 	   $("#otroMotivoAusencia").prop('readonly', true);
 	   $("#motivoAusencia").prop('disabled', false);
    }
	
	//alert(select);	
	//$("#motivoAusencia").prop('disabled', true);
	
	
	$("#otroMotivoAusencia").prop('readonly', true);
	$("#motivoInasistenciaR").prop("disabled", true);
	$("#motivoSuspension").prop("disabled", true);
	$("#motivoCesasion").prop("disabled", true);
	$("#observacionesGenerales").prop('readonly', true);
	
	$("#participoBecado").change(function(){
		var participoAB = $(this).children("option:selected").val();
		//alert(participoAB);
      	
        if(participoAB==="1"){
    	   $("#motivoAusencia").prop('disabled', true); 
    	   $("#otroMotivoAusencia").prop('readonly', true);
    	   $("#motivoAusencia").val("0");
    	   $("#otroMotivoAusencia").val("");
       }else{
    	   $("#otroMotivoAusencia").prop('readonly', true);
    	   $("#motivoAusencia").prop('disabled', false);
       }
    });
	
	
	$("#motivoAusencia").change(function(){
        var otros = $(this).children("option:selected").val();
       if(otros==="4"){
    	   $("#otroMotivoAusencia").prop('readonly', false); 
       }else{
    	   $("#otroMotivoAusencia").prop('readonly', true);
    	   $("#otroMotivoAusencia").val("");
       }
    });	
	
	$("#hsTrabajarA�o").change(function(){
        var otrosHSE = $(this).children("option:selected").val();
       if(otrosHSE==="Otra"){
    	   $("#observacionesGenerales").prop('readonly', false); 
       }else{
    	   $("#observacionesGenerales").prop('readonly', true);
    	   $("#observacionesGenerales").val("");
       }
    });	
	
	
	if(("#cantidadInasistencias")!==0 && ("#cantidadInasistencias")!=="0.0"){
		$("#motivoInasistenciaR").prop("disabled", false); 
	}else{
		$("#motivoInasistenciaR").prop("disabled", true);
 	   	$("#motivoInasistenciaR").val("0");
	}
	
	$("#cantidadInasistencias").change(function(){
        var cantidadInasistencias = $(this).val();        
       if(cantidadInasistencias!=="0"){
    	   $("#motivoInasistenciaR").prop("disabled", false); 
       }else{
    	   $("#motivoInasistenciaR").prop("disabled", true);
    	   $("#motivoInasistenciaR").val("0");
       }
    });
	
	$("#evaluacionCobroBeca").change(function(){
        var tipoCobro = $(this).children("option:selected").val();
       if(tipoCobro==="2"){
    	   $("#motivoSuspension").prop("disabled", false); 
    	   $("#motivoCesacion").prop("disabled", true);
       }else{
	       if(tipoCobro==="4"){
	    	   $("#motivoSuspension").prop("disabled", true); 
	    	   $("#motivoCesacion").prop("disabled", false);
	       }else{
	    	   $("#motivoSuspension").prop("disabled", true); 
	    	   $("#motivoCesacion").prop("disabled", true);   
	       }
      }
    });	
	
	
});
</script>

<script>

function guardarAprobar(valor, valorPerfil){		
	//alert(valorPerfil);
	var texto="<ul style ='list-style:none'>";
	texto=texto+"<li><b>Te falta completar los siguientes campos</b></li><li> </li>";
	if(document.forms['altaEntrevistaIndividual'].tipoEncuentroAcompanamiento.value=="0" ){	 
		texto=texto+"<li>Principal tipo encuentro acompa�amiento</li>";					
	}
	//alert(1);
	if(document.forms['altaEntrevistaIndividual'].participoBecado.value=="0" && document.forms['altaEntrevistaIndividual'].motivoAusencia.value=="0"){		  
		texto=texto+"<li>Motivo de no participaci�n Becado</li>";			
	}
	//alert(2);
	if(document.forms['altaEntrevistaIndividual'].motivoAusenciaRa2.value=="0" ){		
		texto=texto+"<li>Participaci�n RA</li>";
	}
	
	//alert(document.forms['altaEntrevistaIndividual'].periodo.value);
	if(document.forms['altaEntrevistaIndividual'].periodo.value=="Julio"){
		//alert(document.forms['altaEntrevistaIndividual'].qtam.value);
		if(document.forms['altaEntrevistaIndividual'].qtam.value==""){					
			texto=texto+"<li>�Qu� trabajaste en el acompa�amiento en esta primer parte del a�o?</li>";
		}
		if(document.forms['altaEntrevistaIndividual'].anioEgreso.value=="2020"){
			if(document.forms['altaEntrevistaIndividual'].celular.value==""){					
				texto=texto+"<li>Celular</li>";
			}
		}	
	}	
	//alert(4);
	if(document.forms['altaEntrevistaIndividual'].osme.value==""){					
		texto=texto+"<li>Observaciones sobre rendimiento escolar y asistencia en esta primer parte del a�o</li>";
	}
	//alert(5);
	if(document.forms['altaEntrevistaIndividual'].hsTrabajarA�o.value=="0"){					
		texto=texto+"<li>Principal HSE trabajada en esta primer parte del a�o</li>";
	}
	//alert(6);
	if(document.forms['altaEntrevistaIndividual'].anioEgreso.value=="2020"){
		//alert("6bis");
		if(document.forms['altaEntrevistaIndividual'].sarpepe.value=="0"){					
			texto=texto+"<li>Proyecci�n post-escolar del EP</li>";
		}
	//alert(7);	
		
	}
	//alert(8);
	if(document.forms['altaEntrevistaIndividual'].objetivoEncuentro.value==""){					
		texto=texto+"<li>Objetivo del encuentro de julio y actividad implementada</li>";
	}
	//alert(9);
	if(document.forms['altaEntrevistaIndividual'].evaluacionCobroBeca.value==""){					
		texto=texto+"<li>Evaluaci�n cobro beca</li>";
	}
	//alert(10);		
	if(document.forms['altaEntrevistaIndividual'].evaluacionCobroBeca.value=="2"){		
		if(document.forms['altaEntrevistaIndividual'].motivoSuspension.value==""){						
			texto=texto+"<li>Motivo de suspensi�n</li>";
		} 
	}
	//alert(11);
	if(document.forms['altaEntrevistaIndividual'].evaluacionCobroBeca.value=="4"){
		if(document.forms['altaEntrevistaIndividual'].motivoCesacion.value==""){			
			texto=texto+"<li>Motivo de cesaci�n</li>";
		}
	}
	//alert(12);
	if (document.forms['altaEntrevistaIndividual'].evaluacionCobroBeca.value == 3 ) { 			  		
	  	texto=texto+"<li>No se puede finalizar una ent;revista en estado dudoso</li>"
	}	
	//alert(13);
	texto=texto+"</ul>";
	//alert(texto.length);
	if(texto.length>100){			
		const Toast = Swal.mixin({
			  toast: true,
			  position: 'top-end',
			  //showConfirmButton: false,			  
			  //timer: 7000,
			  html:texto,
			  timerProgressBar: true,
			  footer: 'Cualquier duda contactate con tu Responsable Regional',
			  onOpen: (toast) => {
			    toast.addEventListener('mouseenter', Swal.stopTimer)
			    toast.addEventListener('mouseleave', Swal.resumeTimer)
			  }
			})
			Toast.fire({
			  icon: 'error',
			  //title: 'Falta completar'
			})
			texto="";
			
		return false;
	}else{
		document.forms['altaEntrevistaIndividual'].valorPerfil.value = valorPerfil;
		document.forms['altaEntrevistaIndividual'].valorGuardar.value = valor;			
		//$.blockUI();			
		document.forms['altaEntrevistaIndividual'].submit();		
	}
}	
</script>
<script>
	function guardar(valor, valorPerfil){	
		
		document.forms['altaEntrevistaIndividual'].valorPerfil.value = valorPerfil;
		var valor=document.forms['altaEntrevistaIndividual'].valorGuardar.value = valor;		
		//alert(valor);
		if (valor == 'f'){
			
			
			if (esMayor(document.forms['altaEntrevistaIndividual'].fechaEntrevista.value, document.forms['altaEntrevistaIndividual'].fechaActual.value)){
				document.forms['altaEntrevistaIndividual'].fechaEntrevista.focus();
				jAlert('warning', '"Fecha Entrevista" no puede ser mayor a la fecha actual', 'Atenci�n!')
				
			}
			else{
				if (document.forms['altaEntrevistaIndividual'].evaluacionCobroBeca.value == 4 ){
					$.blockUI();
					$('#altaEntrevistaIndividual').submit();
				}else{
					if(valorPerfil != 'superUsuario'){
						if (!esMayor(document.forms['altaEntrevistaIndividual'].proximaEntrevista.value, document.forms['altaEntrevistaIndividual'].fechaActual.value)){
							document.forms['altaEntrevistaIndividual'].proximaEntrevista.focus();
							jAlert('warning', '"Fecha Proxima Entrevista" debe ser mayor a la fecha actual', 'Atenci�n!')
						}
						else{
							$.blockUI();
							$('#altaEntrevistaIndividual').submit();
						}
					}
					else{
						$.blockUI();
						$('#altaEntrevistaIndividual').submit();
					}
				}
			}	
		}else{
			//$.blockUI();
			var cantidadInasistencias=$("#cantidadInasistencias").val();
			//alert(cantidadInasistencias.length);
			if(cantidadInasistencias.length==0){
				$("#cantidadInasistencias").val(0);
				
			}
			document.forms['altaEntrevistaIndividual'].submit();
		}
		
	}
</script>

<script>
	function raNoFueConvocado(inputSelect){
		//alert(1);
	
		if(document.getElementById("raNoConvocado").checked==true){		
			//alert(2);
			$('#motivoNoConvocatoria').attr('disabled','disabled');
			$('#motivoNoConvocatoria').attr('value', 'Seleccione una opci�n:');
			//$('#motivoNoConvocatoria > option[value="0"]').attr('selected', 'selected');
			$('#participoRA').removeAttr('disabled');
			//$('#motivoAusenciaRA').removeAttr('disabled');
			//$('#motivoAusenciaRA').attr('value', 'Seleccione una opci�n:');
		}else{		
			//alert(3);
			$('#motivoNoConvocatoria').removeAttr('disabled');
			//$('#participoRA').removeAttr('disabled');
			$('#participoRA').removeAttr("checked");
			$('#participoRA').attr('disabled','disabled');	
			//$('#motivoAusenciaRA').attr('disabled','disabled');
			//$('#motivoAusenciaRA').attr('value', 'Seleccione una opci�n:');
		}	
	}
</script>

<script>
	$(document).ready(function(){  
	  
    	$("#participoRA").click(function() {  
        	if($("#participoRA").is(':checked')) {  
            	//alert("Est� activado");  
        		//$('#motivoAusenciaRA').attr('disabled','disabled');
    			//$('#motivoAusenciaRA').attr('value', 'Seleccione una opci�n:');
    	    }  
            	
        	 else {  
	            //alert("No est� activado");
        		//$('#motivoAusenciaRA').removeAttr('disabled');
    			//$('#motivoAusenciaRA').attr('value', 'Seleccione una opci�n:');
        	}	
    	});  
  
	});  
</script>

<script>
	function verificarCantidad(){
		//alert(document.getElementById("contenidosAbordados").length);
		var e = document.getElementById("contenidosAbordados");
		var a=0;
		for (var i = 0; i < e.length; i++){				
				if(e.options[i].selected == true){
				var name = e[i].getAttribute("text");
				a++;								
				}
		}
		if(a>2){
			alert("Ten�s que seleccionar no m�s de 2 habilidades y/o contenidos. Seleccionaste "+a);
		}
		
	} 
</script>

<script>
function chequearLongitud(obj){
	if (obj.value.length > 10000) {
	obj.value = obj.value.substring(0, 10000);
	}
}
</script>	
</body>
</html>