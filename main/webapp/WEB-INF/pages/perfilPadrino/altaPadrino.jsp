<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="<c:url value="/static/css/demos.css"/>" media="all" />
<title>..:: Alta de Padrino ::..</title>

<script type="text/javascript" src="<c:url  value="/static/js/jquery.validate.js"/>"></script>
<style type="text/css">
	label { width: 10em; float: left; }
	label.error { float: none; color: red; padding-left: .5em; vertical-align: top; }
	p { clear: both; }
	.submit { margin-left: 12em; }
	em { font-weight: bold; padding-right: 1em; vertical-align: top; }
</style>
  <script>
//  DMS c�digo original
//   $(document).ready(function(){
//     $("#altaPadrino").validate();
//     $("#fechaAlta").datepicker({
//     	  changeMonth: true,
//     	  changeYear: true
//     	  });
//   });
//
    
  
  
  
  
  //DMS c�digo que soluciona error de fechas
  
  $(document).ready(function(){
		 
	  
		 // $("#altaPadrino").validate();DMS 15/9/22 reemplazo validate por valid de la funcion enviar (daba error)
		 
		 
	    $("#fechaAlta").datepicker({
	    	  changeMonth: true,
	    	  changeYear: true
	    	  });
	  });

	//DMS 15/9/22 antes de hacer un submit doy vuelta el valor de la fecha para que el validador
	//funcione bien, luego lo normalizo para que llegue bien al controlador
	  function enviar(){
		  
		  voltearFecha();
		 
		 
			if($("#altaPadrino").valid()){
				alert("hola");
				voltearFecha();
				document.getElementById("altaPadrino").submit(); 
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
function formatear(cuil) {
	var xy = cuil.substring(0,2);
	var dni = $('#dni').val();
	var digito = cuil.substring(11,11);
	var cuil = (xy + "-" + dni + "-" + digito);
	return $('#cuit_cuil').val(cuil);	
}
</script>
<script>
$(function() {
	  $("#cuit_cuil").blur(function(evt) {
	    evt.preventDefault()   // make sure the hyperlink doesn't work per se
	    if($("#tipoP").val() == 1){ //es una empresa
		    $.ajax( {
		      type: "GET",
		      url: "../ajax/validarCuitEmpresa.do",
		      data: { cuit_cuil: $("#cuit_cuil").val() },
		      dataType: "json",
		      success: function(data) {
		        if(!(data.existeEmpresa)){
		        	url = "../empresa/altaEmpresaView.do?popup=true&cuit="+document.getElementById("cuit_cuil").value;
		    		window.open(url, '_blank','width=600, height=400 ,scrollbars=YES');
		        	return false;
		        }
		      }
		    } )
	    }else if($("#tipoP").val() == 2){ // es una persona
		    $.ajax( {
			      type: "GET",
			      url: "../ajax/validarCuilPersona.do",
			      data: { cuit_cuil: $("#cuit_cuil").val() },
			      dataType: "json",
			      success: function(data) {
			        if(!(data.existePersona)){
			        	url = "../perfilPadrino/registrarPersonaPadrinoView.do?popup=true&cuil="+document.getElementById("cuit_cuil").value;
			    		window.open(url, '_blank','width=490, height=470 ,scrollbars=NO');
			        	return false;
			        }
			      }
			    } )
	    }   
	  })
	})

</script>
</head>
<body>

<form id="altaPadrino" class="cmxform" action="<c:url value='/perfilPadrino/altaPadrino.do' />" method="post">
<div id="right-content">

    <br />

    <br />
<fieldset  style="font-size: 12px; width:980px;">
	<legend>Alta de Padrino</legend>
    <table width="90" border="0" align="left" cellpadding="0" cellspacing="0" id="table-forms">
   		<tr>
	    <td width="150">Tipo Padrino</td>
        <td width="600">
	        <select name="tipo" id="tipoP" class="text-input required">
	         	<option value="" selected="selected">Seleccione un tipo</option>
				<c:forEach var="tipo" items="${tipos}">
					<option value="${tipo.id}">${tipo.valor}</option>
				</c:forEach>
			</select>		
        </td>
      	</tr>
   		<tr>
	        <td>CUIT/CUIL</td>
	        <td>
			<input type="text" id="cuit_cuil" maxlength="11" name="cuit_cuil" class="text-input digits required"  value="${cuit_cuil}"></td>
	    </tr>
		<tr>
        <td>Fecha de modificaci&oacute;n</td>
        <td><input name="fechaAlta" id="fechaAlta" class="text-input date" value="<fmt:formatDate value="${fechaAlta}" pattern="dd/MM/yyyy"/>" /> dd/mm/aaaa</td>
	    </tr>
		<tr>
			<td>Id Plataforma Contable</td>
			<td><input type="text" name="nroCtesPlataformaContable" class="digits text-input"/>
			</td>
		</tr>
		<tr>
			<td>Recibe informes masivos</td>
			<td><input type="checkbox" name="recibeInformesMasivos" checked="checked"/></td>

		</tr>
		
		<tr>		
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      	</tr>
 	    			
			
</table>
</fieldset>
<table width="800" border="0" align="left" cellpadding="0" cellspacing="0" id="table-botons-small">
          	<tr>
       	 	<td>&nbsp;</td>
     	    <td>&nbsp;</td>
     	    <td><input type="hidden" name="idBeca" /></td>
      		</tr>
          	<tr>
            	<td width="50" align="left" valign="middle"><input class="ui-state-default ui-corner-all " type="button" onclick="enviar()" value="Registrar" /></td>
            	<td width="50" align="left" valign="middle"><input type="button" value="Volver" class="ui-state-default ui-corner-all"	onclick="location.href='../perfilPadrino/listaPadrinosView.do'; return false;" /></td>
            	<td width="600" height="30" align="left" valign="middle">&nbsp;</td>
        	</tr>
	</table>  
</div>
</form>

</body>
</html>