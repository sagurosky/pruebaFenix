<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	 span{ background-color: yellow; }
</style>
<table id="table-informe">
	<!-- ocultado el 11-02-2016
	<tr>
		<td><label>Rendicion Gastos  *</label></td>
		<td>
			<form:checkbox path="rendicionGastos" id="rendicionGastos" disabled="true" onclick="habilitarDetalleGastos(this)"/>
		</td>
	</tr>
	 -->
	<tr>
			<td nowrap="nowrap"><label>Valoraci�n compromiso AB<br>con el Progama *</label></td>
			<td>
				<select id="ecabp" name="ecabp">
					
	   					<c:if test="${entrevista.ecabp == 'Malo'}">
							<option value="0" >Seleccione una opci�n</option>
							<option value="Malo" selected="selected">Malo</option>
							<option value="Regular">Regular</option>
							<option value="Bueno">Bueno</option>
							<option value="Muy Bueno">Muy Bueno</option>
							<option value="Excelente">Excelente</option>
						</c:if>
						<c:if test="${entrevista.ecabp == 'Regular'}">
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
			<td nowrap="nowrap"><label>Valoraci�n Compromiso RA<br>con el Programa *</label></td>
			<td>
				<select id="vcrae" name="vcrae">
					
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
		<tr>
			<td nowrap="nowrap"><label>Seguiiento del<br>Prop�sito anual *</label></td>
			<td>
				<form:textarea path="propositoAnual"  id="propositoAnual" class="textbox2" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>											
			</td>											   		
		</tr>
		
		<tr>
			<td nowrap="nowrap"><label>�Qu� trabajaste en el acompa�amiento<br>en esta 2� parte del a�o *</label>
			<br><br>
			<font size="1">Atenci�n. Este campo va al Informe al padrino.</font><img src="../static/images/atencion.gif" width=10></td>
			<td>
				<form:textarea path="qtam" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
				<!-- input type="hidden" id="evaluacionProposito" name="evaluacionProposito"-->	
			</td>
		</tr>	
		<tr>
			<td nowrap="nowrap"><label>Observaciones sobre<br>rendimiento<br>escolar y asistencia<br>durante la 2� parte del a�o *</label><br><br>		
			
				<font size="1">Atenci�n. Este campo va al Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
			
			</td>
			<td>
				<form:textarea path="osme" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
			</td>
		</tr>
		<tr>
		<td nowrap="nowrap"><label>Principal habilidad<br>trabajada durante<br>la 2� parte del a�o *</label></td>		
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
			<font size="1">Atenci�n. Este campo va al Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
		</td>					
		</tr>
		<tr>
		<td nowrap="nowrap"><label>Principal Contenido trabajado durante<br>la 2da parte del a�o *</label></td>
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
				<form:checkbox path="usasteFichero" id="usasteFichero" />
			</td>
		</tr>
		<tr>	
			<td><label>�Usaste la Br�jula de Habilidades?</label></td>
			<td>
				<form:checkbox path="brujula" id="brujula" />
			</td>
		</tr>
		
	
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
	
	<c:if test="${egreso==2020}">
			
			<tr>
				<td  nowrap="nowrap"><label><font color="#AE30CD">Proyecci�n post-escolar *</font></label></td>
				<td>	
					<select id="sarpepe" name="sarpepe">				
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
								
			</tr>
			<tr>
				<td  nowrap="nowrap"><label><font color="#AE30CD">En caso que quiera estudiar,<br> qu� estudios quiere realizar? *</font></label></td>
				<td>	
					<select id="te" name="te">				
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
				<td nowrap="nowrap"><label><font color="#AE30CD">Especificar nombre de Estudios o Carrera que le interesa</font></label></td>										
				<td>						
					<form:textarea path="ie" rows="4" cols="70" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>					
				</td>				
			</tr>
			<tr>
				<td nowrap="nowrap"><label><font color="#AE30CD">Si ya lo tiene definido, especificar Instituci�n</font></label></td>
				<td>						
					<form:input path="facebook" id="facebook" size="70" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>					
				</td>				
			</tr>
			
			<tr>	
				<td><label><font color="#AE30CD">Tiene su CV armado? *</font></label></td>
				<td>
					
					<form:checkbox path="cv" id="cv" />
				</td>
			</tr>
			<tr>	
				<td><label><font color="#AE30CD">Tiene mail activo? *</font></label></td>
				<td>
					<form:checkbox path="tma" id="tma" />
				</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap"><label><font color="#AE30CD">Direcci�n de mail *</font></label></td>
				<td>						
					<form:input path="dirMail" id="dirMail"  size="70" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>					
				</td>				
			</tr>
			<tr>
				<td nowrap="nowrap"><label><font color="#AE30CD">Celular EP *</font></label></td>
				<td>						
					<form:input path="celular" id="celular" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>					
				</td>				
			</tr>
			<tr>
				<td nowrap="nowrap"><label><font color="#AE30CD">Tel�fono RA</font></label></td>
				<td>						
					<input type="text" id="evaluacionProposito" name="evaluacionProposito">					
				</td>				
			</tr>
			<tr>
				<td nowrap="nowrap"><label><font color="#AE30CD">Tel�fono fijo</font></label></td>
				<td>						
					<form:input path="telFijo" id="telFijo" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>					
				</td>				
			</tr>
		</c:if>	
		
		<tr>		
			<td><label>Situaci�n de Riesgo extra-escolar</label></td>
			<td>
				<input type="hidden" name="compromisoRA" id="compromisoRA" value="1">
				<input type="hidden" name="estrategiaComp" id="estrategiaComp" value="5">
				<form:select path="situacionCrisis">
					<form:options items="${situacionCrisis}" itemLabel="valor" itemValue="id"/>				
				</form:select>
				<input type="hidden" id="horaProxEntrevista" name="horaProxEntrevista" value="12:00">
				<input type="hidden" id="lugarProximaEntrevista" name="lugarProximaEntrevista" size="39" value="${alumno.escuela.nombre}"  />
				<input type="hidden" id="idProxima" name="lugarProximaEntrevista.id" value="${alumno.escuela.id}"></input>
				
			
			</td>
		</tr>	
		
		<tr>		
			<td><label>Situaci�n de Riesgo escolar</label></td>
			<td>
				<input type="hidden" name="compromisoRA" id="compromisoRA" value="1">
				<input type="hidden" name="estrategiaComp" id="estrategiaComp" value="5">
				<form:select path="situacionCrisis">
					<form:options items="${situacionCrisis}" itemLabel="valor" itemValue="id"/>				
				</form:select>
			</td>
		</tr>	
		
		
		<c:if test="${egreso!=2020}">
		<input type="checkbox" name="cv" id="cv" checked style="display:none">
		<input type="checkbox" name="tma" id="tma" checked style="display:none">
		<input type="checkbox" name="usasteFichero" id="usasteFichero" checked style="display:none">
		<input type="checkbox" name="brujula" id="brujula" checked >
		<input type="hidden" name="te" id="te" value="-">
		<input type="hidden" name="dirMail" id="dirMail" value="-">
		<input type="hidden" name="celular" id="celular" value="-">		
		<input type="hidden" name="sarpepe" id="sarpepe" value="-">
		
		</c:if>
	
	
	<tr>
		<td nowrap="nowrap"><label>Resultado A�o Escolar * </label></td>
		<td>
			<form:select path="situacionEscolarMergeada" id="resultadoAnioEscolar"  class="required">
					<form:option value="">Seleccione una opcion...</form:option>
					<form:options items="${resultadoAnioEscolar}" itemLabel="valor" itemValue="id"/>
					
			</form:select>						
			<font size="1">Atenci�n. Este campo aparece en Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>			
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Fue corroboardo con bolet�n? *</label></td>
		<td>
			<select id="corroboradoBoletin" name="corroboradoBoletin">
				<c:choose>
   					<c:when test="${entrevista.corroboradoBoletin == 'S�'}">
						<option value="S�" selected="selected">S�</option>
						<option value="No">No</option>				
					</c:when>
					<c:when test="${entrevista.corroboradoBoletin == 'No'}">
						<option value="S�">S�</option>
						<option value="No" selected="selected">No</option>				
					</c:when>
					<c:otherwise>
						<option value="S�">S�</option>
						<option value="No">No</option>
					</c:otherwise>
				
				</c:choose>
			</select>
		</td>
	</tr>	
	
	<tr>		
		<td nowrap="nowrap"><label>Evaluacion de renovaci�n *</label></td>
		<td>
			<form:select path="evaluacionRenovacionFinal" id="evaluacionRenovacionFinal" class="required" onchange="habilitarRenovacion(this)">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${evaluacionRenovacionFinal}" itemLabel="valor" itemValue="id"/>				
			</form:select>
		</td>
	</tr>
	<tr>
		<td nowrap="nowrap"><label>Motivo de no renovaci�n *</label></td>
		<td>
			<form:select path="motivoNoRenovacion" id="motivoNoRenovacion" class="required" disabled="true">
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${motivoNoRenovacion}" itemLabel="valor" itemValue="id"/>				
			</form:select>
			
		</td>
	</tr>
	
	<tr>
	<td nowrap="nowrap"><label>Evaluaci�n Cobro Beca  *</label></td>
		<td>
		<form:select path="evaluacionCobroBeca" id="evaluacionCobroBeca" class="required" onchange="habilitarMotivos(this)">
			<form:option value="">Seleccione una opci�n...</form:option>
			<form:options items="${evaluacionCobroBeca}" itemLabel="valor" itemValue="id"/>				
		</form:select>
		</td>
	</tr>			
	<tr>
		<td nowrap="nowrap"><label>Motivo de Suspensi�n *</label></td>
		<td>
			<form:select path="motivoSuspension" id="motivoSuspension" class="required" disabled="true" >
				<form:option value="">Seleccione una opci�n...</form:option>
				<form:options items="${motivoSuspension}" itemLabel="valor" itemValue="id"/>				
			</form:select>
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
		<td nowrap="nowrap"><label>Comentarios de revisi�n,<br>intercambio RR - EA</label></td>
		<td>
			<form:textarea path="comentariosRevision" rows="4" cols="30" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
		</td>
	</tr>
</table>