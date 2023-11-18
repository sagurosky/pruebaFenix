<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Beca Asignada</title>
<script type="text/javascript" src="<c:url  value="/static/js/jquery.blockUI.js"/>"></script>
<script type="text/javascript">
	function actualizacionPeriodoAsignacion(objPeriodoAlumno, objPeriodoFormulario){
		//alert(objPeriodoAlumno);
		//alert(objPeriodoFormulario);
		
		if(objPeriodoFormulario.value != 0 && objPeriodoAlumno.value != objPeriodoFormulario.value){
			document.forms['alumnoForm'].actualizacionPeriodoAsignacion.value = true;
		}
		else{
			document.forms['alumnoForm'].actualizacionPeriodoAsignacion.value = false;
		}
	}
	
	function desasignarBeca(){
		if($("#desasignar").attr("checked")){
			$("#periodoIdAsignacion").attr("disabled","disabled");
			document.forms['alumnoForm'].becaDesasignar.value = true;
		}
		else{
			document.forms['alumnoForm'].becaDesasignar.value = false;
		}
	}
</script>

</head>
<body onload="cargarDatos();">
	<table align="left" width="800">	
		<tr>
			<td>		
				<b>Datos &uacute;ltima asignaci&oacute;n de beca</b>
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
							<td width="165">
								Padrino: 
							</td>
							<c:if test="${!empty perfilAlumno.beca.padrino.datosPersonales}">				
								<td>						
									${perfilAlumno.beca.padrino.datosPersonales.apellidoNombre}
								</td>	
							</c:if>	
							<c:if test="${!empty perfilAlumno.beca.padrino.empresa}">				
								<td>						
									${perfilAlumno.beca.padrino.empresa.denominacion}
								</td>	
							</c:if>						
						<tr>
						<tr>  
							<td>
								Per&iacute;odo de asignaci&oacute;n:	
							</td>
							<td colspan="2">			
								${periodoAsignacion.nombre}
							</td>
						</tr>						
					</table>
				</fieldset>
			</td>
		</tr>			
		<tr>
      	    <td>&nbsp;</td>	       	 
      	</tr>
      	<sec:authorize access="hasRole('SuperUsuario')">
      		<c:if test="${modificacionPeriodo == true}">
		      	<tr>
					<td>		
						<b>Actualizaci&oacute;n datos beca asignada</b>
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
						      				<legend>Modificaci&oacute;n per&iacute;odo de asignaci&oacute;n</legend>
						      				<table width="600">	
						      					<tr>
						      	   					<td>&nbsp;</td>	       	 
						     					</tr>			      					
						      					<tr align="center">
													<td align="left" width="130">Per&iacute;odo asignaci&oacute;n</td>
													<td align="left" width="120">
														<select id="periodoIdAsignacion" name="periodoIdAsignacion">
															<option value="0">Seleccione</option>
															<c:forEach var="periodo" items="${periodosBeca}">
																<c:if test="${periodo.id == periodoIdAsignacion}">
																	<option selected="selected" id="periodo" value="${periodo.id}">${periodo.nombre}</option>
																</c:if>
																<c:if test="${periodo.id != periodoIdAsignacion}">
																	<option id="tipo" value="${periodo.id}">${periodo.nombre}</option>
																</c:if>
															</c:forEach>
									 					</select>
													</td>
													<c:if test="${desasignarBeca == true}">
														<td align="left" width="110">Desasignar Beca</td>
														<td align="left">
															<input type="checkbox" name="desasignar" id="desasignar" onclick="desasignarBeca()" >
														</td>
													</c:if>
													<c:if test="${desasignarBeca != true}">
														<td align="left" colspan="2"></td>
													</c:if>
												</tr>										
											</table>
										</fieldset>
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
			</c:if>
			<c:if test="${modificacionPeriodo != true && desasignarBeca == true}">
				<input type="hidden" id="periodoIdAsignacion" name="periodoIdAsignacion" value="0"/>
				<tr>
					<td>		
						<b>Actualizaci&oacute;n datos beca asignada</b>
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
						      				<legend>Desasignaci&oacute;n de Beca</legend>
						      				<table width="600">	
						      					<tr>
						      	   					<td>&nbsp;</td>	       	 
						     					</tr>			      					
						      					<tr align="center">														
													<td align="left" width="110">Desasignar Beca</td>
													<td align="left">
														<input type="checkbox" name="desasignar" id="desasignar" onclick="desasignarBeca()" >
													</td>
												</tr>										
											</table>
										</fieldset>
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
			</c:if>
			<c:if test="${modificacionPeriodo != true && desasignarBeca != true}">
				<input type="hidden" id="periodoIdAsignacion" name="periodoIdAsignacion" value="0"/>
			</c:if>
		</sec:authorize>
		<sec:authorize access="not hasRole('SuperUsuario')">
			<input type="hidden" id="periodoIdAsignacion" name="periodoIdAsignacion" value="0"/>
		</sec:authorize>
	</table>
	<input type="hidden" id="periodoIdAsignacionAlumno" name="periodoIdAsignacionAlumno" value="${periodoIdAsignacion}"/>
</body>
</html>