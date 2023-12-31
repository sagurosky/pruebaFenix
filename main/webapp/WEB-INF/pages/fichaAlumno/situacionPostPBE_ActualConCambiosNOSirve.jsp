<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Situaci&oacute;n Escolar</title>
<script type="text/javascript" src="<c:url  value="/static/js/jquery.blockUI.js"/>"></script>
<script type="text/javascript">
$(function() {
	  $("#cicloIdEgreso").change(function(evt) {
	    evt.preventDefault()   
	    $.ajax( {
	      type: "GET",
	      url: "../ajax/obtenerListaPeriodos.do",
	      data: { idCiclo: $("#cicloIdEgreso").val() },
	      dataType: "json",
	      success: function(data) {
	    	  var options = '';
	            options += '<option value="" selected="selected">Seleccione</option>'
	            $(data.periodos).each(function() {
	                options += '<option value="' + this.id + '">' + this.nombre + '</option>';
	            });
	             $("select#periodoIdEgreso").html(options);
	             $("#periodoIdEgreso").addClass("required");        	
	      }
	    } )
	  });
});

function chequearLongitud(obj){
	if (obj.value.length > 10000) {
	obj.value = obj.value.substring(0, 10000);
	}
}

function habilitarCamposEgreso(obj){
	var perfilSuper = document.forms['alumnoForm'].perfil.value;
	if(perfilSuper == 'SuperUsuario'){
		document.getElementById("cicloIdEgreso").disabled = false;
		document.getElementById("periodoIdEgreso").disabled = false;
	}
	else{
		if(obj.value == ''){
			document.getElementById("cicloIdEgreso").disabled = false;		
			document.getElementById("periodoIdEgreso").disabled = false;	
		}else{
			document.getElementById("cicloIdEgreso").disabled = true;
			document.getElementById("periodoIdEgreso").disabled = true;
		}	
	}
}

function habilitarOtraProyeccion(obj){
	if(obj.value == 5){
		document.getElementById("otraProyeccion").disabled = false;	
		$("#otraProyeccion").addClass("required");
	}else{
		document.getElementById("otraProyeccion").disabled = true;
		document.getElementById("otraProyeccion").value = "";
	}	
}

function habilitarOtraSituacion(obj){
	if(obj.value == 5){
		document.getElementById("otraSituacion").disabled = false;
		$("#otraSituacion").addClass("required");
	}else{
		document.getElementById("otraSituacion").disabled = true;
		document.getElementById("otraSituacion").value = "";
	}	
}	

function deshabilitarFechas(){	
	//document.getElementById("fechaSituacionEscolar").disabled = true;
	//document.getElementById("fechaSituacionActual").disabled = true;
	//document.getElementById("fechaProyeccionDeseada").disabled = true;
}

function cargarDatos(){
	habilitarCamposEgreso(document.getElementById("fechaSituacionEscolar"));
	habilitarOtraSituacion(document.getElementById("situacionActual"));
	habilitarOtraProyeccion(document.getElementById("proyeccionDeseada"));
	deshabilitarFechas();
}

function actualizacionDatosPostPBE(){
 	actualizacionPeriodoEgreso(document.getElementById("cicloIdEgresoAlumno"),document.getElementById("cicloIdEgreso"),
 			document.getElementById("periodoIdEgresoAlumno"),document.getElementById("periodoIdEgreso"));
 	//actualizacionDatosSituacionActual(document.getElementById("situacionActualAlumno"),document.getElementById("situacionActual"));
 	//actualizacionDatosOtraSituacionActual(document.getElementById("otraSituacionAlumno"),document.getElementById("otraSituacion"));
 	//actualizacionDatosProyeccionDeseada(document.getElementById("proyeccionDeseadaAlumno"),document.getElementById("proyeccionDeseada"));
 	//actualizacionOtrosDatosProyeccionDeseada(document.getElementById("otraProyeccionAlumno"),document.getElementById("otraProyeccion"));
 	alert();
}

function actualizacionPeriodoEgreso(objCicloAlumno, objCicloFormulario, objPeriodoAlumno, objPeriodoFormulario){	
	if(objCicloAlumno.value != objCicloFormulario.value){
		if(objCicloFormulario.value !=0){
			document.forms['alumnoForm'].actualizacionPBE.value = true;
			document.forms['alumnoForm'].actualizacionDatosEgreso.value = true;
		}
		else{
			var perfilSuper = document.forms['alumnoForm'].perfil.value;
			if(perfilSuper == 'SuperUsuario' && objCicloAlumno.value != ""){
				document.forms['alumnoForm'].actualizacionPBE.value = true;
				document.forms['alumnoForm'].actualizacionDatosEgreso.value = true;
			}
			else{
				document.forms['alumnoForm'].actualizacionPBE.value = false;
				document.forms['alumnoForm'].actualizacionDatosEgreso.value = false;
			}
		}
	}
	else{
		if(objPeriodoAlumno.value != objPeriodoFormulario.value){
			document.forms['alumnoForm'].actualizacionDatosEgreso.value = true;
		}
		else{
			document.forms['alumnoForm'].actualizacionDatosEgreso.value = false;
		}
	}
}

function actualizacionDatosSituacionActual(objAlumno, objFormulario){
	if(objAlumno.value != objFormulario.value){
		document.forms['alumnoForm'].actualizacionSituacionActual.value = true;		
		document.forms['alumnoForm'].actualizacionPBE.value = true;
	}
	else{
		document.forms['alumnoForm'].actualizacionSituacionActual.value = false;
	}
}

function actualizacionDatosOtraSituacionActual(objAlumno, objFormulario){
	if(objAlumno.value != objFormulario.value){
		document.forms['alumnoForm'].actualizacionSituacionActual.value = true;
		document.forms['alumnoForm'].actualizacionPBE.value = true;
	}
	else{		
		var actualizacion = document.forms['alumnoForm'].actualizacionSituacionActual.value;
		document.forms['alumnoForm'].actualizacionSituacionActual.value = actualizacion;			
	}
}

function actualizacionDatosProyeccionDeseada(objAlumno, objFormulario){
	if(objAlumno.value != objFormulario.value){
		document.forms['alumnoForm'].actualizacionProyeccionDeseada.value = true;		
		document.forms['alumnoForm'].actualizacionPBE.value = true;
	}
	else{
		document.forms['alumnoForm'].actualizacionProyeccionDeseada.value = false;
	}
}

function actualizacionOtrosDatosProyeccionDeseada(objAlumno, objFormulario){	
	if(objAlumno.value != objFormulario.value){
		document.forms['alumnoForm'].actualizacionProyeccionDeseada.value = true;
		document.forms['alumnoForm'].actualizacionPBE.value = true;
	}
	else{
		var actualizacion = document.forms['alumnoForm'].actualizacionProyeccionDeseada.value;
		document.forms['alumnoForm'].actualizacionProyeccionDeseada.value = actualizacion;
	}
}

function validarPeriodoCicloEgreso(){
	var periodo = $("#periodoIdEgreso").val();
	var ciclo = $("#cicloIdEgreso").val();
	var modificar = document.forms['alumnoForm'].actualizacionDatosEgreso.value;
	var perfilSuper = document.forms['alumnoForm'].perfil.value;
	var situacionEscolar =  document.forms['alumnoForm'].situacionEscolarUltimaEntevista.value;
	if(perfilSuper == 'SuperUsuario' && modificar == 'true' && situacionEscolar == 'EGRESO'){
		if(periodo == 0)
			document.forms['alumnoForm'].periodoIdEgreso.value = "";
		$("#periodoIdEgreso").addClass("required");
	}
	else{
		if(ciclo == 0)
			$("#periodoIdEgreso").removeClass("required");
		else{
			if(periodo == 0)
				document.forms['alumnoForm'].periodoIdEgreso.value = "";
			$("#periodoIdEgreso").addClass("required");    
		}
	}   
}
</script>

</head>
<body onload="cargarDatos();">
	<table align="left" width="800">	
		<tr>
			<td>		
				<b>Datos &uacute;ltima entrevista acompa&ntilde;amiento</b>
			</td>
		</tr>
		<tr>
			<td>					
				<fieldset>
					<table align="left">					
						<tr>
				      	    <td>&nbsp;</td>	       	 
				      	</tr>
				      	<tr>
							<td colspan="3">
								${perfilAlumno.periodoDeBaja.nombre} ${perfilAlumno.periodoDeBaja.ciclo.nombre}
							</td>							
						<tr>
						<tr>
							<td width="175">
								Situaci&oacute;n escolar: 
							</td>
							<c:if test="${!empty perfilAlumno.situacionEscolarUltimaEntevista}">				
								<td>						
									${perfilAlumno.situacionEscolarUltimaEntevista.valor}
								</td>	
							</c:if>	
							<c:if test="${empty perfilAlumno.situacionEscolarUltimaEntevista}">				
								<td>						
									No Aplica
								</td>	
							</c:if>						
						<tr>
						<tr>  
							<td>
								Estado del alumno:	
							</td>
							<td colspan="2">			
								<c:choose>
									<c:when test="${perfilAlumno.estadoAlumno.id == 20 ||perfilAlumno.estadoAlumno.id == 22}">
										${perfilAlumno.estadoRenovacion.valor}
									</c:when>
									<c:otherwise>
										${perfilAlumno.estadoAlumno.valor}
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<c:if test="${!empty perfilAlumno.motivoBaja}">	
							<tr>		  
								<td>
									Motivo de baja:	
								</td>
								<td colspan="2">												
									${perfilAlumno.motivoBaja}	
								</td>
							</tr>
							<tr>
			     	  			<td>&nbsp;</td>	       	 
			     			</tr>
						</c:if>				
						<c:if test="${empty perfilAlumno.motivoBaja && !empty perfilAlumno.proyeccionEntrevistaFinal}">		
							<tr>			
								<td>
									Proyecci&oacute;n a&ntilde;o pr&oacute;ximo:	
								</td>
								<td colspan="2">												
									${perfilAlumno.proyeccionEntrevistaFinal.valor}	
								</td>
							</tr>
							<tr>
		     	  			  <td>&nbsp;</td>	       	 
		     				</tr>
						</c:if>							
					</table>
				</fieldset>
			</td>
		</tr>			
		<tr>
      	    <td>&nbsp;</td>	       	 
      	</tr>
      	<tr>
			<td>		
				<b>Actualizaci&oacute;n datos post PFE </b>
			</td>
		</tr>
		<tr>
			<td>					
				<fieldset>
					<table align="left">  			
						<tr>
				      	    <td>&nbsp;</td>	       	 
				      	</tr>
				      	<tr>
				      		<td>
				      			<fieldset style="width: 780px">
				      				<legend>Egreso Efectivo</legend>
				      				<table width="600">	
				      					<tr>
				      	   					<td>&nbsp;</td>	       	 
				     					</tr>			      					
				      					<tr>
											<td colspan="2">Fecha actualizaci&oacute;n situaci&oacute;n escolar</td>
											<td colspan="2"><input style="border: 0" id="fechaSituacionEscolar" disabled="disabled" value="<fmt:formatDate value="${perfilAlumno.ultimaActualizacion}" pattern="dd/MM/yyyy"/>"></td>
										</tr>
										<tr>
											<td>&nbsp;</td>	     
										</tr>
										<tr align="center">
											<td align="left" width="100">Ciclo egreso</td>
											<td align="left" width="100">
												 <select id="cicloIdEgreso" name="cicloIdEgreso"  style="width:150px;">
													<option value="0">Seleccione</option>
													<c:forEach var="ciclo" items="${ciclos}">
														<c:if test="${ciclo.id == cicloIdEgreso}">
															<option selected="selected" id="ciclo" value="${ciclo.id}">${ciclo.nombre}</option>
														</c:if>
														<c:if test="${ciclo.id != cicloIdEgreso}">
															<option id="ciclo" value="${ciclo.id}">${ciclo.nombre}</option>
														</c:if>
													</c:forEach>
							 					</select>
											</td>
											<td align="center" width="100">Per&iacute;odo egreso</td>
											<td align="left" width="100">
												<select id="periodoIdEgreso" name="periodoIdEgreso" style="width:150px;">
													<option value="0">Seleccione</option>
													<c:forEach var="periodo" items="${periodosEgreso}">
														<c:if test="${periodo.id == periodoIdEgreso}">
															<option selected="selected" id="periodo" value="${periodo.id}">${periodo.nombre}</option>
														</c:if>
														<c:if test="${periodo.id != periodoIdEgreso}">
															<option id="tipo" value="${periodo.id}">${periodo.nombre}</option>
														</c:if>
													</c:forEach>
							 					</select>
											</td>
										</tr>	
										<tr>
											<td>
											</td>
											<td>
												<input type="hidden" id="periodoEgreso" name="periodoEgreso"/>
											</td>
										</tr>									
									</table>
								</fieldset>
							</td>
						</tr>
						<tr>
	     	   					<td>&nbsp;</td>	       	 
	    					</tr>
						<!-- 
						<tr>
				      		<td>
				      			<fieldset style="width: 780px">
				      				<legend>Actualizaci&oacute;n situaci&oacute;n actual</legend>
				      				<table width="800">	
				      					<tr>
	     	   								<td>&nbsp;</td>	       	 
	    								</tr>	
				      					<tr>
											<td colspan="2">&Uacute;ltima actualizaci&oacute;n de situaci&oacute;n actual</td>
											<td colspan="2"><input style="border: 0"  id="fechaSituacionActual" disabled="disabled"  value="<fmt:formatDate value="${perfilAlumno.fechaSituacionActual}" pattern="dd/MM/yyyy"/>"></td>
										</tr>
				      					<tr>						
											<td width="120">Situaci&oacute;n actual</td>
											<td>
												<select name="situacionActual" id="situacionActual" onchange="habilitarOtraSituacion(this)">
													<option value="">Seleccione una opci�n...</option>
													<c:forEach items="${situacionActual}" var="situ">
														<c:choose>
															<c:when test="${perfilAlumno.situacionActual.id == situ.id}">
																<option value="${situ.id}" selected="selected">${situ.valor}</option>
															</c:when>
															<c:otherwise>
																<option value="${situ.id}">${situ.valor}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>
											</td>
											<td width="150" align="left">Otra situaci&oacute;n actual</td>
											<td align="left"><textarea cols="45" rows="5"  name="otraSituacion" id="otraSituacion" disabled="disabled" onkeypress="chequearLongitud(this);" 
													onblur="chequearLongitud(this);">${perfilAlumno.otraSituacion}</textarea></td>		
										</tr>										
									</table>
								</fieldset>
							</td>
						</tr>
						<tr>
	     	   				<td>&nbsp;</td>	       	 
	    				</tr>	
						<tr>
				      		<td>
								<fieldset style="width: 780px">
				      				<legend>Actualizaci&oacute;n proyecci&oacute;n deseada</legend>
				      				<table width="800">	
				      					<tr>
	     	   								<td>&nbsp;</td>	       	 
	    								</tr>	
				      					<tr>
											<td colspan="2">&Uacute;ltima actualizaci&oacute;n de proyecci&oacute;n deseada</td>
											<td colspan="2"><input style="border: 0"  id="fechaProyeccionDeseada" disabled="disabled" value="<fmt:formatDate value="${perfilAlumno.fechaProyeccionDeseada}" pattern="dd/MM/yyyy"/>"></td>
										</tr>
										<tr>
											<td width="130">Proyecci&oacute;n deseada</td>
											<td>
												<select name="proyeccionDeseada" id="proyeccionDeseada" onchange="habilitarOtraProyeccion(this)">
													<option value="">Seleccione una opci�n...</option>
													<c:forEach items="${proyeccionDeseada}" var="proy">
														<c:choose>
															<c:when test="${perfilAlumno.proyeccionDeseada.id == proy.id}">
																<option value="${proy.id}" selected="selected">${proy.valor}</option>
															</c:when>
															<c:otherwise>
																<option value="${proy.id}">${proy.valor}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>
											</td>
											<td width="180" align="left">Otra proyecci&oacute;n deseada</td>
											<td align="left"><textarea cols="40" rows="5"  name="otraProyeccion" id="otraProyeccion" disabled="disabled" onkeypress="chequearLongitud(this);" 
													onblur="chequearLongitud(this);">${perfilAlumno.otraProyeccion}</textarea></td>	
										</tr>										
									</table>
								</fieldset>
							</td>
						</tr>
						-->
						<!-- 2019 -->						

						<tr>
							<td>		
								<b>Acompa�amiento post PFE </b>
							</td>							
						</tr>
						<tr>
	     	   				<td>&nbsp;</td>	       	 
	    				</tr>	
						<tr>
						<tr>
							<td>		
								Actualizaci�n de materias pendientes
							</td>							
						</tr>
						<tr>
	     	   				<td>&nbsp;</td>	       	 
	    				</tr>	
						<tr>
						<tr>
							<td>Cantidad de materias aprobadas: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
								<select id="qma" name="qma">
									<option value="0">Seleccionar</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
								</select>
							</td>
						</tr>
						<tr>
	     	   				<td>&nbsp;</td>	       	 
	    				</tr>	
						<tr>
						<tr>
							<td>Cantidad de materias desaprobadas: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<select id="qmd" name="qmd">
									<option value="0">Seleccionar</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
								</select>
							</td>
						</tr>
						<tr>
	     	   				<td>&nbsp;</td>	       	 
	    				</tr>	
						<tr>
						<tr>
							<td>Cantidad de materias que no se present�: 
								<select id="qmqnsp" name="qmqnsp">
									<option value="0">Seleccionar</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
								</select>
							</td>
						</tr>
						<tr>
	     	   				<td>&nbsp;</td>	       	 
	    				</tr>	
						<tr>
						<tr>
							<td>Cantidad de materias que no hubo mesa:&nbsp;
								<select id="qmqnhm" name="qmqnhm">
									<option value="0">Seleccionar</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
								</select>
							</td>
						</tr>
						<tr>
	     	   				<td>&nbsp;</td>	       	 
	    				</tr>	
						
						<tr>
							<td>Cantidad de materias que adeuda:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<select id="qmqad" name="amqad">
									<option value="0">Seleccionar</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
								</select>
							</td>
						</tr>
						<tr>
	     	   				<td>&nbsp;</td>	       	 
	    				</tr>
	    				<tr>
	    					<td>Nombre de las materias que adeuda: <br>
								<textarea cols="50" rows="5"  name="materiasAdeuda" id="materiasAdeuda">${perfilAlumno.obsPostPBE}</textarea>
							</td>	
	    				</tr>
	    				<!-- tr>
	     	   				<td>&nbsp;</td>	       	 
	    				</tr>
						<tr>
							<td>Observaciones: <br>
								<textarea cols="50" rows="5"  name="obsPostPBE" id="obsPostPBE" onkeypress="chequearLongitud(this);" onblur="chequearLongitud(this);">${perfilAlumno.obsPostPBE}</textarea>	
							</tr>
								
							</td>
						</tr-->
						<tr>
	     	   				<td>&nbsp;</td>	       	 
	    				</tr>
	    				<tr>
	    					<td><b>Estrategia de acompa�amiento</b><br></td>	
	    				</tr>
						<tr>
	     	   				<td>&nbsp;</td>	       	 
	    				</tr>
	    				<tr>
	    					<td>Tipo de encuentro:<br><br>
								<input type="checkbox" name="encuentro1" id="encuentro1" value="Individual"> Individual<br>
								<input type="checkbox" name="encuentro2" id="encuentro2" value="Grupal"> Grupal<br>
								<input type="checkbox" name="encuentro3" id="encuentro3" value="Dupla" > Dupla<br>
								<input type="checkbox" name="encuentro4" id="encuentro4" value="Otro" > Otro<br>
							</td>	
	    				</tr>
	    				<tr>
	     	   				<td>&nbsp;</td>	       	 
	    				</tr>
						<tr>
							<td>Descripci�n y evaluaci�n: <br>
								<textarea cols="50" rows="5"  name="evaluacion" id="evaluacion" onkeypress="chequearLongitud(this);" onblur="chequearLongitud(this);">${perfilAlumno.obsPostPBE}</textarea>	
						</tr>
						<tr>
	     	   				<td>&nbsp;</td>	       	 
	    				</tr>	
						
						<tr>
							<td>�Asisti� a clases de aopyo escolar? 
								<select id="clasesApoyoEscolar" name="clasesAopyoEscolar">
									<option value="S�">S�</option>
									<option value="No">No</option>									
								</select>
							</td>
						</tr>
						<tr>
	     	   				<td>&nbsp;</td>	       	 
	    				</tr>	
	    				<tr><td><h1 align="left" id="titulo-informe">Carga de Bolet�n</h1></td></tr>
						
						<tr>	
							<td>			
							<a href="../entrevistas/mostrarImagen.do?dni=${alumno.datosPersonales.perfilAlumno.id}-${alumno.datosPersonales.perfilAlumno.boletin.id}" target="_blank"> <img src="../entrevistas/mostrarImagen.do?dni=${alumno.datosPersonales.perfilAlumno.id}-${alumno.datosPersonales.perfilAlumno.boletin.id}" width="100px"></a></td>			
						</tr>
						<tr>
							<td><center>Subir bolet�n
							<input name="foto" id="foto" type="file" onchange="validarExtension()"></center></td>
							
						</tr>		
						<tr>
							<td colspan="2"><font color="red">El tipo de archivo de la imagen debe ser "jpg"</font></td>
						</tr>	
					</table>
				

<input type="hidden" id="cicloIdEgresoAlumno" name="cicloIdEgresoAlumno" value="${cicloIdEgreso}"/>
<input type="hidden" id="periodoIdEgresoAlumno" name="periodoIdEgresoAlumno" value="${periodoIdEgreso}"/>
<input type="hidden" id="situacionActualAlumno" name="situacionActualAlumno" value="${perfilAlumno.situacionActual.id}"/>
<input type="hidden" id="otraSituacionAlumno" name="otraSituacionAlumno" value="${perfilAlumno.otraSituacion}"/>
<input type="hidden" id="proyeccionDeseadaAlumno" name="proyeccionDeseadaAlumno" value="${perfilAlumno.proyeccionDeseada.id}"/>
<input type="hidden" id="otraProyeccionAlumno" name="otraProyeccionAlumno" value="${perfilAlumno.otraProyeccion}"/>
<input type="hidden" id="actualizacionDatosEgreso" name="actualizacionDatosEgreso"/>
<input type="hidden" id="actualizacionSituacionActual" name="actualizacionSituacionActual"/>
<input type="hidden" id="actualizacionProyeccionDeseada" name="actualizacionProyeccionDeseada"/>
<input type="hidden" id="perfil" name="perfil" value="${perfil}"/>
<input type="hidden" id="situacionEscolarUltimaEntevista" name="situacionEscolarUltimaEntevista" value="${perfilAlumno.situacionEscolarUltimaEntevista}"/>
</body>
</html>