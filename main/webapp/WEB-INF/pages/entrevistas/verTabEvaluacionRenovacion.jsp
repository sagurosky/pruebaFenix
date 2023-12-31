<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table id="table-informe">
	<tr align="left">
			
	</tr>
	<tr>		
		<td nowrap="nowrap" ><label>Situacion Escolar Diciembre</label></td>
		<td>
			${entrevista.situacionEscolarDiciembre.valor}				
		</td>
	</tr>
	<tr>		
		<td nowrap="nowrap"><label>Situaci�n Renovaci�n  Diciembre</label></td>
		<td>
			${entrevista.evaluacionRenovacionFinal.valor}		
		</td>
	</tr>
	<tr>		
		<td nowrap="nowrap" ><label>Situaci�n Escolar *</label></td>
		<td>
			<form:select path="situacionEscolarMergeada"  id="situacionEscolar" disabled="true">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${situacionEscolar}" itemLabel="valor" itemValue="id"/>				
			</form:select><font size="1">Atenci�n. Este campo aparece en Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
		</td>
	</tr>
	<tr>		
		<td nowrap="nowrap"><label>Situaci�n Renovaci�n  *</label></td>
		<td>
			<form:select path="evaluacionRenovacionMergeada" id="evaluacionRenovacion" disabled="true">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${evaluacionRenovacion}" itemLabel="valor" itemValue="id"/>				
			</form:select><font size="1">Atenci�n. Este campo aparece en Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
		</td>
	</tr>
	<tr>
		<td>
			<b>Renueva con excepci�n</b>
		</td>
		<td>
			<!-- input type="checkbox" 	name="excepcionR" id="excepcionR" value="${entrevista.excepcion}"-->			
			<form:checkbox path="excepcion" id="excepcionR" name="excepcionR" readonly/>
			<input type="text" name="excepcionR" id="excepcionR" value="${entrevista.excepcion}">
			<select id="excepcionR" name="excepcionR">
				<c:choose>
					<c:when test="${entrevista.excepcion == true}">
	     				<option value=0>Seleccione una opci&oacute;n:</option>
						<option value="1" selected="selected">S�</option>
						<option Value="2">No</option>
					</c:when>
					<c:when test="${entrevista.excepcion == false}">
	     				<option value=0>Seleccione una opci&oacute;n:</option>
						<option value="1" >S�</option>
						<option Value="2" selected="selected">No</option>
					</c:when>
					<c:otherwise>
						<option value=0>Seleccione una opci&oacute;n:</option>
						<option value="1" >S�</option>
						<option Value="2" >No</option>
					</c:otherwise>
				</c:choose>
			</select>			 
		</td>	
	</tr>
	<tr>
		<td width="28%"><label>Motivo Pendiente *</label></td>
		<td>
			<form:select path="motivoPendiente" id="motivoPendiente" disabled="true"  disabled="true" >
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${motivoPendiente}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td>
			<font size="1"><b>Queremos informarle que la renovaci�n de la beca de ${alumno.datosPersonales.nombre} ${alumno.datosPersonales.apellido} 
								de la zona de ${alumno.escuela.localidad.zona.nombre} a�n est� pendiente debido a que ...</b>
			</font>
		</td>
	</tr>
	<tr>
		<td><label>Otro Motivo * </label></td>
		<td>
			<form:textarea path="motivoOtro" id="motivoOtro" rows="4" cols="60" disabled="true" cssStyle="width:98%"
			 cssClass="required" onkeypress="chequearLongitud(this);"/>
		</td>
	</tr>
		<tr>
		<td></td>
		<td>
			<table>
				<tr>
					<td>
						<font size="1">
							<b>Quedo a disposici�n ante cualquier consulta.</b>
						</font>
					</td>
				</tr>
				<tr>
					<td>
						<font size="1">
							<b>Saludos,</b>
						</font>
					</td>
				</tr>
				<tr>
					<td>
						<font size="1">Atenci�n. Este campo aparece en Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Motivo no renovacion  * </label></td>
		<td>
			<form:select path="motivoNoRenovacion" id="motivoNoRenovacion" disabled="true">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${motivoNoRenovacion}" itemLabel="valor" itemValue="id"/>				
			</form:select><font size="1">Atenci�n. Este campo aparece en Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
		</td>
	</tr>
	
	<tr>	
		<td><label>Realizo Entrevista</label></td>
		<td>
			<form:checkbox path="realizoEntrevista" id="realizoEntrevista" disabled="true"/>
		</td>
	</tr>
	<tr>
		<td><label>Tipo Contacto</label></td>
		<td>
			<form:select path="tipoContacto" id="tipoContacto" disabled="true">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${tipoContacto}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Otro Tipo Contacto</label></td>
		<td>
			<form:textarea path="motivoTipoContactoOtro" id="motivoTipoContactoOtro" rows="4" cols="60" disabled="true" cssStyle="width:98%" 
			 cssClass="required" onkeypress="chequearLongitud(this);"/>
		</td>
	</tr>
	
</table>