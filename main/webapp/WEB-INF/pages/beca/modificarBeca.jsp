<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript"
src="<c:url value="/static/js/jquery.js"/>"></script>
<script type="text/javascript"
src="<c:url value="/static/js/jquery-ui-1.8.5.custom.min.js"/>"></script>
<script type="text/javascript"
src="<c:url value="/static/js/table/jquery.dataTables.min.js"/>"></script>
<script type="text/javascript"
src="<c:url value="/static/js/jquery.ui.datepicker-es.js"/>"></script>
<link rel="stylesheet"
href="<c:url value="/static/css/cimientos/jquery-ui-1.8.5.custom.css"/>" media="all">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="<c:url value="/static/css/demos.css"/>" media="all" />
<title>..:: Modificar Beca ::..</title>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.validate.js"/>"></script>
	<style type="text/css">
	label { width: 10em; float: left; }
	label.error { float: none; color: red; padding-left: .5em; vertical-align: top; }
	p { clear: both; }
	.submit { margin-left: 12em; }
	em { font-weight: bold; padding-right: 1em; vertical-align: top; }
	</style>
  <script>
  $(document).ready(function(){
   // $("#form1").validate(); DMS 20/9/23 reemplazo validate por valid de la funcion enviar (daba error)
    $("#fechaAlta").datepicker();
  });
  

	//DMS 20/9/23  antes de hacer un submit doy vuelta el valor de la fecha para que el validador
	//funcione bien, luego lo normalizo para que llegue bien al controlador

	function enviar(){
		
		voltearFecha();
		 
		 
		  if($("#altaBeca").valid()){
				voltearFecha();
				document.getElementById("altaBeca").submit(); 
			}else voltearFecha();
	}

	function voltearFecha(){
		  var fecha=$("#fechaAlta").val();
		  fecha=fecha.toString();
		  var dia=fecha.slice(0,2);
		  var mes=fecha.slice(3,5);
		  var anio=fecha.slice(6,10);
		  var barra=fecha.slice(2,3);
		fecha=mes+barra+dia+barra+anio;  
		document.getElementById("fechaAlta").value=fecha;
		console.log(fecha);
	}





  
  
  
  
  
  
  
  </script>
  <script>
  function verificarCantidadBecas(obj){
	  	
	  	var c=0;	  
	  	
	  	c=parseInt(obj.value);
	  	
	  	var co=0;
	  	
	  	co=parseInt(document.getElementById("cantidadOriginal").value);
	  	
	  	var ca=0;
	  	
	  	ca=parseInt(document.getElementById("cantidadAsisgnada").value);
		//alert(c);
		//alert(ca);
		//alert(co);
	  	if (parseInt(c)<parseInt(ca)) {
	  		//alert();
	  		document.getElementById("cantidad").value=document.getElementById("cantidadOriginal").value; 
		}
	}
  </script>
  <script>
  function chequearLongitud(obj){
		if (obj.value.length > 250) {
		obj.value = obj.value.substring(0, 250);
		}
	}
  
$(function() {
	  $("#ciclo").change(function(evt) {
	    evt.preventDefault()   // make sure the hyperlink doesn't work per se
	    $.ajax( {
	      type: "GET",
	      url: "../ajax/obtenerListaPeriodos.do",
	      data: { idCiclo: $("#ciclo").val() },
	      dataType: "json",
	      success: function(data) {
	    	  var options = '';
	            options += '<option value="" selected="selected">Seleccione un periodo</option>'
	            $(data.periodos).each(function() {
	                options += '<option value="' + this.id + '">' + this.nombre + '</option>';
	            });
	             $("select#periodo").html(options);
	        	
	      }
	    } )
	  })
	})

</script>
<script type="text/javascript">
	$(function() {
		$("#padrino").autocomplete({
			source: function(request, response) {
				$.ajax({
					url: "../ajax/buscarPadrinosPorNombre.do",
					dataType: "json",
					data: {
						style: "full",
						maxRows: 15,
						name_startsWith: request.term
					},
					success: function(data) {
						response($.map(data.padrinos, function(item) {
							return {
								label: item.nombre,
								value: item.nombre,
								id: item.id
							}
						}))
					}
				})
			},
			minLength: 2,
			select: function(event, ui) {
				$("#idPadrino").val(ui.item.id);
			},
			open: function() {
				$(this).removeClass("ui-corner-all").addClass("ui-corner-top");
			},
			close: function() {
				$(this).removeClass("ui-corner-top").addClass("ui-corner-all");
			}
		});
	});
	</script>
	<script>
		var a;
		a=0;
	</script>
	<script>
		
		function validarEstado(){
			//
			//a=a+1
			//alert(a);
			//if($("#estado option:selected").val()==$("#txtEstado").val()){
			//	a=0;
			//	document.forms['form1'].action = "../beca/modificar.do";
				//document.forms['fomr1'].idBeca.value = id;
			//	document.forms['form1'].submit();
								
			//}
			//else{
			//	if (a==2){
			//		document.forms['form1'].action = "../beca/modificar.do";
					//document.forms['fomr1'].idBeca.value = id;
			//		document.forms['form1'].submit();
			//	}
			//	else{
			//		alert("Record� de editar la fecha de modificaci�n");	
			//	}
					
			//}
		}
	</script>
	
	<script>
		function verificarAviso(){
			
			//if($("#estado option:selected").val()==$("#txtEstado").val()){
			//	$("#aviso").hide();	
			//}else{
			//	$("#aviso").show();	
			//}
		}
	</script>
	<script>
		//$("#aviso").hide();	
	
	</script>

<script>
	function enviarMail(){
		alert();
	}

</script>

</head>
<body>

<form class="cmxform" id="form1" action="<c:url value='/beca/modificar.do' />" method="post"> 
<div id="right-content">

    <br />

    <br />
<fieldset style="font-size: 12px; width:980px;">
  <legend><c:if test="${beca.id != null}">Modificar&nbsp;</c:if> <c:if test="${beca.id == null}">Alta&nbsp;</c:if>Beca</legend>
    <table border="0" align="left" cellpadding="0" cellspacing="0" id="table-forms">
		<tr>
	        <td width="180">Padrino*</td>
	        <td width="669"><label>
			<c:if test="${beca.padrino.empresa != null}">
			<input type="text" id="padrino" name="padrino" class="text-input required" value="${beca.padrino.empresa.denominacion}"/>
			</c:if>
			<c:if test="${beca.padrino.empresa == null}">
			<input type="text" id="padrino" name="padrino" class="text-input required" value="${beca.padrino.datosPersonales.apellido},${beca.padrino.datosPersonales.nombre}"/>
			</c:if>
			
	    </tr>
		<tr>
	    <td>Ciclo*</td>
        <td><label>
         <select  id="ciclo" name="ciclo" class="required">
				<option value="">Seleccione un ciclo</option>
				<c:forEach var="ciclo1" items="${ciclos}">
					<c:if test="${ciclo1.id == beca.ciclo.id}">
						<option selected="selected" value="${ciclo1.id}">${ciclo1.nombre}</option>
					</c:if>
					<c:if test="${ciclo1.id != beca.ciclo.id}">
						<option value="${ciclo1.id}">${ciclo1.nombre}</option>
					</c:if>
				</c:forEach>
			</select>
        </label></td>
      	</tr>		
		<tr>
	    <td>Mes Incorporac. Beca*</td>
        <td><label>
         <select  id="periodo" name="periodo" class="required">
			<option value="">Seleccione un periodo</option>
				<c:forEach var="periodo1" items="${periodos}">
					<c:if test="${periodo1.id == beca.periodoPago.id}">
						<option selected="selected" value="${periodo1.id}">${periodo1.nombre}</option>
					</c:if>
					<c:if test="${periodo1.id != beca.periodoPago.id}">
						<option value="${periodo1.id}">${periodo1.nombre}</option>
					</c:if>
				</c:forEach>
			</select>
        </label></td>
      	</tr>
		<tr>
	    <td>Zona*</td>
        <td>
        	<label>
	         	<c:if test="${beca.cantidadAsignada != 0}">
					<select id="zona" name="zona" style="visibility: hidden">
						<c:forEach var="zona" items="${zonas}">
							<c:if test="${zona.id == beca.zona.id}">
								<option selected="selected" value="${zona.id}">${zona.nombre}</option>
							</c:if>
							<c:if test="${zona.id != beca.zona.id}">
								<option value="${zona.id}">${zona.nombre}</option>
							</c:if>				
						</c:forEach>
						<input type="text" id="zona2" name="zona2" class="text-input digits required" value="${beca.zona.nombre}" disabled="disabled">
				</c:if>
				<c:if test="${beca.cantidadAsignada == 0}">
					<select id="zona" name="zona">
						<c:forEach var="zona" items="${zonas}">
							<c:if test="${zona.id == beca.zona.id}">
								<option selected="selected" value="${zona.id}">${zona.nombre}</option>
							</c:if>
							<c:if test="${zona.id != beca.zona.id}">
								<option value="${zona.id}">${zona.nombre}</option>
							</c:if>				
						</c:forEach>
				</c:if>
				
				</select>
        	</label>
        	
        </td>
      	</tr>
      	<tr>
      	<td><input name="zonaVieja" id="zonaVieja" type="hidden" value ="${beca.zona.id}"></td>
      	</tr>
      	<tr>
      	<td><input name="zonaViejaS" id="zonaViejaS" type="hidden" value ="${beca.zona.nombre}"></td>
      	</tr>
		<tr>
	    <td>Tipo Beca</td>
        <td><label>
         <select id="tipo" name="tipo">
         		<option value="" selected="selected">Seleccione un tipo</option>
         		<c:forEach var="tipo" items="${tipos}">
					<c:if test="${tipo.id == beca.tipo.id}">
						<option selected="selected" value="${tipo.id}">${tipo.valor}</option>
					</c:if>
					<c:if test="${tipo.id != beca.tipo.id}">
						<option value="${tipo.id}">${tipo.valor}</option>
					</c:if>					
				</c:forEach>
			</select>
        </label></td>
      	</tr>        	
		<tr>
		    <td>Estado*</td>
	        <td>
	        	<label>
	         		<select id="estado" name="estado" onclick="verificarAviso()">
						<c:forEach var="estado" items="${estados}">
							<c:if test="${estado.id == beca.estado.id}">
								<option selected="selected" value="${estado.id}">${estado.valor}</option>
							</c:if>
							<c:if test="${estado.id != beca.estado.id}">
												
								<option value="${estado.id}">${estado.valor}</option>
							</c:if>					
						</c:forEach>
					</select>
	        		
	        	</label>
	        	<input type="hidden" id="txtEstado" value="${beca.estado.id}">
	        </td>
      	</tr>
		<tr>
			<td>Cantidad*</td>
			<td><input type="text" id="cantidad" name="cantidad" class="text-input digits required" value="${beca.cantidad}" onchange="verificarCantidadBecas(this)">
				<input type="hidden" id="cantidadOriginal" name="cantidadOriginal" class="text-input digits required" value="${beca.cantidad}">
			</td>
		</tr>
		<tr>	
			<td>Cantidad Asignada</td>
			<td>	<input type="text" id="cantidadAsignada" name="cantidadAsisgnada" class="text-input digits required" value="${beca.cantidadAsignada}" disabled="disabled">        
			</td>
	    </tr>
	    
		<tr>
        	<td>Fecha Confirmaci&oacute;n</td>
        	<td>
	        	<input name="fechaAlta" id="fechaAlta" class="text-input" value="<fmt:formatDate value="${beca.fechaAlta}" pattern="dd/MM/yyyy"/>" /> dd/mm/aaaa        
	    		<input name="fechaModif" id="fechaModif" class="text-input date"  type="hidden" value="<fmt:formatDate value="${fechaModif}" pattern="dd/MM/yyyy"/>" /> 
	    		<!--  input type="text"  id="aviso" name="aviso" style="display:none;color: green;border:0;" size="50" value="Record� de hacer bla bla bla bla..."/-->
	    	</td>
	    </tr>	
		<tr>
			<td>Comentarios:</td>
		   	<td><textarea cols="60" rows="5"  name="comentarios" name="comentarios" onkeypress="chequearLongitud(this);">${beca.comentarios}</textarea></td>
		</tr>		
      	<tr>
        <td>&nbsp;</td>
     	   <td>&nbsp;</td>
      	</tr>
      	<tr>
        	<td colspan="2">
				
</table>	
</fieldset>
<table width="800" border="0" align="left" cellpadding="0" cellspacing="0" id="table-botons-small">
         <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      	</tr>
        <tr>
    	   	<td width="50" height="0" align="left" valign="middle">
	           	<input type="hidden" value="${beca.id}" name="idBeca"/>
	        	<c:if test="${beca.id != null}">
		 			<input class="ui-state-default ui-corner-all "  type="submit" value="Modificar" />
				</c:if>
			</td>
			
 	      	<td width="50" align="left" valign="middle">
	 	      	<c:if test="${beca.id == null}">
					<input class="ui-state-default ui-corner-all "  type="submit" value="Guardar" />
				</c:if>
			</td>
			<td width="50" align="left" valign="middle"><input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../beca/listaBecasView.do'; return false;" /></td>
       		<td width="600" height="30" align="left" valign="middle">&nbsp;
       		</td>
   		</tr>

		 	</table>      	
</div>	
<input name="idPadrino" id="idPadrino" type="hidden" value="${beca.padrino.id}">
	</form>
	

</body>
</html>