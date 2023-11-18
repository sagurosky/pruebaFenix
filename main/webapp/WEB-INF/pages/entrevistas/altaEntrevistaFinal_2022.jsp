<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>..:: Espacio de acompa�amiento Final ::..</title>
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
<script type="text/javascript" src="<c:url  value="/static/js/funcionesEntrevistaFinal.js"/>"></script>
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
				//alert(4);
				//alert(document.forms['altaEntrevistaIndividual'].fechaEntrevista.value);
				//alert(document.forms['altaEntrevistaIndividual'].fechaActual.value);
				/*if (esMayor(document.forms['altaEntrevistaIndividual'].fechaEntrevista.value, document.forms['altaEntrevistaIndividual'].fechaActual.value)){
					document.forms['altaEntrevistaIndividual'].fechaEntrevista.focus();
					jAlert('warning', '"Fecha Entrevista" no puede ser mayor a la fecha actual', 'Atenci�n!')		
					//alert(5);
				}*/
				if(document.forms['altaEntrevistaIndividual'].participoBecado.value=="0" && document.forms['altaEntrevistaIndividual'].motivoAusencia.value=="0"){			
					jAlert('warning', 'Falta completar Motivo de Ausencia Becado', 'Atenci�n!');  
					return false;	
				}
				
				
				if(document.forms['altaEntrevistaIndividual'].motivoAusenciaRa2.value=="0"){			
					jAlert('warning', 'Falta completar Participaci�n RA', 'Atenci�n!');  
					return false;	
				}
				
				if(document.forms['altaEntrevistaIndividual'].ecabp.value=="0"){			
					jAlert('warning', 'Falta completar Valoraci�n compromiso EPcon el Progama ', 'Atenci�n!');  
					return false;	
				}
				
				if(document.forms['altaEntrevistaIndividual'].vcrae.value=="0"){			
					jAlert('warning', 'Falta completar Valoraci�n compromiso RA con el Progama ', 'Atenci�n!');  
					return false;	
				}
				
				if(document.forms['altaEntrevistaIndividual'].propositoAnual.value==""){			
					jAlert('warning', 'Falta completar Seguimiento del prop�sito anual ', 'Atenci�n!');  
					return false;	
				}
				
				if(document.forms['altaEntrevistaIndividual'].qtam.value==""){			
					jAlert('warning', 'Falta completar �Qu� trabajaste en el acompa�amiento en esta 2da parte del a�o?', 'Atenci�n!');  
					return false;	
				}
				
				
				if(document.forms['altaEntrevistaIndividual'].osme.value==""){			
					jAlert('warning', 'Falta completar Observaciones sobre la trayectoria escolar y asistencia durante la segunda parte del a�o', 'Atenci�n!');  
					return false;	
				}
				
				if(document.forms['altaEntrevistaIndividual'].hsTrabajarA�o.value=="0"){			
					jAlert('warning', 'Falta completar Principal habilidad trabajada en la 2� parte del a�o', 'Atenci�n!');  
					return false;	
				}
								
				if(document.forms['altaEntrevistaIndividual'].contenidosTrabajarEnElAnio.value<="0"){			
					jAlert('warning', 'Falta completar Principal Contenido trabajado durante la 2da parte del a�o', 'Atenci�n!');  
					return false;	
				}
				
				if(document.forms['altaEntrevistaIndividual'].sarpepe.value=="0"){			
					jAlert('warning', 'Falta completar Proyecci�n post-escolar', 'Atenci�n!');  
					return false;	
				}
				
				
				if(document.forms['altaEntrevistaIndividual'].anioEgreso.value=="2021"){
					if(document.forms['altaEntrevistaIndividual'].dirMail.value==""){			
						jAlert('warning', 'Falta completar Direcci�n de mail ', 'Atenci�n!');  
						return false;	
					}
					if(document.forms['altaEntrevistaIndividual'].celular.value==""){			
						jAlert('warning', 'Falta completar Celular ', 'Atenci�n!');  
						return false;	
					}
										
				}
				
				if(document.forms['altaEntrevistaIndividual'].anioEgreso.value=="2022"){
					if(document.forms['altaEntrevistaIndividual'].dirMail.value==""){			
						jAlert('warning', 'Falta completar Direcci�n de mail ', 'Atenci�n!');  
						return false;	
					}
					if(document.forms['altaEntrevistaIndividual'].celular.value==""){			
						jAlert('warning', 'Falta completar Celular ', 'Atenci�n!');  
						return false;	
					}
					
				}
				
				if(document.forms['altaEntrevistaIndividual'].alo.value==""){			
					jAlert('warning', 'Falta completar Aprendizajes, logros y oportunidades de mejora para continuar trabajando', 'Atenci�n!');  
					return false;	
					}
				
				if(document.forms['altaEntrevistaIndividual'].objetivoEncuentro.value==""){			
					jAlert('warning', 'Falta completar Objetivo del encuentro de diciembre y actividad implementada', 'Atenci�n!');  
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
				
				if(document.forms['altaEntrevistaIndividual'].evaluacionRenovacionFinal.value=="1"){
					if(document.forms['altaEntrevistaIndividual'].motivoNoRenovacion.value==""){
						jAlert('warning', 'Falta completar Motivo de No renovaci�n', 'Atenci�n!');
						return false;	
					}
							
					
				}
				
				
				if(document.forms['altaEntrevistaIndividual'].resultadoAnioEscolar.value==""){					
					jAlert('warning', 'Falta completar Resultado a�o escolar', 'Atenci�n!');
				}
				
				if(document.forms['altaEntrevistaIndividual'].evaluacionRenovacionFinal.value==""){					
					jAlert('warning', 'Falta completar Evaluaci�n de renovaci�n', 'Atenci�n!');
				}
				
				if(document.forms['altaEntrevistaIndividual'].evaluacionCobroBeca.value==""){					
					jAlert('warning', 'Falta completar Evaluaci�n cobro Beca', 'Atenci�n!');
				}
				
				if(document.forms['altaEntrevistaIndividual'].evaluacionCobroBeca.value=="4"){
					if(document.forms['altaEntrevistaIndividual'].motivoCesacion.value==""){			
						jAlert('warning', 'Falta completar Motivo de Suspensi�n', 'Atenci�n!');
					}
				}
				//alert();
				//if(document.forms['altaEntrevistaIndividual'].comentariosRevision.value==""){					
				//	jAlert('warning', 'Falta completar Detallar brevemente como es...', 'Atenci�n!');
				//}
				
				
				//2021
				
				
				
				
				else{
					
						$.blockUI();
						
						$('#altaEntrevistaIndividual').submit();
					//}
				}
			}
			else{
				//alert("hola");
				$.blockUI();
				
				document.forms['altaEntrevistaIndividual'].submit();
			}
	  	}
	}

	function guardar(valor, valorPerfil){	
		document.forms['altaEntrevistaIndividual'].valorPerfil.value = valorPerfil;
		document.forms['altaEntrevistaIndividual'].valorGuardar.value = valor;
		//alert(document.forms['altaEntrevistaIndividual'].evaluacionRenovacionFinal.value);
		//alert(document.forms['altaEntrevistaIndividual'].motivoNoRenovacion.value);
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
						<input type="button" class="btn btn-secondary" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../entrevistas/listarBecados.do'; return false;" />
					</c:if>	
					<c:if test="${tipoPerfil == 'superUsuario'}">
							<input type="button" class="btn btn-secondary" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../exportacionEntrevistas/verExportarEntrevistas.do'; return false;" />
					</c:if>	
				
			</div>
		</div>
	</div>



<div class="col-lg-10">
<form:form id="altaEntrevistaIndividual" commandName="entrevista" modelAttribute="entrevista" class="cmxform" method="post" action="guardarFinal.do?alumnoId=${alumno.id}&EA=${ea}">
<form:hidden path="id"/>
<form:hidden path="fechaCarga"/>
<form:hidden path="periodoDePago"/>
	<div class="card-body p-3 my-3 bg-secondary text-white">
		  <h3 title="IdAlumno=${alumno.id}">Espacio de acompa�amiento Final - ${periodo.nombre} ${periodo.ciclo.nombre}  ${entrevista.periodoDePago.nombre} ${entrevista.periodoDePago.ciclo.nombre} - ${entrevista.estadoEntrevista.valor}<br>${alumno.datosPersonales.nombre}&nbsp;${alumno.datosPersonales.apellido}</h3>
			Fecha Incorporaci�n PFE: <fmt:formatDate value="${alumno.fechaPBE}" pattern="dd/MM/yyyy"/>
			<br>Escuela: ${alumno.escuela.nombre}<br>
			A�o Escolar: ${alumno.anioEscolar.valor} - 
			A�o Egreso:		
			<c:if test="${alumno.escuela.zonaCimientos.eae=='6/6'}">
		    	<c:if test="${alumno.anioAdicional}">
					${alumno.beca.ciclo.nombre+14-alumno.anioEscolar.id+1} 
				</c:if>
				<c:if test="${!alumno.anioAdicional}">
					${alumno.beca.ciclo.nombre+14-alumno.anioEscolar.id} 
				</c:if>
			</c:if>
			<c:if test="${alumno.escuela.zonaCimientos.eae=='7/5'}">
		    	<c:if test="${alumno.anioAdicional}">
					${alumno.beca.ciclo.nombre+13-alumno.anioEscolar.id+1} 
				</c:if>
				<c:if test="${!alumno.anioAdicional}">
					${alumno.beca.ciclo.nombre+13-alumno.anioEscolar.id} 
				</c:if>
			</c:if>	
			<c:if test="${alumno.anioAdicional==true}">
				 - Tiene a�o adicional
			</c:if>
			<c:if test="${alumno.anioAdicional==false}">
				- No tiene a�o adicional
			</c:if>			
			<br>
			
			<c:if test="${entrevista.excepcion==true}">
				 Renovado por excepci�n
			</c:if>
			<c:if test="${entrevista.excepcion==false}">				
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
	<label class="text-danger">�Particip� el/la estudiante?</label>																				
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
<!--div class="form-group">
	<label for="uname">Orientaci�n Escolar: ${alumno.escuela.modalidadEscolar.valor}</label>										
</div>
<br-->
<div class="form-group">		
	<label>Materias/fechas a rendir en diciembre</label>										
	<form:textarea path="materiasRendirDiciembre" class="form-control" name="materiasRendirDiciembre" id="materiasRendirDiciembre" rows="4" style="width:270px" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
</div>				
<div class="form-group">		
	<label>Materias/fechas a rendir en febrero/marzo &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>										
	<form:textarea path="materiasRendirFebMarzo" class="form-control" name="materiasRendirFebMarzo" id="materiasRendirFebMarzo" rows="4" style="width:270px" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
</div>
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
<div class="form-group">
	<label class="text-danger">Evaluaci�n del compromiso EP con el programa &nbsp;&nbsp;</label><br>			
	<select class="form-control" style='width:auto' id="ecabp" name="ecabp">					
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
</div>		
<br>
<div class="form-group">
	<label class="text-danger">Evaluaci�n del compromiso RA con el programa &nbsp;&nbsp;</label><br>			
	<select id="vcrae" name="vcrae" style='width:auto' class="form-control">					
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
</div>	
<br>		
<div class="form-group">
	<label class="text-danger">Seguimiento de Prop�sito anual &nbsp;&nbsp;</label>			
	<form:textarea path="propositoAnual" class="form-control"  id="propositoAnual" rows="4" cols="60" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>										
</div>
<br>
<div class="form-group">
	<label class="text-danger">�Qu� trabajaste en el acompa�amiento<br>en esta segunda parte del a�o? &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>			
	<form:textarea path="qtam" class="form-control"  id="qtam" name="qtam" rows="4" cols="50" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/> &nbsp;&nbsp;	
	<font size="1">Atenci�n. Este campo va al Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>		
</div>
<div class="form-group">
	<label class="text-danger">Observaciones sobre<br>la trayectoria escolar y<br>asistencia durante<br>la segunda parte del a�o</label>
	<form:textarea path="osme" class="form-control" id="osme" rows="4" cols="50" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/> &nbsp;&nbsp;
	<font size="1">Atenci�n. Este campo va al Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
</div>
<div class="form-group">
	<label class="text-danger">Aprendizajes, logros<br>y oportunidades de mejora<br>para continuar trabajando</label>
	<form:textarea path="alo" class="form-control" id="alo" rows="4" cols="50" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/> &nbsp;&nbsp;
	<font size="1">Atenci�n. Este campo va al Informe al padrino.</font><img src="../static/images/atencion.gif" width=10>
</div>



<div class="form-group form-inline">		
	<label class="text-danger">Principal HSE trabajada durante la segunda parte del a�o  &nbsp;&nbsp;</label>				
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
<div class="form-group form-inline">		
	<label>&nbsp;&nbsp;Otra&nbsp; &nbsp;</label>										
	<form:textarea path="observacionesGenerales" class="form-control" name="observacionesGenerales" id="observacionesGenerales" rows="4" style="width:700px" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
</div>
<div class="form-group form-inline">
	<label class="text-danger">Principal contenido trabajado durante la segunda parte del a�o  &nbsp;&nbsp;</label>			
	<form:select path="contenidosTrabajarEnElAnio" style='width:auto' class="form-control">
		<form:options items="${contenidosTrabajarEnElAnio}" itemLabel="valor" itemValue="id"/>				
	</form:select>
</div>
<div class="form-group form-inline">
	<label>Otro contenido trabajado &nbsp;&nbsp;</label>										
	
	<form:textarea path="motivoInasistencia" class="form-control" name="motivoInasistencia" id="motivoInasistencia" rows="4" style="width:700px" onblur="chequearLongitud(this);" onkeypress="chequearLongitud(this);"/>
</div>
<div class="form-group form-inline">	
	<label class="text-danger">�Usaste el fichero en esta segunda parte del a�o? &nbsp;&nbsp;</label>			
	<form:checkbox path="usasteFichero" id="usasteFichero" style='width:auto' class="form-control"/>
</div>
<div class="form-group form-inline">	
	<label class="text-danger">�Completaste la br�jula con el EP en esta segunda parte del a�o? &nbsp;&nbsp;</label>			
	<form:checkbox path="brujula" id="brujula" style='width:auto' class="form-control" />
</div>
<div class="form-group form-inline">	
	<label class="text-danger">�El/la EP particip� del Apoyo Escolar Virtual? &nbsp;&nbsp;</label>			
	<select class="form-control" id="paev" name="paev" style='width:auto'>							
		<c:choose>
			<c:when test="${entrevista.paev == 'Si'}">
				<option value="0" >Seleccion</option>
				<option value="Si" selected="selected">Si</option>
				<option value="No" >No</option>    	
		    </c:when>													    
		    <c:when test="${entrevista.paev == 'No'}">       						
				<option value="0" >Seleccion</option>
				<option value="Si" >Si</option>
				<option value="No" selected="selected">No</option>    	
		    </c:when>
		    <c:otherwise>
		    	<option value="0" selected="selected">Seleccion</option>
		    	<option value="Si" >Si</option>
				<option value="No">No</option>
		    </c:otherwise>													    								
		</c:choose>			
	</select>
</div>


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
<input type="hidden" id="anioEgreso" name="anioEgreso" value="${egreso}">	
<c:if test="${egreso==2021 || egreso==2022}">
	<div class="card bg-light text-dark">
		<div class="card bg-secondary text-white">
			<div class="card-body"><h2>Egreso ${egreso}</h2> </div>
		</div>
		<div class="card bg-light text-dark">						
			<div class="form-group form-inline">
				<label class="text-danger">Proyecci�n post-escolar</label>	
				<select id="sarpepe" name="sarpepe" style='width:auto' class="form-control">				
  					<c:if test="${entrevista.sarpepe == 'Tiene pensado estudiar'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Tiene pensado estudiar" selected="selected">Tiene pensado estudiar</option>
					<option value="Tiene pensado trabajar">Tiene pensado trabajar</option>
					<option value="Tiene pensado estudiar y trabajar">Tiene pensado estudiar y trabajar</option>					
					<option value="Aun no lo sabe">Aun no lo sabe</option>
				</c:if>
				<c:if test="${entrevista.sarpepe == 'Tiene pensado estudiar y trabajar'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Tiene pensado estudiar">Tiene pensado estudiar</option>
					<option value="Quiere trabajar">Quiere trabajar</option>
					<option value="Tiene pensado estudiar y trabajar" selected="selected">Tiene pensado estudiar y trabajar</option>					
					<option value="Aun no lo sabe">Aun no lo sabe</option>
				</c:if>
				<c:if test="${entrevista.sarpepe == 'Tiene pensado trabajar'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Tiene pensado estudiar">Tiene pensado estudiar</option>
					<option value="Tiene pensado trabajar"  selected="selected">Tiene pensado trabajar</option>
					<option value="Tiene pensado estudiar y trabajar">Tiene pensado estudiar y trabajar</option>					
					<option value="Aun no lo sabe">Aun no lo sabe</option>
				</c:if>
				<c:if test="${entrevista.sarpepe == 'Aun no lo sabe'}">
					<option value="0" >Seleccione una opci�n</option>
					<option value="Tiene pensado estudiar">Tiene pensado estudiar</option>
					<option value="Tiene pensado trabajar">Tiene pensado trabajar</option>
					<option value="Tiene pensado estudiar y trabajar">Tiene pensado estudiar y trabajar</option>					
					<option value="Aun no lo sabe" selected="selected">Aun no lo sabe</option>
				</c:if>
				<c:if test="${entrevista.sarpepe != 'Tiene pensado estudiar' && entrevista.sarpepe != 'Tiene pensado estudiar y trabajar' 
						&& entrevista.sarpepe != 'Tiene pensado trabajar' && entrevista.sarpepe != 'Aun no lo sabe'}">
					<option value="0" >Seleccione una opci�n</option>
						<option value="Tiene pensado estudiar">Tiene pensado estudiar</option>
						<option value="Tiene pensado trabajar">Tiene pensado trabajar</option>
						<option value="Tiene pensado estudiar y trabajar">Tiene pensado estudiar y trabajar</option>						
						<option value="Aun no lo sabe">Aun no lo sabe</option>
				</c:if>				
			</select>
		</div>				
		<div class="form-group form-inline">					
			<label>En caso de que quiera estudiar �Qu� estudio quiere realizar?</label>			
			
			<select id="te" name="te" style='width:auto' class="form-control">				
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
				<c:if test="${entrevista.te != 'Universitarios' && entrevista.te != 'Terciarios' && entrevista.te != 'Curso-oficio' && entrevista.te != 'Aun no lo sabe' }">
					<option value="0" >Seleccione una opci�n</option>
						<option value="Universitarios">Universitarios</option>
						<option value="Terciarios">Terciarios</option>
						<option value="Curso-oficio">Curso-oficio</option>
						<option value="Aun no lo sabe">Aun no lo sabe</option>
				</c:if>				
			</select>			
		</div>	
		<div class="form-group form-inline">
			<label>Especificar nombre de Estudios o Carrera que le interesa</label>			
			<form:input path="ie" id="ie"  style="width:auto;" class="form-control"/>
			<font size="1">En caso de que tenga m�s de un estudio o carrera de interes, separar con comas.</font><img src="../static/images/atencion.gif" width=10>
		</div>	
		<div class="form-group form-inline">
			<label>Si ya lo tiene definido, especificar Instituci�n</label>	
			<form:input path="facebook" id="facebook"  style="width:auto;" class="form-control"/>
		</div>
		<div class="form-group form-inline">	
			<label class="text-danger">�Tiene su CV armado?  &nbsp;&nbsp;</label>
			<form:checkbox path="cv" id="cv" style='width:auto' class="form-control"/>
		</div>
		<div class="form-group form-inline">	
			<label class="text-danger">�Tiene mail activo?  &nbsp;&nbsp;</label>
			<form:checkbox path="tma" id="tma" style='width:auto' class="form-control"/>
		</div>	
		<div class="form-group form-inline">	
			<label class="text-danger">&nbsp;&nbsp; Correo electr�nico  &nbsp;&nbsp;</label>										
			<form:input path="dirMail" id="dirMail"  style="width:auto;" class="form-control"/>	
			<font size="1">Corroborar que los datos registrados en julio siguen vigentes.</font><img src="../static/images/atencion.gif" width=10>
			
		</div>
		<div class="form-group form-inline">	
			<label class="text-danger">&nbsp;&nbsp; Celular EP  &nbsp;&nbsp;</label>										
			<form:input path="celular" id="celular"  style="width:auto;" class="form-control"/>
		</div>	
		<div class="form-group form-inline">	
			<label>&nbsp;&nbsp; Redes Sociales  &nbsp;&nbsp;</label>										
			<form:input path="evaluacionProposito" id="evaluacionProposito"  style="width:auto;" class="form-control"/>
		</div>	
		<!--div class="form-group form-inline">	
			<label>&nbsp;&nbsp; Tel�fono fijo  &nbsp;&nbsp;</label>										
			<form:input path="telFijo" id="telFijo"  style="width:auto;" class="form-control"/>					
		</div-->
		<input type="hidden" name="telFijo" id="telFijo" value="-">	
		</div>
	</div>			
</c:if>

<c:if test="${egreso!=2021 && egreso!=2022}">
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
</c:if>


<br>			
<div class="form-group form-inline">
	<label class="text-danger">Objetivo del encuentro de diciembre y actividad implementada &nbsp;&nbsp;</label>												   					
	<textarea rows="4" style="width:700px" id="objetivoEncuentro" name="objetivoEncuentro"   class="form-control">${entrevista.objetivoEncuentro}</textarea> 		
</div>

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
	<label>Ampliar informaci�n sobre la situaci�n de riesgo seleccionada &nbsp;&nbsp;</label>												   					
	<textarea rows="4" style="width:700px" id="aislsdrs" name="aislsdrs"   class="form-control">${entrevista.aislsdrs}</textarea> 		
</div>


<div class="form-group form-inline">
	<label class="text-danger">Resultado A�o Escolar &nbsp;&nbsp;</label>	
		<form:select path="situacionEscolarMergeada" id="resultadoAnioEscolar" style='width:auto' class="form-control required">
			<form:option value="">Seleccione una opcion...</form:option>
			<form:options items="${resultadoAnioEscolar}" itemLabel="valor" itemValue="id"/>					
		</form:select>
</div>	

<div class="form-group form-inline">
	<label class="text-danger">Evaluacion de renovaci�n &nbsp;&nbsp;</label>	
		<form:select path="evaluacionRenovacionFinal" id="evaluacionRenovacionFinal" style='width:auto' class="form-control required">
			<form:option value="">Seleccione una opcion...</form:option>
			<form:options items="${evaluacionRenovacionFinal}" itemLabel="valor" itemValue="id"/>					
		</form:select>
</div>	
<c:if test="${egreso!=2021}">
	<div class="form-group form-inline">
		<label class="text-danger">Motivo de no renovaci�n &nbsp;&nbsp;</label>	
			<form:select path="motivoNoRenovacion" id="motivoNoRenovacion" style='width:auto' class="form-control">
				<form:option value="">Seleccione una opcion...</form:option>
				<form:options items="${motivoNoRenovacion}" itemLabel="valor" itemValue="id"/>					
			</form:select>
	</div>	
</c:if>


<c:if test="${egreso==2021}">
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
	<label>Comentarios de revisi�n, intercambio RR - EA</label>												   					
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