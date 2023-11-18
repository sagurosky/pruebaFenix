<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<table id="table-informe">
	<tr>		
		<td nowrap="nowrap"><label>Situaci�n Incorporaci�n   *</label></td>
		<td>
			<form:select path="incorporacion" id="incorporacion" class="textbox2" onchange="habilitarCamposIncorporacion(this)" >
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${evaluacionIncorporacion}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap" width="32%"><label>Motivo Incorporaci�n Pendiente   *</label></td>
		<td>
			<form:select path="motivoPendiente" id="motivoPendiente" disabled="true"  class="textbox2" onchange="habilitarMotivoPendiente(this)">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${motivoPendiente}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Otro Motivo   * </label></td>
		<td>
			<form:textarea path="motivoOtroPendiente" id="motivoOtroPendiente" rows="4" cols="60" disabled="true" cssStyle="width:98%" 
			 class="textbox2" onkeypress="chequearLongitud(this);"/>
		</td>
	</tr>
	<tr>		
		<td nowrap="nowrap"><label>Motivo No Incorporaci�n   *</label></td>
		<td>
			<form:select path="motivoNoIncorporacion" id="motivoNoIncorporacion" class="textbox2" disabled="true"  	onchange="habilitarOtroMotivoNoIncorporacion(this)">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${motivoNoIncorporacion}" itemLabel="valor" itemValue="id" />				
			</form:select>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Otro Motivo   *</label></td>
		<td>
			<form:textarea path="motivoNoIncorporacionOtro" id="motivoNoIncorporacionOtro" rows="4" cols="60" disabled="true" 
				cssStyle="width:98%" class="textbox2" onkeypress="chequearLongitud(this);"/>
		</td>
	</tr>
	
	<tr>
		<td>
			<label for="sel1">Situaci�n Escolar &nbsp;&nbsp;</label>
		</td>
		<td>
				<form:select path="situacionEscolarMergeada" id="resultadoAnioEscolar" style='width:auto' class="form-control required">
			<form:option value="">Seleccione una opcion...</form:option>
			<form:options items="${resultadoAnioEscolar}" itemLabel="valor" itemValue="id"/>					
				</form:select>	  		
		</td>
	</tr>
	
	
	
	
	
	
	
	
	
	
	
			
	<tr>
		<td nowrap="nowrap"><label>Detallar informaci�n sobre la<br> situaci�n de incorporaci�n del estudiante</label></td>
		<td>
			<form:textarea path="observacionesNoIncorporacion" id="observacionesNoIncorporacion" rows="4" cols="60"
				cssStyle="width:98%" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);" class="textbox2"  placeholder="Brindar informaci�n cualitativa sobre el cierre del ciclo lectivo anterior. En caso de que adeude materias detallar �cu�les son? �Qu� dificultades tiene con respecto a la materia? �hubo mesas de examen?, �c�mo le fue en las �ltimas mesas?. Esta informaci�n se env�a al padrino"/>				
		</td>
	</tr>	
	<tr>
		<td>
		
		<input type ="hidden" id="realizoEntrevista" id="realizoEntrevista" value="1">
		<input type ="hidden" id="tipoContacto" id="tipoContacto" value="">
		</td>
	</tr>
	<tr>
		<td>
		<input type ="hidden" id="motivoTipoContactoOtro" id="motivoTipoContactoOtro" value="">			
		</td>
	</tr>
	
	<tr>		
		<td><label>Acta de Compromiso firmada por EP y RA</label></td>
		<td>
			<form:select path="firmaActaCompromiso" id="firmaActaCompromiso" class="textbox2"
					onchange="habilitarMaterialCompletoFirmaActaCompromiso(this)">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${opciones}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	
	<tr>	
		<td nowrap="nowrap"><label>Notificaci�n Cierre cuenta bancaria firmada</label></td>
		<td>
			<form:select path="firmaAutorizacionCierreCaja" id="firmaAutorizacionCierreCaja" class="textbox2" 
					onchange="habilitarMaterialCompletoFirmaAutorizacionCierreCaja(this)" >
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${opciones}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	
	<tr>		
		<td nowrap="nowrap" ><label>Autorizaci�n Uso de Imagen firmada</label></td>
		<td>
			<form:select path="firmaAutorizacionImagen" id="firmaAutorizacionImagen" class="textbox2"
					onchange="habilitarMaterialCompletoFirmaAutorizacionImagen(this)">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${opciones}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	
	<tr>		
		<td nowrap="nowrap" width="32%"><label> Autorizaci�n Cesi�n de datos firmada</label></td>
		<td>
			<form:checkbox path="materialCompleto" id="materialCompleto" onclick="this.checked = !this.checked"/>
			
			
			
		</td>			
	</tr>
	
	
			
</table>