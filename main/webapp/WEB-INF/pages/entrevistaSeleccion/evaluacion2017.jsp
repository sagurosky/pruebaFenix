<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<table>
  <tr>
    <td>
    	<p>
    		<label>Información complementaria</label>
    			<form:textarea path="entrevistaSeleccion.informacionComplementaria" rows="2" cols="40" id="perfilAlumno.informacionComplementaria" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/> 
		</p>
    </td>
  </tr>
  <tr>
    <td>
    	<p>
    		<label>Percepciones sobre el candidato</label>
    			<form:textarea path="entrevistaSeleccion.percepcionesCandidato" rows="2" cols="40" id="perfilAlumno.percepcionesCandidato" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/> 
		</p>
    </td>
  </tr>
  <tr>
    <td>
    	<table>
    		<tr>
    			<td>
			    	<p><font color="green"><label>Compromiso escolaridad *</label></font> 
							<select name="idCompromiso" id="compromiso" class="required">
								<option value="">Seleccione una opci&oacute;n:</option>
								<c:forEach items="${listCompromiso}" var="compromiso">
									<c:choose>
											<c:when test="${entrevistaSeleccionDTO.perfilAlumno.compromisoEscolaridad.id == compromiso.id}">
												<option value="${compromiso.id}" selected="selected">${compromiso.valor}</option>
											</c:when>
											<c:otherwise>
												<option value="${compromiso.id}">${compromiso.valor}</option>
											</c:otherwise>	
										</c:choose>
								</c:forEach>
							</select>
					</p>
    			</td>
    			<td>
			    	<p><font color="green"><label>Posibilidad compromiso PFE *</label></font> 
						<select name="idCompromisoPBE" id="compromisoPBE" class="required">
							<option value="">Seleccione una opci&oacute;n:</option>
							<c:forEach items="${listCompromisoPBE}" var="compromisoPBE">
								<c:choose>
										<c:when test="${entrevistaSeleccionDTO.perfilAlumno.compromisoPbe.id == compromisoPBE.id}">
											<option value="${compromisoPBE.id}" selected="selected">${compromisoPBE.valor}</option>
										</c:when>
										<c:otherwise>
											<option value="${compromisoPBE.id}">${compromisoPBE.valor}</option>
										</c:otherwise>	
									</c:choose>
							</c:forEach>
						</select>
					</p>
    			</td>
    		</tr>
    	</table>
    <td>
 <tr>
</table>
</body>
</html>