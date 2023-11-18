<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table id="table-informe">
	<tr>
		<td width="180"><label>Escuela</label></td>
		<td nowrap="nowrap"><label><b>${alumno.escuela.nombre}</b></label></td>
	</tr>
	<tr>
		<td><label>Orientaci�n Escolar</label></td>
		<td><label><b>${alumno.escuela.modalidadEscolar.valor}</b></label></td>	
	</tr>
	<tr>		
		<td><label>A�o Escolar</label></td>
		<td><label><b>${alumno.boletin.ano.valor}</b></label></td>
	</tr>
	<tr>		
		<td><label>A�o Adicional</label></td>
		<td>
			<input type="checkbox" name="anioAdicional"
				<c:if test="${alumno.anioAdicional}"> checked="checked" </c:if> 
			id="anioAdicional"  disabled="true">
		</td>
	</tr>
	<tr>		
		<td><label>A�o Egreso</label></td>
		<td><label>		
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
		</label>
		</td>
	</tr>
	<!-- 2019 
	<tr>		
			<td nowrap="nowrap"><label>Renovado con materias a rendir</label></td>		
		<td> 	
						
			<c:if test="${alumno.situacionEscolar == 'PROMOVIDO_CON_PREVIAS'}">
				<input type="checkbox" 	name="situacionEscolar" id="situacionEscolar" checked="checked" disabled="true">			
			</c:if>
			<c:if test="${alumno.situacionEscolar != 'PROMOVIDO_CON_PREVIAS'}">
				<input type="checkbox" 	name="situacionEscolar" id="situacionEscolar"  disabled="true">			
			</c:if>								
		</td>
	</tr-->
	 <tr>		
			<td nowrap="nowrap"><label>Renovado por excepci�n</label></td>		
		<td>	
			<input type="checkbox" 	name="excepcionR" id="excepcionR" value="${entrevista.excepcion}" disabled="true">						
		</td>
	</tr>
	<tr>		
		<td nowrap="nowrap"><label>Inasistencias mensuales</label></td>
		<td>
			<form:input path="cantidadInasistencias" id="cantidadInasistencias" disabled="true" />
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Principales motivos de inasistencias de este per�odo:</label></td>					
		<td>
			<form:select path="motivoInasistenciaR" id="motivoInasistenciaR" class="textbox2" disabled="true">
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
			</form:select>	
		</td>	
	<tr>
	   
	
</table>