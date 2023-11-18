<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="mif" uri="/list-operator.tld" %>
<%@page import="java.sql.*" %> 
<%@page import="org.cimientos.intranet.web.controller.Conexion"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">	
<html>
	<style type="text/css">
		input[name=search_browser]{	
			font-size: x-small;
			width: 90px;
			color: gray;
			font-style: italic; 
		}
		select[name=search_browser]{	
			font-size: x-small;
			width: 90px;
			color: gray;
			font-style: italic; 
		}		
	</style>
	<link rel="stylesheet" href="<c:url value="/static/css/cimientos/jquery-ui-1.8.5.custom.css"/>" media="all">
	<link rel="stylesheet" href="<c:url value="/static/css/cimientos/jquery-ui-1.8.5.custom.css"/>" media="all">
	<link rel="stylesheet" href="<c:url value="/static/css/displaytags.css"/>" media="all">
	<link rel="stylesheet" href="<c:url value="/static/css/cimientos/ui.dropdownchecklist.themeroller.css"/>" type="text/css">
	<script type="text/javascript" src="<c:url value="/static/js/jquery.effects.core.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/static/js/jquery.ui.position.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/static/js/jquery.ui.widget.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/static/js/jquery.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/static/js/jquery-ui-1.8.5.custom.min.js"/>"></script>	
	<script type="text/javascript" src="<c:url value="/static/js/jquery.quicksearch.js"/>"></script>
	<script src="<c:url value="/static/js/jquery.alerts.js" />" type="text/javascript"></script>
	<script type="text/javascript" src="<c:url value="/static/js/jquery.effects.core.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/static/js/jquery.ui.position.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/static/js/jquery.ui.widget.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/static/js/jquery.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/static/js/jquery-ui-1.8.5.custom.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/static/js/table/jquery.dataTables.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/static/js/ui.dropdownchecklist.js"/>"></script>
	<script type="text/javascript" src="<c:url  value="/static/js/jquery.blockUI.js"/>"></script>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Listado General de Pagos</title>
		<script type="text/javascript">	
			function enviarForm(id){
				if(document.getElementById("estadoNuevoId").value == 'seleccione'){
					jAlert('warning', 'Debe seleccionar el estado para el cual quiere modificar el/los pago/s', 'Atenci�n!');
					return false;
				}
				if(($("input[@name=_chk]:checked").length > 0) || id !=''){
					jConfirm('Esta seguro de que desea modificar el estado del/los pago/s seleccionado/s?', 'Confirmaci�n', function(result){
					    if (result) {
							document.forms['form'].action = '<c:url value="moficarEstadoPago.do"/>';
							if(id !=''){
								document.forms['form'].idPago.value = id;
								document.forms['form']._chk.value = "";
							}	
							
							document.forms['form'].limpiarChks.value = 'true';
							document.forms['form'].page.value = "";							
							document.forms['form'].submit();
					    	$.blockUI();							
					    }
					 	else {
					      return false;
						}
					});	
				}
				else{
					jAlert('warning', 'Debe seleccionar el menos un pago', 'Atenci�n!');
					return false;
					}		
			}
									
		</script>
		
			
		
		
		
		<script type="text/javascript">
			$(document).ready(function() {			  
				$('#buscar').click( function() {
					document.forms['form'].action = '<c:url value="verlistaPagosView.do"/>';
					document.forms['form'].limpiarChks.value = 'true';
					document.forms['form'].page.value = "";
					document.forms['form'].submit();
			   // 	$.blockUI();
				} ); 
			} );

			$(function() {
				$("#zona").autocomplete({
					source: function(request, response) {
						$.ajax({
							url: "../ajax/buscarZonaPorNombre.do",
							dataType: "json",
							data: {
								style: "full",
								maxRows: 12,
								name_startsWith: request.term
							},
							success: function(data) {
								response($.map(data.zonas, function(item) {
									return {
										label: item.nombre,
										value: item.nombre,
										id: item.id,
										zona: item.zona
									}
								}))
							}
						})
					},
					minLength: 2,
					select: function(event, ui) {
						$("#idZona").val(ui.item.id);
						$("#zona").text(ui.item.zona);
					}
				});
			});	
	
			function CheckAll(chk){
				for (i = 0; i < chk.length; i++)
					chk[i].checked = true ;
			}			
			
			function UnCheckAll(chk){
				for (i = 0; i < chk.length; i++)
					chk[i].checked = false ;
			}
		
			$(document).ready(function(){		
				$("#idsPeriodo").dropdownchecklist({icon: {}, width: 150, maxDropHeight: 200, firstItemChecksAll: true});
				$("#idsZona").dropdownchecklist({icon: {}, width: 150, maxDropHeight: 200, firstItemChecksAll: true});
				$("#idsEstadoPago").dropdownchecklist({icon: {}, width: 150, maxDropHeight: 200, firstItemChecksAll: true});
				$("#idsEstadoCuenta").dropdownchecklist({icon: {}, width: 150, maxDropHeight: 200, firstItemChecksAll: true});			  
			});
			
			$(function(){
				$('#idCiclo').change(function(){
					misValores = $('#idCiclo').val();
					if (misValores!=null ){
						//cargar periodos para el ciclo elegido
						$("#idsPeriodo").dropdownchecklist('enable');
						//tomar ciclo elegido
						//llamar a ajax y cargar los periodos
						$.ajax({
							url: "../ajax/obtenerListaPeriodos.do",
							data: "idCiclo="+misValores,
					        success: function(datos){
					        	$('#idsPeriodo').get(0).options.length=0;
					        	$("#idsPeriodo").dropdownchecklist("destroy");

					            $.each(datos, function(val, text) {
				                	$('#idsPeriodo').append( '<option value=0>Todos</option>' );
					            	for (i=0;i<text.length;i++){
					                	$('#idsPeriodo').append( '<option value=' + text[i].id +'>'+ text[i].nombre + '</option>' );
					            	}
					            });

					            $("#idsPeriodo").dropdownchecklist({icon: {}, width: 150, maxDropHeight: 200, firstItemChecksAll: true});
					        }
						});
					} else {
						//deshabilitar combo periodos
						$("#idsPeriodo").dropdownchecklist('disable');
					    $("#idsPeriodo option:selected").attr('disabled','disabled')
					}
					
				});
			});
		</script>	
	<script>
	$(function() {
	    $( "#fechaExportacion" ).datepicker();
	  });
	
	
	</script>
	<script>	
		function historialPago(id) { 			
			//alert(id);
			//url = "../empresa/altaEmpresaView.do?popup=true&cuit="+document.getElementById("cuit_cuil").value;
			url = "../becadosPorEa/historialPago.jsp?id="+id;
			//alert(url);
			window.open("../becadosPorEa/historialPago.jsp?id="+id, '_blank','width=800, height=630 ,scrollbars=YES');
			
			
			//$("#pagoSeleccionado" ).val(id);
			//$("#dialog").dialog({ width: 800 }); 
		};
	
	</script>



	</head> 
	<body>
		<div id="main-content">
			<br><br>
			<center><h3>Listado General de Pagos</h3></center>
			<br><br>
			<form method="post" id="form" name="form" action='<c:url value="/pago/verlistaPagosView.do"/>'>
				<center>
				<fieldset style="font-size: 12px; margin-left: 0px; margin-right: 0px; width:980px;">
					<table id="table-informe" align="center" style="margin-left: 0px; margin-right: 10px; border-style:hidden;" width="900px">
						<tr align="center">
							<!-- Banco -->
							<td class="inicio" align="left" style="font-size: 13px; font-weight: bold">Banco:</td>
							<td align="left">
								<select id="banco" name="idBanco" class="required"> 
									<option value="0">Todos</option>
									<c:forEach var="banco" items="${bancos}">
										<c:if test="${banco.id == idBanco}">
											<option selected="selected" id="banco" value="${banco.id}">${banco.nombre}</option>
										</c:if>
										<c:if test="${banco.id != idBanco}">
											<option id="banco" value="${banco.id}">${banco.nombre}</option>
										</c:if>
									</c:forEach>
								</select>
							</td>					
					  		<!--  Becado  -->
							<td align="left" style="font-size: 13px; font-weight: bold">Becado:</td>
							<td align="left">
								<input type="text" value="${becado}" name="becado" id="becado" maxlength="30" size="21">
							</td>
						</tr>
						<tr align="center">
							<!--  RA -->
							<td align="left" style="font-size: 13px; font-weight: bold">RA:</td>
							<td align="left">
								<input type="text" value="${ra}" id="ra" name="ra" size="21" maxlength="30">
							</td>
							<!-- Zona -->
							<td align="left" style="font-size: 13px; font-weight: bold">Zona:</td>
							<td align="left">
								<select id="idsZona" name="idsZona" multiple="multiple" style="width:150px; ">
									<c:choose>
										<c:when test="${mif:contieneLong(idsZona, 0)}">
											<option selected="selected" id="zona" value="0">Todos</option>
										</c:when>
										<c:otherwise>
											<option id="zona" value="0">Todos</option>
										</c:otherwise>	
									</c:choose>	
									<c:forEach var="item" items="${zonas}">
										<c:choose>
											<c:when test="${mif:contieneLong(idsZona, item.id)}">
												<option selected="selected" id="item" value="${item.id}">${item.nombre}</option>
											</c:when>
											<c:otherwise>
												<option id="zona" value="${item.id}">${item.nombre}</option>
											</c:otherwise>	
										</c:choose>	
									</c:forEach>
								</select>								
							</td>
						</tr>
						<tr align="center">
							<!-- Estado Cta. -->
							<td align="left" style="font-size: 13px; font-weight: bold">Estado Cuenta:</td>
							<td align="left" >
								<select id="idsEstadoCuenta" name="idsEstadoCuenta" multiple="multiple" style="width:150px;">
									<c:choose>
										<c:when test="${mif:contieneInt(idsEstadoCuenta, 0)}">
											<option selected="selected" id="item" value="0">Todos</option>
										</c:when>
										<c:otherwise>
											<option id="item" value="0">Todos</option>
										</c:otherwise>
									</c:choose>
									<c:forEach var="item" items="${estadoCuentas}">
										<c:choose>
											<c:when test="${mif:contieneInt(idsEstadoCuenta, item.id)}">
												<option selected="selected" id="item" value="${item.id}">${item.valor}</option>
											</c:when>
											<c:otherwise>
												<option id="item" value="${item.id}">${item.valor}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
							</td>
							<!-- Estado Pago -->
							<td align="left" style="font-size: 13px; font-weight: bold">Estado Pago:</td>
							<td align="left">
								<select id="idsEstadoPago" name="idsEstadoPago" multiple="multiple" style="width:150px;">
								<c:choose>
										<c:when test="${mif:contieneInt(idsEstadoPago, 0)}">
											<option selected="selected" id="item" value="0">Todos</option>
										</c:when>
										<c:otherwise>
											<option id="item" value="0">Todos</option>
										</c:otherwise>
									</c:choose>
									<c:forEach var="item" items="${estadoPagos}">
										<c:choose>
											<c:when test="${mif:contieneInt(idsEstadoPago, item.id)}">
												<option selected="selected" id="item" value="${item.id}">${item.valor}</option>
											</c:when>
											<c:otherwise>
												<option id="item" value="${item.id}">${item.valor}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>									
								</select>	
							</td>
						</tr>						
						<tr>
							<!-- Ciclo -->
							<td align="left" style="font-size: 13px; font-weight: bold">Ciclo:</td>
							<td align="left">
								<select id="idCiclo" name="idCiclo" style="width:150px;">
									<c:forEach var="ciclo" items="${ciclos}">
										<c:if test="${ciclo.id == idCiclo}">
											<option selected="selected" id="ciclo" value="${ciclo.id}">${ciclo.nombre}</option>
										</c:if>
										<c:if test="${ciclo.id != idCiclo}">
											<option id="ciclo" value="${ciclo.id}">${ciclo.nombre}</option>
										</c:if>
									</c:forEach>
				 				</select>
							</td>
							<!-- Periodo -->
							<td align="left" style="font-size: 13px; font-weight: bold">Periodo:</td>
							<td align="left">
								<select id="idsPeriodo" name="idsPeriodo" multiple="multiple" style="width:150px;">
									<c:choose>
									<c:when test="${mif:contieneLong(idsPeriodo, 0)}">
										<option selected="selected" id="item" value="0">Todos</option>
									</c:when>
									<c:otherwise>
										<option id="item" value="0">Todos</option>
									</c:otherwise>
									</c:choose>
				
									<c:forEach var="item" items="${periodos}">
										<c:choose>
										<c:when test="${mif:contieneLong(idsPeriodo, item.id)}">
											<option selected="selected" id="item" value="${item.id}">${item.nombre}</option>
										</c:when>
										<c:otherwise>
											<option id="item" value="${item.id}">${item.nombre}</option>
										</c:otherwise>
										</c:choose>
									</c:forEach>
				 				</select>
							</td>
						</tr>
						<tr>
							<!-- Total -->
							<td align="left" style="font-size: 13px; font-weight: bold">Monto total:</td>
							<td align="left" >
								<input type="text" value="${totalFiltro}" id="totalFiltro" name="totalFiltro" size="21" readonly="readonly">
							</td>			
							<td align="left" style="font-size: 13px; font-weight: bold">Fecha de exportaci�n:</td>
							<td align="left">
								<input type="text" value="31/05/2016" id="fechaExportacion" name="fechaExportacion" size="21">
							</td>
						</tr>
						
						<tr align="center">
							<td colspan="4">
									<input align="middle" id="buscar" type="submit" value="Buscar" class="ui-state-default ui-corner-all" ></input>
							</td>
						</tr>
					</table>
				</fieldset>
				</center>
				<br><br>
				<!-- fin - filtros -->	
				<fieldset style="font-size: 12px; margin-left: 60px; margin-right: 50px; width:980px;">
					<table id="table-ciclo" align="center" style="margin-left: 100px; margin-right: 60px; border-style:hidden;" width="1000px">		
						<tr >
							<td align="left" style="font-size: 13px; font-weight: bold">Seleccione el estado para el cual se modificar�n los pagos:</td>
							<td align="left">
								 <select id="estadoNuevoId" name="estadoNuevoId" class="required" style="width:150px;">
									<option id="estadoNuevo" value="seleccione">Seleccione</option>
									<c:forEach var="estado" items="${estadoPagos}">
										<option id="estado" value="${estado.id}">${estado.valor}</option>
									</c:forEach>
								</select>
							</td>
							<td>Motivo cambio de estado:<input type="text" id="detalleCambioEstado"name="detalleCambioEstado" style="width: 300px;" value=""></td>
						</tr>
					</table>
				</fieldset>
				<center style="width: 1210px;">
				<display:table name="reportePagos" form="form" class="displayTags_wrapper"  export="true" 
						decorator="org.cimientos.intranet.utils.paginacion.ModificarPagosCheckboxDecorator" sort="external"
						excludedParams="_chk idsZona idsPeriodo idCiclo zona idsEstadoPago estadoNuevoId idsEstadoCuenta idPago idPagos ra becado idBanco page mostrarTotal limpiarChks totalPagos sort dir"      					
      					style="font-size: 12px; margin-left: 50px; margin-right: 50px;width:1100px; background-color: #C0C2FF;" 
      					uid="pagos" id="reportePagos" pagesize='50' defaultsort="1" defaultorder="ascending" requestURI="">  
					<!-- display:table class="displayTags_wrapper" export="true" style="font-size: 12px; margin-left: 50px; margin-right: 50px;" uid="pagos" id="pagosList" name="sessionScope.pagosList" pagesize='50' defaultsort="1" defaultorder="ascending" requestURI=""-->  
					    <display:column media="html" title="Selecci�n" style="width: 4%"  property="checkbox"/>
						<display:column property="responsable.sucursalBanco.banco.nombre" sortProperty="responsable.sucursalBanco.banco.nombre" sortable="true" style="width: 5%" headerClass="sortable" title="Banco"  />  
					    <display:column property="zona" sortProperty="becado.escuela.localidad.zona.nombre" sortable="true" style="width: 8%" headerClass="sortable" title="Zona" />
					    <display:column property="becadoCompleto" sortProperty="becado.datosPersonales.apellido" sortable="true" style="width: 15%" headerClass="sorted" title="Becado" />  
					    <display:column property="nombreRa" sortProperty="responsable.apellido" sortable="true" style="width: 15%" headerClass="sortable" title="RA"  />  
					    <display:column property="responsable.cuilCuit" sortProperty="responsable.cuilCuit" sortable="true" style="width: 8%" headerClass="sortable" title="CUIT"  />  
					    <display:column property="responsable.nroCuenta" sortProperty="responsable.nroCuenta" sortable="true" style="width: 8%" headerClass="sortable" title="Nro Cta."  />
					    <display:column property="periodo.nombre" style="width: 8%" headerClass="sortable" title="Periodo"  />
					    <display:column property="estadoPago.valor" style="width: 5%" headerClass="sortable" title="Estado de Pago" maxLength="30" />
						<display:column property="fechaString" sortProperty="fechaExportacion" sortable="true" style="width: 7%" headerClass="sortable" title="Fecha de exportaci�n" maxLength="35" />
					    <display:column property="estadoCuenta" style="width: 7%" headerClass="sortable" title="Estado de Cuenta" maxLength="30" />
					    <display:column property="montoMasExtra" style="width: 5%" headerClass="sortable" title="Monto Total"/>
					 	<display:column property="motivo" style="width: 12%" headerClass="sortable" title="Motivo Fallido" maxLength="35" />
					 	<display:column title="Acciones" media="html">
							<table>
								<tr>
									<td>
										<!-- div  style= width:0.5cm class="ui-state-default ui-corner-all" > 
											<a  onclick="enviarForm('${reportePagos.id}')" title="Modificar estado"> 
											<span class="ui-icon ui-icon-copy" > 
											</span></a>				
										</div-->
									</td>
								</tr>
							</table>	
						</display:column>
						<display:column title="Historial Pago" media="html">
							<table>
								<tr>
									<td>
										<div  style= width:0.5cm class="ui-state-default ui-corner-all" > 
											<a  onclick="historialPago('${reportePagos.id}')" title="Historial Pago"> 
											<span class="ui-icon ui-icon-copy" > 
											</span></a>				
										</div>
									</td>
								</tr>
							</table>	
						</display:column>
					 	
					    <display:setProperty name="basic.empty.showtable" value="true" />  
					    <display:setProperty name="paging.banner.group_size" value="35" />  
					    <display:setProperty name="paging.banner.item_name" value="pago" />  
					    <display:setProperty name="paging.banner.items_names" value="pagos" />  
					    <display:setProperty name="paging.banner.onepage" value="Lista de Pagos" />
					    <display:setProperty name="export.excel.filename" value="ReportePagos.xls" />
					</display:table>
				</center>
				<input name="page" type="hidden" value="${page}"/>
				<input name="sort" type="hidden" value="${sort}"/>
				<input name="dir" type="hidden" value="${dir}"/>
				<br></br>
				<input type="hidden" name="idPago" />
				<table align="center" width="150px" >
					<tr>
						<td>
							<input type="button" id="botonSelecTodos" name="Check_All" class="ui-state-default ui-corner-all" value="Seleccionar todos" onClick="CheckAll(document.form._chk)">
						</td>
						<td>
							<input type="button" id="botonDeselecTodos" name="Un_CheckAll" class="ui-state-default ui-corner-all" value="Deseleccionar todos" onClick="UnCheckAll(document.form._chk)">
						</td>
						<td>
							<input type="button" id="modificarEstado" class="ui-state-default ui-corner-all" value="Modificar estado" onclick="enviarForm('')"/>
						</td>
					</tr>
				</table>
					<input value="false" type="hidden" id="mostrarTotal" name="mostrarTotal">
					<input value="false" type="hidden" id="limpiarChks" name="limpiarChks">
			</form>
		</div>	
		<center>	
			<div style="display: none;" id="fallido-form" title="Notificar Pago Fallido">
				<form id="fallidoForm" name="fallidoForm" class="cmxform" action="<c:url value='/pago/notificarFallido.do' />" method="post">
					<input type="hidden" name="idBecado" id="idBecado" >
					<input type="hidden" name="fechaExportacion" id="fechaExportacion">
					<div id="left-content">
		   				<table border="0" align="left" cellpadding="0" cellspacing="0">
							<tr>
						        <td width="20%" valign="top">Motivo:</td>
						        <td width="80%">
									<textarea rows="10" cols="40" name="motivo"></textarea> 
								</td>
			   				</tr>
		 				</table>      
					</div>	
				</form>
			</div>
			<div id="dialog" title="Historial de Pago" style="width: 800px;">
			
		<input type="text" id="pagoSeleccionado" name="pagoSeleccionado">
	</body>
	
</html>