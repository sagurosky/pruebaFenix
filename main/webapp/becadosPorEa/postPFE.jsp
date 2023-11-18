<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"   %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"   %>
<%@page import="java.util.ArrayList"%>
<%@page import="org.cimientos.intranet.web.controller.Conexion"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>

        
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Post PFE</title>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css ">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.11/css/dataTables.jqueryui.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.3.1/css/buttons.dataTables.min.css">



<script src="https://code.jquery.com/jquery-1.12.3.min.js"></script>
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>	
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.11/js/dataTables.jqueryui.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/buttons.flash.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/pdfmake.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/vfs_fonts.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/buttons.html5.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/buttons.print.min.js"></script>


<style>
th { white-space: nowrap; }

body {
font-family: Arial, Verdana; 

}

thead, tfoot {
    display: table-header-group;
}
</style>

<script type="text/javascript">
$(document).ready(function() {  
	
    $('#tContabilidad tfoot th').each( function () {
        var title = $(this).text();
        $(this).html( '<input type="text" size=7 placeholder="Buscar" />' );
    } );
 
    // DataTable
   var table=$('#tContabilidad').DataTable( {
    	
	   "oLanguage": {
			"sLengthMenu": 'Mostrar <select>'+
			'<option value="10">10</option>' +
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
			"iDisplayLength": 10,
	    
	    dom: 'Blfrtip',
	    buttons: [
	              'copy', 
	              {
	                  extend: 'csv',
	                  text: 'csv',
	                  extension: '.csv',
	                  exportOptions: {
	                      modifier: {
	                          page: 'current'
	                      }
	                  },
	                  title: 'Reporte Post-PFE'
	              }, 
	               
	              'print',
	              {
	                  extend: 'excel',
	                  text: 'excel',
	                  extension: '.xlsx',
	                  exportOptions: {
	                      modifier: {
	                          page: 'current'
	                      }
	                  },
	                  title: 'Reporte Post-PFE'
	              }
	          ]
	    
	    
	    
        
     }); 
    // Apply the search
    table.columns().every( function () {
        var that = this;
        $( 'input', this.footer() ).on( 'keyup change', function () {
            if ( that.search() !== this.value ) {
                that
                    .search( this.value )
                    .draw();
            }
        } );
    } );
} );
</script>






<link rel="stylesheet"
	href="<c:url  value="/static/css/styles.css"/>" media="all">

</head>
<body>
<table  style="width: 100%; height: auto;" cellpadding="0" cellspacing="0">
<!-- DMS comento funcionalidad vieja y agrego el tempate que tiene el nuevo men� -->

<!-- 	<tr> -->
<!-- 		<td colspan="2"> -->
<%-- 			<jsp:include page="/WEB-INF/pages/includes/header.jsp"></jsp:include> --%>
<!-- 		</td> -->
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td colspan="2"> -->
<%-- 			<jsp:include page="/WEB-INF/pages/includes/menu.jsp"></jsp:include> --%>
<!-- 		</td> -->
<!-- 	</tr> -->
	<tr>
		<td colspan="2">
			<jsp:include page="/WEB-INF/pages/includes/TemplateAlternativo.jsp"></jsp:include>
		</td>
	</tr>
	<tr>
		<td valign="top" style="width: 200px; height: 500px; background-color: #7C7C7C;" >
<%-- 			<jsp:include page="${menu}"></jsp:include> --%>
		</td>
			<td style="background-color: #FFF; vertical-align: top;">
				<div id="body" style="background-color: #FFF; vertical-align: top;">
					<c:if test="${error != null || mensaje != null}">
						<div id="mensaje-content">
							<table id="mensaje" >
								<tr >
									<td>
										<jsp:include page="/WEB-INF/pages/includes/mensajes.jsp"></jsp:include>
									</td>
								</tr>
							</table>
						</div>
					</c:if>




<% 	String ciclo=request.getParameter("ciclo"); 
	String nombreCiclo="";
	
	if(ciclo==null){
		ciclo="33";
		nombreCiclo="2022";
	}else{
	
		if(ciclo.equals("29")){
			nombreCiclo="2018";
		}
		if(ciclo.equals("30")){
			nombreCiclo="2019";
		}
		if(ciclo.equals("31")){
			nombreCiclo="2020";					
		}
		if(ciclo.equals("32")){
			nombreCiclo="2021";					
		}
		if(ciclo.equals("33")){
			nombreCiclo="2022";					
		}
		if(ciclo.equals("34")){
			nombreCiclo="2023";					
		}

	}	
// 	System.out.println("id ciclo:" + ciclo);
// 	System.out.println("nombre ciclo: " + nombreCiclo);
	
	
%>

	<form id="frmReportes" method="post" action="postPFE.jsp">	
		<h1 style="background-color:#7FC2D8;font-size: 25px;">LISTADO POST PFE <%=nombreCiclo %> - 
		<select id="ciclo" name="ciclo">
			<option value="0">Seleccion� el Ciclo</option>
			<option value="33" selected="selected">2022</option>
			<option value="32">2021</option>
			<option value="31">2020</option>
			<option value="30">2019</option>
			<option value="29">2018</option>		
		</select>
		
		<input type="submit"  id="generar" name="generar" class="classnameboton" value="Buscar" >		
		</h1>
	</form>
	<br><br>
<table id="tContabilidad" class="display" cellspacing="0" width="100%">
	<thead>
		<tr>								
			<th>Id</th>
         	<th>BECADO</th>
			<th>DNI</th>
			<th>ZONA</th>
			
			<th>LOCALIDAD</th>
			<th>PROVINCIA</th>
			
			<th>ESCUELA</th>			
			<th>SITUACION<br>ESCOLAR</th>
			<th>ESTADO ACTUAL</th>
			<th>ULTIMA<br>ACTUALIZACION</th>
			<th>BOLETIN</th>
			<th>ESTADO<br>PAGO</th>
			<th>PERIODO<br>EGRESO</th>
			<th>MAT.<br>APROBADAS</th>
			<th>MAT.<br>DESAPROBADAS</th>
			<th>MATERIAS<br>NO SE PRESENTO</th>
			<th>MATERIAS<br>NO HUBO MESA</th>
			<th>MATERIAS<br>QUE ADEUDA</th>
			<th>NOMBRE MATERIA<br>QUE ADEUDA</th>
			<th>ENCUENTRO<br>INDIVIDUAL</th>
			<th>ENDUENTRO<br>GRUPAL</th>
			<th>ENCUENTRO<br>DUPLA</th>
			<th>CONTACTO<br>TELEFONICO</th>
			<th>OTRO<br>ENCUENTRO</th>
			<th>DESCRIPCION<br>Y EVALUACION</th>
			<th>CLASES DE<br>APOYO ESCOLAR</th>
			<th>PLAN DE<br>ACCION</th>
			<th>OBSERVACIONES<br>OFICINA</th>
			<th>EA</th>
			<th>RR</th>
			<th>PADRINO</th>
			
		</tr>
	</thead>
	<tfoot>
         <tr>
         	<th>Id</th>	
         	<th>BECADO</th>
			<th>DNI</th>
			<th>ZONA</th>
			
			<th>LOCALIDAD</th>
			<th>PROVINCIA</th>
			
			<th>ESCUELA</th>			
			<th>SITUACION<br>ESCOLAR</th>
			<th>ESTADO ACTUAL</th>
			<th>ULTIMA<br>ACTUALIZACION</th>
			<th>BOLETIN</th>
			<th>ESTADO<br>PAGO</th>
			<th>PERIODO<br>EGRESO</th>
			<th>MAT.<br>APROBADAS</th>
			<th>MAT.<br>DESAPROBADAS</th>
			<th>MATERIAS<br>NO SE PRESENTO</th>
			<th>MATERIAS<br>NO HUBO MESA</th>
			<th>MATERIAS<br>QUE ADEUDA</th>
			<th>NOMBRE MATERIA<br>QUE ADEUDA</th>
			<th>ENCUENTRO<br>INDIVIDUAL</th>
			<th>ENDUENTRO<br>GRUPAL</th>
			<th>ENCUENTRO<br>DUPLA</th>
			<th>CONTACTO<br>TELEFONICO</th>
			<th>OTRO<br>ENCUENTRO</th>
			<th>DESCRIPCION<br>Y EVALUACION</th>
			<th>CLASES DE<br>APOYO ESCOLAR</th>
			<th>PLAN DE<br>ACCION</th>
			<th>OBSERVACIONES<br>OFICINA</th>
			<th>EA</th>
			<th>RR</th>
			<th>PADRINO</th>
		 </tr>
     </tfoot>
	<tbody>	
	<% 
	
   	Connection cn = null;
    CallableStatement cl = null;
    ResultSet rs = null;
   
    Long becados=0L;
    Long totalBe=0L;
	String situacionEscolarPA="";
    
	cn = null;
   	cl = null;
   	rs = null;
   	String call="";
   	
   		//System.out.println("1");
		if(ciclo==null || ciclo.equals("0")){
			call = "SELECT * FROM perfil_alumno,persona, estado_alumno,escuela,zona_cimientos,entrevista, ciclo_programa, periodo, evaluacion_renovacion_final, situacion_escolar, localidad, provincia, perfilrr, perfilea where perfil_alumno.id=persona.perfil_alumno and perfil_alumno.estado_alumno=estado_alumno.id_estado and perfil_alumno.escuela=escuela.id and escuela.zona_cimientos_id=zona_cimientos.id and entrevista.perfil_alumno=perfil_alumno.id and entrevista.periodo_de_pago=375 and entrevista.evaluacion_renovacion_final=3 and periodo.id=entrevista.periodo_de_pago and ciclo_programa.id=periodo.ciclo_id and evaluacion_renovacion_final.codigo=entrevista.evaluacion_renovacion_final and  situacion_escolar.codigo=entrevista.situacion_escolar_mergeada and ciclo_programa.id=0";	
		}else{	
			if(ciclo.equals("29")){
				call = "SELECT * FROM perfil_alumno,persona, estado_alumno,escuela,zona_cimientos,entrevista, ciclo_programa, periodo, evaluacion_renovacion_final, situacion_escolar, localidad, provincia, perfilrr, perfilea where perfil_alumno.id=persona.perfil_alumno and perfil_alumno.estado_alumno=estado_alumno.id_estado and perfil_alumno.escuela=escuela.id and escuela.zona_cimientos_id=zona_cimientos.id and entrevista.perfil_alumno=perfil_alumno.id and entrevista.periodo_de_pago=345 and entrevista.evaluacion_renovacion_final=3 and periodo.id=entrevista.periodo_de_pago and ciclo_programa.id=periodo.ciclo_id and evaluacion_renovacion_final.codigo=entrevista.evaluacion_renovacion_final and  situacion_escolar.codigo=entrevista.situacion_escolar_mergeada AND zona_cimientos.id=localidad.zona AND localidad.provincia=provincia.id AND perfilea.rr_id_perfil=perfilrr.id_perfilrr AND perfil_alumno.perfil_ea_id=perfilea.id_perfilea and ciclo_programa.id="+ciclo;	
			}			
			if(ciclo.equals("30")){
				call = "SELECT * FROM perfil_alumno,persona, estado_alumno,escuela,zona_cimientos,entrevista, ciclo_programa, periodo, evaluacion_renovacion_final, situacion_escolar, localidad, provincia, perfilrr, perfilea where perfil_alumno.id=persona.perfil_alumno and perfil_alumno.estado_alumno=estado_alumno.id_estado and perfil_alumno.escuela=escuela.id and escuela.zona_cimientos_id=zona_cimientos.id and entrevista.perfil_alumno=perfil_alumno.id and entrevista.periodo_de_pago=355 and entrevista.evaluacion_renovacion_final=3 and periodo.id=entrevista.periodo_de_pago and ciclo_programa.id=periodo.ciclo_id and evaluacion_renovacion_final.codigo=entrevista.evaluacion_renovacion_final and  situacion_escolar.codigo=entrevista.situacion_escolar_mergeada AND zona_cimientos.id=localidad.zona AND localidad.provincia=provincia.id AND perfilea.rr_id_perfil=perfilrr.id_perfilrr AND perfil_alumno.perfil_ea_id=perfilea.id_perfilea and ciclo_programa.id="+ciclo;	
			}		
			if(ciclo.equals("31")){
				call = "SELECT * FROM perfil_alumno,persona, estado_alumno,escuela,zona_cimientos,entrevista, ciclo_programa, periodo, evaluacion_renovacion_final, situacion_escolar, localidad, provincia, perfilrr, perfilea where perfil_alumno.id=persona.perfil_alumno and perfil_alumno.estado_alumno=estado_alumno.id_estado and perfil_alumno.escuela=escuela.id and escuela.zona_cimientos_id=zona_cimientos.id and entrevista.perfil_alumno=perfil_alumno.id and entrevista.periodo_de_pago=365 and entrevista.evaluacion_renovacion_final=3 and periodo.id=entrevista.periodo_de_pago and ciclo_programa.id=periodo.ciclo_id and evaluacion_renovacion_final.codigo=entrevista.evaluacion_renovacion_final and  situacion_escolar.codigo=entrevista.situacion_escolar_mergeada AND zona_cimientos.id=localidad.zona AND localidad.provincia=provincia.id AND perfilea.rr_id_perfil=perfilrr.id_perfilrr AND perfil_alumno.perfil_ea_id=perfilea.id_perfilea and ciclo_programa.id="+ciclo;	
			}
			if(ciclo.equals("32")){
				call = "SELECT * FROM perfil_alumno,persona, estado_alumno,escuela,zona_cimientos,entrevista, ciclo_programa, periodo, evaluacion_renovacion_final, situacion_escolar, localidad, provincia, perfilrr, perfilea where perfil_alumno.id=persona.perfil_alumno and perfil_alumno.estado_alumno=estado_alumno.id_estado and perfil_alumno.escuela=escuela.id and escuela.zona_cimientos_id=zona_cimientos.id and entrevista.perfil_alumno=perfil_alumno.id and entrevista.periodo_de_pago=375 and entrevista.evaluacion_renovacion_final=3 and periodo.id=entrevista.periodo_de_pago and ciclo_programa.id=periodo.ciclo_id and evaluacion_renovacion_final.codigo=entrevista.evaluacion_renovacion_final and  situacion_escolar.codigo=entrevista.situacion_escolar_mergeada AND zona_cimientos.id=localidad.zona AND localidad.provincia=provincia.id AND perfilea.rr_id_perfil=perfilrr.id_perfilrr AND perfil_alumno.perfil_ea_id=perfilea.id_perfilea and ciclo_programa.id="+ciclo;	
			}
			if(ciclo.equals("33")){
				call = "SELECT * FROM perfil_alumno,persona, estado_alumno,escuela,zona_cimientos,entrevista, ciclo_programa, periodo, evaluacion_renovacion_final, situacion_escolar, localidad, provincia, perfilrr, perfilea where perfil_alumno.id=persona.perfil_alumno and perfil_alumno.estado_alumno=estado_alumno.id_estado and perfil_alumno.escuela=escuela.id and escuela.zona_cimientos_id=zona_cimientos.id and entrevista.perfil_alumno=perfil_alumno.id and entrevista.periodo_de_pago=385 and entrevista.evaluacion_renovacion_final=3 and periodo.id=entrevista.periodo_de_pago and ciclo_programa.id=periodo.ciclo_id and evaluacion_renovacion_final.codigo=entrevista.evaluacion_renovacion_final and  situacion_escolar.codigo=entrevista.situacion_escolar_mergeada AND zona_cimientos.id=localidad.zona AND localidad.provincia=provincia.id AND perfilea.rr_id_perfil=perfilrr.id_perfilrr AND perfil_alumno.perfil_ea_id=perfilea.id_perfilea and ciclo_programa.id="+ciclo;	
			}		
		}
		//System.out.println("2");	
	cn = Conexion.getConexion();
    cl = cn.prepareCall(call); 
    
    rs = cl.executeQuery();
    
    
    
    while (rs.next()) {
//     	System.out.println("perfil_alumno.id: " + rs.getString("perfil_alumno.id"));
// 	System.out.println("perfil_alumno.id: " + rs.getString("persona.apellido"));
// 	System.out.println("Situacion escolar: " + rs.getString("perfil_alumno.situacion_escolar"));
	
	String archivo="http://fenix.cimientos.org/boletinesPostPFE/"+rs.getString("perfil_alumno.boletin_post_pfe");
    	if (rs.getString("perfil_alumno.situacion_escolar").equals("0")){situacionEscolarPA="Promovido sin adeudar materias";}
		if (rs.getString("perfil_alumno.situacion_escolar").equals("1")){situacionEscolarPA="Pendiente";}
		if (rs.getString("perfil_alumno.situacion_escolar").equals("2")){situacionEscolarPA="Egreso Pendiente";}
		if (rs.getString("perfil_alumno.situacion_escolar").equals("3")){situacionEscolarPA="Egreso Efectivo";}
		if (rs.getString("perfil_alumno.situacion_escolar").equals("4")){situacionEscolarPA="Promovido con materias a rendir";}
		if (rs.getString("perfil_alumno.situacion_escolar").equals("10")){situacionEscolarPA="Egreso Pendiente";}		
    %>
    <tr>
    	<td><a href="detallePostPFE.jsp?id=<%= rs.getString("perfil_alumno.id") %>&ciclo=<%=ciclo %>" ><%= rs.getString("perfil_alumno.id") %></a></td>
    	<td><%= rs.getString("persona.apellido")+ " "+ rs.getString("persona.nombre") %></td>
    	<td><%= rs.getString("persona.dni") %></td>    	
    	<td><%= rs.getString("zona_cimientos.nombre") %></td>
    	
    	
    	<td><%= rs.getString("localidad.nombre") %></td>
    	<td><%= rs.getString("provincia.descripcion") %></td>
    	
    	
    	<td><%= rs.getString("escuela.nombre") %></td>
    	
    	<td><%= rs.getString("situacion_escolar.nombre") %></td>
		<td><%= situacionEscolarPA %></td>
		<td>
			<% if(rs.getString("ultima_actualizacion")!=null){%>
				<%=rs.getString("ultima_actualizacion").substring(0,10) %>
				</td>
			<%}else{%>
					</td>
			<%}%>
    	<td><a href="<%=archivo%>" target="_blank"><img src="<%=archivo%>" width="50"></a></td>
		<% if(rs.getString("aprobar_pago")==null && rs.getString("revertir_pago")==null){%>
			<td></td>
		<%}else{%>			
				<% if(rs.getString("aprobar_pago").equals("si") && rs.getString("revertir_pago").equals("no")){%>
					<td><font color="green"><strong>Aprobado</strong></font></td>
				<%}%>	
				<% if(rs.getString("aprobar_pago").equals("si") && rs.getString("revertir_pago").equals("si")){%>
					<td><font color="blue"><strong>Finalizado</strong></font></td>
				<%}%>			
				<% if(rs.getString("aprobar_pago").equals("no")){%>
					<td></td>
				<%}%>			
		<%}%>			
		<%
			String ok="";
			Connection cn2 = null;
			CallableStatement cl2 = null;
			ResultSet rs2 = null;
			cn2 = null;
			cl2 = null;
			rs2 = null;
			String call2 ="SELECT * FROM post_pfe where idBecado="+rs.getString("perfil_alumno.id");
			cn2 = Conexion.getConexion();
			cl2 = cn2.prepareCall(call2); 
			rs2 = cl2.executeQuery();
			while (rs2.next()) {
				ok="si";
// 				System.out.println("perfil_alumno.id: " + rs.getString("perfil_alumno.id"));
			%>
				<td><%= rs2.getString("periodo") + " " +rs2.getString("ciclo")  %></td>
				<td><%= rs2.getString("qma") %></td>
				<td><%= rs2.getString("qmd") %></td>
				<td><%= rs2.getString("qmqnsp") %></td>
				<td><%= rs2.getString("qmqnhm") %></td>
				<td><%= rs2.getString("qmqa") %></td>
				<td><%= rs2.getString("materias_adeuda") %></td>
				<td><%= rs2.getString("individual") %></td>
				<td><%= rs2.getString("grupal") %></td>
				<td><%= rs2.getString("dupla") %></td>
				<td><%= rs2.getString("telefonico") %></td>
				<td><%= rs2.getString("otro") %></td>
				<td><%= rs2.getString("evaluacion") %></td>
				<td><%= rs2.getString("apoyo_escolar") %></td>
				<td><%= rs2.getString("plan_accion") %></td>
				<td><%= rs2.getString("observaciones_oficina") %></td>
			<%} 
				if(ok.equals("")){								
				%>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					
				<%} 
					Conexion.cerrarCall(cl2);
					Conexion.cerrarConexion(cn2);
					//EA
					
					Connection cn3 = null;
					CallableStatement cl3 = null;
					ResultSet rs3 = null;
					cn3 = null;
					cl3 = null;
					rs3 = null;
					String call3 ="select * from persona,perfilea where persona.perfilea="+rs.getString("perfil_alumno.perfil_ea_id")+" and perfilea.id_perfilea="+rs.getString("perfil_alumno.perfil_ea_id");
					cn3 = Conexion.getConexion();
					cl3 = cn3.prepareCall(call3); 
					rs3 = cl3.executeQuery();
					
					String idRr=null;
				    
					while (rs3.next()) {
					%>
						<td><%= rs3.getString("apellido") + " " +rs3.getString("nombre")  %>
							<%  idRr=rs3.getString("rr_id_perfil");%>
						</td>
					<%
					
					}
					
					Conexion.cerrarCall(cl3);
					Conexion.cerrarConexion(cn3);	
					System.out.println("idrr id: "+idRr);
						Connection cn4=Conexion.getConexion();
						String call4="select * from persona,perfilrr where perfilrr.datos_personales=persona.id and perfilrr.id_perfilrr="+idRr;
						CallableStatement cl4 = cn4.prepareCall(call4); 
					    ResultSet rs4 = cl4.executeQuery();
					   
					    while (rs4.next()) {		
							%>
								<td><%= rs4.getString("apellido") + " " +rs4.getString("nombre")  %></td>
							<%}
						Conexion.cerrarCall(cl4);
						Conexion.cerrarConexion(cn4);	

						
// 						System.out.println("beca id: "+rs.getString("beca_id"));
						Connection cn5=Conexion.getConexion();
						String call5="select * from persona,beca, perfil_padrino where beca.id="+rs.getString("beca_id")+" and perfil_padrino.id=beca.padrino and perfil_padrino.datos_personales=persona.id";
						CallableStatement cl5 = cn5.prepareCall(call5); 
					    ResultSet rs5 = cl5.executeQuery();
					    while (rs5.next()) {
					    	System.out.println(":::::: "+rs5.getString("apellido"));
							%>
								<td><%= rs5.getString("apellido") + " " +rs5.getString("nombre")  %></td>
							<%}
						Conexion.cerrarCall(cl5);
						Conexion.cerrarConexion(cn5);
					
					    
					%>
				
    </tr>
    	  		
	<%} 
		Conexion.cerrarCall(cl);
        Conexion.cerrarConexion(cn);%>
	</tbody>
	</table>
	
	</div>
</td>
</tr>

</table>
 
</body>
</html>