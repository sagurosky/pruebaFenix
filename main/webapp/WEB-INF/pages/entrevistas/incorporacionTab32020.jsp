<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.textbox2
	 { 
	  border: 1px solid #DBE1EB; 
	  font-size: 14px; 
	  font-family: Arial, Verdana; 
	  padding-left: 2px; 
	  padding-right: 2px; 
	  padding-top: 2px; 
	  padding-bottom: 2px; 
	  border-radius: 4px; 
	  -moz-border-radius: 4px; 
	  -webkit-border-radius: 4px; 
	  -o-border-radius: 4px; 
	  background: #FFFFFF; 
	  background: linear-gradient(left, #FFFFFF, #f5ebf2); 
	  background: -moz-linear-gradient(left, #FFFFFF, #f5ebf2); 
	  background: -webkit-linear-gradient(left, #FFFFFF, #f5ebf2); 
	  background: -o-linear-gradient(left, #FFFFFF, #f5ebf2); 
	  color: #2E3133; 	 
	 } 
	 .textbox2:focus 
	  { 
	  color: #2E3133; 
	  border-color: #FBFFAD; 
	  }	  
</style>

<table id="table-informe">
	<tr>
		<td nowrap="nowrap"><label>Prop�sito anual</label>
		<br>Record� enunciar el proposito con la logica qu�, c�mo, cuando <img src="../static/images/atencion.gif" width=10><br>
		</td>
		<td>
			<form:textarea path="proposito" rows="4" cols="60" onblur="chequearLongitud(this);" cssStyle="width:98%" 
				onkeypress="chequearLongitud(this);" class="textbox2"/>
				
			<input type="hidden" id="proximaEntrevista" name="proximaEntrevista">
			<input type="hidden" id="horaProxEntrevista" name="horaProxEntrevista" value="12:00">
			<input type="hidden" id="lugarProximaEntrevista" name="lugarProximaEntrevista" size="39" value="${escuelaZona}"/>
			<input type="hidden" id="idProxima" name="lugarProximaEntrevista.id" value="${entrevista.lugarProximaEntrevista.id}"></input>
			<input type="hidden" id="entregaMaterial" name="entregaMaterial" value="1">
		</td>		
	</tr>
	<tr>
	<td nowrap="nowrap"><label>Categor�a de Prop�sito anual (Va a la FP)<img src="../static/images/atencion.gif" width=10><br></label>
		 
	</td>
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
		<tr>
		<td nowrap="nowrap"><label>HSE a trabajar durante el a�o</label></td>
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
		</td>					
		</tr>
		<tr>
		<td nowrap="nowrap"><label>Contenidos a trabajar en el a�o</label></td>
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
		<td><label>Situaci�n de Riesgo</label></td>
		<td>			
			<form:select path="situacionCrisis" class="textbox2">
				<form:options items="${situacionCrisis}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Observaciones sobre situaciones de riesgo</label></td>
		<td>
			<form:textarea path="observacionesSR" rows="4" cols="60" cssStyle="width:98%"  class="textbox2" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
		</td>
	</tr>
	
	
	
	
	
	
	
	
	<tr>
	<td nowrap="nowrap"><label>Evaluaci�n Cobro Beca  *</label></td>
		<td>
		<form:select path="evaluacionCobroBeca" id="evaluacionCobroBeca" disabled="true"  class="textbox2">
			<form:option value="">Seleccione una opci�n...</form:option>
			<form:options items="${evaluacionCobroBeca}" itemLabel="valor" itemValue="id"/>				
		</form:select>
		</td>
	</tr>		
	<tr>
		
		<td nowrap="nowrap"><label>Observaciones Generales</label></td>
		<td>
			<input type="hidden" id="destinoDinero" name="destinoDinero" value="13">
			<form:textarea path="observacionesGenerales" rows="4" cols="60" onblur="chequearLongitud(this);" cssStyle="width:98%"
				onkeypress="chequearLongitud(this);" class="textbox2"/>
		</td>
	</tr>
	<c:if test="${tipoPerfil != 'ea'}">  
		<tr>		
			<td><label>Paga Enucuentro de acompa�amiento</label></td>
			<td>
				<form:checkbox path="pagaEntrevista" checked="checked"/>
			</td>
		</tr>
	</c:if>	
	<tr>
		<td nowrap="nowrap" width="32%"><label>Comentarios de revisi�n, intercambio RR - EA</label></td>
		<td>
			<form:textarea path="comentariosRevision" rows="4" cols="50" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);" class="textbox2"/>
		</td>
	</tr>
</table>