<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>:: Informe de Seguimiento N� 1 ::</title>
<script type="text/javascript"	src="<c:url value="/static/js/funcionesEntrevista.js"/>"></script>
<script type="text/javascript" src="<c:url  value="/static/js/jquery.blockUI.js"/>"></script>
</head>
<script type="text/javascript">
$(document).ready(function(){

	$("#informeForm").validate({
   		invalidHandler: function(form, validator) {
		var errors = validator.numberOfInvalids();
		if (errors) {
			$.unblockUI();
		}
	}
});
 
});

function enviarForm(action){

	if(action == 'finalizar'){
		document.forms['informeForm'].action = "../informeIS1/actualizarInformeCorrectora.do?accion=" + action;
		$.blockUI();
		$('#informeForm').submit();
	}
	if(action == 'guardar'){
		if (document.forms['informeForm'].informacionSuspension != null) {
			if (document.forms['informeForm'].informacionSuspension.value == "") { 
			      jAlert('warning', 'El campo "Suspensi�n" no puede estar vacio', 'Atenci�n!');
			      document.forms['informeForm'].informacionSuspension.focus();
				}else{
					document.forms['informeForm'].action = "../informeIS1/actualizarInformeCorrectora.do?accion=" + action;
					$.blockUI();
					document.forms['informeForm'].submit();
				}
		}else{
			document.forms['informeForm'].action = "../informeIS1/actualizarInformeCorrectora.do?accion=" + action;
			$.blockUI();
			document.forms['informeForm'].submit();
		}
	}
	if(action == 'supervisar'){
		if (document.forms['informeForm'].informacionSuspension != null) {
			if (document.forms['informeForm'].informacionSuspension.value == "") { 
			      jAlert('warning', 'El campo "Suspensi�n" no puede estar vacio', 'Atenci�n!');
			      document.forms['informeForm'].informacionSuspension.focus();
				}else{
					document.forms['informeForm'].action = "../informeIS1/actualizarInformeCorrectora.do?accion=" + action;
					$.blockUI();
					document.forms['informeForm'].submit();
				}
		}else{
			document.forms['informeForm'].action = "../informeIS1/actualizarInformeCorrectora.do?accion=" + action;
			$.blockUI();
			document.forms['informeForm'].submit();
		}
	}
	
}
</script>
 <script type="text/javascript">
	function chequearLongitud(obj){
		if (obj.value.length > 10000) {
		obj.value = obj.value.substring(0, 10000);
		}
	}
</script>
<body>
<div id="main-content">
<form:form id="informeForm" commandName="informe" cssClass="cmxform"  modelAttribute="informe" action="" method="post">
<h1 id="titulo-informe">:: Informe de Seguimiento N� 1 ::</h1>
    	<table border="0" align="left" cellpadding="0" cellspacing="0" id="table-informe">
    	<tr>
			<td >Correcci�n</td>
		</tr>

    	<tr>
			<td colspan="2"><h1 id="subtitulo-informe">Datos del Becado</h1></td>
		</tr> 
		<tr>
		<td>
		<table width="200" border="0" align="left" cellpadding="0" cellspacing="0" id="table-forms"> 
		<tr>
			<td width="200"><label>Ciclo lectivo:</label></td>
			<td width="600"><label>${informe.cicloActual.nombre}</label></td>
		</tr>	
		<tr>
			<td><label>Alumno:</label></td>
			<td><label>${informe.becado.datosPersonales.nombre}&nbsp;${informe.becado.datosPersonales.apellido}</label></td>
		</tr>
		<tr>
			<td><label>Fecha de Nacimiento:</label></td>
			<td><label><fmt:formatDate value="${informe.becado.datosPersonales.fechaNacimiento}" pattern="dd/MM/yyyy"/></label></td>
		</tr>
		<tr>
			<td><label>Edad:</label></td>
			<td><label>${informe.edad}</label></td>
		</tr>
		<tr>	
			<td><label>Localidad donde vive:</label></td>
			<td><label>${informe.becado.datosPersonales.localidad.nombre}</label></td>
		</tr>
		<tr>	
			<td><label>A&ntilde;o que cursa:</label></td>
			<c:if test="${empty boletin}">
				<td><label>${informe.becado.anioEscolar.valor}</label></td>
			</c:if>
			<c:if test="${!empty boletin}">
				<td><label>${boletin.ano.valor}</label></td>
			</c:if>
		</tr>
		<tr>		
			<td><label>A&ntilde;o adicional:</label></td>
			<td>
				<input type="checkbox" name="anioAdicional"
					<c:if test="${informe.becado.anioAdicional}"> checked="checked" </c:if> 
				id="anioAdicional"  disabled="true">
			</td>
		</tr>
		<tr>
			<td><label>A&ntilde;o estimado de egreso::</label></td>
			<td><label>${informe.anioEgreso}</label></td>						
		</tr>
		<tr>	
			<td><label>Instituci�n educativa:</label></td>
			<td><label>${informe.becado.escuela.nombre}</label>
			</td>
		</tr>	
		<tr>	
			<td><label>Localidad:</label></td>
			<td><label>${informe.becado.escuela.localidad.nombre}</label>
			</td>
		</tr>				
				<c:if test="${!empty informe.becado.responsable2}">
					<tr>
						<td >Responsable Adulto:</td>						
							<td ><label>${informe.becado.responsable2.nombre },&nbsp;${informe.becado.responsable2.apellido}</label>					
					</tr>
					<c:if test="${!empty informe.becado.responsable2.idVinculo}">
						<tr>
							<td >V&iacute;nculo:</td>
							<td ><label>${informe.becado.responsable2.idVinculo.valor}</label></td>
						</tr>
					</c:if>
				</c:if>
				<c:if test="${empty informe.becado.responsable2}">
					<tr>
						<td >Responsable Adulto:</td>						
							<td ><label>${informe.becado.responsable1.nombre },&nbsp;${informe.becado.responsable1.apellido}</label>					
					</tr>
					<c:if test="${!empty informe.becado.responsable1.idVinculo}">
						<tr>
							<td >V&iacute;nculo:</td>
							<td ><label>${informe.becado.responsable1.idVinculo.valor}</label></td>
						</tr>
					</c:if>
				</c:if>
		<tr>
			<td><label>Fecha Incorporaci�n al PFE:</label></td>
			<td><label><fmt:formatDate value="${informe.fechaPBE}" pattern="dd/MM/yyyy"/></label></td>
		</tr>
		<tr>	
			<td><label>Padrino:</label></td>
			<td>
			<label>
				${informe.padrino.empresa.denominacion}			
				${informe.padrino.datosPersonales.nombre}&nbsp;${informe.padrino.datosPersonales.apellido}
			</label>
			</td>
		</tr>
		</table>
		</td>
		</tr>
		<!-- tr>
			<td><a href="">Edici�n de datos del alumno</a></td>
		</tr-->
		<tr>
      	    <td>&nbsp;</td>
       	    <td>&nbsp;</td>
      	</tr>		
    	<tr>
			<td colspan="2"><h1 id="subtitulo-informe">Bolet&iacute;n de calificaciones a&ntilde;o anterior</h1></td>
		</tr>		
		<tr>
		<td colspan="2">
		<c:if test="${informe.boletinAnioAnterior != null}">
			<table>	
				<tr>
					<td>
						<label>
							Recuerda que las materias y/o asistencias, d�as h�biles que contengan en todos los trimestres los valores "No aplica" y/o "No existe" y/o "Sin dato", no ser�n agregados al PDF para el padrino.
						</label>
					</td>
				</tr>
			</table>
			<jsp:include page="/WEB-INF/pages/informes/boletinView.jsp"></jsp:include>
		</c:if>
		</td>
		</tr>			
    	
		<tr>
      	    <td>&nbsp;</td>
       	    <td>&nbsp;</td>
      	</tr>	
		
		<tr>
		<td>
		<table width="200" border="0" align="left" cellpadding="0" cellspacing="0" id="table-forms"> 
		<tr>
			<td width="600"><label>Observaciones sobre materias y ex�menes:</label></td>
			<td width="600"><form:textarea  rows="5" cols="60" path="observacionMateriasExamenes"  onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"></form:textarea></td>
		</tr>
		<tr>
      	    <td>&nbsp;</td>
       	    <td>&nbsp;</td>
      	</tr>		
		<tr>
			<td><label>Situaci�n escolar:</label></td>
			<td>
			<select  name="situacionEscolar" id="situacionEscolar" class="required" >
				<option selected="selected"  value="${situacionEscolar.id}">${situacionEscolar.valor}</option>
				<c:forEach var="situacion" items="${situaciones}">
					<option  value="${situacion.id}">${situacion.valor}</option>
				</c:forEach>
			</select>
			</td>
		</tr>
		<tr>
        	<td>&nbsp;</td>
    	</tr>
    	</table>
    	</td>
    	</tr>
    			
		<tr>
			<td colspan="2"><h1 id="subtitulo-informe">S&iacute;ntesis a&ntilde;o anterior. Prop&oacute;sito para el a&ntilde;o que comienza</h1></td>
		</tr>
	
		<tr>
		<td>
		<table width="200" border="0" align="left" cellpadding="0" cellspacing="0" id="table-forms"> 
		<tr>
			<td valign="top" width="600"><label>Escolaridad y compromiso durante el a�o anterior:</label></td>
			<td width="600"><form:textarea rows="5" cols="60" path="escolaridadCompromisoAnterior" cssClass="required" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"></form:textarea></td>
		</tr>
		<tr>
			<td valign="top"><label>Un dato curioso del estudiante:</label></td>
			<td><form:textarea  rows="5" cols="60" path="actividadesVacaciones" cssClass="required" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/></td>
		</tr>
		<tr>
			<td valign="top"><label>Prop&oacute;sito para el a&ntilde;o que comienza:</label></td>
			<td><form:textarea  rows="5" cols="60" path="propositoAnioComienza" cssClass="required" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/></td>
		</tr>		
		<tr>
			<td valign="top"><label>Expectativas del responsable adulto:</label></td>
			<td><form:textarea  rows="5" cols="60" path="expectativasRA" cssClass="required" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/></td>
		</tr>		
		<tr>
			<td valign="top"><label>Observaciones entrevista de renovaci�n:</label></td>
		   	<td><form:textarea  rows="5" cols="60" path="observaciones"  onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/></td>
		</tr>	
		<c:if test="${!empty informe.informacionSuspension}">
		<tr>
			<td valign="top"><label>Suspensi�n:</label></td>
		   		<td><form:textarea  rows="5" cols="60" path="informacionSuspension" cssClass="required" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/></td>

		</tr>	
		</c:if>		
		<tr>
			<td valign="top"><label>Destino del dinero de la Beca:</label></td>
			<td><form:textarea rows="5" cols="60" path="utilizacionBeca" cssClass="required" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/></td>
		</tr>
		<tr>
      	    <td>&nbsp;</td>
       	    <td>&nbsp;</td>
       	    <td>&nbsp;</td>
      	</tr>
      	</table>
      	</td>
      	</tr>
      	
      	<tr>
			<td colspan="2"><h1 id="subtitulo-informe">Comentarios de Revisi�n</h1></td>
		</tr>
		<tr>
		<td>
		<table width="200" border="0" align="left" cellpadding="0" cellspacing="0" id="table-forms"> 
		<tr>
			<td valign="top" width="600"><label>Comentarios:</label></td>
		   	<td width="600"><form:textarea rows="5"  cols="60" path="comentarios" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);" /></td>
		</tr>					
		<tr>
      	    <td>&nbsp;</td>
       	    <td>&nbsp;</td>
      	</tr>
     	<tr>
        	<td>&nbsp;</td>
    	    <td>&nbsp;</td>
    	</tr>
    	</table>
    	</td>
    	</tr>
      	<tr>
 	       <td colspan="2">
  	       <table width="800" border="0" align="right" cellpadding="0" cellspacing="0" id="table-botons-small">
             <tr>
		  	  <td width="50" height="0" align="center" valign="middle">
		  	  	<input class="ui-state-default ui-corner-all " type="button" onclick="enviarForm('guardar')" value="Guardar" />
		  	  </td>		  
              <td width="50" height="0" align="center" valign="middle">
              	<input type="button" class="ui-state-default ui-corner-all" type="button" onclick="enviarForm('supervisar')" value="Supervisar" />
              </td>
              <td width="50" height="0" align="center" valign="middle">
              	<input type="button" class="ui-state-default ui-corner-all" type="button" onclick="enviarForm('finalizar')" value="Finalizar" />
              </td>
		       <td width="50" align="center" valign="middle">
			  	<input type="button" value="Volver" class="ui-state-default ui-corner-all" 
		       	onclick="location.href='../informes/listaInformesCorreccion.do'; return false;" />
		       </td>
              <td width="292" height="30" align="center" valign="middle">&nbsp;</td>
			 </tr>
	       </table> 
	       </td>
	   </tr>
	</table>
	<input type="hidden" name="id" value="${informe.id}"></input>
	<input type="hidden" name="er.id" value="${informe.er.id}"></input>
	<input type="hidden" name="beca.id" value="${informe.beca.id}"></input>
	<input type="hidden" name="padrino.id" value="${informe.padrino.id}"></input>
	<input type="hidden" name="eaPerfil.idPerfilEA" value="${informe.eaPerfil.idPerfilEA}"></input>
	<input type="hidden" name="rrPerfil.idPerfilRR" value="${informe.rrPerfil.idPerfilRR}"></input>
	<input type="hidden" name="cicloActual.id" value="${informe.cicloActual.id}"></input>
	<input type="hidden" name="fechaAlta"  value="<fmt:formatDate value="${informe.fechaAlta}" pattern="dd/MM/yyyy"/>" ></input>
	<input type="hidden" name="estado" value="${informe.estado}"></input>
	<input type="hidden" name="fechaPBE" value="<fmt:formatDate value="${informe.fechaPBE}" pattern="dd/MM/yyyy"/>""></input>
	<input type="hidden" name="fechaCambioUltimoEstado" value="<fmt:formatDate value="${informe.fechaCambioUltimoEstado}" pattern="dd/MM/yyyy"/>""></input>
	<input type="hidden" name="urlInforme" value="${urlInforme}"></input>
	<input type="hidden" name="informe" value="${informe}"></input>
	<input type="hidden" name="becado.id" value="${informe.becado.id}"></input>
	<input type="hidden" name="edad" value="${informe.edad}"></input>
	<input type="hidden" name="nombre" value="${informe.nombre}"></input>
	<input type="hidden" name="situacionEscolar"  value="${informe.situacion.id}"/>	
	<c:if test="${informe.boletinAnioAnterior != null}">
		<input type="hidden" name="boletinAnioAnterior.id" value="${informe.boletinAnioAnterior.id}"></input>
	</c:if>
</form:form>
</div>
</body>
</html>