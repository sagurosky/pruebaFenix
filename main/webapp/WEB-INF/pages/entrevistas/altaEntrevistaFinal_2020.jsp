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
				if (esMayor(document.forms['altaEntrevistaIndividual'].fechaEntrevista.value, document.forms['altaEntrevistaIndividual'].fechaActual.value)){
					document.forms['altaEntrevistaIndividual'].fechaEntrevista.focus();
					jAlert('warning', '"Fecha Entrevista" no puede ser mayor a la fecha actual', 'Atenci�n!')		
				//	alert(5);
				}
				if(document.forms['altaEntrevistaIndividual'].participoBecado.value=="0" && document.forms['altaEntrevistaIndividual'].motivoAusencia.value=="0"){			
					jAlert('warning', 'Falta completar Motivo de Ausencia Becado', 'Atenci�n!');  
					return false;	
				}
				
				
				if(document.forms['altaEntrevistaIndividual'].motivoAusenciaRa2.value=="0"){			
					jAlert('warning', 'Falta completar Participaci�n RA', 'Atenci�n!');  
					return false;	
				}
				//var isChecked = document.getElementById('cv').checked;
				//if(isChecked){
				  
				//}else{
				//	jAlert('warning', 'Falta completar Tiene su CV armado ', 'Atenci�n!');  
				//	return false;	
				//}
				//var isChecked = document.getElementById('tma').checked;
				//if(isChecked){
				  
				//}else{
				//	jAlert('warning', 'Falta completar Tiene mail activo? ', 'Atenci�n!');  
				//	return false;		
				//}
				//var isChecked = document.getElementById('usasteFichero').checked;
				//if(isChecked){
				//  
				//}else{
				//	jAlert('warning', 'Falta completar Usaste el fichero? ', 'Atenci�n!');  
				//	return false;		
				//}
				//var isChecked = document.getElementById('brujula').checked;
				//if(isChecked){
				  
				//}else{
				//	jAlert('warning', 'Falta completar Completaste la br�jula? ', 'Atenci�n!');  
				//	return false;		
				//}
				if(document.forms['altaEntrevistaIndividual'].osme.value==""){			
					jAlert('warning', 'Falta completar Observaciones sobre rendimiento escolar y asistencia durante la 2� parte del a�o', 'Atenci�n!');  
					return false;	
				}
				if(document.forms['altaEntrevistaIndividual'].hsTrabajarA�o.value=="0"){			
					jAlert('warning', 'Falta completar Principal habilidad trabajada en la 2� parte del a�o', 'Atenci�n!');  
					return false;	
				}				
				if(document.forms['altaEntrevistaIndividual'].contenidosTrabajarDuranteAnio.value=="0"){			
					jAlert('warning', 'Falta completar Contenidos Abordados', 'Atenci�n!');  
					return false;	
				}
				if(document.forms['altaEntrevistaIndividual'].qtam.value==""){			
					jAlert('warning', 'Falta completar Qu� trabajaste en el acompa�amiento en esta 2� parte del a�o', 'Atenci�n!');  
					return false;	
				}
				if(document.forms['altaEntrevistaIndividual'].propositoAnual.value==""){			
					jAlert('warning', 'Falta completar Seguimiento del prop�sito anual ', 'Atenci�n!');  
					return false;	
				}
				if(document.forms['altaEntrevistaIndividual'].materiasRendirDiciembre.value==""){			
					jAlert('warning', 'Falta completar Materias/fechas a rendir en diciembre ', 'Atenci�n!');  
					return false;	
				}
				if(document.forms['altaEntrevistaIndividual'].materiasRendirFebMarzo.value==""){			
					jAlert('warning', 'Falta completar Materias/fechas a rendir en febrero/marzo ', 'Atenci�n!');  
					return false;	
				}
				if(document.forms['altaEntrevistaIndividual'].motivoInasistenciaR.value=="0"){			
					jAlert('warning', 'Falta completar Principal motivo de inasistencias ', 'Atenci�n!');  
					return false;	
				}
				if(document.forms['altaEntrevistaIndividual'].ecabp.value=="0"){			
					jAlert('warning', 'Falta completar Valoraci�n compromiso AB con el Progama ', 'Atenci�n!');  
					return false;	
				}
				if(document.forms['altaEntrevistaIndividual'].vcrae.value=="0"){			
					jAlert('warning', 'Falta completar Valoraci�n compromiso RA con el Progama ', 'Atenci�n!');  
					return false;	
				}
				if(document.forms['altaEntrevistaIndividual'].vcrae.value=="0"){			
					jAlert('warning', 'Falta completar Valoraci�n compromiso RA con el Progama ', 'Atenci�n!');  
					return false;	
				}
				if(document.forms['altaEntrevistaIndividual'].sarpepe.value=="0"){			
					jAlert('warning', 'Falta completar Proyecci�n post-escolar del AB ', 'Atenci�n!');  
					return false;	
				}
				if(document.forms['altaEntrevistaIndividual'].te.value=="0"){			
					jAlert('warning', 'Falta completar En caso que quiera estudiar, qu� estudios quiere hacer? ', 'Atenci�n!');  
					return false;	
				}								
				if(document.forms['altaEntrevistaIndividual'].dirMail.value==""){			
					jAlert('warning', 'Falta completar Direcci�n de mail ', 'Atenci�n!');  
					return false;	
				}
				if(document.forms['altaEntrevistaIndividual'].celular.value==""){			
					jAlert('warning', 'Falta completar Celular ', 'Atenci�n!');  
					return false;	
				}
				if(document.forms['altaEntrevistaIndividual'].corroboradoBoletin.value=="0"){			
					jAlert('warning', 'Falta completar Fue corroboardo con bolet�n? ', 'Atenci�n!');  
					return false;	
				}
				else{
					//alert(6);
					//if (document.forms['altaEntrevistaIndividual'].FechaEntrevFebMarzo.value != "" && 
					//		!esMayor(document.forms['altaEntrevistaIndividual'].FechaEntrevFebMarzo.value, document.forms['altaEntrevistaIndividual'].fechaActual.value)){
					//	document.forms['altaEntrevistaIndividual'].FechaEntrevFebMarzo.focus();
					//	alert(7);
					//	jAlert('warning', '"Fecha Entrevista febrero/marzo" debe ser mayor a la fecha actual', 'Atenci�n!');					
					//}
					//else{
						//alert(8);
						$.blockUI();
						//alert(9);
						$('#altaEntrevistaIndividual').submit();
					//}
				}
			}
			else{
				//alert(10);
				$.blockUI();
				//alert(11);
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
<div id="main-content">
<form:form id="altaEntrevistaIndividual" commandName="entrevista" modelAttribute="entrevista" class="cmxform" method="post" action="guardarFinal.do?alumnoId=${alumno.id}&EA=${ea}">
<form:hidden path="id"/>
<form:hidden path="fechaCarga"/>
<form:hidden path="periodoDePago"/>
<h1 id="titulo-informe">Espacio de acompa�amiento Final - ${entrevista.estadoEntrevista.valor}</h1>
<table id="table-informe">
	<tr >
		<td colspan="2"><h1 id="subtitulo-informe" align="center">${alumno.datosPersonales.nombre}&nbsp;${alumno.datosPersonales.apellido}</h1></td>
	</tr>
</table>
<input type="hidden" name="valorGuardar" />
<input type="hidden" name="valorPerfil" />
<br>
    
<div id="accordion"  style="width:90%" >
	<h3  class="ui-accordion-header  ui-state-default ui-corner-all"  align="left" ><a href="#" onclick="mostrar(1)" >Datos generales</a></h3>
	<div id="datosEntrevista1"  style=" height:300px; ;overflow:scroll;"> 
		<jsp:include page="/WEB-INF/pages/entrevistas/finalTab1.jsp" />		  	
	</div>
	
	<h3  class="ui-accordion-header  ui-state-default ui-corner-all"  align="left" ><a href="#" onclick="mostrar(2)" >Datos escolares</a></h3>
	<div id="datosEntrevista2"  style=" height:400px; ;overflow:scroll;">  	
		<jsp:include page="/WEB-INF/pages/entrevistas/finalTab2.jsp" />		  	
	</div>
	
	<h3  class="ui-accordion-header  ui-state-default ui-corner-all"  align="left" ><a href="#" onclick="mostrar(3)" >Acompa�amiento</a></h3>
	<div id="datosEntrevista3"  style=" height:1100px; ;overflow:scroll;">  	
		<jsp:include page="/WEB-INF/pages/entrevistas/finalTab3.jsp" />		  	
	</div>
</div>

<br>
	<table align="left" id="table-botons-small" width="96%">
		<tr>
			<td  width="50">
				<center>
					<input type="button"   value="En construcci�n" class="ui-state-default ui-corner-all"	onclick="guardar('c','${tipoPerfil}');" />
				</center>
			</td>
			<td  width="50">
				<center>
					<c:if test="${tipoPerfil == 'rr'}">
						<input type="button" value="Aprobar" class="ui-state-default ui-corner-all" onclick="guardarAprobar('f','${tipoPerfil}');" />
					</c:if>
					<c:if test="${tipoPerfil == 'ea'}">
						<input type="button" value="Finalizar" class="ui-state-default ui-corner-all" onclick="guardarAprobar('f','${tipoPerfil}');" />
					</c:if>
					<c:if test="${tipoPerfil == 'superUsuario'}">
						<input type="button" value="A Supervisi�n" class="ui-state-default ui-corner-all" onclick="guardar('f','${tipoPerfil}');" />
					</c:if>
				</center>
			</td>
			<td  width="50">
				<center>
					<c:if test="${tipoPerfil == 'superUsuario'}">
						<input type="button" value="Aprobar" class="ui-state-default ui-corner-all" onclick="guardarAprobar('s','${tipoPerfil}');" />
					</c:if>
				</center>
			</td>	
			<td  width="50">
				<center>
					<c:if test="${tipoPerfil == 'rr'}">
						<input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../entrevistas/listaEntrevistasAprobar.do'; return false;" />
					</c:if>
					<c:if test="${tipoPerfil == 'ea'}">
						<input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../entrevistas/listarBecados.do'; return false;" />
					</c:if>	
					<c:if test="${tipoPerfil == 'superUsuario'}">
							<input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../exportacionEntrevistas/verExportarEntrevistas.do'; return false;" />
					</c:if>	
				</center>			
			</td>
			<td width="292" height="30" align="center" valign="middle">&nbsp;</td>
		</tr>
	</table>

<input id="idEA" type="hidden" value="${idEA}"/>
<input id="fechaActual" type="hidden" value="${fechaActual}">
<input id="ultimoAnio" type="hidden" value="${ultimoAnio}">

</form:form>
</div>
</body>
</html>