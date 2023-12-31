<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
	input[name=search_browser]{	
		font-size: x-small;
		width: 120px;
		color: gray;
		font-style: italic; 
	}
		select[name=search_browser]{	
		font-size: x-small;
		width: 120px;
		color: gray;
		font-style: italic; 
	}
	
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Renovaci&oacute;n Becas Paso 2</title>

<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.blockUI.js"/>"></script>
<script>
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

var oTable1;
var oTable2;
var asInitVals = new Array();

$(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

$(document).ready(function() {
	

	$('#boton_todos').click( function() {
		$(oTable1.fnSettings().aoData).each(function (){
			$(this.nTr).removeClass('row_selected');
		});
		oTable2.fnReloadAjax( "../renovacionBecas/buscarAlumnos.do?paso=" + 2);
	})
	
	$('#asignacionForm').submit( function() {
		
		var alumnosSeleccionados = fnGetIdsOfSelectedRows(fnGetSelected(oTable2), oTable2);
		var becaSeleccionada = fnGetIdsOfSelectedRows(fnGetSelected(oTable1), oTable1);
		jQuery("#alumnosSeleccionados").val(alumnosSeleccionados);
		jQuery("#idBeca").val(becaSeleccionada);
		if(alumnosSeleccionados == "" || becaSeleccionada == ""){
	        jAlert('warning', 'Por favor seleccione 1 beca y al menos 1 alumno.', 'Atenci�n!');
			return false;
		}
		return true;
	} );

	
	oTable1 = $('#tabla1').dataTable({
		"sDom": '<"H"l>rt<"F"ip>',
		"oLanguage": {
		"sLengthMenu": 'Mostrar <select>'+
		'<option value="25">25</option>'+	
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
			       		null,
			       		null,
			       		null,
			       		null,
			       		null]
	});

		
	
	 oTable2 = $('#tabla2').dataTable({
		 "sDom": '<"H"l>rt<"F"ip>',
		"oLanguage": {
		"sLengthMenu": 'Mostrar <select>'+
		'<option value="25">25</option>'+	
		'<option value="50">50</option>'+
		'<option value="75">75</option>'+
		'<option value="100">100</option>'+
		'<option value="-1">Todos</option>'+
		'</select> registros por hoja',
		"sZeroRecords": "No se encontraron registros",
		"sProcessing": "Por favor espere ...",
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
		"sAjaxSource" : "../renovacionBecas/buscarAlumnos.do?paso=" + 2,
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
		       		null]
		                    		
	});
	

		/* Agrega el manejador del evento click en las filas */
	 $('#tabla2 tbody').delegate('tr', 'click', function(event) {
		 if ( $(this).hasClass('row_selected') ){
			 $(this).removeClass('row_selected');
		 }else {
			 $(this).addClass('row_selected'); 
		 }
			
		});

	 $("#tabla1 tbody").delegate('#beca_row', 'click', function(event) {
			$(oTable1.fnSettings().aoData).each(function (){
				$(this.nTr).removeClass('row_selected');
			});
			$(event.target.parentNode).addClass('row_selected');
			var aData = oTable1.fnGetData( this );
			 oTable2.fnReloadAjax( "../renovacionBecas/buscarAlumnos.do?becaId=" + aData[0] + "&paso=" + 2);
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
		function fnGetIdsOfSelectedRows(oSelectedRows, oTableLocal) {
		    var aRowIndexes = new Array();
		    var aRowData = new Array();
		    var aReturn = new Array();

		    aRowIndexes = oSelectedRows;    

		    // Se recorren las filas seleccionadas y se crea un arreglo 
		    //delimitado por comas de los ids que se envian al controller para procesarlos
		    for(var i = 0; i < aRowIndexes.length; i++){
		        // fnGetData es una funcion predefinida de DataTable
		        // Se obtienen los datos de la fila con index i
		        aRowData = oTableLocal.fnGetData(aRowIndexes[i]);

		        //Se guardan los valores cocatenados en un array
		        aReturn.push(aRowData[0]);
		    }

		    return aReturn;
		}

		//filtros
		var  isMultipleSeleccion = true;

		
		$("thead#beca input").keyup( function () {
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
				var index = eval($("thead#beca input").index(this)+ 1 );
				/* Filter on the column (the index) of this element */
				oTable1.fnFilter( this.value,index);
			}else{
				oTable1.fnFilter( this.value, $("thead#beca input").index(this) );
			}
		} );
		
		$("thead#beca input").each( function (i) {
			asInitVals[i] = this.value;
		} );
		
		$("thead#beca input").focus( function () {
			if ( this.className == "search_init" )
			{
				this.className = "";
				this.value = "";
			}
		} );
		
		$("thead#beca input").blur( function (i) {
			if ( this.value == "" )
			{
				this.className = "search_init";
				this.value = asInitVals[$("thead#beca input").index(this)];
			}
		} );

		jQuery('thead#beca select').change( function() {
			select_val = jQuery(this).val();
			if (select_val == "All" || select_val == '') {
				oTable1.fnFilter("");
				oTable1.fnDraw();
			} else {
				oTable1.fnFilter(select_val);
			}
			$(oTable1.fnSettings().aoData).each(function (){
				$(this.nTr).removeClass('row_selected');
			});
			jQuery('thead#beca select').val(select_val);
		} );

		
		
		$("thead#alumno input").keyup( function () {
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
				var index = eval($("thead#alumno input").index(this)+ 1 );
				/* Filter on the column (the index) of this element */
				oTable2.fnFilter( this.value,index);
				$(oTable2.fnSettings().aoData).each(function (){
					$(this.nTr).removeClass('row_selected');
				});
			}else{
				oTable2.fnFilter( this.value, $("thead#alumno input").index(this) );
			}
		} );
		
		$("thead#alumno input").each( function (i) {
			asInitVals[i] = this.value;
		} );
		
		$("thead#alumno input").focus( function () {
			if ( this.className == "search_init" )
			{
				this.className = "";
				this.value = "";
			}
		} );
		
		$("thead#alumno input").blur( function (i) {
			if ( this.value == "" )
			{
				this.className = "search_init";
				this.value = asInitVals[$("thead#alumno input").index(this)];
			}
		} );

		jQuery('thead#alumno select').change( function() {
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
			jQuery('thead#alumno select').val(select_val);
		} );		
		

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
} );
</script>

</head>

<body>
<div id="main-content">
<form id="asignacionForm" class="asignacionForm" action="<c:url value='/renovacionBecas/renovacionBecas.do?paso=2' />" method="post">
<br>
<CENTER>
<table style="margin-left: 50px; margin-right: 50px;">
<tr >
<td style="vertical-align: top">
<div class="ui-state-default ui-corner-all" style="width:700px;">
<h3 align="center">Renovaci&oacute;n Becas Paso 2</h3>
</div>
<CENTER>

<jsp:include page="/WEB-INF/pages/listasComunes/listaAlumnosRenovacion.jsp"></jsp:include>
<br>
<table align="center">
<tr>
	<td>
		<input align="middle" id="botonSelecTodos" type="button" value="Seleccionar todos" class="ui-state-default ui-corner-all" ></input>	
		<input align="middle" id="botonDeselecTodos" type="button" value="Deseleccionar todos" class="ui-state-default ui-corner-all" ></input>
	</td>
</tr>
</table>
<br>
<jsp:include page="/WEB-INF/pages/listasComunes/listaBecasRenovacion.jsp"></jsp:include>

<table align="center">
<tr>
	<td>
		<input type="submit" value="Renovar" class="ui-state-default ui-corner-all" />
		<input type="button" name="boton_todos" id="boton_todos" value="Ver todos" class="ui-state-default ui-corner-all" />
	</td>
</tr>
</table>
</CENTER>
<input type="hidden" id="alumnosSeleccionados" name="alumnosSeleccionados"/>
<input type="hidden" id="idBeca" name="idBeca"/>
<input type="hidden" id="renovacionPasoII" name="renovacionPasoII"/>
</td>
</tr>
</table>
</CENTER>
</form>	
</div>
</body>
</html>