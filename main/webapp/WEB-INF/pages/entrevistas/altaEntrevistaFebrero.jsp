|<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>..:: Espacio de acompa�amiento Febrero ::..</title>
<style type="text/css">
	label { width: 10em; float: left; }
	label.error { float: none; color: red; padding-left: .5em; vertical-align: top; }
	p { clear: both; }
	.submit { margin-left: 12em; }
	em { font-weight: bold; padding-right: 1em; vertical-align: top; }
</style>
<script type="text/javascript" src="<c:url  value="/static/js/jquery.js"/>"></script>
<script type="text/javascript" src="<c:url  value="/static/js/jquery.ui.datepicker-es.js"/>"></script>
<script type="text/javascript" src="<c:url  value="/static/js/jquery-ui-1.8.5.custom.min.js"/>"></script>
<link rel="stylesheet" href="<c:url  value="/static/css/cimientos/jquery-ui-1.8.5.custom.css"/>" media="all">
<script type="text/javascript" src="<c:url  value="/static/js/jquery.validate.js"/>"></script>
<script type="text/javascript" src="<c:url  value="/static/js/validador.js"/>"></script>
<!-- script type="text/javascript" src="<c:url  value="/static/js/funcionesEntrevistaFinal.js"/>"></script-->
<script type="text/javascript" src="<c:url  value="/static/js/jquery.blockUI.js"/>"></script>
<link rel="stylesheet" type="text/css"	href="../pages/includes/jquery.tabs.css" />
<script type="text/javascript" src="<c:url  value="/static/js/dFilter.js"/>"></script>

<style>
	 span{ background-color: yellow; }
</style>

<link rel="stylesheet" href="<c:url  value="/static/css/cimientos/jquery-ui-1.8.5.custom.css"/>"	media="all">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">

<link href="//cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@3/dark.css" rel="stylesheet">

<script>
	


</script>


<script type="text/javascript">
	function raNoFueConvocado(inputSelect){
		//alert(1);
	
		if(document.getElementById("raNoConvocado").checked==true){		
			//alert(2);
			$('#motivoNoConvocatoria').attr('disabled','disabled');
			$('#motivoNoConvocatoria').attr('value', 'Seleccione una opci�n:');
			//$('#motivoNoConvocatoria > option[value="0"]').attr('selected', 'selected');
			$('#participoRA').removeAttr('disabled');
			$('#motivoAusenciaRA').removeAttr('disabled');
			$('#motivoAusenciaRA').attr('value', 'Seleccione una opci�n:');
		}else{		
			//alert(3);
			$('#motivoNoConvocatoria').removeAttr('disabled');
			//$('#participoRA').removeAttr('disabled');
			$('#participoRA').removeAttr("checked");
			$('#participoRA').attr('disabled','disabled');	
			$('#motivoAusenciaRA').attr('disabled','disabled');
			$('#motivoAusenciaRA').attr('value', 'Seleccione una opci�n:');
		}	
	}
</script>
<script type="text/javascript">
	$(document).ready(function(){  
		//alert();  
		$('#otroMotivoAusencia').attr('disabled','disabled');		
		$('#observacionesGenerales').attr('disabled','disabled');
		$('#motivoSuspension').attr('disabled','disabled');
		
		
		$("#participoBecado").change(function(){
			var participoAB = $(this).children("option:selected").val();
			//alert(participoAB);
	      	
	        if(participoAB==="1"){
	        	
	           $("#motivoAusencia").val("0");
	           $("#motivoAusencia").attr('disabled','disabled');
	    	   $("#otroMotivoAusencia").attr('disabled','disabled');
	    	   
	    	   $("#otroMotivoAusencia").val("");
	       }else{
	    	  
	    	   $("#motivoAusencia").removeAttr('disabled');
	    	  
	    	   $("#otroMotivoAusencia").attr('disabled','disabled');
	    	  
	       }
	    });
		
		$("#motivoAusencia").change(function(){
	        var otros = $(this).children("option:selected").val();
	       if(otros==="4"){
	    	   $("#otroMotivoAusencia").removeAttr('disabled');
	       }else{
	    	   $("#otroMotivoAusencia").attr('disabled','disabled');
	    	   $("#otroMotivoAusencia").val("");
	       }
	    });	
		
		
		$("#hsTrabajarA�o").change(function(){
	        var otrosHSE = $(this).children("option:selected").val();
	       if(otrosHSE==="Otra"){
	    	   $("#observacionesGenerales").removeAttr('disabled');
	       }else{
	    	   $("#observacionesGenerales").attr('disabled','disabled');
	    	   $("#observacionesGenerales").val("");
	       }
	    });
		
		
		$("#evaluacionCobroBeca").change(function(){
			
			var tipoCobro = $(this).children("option:selected").val();
	        
	       if(tipoCobro==="2"){
	    	   
	    	   $("#motivoSuspension").removeAttr('disabled'); 	   
	       }else{
	    	   $("#motivoSuspension").val("0");
	    	   $("#motivoSuspension").attr('disabled','disabled');
	    	   
		   }	      
	    });	
		
		
		
		$("#evaluacionRenovacionFinal").change(function(){
			
			var tipoCobro = $(this).children("option:selected").val();
	        
	       if(tipoCobro==="1"){
	    	   
	    	   $("#motivoNoRenovacion").removeAttr('disabled'); 	   
	       }else{
	    	   $("#motivoNoRenovacion").val("0");
	    	   $("#motivoNoRenovacion").attr('disabled','disabled');
	    	   
		   }	      
	    });
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
    	$("#participoRA").click(function() {  
        	if($("#participoRA").is(':checked')) {  
            	//alert("Est� activado");  
        		$('#motivoAusenciaRA').attr('disabled','disabled');
    			$('#motivoAusenciaRA').attr('value', 'Seleccione una opci�n:');
    	    }  
            	
        	 else {  
	            //alert("No est� activado");
        		$('#motivoAusenciaRA').removeAttr('disabled');
    			$('#motivoAusenciaRA').attr('value', 'Seleccione una opci�n:');
        	}	
    	});  
  
	});  
</script>

<script>
  $(document).ready(function(){
    $("#altaEntrevistaIndividual").validate({
   		invalidHandler: function(form, validator) {
			var errors = validator.numberOfInvalids();
			if (errors) {
				$.unblockUI();
			}
		}
	});
    
	$("#datepicker").datepicker({
	  	  changeMonth: true,
		  changeYear: true,
	 	  yearRange:'-1:+1'
		  });
	$("#datepicker1").datepicker({
	  	  changeMonth: true,
		  changeYear: true,
	 	  yearRange:'-1:+1'
		  });
	$("#container-1").tabs();
  });

  function mostrar(idx){
		var selector;
			switch (idx) {
			case 1:
				selector = "#datosEntrevista1";
				break
			case 2:
				selector = "#datosEntrevista2";
				break
			case 3:
				selector = "#datosEntrevista3";
			}

			$(selector).toggle("blind");
		}


$(function() {
	 
	$("#escuela").autocomplete({
		source: function(request, response) {
			$.ajax({
				url: "../ajax/buscarEscuelaPorEA.do?idEA=" + $("#idEA").val(),
				dataType: "json",
				data: {
					style: "full",
					maxRows: 12,
					name_startsWith: request.term
				},
				success: function(data) {
					response($.map(data.escuelas, function(item) {
						return {
							label: item.labelEscuelaZona,
							value: item.labelEscuelaZona,
							id: item.id
						}
					}))
				}
			})
		},
		minLength: 2,
		select: function(event, ui) {
			$("#lugarEntrevistaId").val(ui.item.id);
			$("#idProxima").val(ui.item.id);
		}
	});



});


function chequearLongitud(obj)
{
	if (obj.value.length > 10000) 
	{
		obj.value = obj.value.substring(0, 10000);
	}
}

	function guardarAprobar(valor, valorPerfil){
		//alert();
		if (document.forms['altaEntrevistaIndividual'].evaluacionCobroBeca.value == 3 ) { 
			document.forms['altaEntrevistaIndividual'].evaluacionCobroBeca.focus();
	    	//alert(1);
			jAlert('warning', 'No se puede aprobar una entrevista en estado Dudoso', 'Atenci�n!');
	  	}
		else{
			//alert(2);
			document.forms['altaEntrevistaIndividual'].valorPerfil.value = valorPerfil;
			//alert(3);
			document.forms['altaEntrevistaIndividual'].valorGuardar.value = valor;
			if (valor == 'f' || valor == 's'){
				
				if(document.forms['altaEntrevistaIndividual'].participoBecado.value=="0" && document.forms['altaEntrevistaIndividual'].motivoAusencia.value=="0"){			
					jAlert('warning', 'Falta completar Motivo de Ausencia Becado', 'Atenci�n!');  
					return false;	
				}
				
				
				if(document.forms['altaEntrevistaIndividual'].motivoAusenciaRa2.value=="0"){			
					jAlert('warning', 'Falta completar Participaci�n RA', 'Atenci�n!');  
					return false;	
				}
				
				
				
				
				
				if(document.forms['altaEntrevistaIndividual'].anioEgreso.value=="2020"){
					
					if(document.forms['altaEntrevistaIndividual'].spe.value=="0"){					
						jAlert('warning', 'Falta completar Situaci�n Post Escolar', 'Atenci�n!');
						return false;
					}
					
				}
				
				
				if(document.forms['altaEntrevistaIndividual'].osme.value==""){			
					jAlert('warning', 'Falta completar Observaciones sobre<br>la trayectoria escolar y<br>asistencia', 'Atenci�n!');  
					return false;	
				}
				
				if(document.forms['altaEntrevistaIndividual'].hsTrabajarA�o.value=="0"){			
					jAlert('warning', 'Falta completar Principal HSE trabajada', 'Atenci�n!');  
					return false;	
				}
								
				if(document.forms['altaEntrevistaIndividual'].contenidosTrabajarEnElAnio.value<="0"){			
					jAlert('warning', 'Falta completar Principal Contenido trabajado', 'Atenci�n!');  
					return false;	
				}
				
				
				
				if(document.forms['altaEntrevistaIndividual'].objetivoEncuentro.value==""){			
					jAlert('warning', 'Falta completar Objetivo del encuentro y actividad implementada', 'Atenci�n!');  
					return false;	
				}
				
				if(document.forms['altaEntrevistaIndividual'].situacionCrisis.value<="0"){			
					jAlert('warning', 'Falta completar Situaci�n de Riesgo extra-escolar ', 'Atenci�n!');  
					return false;	
				}	
				
				if(document.forms['altaEntrevistaIndividual'].situacionRiesgoEscolar.value<="0"){			
					jAlert('warning', 'Falta completar Situaci�n de Riesgo escolar ', 'Atenci�n!');  
					return false;	
				}
				
				
				
				if(document.forms['altaEntrevistaIndividual'].rae.value=="0"){					
					jAlert('warning', 'Falta completar Resultado a�o escolar', 'Atenci�n!');
					return false;
				}
				
				
				
				
				if(document.forms['altaEntrevistaIndividual'].evaluacionCobroBeca.value==""){					
					jAlert('warning', 'Falta completar Evaluaci�n cobro Beca', 'Atenci�n!');
					return false;
				}
				
				if(document.forms['altaEntrevistaIndividual'].evaluacionCobroBeca.value=="4"){
					if(document.forms['altaEntrevistaIndividual'].motivoCesacion.value==""){			
						jAlert('warning', 'Falta completar Motivo de Suspensi�n', 'Atenci�n!');
					}
					return false;
				}
				//alert();
				
				
				
				
				else{
					
						$.blockUI();
						
						$('#altaEntrevistaIndividual').submit();
					//}
				}
			}
			else{
				
				$.blockUI();
				
				document.forms['altaEntrevistaIndividual'].submit();
			}
	  	}
	}

	function guardar(valor, valorPerfil){	
		document.forms['altaEntrevistaIndividual'].valorPerfil.value = valorPerfil;
		document.forms['altaEntrevistaIndividual'].valorGuardar.value = valor;
		if (valor == 'f'){
			if (esMayor(document.forms['altaEntrevistaIndividual'].fechaEntrevista.value, document.forms['altaEntrevistaIndividual'].fechaActual.value)){
				document.forms['altaEntrevistaIndividual'].fechaEntrevista.focus();
				jAlert('warning', '"Fecha Entrevista" no puede ser mayor a la fecha actual', 'Atenci�n!');				
			}
			else{
				if (document.forms['altaEntrevistaIndividual'].FechaEntrevFebMarzo.value != "" && 
						!esMayor(document.forms['altaEntrevistaIndividual'].FechaEntrevFebMarzo.value, document.forms['altaEntrevistaIndividual'].fechaActual.value)){
					document.forms['altaEntrevistaIndividual'].FechaEntrevFebMarzo.focus();
					jAlert('warning', '"Fecha Entrevista febrero/marzo" debe ser mayor a la fecha actual', 'Atenci�n!');					
				}
				else{
					$.blockUI();
					$('#altaEntrevistaIndividual').submit();
				}
			}
		}
		else{
			$.blockUI();
			document.forms['altaEntrevistaIndividual'].submit();
		}
	}
</script>
 
</head>
<body onload="cargarDatos('${sextoAnio}','${tipoPerfil}', '${alumno.eae}', '${alumno.anioEscolar}' , '${alumno.anioAdicional}');">
<!-- div id="main-content"-->
<div class="container-fluid">
<div class="row">
	<div class="col-lg-2">
		<br>
		<div class="position-fixed">
			<img src="../fichaAlumno/mostrarImagen.do?dni=${alumno.datosPersonales.dni}" width="100px">	
			<br><br>	
			<div class="form-group">			
					<input type="button"  class="btn btn-secondary" value="En construcci�n" class="ui-state-default ui-corner-all"	onclick="guardar('c','${tipoPerfil}');" />
			</div>
			<div class="form-group">				
					<c:if test="${tipoPerfil == 'rr'}">
						<input type="button" class="btn btn-secondary " value="Finalizar" class="ui-state-default ui-corner-all" onclick="guardarAprobar('f','${tipoPerfil}');" />
					</c:if>
					<c:if test="${tipoPerfil == 'ea'}">
						<input type="button" class="btn btn-secondary " value="Finalizar" class="ui-state-default ui-corner-all" onclick="guardarAprobar('f','${tipoPerfil}');" />
					</c:if>
														
					<c:if test="${tipoPerfil == 'superUsuario'}">
						<input type="button" class="btn btn-secondary" value="Finalizar" class="ui-state-default ui-corner-all" onclick="guardarAprobar('s','${tipoPerfil}');" />
					</c:if>
			</div>
			<div class="form-group">				
					<c:if test="${tipoPerfil == 'rr'}">
						<input type="button" class="btn btn-secondary " value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../entrevistas/listaEntrevistasAprobar.do'; return false;" />
					</c:if>
					<c:if test="${tipoPerfil == 'ea'}">
						<input type="button" class="btn btn-secondary" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../entrevistas/listarBecadosFebrero.do'; return false;" />
					</c:if>	
					<c:if test="${tipoPerfil == 'superUsuario'}">
							<input type="button" class="btn btn-secondary" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../exportacionEntrevistas/verExportarEntrevistas.do'; return false;" />
					</c:if>	
				
			</div>
		</div>
	</div>



<div class="col-lg-10">
<form:form id="altaEntrevistaIndividual" commandName="entrevista" modelAttribute="entrevista" class="cmxform" method="post" action="guardarFebrero.do?alumnoId=${alumno.id}&EA=${ea}">
<form:hidden path="id"/>
<form:hidden path="fechaCarga"/>
<form:hidden path="periodoDePago"/>
	<div class="card-body p-3 my-3 bg-secondary text-white">
		  <h3 title="IdAlumno=${alumno.id}">Encuentro Adicional Febrero 2021 - ${periodo.nombre} ${periodo.ciclo.nombre}  ${entrevista.periodoDePago.nombre} ${entrevista.periodoDePago.ciclo.nombre} - ${entrevista.estadoEntrevista.valor}<br>${alumno.datosPersonales.nombre}&nbsp;${alumno.datosPersonales.apellido}</h3>
			Fecha Incorporaci�n PFE: <fmt:formatDate value="${alumno.fechaPBE}" pattern="dd/MM/yyyy"/>
			<br>Escuela: ${alumno.escuela.nombre}<br>
			A�o Escolar: ${alumno.anioEscolar.valor} - 	
			alumno.anioEscolar.id		
			A�o Egreso:
			<c:set var="egreso" value="${0}"/>
			<c:if test="${alumno.escuela.zonaCimientos.eae=='6/6'}">
		    		<c:if test="${!alumno.anioAdicional && alumno.anioEscolar.id==16}">
					<c:set var="egreso" value="${2020}"/>
					2020
				</c:if>
				<c:if test="${alumno.anioAdicional && alumno.anioEscolar.id==16}">
					<c:set var="egreso" value="${2020}"/>
					2020
				</c:if>

				<c:if test="${!alumno.anioAdicional && alumno.anioEscolar.id!=16}">
					${2020+13-alumno.anioEscolar.id+1}
					<c:set var="egreso" value="${2020+13-alumno.anioEscolar.id+1}"/> 
				</c:if>
				
				<c:if test="${alumno.anioAdicional && alumno.anioEscolar.id==15}">
					<c:set var="egreso" value="${2020}"/>
					2020
				</c:if>
				<c:if test="${alumno.anioAdicional && alumno.anioEscolar.id<15}">
					<c:set var="egreso" value="${2020+13-alumno.anioEscolar.id+2}"/>
					${2020+13-alumno.anioEscolar.id+2} 
				</c:if>
				
				
				
			</c:if>
			<c:if test="${alumno.escuela.zonaCimientos.eae=='7/5'}">
		    	
		    	<c:if test="${!alumno.anioAdicional && alumno.anioEscolar.id==16}">
					<c:set var="egreso" value="${2020}"/>
					2020
				</c:if>
		    	
		    	<c:if test="${!alumno.anioAdicional && alumno.anioEscolar.id!=16}">
					<c:set var="egreso" value="${2020+13-alumno.anioEscolar.id}"/>
					${2020+13-alumno.anioEscolar.id} 
				</c:if>
		    	
		    	<c:if test="${alumno.anioAdicional && alumno.anioEscolar.id==16}">
					<c:set var="egreso" value="${2020}"/>
					2020
				</c:if>
		    	
		    	<c:if test="${alumno.anioAdicional && alumno.anioEscolar.id!=16}">
					<c:set var="egreso" value="${2020+13-alumno.anioEscolar.id+1}"/>
					${2020+13-alumno.anioEscolar.id+1} 
				</c:if>
		    	
		    	
				
			</c:if>	
			
			
			
			<c:if test="${alumno.anioAdicional}">
				 - Tiene a�o adicional
			</c:if>
			<c:if test="${!alumno.anioAdicional}">
				- No tiene a�o adicional
			</c:if>			
			<br>
			
			<c:if test="${entrevista.excepcion}">
				 Renovado por excepci�n
			</c:if>	
	</div>

<input type="hidden" name="valorGuardar" />
<input type="hidden" name="valorPerfil" />
<input type="hidden" name="fechaEntrevista" id="datepicker"  value="<fmt:formatDate value="${entrevista.fechaEntrevista}" pattern="dd/MM/yyyy"/>"  >
<input id="idProxima" type="hidden" />
<input type="hidden" id="escuela" name="lugarEntrevista" size="39" value="${alumno.escuela.id}" class="required"/>
<input type="hidden" class="required" id="lugarEntrevistaId" name="lugarEntrevista.id" value="${alumno.escuela.id}"></input>
<input id="idProxima" type="hidden" />
<input type="hidden" id="corroboradoBoletin" name="corroboradoBoletin" value="no">

<div class="card bg-info text-white">
	<div class="card-body">Datos Generales</div>
</div>	
<br>
<div class="form-group form-inline">
		  		<label for="sel1" class="text-danger">Tipo encuentro<br>acompa�amiento &nbsp;&nbsp;</label>
		  		<select class="form-control" id="tipoEncuentroAcompanamiento" name="tipoEncuentroAcompanamiento" style='width:auto'>						
					<c:choose>
	   					<c:when test="${entrevista.tipoEncuentroAcompanamiento == 'Encuentro Individual'}">
	      						<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Encuentro Individual" selected="selected">Encuentro Individual</option>
							<option Value="Encuentro grupal">Encuentro grupal</option>									
							<option Value="Intercambio virtual" >Intercambio virtual</option>									
					    	<option Value="Otro">Otro</option>							    	
					    </c:when>																		
					    <c:when test="${entrevista.tipoEncuentroAcompanamiento == 'Encuentro grupal'}">
	      						<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Encuentro Individual">Encuentro Individual</option>
							<option Value="Encuentro grupal" selected="selected">Encuentro grupal</option>									
							<option Value="Intercambio virtual" >Intercambio virtual</option>									
					    	<option Value="Otro">Otro</option>								    	
					    </c:when>						
					    <c:when test="${entrevista.tipoEncuentroAcompanamiento == 'Intercambio virtual'}">
	      						<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Encuentro Individual">Encuentro Individual</option>
							<option Value="Encuentro grupal">Encuentro grupal</option>									
							<option Value="Intercambio virtual"  selected="selected">Intercambio virtual</option>									
					    	<option Value="Otro">Otro</option>								    	
					    </c:when>													    
					    <c:when test="${entrevista.tipoEncuentroAcompanamiento == 'Otro'}">
	      						<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Encuentro Individual">Encuentro Individual</option>
							<option Value="Encuentro grupal">Encuentro grupal</option>									
							<option Value="Intercambio virtual" >Intercambio virtual</option>									
					    	<option Value="Otro"  selected="selected">Otro</option>									    	
					    </c:when>	
					    <c:otherwise>
					    	<option value="0">Seleccione una opci&oacute;n:</option>
							<option value="Encuentro Individual" >Encuentro Individual</option>
							<option Value="Encuentro grupal">Encuentro grupal</option>									
							<option Value="Intercambio virtual" >Intercambio virtual</option>									
					    	<option Value="Otro">Otro</option>		
					    </c:otherwise>					
					</c:choose>
				<!--  /form:select-->		
				</select>	
			</div>
<div class="form-group form-inline">
	<label class="text-danger">Particip� EP?</label>																				
	<select class="form-control" id="participoBecado" name="participoBecado" style='width:auto'>							
		<c:choose>
			<c:when test="${entrevista.participoBecado == 'true'}">
					<option value="1" selected="selected">Si</option>
					<option value="0" >No</option>    	
		    </c:when>													    
		    <c:when test="${entrevista.participoBecado == 'false'}">       						
					<option value="1" >Si</option>
					<option value="0" selected="selected">No</option>    	
		    </c:when>													    								
		</c:choose>			
	</select>		
</div>					
<div class="form-group form-inline">
	<label class="text-danger">Motivo Ausencia &nbsp;&nbsp;&nbsp;</label>			
	<select class="form-control" name="motivoAusencia" id="motivoAusencia" style='width:auto'>
	<!-- >form:select path="motivoAusencia" id="motivoAusencia" class="required"-->
		<c:choose>
 			<c:when test="${entrevista.motivoAusencia == 'ENFERMEDAD'}">
    			<option value=0>Seleccione una opci&oacute;n:</option>
				<option value=1 selected="selected">Razones de salud propia o de terceros</option>
				<option Value=2> in justificaci�n-se desconoce el motivo</option>
				<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
				<option Value=4 >Otros</option>
				<option Value=5 disabled="disabled">No corresponde</option>								
		    	<option Value=6>Cuidado-ayuda a terceros</option>
		    	<option Value=7>Motivos laborales</option>
		    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
		    	<option Value=9>Dificultades en el traslado</option>
		    	<option Value=10>Realizaci�n de tr�mites</option>
		    	<option Value=11>Factores clim�ticos</option>
		    	<option Value=12>Viaje a otra localidad</option>
		    	<option Value=13>No demuestra inter�s-compromiso</option>
		    </c:when>
		    <c:when test="${entrevista.motivoAusencia == 'EVENTUALIDAD'}">
    						<option value=0>Seleccione una opci&oacute;n:</option>
				<option Value=1>Razones de salud propia o de terceros</option>
				<option Value=2  selected="selected">Sin justificaci�n-se desconoce el motivo</option>
				<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
				<option Value=4 >Otros</option>
				<option Value=5 disabled="disabled">No corresponde</option>								
		    	<option Value=6>Cuidado-ayuda a terceros</option>
		    	<option Value=7>Motivos laborales</option>
		    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
		    	<option Value=9>Dificultades en el traslado</option>
		    	<option Value=10>Realizaci�n de tr�mites</option>
		    	<option Value=11>Factores clim�ticos</option>
		    	<option Value=12>Viaje a otra localidad</option>
		    	<option Value=13>No demuestra inter�s-compromiso</option>
		    </c:when>
		    <c:when test="${entrevista.motivoAusencia == 'INASISTENCIA'}">
    						<option value=0>Seleccione una opci&oacute;n:</option>
				<option Value=1>Razones de salud propia o de terceros</option>
				<option Value=2 selected="selected">Sin justificaci�n-se desconoce el motivo</option>
				<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
				<option Value=4 >Otros</option>
				<option Value=5 disabled="disabled">No corresponde</option>								
		    	<option Value=6>Cuidado-ayuda a terceros</option>
		    	<option Value=7>Motivos laborales</option>
		    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
		    	<option Value=9>Dificultades en el traslado</option>
		    	<option Value=10>Realizaci�n de tr�mites</option>
		    	<option Value=11>Factores clim�ticos</option>
		    	<option Value=12>Viaje a otra localidad</option>
		    	<option Value=13>No demuestra inter�s-compromiso</option>
		    </c:when>
		    <c:when test="${entrevista.motivoAusencia == 'CUIDADO'}">
    						<option value=0>Seleccione una opci&oacute;n:</option>
				<option Value=1>Razones de salud propia o de terceros</option>
				<option Value=3 selected="selected">Sin justificaci�n-se desconoce el motivo</option>
				<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
				<option Value=4 >Otros</option>
				<option Value=5 disabled="disabled">No corresponde</option>								
		    	<option Value=6  selected="selected">Cuidado-ayuda a terceros</option>
		    	<option Value=7>Motivos laborales</option>
		    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
		    	<option Value=9>Dificultades en el traslado</option>
		    	<option Value=10>Realizaci�n de tr�mites</option>
		    	<option Value=11>Factores clim�ticos</option>
		    	<option Value=12>Viaje a otra localidad</option>
		    	<option Value=13>No demuestra inter�s-compromiso</option>
		    </c:when>
		    <c:when test="${entrevista.motivoAusencia == 'MOTIVOSLABORALES'}">
    						<option value=0>Seleccione una opci&oacute;n:</option>
				<option Value=1>Razones de salud propia o de terceros</option>
				<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
				<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
				<option Value=4 >Otros</option>
				<option Value=5 disabled="disabled">No corresponde</option>								
		    	<option Value=6>Cuidado-ayuda a terceros</option>
		    	<option Value=7  selected="selected">Motivos laborales</option>
		    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
		    	<option Value=9>Dificultades en el traslado</option>
		    	<option Value=10>Realizaci�n de tr�mites</option>
		    	<option Value=11>Factores clim�ticos</option>
		    	<option Value=12>Viaje a otra localidad</option>
		    	<option Value=13>No demuestra inter�s-compromiso</option>
		    </c:when>
		    <c:when test="${entrevista.motivoAusencia == 'DESCONOCIMIENTO'}">
    						<option value=0>Seleccione una opci&oacute;n:</option>
				<option Value=1>Razones de salud propia o de terceros</option>
				<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
				<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
				<option Value=4 >Otros</option>
				<option Value=5 disabled="disabled">No corresponde</option>								
		    	<option Value=6>Cuidado-ayuda a terceros</option>
		    	<option Value=7>Motivos laborales</option>
		    	<option Value=8 selected="selected">Desconocimiento, olvido o confusi�n fecha entrevista</option>
		    	<option Value=9>Dificultades en el traslado</option>
		    	<option Value=10>Realizaci�n de tr�mites</option>
		    	<option Value=11>Factores clim�ticos</option>
		    	<option Value=12>Viaje a otra localidad</option>
		    	<option Value=13>No demuestra inter�s-compromiso</option>
		    </c:when>
		    <c:when test="${entrevista.motivoAusencia == 'DIFICULTADES'}">
    						<option value=0>Seleccione una opci&oacute;n:</option>
				<option Value=1>Razones de salud propia o de terceros</option>
				<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
				<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
				<option Value=4 >Otros</option>
				<option Value=5 disabled="disabled">No corresponde</option>								
		    	<option Value=6>Cuidado-ayuda a terceros</option>
		    	<option Value=7>Motivos laborales</option>
		    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
		    	<option Value=9  selected="selected">Dificultades en el traslado</option>
		    	<option Value=10>Realizaci�n de tr�mites</option>
		    	<option Value=11>Factores clim�ticos</option>
		    	<option Value=12>Viaje a otra localidad</option>
		    	<option Value=13>No demuestra inter�s-compromiso</option>
		    </c:when>
		    <c:when test="${entrevista.motivoAusencia == 'TRAMITES'}">
    						<option value=0>Seleccione una opci&oacute;n:</option>
				<option Value=1>Razones de salud propia o de terceros</option>
				<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
				<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
				<option Value=4 >Otros</option>
				<option Value=5 disabled="disabled">No corresponde</option>								
		    	<option Value=6>Cuidado-ayuda a terceros</option>
		    	<option Value=7>Motivos laborales</option>
		    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
		    	<option Value=9>Dificultades en el traslado</option>
		    	<option Value=10 selected="selected">Realizaci�n de tr�mites</option>
		    	<option Value=11>Factores clim�ticos</option>
		    	<option Value=12>Viaje a otra localidad</option>
		    	<option Value=13>No demuestra inter�s-compromiso</option>
		    </c:when>
		    <c:when test="${entrevista.motivoAusencia == 'FACTORESCLIMATICOS'}">
    						<option value=0>Seleccione una opci&oacute;n:</option>
				<option Value=1>Razones de salud propia o de terceros</option>
				<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
				<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
				<option Value=4 >Otros</option>
				<option Value=5 disabled="disabled">No corresponde</option>								
		    	<option Value=6>Cuidado-ayuda a terceros</option>
		    	<option Value=7>Motivos laborales</option>
		    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
		    	<option Value=9>Dificultades en el traslado</option>
		    	<option Value=10>Realizaci�n de tr�mites</option>
		    	<option Value=11 selected="selected">Factores clim�ticos</option>
		    	<option Value=12>Viaje a otra localidad</option>
		    	<option Value=13>No demuestra inter�s-compromiso</option>
		    </c:when>
		    <c:when test="${entrevista.motivoAusencia == 'VIAJEAOTRALOCALIDAD'}">
    						<option value=0>Seleccione una opci&oacute;n:</option>
				<option Value=1>Razones de salud propia o de terceros</option>
				<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
				<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
				<option Value=4 >Otros</option>
				<option Value=5 disabled="disabled">No corresponde</option>								
		    	<option Value=6>Cuidado-ayuda a terceros</option>
		    	<option Value=7>Motivos laborales</option>
		    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
		    	<option Value=9>Dificultades en el traslado</option>
		    	<option Value=10>Realizaci�n de tr�mites</option>
		    	<option Value=11>Factores clim�ticos</option>
		    	<option Value=12 selected="selected">Viaje a otra localidad</option>
		    	<option Value=13>No demuestra inter�s-compromiso</option>
		    </c:when>
		    <c:when test="${entrevista.motivoAusencia == 'NODEMUESTRAINTERES'}">
    			<option value=0>Seleccione una opci&oacute;n:</option>
				<option Value=1 selected="selected">Razones de salud propia o de terceros</option>
				<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
				<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
				<option Value=4 >Otros</option>
				<option Value=5 disabled="disabled">No corresponde</option>								
		    	<option Value=6>Cuidado-ayuda a terceros</option>
		    	<option Value=7>Motivos laborales</option>
		    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
		    	<option Value=9>Dificultades en el traslado</option>
		    	<option Value=10>Realizaci�n de tr�mites</option>
		    	<option Value=11>Factores clim�ticos</option>
		    	<option Value=12>Viaje a otra localidad</option>
		    	<option Value=13 selected="selected">No demuestra inter�s-compromiso</option>
		    </c:when>
		    <c:when test="${entrevista.motivoAusencia == 'OTROS'}">
    			<option value=0>Seleccione una opci&oacute;n:</option>
				<option Value=1 >Razones de salud propia o de terceros</option>
				<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
				<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
				<option Value=4 selected="selected">Otros</option>
				<option Value=5 disabled="disabled">No corresponde</option>								
		    	<option Value=6>Cuidado-ayuda a terceros</option>
		    	<option Value=7>Motivos laborales</option>
		    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
		    	<option Value=9>Dificultades en el traslado</option>
		    	<option Value=10>Realizaci�n de tr�mites</option>
		    	<option Value=11>Factores clim�ticos</option>
		    	<option Value=12>Viaje a otra localidad</option>
		    	<option Value=13>No demuestra inter�s-compromiso</option>
		    </c:when>
		    <c:otherwise>
    						<option value=0>Seleccione una opci&oacute;n:</option>
				<option Value=1>Razones de salud propia o de terceros</option>
				<option Value=2>Sin justificaci�n-se desconoce el motivo</option>
				<!--option Value=3>Sin justificaci�n-se desconoce el motivo</option-->
				<option Value=4 >Otros</option>
				<option Value=5 disabled="disabled">No corresponde</option>								
		    	<option Value=6>Cuidado-ayuda a terceros</option>
		    	<option Value=7>Motivos laborales</option>
		    	<option Value=8>Desconocimiento, olvido o confusi�n fecha entrevista</option>
		    	<option Value=9>Dificultades en el traslado</option>
		    	<option Value=10>Realizaci�n de tr�mites</option>
		    	<option Value=11>Factores clim�ticos</option>
		    	<option Value=12>Viaje a otra localidad</option>
		    	<option Value=13>No demuestra inter�s-compromiso</option>
		    </c:otherwise>
		</c:choose>
	</select>
	<!-- /form:select-->
</div>
<div class="form-group form-inline">		
	<label>Otro Motivo &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>										
	<form:textarea path="otroMotivoAusencia" class="form-control" name="otroMotivoAusencia" id="otroMotivoAusencia" rows="4" style="width:700px" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
</div>				
<input type="hidden" value="${entrevista.raNoConvocado}">
<input type="hidden" value="${entrevista.motivoNoConvocatoria}">
<input type="hidden" value="${entrevista.raNoConvocado}">
<input type="hidden" value="${entrevista.motivoNoConvocatoria}">
<input type="hidden" id="motivoNoConvocatoria" name="motivoNoConvocatoria" value="${entrevista.motivoNoConvocatoria}">
<input type="hidden" value="${entrevista.participoRA}">						
<input type="hidden" id="motivoAusenciaRA" name="motivoAusenciaRA" value="${entrevista.motivoAusenciaRA}">
<input type="hidden" id="otroMotivoAusenciaRA" name="otroMotivoAusenciaRA" value=" ">				
<div class="form-group form-inline">
	<label class="text-danger">Participaci�n RA &nbsp;&nbsp;</label>
	<select  class="form-control"  id="motivoAusenciaRa2" name="motivoAusenciaRa2" style='width:auto'>
		<c:choose>
			<c:when test="${entrevista.motivoAusenciaRa2 == 'Presente'}">
     						<option value='0'>Seleccione una opci&oacute;n:</option>
					<option value='Presente' selected="selected">Presente</option>
					<option value='Ausente' >Ausente</option>
					<option value='No fue convocado' >No fue convocado</option>    	
		    </c:when>													    
		    <c:when test="${entrevista.motivoAusenciaRa2 == 'Ausente'}">
     						<option value='0'>Seleccione una opci&oacute;n:</option>
					<option value='Presente' >Presente</option>
					<option value='Ausente' selected="selected">Ausente</option>
					<option value='No fue convocado' >No fue convocado</option>    	
		    </c:when>								
		    <c:when test="${entrevista.motivoAusenciaRa2 == 'No fue convocado'}">
     						<option value='0'>Seleccione una opci&oacute;n:</option>
					<option value='Presente' >Presente</option>
					<option value='Ausente' >Ausente</option>
					<option value='No fue convocado' selected="selected">No fue convocado</option>    	
		    </c:when>									
		    <c:otherwise>
		    		<option value='0'>Seleccione una opci&oacute;n:</option>
					<option value='Presente' >Presente</option>
					<option value='Ausente' >Ausente</option>
					<option value='No fue convocado'>No fue convocado</option>
		    </c:otherwise>								
		</c:choose>				
	</select>
</div>

<div class="card bg-info text-white">
		<div class="card-body">Datos Escolares</div>
</div>
<br>
<div class="form-group">
	<label for="uname">Orientaci�n Escolar: ${alumno.escuela.modalidadEscolar.valor}</label>										
</div>
<br>

<div class="form-group form-inline"> 
		<label for="uname">Inasistencias mensuales &nbsp;&nbsp;</label>
		<form:input path="cantidadInasistencias" class="form-control" name="cantidadInasistencias" id="cantidadInasistencias" onkeypress="return validarDecimal(event, this);" onchange="habilitarMotivoInasistencias(this)" size="5"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<label for="uname">Principal motivo de inasistencia &nbsp;&nbsp;</label>	
		
		<select class="form-control" name="motivoInasistenciaR" id="motivoInasistenciaR" style='width:auto'>
			<c:choose>
 				<c:when test="${entrevista.motivoInasistenciaR == 'Llegada tarde'}">
    				<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde" selected="selected">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Se qued� dormido/a'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a" selected="selected">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Cuidado-ayuda a terceros'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" selected="selected" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Dificultades en el traslado'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado" selected="selected">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Factores clim�ticos'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos" selected="selected">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Motivos laborales'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales" selected="selected">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Razones de salud propia'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia" selected="selected">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Viaje a otra localidad'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad" selected="selected">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Realizaci�n de tr�mites personales'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales" selected="selected">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>							    	
			    </c:when>		
			    <c:when test="${entrevista.motivoInasistenciaR == 'Otro'}">
	    			<option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro" selected="selected">Otro</option>							    	
			    </c:when>		
			    <c:otherwise>
				    <option value="0">Seleccione una opci&oacute;n:</option>
					<option value="Llegada tarde">Llegada tarde</option>
					<option Value="Se qued� dormido/a">Se qued� dormido/a</option>									
					<option Value="Cuidado-ayuda a terceros" >Cuidado-ayuda a terceros</option>
					<option Value="Dificultades en el traslado">Dificultades en el traslado</option>								
			    	<option Value="Factores clim�ticos">Factores clim�ticos</option>
			    	<option Value="Motivos laborales">Motivos laborales</option>
			    	<option Value="Razones de salud propia">Razones de salud propia</option>
			    	<option Value="Viaje a otra localidad">Viaje a otra localidad</option>
			    	<option Value="Realizaci�n de tr�mites personales">Realizaci�n de tr�mites personales</option>
			    	<option Value="Otro">Otro</option>		
				</c:otherwise>
			</c:choose>
		</select>			
	</div>				
	
	
<div class="card bg-info text-white">
		<div class="card-body">Acompa�amiento</div>
</div>
<br>

<div class="form-group form-inline">
	<label class="text-danger">Objetivo del encuentro y actividad implementada &nbsp;&nbsp;</label>												   					
	<textarea rows="4" style="width:700px" id="objetivoEncuentro" name="objetivoEncuentro"   class="form-control">${entrevista.objetivoEncuentro}</textarea> 		
</div>
<br>		
<div class="form-group form-inline">		
	<label class="text-danger">Principal HSE trabajada  &nbsp;&nbsp;</label>				
	<select  name="hsTrabajarA�o" id="hsTrabajarA�o" style='width:auto' class="form-control"> 
		<c:choose>
 				<c:when test="${entrevista.hsTrabajarA�o == 'Autoconcepto'}">
   				<option value="0">Seleccione una opci&oacute;n:</option>
				<option value="Autoconcepto" selected="selected">Autoconcepto</option>
				<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
				<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
				<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
		    	<option Value="Toma de decisiones">Toma de decisiones</option>
		    	<option Value="Otra">Otra</option>				    	  						    
		    </c:when>	
		    <c:when test="${entrevista.hsTrabajarA�o == 'Planificaci�n y organizaci�n del tiempo'}">
   				<option value="0">Seleccione una opci&oacute;n:</option>
				<option value="Autoconcepto" >Autoconcepto</option>
				<option Value="Planificaci�n y organizaci�n del tiempo" selected="selected">Planificaci�n y organizaci�n del tiempo</option>									
				<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
				<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
		    	<option Value="Toma de decisiones">Toma de decisiones</option>
		    	<option Value="Otra">Otra</option>				    	  						    
		    </c:when>	
		    <c:when test="${entrevista.hsTrabajarA�o == 'Relaciones interpersonales'}">
   				<option value="0">Seleccione una opci&oacute;n:</option>
				<option value="Autoconcepto">Autoconcepto</option>
				<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
				<option Value="Relaciones interpersonales"  selected="selected">Relaciones interpersonales</option>
				<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
		    	<option Value="Toma de decisiones">Toma de decisiones</option>
		    	<option Value="Otra">Otra</option>				    	  						    
		    </c:when>	
		    <c:when test="${entrevista.hsTrabajarA�o == 'Responsabilidad y autonom�a'}">
    				<option value="0">Seleccione una opci&oacute;n:</option>
				<option value="Autoconcepto">Autoconcepto</option>
				<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
				<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
				<option Value="Responsabilidad y autonom�a" selected="selected">Responsabilidad y autonom�a</option>								
		    	<option Value="Toma de decisiones">Toma de decisiones</option>
		    	<option Value="Otra">Otra</option>				    	  						    
		    </c:when>	
		    <c:when test="${entrevista.hsTrabajarA�o == 'Toma de decisiones'}">
    				<option value="0">Seleccione una opci&oacute;n:</option>
				<option value="Autoconcepto">Autoconcepto</option>
				<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
				<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
				<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
		    	<option Value="Toma de decisiones" selected="selected">Toma de decisiones</option>
		    	<option Value="Otra">Otra</option>				    	  						    
		    </c:when>					    
		    <c:when test="${entrevista.hsTrabajarA�o == 'Otra'}">
    				<option value="0">Seleccione una opci&oacute;n:</option>
				<option value="Autoconcepto">Autoconcepto</option>
				<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
				<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
				<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
		    	<option Value="Toma de decisiones" >Toma de decisiones</option>
		    	<option Value="Otra" selected="selected">Otra</option>				    	  						    
		    </c:when>
		   	<c:otherwise>
		    	<option value="0">Seleccione una opci&oacute;n:</option>
				<option value="Autoconcepto">Autoconcepto</option>
				<option Value="Planificaci�n y organizaci�n del tiempo">Planificaci�n y organizaci�n del tiempo</option>									
				<option Value="Relaciones interpersonales" >Relaciones interpersonales</option>
				<option Value="Responsabilidad y autonom�a">Responsabilidad y autonom�a</option>								
		    	<option Value="Toma de decisiones">Toma de decisiones</option>
		    	<option Value="Otra">Otra</option>		
		    </c:otherwise>		
		</c:choose>
	</select>
</div>
<br>
<div class="form-group form-inline">		
	<label>&nbsp;&nbsp;Otra&nbsp; &nbsp;</label>										
	<form:textarea path="observacionesGenerales" class="form-control" name="observacionesGenerales" id="observacionesGenerales" rows="4" style="width:700px" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
</div>
<br>
<div class="form-group form-inline">
	<label class="text-danger">Principal Contenido trabajado  &nbsp;&nbsp;</label>			
	<form:select path="contenidosTrabajarEnElAnio" style='width:auto' class="form-control">
		<form:options items="${contenidosTrabajarEnElAnio}" itemLabel="valor" itemValue="id"/>				
	</form:select>
</div>
<br>
<div class="form-group form-inline">
	<label>Otro contenido trabajado &nbsp;&nbsp;</label>										
	
	<form:textarea path="motivoInasistencia" class="form-control" name="motivoInasistencia" id="motivoInasistencia" rows="4" style="width:700px" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
</div>
<br>
<div class="form-group">
	<label class="text-danger">Observaciones sobre<br>la trayectoria escolar y<br>asistencia</label>
	<form:textarea path="osme" class="form-control" id="osme" rows="4" cols="50" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/> &nbsp;&nbsp;
</div>
<br>







<input type="hidden" id="anioEgreso" name="anioEgreso" value="${egreso}">	
<c:if test="${egreso==2020}">
	
		<div class="card bg-secondary text-white">
			<div class="card-body"><h2>Egreso 2020</h2> </div>
		</div>
		<div class="card bg-light text-dark">						
			
			<div class="form-group form-inline">
				<label class="text-danger">Situaci�n escolar actual</label>	
				<select id="sea" name="sea" style='width:auto' class="form-control">				
  					<c:if test="${entrevista.sea == 'Egreso Efectivo'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="Egreso Efectivo" selected="selected">Egreso Efectivo</option>
						<option value="Egreso Pendiente">Egreso Pendiente</option>					
					</c:if>
				<c:if test="${entrevista.sea == 'Egreso Pendiente'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="Egreso Efectivo" >Egreso Efectivo</option>
						<option value="Egreso Pendiente" selected="selected">Egreso Pendiente</option>					
					</c:if>
				<c:if test="${entrevista.sea != 'Egreso Efectivo' && entrevista.sea != 'Egreso Pendiente'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="Egreso Efectivo" >Egreso Efectivo</option>
						<option value="Egreso Pendiente">Egreso Pendiente</option>		
				</c:if>				
			</select>
		</div>
		<br>
		<div class="form-group">
			<label class="text-danger">Plan de Acci�n acordado con el EP (esta informaci�n va a ser utilizada por el equipo de oficina para el seguimiento posterior. Por favor, agregar toda informaci�n de fechas importantes, materias a rendir y estrategias definidas en el cronograma)</label>												   					
			<br>
			<form:textarea path="planAccion" rows="13" cols="100" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/> 		<!-- CAMBIAR POR paep -->
		</div>	
		<br>
		<div class="form-group form-inline">	
			<label >Direcci�n de mail  &nbsp;&nbsp;</label>										
			<form:input path="dirMail" id="dirMail"  style="width:auto;" class="form-control"/>	
		</div>
		<br>
		<div class="form-group form-inline">	
			<label >Celular EP  &nbsp;&nbsp;</label>										
			<form:input path="celular" id="celular"  style="width:auto;" class="form-control"/>
		</div>
		<br>	
		<div class="form-group form-inline">	
			<label>Tel�fono alternativo  &nbsp;&nbsp;</label>										
			<form:input path="telFijo" id="telFijo"  style="width:auto;" class="form-control"/>					
		</div>
		<br>
		<div class="form-group form-inline">
				<label class="text-danger">El celular es de uso propio?</label>	
				<select id="cup" name="cup" style='width:auto' class="form-control">				
  					<c:if test="${entrevista.cup == 'Si, uso propio'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="Si, uso propio" selected="selected">Si, uso propio</option>
						<option value="No, uso compartido con otros familiares">No, uso compartido con otros familiares</option>					
					</c:if>
				<c:if test="${entrevista.cup == 'No, uso compartido con otros familiares'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="Si, uso propio">Si, uso propio</option>
						<option value="No, uso compartido con otros familiares"  selected="selected">No, uso compartido con otros familiares</option>					
					</c:if>
				<c:if test="${entrevista.cup != 'Si, uso propio' && entrevista.cup != 'No, uso compartido con otros familiares'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="Si, uso propio">Si, uso propio</option>
						<option value="No, uso compartido con otros familiares">No, uso compartido con otros familiares</option>		
				</c:if>				
			</select>
		</div>
		<br>
		<div class="form-group form-inline">
				<label class="text-danger">�Tiene wifi en el hogar?</label>	
				<select id="wifi" name="wifi" style='width:auto' class="form-control">				
  					<c:if test="${entrevista.wifi == 'S�'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="S�" selected="selected">S�</option>
						<option value="No">No</option>					
					</c:if>
				<c:if test="${entrevista.wifi == 'No'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="S�">S�</option>
						<option value="No"  selected="selected">No</option>					
					</c:if>
				<c:if test="${entrevista.wifi != 'S�' && entrevista.wifi != 'No'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="S�">S�</option>
						<option value="No">No</option>		
				</c:if>				
			</select>
		</div>
		<br>
		<div class="form-group form-inline">
				<label class="text-danger">Tiene computadora en el hogar?</label>	
				<select id="pc" name="pc" style='width:auto' class="form-control">				
  					<c:if test="${entrevista.pc == 'S�'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="S�" selected="selected">S�</option>
						<option value="No">No</option>					
					</c:if>
				<c:if test="${entrevista.pc == 'No'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="S�">S�</option>
						<option value="No"  selected="selected">No</option>					
					</c:if>
				<c:if test="${entrevista.pc != 'S�' && entrevista.pc != 'No'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="S�">S�</option>
						<option value="No">No</option>		
				</c:if>				
			</select>
		</div>
		<br>
		<div class="form-group form-inline">
				<label class="text-danger">�EP Participa del Apoyo Escolar Virtual?</label>	
				<select id="epaev" name="epaev" style='width:auto' class="form-control">				
  					<c:if test="${entrevista.epaev == 'S�'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="S�" selected="selected">S�</option>
						<option value="No">No</option>					
					</c:if>
				<c:if test="${entrevista.epaev == 'No'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="S�">S�</option>
						<option value="No"  selected="selected">No</option>					
					</c:if>
				<c:if test="${entrevista.epaev != 'S�' && entrevista.epaev != 'No'}">
						<option value="0" >Seleccione una opci�n</option>
						<option value="S�">S�</option>
						<option value="No">No</option>		
				</c:if>				
			</select>
		</div>
		<br>
		<div class="form-group">
			<label class="text-danger">Detallar brevemente c�mo es la acreditaci�n de contenidos en la escuela y curso del EP para el egreso efectivo (ej: se tiene en cuenta la entrega de trabajos pr�cticos enviados por plataforma virtual o presencial, la participaci�n/asistencia a clases virtuales o presenciales, la evaluaci�n o pruebas presenciales o virtuales, etc.)</label>												   					
			<br>
			<form:textarea path="detallarAcreditacion" rows="16" cols="100" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/> 		<!-- CAMBIAR POR paep -->
		</div>
		<br>
		<div class="form-group">
			<label class="text-danger">Nombre, apellido, y tel�fono del Referente Escolar (este referente ser� contactado para recabar informaci�n escolar del EP, en caso de que sea necesario) </label>												   					
			<br>
			<form:textarea path="referenteEscolar" rows="6" cols="100" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/> 		<!-- CAMBIAR POR paep -->
		</div>
		<br>
			
			
			
			
			<div class="form-group form-inline">
				<label class="text-danger">Situaci�n post-escolar</label>	
				<select id="spe" name="spe" style='width:auto' class="form-control">				
  					<c:if test="${entrevista.spe == 'Inscripto en un estudio superior'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Inscripto en un estudio superior" selected="selected">Inscripto en un estudio superior</option>
					<option value="Trabajando o buscando trabajo">Trabajando o buscando trabajo</option>
					<option value="Inscripto en un estudio superior y trabajando o buscando trabajo">Inscripto en un estudio superior y trabajando o buscando trabajo</option>					
					<option value="No est� inscripto en un estudio superior y no est� trabajando ni buscando trabajo">No est� inscripto en un estudio superior y no est� trabajando ni buscando trabajo</option>
				</c:if>							
  				<c:if test="${entrevista.spe == 'Trabajando o buscando trabajo'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Inscripto en un estudio superior" >Inscripto en un estudio superior</option>
					<option value="Trabajando o buscando trabajo" selected="selected">Trabajando o buscando trabajo</option>
					<option value="Inscripto en un estudio superior y trabajando o buscando trabajo">Inscripto en un estudio superior y trabajando o buscando trabajo</option>					
					<option value="No est� inscripto en un estudio superior y no est� trabajando ni buscando trabajo">No est� inscripto en un estudio superior y no est� trabajando ni buscando trabajo</option>
				</c:if>
							
  				<c:if test="${entrevista.spe == 'Inscripto en un estudio superior y trabajando o buscando trabajo'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Inscripto en un estudio superior">Inscripto en un estudio superior</option>
					<option value="Trabajando o buscando trabajo">Trabajando o buscando trabajo</option>
					<option value="Inscripto en un estudio superior y trabajando o buscando trabajo" selected="selected">Inscripto en un estudio superior y trabajando o buscando trabajo</option>					
					<option value="No est� inscripto en un estudio superior y no est� trabajando ni buscando trabajo">No est� inscripto en un estudio superior y no est� trabajando ni buscando trabajo</option>
				</c:if>
							
  				<c:if test="${entrevista.spe == 'No est� inscripto en un estudio superior y no est� trabajando ni buscando trabajo'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Inscripto en un estudio superior" selected="selected">Inscripto en un estudio superior</option>
					<option value="Trabajando o buscando trabajo">Trabajando o buscando trabajo</option>
					<option value="Inscripto en un estudio superior y trabajando o buscando trabajo">Inscripto en un estudio superior y trabajando o buscando trabajo</option>					
					<option value="No est� inscripto en un estudio superior y no est� trabajando ni buscando trabajo" selected="selected">No est� inscripto en un estudio superior y no est� trabajando ni buscando trabajo</option>
				</c:if>
				<c:if test="${entrevista.spe != 'Inscripto en un estudio superior' && entrevista.spe != 'Trabajando o buscando trabajo' 
						&& entrevista.spe != 'Inscripto en un estudio superior y trabajando o buscando trabajo' && entrevista.spe != 'No est� inscripto en un estudio superior y no est� trabajando ni buscando trabajo'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Inscripto en un estudio superior">Inscripto en un estudio superior</option>
					<option value="Trabajando o buscando trabajo">Trabajando o buscando trabajo</option>
					<option value="Inscripto en un estudio superior y trabajando o buscando trabajo">Inscripto en un estudio superior y trabajando o buscando trabajo</option>					
					<option value="No est� inscripto en un estudio superior y no est� trabajando ni buscando trabajo">No est� inscripto en un estudio superior y no est� trabajando ni buscando trabajo</option>
				</c:if>				
			</select>
		</div>				
	</div>			
</c:if>

<c:if test="${egreso!=2020}">
	<input type="checkbox" name="cv" id="cv" checked style="display:none" value="false">
	<input type="checkbox" name="tma" id="tma" checked style="display:none" value="false">
	<input type="hidden" name="te" id="te" value="-">
	<input type="hidden" name="ie" id="ie" value="-">
	<input type="hidden" name="facebook" id="facebook" value="-">
	<!--input type="hidden" name="dirMail" id="dirMail" value="-">
	<input type="hidden" name="celular" id="celular" value="-"-->		
	<input type="hidden" name="sarpepe" id="sarpepe" value="-">
	<input type="hidden" name="evaluacionProposito" id="evaluacionProposito" value="-">
	<input type="hidden" name="telfijo" id="telfijo" value="-">
	
	<input type="hidden" name="sea" id="sea" value="0">
	<input type="hidden" name="cup" id="cup" value="0">
	<input type="hidden" name="wifi" id="wifi" value="0">
	<input type="hidden" name="pc" id="pc" value="0">
	<input type="hidden" name="epaev" id="epaev" value="0">
	<input type="hidden" name="spe" id="spe" value="0">
	<input type="hidden" name="planAccion" id="planAccion" value=" ">
	<input type="hidden" name="detallarAcreditacion" id="detallarAcreditacion" value="0">
	<input type="hidden" name="referenteEscolar" id="referenteEscolar" value="0">
	
	
	
	
	
</c:if>


<br>			

<input type="hidden" name="brujula" id="compromisoRA" value="false">
<input type="hidden" name="compromisoRA" id="compromisoRA" value="1">
<input type="hidden" name="estrategiaComp" id="estrategiaComp" value="5">
<input type="hidden" id="horaProxEntrevista" name="horaProxEntrevista" value="12:00">
<input type="hidden" id="lugarProximaEntrevista" name="lugarProximaEntrevista" size="39" value="${alumno.escuela.nombre}"  />
<input type="hidden" id="idProxima" name="lugarProximaEntrevista.id" value="${alumno.escuela.id}"></input>	

<div class="form-group form-inline">
	<label class="text-danger">Situaci�n de Riesgo extra-escolar &nbsp;&nbsp;</label>						
	<form:select path="situacionCrisis" style='width:auto' class="form-control">
		<form:options items="${situacionCrisis}" itemLabel="valor" itemValue="id"/>				
	</form:select>							
</div>
<div class="form-group form-inline">
	<label class="text-danger">Situaci�n de Riesgo escolar &nbsp;&nbsp;</label>						
	<form:select path="situacionRiesgoEscolar" style='width:auto' class="form-control">
		<form:options items="${situacionRiesgoEscolar}" itemLabel="valor" itemValue="id"/>				
	</form:select>							
</div>

<div class="form-group form-inline">
	<label>Observaciones sobre situaci�n de riesgo &nbsp;&nbsp;</label>												   					
	<textarea rows="4" style="width:700px" id="aislsdrs" name="aislsdrs"   class="form-control">${entrevista.aislsdrs}</textarea> 		
</div>


<div class="form-group form-inline">
		<label class="text-danger">Resultado A�o Escolar &nbsp;&nbsp;</label>	
		<select id="rae" name="rae" style='width:auto' class="form-control">	
		<c:choose>			
			<c:when test="${entrevista.rae == '1'}">
				<option value="0" >Seleccione una opci�n</option>
				<option value="1" selected="selected">Promovido sin materias a rendir</option>
				<option value="5">Promovido con materias a rendir</option>
				<option value="2">Promoci�n Pendiente</option>
				<option value="4">Egreso Efectivo</option>
				<option value="6">Egreso Pendiente</option>					
			</c:when>
			<c:when test="${entrevista.rae == '5'}">
				<option value="0" >Seleccione una opci�n</option>
				<option value="1" >Promovido sin materias a rendir</option>
				<option value="5" selected="selected">Promovido con materias a rendir</option>
				<option value="2">Promoci�n Pendiente</option>
				<option value="4">Egreso Efectivo</option>
				<option value="6">Egreso Pendiente</option>					
			</c:when>
			<c:when test="${entrevista.rae == '2'}">
				<option value="0" >Seleccione una opci�n</option>
				<option value="1">Promovido sin materias a rendir</option>
				<option value="5">Promovido con materias a rendir</option>
				<option value="2" selected="selected">Promoci�n Pendiente</option>
				<option value="4">Egreso Efectivo</option>
				<option value="6">Egreso Pendiente</option>					
			</c:when>
			<c:when test="${entrevista.rae == '4'}">
				<option value="0" >Seleccione una opci�n</option>
				<option value="1">Promovido sin materias a rendir</option>
				<option value="5">Promovido con materias a rendir</option>
				<option value="2">Promoci�n Pendiente</option>
				<option value="4" selected="selected">Egreso Efectivo</option>
				<option value="6">Egreso Pendiente</option>					
			</c:when>
			<c:when test="${entrevista.rae == '6'}">
				<option value="0" >Seleccione una opci�n</option>
				<option value="1">Promovido sin materias a rendir</option>
				<option value="5">Promovido con materias a rendir</option>
				<option value="2">Promoci�n Pendiente</option>
				<option value="4">Egreso Efectivo</option>
				<option value="6" selected="selected">Egreso Pendiente</option>					
			</c:when>
		
			<c:otherwise>
				<option value="0" >Seleccione una opci�n</option>
				<option value="1">Promovido sin materias a rendir</option>
				<option value="5">Promovido con materias a rendir</option>
				<option value="2">Promoci�n Pendiente</option>
				<option value="4">Egreso Efectivo</option>
				<option value="6">Egreso Pendiente</option>					
			</c:otherwise>
			
		</c:choose>
		
				
	</select>
</div>
<br>		






<c:if test="${egreso==2020}">
	<input type="hidden" value="" id="motivoNoRenovacion" name="motivoNoRenovacion">
</c:if>

<div class="form-group form-inline">
	<label class="text-danger">Evaluaci�n Cobro Beca  &nbsp;&nbsp;</label>	
		<form:select path="evaluacionCobroBeca" id="evaluacionCobroBeca" style='width:auto' class="form-control required">
			<form:option value="">Seleccione una opcion...</form:option>
			<form:options items="${evaluacionCobroBeca}" itemLabel="valor" itemValue="id"/>					
		</form:select>
</div>	
<div class="form-group form-inline">
	<label class="text-danger">Motivo de Suspensi�n  &nbsp;&nbsp;</label>	
		<form:select path="motivoSuspension" id="motivoSuspension" style='width:auto' class="form-control required">
			<form:option value="">Seleccione una opcion...</form:option>
			<form:options items="${motivoSuspension}" itemLabel="valor" itemValue="id"/>					
		</form:select>
</div>
			
<div class="form-group">
	<label>Comentarios de revisi�n, intercambio RR-EA</label>												   					
	<br>
	<form:textarea path="comentariosRevision" rows="15" cols="100" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/> 		
</div>

</form:form>	
</div>	  	
	</div>
</div>

<input id="idEA" type="hidden" value="${idEA}"/>
<input id="fechaActual" type="hidden" value="${fechaActual}">
<input id="ultimoAnio" type="hidden" value="${ultimoAnio}">
</body>
</html>