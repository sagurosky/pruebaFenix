<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
	input[name=search_browser]{	
		font-size: x-small;
		width: 150px;
		color: gray;
		font-style: italic; 
	}
		select[name=search_browser]{	
		font-size: x-small;
		width: 150px;
		color: gray;
		font-style: italic; 
	}
	
</style>
<script src="<c:url value="/static/js/jquery.alerts.js" />" type="text/javascript" ></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Alta de Cuentas</title>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.blockUI.js"/>"></script>

<script type="text/javascript">

$.fn.dataTableExt.oApi.fnReloadAjax = function ( oSettings, sNewSource, fnCallback )
{
	if ( typeof sNewSource != 'undefined' )
	{
	oSettings.sAjaxSource = sNewSource;
	}
	this.oApi._fnProcessingDisplay( oSettings, true );
	var that = this;
	
	oSettings.fnServerData( oSettings.sAjaxSource, null, function(json) {
	/* Clear the old information from the table */
	that.oApi._fnClearTable( oSettings );
	
	/* Got the data - add it to the table */
	for ( var i=0 ; i<json.aaData.length ; i++ )
	{
	that.oApi._fnAddData( oSettings, json.aaData[i] );
	}
	
	oSettings.aiDisplay = oSettings.aiDisplayMaster.slice();
	that.fnDraw( that );
	that.oApi._fnProcessingDisplay( oSettings, false );
	
	/* Callback user function - for event handlers etc */
	if ( typeof fnCallback == 'function' )
	{
	fnCallback( oSettings );
	}
	} );
}

$.fn.dataTableExt.oApi.fnGetFilteredNodes = function ( oSettings )
{
	var anRows = [];
	for ( var i=0, iLen=oSettings.aiDisplay.length ; i<iLen ; i++ )
	{
		var nRow = oSettings.aoData[ oSettings.aiDisplay[i] ].nTr;
		anRows.push( nRow );
	}
	return anRows;
};

var asInitVals = new Array();
var oTable2;
var selected =  new Array();
$(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

$(document).ready(function() {
	$('#botonGenerar').click( function() {
		var result;
		var selected = fnGetIdsOfSelectedRows(fnGetSelected(oTable2));
		if(selected.length < 1){
	        jAlert('warning', 'Por favor seleccione al menos 1 cuenta para el alta.', 'Atenci�n!');
			return false;
		}
	  jConfirm('Esta seguro de que desea generar el archivo de alta para las cuentas seleccionadas?', 'Confirmaci�n', function(result){
		    if (result) {
		    	jQuery("#ctasSeleccionadas").val(selected);
		    	var idBanco = $("#banco").val();  
		    	document.forms['form'].action = "../cuenta/generarArchivoCuentas.do?idBanco="+idBanco;
				document.forms['form'].submit();
		    } else {
		      return false;
		    }
		  });
		
	} );


	TableToolsInit.sSwfPath = '<c:url  value="/static/js/table/tabletools/swf/ZeroClipboard.swf"/>'
	 oTable2 = $('#tabla').dataTable({
		"sDom": '<"H"Tl>rt<"F"ip>', 
		"oLanguage": {
		"sLengthMenu": 'Mostrar <select>'+
		'<option value="25">25</option>' +
		'<option value="50">50</option>'+
		'<option value="75">75</option>'+
		'<option value="100">100</option>'+
		'<option value="-1">Todos</option>'+
		'</select> registros por hoja',
		"sZeroRecords": "No se encontraron registros",
		"sInfo": "Mostrando del _START_ al _END_ de _TOTAL_ registros",
		"sInfoEmtpy": "Mostrando 0 registros",
		"sInfoFiltered": "(filtrado de _MAX_ registros totales)",
		"sSearch": "Buscar",
		"oPaginate": {
			"sFirst":    "Primera",
			"sPrevious": "Anterior",
			"sNext":     "Siguiente",
			"sLast":     "Ultima"
		}
		
		},
		"bJQueryUI": true,
		"sPaginationType": "full_numbers",
		"iDisplayLength": 25,
		"bProcessing" : true,
		"sAjaxSource" : "../cuenta/obtenerCuentasPorBanco.do?idBanco=0",
		"aoColumns" : [
					/* idCandidato */{
						"bSortable" : false,
						"bSearchable" : false,
						"bVisible": false
					},
		       		null,
					null,
		       		null,
		       		null,
		       		null,
		       		null]
		                    		
	});
	
		$('#botonSelecTodos').click( function() {
		    var aTrs = oTable2.fnGetFilteredNodes();
		    for (var i = 0; i < aTrs.length; i++) {
		        $(aTrs[i]).addClass('row_selected');
		        }
			
		} );

		$('#botonDeselecTodos').click( function() {
		    var aTrs = oTable2.fnGetNodes();
		    for (var i = 0; i < aTrs.length; i++) {
		        $(aTrs[i]).removeClass('row_selected');
		        }
			
		} );
		
		/* Agrega el manejador del evento click en las filas */
       $('#tabla').delegate('tr', 'click', function(event) {
             if ( $(this).hasClass('row_selected') )
                        $(this).removeClass('row_selected');
                  else
                        $(this).addClass('row_selected');
            });
			
		
		function fnGetSelected(oTableLocal) {
		    var aReturn = new Array();

		    // fnGetNodes es una funcion predefinida de DataTable 
		    // aTrs == array de filas de la tabla
		    var aTrs = oTableLocal.fnGetNodes();

		    // Se guardan todos los TR con class 'row_selected' en un array
		    for (var i = 0; i < aTrs.length; i++) {
		        if ($(aTrs[i]).hasClass('row_selected')) {
		            aReturn.push(aTrs[i]);
		        }
		    }

		    return aReturn;
		}

		// Esta funcion recupera el valor de la columna hidden de la tabla 
		//(en la que esta el id)
		function fnGetIdsOfSelectedRows(oSelectedRows) {
		    var aRowIndexes = new Array();
		    var aRowData = new Array();
		    var aReturn = new Array();

		    aRowIndexes = oSelectedRows;    

		    // Se recorren las filas seleccionadas y se crea un arreglo 
		    //delimitado por comas de los ids que se envian al controller para procesarlos
		    for(var i = 0; i < aRowIndexes.length; i++){
		        // fnGetData es una funcion predefinida de DataTable
		        // Se obtienen los datos de la fila con index i
		        aRowData = oTable2.fnGetData(aRowIndexes[i]);

		        //Se guardan los valores cocatenados en un array
		        aReturn.push(aRowData[0]);
		    }

		    return aReturn;
		}

		$("#banco").change(function(evt) {
			var idBanco = $("#banco").val();
			if(idBanco == 0){
				$("#botonGenerar").attr('disabled',true);
			}else{
				$("#botonGenerar").attr('disabled',false);
			}
			oTable2.fnReloadAjax( "../cuenta/obtenerCuentasPorBanco.do?idBanco=" + idBanco  );	
		})

		//filtros
		var  isMultipleSeleccion = true;

		
		$("thead#cuenta input").keyup( function () {
			//Esto es un parche para que se puedan utilizar los filtros en una 
			//Seleccion multiple. 
			//Esta variable se debe poner en true,antes de la incorporacion de las funciones de la tabla
			try {
				if(isMultipleSeleccion == "undefined"){
					isMultipleSeleccion = false;
				}
			} catch (e) {
				isMultipleSeleccion = false;
			}
			if(isMultipleSeleccion){
				var index = eval($("thead#cuenta input").index(this)+ 1 );
				/* Filter on the column (the index) of this element */
				oTable2.fnFilter( this.value,index);
				$(oTable2.fnSettings().aoData).each(function (){
					$(this.nTr).removeClass('row_selected');
				});				
			}else{
				oTable2.fnFilter( this.value, $("thead#cuenta input").index(this) );
			}
			    
		} );
		
		$("thead#cuenta input").each( function (i) {
			asInitVals[i] = this.value;
		} );
		
		$("thead#cuenta input").focus( function () {
			if ( this.className == "search_init" )
			{
				this.className = "";
				this.value = "";
			}
		} );
		
		$("thead#cuenta input").blur( function (i) {
			if ( this.value == "" )
			{
				this.className = "search_init";
				this.value = asInitVals[$("thead#cuenta input").index(this)];
			}
		} );

		jQuery('thead#cuenta select').change( function() {
			select_val = jQuery(this).val();
			if (select_val == "All" || select_val == '') {
				oTable2.fnFilter("");
				oTable2.fnDraw();
			} else {
				oTable2.fnFilter(select_val);
			}
			$(oTable2.fnSettings().aoData).each(function (){
				$(this.nTr).removeClass('row_selected');
			});
			jQuery('thead#cuenta select').val(select_val);
		} );
		

} );

</script>

  
<style type="text/css">
label { width: 10em; float: left; }
label.error { float: none; color: red; padding-left: .5em; vertical-align: top; }
p { clear: both; }
.submit { margin-left: 12em; }
em { font-weight: bold; padding-right: 1em; vertical-align: top; }
</style>
  <script>
  $(document).ready(function(){
    $("#form").validate();
  });
  </script>

</head>
<body>
<div id="main-content">
<br><br>
<center><h3>Alta de Cuentas</h3></center>
<br><br>
<form method="post" id="form" name="form" >
	<div id="">
	<table align="center">
		<tr align="center">
			<td class="inicio" align="center" style="font-size: 14px; font-weight: bold">Banco:</td>
			<td align="center">
		         <select id="banco" name="banco" class="required">
						<option value="0" selected="selected">Todos</option>
						<c:forEach var="banco" items="${bancos}">
							<option id="banco" value="${banco.id}">${banco.nombre}</option>
						</c:forEach>
					</select>
			</td>
			<td>
				&nbsp;
				&nbsp;
			</td>
		</tr>
	</table>
	</div>
<br><br>
<CENTER>

<table style="margin-left: 50px; margin-right: 50px;" width="800px">
<tr >
<td >
<div id="">
<table align="center"  class="dataTables_wrapper" id="tabla" width="100%" border="0" style="background-color: #C0C2FF">
<thead title="creacion de cuentas" align="center" style="width: 100%" id="cuenta">
	<tr align="center">
		<th></th>
		<th>Banco</th>
		<th>Becado</th>
		<th>Titular Cuenta</th>
		<th>CUIL</th>
		<th>RR</th>
		<th>Zona</th>
	</tr>
	<tr>
		<td><input name="search_browser"  value="Buscar" class="search_init"/></td>
		<td><input name="search_browser"  value="Buscar" class="search_init"/></td>
		<td><input name="search_browser"  value="Buscar" class="search_init"/></td>
		<td><input name="search_browser"  value="Buscar" class="search_init"/></td>
		<td><input name="search_browser" value="Buscar" class="search_init"/></td>
		<td><input name="search_browser"  value="Buscar" class="search_init"/></td>		
	</tr>	
</thead>
	<tbody align="center" style="font-size: 14px">
</tbody>

</table>
</div>
<br></br>
	<input type="hidden" id="ctasSeleccionadas" name="ctasSeleccionadas"/>

<input align="middle" disabled="disabled" id="botonGenerar" type="button" value="Generar Archivo" class="ui-state-default ui-corner-all" ></input>	
<input type="button" value="Ver lista actualizada" class="ui-state-default ui-corner-all"	 onclick="location.href='../cuenta/verCreacionCuentas.do'; return false;" />
<input align="middle" id="botonSelecTodos" type="button" value="Seleccionar todos" class="ui-state-default ui-corner-all" ></input>	
<input align="middle" id="botonDeselecTodos" type="button" value="Deseleccionar todos" class="ui-state-default ui-corner-all" ></input>
</td>
</tr>
</table>
</CENTER>
</form>
</div>
</body>
</html>