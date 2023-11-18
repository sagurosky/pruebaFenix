<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Espacio de acompa�amiento</title>

<style type="text/css">
	input[name=search_browser]{	
		font-size: x-small;
		width: 80px;
		color: gray;
		font-style: italic; 
	}
	
	table#laTabla{
		 background-color: #C0C2FF;
		 border: 0;
	}
</style>

<script type="text/javascript">

var oTable2;
var selected =  new Array();
var asInitVals = new Array();

$(document).ready(function() {
	$('#becadosForm').submit( function() {
		var selected = fnGetIdsOfSelectedRows(fnGetSelected(oTable2));
		jQuery("#alumnosSeleccionados").val(selected);
		if(selected == ""){
			alert("Debe seleccionar al menos un alumno");
			return false;
		}
		else
			return true;
	} );

	
	 oTable2 = $('#tablaBecados').dataTable({
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
		"sDom": '<"H"l>rt<"F"ip>',
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
		       		null,
		       		null,
		       		null,
		       		null,null
		       		]
		                    		
	});
	
	 $("thead input").keyup( function () {
			/* Filter on the column (the index) of this element */
			oTable2.fnFilter( this.value, $("thead input").index(this)+1 );
		} );
		
		$("thead input").each( function (i) {
			asInitVals[i] = this.value;
		} );
		
		$("thead input").focus( function () {
			if ( this.className == "search_init" )
			{
				this.className = "";
				this.value = "";
			}
		} );
		
		$("thead input").blur( function (i) {
			if ( this.value == "" )
			{
				this.className = "search_init";
				this.value = asInitVals[$("thead input").index(this)];
			}
		} );

		jQuery('thead select').change( function() {
		select_val = jQuery(this).val();
			if (select_val == "All" || select_val == '') {
				oTable2.fnFilter("");
				oTable2.fnDraw();
			} else {
				oTable2.fnFilter(select_val);
			}
			jQuery('thead select').val(select_val);
		});

		
		/* Agrega el manejador del evento click en las filas */
       $('#tablaBecados').delegate('tr', 'click', function(event) {
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

} );


</script>
<script>
function confirmacionBoletin(idAlumno, colorBoletin)
{
	//if(colorBoletin == 'gray')
	//{
	//    jConfirm('Record� que para generar el bolet�n ten�s que contar con todas las notas, sino quedar� incompleto.'+ 
	//		 'Por lo tanto, si no ten�s el bolet�n en mano, no hagas click ac�', 'Confirmaci�n', function(result){
	//    if (result) 
	//	{
	//    	enviarForm('boletin', idAlumno);
	//    } 
	//    else 
	//	{
	//      return false;
	//    }
	//  });
	//}
	//else
	//{
		enviarForm('boletin', idAlumno);
	//}
}

</script>
<script type="text/javascript">
	function enviarForm(action, id){
		
		if(action=='lista'){
			document.forms['becadosForm'].action = "../entrevistas/listaEntrevistasView.do";
		}else if(action=='boletin'){
			document.forms['becadosForm'].action = "../entrevistas/registrarBoletinView.do";
			//document.forms['becadosForm'].action = action="<c:url value='../becadosPorEa/modificarDatosBoletin.jsp' />";
		}else if(action=='alta'){
		
			document.forms['becadosForm'].action = "../entrevistas/registrarEntrevistasView.do?tipo=m";
			
		}else if(action=='pagos'){
			document.forms['becadosForm'].action = "../entrevistas/listaPagosView.do";
		}else if(action=='altaIS2'){
			document.forms['becadosForm'].action = "../informeIS2/registrarInformeIS2.do";
		}else if(action=='verIS2'){
			document.forms['becadosForm'].action = "../informeIS2/verInformeIS2.do";
		}else if(action=='editarIS2'){
			document.forms['becadosForm'].action = "../informeIS2/verInformeIS2.do";
		}else if(action=='verIS1'){
			document.forms['becadosForm'].action = "../informeIS1/verInformeIS1.do";
		}else if(action=='editarIS1'){
			document.forms['becadosForm'].action = "../informeIS1/verInformeIS1.do";
		}else if(action=='cuentaRA'){
			document.forms['becadosForm'].action = "../entrevistas/listaDetalleRA.do";
		}else if(action=='verIS3'){
			document.forms['becadosForm'].action = "../informeIS3/verInformeIS3.do";
		}else if(action=='editarIS3'){
			document.forms['becadosForm'].action = "../informeIS3/verInformeIS3.do";
		}
		
		document.forms['becadosForm'].idAlumno.value = id;
		document.forms['becadosForm'].submit();
	}


	function validarGrupal(){
		document.forms['becadosForm'].submit();			
	}
	
</script>

<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.alerts.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/validador.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery-ui-1.8.5.custom.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.dataTables.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.ui.datepicker-es.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.validate.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.ui.tabs.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.ui.draggable.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.effects.core.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.ui.position.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.ui.widget.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/jquery.ui.accordion.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/table/jquery.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/table/jquery.dataTables.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/table/ColVis.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/table/tabletools/js/TableTools.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/table/tabletools/ZeroClipboard/ZeroClipboard.js"/>"></script>
<script type="text/javascript"
	src="<c:url  value="/static/js/table/tabletools/js/TableTools.min.js"/>"></script>
<link rel="stylesheet"
	href="<c:url  value="/static/css/styles.css"/>" media="all">
<link rel="stylesheet"
	href="<c:url  value="/static/css/table.css"/>"	media="all">
<link rel="stylesheet"
	href="<c:url  value="/static/css/jquery.ui.accordion.css"/>"	media="all">
<link rel="stylesheet"
	href="<c:url  value="/static/css/cimientos/jquery-ui-1.8.5.custom.css"/>" media="all">
<link rel="stylesheet"
	href="<c:url  value="/static/css/blitzer/jquery-ui-1.8.5.custom.css"/>"	media="all">
<link rel="stylesheet"
	href="<c:url  value="/static/css/ui-lightness/jquery-ui-1.8.5.custom.css"/>" media="all">
<link rel="stylesheet"
	href="<c:url  value="/static/css/ui-lightness/jquery.alerts.css"/>"	media="all">
<link rel="stylesheet"
	href="<c:url  value="/static/js/table/tabletools/css/TableTools.css"/>"	media="all">
	



</head>
<body>
<div id="main-content">
<form id="becadosForm" class="becadosForm" action="<c:url value='/entrevistas/registrarEntrevistaGrupalView.do' />" method="post">
	<br />
	<CENTER>
	<table align="center" >
	<tr align="center">
	<td style="vertical-align: middle;" align="center">
		<!-- Titulo de la Tabla -->
		<div class="ui-state-default ui-corner-all" align="center">
			<h3 align="center">Panel de Control EA</h3>
		</div>
		<!-- Fin titulo -->
		<table class="dataTables_wrapper" width="102px" border="0" id="tablaBecados" style="background-color: #C0C2FF" cellspacing="1"> 
	
			<thead align="center">
				<tr>
					<th></th>
					<th>Zona</th>
					<th>Alumno</th>
					<th>Foto</th>
					<th>DNI</th>
					<th>Escuela</th>
					<th>A�o Escolar</th>
					<th>Ent. Requeridas</th>
					<th>Pagos Recibidos</th>
					<th>Bolet&iacute;n</th>
					<th>Cantidad de Previas</th>
					<th>Cuenta RA</th>
					<!-- <th>Entrevista Mensual</th>  -->
					<th>Informe IS1</th>
					<th>Informe IS2</th>
					<th >Informe IS3</th>
				</tr>
				<tr>
					<c:forEach begin="0" end="4" var="loop">
						<td><input name="search_browser" value="Buscar" class="search_init"/></td>
					</c:forEach>
				</tr>
			</thead>
			<tbody align="center">
				<c:forEach items="${alumnos}" var="a">
					<tr>
						<td align="left" valign="middle" style="font-size: 14px">${a.idPerfilAlumno}</td>
						<td align="center" valign="middle" style="font-size: 14px">&nbsp;${a.zona}</td>
						<td align="center" valign="middle" style="font-size: 14px">&nbsp;${a.nombreApellido}</td>						
						<td align="center" valign="middle" style="font-size: 14px"><img src="../fichaAlumno/mostrarImagen.do?dni=${a.dni}" width="75px"></td> 					        						
						<td align="center" valign="middle" style="font-size: 14px">&nbsp;${a.dni}</td>			
						<td align="center" valign="middle" style="font-size: 14px">&nbsp;${a.escuela}</td>
						<td align="center" valign="middle" style="font-size: 14px">&nbsp;${a.anio.valor}</td>
						<td>
							<table border="0">
								<tr>
									<td>
										<img src="<c:url value='/static/images/iconos/${a.colorEntrevistas}_light.png'></c:url>" width="15px">
									</td>
									<td>									
										<div  style= width:0.5cm class="ui-state-default ui-corner-all" >
											<c:if test="${a.entrevistas != 0}">
												<a href="javascript:enviarForm('lista','${a.idPerfilAlumno}')">
													${a.entrevistasRealizadas}/${a.entrevistas}
												</a>
											</c:if>
											<c:if test="${a.entrevistas == 0}">
												${a.entrevistasRealizadas}/${a.entrevistas}												
											</c:if>												
										</div>									
									</td>
								</tr>
							</table>
						</td>
						
						<td>
							<table border="0">
								<tr>
									<td>
										<img src="<c:url value='/static/images/iconos/${a.colorPagos}_light.png'></c:url>" width="15px">
									</td>
									<td>
										<div  style= width:0.5cm class="ui-state-default ui-corner-all" > 
											<a href="javascript:enviarForm('pagos','${a.idPerfilAlumno}')" title="Ver Pagos" >${a.pagosRealizados}/${a.pagos}</a>			
										</div>
									</td>
								</tr>
							</table>
						</td>
						
						<td>
							<table border="0" width="70px">
								<tr>
									<td>
										<img src="<c:url value='/static/images/iconos/${a.colorBoletin}_light.png'></c:url>" width="15px">
									</td>
									<td>
										<div  style= width:0.5cm class="ui-state-default ui-corner-all" > 
											<a onclick="confirmacionBoletin('${a.idPerfilAlumno}','${a.colorBoletin}')" title="Ver Boletin">
												<span class="ui-icon ui-icon-note" ></span>
											</a>			
										</div>
									</td>
								</tr>
							</table>							
						</td>
						
						<td>
							<table border="0" width="70px">
								<tr>
									<td>
										<div  style= width:0.5cm class="ui-state-default ui-corner-all" > 
											${a.cantidadPrevias}		
										</div>
									</td>
								</tr>
							</table>							
						</td>
						
						<td>
							<table>
								<tr>
									<td>
										<img src="<c:url value='/static/images/iconos/${a.colorRA}_light.png'></c:url>" width="15px">
									</td>
									<td>
										<div  style= width:0.5cm class="ui-state-default ui-corner-all" >
											<a onclick="enviarForm('cuentaRA','${a.idPerfilAlumno}')" title="Cuenta Responsable Adulto"> 
												<span class="ui-icon ui-icon-zoomin" title="Cuenta Responsable Adulto"></span>
											</a>				
										</div>
									</td>
								</tr>
							</table>
						</td>
						<!-- Si vuelve a agregar , agregar la columna null
						<td>
							<table>
								<tr><td>
									<div  style= width:0.5cm class="ui-state-default ui-corner-all" > 
										<a  onclick="enviarForm('alta','${a.idPerfilAlumno}')" > 
											<span class="ui-icon ui-icon-plus" title="Alta Entrevista Mensual"> 
										</span></a>				
									</div>
								</td></tr>
							</table>
						</td>
						 -->
						
						<td>
							<table border="0" width="70px">
								<tr>
									<c:if test="${a.colorIS1 == 'red' || a.colorIS1 == 'gray'}">
										<td>
											<img src="<c:url value='/static/images/iconos/${a.colorIS1}_light.png'></c:url>" width="15px">
										</td>
									</c:if>
									<c:if test="${a.colorIS1 == 'green' || a.colorIS1 == 'yellow'}">
										<td>
											<img src="<c:url value='/static/images/iconos/${a.colorIS1}_light.png'></c:url>" width="15px">
										</td>
										<td>
											<div  style= width:0.5cm class="ui-state-default ui-corner-all" >
												<a onclick="enviarForm('verIS1','${a.idPerfilAlumno}')" title="Informe IS1"> 
													<span class="ui-icon ui-icon-zoomin" title="Ver Informe IS1"></span>
												</a>				
											</div>
										</td>
									</c:if>
	<%-- 							<c:if test="${a.colorIS1 == 'yellow'}">
										<td>
											<img src="<c:url value='/static/images/iconos/${a.colorIS1}_light.png'></c:url>" width="15px">
										</td>
										
										<td>
											<div  style= width:0.5cm class="ui-state-default ui-corner-all" >
												<a  onclick="enviarForm('editarIS1','${a.idPerfilAlumno}')" title="Informe IS1"> 
													<span class="ui-icon ui-icon-pencil" title="Editar Informe IS1"></span>
												</a>				
											</div>
										</td>
									</c:if> --%>
								</tr>
							</table>							
						</td>
						<td>
							<table border="0" width="70px">
								<tr>
									<c:if test="${a.colorIS2 == 'red'}">
										<td>
											<img src="<c:url value='/static/images/iconos/${a.colorIS2}_light.png'></c:url>" width="15px">
										</td>
										
<!--										<td>-->
<!--											<a  onclick="enviarForm('altaIS2','${a.idPerfilAlumno}')" title="Informe IS2">-->
<!--												<img src="<c:url value='/static/images/iconos/${a.colorIS2}_light.png'></c:url>" width="15px">-->
<!--											</a>-->
<!--										</td>-->
										<td>
											<div  style= width:0.5cm class="ui-state-default ui-corner-all" >
												<a  onclick="enviarForm('altaIS2','${a.idPerfilAlumno}')" title="Informe IS2"> 
													<span class="ui-icon ui-icon-plus" title="Alta Informe IS2"></span>
												</a>				
											</div>
										</td>
									</c:if>
									<c:if test="${a.colorIS2 == 'gray'}">
										<td align="center">
											<img src="<c:url value='/static/images/iconos/${a.colorIS2}_light.png'></c:url>" width="15px">
										</td>	
									</c:if>
									<c:if test="${a.colorIS2 == 'yellow'}">
										<td>
											<img src="<c:url value='/static/images/iconos/${a.colorIS2}_light.png'></c:url>" width="15px">
										</td>
										
										<td>
											<div  style= width:0.5cm class="ui-state-default ui-corner-all" >
												<a  onclick="enviarForm('editarIS2','${a.idPerfilAlumno}')" title="Informe IS2"> 
													<span class="ui-icon ui-icon-pencil" title="Editar Informe IS2"></span>
												</a>				
											</div>
										</td>
									</c:if>
									<c:if test="${a.colorIS2 == 'green'}">
										<td>
											<img src="<c:url value='/static/images/iconos/${a.colorIS2}_light.png'></c:url>" width="15px">
										</td>
										
										<td>
											<div  style= width:0.5cm class="ui-state-default ui-corner-all" >
												<a  onclick="enviarForm('editarIS2','${a.idPerfilAlumno}')" title="Informe IS2"> 
													<span class="ui-icon ui-icon-pencil" title="Editar Informe IS2"></span>
												</a>				
											</div>
										</td>
									</c:if>
								</tr>
							</table>							
						</td>
						<td>
							<table border="0" width="70px">
								<tr>
									<c:if test="${a.colorIS3 == 'red' || a.colorIS3 == 'gray'}">
										<td>
											<img src="<c:url value='/static/images/iconos/${a.colorIS3}_light.png'></c:url>" width="15px">
										</td>
									</c:if>
									<c:if test="${a.colorIS3 == 'yellow'}">
										<td>
											<img src="<c:url value='/static/images/iconos/${a.colorIS3}_light.png'></c:url>" width="15px">
										</td>
										
										<td>
											<div  style= width:0.5cm class="ui-state-default ui-corner-all" >
												<a  onclick="enviarForm('editarIS3','${a.idPerfilAlumno}')" title="Informe IS3"> 
													<span class="ui-icon ui-icon-pencil" title="Editar Informe IS3"></span>
												</a>				
											</div>
										</td>
									</c:if>
									<c:if test="${a.colorIS3 == 'green'}">
										<td>
											<img src="<c:url value='/static/images/iconos/${a.colorIS3}_light.png'></c:url>" width="15px">
										</td>
										
										<td>
											<div  style= width:0.5cm class="ui-state-default ui-corner-all" >
												<a  onclick="enviarForm('verIS3','${a.idPerfilAlumno}')" title="Informe IS3"> 
													<span class="ui-icon ui-icon-zoomin" title="Ver Informe IS3"></span>
												</a>				
											</div>
										</td>
									</c:if>
								</tr>
							</table>							
						</td>	
					</tr>
				</c:forEach>
			</tbody>
		</table>
	<div class="ui-state-default ui-corner-all" align="center">
	<table align="center">
	<tr>
		<td>
			<input type="submit" value="Alta Encuentro Grupal" class="ui-state-default ui-corner-all" />
		</td>
	</tr>
	</table>
	</div>

	</td>
	</tr>
	</table>
	</CENTER>	
	<input type="hidden" name="idAlumno" />
	<input type="hidden" id="alumnosSeleccionados" name="alumnosSeleccionados"/>
</form>
</div>
</body>
</html>