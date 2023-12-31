<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@taglib prefix="display" uri="http://displaytag.sf.net"%>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript" src="<c:url value="/static/js/jquery.dialog.detail.js"/>"></script>
<style type="text/css">
	table#exportacion{  
	background-color: #C0C2FF;
	border: 0;
	}
</style>

<script>
$(function() {
	  $("#cicloId").change(function(evt) {
	    evt.preventDefault()
	    if($("#cicloId").val() == 'Todos'){
	    	var options = '<option value="" selected="selected">Todos</option>'
			$("select#periodoId").html(options);
	    }
	    else{
		    $.ajax( {
		      type: "GET",
		      url: "../ajax/obtenerListaPeriodos.do",
		      data: { idCiclo: $("#cicloId").val() },
		      dataType: "json",
		      success: function(data) {
		    	    var options = '';
		            options += '<option value="" selected="selected">Todos</option>'
		            $(data.periodos).each(function() {
		                options += '<option value="' + this.id + '">' + this.nombre + '</option>';
		            });
		             $("select#periodoId").html(options);
		        	
		      }
		    } )
	    }
	  })
	})

</script>	
	
<script type="text/javascript">
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

</script>

<script type="text/javascript">
$(function() {
	$("#padrinoBeca").autocomplete({
		source: function(request, response) {
			$.ajax({
				url: "../ajax/buscarPadrinosPorNombre.do?",
				dataType: "json",
				data: {
					style: "full",
					maxRows: 12,
					name_startsWith: request.term
				},
				success: function(data) {
					response($.map(data.padrinos, function(item) {
						return {
							label: item.nombre,
							value: item.nombre,
							id: item.id,
							padrino: item.padrino
						}
					}))
				}
			})
		},
		minLength: 2,
		select: function(event, ui) {
			$("#idPadrino").val(ui.item.id);
			$("#padrinoBeca").text(ui.item.padrino);
		}
	});
});

</script>

<script type="text/javascript" src="<c:url value="/static/js/jquery.effects.core.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/jquery.ui.position.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/jquery.ui.widget.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/jquery.js"/>"></script>
<script type="text/javascript" src="<c:url value="/static/js/jquery-ui-1.8.5.custom.min.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/static/css/cimientos/jquery-ui-1.8.5.custom.css"/>" media="all">
<script src="<c:url value="/static/js/jquery.alerts.js" />" type="text/javascript" ></script>

<link rel="stylesheet" href="<c:url value="/static/css/displaytags.css"/>" media="all">

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listado de Becas</title>

<script type="text/javascript">
function enviarForm(action, id){
	if(action=='ver'){
		document.forms['becaForm'].action = "../beca/verBecaDetalleView.do";
		document.forms['becaForm'].idBeca.value = id;
		document.forms['becaForm'].submit();
	}else if(action=='modificar'){
		document.forms['becaForm'].action = "../beca/modificarBecaView.do";
		document.forms['becaForm'].idBeca.value = id;
		document.forms['becaForm'].submit();
	}else if(action=='eliminar'){
		jConfirm('Esta seguro de que desea eliminar la beca? Dichas becas pasarán a ser del padrino "Fundación Cimientos"', 'Confirmación', function(result){
		    if (result) {
				document.forms['becaForm'].action = "../beca/eliminarBeca.do";
				document.forms['becaForm'].idBeca.value = id;
				document.forms['becaForm'].submit();
		    } else {
		      return false;
		    }
		  });
	}else if(action=='alta'){
		document.forms['becaForm'].action = "../beca/altaBecaView.do";
		document.forms['becaForm'].submit();
	}
	
}
function validarFiltros(){
	
	if($('#zona').val() == ''){
		$('#idZona').removeAttr('value');
	}
	if($('#padrinoBeca').val() == ''){
		$('#idPadrino').removeAttr('value');
	}
	document.forms['becaForm'].action = "../beca/listaBecasView.do";	
	document.forms['becaForm'].submit();
	
}
function validarFiltros2(){
	
	if($('#zona').val() == ''){
		$('#idZona').removeAttr('value');
	}
	if($('#padrinoBeca').val() == ''){
		$('#idPadrino').removeAttr('value');
	}
	document.forms['becaForm'].action = "../beca/exportarBecasView.do";	
	document.forms['becaForm'].submit();
	
}
</script>

</head>
<body>
<div id="main-content">
<br><br>
<center><h3>Listado de Becas</h3></center>
<br><br>
<form method="post" id="becaForm" name="becaForm" action="<c:url value="/beca/listaBecasView.do"/>">
<fieldset style="font-size: 12px; margin-left: 60px; margin-right: 50px; width:980px;">
<table id="table-informe" align="center" style="margin-left: 100px; margin-right: 60px; border-style:hidden;" width="600px">
		
		<tr align="center">
			<td align="left" style="font-size: 13px; font-weight: bold">Ciclo:</td>
			<td align="left">
					 <select id="cicloId" name="cicloId" class="required"  style="width:150px;">
						<option value="Todos">Todos</option>
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
			<td align="left" style="font-size: 13px; font-weight: bold">Zona:</td>
			<td align="left" >
			<input type="text" value="${zona}" id="zona" name="zona" size="21" onkeyup="reloadInputs();">
			<input name="idZona" value="${idZona}" id="idZona" type="hidden">
			</td>
		</tr>

		<tr align="center">
			<td align="left" style="font-size: 13px; font-weight: bold">Tipo Beca:</td>
			<td align="left">
					 <select id="tipoBecaId" name="tipoBecaId" class="required" style="width:150px;">
					 	<option value="0">Todos</option>
						<c:forEach var="tipoBeca" items="${tiposBecas}">
							<c:if test="${tipoBeca.id == tipoBecaId}">
								<option selected="selected" id="forma" value="${tipoBeca.id}">${tipoBeca.descripcion}</option>
							</c:if>
							<c:if test="${tipoBeca.id != tipoBecaId}">
							<option id="forma" value="${tipoBeca.id}">${tipoBeca.descripcion}</option>
							</c:if>
						</c:forEach>
 					</select>
			</td>
			<td align="left" style="font-size: 13px; font-weight: bold">Tipo Padrino:</td>
			<td align="left">
					 <select id="tipoId" name="tipoId" class="required" style="width:150px;">
						<option value="0">Todos</option>
						<c:forEach var="tipo" items="${tipos}">
							<c:if test="${tipo.id == tipoId}">
								<option selected="selected" id="tipo" value="${tipo.id}">${tipo.valor}</option>
							</c:if>
							<c:if test="${tipo.id != tipoId}">
							<option id="tipo" value="${tipo.id}">${tipo.valor}</option>
							</c:if>
						</c:forEach>
 					</select>
			</td>
		</tr>		

		<tr align="center">
			<td align="left" style="font-size: 13px; font-weight: bold">Estado Beca:</td>
			<td align="left">
					 <select id="estadoId" name="estadoId" class="required" style="width:150px;">
						<option value="0">Todos</option>
						<c:forEach var="estado" items="${estados}">
							<c:if test="${estado.id == estadoId}">
								<option selected="selected" id="estado" value="${estado.id}">${estado.valor}</option>
							</c:if>
							<c:if test="${estado.id != estadoId}">
							<option id="ciclo" value="${estado.id}">${estado.valor}</option>
							</c:if>
						</c:forEach>
 					</select>
			</td>
			<td align="left" style="font-size: 13px; font-weight: bold">Mes Incorp.:</td>
			<td align="left">
					 <select id="periodoId" name="periodoId" class="required" style="width:150px;">
						<option value="0">Todos</option>
						<c:forEach var="periodo" items="${periodos}">
							<c:if test="${periodo.id == periodoId}">
								<option selected="selected" id="periodo" value="${periodo.id}">${periodo.nombre}</option>
							</c:if>
							<c:if test="${periodo.id != periodoId}">
							<option id="tipo" value="${periodo.id}">${periodo.nombre}</option>
							</c:if>
						</c:forEach>
 					</select>
			</td>
		</tr>	
		
		<tr align="center">

			<td align="left" style="font-size: 13px; font-weight: bold">Padrino:</td>
			<td align="left">
				<input type="text" id="padrinoBeca" value="${padrinoBeca}" name="padrinoBeca" size="21">
				<input value="${idPadrino}" name="idPadrino" id="idPadrino" type="hidden">
			</td>
		</tr>
		
		<tr align="center">
			<td colspan="4">
				<input align="middle" id="buscar" type="submit"  onclick="validarFiltros()"  value="Buscar" class="ui-state-default ui-corner-all" ></input>
				<!--  input align="middle" id="exportar" type="submit"  onclick="validarFiltros2()"  value="Exportación Especial" class="ui-state-default ui-corner-all" ></input-->
			</td>
		</tr>
	</table>	
	</fieldset>
<br><br>
<CENTER style="width: 1100px;">
	<table align="center" width="150px" >
		<tr>
			<td >
				<input align="middle"  id="buscar" style="width:60px;height:23px;font-size: 15px" class="ui-state-default ui-corner-all" type="button" value="Alta"  onclick="enviarForm('alta','')" ></input>
			</td>
		</tr>
	</table>
	<br>
<display:table export="true" class="displayTags_wrapper" style="font-size: 12px; margin-left: 50px; margin-right: 50px;width:1000px; background-color: #C0C2FF;"  id="beca" name="becas" requestURI="" pagesize="50">  
    
    <display:column	media="excel" title="Id Beca">${beca.id}</display:column> 
    <display:column title="Padrino" >
 		<c:if test="${beca.padrino.datosPersonales != null}">
			${beca.padrino.datosPersonales.apellido}, ${beca.padrino.datosPersonales.nombre}
		</c:if>	
		<c:if test="${beca.padrino.empresa != null}">
			${beca.padrino.empresa.denominacion}
		</c:if>
    </display:column>
    
    <display:column   title="Id Plat" sortProperty="idPlataforma"  headerClass="sortable">
    	${beca.padrino.nroCtesPlataformaContable}
    </display:column>
    

    <display:column property="padrino.tipo.valor"   title="Tipo padrino" />
    
    <display:column title="Mail"  media="excel">
 		<c:if test="${beca.padrino.datosPersonales != null}">
			${beca.padrino.datosPersonales.mail}
		</c:if>	
		<c:if test="${beca.padrino.empresa != null}">
			${beca.padrino.empresa.mailContacto1}  ${beca.padrino.empresa.mailContacto2}
		</c:if>
    </display:column>
    
    <display:column title="CUIT/CUIL"  >
 		<c:if test="${beca.padrino.datosPersonales != null}">
			${beca.padrino.datosPersonales.cuilCuit}
		</c:if>	
		<c:if test="${beca.padrino.empresa != null}">
			${beca.padrino.empresa.CUIT}
		</c:if>
    </display:column>
    
    
    <display:column property="periodoPago.nombre"    title="Mes Incorporac. Beca" />
	<display:column property="ciclo.nombre"  title="Ciclo Programa"  /> 
	<display:column property="estado.valor"   title="Estado"  /> 
	<display:column  property="zona.nombre"  title="Zona" />
	<display:column  property="tipo.descripcion"   title="Tipo Beca" />
	<display:column  property="cantidad"  title="Cantidad" />
	
	<display:column   title="Comentarios" sortProperty="comentarios" sortable="true" headerClass="sortable">
    	${beca.comentarios}
    </display:column>
	<display:column  title="Fecha Confirmación"><fmt:formatDate value='${beca.fechaAlta}' pattern='dd/MM/yyyy'/> </display:column>
	<display:column  title="Fecha Modificación"><fmt:formatDate value='${beca.fechaModificacion}' pattern='dd/MM/yyyy'/> </display:column>
	<display:column title="Acciones" media="html">
				<table>
				<tr>
				<td>
					<c:if test="${beca.ciclo.estado.id==1 || beca.ciclo.estado.id==2 }">
						<div  style= width:0.5cm class="ui-state-default ui-corner-all" > 
							<a  onclick="enviarForm('modificar','${beca.id}')"> 
							<span class="ui-icon ui-icon-pencil" > 
							</span></a>				
						</div>
					</c:if>						
				</td>
				<td>	
					<c:if test="${beca.ciclo.estado.id==3}">
					<div  style= width:0.5cm class="ui-state-default ui-corner-all" > 
							<!--  a onclick="openDetallePadrino('${beca.padrino.id}');"--> 
							<a  onclick="enviarForm('ver','${beca.id}')">
							<span class="ui-icon ui-icon-search" > 
							</span></a>				
						</div>
					</c:if>
				</td>
				
				<td>
					<c:if test="${beca.cantidadAsignada<beca.cantidad}">	
						<div  style= width:0.5cm class="ui-state-default ui-corner-all" > 
							<a  onclick="enviarForm('eliminar','${beca.id}')" > 
							<span class="ui-icon ui-icon-trash" > 
							</span></a>				
						</div>
					</c:if>
				</td>
					
				</tr>
				</table>	
	</display:column>
				

    <display:setProperty name="basic.empty.showtable" value="true" />  
    <display:setProperty name="paging.banner.group_size" value="35" />  
    <display:setProperty name="paging.banner.item_name" value="beca" />  
    <display:setProperty name="paging.banner.items_names" value="becas" />  
    <display:setProperty name="paging.banner.onepage" value=" " />
	<display:setProperty name="export.excel.filename" value="becas.xls" />
	
</display:table>
<br></br>
<table align="center" width="150px" >
	<tr>
		<td >
			<input align="middle"  id="buscar" style="width:60px;height:23px;font-size: 15px" class="ui-state-default ui-corner-all" type="button" value="Alta"  onclick="enviarForm('alta','')" ></input>
		</td>
	</tr>
</table>
</CENTER>
<input type="hidden" name="idBeca" />
</form>
</div>
<div id="dialogPadrino" title="Datos Padrinoxxx">
<jsp:include page="/WEB-INF/pages/detallePerfil/detallePadrino.jsp"></jsp:include>
</div>
<center>
</center>
</body>
</html>

