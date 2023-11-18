<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.ArrayList"%>


<Script>
	function verificarCantidad(){
		//alert(document.getElementById("contenidosAbordados").length);
		var e = document.getElementById("contenidosAbordados");
		var a=0;
		for (var i = 0; i < e.length; i++){				
				if(e.options[i].selected == true){
				var name = e[i].getAttribute("text");
				a++;								
				}
		}
		if(a>2){
			alert("Ten�s que seleccionar no m�s de 2 habilidades y/o contenidos. Seleccionaste "+a);
		}
		
	} 
</Script>

<Script>
	function verificarCantidad(){
		//alert(document.getElementById("contenidosAbordados").length);
		var e = document.getElementById("contenidosAbordados");
		var a=0;
		for (var i = 0; i < e.length; i++){				
				if(e.options[i].selected == true){
				var name = e[i].getAttribute("text");
				a++;								
				}
		}
		if(a>2){
			alert("Ten�s que seleccionar no m�s de 2 habilidades y/o contenidos. Seleccionaste "+a);
		}
		
	} 
</Script>
<style>
	 span{ background-color: yellow; }
</style>
<table id="table-informe">
	<c:if test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">
		<tr>
			<td nowrap="nowrap"><label>Valoraci�n compromiso AB con el<br>acompa�amiento</label></td>
			<td>
				<select id="ecabp" name="ecabp" disabled="disabled">
					
	   					<c:if test="${entrevista.ecabp == 'Malo'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Malo" selected="selected">Malo</option>
							<option value="Regular">Regular</option>
							<option value="Bueno">Bueno</option>
							<option value="Muy Bueno">Muy Bueno</option>
							<option value="Excelente">Excelente</option>
						</c:if>
						<c:if test="${entrevista.ecabp == 'regular'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Malo">Malo</option>
							<option value="Regular" selected="selected">Regular</option>
							<option value="Bueno">Bueno</option>
							<option value="Muy Bueno">Muy Bueno</option>
							<option value="Excelente">Excelente</option>
						</c:if>
						<c:if test="${entrevista.ecabp == 'Bueno'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Malo">Malo</option>
							<option value="Regular">Regular</option>
							<option value="Bueno" selected="selected">Bueno</option>
							<option value="Muy Bueno">Muy Bueno</option>
							<option value="Excelente">Excelente</option>
						</c:if>
						<c:if test="${entrevista.ecabp == 'Muy Bueno'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Malo">Malo</option>
							<option value="Regular">Regular</option>
							<option value="Bueno">Bueno</option>
							<option value="Muy Bueno" selected="selected">Muy Bueno</option>
							<option value="Excelente">Excelente</option>
						</c:if>
						<c:if test="${entrevista.ecabp == 'Excelente'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Malo">Malo</option>
							<option value="Regular">Regular</option>
							<option value="Bueno">Bueno</option>
							<option value="Muy Bueno">Muy Bueno</option>
							<option value="Excelente" selected="selected">Excelente</option>
						</c:if>
						
						<c:if test="${entrevista.ecabp != 'Malo' && entrevista.ecabp != 'Regular'  && entrevista.ecabp != 'Bueno'  && entrevista.ecabp != 'Muy Bueno'  && entrevista.ecabp != 'Excelente'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Malo">Malo</option>
							<option value="Regular">Regular</option>
							<option value="Bueno">Bueno</option>
							<option value="Muy Bueno">Muy Bueno</option>
							<option value="Excelente">Excelente</option>
						</c:if>
						
				</select>
			</td>
		</tr>
		<tr>
			<td nowrap="nowrap"><label>Valoraci�n Compromiso RA con el <br>acompa�amiento</label></td>
			<td>
				<select id="vcrae" name="vcrae" disabled="disabled">
					
	   					<c:if test="${entrevista.vcrae == 'Malo'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Malo" selected="selected">Malo</option>
							<option value="Regular">Regular</option>
							<option value="Bueno">Bueno</option>
							<option value="Muy Bueno">Muy Bueno</option>
							<option value="Excelente">Excelente</option>
						</c:if>
						<c:if test="${entrevista.vcrae == 'Regular'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Malo">Malo</option>
							<option value="Regular" selected="selected">Regular</option>
							<option value="Bueno">Bueno</option>
							<option value="Muy Bueno">Muy Bueno</option>
							<option value="Excelente">Excelente</option>
						</c:if>
						<c:if test="${entrevista.vcrae == 'Bueno'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Malo">Malo</option>
							<option value="Regular">Regular</option>
							<option value="Bueno" selected="selected">Bueno</option>
							<option value="Muy Bueno">Muy Bueno</option>
							<option value="Excelente">Excelente</option>
						</c:if>
						<c:if test="${entrevista.vcrae == 'Muy Bueno'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Malo">Malo</option>
							<option value="Regular">Regular</option>
							<option value="Bueno">Bueno</option>
							<option value="Muy Bueno" selected="selected">Muy Bueno</option>
							<option value="Excelente">Excelente</option>
						</c:if>
						<c:if test="${entrevista.vcrae == 'Excelente'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Malo">Malo</option>
							<option value="Regular">Regular</option>
							<option value="Bueno">Bueno</option>
							<option value="Muy Bueno">Muy Bueno</option>
							<option value="Excelente" selected="selected">Excelente</option>
						</c:if>
						
						<c:if test="${entrevista.vcrae != 'Malo' && entrevista.vcrae != 'Regular'  && entrevista.vcrae != 'Bueno'  && entrevista.vcrae != 'Muy Bueno'  && entrevista.vcrae != 'Excelente'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Malo">Malo</option>
							<option value="Regular">Regular</option>
							<option value="Bueno">Bueno</option>
							<option value="Muy Bueno">Muy Bueno</option>
							<option value="Excelente">Excelente</option>
						</c:if>
						
				</select>
			</td>
		</tr>		
	</c:if>
	<c:if test="${!entrevista.periodoDePago.nombre=='Julio' || !periodo.nombre=='Julio' }">
			<tr>			
				<td nowrap="nowrap"><label>Cumplimiento de prop�sitos<br>acordados con el EA:</label></td>
				
				<td>
					<select id="cpaEA" name="cpaEA"  disabled="disabled">
						
		   					<c:if test="${entrevista.cpaEA == 'Si'}">
								<option value="0" >Seleccione una opci�n</option>
								<option value="Si" selected="selected">Si</option>
								<option value="No">No</option>
							</c:if>
							<c:if test="${entrevista.cpaEA == 'No'}">
								<option value="0" >Seleccione una opci�n</option>
								<option value="Si">Si</option>
								<option value="No" selected="selected">No</option>
							</c:if>
							<c:if test="${entrevista.cpaEA != 'Si' && entrevista.cpaEA != 'No' }">
								<option value="0" >Seleccione una opci�n</option>
									<option value="Si">Si</option>
									<option value="No">No</option>
							</c:if>
							
					</select>
				</td>
		</tr>
	</c:if>
	<c:if test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">
		<tr>
			<td nowrap="nowrap"><label>Seguimientos de Prop�sito anual</label></td>
			<td>
				<form:textarea path="propositoAnual"  id="propositoAnual" class="textbox2" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"  disabled="disabled"/>											
			</td>											   		
			</tr>
		</c:if>
	
	<c:if test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">
		<tr>		
			<td><label>Situacion de Riesgo</label></td>
			<td>
				<input type="hidden" name="compromisoRA" id="compromisoRA" value="1">
				<input type="hidden" name="estrategiaComp" id="estrategiaComp" value="5">
				<form:select path="situacionCrisis">
					<form:options items="${situacionCrisis}" itemLabel="valor" itemValue="id"  disabled="disabled"/>				
				</form:select>
				<input type="hidden" id="horaProxEntrevista" name="horaProxEntrevista" value="12:00">
				<input type="hidden" id="lugarProximaEntrevista" name="lugarProximaEntrevista" size="39" value="${escuelaZona}" />
				<input type="hidden" id="idProxima" name="lugarProximaEntrevista.id" value="${entrevista.lugarProximaEntrevista.id}"></input>
			</td>
		</tr>	
	</c:if>
	<c:if test="${!entrevista.periodoDePago.nombre=='Julio' || !periodo.nombre=='Julio' }">	
		<tr>		
			<td></td>
			<td>
				<input type="hidden" name="compromisoRA" id="compromisoRA" value="1">
				<input type="hidden" name="estrategiaComp" id="estrategiaComp" value="5">
				<input type="hidden" name="situacionCrisis" id="situacionCrisis" value="">					
				<input type="hidden" id="horaProxEntrevista" name="horaProxEntrevista" value="12:00">
				<input type="hidden" id="lugarProximaEntrevista" name="lugarProximaEntrevista" size="39" value="${escuelaZona}" disabled="true" />
				<input type="hidden" id="idProxima" name="lugarProximaEntrevista.id" value="${entrevista.lugarProximaEntrevista.id}"></input>
				<input type="hidden" name="ossr" id="ossr" value="">
			</td>
		</tr>
	</c:if>
	<c:if test="${!entrevista.periodoDePago.nombre=='Julio' || !periodo.nombre=='Julio' }">
		<tr>
			<td nowrap="nowrap"><label>Observaciones sobre situaciones de riesgo</label></td>
			<td>
				<form:textarea path="ossr" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);" disabled="disabled"/>
			</td>
		</tr>
	</c:if>	
	<tr>
		<td nowrap="nowrap"><label>Observaciones sobre rendimiento<br>escolar y asistencia</label><br><br>
		<font size="1">Atenci�n. Este campo va al Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
		</td>
		<td>
			<form:textarea path="osme" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"  disabled="disabled"/>
		</td>
	</tr>
	<c:if test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">	
		<tr>
			<td></td>
			<td>
				<input type="hidden" id="osare" name="osare" value="">				
			</td>
		</tr>
	</c:if>
	<c:if test="${!entrevista.periodoDePago.nombre=='Julio' || !periodo.nombre=='Julio' }">	
		<tr>
			<td nowrap="nowrap"><label>Observac.sobre alumnos<br>renovados p/excepci�n</label></td>
			<td>
				<form:textarea path="osare" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);" disabled="disabled"/>
			</td>
		</tr>
	</c:if>
	
	<c:if test="${entrevista.periodoDePago.nombre=='Julio' || periodo.nombre=='Julio' }">
		<tr>
		<td nowrap="nowrap"><label>Principal habilidad trabajada durante<br>la primera parte a�o</label></td>		
		<td>
			<form:select path="hsTrabajarA�o" id="hsTrabajarA�o" class="textbox2"  disabled="disabled"> 
				<c:choose>
   					<c:when test="${entrevista.hsTrabajarA�o == 'Autoconcepto'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Autoconcepto" selected="selected">Autoconcepto</option>
						<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
						<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
						<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
				    	<option Value="Toma de decisiones">Toma de decisiones</option>				    	  						    
				    </c:when>	
				    <c:when test="${entrevista.hsTrabajarA�o == 'Planificaci�n y organizaci�n del tiempo'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Autoconcepto" >Autoconcepto</option>
						<option Value="Planificaci�n y organizaci�n del tiempo" selected="selected">Planificaci�n y organizaci�n del tiempo</option>									
						<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
						<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
				    	<option Value="Toma de decisiones">Toma de decisiones</option>				    	  						    
				    </c:when>	
				    <c:when test="${entrevista.hsTrabajarA�o == 'Relaciones interpersonales'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Autoconcepto">Autoconcepto</option>
						<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
						<option Value="Relaciones interpersonales"  selected="selected">Relaciones interpersonales</option>
						<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
				    	<option Value="Toma de decisiones">Toma de decisiones</option>				    	  						    
				    </c:when>	
				    <c:when test="${entrevista.hsTrabajarA�o == 'Responsabilidad y autonom�a'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Autoconcepto">Autoconcepto</option>
						<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
						<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
						<option Value="Responsabilidad y autonom�a" selected="selected">Responsabilidad y autonom�a</option>								
				    	<option Value="Toma de decisiones">Toma de decisiones</option>				    	  						    
				    </c:when>	
				    <c:when test="${entrevista.hsTrabajarA�o == 'Toma de decisiones'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Autoconcepto">Autoconcepto</option>
						<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
						<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
						<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
				    	<option Value="Toma de decisiones" selected="selected">Toma de decisiones</option>				    	  						    
				    </c:when>					    
				    <c:otherwise>
				    	<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Autoconcepto">Autoconcepto</option>
						<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
						<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
						<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
				    	<option Value="Toma de decisiones">Toma de decisiones</option>		
				    </c:otherwise>		
				</c:choose>
			</form:select>
			<font size="1">Atenci�n. Este campo va al Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
		</td>					
		</tr>
		<tr>
		<td nowrap="nowrap"><label>Contenidos abordados</label></td>
		<td>
			<form:select path="contenidosTrabajarDuranteAnio" id="contenidosTrabajarDuranteAnio" class="textbox2"  disabled="disabled">
				<c:choose>
   					<c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Asertividad y comunicaci�n'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n" selected="selected">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima</option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>	
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Autoconocimiento y autoestima'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n" >Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima" selected="selected">Autoconocimiento y autoestima</option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Autocontrol y determinaci�n'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima</option>															
						<option Value="Autocontrol y determinaci�n" selected="selected">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Autoeficacia y autoconfianza'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n" >Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza" selected="selected">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Autonom�a'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n" >Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a" selected="selected">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Convivencia y Resoluci�n de conflictos'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos" selected="selected">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Egreso efectivo y transici�n post-escolar'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar" selected="selected">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Elecci�n de la orientaci�n y cambio de ciclo'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo" selected="selected">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Empat�a y trabajo con otros'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros" selected="selected">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Entusiasmo por aprender'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender" selected="selected">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'H�bitos de estudio'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio" selected="selected">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Materias previas'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas" selected="selected">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Organizaci�n del tiempo'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo" selected="selected">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Participaci�n'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n" selected="selected">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Participaci�n en PFE'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE" selected="selected">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Pensamiento cr�tico y creativo'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo" selected="selected">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Planificaci�n'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n" selected="selected">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Planificaci�n y proyecto de vida'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida" selected="selected">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Responsabilidad y compromiso'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso"  selected="selected">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Sentido de la oportunidad'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad" selected="selected">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>
				    <c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Transici�n primaria-secundaria'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria" selected="selected">Transici�n primaria-secundaria</option>				    	  						    
				    </c:when>						    
				    <c:otherwise>
				    	<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima</option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convivencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
				    	<option Value="Egreso efectivo y transici�n post-escolar">Egreso efectivo y transici�n post-escolar</option>
				    	<option Value="Elecci�n de la orientaci�n y cambio de ciclo">Elecci�n de la orientaci�n y cambio de ciclo</option>
				    	<option Value="Empat�a y trabajo con otros">Empat�a y trabajo con otros</option>
				    	<option Value="Entusiasmo por aprender">Entusiasmo por aprender</option>
				    	<option Value="H�bitos de estudio">H�bitos de estudio</option>
				    	<option Value="Materias previas">Materias previas</option>
				    	<option Value="Organizaci�n del tiempo">Organizaci�n del tiempo</option>
				    	<option Value="Participaci�n">Participaci�n</option>
				    	<option Value="Participaci�n en PFE">Participaci�n en PFE</option>
				    	<option Value="Pensamiento cr�tico y creativo">Pensamiento cr�tico y creativo</option>
				    	<option Value="Planificaci�n">Planificaci�n</option>
				    	<option Value="Planificaci�n y proyecto de vida">Planificaci�n y proyecto de vida</option>
				    	<option Value="Responsabilidad y compromiso">Responsabilidad y compromiso</option>
				    	<option Value="Sentido de la oportunidad">Sentido de la oportunidad</option>
				    	<option Value="Transici�n primaria-secundaria">Transici�n primaria-secundaria</option>		
				    </c:otherwise>		
				</c:choose>
			</form:select>
			<font size="1">Atenci�n. Este campo va al Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
		</td>							
		</tr>			
		<tr>	
			<td><label>Usaste el fichero?</label></td>
			<td>
				<form:checkbox path="usasteFichero" id="usasteFichero"  disabled="disabled"/>
			</td>
		</tr>
		<tr>	
			<td><label>Completaste la br�jula?</label></td>
			<td>
				<form:checkbox path="brujula" id="brujula"  disabled="disabled"/>
			</td>
		</tr>
		<tr>
			<td nowrap="nowrap"><label>Qu� trabajaste en acompa�amiento<br>en esta primera parte del a�o</label>
			<br><br>
			<font size="1">Atenci�n. Este campo va al Informe al padrino.</font><img src="../static/images/atencion.gif" width=10></td>
			<td>
				<form:textarea path="qtam" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);" disabled="disabled"/>
				
			</td>
		</tr>
		
		
		<!-- ESTO SOLO ES PARA LOS EGRESADOS -->
		
		<c:set var="egreso" value="${0}"/>
		<c:if test="${alumno.escuela.zonaCimientos.eae=='6/6'}">
	    	<c:if test="${alumno.anioAdicional}">
				<c:set var="egreso" value="${alumno.beca.ciclo.nombre+14-alumno.anioEscolar.id+1}" />
				
			</c:if>
			<c:if test="${!alumno.anioAdicional}">
				
				<c:set var="egreso" value="${alumno.beca.ciclo.nombre+14-alumno.anioEscolar.id}" />
			</c:if>
		</c:if>
		<c:if test="${alumno.escuela.zonaCimientos.eae=='7/5'}">
	    	<c:if test="${alumno.anioAdicional}">
				
				<c:set var="egreso" value="${alumno.beca.ciclo.nombre+13-alumno.anioEscolar.id+1}" />
			</c:if>
			<c:if test="${!alumno.anioAdicional}">
				<c:set var="egreso" value="${alumno.beca.ciclo.nombre+13-alumno.anioEscolar.id}" />
			</c:if>
		</c:if>
		<c:if test="${egreso==2018}">
		
			<tr>
				<td  nowrap="nowrap"><label>Proyecci�n post-escolar del AB</label></td>
				<td>	
					<select id="sarpepe" name="sarpepe" disabled="disabled">				
	   					<c:if test="${entrevista.sarpepe == 'Tiene pensado estudiar'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Tiene pensado estudiar" selected="selected">Tiene pensado estudiar</option>
							<option value="Tiene pensado estudiar y trabajar">Tiene pensado estudiar y trabajar</option>
							<option value="Tiene pensado trabajar">Tiene pensado trabajar</option>
							<option value="Aun no lo sabe">Aun no lo sabe</option>
						</c:if>
						<c:if test="${entrevista.sarpepe == 'Tiene pensado estudiar y trabajar'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Tiene pensado estudiar">Tiene pensado estudiar</option>
							<option value="Tiene pensado estudiar y trabajar" selected="selected">Tiene pensado estudiar y trabajar</option>
							<option value="Quiere trabajar">Quiere trabajar</option>
							<option value="Aun no lo sabe">Aun no lo sabe</option>
						</c:if>
						<c:if test="${entrevista.sarpepe == 'Tiene pensado trabajar'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Tiene pensado estudiar">Tiene pensado estudiar</option>
							<option value="Tiene pensado estudiar y trabajar">Tiene pensado estudiar y trabajar</option>
							<option value="Tiene pensado trabajar"  selected="selected">Tiene pensado trabajar</option>
							<option value="Aun no lo sabe">Aun no lo sabe</option>
						</c:if>
						<c:if test="${entrevista.sarpepe == 'Aun no lo sabe'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Tiene pensado estudiar">Tiene pensado estudiar</option>
							<option value="Tiene pensado estudiar y trabajar">Tiene pensado estudiar y trabajar</option>
							<option value="Tiene pensado trabajar">Tiene pensado trabajar</option>
							<option value="Aun no lo sabe" selected="selected">Aun no lo sabe</option>
						</c:if>
						<c:if test="${entrevista.sarpepe != 'Tiene pensado estudiar' && entrevista.sarpepe != 'Tiene pensado estudiar y trabajar' 
								&& entrevista.sarpepe != 'Tiene pensado trabajar' && entrevista.sarpepe != 'Aun no lo sabe'}">
							<option value="0" >Seleccione una opci�n</option>
								<option value="Tiene pensado estudiar">Tiene pensado estudiar</option>
								<option value="Tiene pensado estudiar y trabajar">Tiene pensado estudiar y trabajar</option>
								<option value="Tiene pensado trabajar">Tiene pensado trabajar</option>
								<option value="Aun no lo sabe">Aun no lo sabe</option>
						</c:if>				
					</select>
					<font size="1">Atenci�n. Este campo va al Informe al padrino.</font><img src="../static/images/atencion.gif" width=10></td>
				</td>				
			</tr>
			<tr>
				<td  nowrap="nowrap"><label>En caso que quiera estudiar,<br> qu� estudios quiere hacer?</label></td>
				<td>	
					<select id="te" name="te" disabled="disabled">				
	   					<c:if test="${entrevista.te == 'Universitarios'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Universitarios" selected="selected">Universitarios</option>
							<option value="Terciarios">Terciarios</option>
							<option value="Curso-oficio">Curso-oficio</option>
							<option value="Aun no lo sabe">Aun no lo sabe</option>
						</c:if>
						<c:if test="${entrevista.te == 'Terciarios'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Universitarios">Universitarios</option>
							<option value="Terciarios" selected="selected">Terciarios</option>
							<option value="Curso-oficio">Curso-oficio</option>
							<option value="Aun no lo sabe">Aun no lo sabe</option>
						</c:if>
						<c:if test="${entrevista.te == 'Curso-oficio'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Universitarios">Universitarios</option>
							<option value="Terciarios">Terciarios</option>
							<option value="Curso-oficio" selected="selected">Curso-oficio</option>
							<option value="Aun no lo sabe">Aun no lo sabe</option>
						</c:if>
						<c:if test="${entrevista.te == 'Aun no lo sabe'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Universitarios">Universitarios</option>
							<option value="Terciarios" selected="selected">Terciarios</option>
							<option value="Curso-oficio">Curso-oficio</option>
							<option value="Aun no lo sabe"  selected="selected">Aun no lo sabe</option>
						</c:if>
						<c:if test="${entrevista.te != 'Si' && entrevista.te != 'No' }">
							<option value="0" >Seleccione una opci�n</option>
								<option value="Universitarios">Universitarios</option>
								<option value="Terciarios">Terciarios</option>
								<option value="Curso-oficio">Curso-oficio</option>
								<option value="Aun no lo sabe">Aun no lo sabe</option>
						</c:if>				
					</select>
				</td>		
			
			<tr>
				<td nowrap="nowrap"><label>Si ya lo tiene definido,<br>especificar carrera y/o instituci�n</label></td>
				<td>						
					<form:textarea path="ie" rows="4" cols="70" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);" disabled="disabled"/>					
				</td>				
			</tr>
			<tr>	
				<td><label>Tiene su CV armado</label></td>
				<td>
					<form:checkbox path="cv" id="cv"  disabled="disabled"/>
				</td>
			</tr>
			<tr>	
				<td><label>Tiene mail activo?</label></td>
				<td>
					<form:checkbox path="tma" id="tma"  disabled="disabled"/>
				</td>
			</tr>
		</c:if>		

		
	</c:if>
	
	<tr>
	<td nowrap="nowrap" valign="top"><label>Evaluacion Cobro Beca  *</label></td>
		<td>
		<form:select path="evaluacionCobroBeca" id="evaluacionCobroBeca" class="required" onchange="habilitarMotivos(this)" disabled="disabled">
			<form:option value="">Seleccione una opci�n...</form:option>
			<form:options items="${evaluacionCobroBeca}" itemLabel="valor" itemValue="id"/>				
		</form:select>
		</td>
	</tr>				
	<tr>
		<td nowrap="nowrap"><label>Motivo de Suspension  *</label></td>
		<td>
			<form:select path="motivoSuspension" id="motivoSuspension"  class="required"  disabled="disabled">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${motivoSuspension}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>		
		<td nowrap="nowrap"><label>Motivo de Cesacion  *</label></td>
		<td>
			<form:select path="motivoCesacion" id="motivoCesacion"  class="required"  disabled="disabled">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${motivoCesacion}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>
		<td><label>Observaciones</label></td>
		<td>
			<form:textarea path="observacionesGenerales" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);" disabled="disabled"/>
		</td>
	</tr>
	<c:if test="${tipoPerfil != 'ea'}">  
	<tr>		
		<td><label>Paga Entrevista</label></td>
		<td>
			<form:checkbox path="pagaEntrevista" checked="checked" disabled="disabled"/>
		</td>
	</tr>
	</c:if>
	<tr>
		<td nowrap="nowrap" width="35%"><label>Comentarios de revisi�n,<br>intercambio RR - EA</label></td>
		<td>
			<form:textarea path="comentariosRevision" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);" disabled="disabled"/>
		</td>
	</tr>
</table>