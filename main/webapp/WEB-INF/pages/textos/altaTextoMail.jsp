<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="mif" uri="/list-operator.tld" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Alta Texto de Mail</title>
		<style type="text/css">
			.td{
				text-indent: 30px;
			}			
			.fechas{
				text-indent: 60px;
				text-transform: inherit;
				font-family: cursive;
				font-size: small;
				font-stretch: ultra-condensed;
				color: purple;
				font-weight: bold;
				vertical-align: top;
			}
			.column-right{
				vertical-align: top;
			}
			.title-right{
				text-indent: 20px;
				margin-left: 20px;
				font-weight: bold;
				color: purple;
				font-family: cursive;
				
			}
			.tabla{
				background-image:url('../static/images/papel.jpg');
				color:black;
				font-family:sans-serif;
				align:center; 
				border:0; 
			}
			.ui-dropdownchecklist-text {
				font-size: 11px;
			}
			.errormsg {
				float: none; 
				color: red; 
				padding-left: .5em; 
				vertical-align: top;
			}
			.class1 {
				color:black
			}
		</style>

		<script type="text/javascript" src="<c:url value="/static/js/ui.dropdownchecklist.js"/>"></script>
		<script type="text/javascript"	src="<c:url value="/static/js/funcionesEntrevista.js"/>"></script>
		<script type="text/javascript" src="<c:url  value="/static/js/jquery.blockUI.js"/>"></script>
		<script type="text/javascript" src="<c:url  value="/static/js/jquery.validate.js"/>"></script>
		<script type="text/javascript" src="<c:url  value="/static/js/validador.js"/>"></script>
	
		<script type="text/javascript">
		
			$(document).ready(function(){		
				$("#form").validate({
					errorClass: 'errormsg',
					rules: 
					{			
						tipoInformeId : {
							required:true
						},
						cicloId : {
							required:true
						},
						idMotivoNoRenovacion: {
							required:true
						},
						idMotivoPendiente: {
							required:true
						},
						tipoMailId: {
							required:true
						},
						titulo : {
							required:true
						},
						destinatario : {
							required:true
						},
						cuerpo :{
							required:true
						},
						firma :{
							required:true
						}						
					},
					messages:{			
						tipoInformeId : {
							required:'Este campo es requerido'
						},
						cicloId : {
							required:'Este campo es requerido'
						},
						tipoMailId : {
							required:'Este campo es requerido'
						},
						idMotivoNoRenovacion: {
							required:'Este campo es requerido'
						},
						idMotivoPendiente: {
							required:'Este campo es requerido'
						},
						titulo: {
							required:'Este campo es requerido'
						},
						destinatario : {
							required:'Este campo es requerido'
						},
						cuerpo :{
							required:'Este campo es requerido'
						},
						firma :{
							required:'Este campo es requerido'
						}
					},	
			   		invalidHandler: function(form, validator) {
						var errors = validator.numberOfInvalids();
						if (errors){
							$.unblockUI();
						}
					}
				});		
				
				$("#tipoInformeId").change(function(){
					var misValores = $('#tipoInformeId').val();
					if (misValores == 'Comunicado de NO Renovaci�n'){
					    $("#idMotivoNoRenovacion").removeAttr("disabled");		
					    $("#idMotivoNoRenovacion").addClass("required");
					    
					    $("#idMotivoPendiente").attr("disabled","disabled");
					    $("#idMotivoPendiente").removeClass("required");
					    
					    $("#tipoMailId").attr("disabled","disabled");
					    $("#tipoMailId").val("Individual");
					    
					} else if (misValores == 'Comunicado de Renovaci�n Pendiente'){
					    $("#idMotivoPendiente").removeAttr("disabled");	
					    $("#idMotivoPendiente").addClass("required");
					    
					    $("#idMotivoNoRenovacion").attr("disabled","disabled");
					    $("#idMotivoNoRenovacion").removeClass("required");
					    
					    //$("#tipoMailId").attr("disabled","disabled");	
					    //$("#tipoMailId").val("Individual");
					  				    
					} else{
						 $("#idMotivoNoRenovacion").attr("disabled","disabled");
						 $("#idMotivoNoRenovacion").removeClass("required");
						 
						 $("#idMotivoPendiente").attr("disabled","disabled");
						 $("#idMotivoPendiente").removeClass("required");
						 
						 $("#tipoMailId").removeAttr("disabled");	
					}
				});  
				
			});	
			
  			function disableAndDisabledRenovacion(){
  				if(${idMotivoNoRenovacion != null}){
				    $("#idMotivoNoRenovacion").removeAttr("disabled");		
				    $("#idMotivoNoRenovacion").addClass("required");
				    
				    if(${tipoMailId == 'Individual'}){
				    	 $("#tipoMailId").attr("disabled","disabled");	
				    }
				    else{
				    	 $("#tipoMailId").removeAttr("disabled");	
				    }
 				}
 				else{
				    $("#idMotivoNoRenovacion").attr("disabled","disabled");
				    $("#idMotivoNoRenovacion").removeClass("required");
 				}
  				if(${idMotivoPendiente != null}){
				    $("#idMotivoPendiente").removeAttr("disabled");	
				    $("#idMotivoPendiente").addClass("required");
				    if(${tipoMailId == 'Individual'}){
				    	 $("#tipoMailId").attr("disabled","disabled");	
				    }
				    else{
				    	 $("#tipoMailId").removeAttr("disabled");	
				    }
 				}
 				else{
				    $("#idMotivoPendiente").attr("disabled","disabled");
				    $("#idMotivoPendiente").removeClass("required");
 				} 
 			}  
  			
			function enviarForm(action, id){
				document.forms['form'].accion.value = action;
				variable = document.getElementById('destinatario').value;
				document.forms['form'].desti.value = variable;
				variable1 = document.getElementById('cuerpo').value;
				document.forms['form'].cuer.value = variable1;
				variable2 = document.getElementById('firma').value;
				document.forms['form'].fir.value = variable2;
				variable3 = document.getElementById('titulo').value;
				document.forms['form'].titu.value = variable3;
				if(action == 'alta'){
					document.forms['form'].action = "../textos/altaTextoMail.do";		
					$.blockUI();
					$('#form').submit();
				}	
				if(action == 'modificar'){
					document.forms['form'].idTexto.value = id;
					document.forms['form'].action ="../textos/modificarTextoMail.do";
					$.blockUI();
					$('#form').submit();		
				}
			}
			
			function validarTipoInforme(tipoInforme){
				var idTipoInforme;
				if(tipoInforme == '')
					idTipoInforme = 0;
				else if(tipoInforme == 'Informe de Seguimiento N�1')
					idTipoInforme = 1;
				else if(tipoInforme == 'Informe de Seguimiento N�2')
					idTipoInforme = 2;
				else if(tipoInforme == 'Informe de Seguimiento N�3')
					idTipoInforme = 3;
				else if(tipoInforme == 'Informe de Cesaci�n')
					idTipoInforme = 4;
				else if(tipoInforme == 'Comunicado de NO Renovaci�n')
					idTipoInforme = 5;
				else if(tipoInforme == 'Comunicado de Renovaci�n Pendiente')
					idTipoInforme = 6;
				else if(tipoInforme == 'Ficha de Presentaci�n')
					idTipoInforme = 7;
				return idTipoInforme;
			}
			
			function obtenerMailAnterior(){				
				var ciclo = document.getElementById('cicloId').value;
				var tipoInforme =  validarTipoInforme(document.getElementById('tipoInformeId').value);
				var tipoMail = document.getElementById('tipoMailId').value;
				var motivoPendiente = document.getElementById('idMotivoPendiente').value;
				var motivoNoRenueva = document.getElementById('idMotivoNoRenovacion').value;
				buscarMail = false;
				mensaje = "No se puede visualizar el mail anterior porque no se selecciono el ciclo, tipo de informe y tipo de mail";
				//llamar a ajax y cargar el mail
				if(tipoInforme != 0 && ciclo != '' && tipoMail != ''){						
					if(tipoInforme == 5){
						if(motivoNoRenueva != ''){
							motivoPendiente = '';
							buscarMail = true;
						}
						else{
							mensaje = "No se puede visualizar el mail anterior porque no se selecciono el ciclo, tipo de informe, tipo de mail y motivo de no renovaci�n";
						}							
					}
					else{
						if(tipoInforme == 6){
							if(motivoPendiente != ''){
								motivoNoRenueva = '';
								buscarMail = true;
							}
							else{
								mensaje = "No se puede visualizar el mail anterior porque no se selecciono el ciclo, tipo de informe, tipo de mail y motivo de renovaci�n pendiente";
							}
						}
						else{
							motivoPendiente = '';
							motivoNoRenueva = '';
							buscarMail = true;
						}
					}
				}
				
				if(buscarMail){
					$.ajax({
						url: "../ajax/generarVisualizacionMailAnterior.do",
						data:{
							style: "full",
							cicloId: ciclo,
							tipoInformeId: tipoInforme,
							tipoMailId: tipoMail,
							idMotivoNoRenovacion: motivoNoRenueva,
							idMotivoPendiente: motivoPendiente	
						},
				        success: function(datos){
				        	if(datos.mensaje == ''){
					        	document.getElementById('titulo').value = datos.titulo;
					        	document.getElementById('destinatario').value = datos.destinatario;
					        	document.getElementById('cuerpo').value = datos.cuerpo;
					        	document.getElementById('firma').value = datos.firma; 
				        	}
				        	else{
				        		jAlert('warning', datos.mensaje, 'Atenci�n!');
								return false;
				        	}
				        }	     
					});					
				}
				else{
					jAlert('warning', mensaje, 'Atenci�n!');
					return false;
				}
			}
		</script>
	</head>
	<body onload="disableAndDisabledRenovacion()">
		<div id="main-content">
			<form id="form" class="cmxform" action="" method="post">
				<h1 id="titulo-informe"> ${accion} Texto de Mail</h1>
				<table border="0" align="left" cellpadding="0" cellspacing="0" id="table-informe">				
					<tr>
						<td colspan="3"><h1 id="subtitulo-informe"><label>Ciclo de env�o de mail</label></h1></td>
					</tr>	
					<tr>
						<td colspan="3">	
							<select id="cicloId" name="cicloId" class="class1 required" style="width:150px;">
								<option value="">Seleccione un ciclo</option>	
								<c:forEach var="ciclo" items="${ciclos}">										
									<c:if test="${ciclo.id == cicloId}">
										<option selected="selected" id="ciclo" value="${ciclo.id}">${ciclo.nombre}</option>
									</c:if>
									<c:if test="${ciclo.id != cicloId}">
									<option id="ciclo" value="${ciclo.id}">${ciclo.nombre}</option>
									</c:if>
								</c:forEach>
							</select>
			 			</td>
			 		</tr>
			 		
			 		<tr>
						<td colspan="3"><h1 id="subtitulo-informe"><label>Tipo de Informe</label></h1></td>
					</tr>	
					<tr>
						<td colspan="3">		
							<select id="tipoInformeId" class="class1 required" name="tipoInformeId" style="width:300px; ">	
								<option value="">Seleccione un tipo de informe</option>									
								<c:forEach var="tipo" items="${tiposInforme}">
									<c:if test="${tipo == tipoInformeId}">
										<option selected="selected" id="tipo" value="${tipo}">${tipo}</option>
									</c:if>
									<c:if test="${tipo != tipoInformeId}">
										<option id="tipo" value="${tipo}">${tipo}</option>								
									</c:if>	
								</c:forEach>
			 				</select>								
						</td>
					</tr>
					
	 				<tr>
						<td colspan="3"><h1 id="subtitulo-informe"><label>Motivo de No Renovaci�n</label></h1></td>
					</tr>	
					<tr>
						<td colspan="3">		
							<select id="idMotivoNoRenovacion" class="class1 required" name="idMotivoNoRenovacion" style="width:300px; ">	
								<option value="">Seleccione un motivo de no renovaci�n</option>		
								<c:forEach var="item" items="${motivosNoRenovacion}">
									<c:if test="${idMotivoNoRenovacion == item.id}">
										<option selected="selected" id="item" value="${item.id}">${item.valor}</option>
									</c:if>
									<c:if test="${idMotivoNoRenovacion != item.id}">
										<option id="item" value="${item.id}">${item.valor}</option>
									</c:if>					
								</c:forEach>
			 				</select>	
						</td>
					</tr>
					
					<tr>
						<td colspan="3"><h1 id="subtitulo-informe"><label>Motivo de Renovaci�n Pendiente</label></h1></td>
					</tr>	
					<tr>
						<td colspan="3">		
							<select id="idMotivoPendiente"  class="class1 required" name="idMotivoPendiente" style="width:300px; ">	
								<option value="">Seleccione un motivo de pendiente</option>			
								<c:forEach var="item" items="${motivosPendiente}">
									<c:if test="${idMotivoPendiente == item.id}">
										<option selected="selected" id="item" value="${item.id}">${item.valor}</option>
									</c:if>		
									<c:if test="${idMotivoPendiente != item.id}">
										<option id="item" value="${item.id}">${item.valor}</option>
									</c:if>
								</c:forEach>
			 				</select>								
						</td>
					</tr>
					
					<tr>
						<td colspan="3"><h1 id="subtitulo-informe"><label>Tipo de Mail</label>
							<label style="font-size: small;"> (mail en referencia a 1 becado o a m�s de 1 becado - no aplica para Comunicado)</label></h1></td>
					</tr>	
					<tr>
						<td colspan="3">		
							<select id="tipoMailId" class="class1 required" name="tipoMailId" style="width:300px; ">	
								<option value="">Seleccione un tipo de tipo de mail</option>									
								<c:forEach var="tipoMail" items="${tiposMail}">
									<c:if test="${tipoMail == tipoMailId}">
										<option selected="selected" id="tipoMail" value="${tipoMail}">${tipoMail}</option>
									</c:if>
									<c:if test="${tipoMail != tipoMailId}">
										<option id="tipoMail" value="${tipoMail}">${tipoMail}</option>								
									</c:if>	
								</c:forEach>
			 				</select>								
						</td>
					</tr>								
			 		
			 		<c:if test="${!empty fechaModificacion && !empty fechaCreacion}">
				 		<tr>
							<td colspan="3"><h1 id="subtitulo-informe"><label>Fecha de Creaci�n / Modificaci�n</label></h1></td>
						</tr>					
						<tr>
							<td colspan="2">Fecha de Creaci�n</td>
							<td align="left">
								<input name="fechaCreacion" disabled="disabled" value="<fmt:formatDate value="${fechaCreacion}" pattern="dd/MM/yyyy"/>">	
							</td>
						</tr>				
						<tr>
							<td colspan="2" nowrap="nowrap">Fecha de Modificaci�n:</td>
							<td align="left">
								<input name="fechaModificacion" disabled="disabled" value="<fmt:formatDate value="${fechaModificacion}" pattern="dd/MM/yyyy"/>">	
							</td>
						</tr>							
					</c:if>
					<c:if test="${empty fechaModificacion && !empty fechaCreacion}">
				 		<tr>
							<td colspan="3"><h1 id="subtitulo-informe"><label>Fecha de Creaci�n</label></h1></td>
						</tr>					
						<tr>
							<td colspan="2">Fecha de Creaci�n</td>
							<td align="left">
								<input name="fechaCreacion" disabled="disabled" value="<fmt:formatDate value="${fechaCreacion}" pattern="dd/MM/yyyy"/>">	
							</td>
						</tr>						
					</c:if>
					
					
					<tr>
						<td colspan="3"><h1 id="subtitulo-informe"><label>T�tulo</label>
							<label style="font-size: small;"> (usar s�lo may�sculas sin tildes)</label></h1></td>
					</tr>	
					<c:if test="${accion == 'Alta'}">
						<tr>
							<td colspan="2">
								<textarea cols="60" rows="5"  class="class1 required" name="titulo" 
									onblur="eliminarEnter(this);chequearLongitudTextarea(this,500);" 
									onkeypress="textareaSinEnter(event.keyCode,this);chequearLongitudTextarea(this,500);"
									onkeyup="textareaSinEnter(event.keyCode,this);chequearLongitudTextarea(this,500);">${titulo}</textarea>		
							</td>
							<td>
								<input type="button" value="Obtener mail anterior" class="ui-state-default ui-corner-all" onclick="obtenerMailAnterior()"/>
							</td>
						</tr>		
					</c:if>
					<c:if test="${accion != 'Alta'}">
						<tr>
							<td colspan="3">
								<textarea cols="60" rows="5"  class="class1 required" name="titulo" 
									onblur="eliminarEnter(this);chequearLongitudTextarea(this,500);" 
									onkeypress="textareaSinEnter(event.keyCode,this);chequearLongitudTextarea(this,500);"
									onkeyup="textareaSinEnter(event.keyCode,this);chequearLongitudTextarea(this,500);">${titulo}</textarea>		
							</td>
						</tr>		
					</c:if>
					
					<tr>
						<td colspan="3"><h1 id="subtitulo-informe"><label>Destinatario mail</label></h1></td>
					</tr>	
					<tr>
						<td colspan="3">
							<label>
								Las constantes que podr� agregar a este apartado son: [nombrePadrino] y [apellidoPadrino].
							</label>
						</td>
					</tr>	
					<tr>
						<td colspan="3">
							<textarea cols="60" rows="5"  class="class1 required" name="destinatario" 
								onblur="chequearLongitudTextarea(this,500);" 
								onkeypress="chequearLongitudTextarea(this,500);"
								onkeyup="chequearLongitudTextarea(this,500);">${destinatario}</textarea>					
						</td>
					</tr>					
							
					<tr>
						<td colspan="3"><h1 id="subtitulo-informe"><label>Cuerpo mail</label></h1></td>
					</tr>
					<tr>
						<td colspan="3">
							<label>
								Las constantes que podr� agregar a este apartado son: [nombreBecado], [apellidoBecado], [zonaBeca] y [textoEntrev.Comun.Pent-Otro].
							</label>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<textarea cols="60" rows="5"  class="class1 required" name="cuerpo" 
								onblur="chequearLongitudTextarea(this,10000);" 
								onkeypress="chequearLongitudTextarea(this,10000);"
								onkeyup="chequearLongitudTextarea(this,10000);">${cuerpo}</textarea>					
						</td>
					</tr>					
					
					<tr>
						<td colspan="3"><h1 id="subtitulo-informe"><label>Firma</label></h1></td>
					</tr>
					<tr>
						<td colspan="3">
							<label>
								Las constantes que podr� agregar a este apartado son: [nombreUsuario] y [apellidoUsuario].
							</label>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<textarea cols="60" rows="5"  class="class1 required" name="firma" 
								onblur="chequearLongitudTextarea(this,5000);" 
								onkeypress="chequearLongitudTextarea(this,5000);"
								onkeyup="chequearLongitudTextarea(this,5000);">${firma}</textarea>					
						</td>
					</tr>
				
			     	<tr>
			        	<td>&nbsp;</td>
			    	    <td>&nbsp;</td>
			    	    <td>&nbsp;</td>
			    	</tr>
			    	<tr>
			      	    <td>&nbsp;</td>
			       	    <td>&nbsp;</td>
			       	    <td>&nbsp;</td>
			      	</tr>
			      	<tr>
			     		<td colspan="3">
			     			<table width="800" border="0" align="center" cellpadding="0" cellspacing="0" id="table-botons-small">
			            		<tr>
			            			<c:if test="${accion=='Alta'}">
										<td width="50" height="0" align="center" valign="middle">
											<input class="ui-state-default ui-corner-all " onclick="enviarForm('alta','')" type="button" value="Guardar"/>
							  	  		</td>
							  	  	</c:if>
							  	  	<c:if test="${accion=='Modificaci�n'}">
				             			<td width="50" height="0" align="center" valign="middle">
						  	  				<input class="ui-state-default ui-corner-all " onclick="enviarForm('modificar','${idTexto}')" type="button" value="Guardar" />
						  	  			</td>	 
						  	  		</c:if>		  
									<td width="50" align="center" valign="middle">
								  		<input type="button" value="Volver" class="ui-state-default ui-corner-all" onclick="history.back();"/>
									</td>									
			              			<td width="292" height="30" align="center" valign="middle">&nbsp;</td>
								</tr>
				      		</table> 
				       	</td>
					</tr>
				</table>
				<input type="hidden" name="accion"></input>
				<input type="hidden" name="idTexto" value="${idTexto}"></input>
				<input type="hidden" name="urlRegreso" value="${urlRegreso}"></input>
				<input type="hidden" name="desti"></input>
				<input type="hidden" name="titu"></input>
				<input type="hidden" name="cuer"></input>
				<input type="hidden" name="fir"></input>
			</form>
		</div>
	</body>
</html>