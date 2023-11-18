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
	<c:if test="${entrevista.periodoDePago.nombre=='Julio'}">
		<tr>
			<td nowrap="nowrap"><label>Evaluaci�n compromiso del AB con el programa</label></td>
			<td>
				<select id="ecabp" name="ecabp">
					
	   					<c:if test="${entrevista.ecabp == 'Si'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="CAT" selected="selected">CAT</option>
							<option value="CAT">CAT</option>
						</c:if>
						<c:if test="${entrevista.ecabp == 'No'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="CAT">CAT</option>
							<option value="CAT" selected="selected">CAT</option>
						</c:if>
						<c:if test="${entrevista.ecabp != 'Si' && entrevista.ecabp != 'No' }">
							<option value="0" >Seleccione una opci�n</option>
							<option value="CAT">CAT</option>
							<option value="CAT">CAT</option>
						</c:if>
						
				</select>
			</td>
		</tr>
		<tr>
			<td nowrap="nowrap"><label>Valoraci�n Compromiso RA con la escolaridad</label></td>
			<td>
				<select id="vcrae" name="vcrae">
					
	   					<c:if test="${entrevista.vcrae == 'Si'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="CAT" selected="selected">CAT</option>
							<option value="CAT">CAT</option>
						</c:if>
						<c:if test="${entrevista.vcrae == 'No'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="CAT">CAT</option>
							<option value="CAT" selected="selected">CAT</option>
						</c:if>
						<c:if test="${entrevista.vcrae != 'Si' && entrevista.vcrae != 'No' }">
							<option value="0" >Seleccione una opci�n</option>
							<option value="CAT">CAT</option>
							<option value="CAT">CAT</option>
						</c:if>
						
				</select>
			</td>
		</tr>
		<tr>
			<td nowrap="nowrap"><label>Avance en el cumplimiento del prop�sito anual</label></td>
			<td>
				<select id="acpa" name="acpa">
					
	   					<c:if test="${entrevista.acpa == 'Si'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="CAT" selected="selected">CAT</option>
							<option value="CAT">CAT</option>
						</c:if>
						<c:if test="${entrevista.acpa == 'No'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="CAT">CAT</option>
							<option value="CAT" selected="selected">CAT</option>
						</c:if>
						<c:if test="${entrevista.acpa != 'Si' && entrevista.acpa != 'No' }">
							<option value="0" >Seleccione una opci�n</option>
							<option value="CAT">CAT</option>
							<option value="CAT">CAT</option>
						</c:if>
						
				</select>
			</td>
		</tr>
	</c:if>
	
	<tr>
		<c:if test="${entrevista.periodoDePago.nombre=='Julio'}">
		<td nowrap="nowrap"><label>Redefinici�n de prop�sito a diciembre:</label></td>
		</c:if>
		<c:if test="${entrevista.periodoDePago.nombre!='Julio'}">
		<td nowrap="nowrap"><label>Cumplimiento de prop�sitos <br>acordados con el EA: </label></td>
		</c:if>
		<td>
			<select id="cpaEA" name="cpaEA">
				
   					<c:if test="${entrevista.cpaEA == 'Si'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="CAT" selected="selected">CAT</option>
						<option value="CAT">CAT</option>
					</c:if>
					<c:if test="${entrevista.cpaEA == 'No'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="CAT">CAT</option>
						<option value="CAT" selected="selected">CAT</option>
					</c:if>
					<c:if test="${entrevista.cpaEA != 'Si' && entrevista.cpaEA != 'No' }">
						<option value="0" >Seleccione una opci�n</option>
							<option value="CAT">CAT</option>
							<option value="CAT">CAT</option>
					</c:if>
					
			</select>
		</td>
	</tr>
	<c:if test="${entrevista.periodoDePago.nombre=='Julio'}">
		<tr>
			<td nowrap="nowrap"><label>Categor�a de Prop�sito anual</label></td>
			<td>
				<form:select path="propositoAnual" id="propositoAnual" class="textbox2">
					<c:choose>
	   					<c:when test="${entrevista.propositoAnual == 'Compromiso con la escolaridad'}">
	      					<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Compromiso con la escolaridad" selected="selected">Compromiso con la escolaridad</option>
							<option Value="Rendimiento escolar">Rendimiento escolar</option>									
							<option Value="Egreso efectivo y proyecto de vida" >Egreso efectivo y proyecto de vida</option>
							<option Value="Compromiso con el programa">Compromiso con el programa</option>								
					    	<option Value="Relaciones interpersonales">Relaciones interpersonales</option>
					    	<option Value="Dificultades personales o familiares">Dificultades personales o familiares</option>
					    	<option Value="Actividades extra-escolares">Actividades extra-escolares</option>				    						    
					    </c:when>	
					    <c:when test="${entrevista.propositoAnual == 'Rendimiento escolar'}">
	      					<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Compromiso con la escolaridad">Compromiso con la escolaridad</option>
							<option Value="Rendimiento escolar" selected="selected">Rendimiento escolar</option>									
							<option Value="Egreso efectivo y proyecto de vida" >Egreso efectivo y proyecto de vida</option>
							<option Value="Compromiso con el programa">Compromiso con el programa</option>								
					    	<option Value="Relaciones interpersonales">Relaciones interpersonales</option>
					    	<option Value="Dificultades personales o familiares">Dificultades personales o familiares</option>
					    	<option Value="Actividades extra-escolares">Actividades extra-escolares</option>				    						    
					    </c:when>	
					    <c:when test="${entrevista.propositoAnual == 'Egreso efectivo y proyecto de vida'}">
	      					<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Compromiso con la escolaridad">Compromiso con la escolaridad</option>
							<option Value="Rendimiento escolar">Rendimiento escolar</option>									
							<option Value="Egreso efectivo y proyecto de vida"  selected="selected">Egreso efectivo y proyecto de vida</option>
							<option Value="Compromiso con el programa">Compromiso con el programa</option>								
					    	<option Value="Relaciones interpersonales">Relaciones interpersonales</option>
					    	<option Value="Dificultades personales o familiares">Dificultades personales o familiares</option>
					    	<option Value="Actividades extra-escolares">Actividades extra-escolares</option>				    						    
					    </c:when>	
					    <c:when test="${entrevista.propositoAnual == 'Compromiso con el programa'}">
	      					<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Compromiso con la escolaridad">Compromiso con la escolaridad</option>
							<option Value="Rendimiento escolar">Rendimiento escolar</option>									
							<option Value="Egreso efectivo y proyecto de vida" >Egreso efectivo y proyecto de vida</option>
							<option Value="Compromiso con el programa" selected="selected">Compromiso con el programa</option>								
					    	<option Value="Relaciones interpersonales">Relaciones interpersonales</option>
					    	<option Value="Dificultades personales o familiares">Dificultades personales o familiares</option>
					    	<option Value="Actividades extra-escolares">Actividades extra-escolares</option>				    						    
					    </c:when>	
					    <c:when test="${entrevista.propositoAnual == 'Relaciones interpersonales'}">
	      					<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Compromiso con la escolaridad">Compromiso con la escolaridad</option>
							<option Value="Rendimiento escolar">Rendimiento escolar</option>									
							<option Value="Egreso efectivo y proyecto de vida" >Egreso efectivo y proyecto de vida</option>
							<option Value="Compromiso con el programa">Compromiso con el programa</option>								
					    	<option Value="Relaciones interpersonales" selected="selected">Relaciones interpersonales</option>
					    	<option Value="Dificultades personales o familiares">Dificultades personales o familiares</option>
					    	<option Value="Actividades extra-escolares">Actividades extra-escolares</option>				    						    
					    </c:when>	
					    <c:when test="${entrevista.propositoAnual == 'Dificultades personales o familiares'}">
	      					<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Compromiso con la escolaridad">Compromiso con la escolaridad</option>
							<option Value="Rendimiento escolar">Rendimiento escolar</option>									
							<option Value="Egreso efectivo y proyecto de vida" >Egreso efectivo y proyecto de vida</option>
							<option Value="Compromiso con el programa">Compromiso con el programa</option>								
					    	<option Value="Relaciones interpersonales">Relaciones interpersonales</option>
					    	<option Value="Dificultades personales o familiares" selected="selected">Dificultades personales o familiares</option>
					    	<option Value="Actividades extra-escolares">Actividades extra-escolares</option>				    						    
					    </c:when>	
					    <c:when test="${entrevista.propositoAnual == 'Actividades extra-escolares'}">
	      					<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Compromiso con la escolaridad">Compromiso con la escolaridad</option>
							<option Value="Rendimiento escolar">Rendimiento escolar</option>									
							<option Value="Egreso efectivo y proyecto de vida" >Egreso efectivo y proyecto de vida</option>
							<option Value="Compromiso con el programa">Compromiso con el programa</option>								
					    	<option Value="Relaciones interpersonales">Relaciones interpersonales</option>
					    	<option Value="Dificultades personales o familiares">Dificultades personales o familiares</option>
					    	<option Value="Actividades extra-escolares" selected="selected">Actividades extra-escolares</option>				    						    
					    </c:when>
					    <c:otherwise>
					    	<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Compromiso con la escolaridad">Compromiso con la escolaridad</option>
							<option Value="Rendimiento escolar">Rendimiento escolar</option>									
							<option Value="Egreso efectivo y proyecto de vida" >Egreso efectivo y proyecto de vida</option>
							<option Value="Compromiso con el programa">Compromiso con el programa</option>								
					    	<option Value="Relaciones interpersonales">Relaciones interpersonales</option>
					    	<option Value="Dificultades personales o familiares">Dificultades personales o familiares</option>
					    	<option Value="Actividades extra-escolares">Actividades extra-escolares</option>
					    </c:otherwise>		
					</c:choose>
				</form:select>
				
			</td>											   		
			</tr>
		</c:if>
	

	<tr>
		<td><label>Situacion de Riesgo</label></td>
		<td>
			<input type="hidden" name="compromisoRA" id="compromisoRA" value="1">
			<input type="hidden" name="estrategiaComp" id="estrategiaComp" value="5">
			<form:select path="situacionCrisis">
				<form:options items="${situacionCrisis}" itemLabel="valor" itemValue="id"/>				
			</form:select>
			<input type="hidden" id="horaProxEntrevista" name="horaProxEntrevista" value="12:00">
			<input type="hidden" id="lugarProximaEntrevista" name="lugarProximaEntrevista" size="39" value="${escuelaZona}" disabled="true" />
			<input type="hidden" id="idProxima" name="lugarProximaEntrevista.id" value="${entrevista.lugarProximaEntrevista.id}"></input>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Observaciones sobre situaciones de riesgo</label></td>
		<td>
			<form:textarea path="ossr" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Observaciones sobre materias y ex�menes</label></td>
		<td>
			<form:textarea path="osme" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Observac.sobre alumnos renovados p/excepci�n</label></td>
		<td>
			<form:textarea path="osare" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
		</td>
	</tr>
	
	<c:if test="${entrevista.periodoDePago.nombre=='Julio'}">
		<tr>
		<td nowrap="nowrap"><label>HSE sobre las que trabajaste primera mitad a�o</label></td>
		<td>
			<form:select path="hsTrabajarA�o" id="hsTrabajarA�o" class="textbox2"> 
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
			<font size="1">Atenci�n. Este campo aparece en Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
		</td>					
		</tr>
		<tr>
		<td nowrap="nowrap"><label>Contenidos abordados</label></td>
		<td>
			<form:select path="contenidosTrabajarDuranteAnio" id="contenidosTrabajarDuranteAnio" class="textbox2">
				<c:choose>
   					<c:when test="${entrevista.contenidosTrabajarDuranteAnio == 'Asertividad y comunicaci�n'}">
      					<option value="0">Seleccione una opci&oacute;n:</option>
						<option value="Asertividad y comunicaci�n" selected="selected">Asertividad y comunicaci�n</option>
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima</option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convivencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos" selected="selected">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
						<option Value="Autoconocimiento y autoestima">Autoconocimiento y autoestima/option>															
						<option Value="Autocontrol y determinaci�n">Autocontrol y determinaci�n</option>								
				    	<option Value="Autoeficacia y autoconfianza">Autoeficacia y autoconfianza</option>
				    	<option Value="Autonom�a">Autonom�a</option>
				    	<option Value="Convicencia y Resoluci�n de conflictos">Convicencia y Resoluci�n de conflictos</option>
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
		</td>							
		</tr>			
		<tr>	
			<td><label>Usaste el fichero</label></td>
			<td>
				<form:checkbox path="usasteFichero" id="usasteFichero" />
			</td>
		</tr>
		<tr>
			<td nowrap="nowrap"><label>Qu� trabajaste en acompa�amiento estos meses</label></td>
			<td>
				<form:textarea path="qtam" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
			</td>
		</tr>
		<tr>
			<td nowrap="nowrap"><label>Estrategias que utilizaste en el acompa�amiento<br>estos meses:</label></td>			
			<td>
				<select id="euam" name="euam">
					
	   					<c:if test="${entrevista.euam == 'Si'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="CAT" selected="selected">CAT</option>
							<option value="CAT">CAT</option>
						</c:if>
						<c:if test="${entrevista.euam == 'No'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="CAT">CAT</option>
							<option value="CAT" selected="selected">CAT</option>
						</c:if>
						<c:if test="${entrevista.euam != 'Si' && entrevista.euam != 'No' }">
							<option value="0" >Seleccione una opci�n</option>
								<option value="CAT">CAT</option>
								<option value="CAT">CAT</option>
						</c:if>
						
				</select>
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
				<td  nowrap="nowrap"><label>Situaci�n alumno respecto al proyecto educativo<br> post-escolar</label></td>
				<td>	
					<select id="sarpepe" name="sarpepe">				
	   					<c:if test="${entrevista.sarpepe == 'No lo tiene definido a�n'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="No lo tiene definido a�n" selected="selected">No lo tiene definido a�n</option>
							<option value="No quiere trabajar">No quiere trabajar</option>
							<option value="Quiere trabajar">Quiere trabajar</option>
						</c:if>
						<c:if test="${entrevista.sarpepe == 'No quiere trabajar'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="No lo tiene definido a�n">No lo tiene definido a�n</option>
							<option value="No quiere trabajar" selected="selected">No quiere trabajar</option>
							<option value="Quiere trabajar">Quiere trabajar</option>
						</c:if>
						<c:if test="${entrevista.sarpepe == 'Quiere trabajar'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="No lo tiene definido a�n">No lo tiene definido a�n</option>
							<option value="No quiere trabajar">No quiere trabajar</option>
							<option value="Quiere trabajar"  selected="selected">Quiere trabajar</option>
						</c:if>
						<c:if test="${entrevista.sarpepe != 'No lo tiene definido a�n' && entrevista.sarpepe != 'No quiere trabajar' && entrevista.sarpepe != 'Quiere trabajar'  }">
							<option value="0" >Seleccione una opci�n</option>
								<option value="No lo tiene definido a�n">No lo tiene definido a�n</option>
								<option value="No quiere trabajar">No quiere trabajar</option>
								<option value="Quiere trabajar">Quiere trabajar</option>
						</c:if>				
					</select>
				</td>				
			</tr>
			<tr>
				<td  nowrap="nowrap"><label>En caso que quiera estudiar. Qu� estudios<br> quiere hacer?</label></td>
				<td>	
					<select id="te" name="te">				
	   					<c:if test="${entrevista.te == 'Universitarios'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Universitarios" selected="selected">Universitarios</option>
							<option value="Terciarios">Terciarios</option>
						</c:if>
						<c:if test="${entrevista.te == 'Terciarios'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Universitarios">Universitarios</option>
							<option value="Terciarios" selected="selected">Terciarios</option>
						</c:if>
						<c:if test="${entrevista.te != 'Si' && entrevista.te != 'No' }">
							<option value="0" >Seleccione una opci�n</option>
								<option value="Universitarios">Universitarios</option>
								<option value="Terciarios">Terciarios</option>
						</c:if>				
					</select>
				</td>		
			<tr>
			<tr>
				<td colspan=2 nowrap="nowrap"><label>En caso que quiera estudiar, especificar detalle de carrera o estudio 
						   Incluir bajada m�s peque�a de aclaraci�n o signo de exclamaci�n que aclare:<br> 
						   Si no lo tiene definido escribir "Sin definici�n"</label></td>
				<td>						
			</tr>
			<tr>
				<td colspan=2>
					<form:textarea path="ec" rows="4" cols="70" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>					
				</td>				
			</tr>
			<tr>
				<td colspan=2 nowrap="nowrap"><label>Si ya lo tiene definido, especificar en qu� instituci�n quiere estudiar
						   Incluir bajada m�s peque�a de aclaraci�n o signo de exclamaci�n que aclare:<br>
						   Si no lo tiene definido escribir "Sin definici�n"</label></td>
			</tr>
			
			<tr>	
				<td colspan=2>						
					<form:textarea path="ie" rows="4" cols="70" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>					
				</td>				
			</tr>
			<tr>	
				<td><label>Tiene su CV armado</label></td>
				<td>
					<form:checkbox path="cv" id="cv" />
				</td>
			</tr>
		</c:if>		

		
	</c:if>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<tr>
	<td nowrap="nowrap" valign="top"><label>Evaluacion Cobro Beca  *</label></td>
		<td>
		<form:select path="evaluacionCobroBeca" id="evaluacionCobroBeca" class="required" onchange="habilitarMotivos(this)">
			<form:option value="">Seleccione una opci�n...</form:option>
			<form:options items="${evaluacionCobroBeca}" itemLabel="valor" itemValue="id"/>				
		</form:select>
		</td>
	</tr>				
	<tr>
		<td nowrap="nowrap"><label>Motivo de Suspension  *</label></td>
		<td>
			<form:select path="motivoSuspension" id="motivoSuspension" disabled="true" class="required">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${motivoSuspension}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>		
		<td nowrap="nowrap"><label>Motivo de Cesacion  *</label></td>
		<td>
			<form:select path="motivoCesacion" id="motivoCesacion" disabled="true" class="required">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${motivoCesacion}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>
		<td><label>Observaciones</label></td>
		<td>
			<form:textarea path="observacionesGenerales" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
		</td>
	</tr>
	<c:if test="${tipoPerfil != 'ea'}">  
	<tr>		
		<td><label>Paga Entrevista</label></td>
		<td>
			<form:checkbox path="pagaEntrevista" checked="checked"/>
		</td>
	</tr>
	</c:if>
	<tr>
		<td nowrap="nowrap" width="35%"><label>Comentarios de revisi�n, intercambio RR - EA</label></td>
		<td>
			<form:textarea path="comentariosRevision" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
		</td>
	</tr>
</table>