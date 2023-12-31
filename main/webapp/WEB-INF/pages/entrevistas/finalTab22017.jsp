<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table id="table-informe">
	<tr>
		<td width="240"><label>Escuela</label></td>
		<td nowrap="nowrap" ><label><b>${alumno.escuela.nombre}</b></label></td>
	</tr>
	<tr>
		<td><label>Modalidad Escolar</label></td>
		<td><label><b>${alumno.escuela.modalidadEscolar.valor}</b></label></td>	
	</tr>
	<tr>		
		<td><label>A�o Escolar</label></td>
		<td><label><b>${alumno.anioEscolar.valor}</b></label></td>
	</tr>
		<tr>		
		<td><label>A�o Adicional</label></td>
		<td>
			<input type="checkbox" name="anioAdicional" <c:if test="${alumno.anioAdicional}"> checked="checked" </c:if> 
			id="anioAdicional"  disabled="true">
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Materias/fechas a rendir en diciembre</label></td>
		<td>
			<form:textarea path="materiasRendirDiciembre" id="materiasRendirDiciembre" rows="4" cols="30" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Materias/fechas a rendir en febrero/marzo</label></td>
		<td>
			<form:textarea path="materiasRendirFebMarzo" id="materiasRendirFebMarzo" rows="4" cols="30" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
		</td>
	</tr>
	<!-- ocultado el 11-02-2016
	<tr>	
		<td><label>Carpeta *</label></td>
		<td>
			<form:select path="carpeta" id="carpeta" disabled="true" class="required" onchange="habilitarMaterialCompletoCarpeta(this)">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${opciones}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	
	<tr>		
		<td nowrap="nowrap"><label>Cuaderno Comunicados  *</label></td>
		<td>
			<form:select path="cuadernoComunicados" id="cuadernoComunicados" class="required" disabled="true" onchange="habilitarMaterialCompletocuadernoComunicados(this)">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${opciones}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Bolet�n *</label></td>
		<td>
			<form:select path="boletin" id="boletin" class="required" disabled="true" onchange="habilitarMaterialCompletoBoletin(this)">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${opciones}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>		
		<td nowrap="nowrap"><label>Informe Profesores *</label></td>
		<td>
			<form:select path="informeProfesores" id="informeProfesores" class="required"disabled="true" onchange="habilitarMaterialCompletoInformeProfesores(this)">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${opciones}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Materia  *</label></td>
		<td>
			<form:select path="materiaBoletin" id="materiaBoletin" class="required">
				<form:option value="">Seleccione una opci�n...</form:option>
				<c:if test="${alumno.boletin != null}">
					<form:options  items="${alumno.boletin.materias}" itemLabel="nombre" itemValue="id"/>
				</c:if> 
				<c:if test="${alumno.boletin == null}">
					<form:options  items="${materiasBasicas}" itemLabel="nombre" itemValue="id"/>
				</c:if>					
			</form:select>
		</td>
	</tr>		
	<tr>
		<td nowrap="nowrap"><label>Cerfificado Asistencia  *</label></td>
		<td>
			<form:select path="certificadoAsistencia" id="certificadoAsistencia" class="required" disabled="true" onchange="habilitarCantInasistencias(this)">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${opciones}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	-->
	<tr>		
		<td nowrap="nowrap"><label>Inasistencias acumuladas  *</label></td>
		<td>
			<form:input path="cantidadInasistencias" id="cantidadInasistencias" class="required" onchange="habilitarMotivoInasistencias(this)" onkeypress="return validarDecimal(event, this);"/>
		</td>
	</tr>
	<tr>		
		<td nowrap="nowrap"><label>Motivo Inasistencias  *</label></td>
		<td>
			<form:textarea path="motivoInasistencia" id="motivoInasistencia" disabled="true" class="required" rows="4" cols="30" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
		</td>		
	</tr> 
	<tr>		
		<td><label>Material Completo</label></td>
		<td>
			<form:checkbox path="materialCompleto" id="materialCompleto" />
		</td>			
	</tr>   
</table>