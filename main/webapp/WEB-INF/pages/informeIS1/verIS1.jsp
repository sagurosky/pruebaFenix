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
</head>

<body>
<div id="main-content">

<br><br>
<form:form id="informeForm" commandName="informe" cssClass="cmxform"  modelAttribute="informe">
 <c:if test="${informe.estado.valor != estadoInformeRevision}">
  	
		<label>
			<font color="red">Este Informe no puede ser modificado. De necesitar hacer alg�n cambio es preciso modificar<br> el estado de la entrevista 
			de renovaci�n que lo gener�. Para ello, contacte a un super usuario.</font>
		</label>
	
</c:if>
<c:if test="${informe.estado.valor == estadoInformeRevision}">
  	
		<label>
			<font color="red">Este Informe no puede ser modificado. Solo DI puede cambiar el estado del mismo.</font>
		</label>
	
</c:if>
<br>Estado del IS1: ${informe.estado.valor}<br>
<h1 id="titulo-informe">PROGRAMA DE FUTUROS EGRESADOS</h1>
<h1 id="titulo-informe">INFORME DE SEGUIMIENTO N� 1 - A�O ${informe.cicloActual.nombre}</h1>
<h1 id="titulo-informe">${informe.becado.datosPersonales.nombre}&nbsp;${informe.becado.datosPersonales.apellido}</h1>		

		<table border="0" align="left" cellpadding="0" cellspacing="0" id="table-informe">
		<tr>
			<td colspan="2"><h1 id="titulo-informe">Datos del Alumno</h1></td>
		</tr>
		<tr>
			
						<td><label>Localidad:</label></td>
						<td><label>${informe.becado.datosPersonales.localidad.nombre}</label></td>
					</tr>
					<tr>
						<td nowrap="nowrap"><label>Fecha de Nacimiento:</label></td>
						<td><label><fmt:formatDate value="${informe.becado.datosPersonales.fechaNacimiento}" pattern="dd/MM/yyyy"/></label></td>
					</tr>
					<tr>
						<td><label>Edad:</label></td>
						<td><label>${informe.edad}</label></td>
					</tr>
					<tr>	
						<td><label>Escuela:</label></td>
						<td><label>${informe.becado.escuela.nombre}</label>
						</td>
					</tr>	
					<tr>	
						<td nowrap="nowrap"><label>A&ntilde;o escolar que cursa:</label></td>
						<td><label>${informe.becado.anioEscolar.valor}</label></td>
					</tr>
					
					<tr>
						<td nowrap="nowrap"><label>Fecha estimada de egreso::</label></td>
						<td><label>${informe.anioEgreso}</label></td>						
					</tr>
					
					
					<c:if test="${!empty informe.becado.responsable2}">
						<tr>
							<td nowrap="nowrap"><label>Responsable Adulto:</label></td>						
							<td><label>${informe.becado.responsable2.nombre },&nbsp;${informe.becado.responsable2.apellido}</label>					
						</tr>
						<c:if test="${!empty informe.becado.responsable2.idVinculo}">
							<tr>
								<td><label>V&iacute;nculo:</label></td>
								<td><label>${informe.becado.responsable2.idVinculo.valor}</label></td>
							</tr>
						</c:if>
					</c:if>
					<c:if test="${empty informe.becado.responsable2}">
						<tr>
							<td nowrap="nowrap"><label>Responsable Adulto:</label></td>						
							<td><label>${informe.becado.responsable1.nombre },&nbsp;${informe.becado.responsable1.apellido}</label>					
						</tr>
						<c:if test="${!empty informe.becado.responsable1.idVinculo}">
							<tr>
								<td><label>V&iacute;nculo:</label></td>
								<td><label>${informe.becado.responsable1.idVinculo.valor}</label></td>
							</tr>
						</c:if>
					</c:if>
					
					<tr>	
						<td><label>Padrino:</label></td>
						<td><label>
							${informe.padrino.empresa.denominacion}			
							${informe.padrino.datosPersonales.nombre}&nbsp;${informe.padrino.datosPersonales.apellido}</label>
						</td>
					</tr> 
					
					<tr>
						<td><br><label>Informaci�n adicional del estudiante:</label></td>
					
						<td>					
							${informe.actividadesVacaciones}
						</td>
					</tr>
					
					
					
					
					
					<tr>
						<td colspan="2"><h1 id="titulo-informe">Informaci�n Escolar</h1></td>
					</tr>
					
					
					<c:if test="${!empty informe.situacion}">
						<tr>
							<td nowrap="nowrap"><label>Situaci�n escolar:</label></td>
							<td><label>${informe.situacion.valor}</label></td>
						</tr>
					</c:if>
					<c:if test="${!empty informe.becado.estadoRenovacion}">
						<tr>
							<td nowrap="nowrap"><label>Situaci�n en el programa:</label></td>
							<td><label>${informe.er.evaluacionRenovacionMergeada.valor}</label></td>
						</tr>
					</c:if>
					
					<tr>
						<td nowrap="nowrap"><br><label>Detalle sobre la situaci�n de renovaci�n:</label></td>
					
						<td>					
							${informe.observacionesExcepcion}
						</td>
					</tr>
					
					<tr>
						<td colspan="2"><h1 id="titulo-informe">Acompa�amiento</h1><br></td>
					</tr>
					<tr>
						<td nowrap="nowrap"><br><label>Prop�sito anual del acompa�amiento:</label></td>	
						<td>					
							${informe.propositoAnioComienza}
						</td>
					</tr>
					
					
							
				
    	
					<tr>
						<td colspan="2"><h1 id="titulo-informe">Informaci�n de la Escuela</h1></td>
					</tr>
				
				
				
				<tr>
					<td nowrap="nowrap"><label>Matr�cula total:</label></td>
					<td><label>${informe.becado.escuela.matricula}</label></td>
					
				</tr>
				<tr>
					<td nowrap="nowrap"><label>Orientaci�n:</label></td>
					<td><label>${informe.becado.escuela.orientacion}</td>
					
				</tr>
				<tr>
					<td nowrap="nowrap"><label>Descripci�n escuela:</label></td>
					<td><label>${informe.becado.escuela.observaciones}</label></td>
					
				</tr>
				<tr>
					<td nowrap="nowrap"><label>El Programa se implementa desde:</label></td>
					<td><label>${informe.becado.escuela.comienzoPBE.nombre}</label></td>
					
				</tr>
									
		<tr>
      	    
       	    <td colspan="2"><br><br>Aviso: el contenido de este informe es confidencial y no podr� ser reproducido de ninguna forma sin previa autorizaci�n por parte de Cimientos</td>
      	</tr>
      	<tr>      	    
       	    <td></td>
       	    <td nowrap="nowrap">
       	    	${informe.eaPerfil.datosPersonales.nombre} ${informe.eaPerfil.datosPersonales.apellido}
       	    <br>Encargado de Acompa�amiento<br>Programa Futuros Egresados - Cimientos</td>
      	</tr>
      	
     	
      	<tr>
 	       <td colspan="2">
				<table width="900" border="0" align="right" cellpadding="0" cellspacing="0" id="table-botons-small">
 	       			<tr>
					  <td width="50" align="center" valign="middle">
					  	<center>
							<input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="history.back();" />
						</center>
				       </td>
 	       			</tr>
 	       		</table>			
	       </td>
	   </tr>
	</table>
	<input type="hidden" name="id" value="${informe.id}"></input>
	<input type="hidden" name="er.id" value="${informe.er.id}"></input>
	<input type="hidden" name="eaPerfil.idPerfilEA" value="${informe.eaPerfil.idPerfilEA}"></input>
	<input type="hidden" name="estado" value="${informe.estado}"></input>
	<input type="hidden" name="padrino.id" value="${informe.padrino.id}"></input>
	<input type="hidden" name="becado.id" value="${informe.becado.id}"></input>	
	<input type="hidden" name="urlInforme" value="${urlInforme}"></input>
	<input type="hidden" name="edad" value="${informe.edad}"></input>
	<input type="hidden" name="nombre" value="${informe.nombre}"></input>
	<c:if test="${informe.boletinAnioAnterior != null}">
		<input type="hidden" name="boletinAnioAnterior.id" value="${informe.boletinAnioAnterior.id}"></input>
	</c:if>
</form:form>
</div>
</body>
</html>