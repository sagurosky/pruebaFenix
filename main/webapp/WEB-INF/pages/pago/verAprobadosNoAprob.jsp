<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@taglib prefix="display" uri="http://displaytag.sf.net"%>
	<%@taglib prefix="mif" uri="/list-operator.tld" %>
	<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
<script type="text/javascript" src="<c:url value="/static/js/jquery.effects.core.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/jquery.ui.position.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/jquery.ui.widget.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/jquery.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/validador.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/jquery-ui-1.8.5.custom.min.js"/>"></script>
<script type="text/javascript" src="<c:url  value="/static/js/jquery.blockUI.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/jquery.quicksearch.js"/>"></script>
<script src="<c:url value="/static/js/jquery.alerts.js" />" type="text/javascript" ></script>
<script type="text/javascript" src="<c:url value="/static/js/table/jquery.dataTables.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/ui.dropdownchecklist.js"/>"></script>

 
<link rel="stylesheet" href="<c:url value="/static/css/cimientos/jquery-ui-1.8.5.custom.css"/>" media="all">
<link rel="stylesheet" href="<c:url value="/static/css/displaytags.css"/>" media="all">

<script type="text/javascript" src="<c:url value="/static/js/ui.dropdownchecklist.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/static/css/cimientos/ui.dropdownchecklist.themeroller.css"/>" type="text/css">
<script type="text/javascript" src="<c:url  value="/static/js/jquery.blockUI.js"/>"></script>
	
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Estado de Pago de Becados</title>
<script type="text/javascript">

function reloadInputs(){
	if(document.getElementById("zona").value == ""){
 		document.getElementById("ra").value = "";
		//document.getElementById("idZona").value = "";
	}
}


$(document).ready(function() {
	$('#verTotalButton').click( function() {
			document.forms['form'].action = "../pago/verAprobadosNoAprobView.do";
			document.forms['form'].mostrarTotal.value = 'true';
			document.forms['form'].submit();
	} );
	
	$('#botonGenerar').click( function() {
		//Hay que ver si se selecciono algun pago en alguna pagina o en la pagina actual
		if (document.forms['form'].pagaXGalicia.checked) {
			
			if(document.forms['form'].fd.value.length != 8 || document.forms['form'].fp.value.length !=8){
				alert("Verific� las fechas");
				return false;
			}
		}
		
		
		if(($("input[name=_chk]:checked").length > 0)){
			generarExcel();
		}else{
			jConfirm('Se exportaran todos los pagos filtrados. Desea Continuar? Recuerde que esta acci�n puede tardar varios minutos', 'Confirmaci�n', function(result){
			    if (result) {
			    	generarExcel();
			    } else {
			      return false;
			    }
			});
		}
	} );

	function generarExcel(){
		document.forms['form'].action = '<c:url value="generarArchivoPagos.do"/>';
		$('#form').submit();
		document.forms['form'].action = '<c:url value="verAprobadosNoAprobView.do"/>';
		document.forms['form'].limpiarChks.value = 'true';
	}

	$("#banco").change(function(evt) {
			var idBanco = $("#banco").val();
			if(idBanco == 0){
				$("#botonGenerar").attr('disabled',true);
				$("#estadoCuenta").val(0);
				$("#estadoCuenta").attr('disabled',false);
			}else{
				$("#botonGenerar").attr('disabled',false);
				$("#estadoCuenta").val(1);
				$("#estadoCuenta").attr('disabled',true);
			}	
			document.forms['form'].action = '<c:url value="verAprobadosNoAprobView.do"/>';
			document.forms['form'].limpiarChks.value = 'true';
			document.forms['form'].page.value = "";
			document.forms['form'].totalPagos.value = 0;
			document.forms['form'].submit();
			  })
			  
	$('#buscar').click( function() {
		document.forms['form'].action = '<c:url value="verAprobadosNoAprobView.do"/>';
		document.forms['form'].limpiarChks.value = 'true';
		document.forms['form'].page.value = "";
		document.forms['form'].totalPagos.value = 0;
		document.forms['form'].submit();
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
	
	
	function CheckAll(chk)
	{
	for (i = 0; i < chk.length; i++)
	chk[i].checked = true ;
	}
	
	function UnCheckAll(chk)
	{
	for (i = 0; i < chk.length; i++)
	chk[i].checked = false ;
	}

	$(document).ready(function(){
		var idBanco = $("#banco").val();
		if(idBanco == 0){
			$("#botonGenerar").attr('disabled',true);
			$("#estadoCuenta").attr('disabled',false);
		}else{
			$("#botonGenerar").attr('disabled',false);
			$("#estadoCuenta").val(1);
			$("#estadoCuenta").attr('disabled',true);
		}	

		$("#idsPeriodo").dropdownchecklist({icon: {}, width: 150, maxDropHeight: 200, firstItemChecksAll: true});
		$("#idsZona").dropdownchecklist({icon: {}, width: 150, maxDropHeight: 200, firstItemChecksAll: true});
		
		$("#idsEstadoCuenta").dropdownchecklist({icon: {}, width: 150, maxDropHeight: 200, firstItemChecksAll: true});

		if ($("#banco").val()!=null && $("#banco").val()!="0"){
	    	$("#idsEstadoCuenta").dropdownchecklist('disable');
	        $("#idsEstadoCuenta option:selected").attr('disabled','disabled');
		}

	});
	
	function enviarForm(){
		if(document.forms['extraForm'].input_extra.value > 0){
			document.forms['extraForm'].submit();
    		$.blockUI();
		}
		else{
		//	$("#extraForm").dialog("close");
			jAlert('warning', 'Debe ingresar un monto antes de guardar los cambios', 'Atenci�n!');
		}
	};
	
	
	function showFallidoDialog(idBecado, idsPeriodo, cantidadPeriodos){
		document.forms['extraForm'].idBecado.value = idBecado;
		document.forms['extraForm'].idsPeriodo.value = idsPeriodo;
		document.forms['extraForm'].cantidadPeriodos.value = cantidadPeriodos;		
		if(cantidadPeriodos == '1'){
			$("#extraForm").dialog({
				title: "Agregar monto extra",
				resizable: false,
				width: 450,
				height:280,
				modal: true,
				buttons: {
					"Agregar monto extra": function() {
						$(this).dialog("close");
						enviarForm();
					},
					"Cancelar": function() {
						$(this).dialog("close");
					}
				}
			});
		}
		else{
			jAlert('warning', 'Para poder agregar un monto extra, aseg�rese de seleccionar un per�odo determinado', 'Atenci�n!');
			return false;
		}
	}
	function habilitarFechas(){		
		var x = document.getElementById("pagaXGalicia").checked;
		
		if (document.forms['form'].banco.value==2 || document.forms['form'].banco.value==4 || document.forms['form'].banco.value==6 || document.forms['form'].banco.value==7 || document.forms['form'].banco.value==8 || document.forms['form'].banco.value==9 || document.forms['form'].banco.value==11 || document.forms['form'].banco.value==13 || document.forms['form'].banco.value==3 || document.forms['form'].banco.value==17){
			
			if (x==true) {
				$("#fd").removeAttr('disabled');
				$("#fp").removeAttr('disabled');
				
				
			}	
			else{
				
				document.forms['form'].pagaXGalicia.checked=false;
				$("#fd").attr('disabled','disabled');
				$("#fp").attr('disabled','disabled');
			
			}	
		}else{
			
			document.forms['form'].pagaXGalicia.checked=false;
			
		}
		
		
	}
	
</script>
</head>
 
<body>
<div id="main-content">
<br><br>
<center><h3>Pagos Pendientes</h3></center>
<br><br>
<form method="post" id="form" name="form" action='<c:url value="verAprobadosNoAprobView.do"/>'>

<CENTER>

<table style="margin-left: 50px; margin-right: 50px;" width="900px">
<tr >
<td >
<div id="">
<fieldset style="font-size: 12px; margin-left: 50px; margin-right: 50px; width:980px;">
<table id="table-informe" align="center" style="margin-left: 100px; margin-right: 60px; border-style:hidden;" width="600px">
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
		
			<!-- Estado Cta. -->
			<td align="left" style="font-size: 13px; font-weight: bold">Estado Cuenta:</td>
			<td align="left">
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
		</tr>

		<tr align="center">
		<!-- Zona -->
			<td align="left" style="font-size: 13px; font-weight: bold">Zona:</td>
			<td align="left" >
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
		<!-- Total -->
			<td align="left" style="font-size: 13px; font-weight: bold">Monto total:</td>
			<td align="left" >
				<input type="text" value="${totalFiltro}" id="totalFiltro" name="totalFiltro" size="21" readonly="readonly">
			</td>			
		</tr>
		<tr>
			<!-- Periodo -->
			<td align="left" style="font-size: 13px; font-weight: bold">Periodo:</td>
			<td>

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
			<td align="left" style="font-size: 13px; font-weight: bold">
				Paga por Galicia<input type="checkbox" name="pagaXGalicia" name="pagaXGalicia" onclick="habilitarFechas()">
			</td>
		</tr>
		<tr>			
			<td align="left" style="font-size: 13px; font-weight: bold">Fecha Disponibilidad (AAAAMMDD):</td>
			<td>
				<input type="text" name="fd" id="fd" maxlength="8" disabled="disabled">
			</td>
			<td align="left" style="font-size: 13px; font-weight: bold">Fecha Proceso (AAAAMMDD):</td>
			<td>
				<input type="text" name="fp" id="fp" maxlength="8" disabled="disabled">
			</td>
		</tr>
		<tr align="center">
			<td colspan="4">
				<input align="middle" id="buscar" type="button" value="Buscar" class="ui-state-default ui-corner-all" ></input>
			</td>
		</tr>
	</table>
	</fieldset>
<br><br>

<CENTER>
<display:table name="sessionScope.pagosList"   form="form" decorator="org.cimientos.intranet.utils.paginacion.PagosCheckboxDecorator" sort="external"
      excludedParams="_chk idsZona idsPeriodo zona idsEstadoCuenta ra becado idBanco page mostrarTotal limpiarChks totalPagos sort dir" 
      class="displayTags_wrapper"  export="true" 
      style="font-size: 12px; margin-left: 50px; margin-right: 50px;width:1000px; background-color: #C0C2FF;" 
      uid="pagos" id="pagosList" pagesize='50' defaultsort="1" defaultorder="ascending" 
      requestURI="/pago/verAprobadosNoAprobView.do">  
    <display:column media="html" title="Seleccion" style="width: 4%"  property="checkbox" />
    <display:column property="becadoId" style="width: 15%" title="Id Becado"  />
    <display:column property="becadoCompleto" sortProperty="becado.datosPersonales.apellido" sortable="true" style="width: 15%" headerClass="sorted" title="Becado"  />      
    <display:column property="nombreRa" sortProperty="responsable.apellido" sortable="true" style="width: 15%" headerClass="sortable" title="RA"  />  
    <display:column sortable="true" style="width: 15%" headerClass="sortable" title="RR">
    	${pagosList.becado.ea.rr.datosPersonales.apellido}, ${pagosList.becado.ea.rr.datosPersonales.nombre}</display:column>
    <display:column sortable="true" style="width: 15%" headerClass="sortable" title="EA">
    	${pagosList.becado.ea.datosPersonales.apellido}, ${pagosList.becado.ea.datosPersonales.nombre}</display:column>
    <display:column property="responsable.cuilCuit" sortProperty="responsable.cuilCuit" sortable="true" style="width: 8%" headerClass="sortable" title="CUIT"  />  
    <display:column property="banco" style="width: 15%" title="Banco"  />    
    <display:column property="responsable.celular" style="width: 15%" title="CBU"  />
    <!-- display:column property="responsable.nroCuenta" style="width: 15%" title="Nro de Cuenta"  /-->
    <display:column property="estadoCuenta" style="width: 8%" headerClass="sortable" title="Estado Cta"  />
    <display:column property="periodosConcatenados" style="width: 15%" headerClass="sortable" title="Periodos"  />
    <display:column property="zona" sortProperty="becado.escuela.localidad.zona.nombre" sortable="true" style="width: 8%" headerClass="sortable" title="Zona" />
    <display:column property="montoTotal" style="width: 6%" headerClass="sorted" title="Monto Total"  format="{0,number,###.00}" />
	<display:column property="agregarMontoExtra" media="html" headerClass="sortable" style="width: 5%" title="Agregar monto extra" maxLength="15" /> 
	 
    <display:setProperty name="basic.empty.showtable" value="true" />  
    <display:setProperty name="paging.banner.group_size" value="35" />  
    <display:setProperty name="paging.banner.item_name" value="pago" />  
    <display:setProperty name="paging.banner.items_names" value="pagos" />  
    <display:setProperty name="paging.banner.onepage" value=" " />
    <display:setProperty name="export.excel.filename" value="pagosPendientes.xls" />
</display:table>
</CENTER>
</div>
<input name="page" type="hidden" value="${page}"/>
<input name="sort" type="hidden" value="${sort}"/>
<input name="dir" type="hidden" value="${dir}"/>
<br></br>
<sec:authorize access="not hasRole('RR')">
	<input align="middle"  disabled="disabled"  id="botonGenerar" type="button" value="Generar Archivo" class="ui-state-default ui-corner-all" ></input>	
</sec:authorize>
<input type="button" value="Ver lista Actualizada" class="ui-state-default ui-corner-all" onclick="location.href='../pago/verAprobadosNoAprobView.do?idBanco='; return false;" />

<input type="button" id="botonSelecTodos" name="Check_All" class="ui-state-default ui-corner-all" value="Seleccionar todos" onClick="CheckAll(document.form._chk)">
<input type="button" id="botonDeselecTodos" name="Un_CheckAll" class="ui-state-default ui-corner-all" value="Deseleccionar todos" onClick="UnCheckAll(document.form._chk)">
<input type="button" id="verTotalButton" name="verTotalButton" class="ui-state-default ui-corner-all" value="Total Selecci�n"/>
<input type="text" name="totalPagos" readonly="readonly" value="${totalPagos}">
<input value="false" type="hidden" id="mostrarTotal" name="mostrarTotal">
<input value="false" type="hidden" id="limpiarChks" name="limpiarChks">
</td>
</tr>
</table>
</CENTER>
</form>
</div>
	<center>	
		<div style="display: none;" id="extra-form" title="Agregar Monto Extra">
			<form id="extraForm" name="extraForm" class="cmxform" action="<c:url value='/pago/agregarMontoExtra.do' />" method="post">
				<input type="hidden" name="idBecado" id="idBecado">
				<input type="hidden" name="idsPeriodo" id="idsPeriodo">
				<input type="hidden" name="cantidadPeriodos" id="cantidadPeriodos">
				<div id="left-content">
				    <table border="0" align="left" cellpadding="0" cellspacing="0">
						<tr>
					        <td width="20%" valign="top">Monto Extra:</td>
					        <td width="80%">
								<input name="input_extra" value="0" size="10" type="text" id="input_extra" onkeypress="return validarDecimal(event, this);"></input>
							</td>
					    </tr>
				 	</table>      
				</div>	
			</form>
		</div>
	</center>
</body>
</html>