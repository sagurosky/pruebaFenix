<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<strong><font color="red">Record� que esta informaci�n la recibe el padrino en el Informe N�1. Te pedimos que redactes en tercera persona y cuides la ortograf�a</font></strong>
<table id="table-informe">
		
	<!-- ocultado el 11-02-2016
	<tr>	
		<td colspan="2">
			<font size="1">Por favor elige la opci�n que mejor refleje el prop�sito planteado para el a�o que comienza 
							para ser incluido en el Informe a padrino.</font>			
		</td>
	</tr>
	
	<tr>
		<td nowrap="nowrap"><label>Prop�sito anual del Acompa�amiento</label></td>
		<td>			
			<form:select path="propositoAnioComienzaList" id="propositoAnioComienzaList" disabled="true" class="required">
				<form:options items="${propositoAnioComienzaList}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	 -->
	<tr>
		<td nowrap="nowrap" >
			<input type="hidden" name="observacionesGenerales" id="observacionesGenerales" >
			<label>En el tiempo libre le gusta</label>
			<br><font size="1">(Este campo va al Informe)</font>
		</td>
		<td>			
			<form:select path="gustosTiempoLibre" id="gustosTiempoLibre" disabled="true" class="textbox2">
				<form:options items="${gustosTiempoLibre}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>	
</table>