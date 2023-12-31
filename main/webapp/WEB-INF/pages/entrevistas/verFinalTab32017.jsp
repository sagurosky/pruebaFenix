<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<table id="table-informe">
	<!-- ocultado el 11-02-2016
	<tr>
		
		<td width="300"><label>Rendicion Gastos  *</label></td>
		 
		<td width="500">
			
			<form:checkbox path="rendicionGastos" id="rendicionGastos"/>
			
		</td>
	</tr>
	-->
	<tr>		
		<td><label>Uso de la beca  *</label></td>
		<td>
			<input type="hidden" name="rendicionGastos" id="rendicionGastos">
			<form:select path="detalleGastos" id="detalleGastos" disabled="true">
				<form:options items="${detalleGastos}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>		
		<td nowrap="nowrap"><label>Autoevaluaci�n del becado  *</label></td>
		<td>
			<form:checkbox path="autoEvaluacionBecado" id="autoEvaluacionBecado" disabled="true"/>
		</td>			
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Evaluaci�n anual del acompa�amiento</label></td>
		<td>
			<form:textarea path="evaluacionProposito" rows="4" cols="30" disabled="true"/>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Resultado A�o Escolar *</label></td>
		<td>
			<form:select path="situacionEscolarMergeada" id="resultadoAnioEscolar" disabled="true">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${resultadoAnioEscolar}" itemLabel="valor" itemValue="id"/>				
			</form:select><font size="1">Atenci�n. Este campo aparece en Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
		</td>
	</tr>
	<tr>		
		<td nowrap="nowrap"><label>Evaluacion de renovaci�n *</label></td>
		<td>
			<form:select path="evaluacionRenovacionFinal" id="evaluacionRenovacionFinal" disabled="true">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${evaluacionRenovacionFinal}" itemLabel="valor" itemValue="id"/>				
			</form:select><font size="1">Atenci�n. Este campo aparece en Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Motivo de no renovaci�n</label></td>
		<td>
			<form:select path="motivoNoRenovacion" id="motivoNoRenovacion" disabled="true">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${motivoNoRenovacion}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Proyecci�n a�o pr�ximo para quienes finalizan PFE  *</label></td>
		<td>
			<form:select path="proyAnioProximo" id="proyAnioProximo" disabled="true">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${proyeccionAnioProximo}" itemLabel="valor" itemValue="id"/>				
			</form:select>
			<font size="1">Este campo aparece en Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Cambio de Escuela para el pr�ximo a�o</label></td>
		<td>
			<form:textarea path="cambioEscuelaProxAnio" id="cambioEscuelaProxAnio" rows="4" cols="30" disabled="true"/>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Modalidad a cursar en el pr�ximo a�o</label></td>
		<td>
			<form:textarea path="modCursaProxAnio" id="modCursaProxAnio" rows="4" cols="30" disabled="true"/>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap" class="datepicker" ><label>Fecha Entrevista febrero/marzo</label></td>
		<td width="300px"><input name="FechaEntrevFebMarzo" id="datepicker1" disabled="true" value="<fmt:formatDate value="${entrevista.fechaEntrevFebMarzo}" pattern="dd/MM/yyyy"/>"  ></td>
	</tr>
	<tr>		
		<td nowrap="nowrap"><label>Hora Entrevista febrero/marzo </label></td>
		<td>
			<form:input  path="horaProxEntrevista" id="horaProxEntrevista" size="4" disabled="true"/>Hs.
		</td>
	</tr>
	<tr>		
		<td nowrap="nowrap"><label>Lugar Entrevistas Febrero/Marzo</label></td>
		<td>
			<form:select path="lugarProximaEntrevista" disabled="true">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${lugarEntrevistas}" itemLabel="nombre" itemValue="id"/>				
			</form:select>
			<input id="idProxima" type="hidden" value="${entrevista.lugarProximaEntrevista.id}"/>
		</td>
	</tr>
	<tr>
		<td><label>Observaciones</label></td>
		<td>
			<form:textarea path="observacionesGenerales" rows="4" cols="30" disabled="true"/>
		</td>
	</tr>
	<tr>
	<td nowrap="nowrap"><label>Evaluacion Cobro Beca  *</label></td>
		<td>
		<form:select path="evaluacionCobroBeca" id="evaluacionCobroBeca" disabled="true">
			<form:option value="">Seleccione una opci�n...</form:option>
			<form:options items="${evaluacionCobroBeca}" itemLabel="valor" itemValue="id"/>				
		</form:select>
		</td>
	</tr>			
	<tr>
		<td nowrap="nowrap"><label>Motivo de Suspension</label></td>
		<td>
			<form:select path="motivoSuspension" id="motivoSuspension" disabled="true">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${motivoSuspension}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Comentarios de revisi�n, intercambio RR - EA</label></td>
		<td>
			<form:textarea path="comentariosRevision" rows="4" cols="30" disabled="true"/>
		</td>
	</tr>
</table>