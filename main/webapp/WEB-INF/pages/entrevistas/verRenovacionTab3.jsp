<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<table id="table-informe">
	<!-- ocultado el 11-02-2016 
	<tr>
		<td nowrap="nowrap"><label>Expectativas RA</label></td>
		<td>
			<form:textarea path="expectativasRA" rows="4" cols="60" cssStyle="width:98%" disabled="true"/>
		</td>
	</tr>
	 -->
	<!-- ocultado el 11-02-2016
	<tr>		
		<td nowrap="nowrap"><label>Destino Dinero de la Beca  *</label></td>
		<td>
			<form:select path="destinoDinero" disabled="true">
				<form:options items="${detalleGastos}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	-->
	<tr>
		
		<td><label>Observaciones</label></td>
		<td>
			<input type="hidden" id="destinoDinero" name="destinoDinero" value="13">
			<form:textarea path="observacionesGenerales" rows="4" cols="60" cssStyle="width:98%" disabled="true"/>
		</td>
	</tr>
	<tr>	
		<td class="datepicker1" nowrap="nowrap"><label>Fecha Proxima Entrevista  *</label></td>
		<td><form:input path="proximaEntrevista" id="datepicker1" disabled="true"/></td>
	</tr>
	<tr>		
		<td nowrap="nowrap"><label>Hora Proxima Entrevista  *</label></td>
		<td>
			<form:input  path="horaProxEntrevista" id="horaProxEntrevista" size="4" disabled="true"/>Hs.
		</td>
	</tr>
	<tr>		
		<td nowrap="nowrap"><label>Lugar Proxima Entrevistas  *</label></td>
		<td>
			<input type="text" id="lugarProximaEntrevista" name="lugarProximaEntrevista" size="39" value="${escuelaZona}" disabled="true"/>
			<input type="hidden" id="idProxima" name="lugarProximaEntrevista.id" value="${entrevista.lugarProximaEntrevista.id}"></input>
		</td>
	</tr> 
	<tr>
		<td><label>Entrega Material  </label></td>
		<td>
			<form:checkbox path="entregaMaterial" disabled="true"/>
		</td>
	</tr>
	<tr>
	<td nowrap="nowrap" valign="top"><label>Evaluacion Cobro Beca  *</label></td>
		<td>
		<form:select path="evaluacionCobroBeca" id="evaluacionCobroBeca" disabled="true" >
			<form:option value="">Seleccione una opci�n...</form:option>
			<form:options items="${evaluacionCobroBeca}" itemLabel="valor" itemValue="id"/>				
		</form:select>
		</td>
	</tr>	
	<tr>
		<td nowrap="nowrap"><label>Motivo de Suspension  *</label></td>
		<td>
			<form:select path="motivoSuspension" id="motivoSuspension" disabled="true">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${motivoSuspension}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap" width="32%"><label>Comentarios de revisi�n, intercambio RR - EA</label></td>
		<td>
			<form:textarea path="comentariosRevision" rows="4" cols="60" cssStyle="width:98%" disabled="true"/>
		</td>
	</tr>		
</table>