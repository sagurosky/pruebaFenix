<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"   %>
	<%@page import="org.cimientos.intranet.web.controller.Conexion"%>
<%@page import="org.cimientos.intranet.web.controller.Globales"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>..:: Cimientos ::.. </title>

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
	
	
<!-- <link rel="stylesheet" -->
<%-- 	href="<c:url  value="/static/css/styles.css"/>" media="all"> --%>

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
	
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"  -->
<!-- integrity="sha512-HsBosvgkFFj3OOkhTj/4Olf8P3ybq1zL2YXnKZXTuBvQ8kkJO4t7b86hpbE/ZsDG6/My8w/X1+BRgON4hKyXw=="  -->
<!-- crossorigin="anonymous" referrerpolicy="no-referrer" /> -->
	
	
	<script>
    $(document).ready(function() {
      // Ocultar el menú lateral al cargar la página
//       $('#menu-lateral').hide();
      
      // Manejar el clic en la pestaña para mostrar/ocultar el menú lateral
      $('#menu-toggle').click(function() {
        $('#menu-lateral').slideToggle();
//         $('#menu-lateral').animate({right: "+=100px"});
      });
    });
	
	</script>



<!-- DMS estilos para el nuevo sistema de navegacion -->
	<style>
			
			*{
		    padding: 0;
		    margin: 0;
		   
		}
		
		
		nav {
		    width: 100%;
		   /* display: flex;*/
 		    justify-content: space-between; 
 		    
/* 		    align-items: center; */
 		    background-color: #F2EFF3;  /*gris claro*/
/* 		    padding-left: 2vw; */
		    position: fixed;
		    z-index:101;
		    
		}
		
		
		
		
		.cont-ul {
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    
		    z-index:101;
		}
		
		li {
		    list-style: none;
		    cursor: pointer;
 		    padding: 1vw ;   
		    transition:  all .3s ease 0s;
		    border: 1px solid grey;
		    border-radius: 5px;
		    z-index:101;
		    font-size:15px;
		}
		
		li:hover {
		    background-color: #CDA1EC;/*violeta claro*/
		    z-index:101;
		}
		
		.primerNivel {
		    position: relative;
		   z-index:101;
		}
		
		.ul-second {
		    display: none;
		    position: absolute;
		    margin-top: 1vw;
		    z-index:101;
		}
		
		.ul-second > li {
		    width: 200px;
/* 		    height:20px; */
		    transform: translateX(-20px);
/* 		    border-bottom:solid 1px #fff ; */
		    text-align: center;
		    background-color: #F2EFF3;
		    z-index:101;
		}
		
		.ul-second > li:hover {
		    background-color: #CDA1EC;
		    z-index:101;
		}
		
		.primerNivel:hover > .ul-second {
		    display: block;
		   z-index:101;
		}
		
		.ul-third {
		    position: absolute;
		    transform: translateX(100%);
		    right: 0;
		    top: 40%;
		    display: none;
		    background-color: #F2EFF3;
		    z-index:101;
		}
		
		.ul-third > li {
		    padding: 1vw;
/* 		    border-bottom: solid 1px #fff; */
			z-index:101;
		}
		
		.segundoNivel:hover > .ul-third {
		    display: block;
		    z-index:101;
		}
		a {
            text-decoration: none;
            color: #8C4BBB;
            z-index:101;
        }
     
			
	</style>
</head>
<body>
	
	
	<!-- DMS adaptacion
	el menu desplegable funciona con el CSS definido arriba, de todos modos sobreescribo muchas propiedades
	para poder usar bootstrap en cada pagina individualmente sin que se vea afectado el menú
	
	 -->
	
	 <nav style=" color: #8C4BBB;">
        <div class="titulo">
            <jsp:include page="/WEB-INF/pages/includes/header.jsp"></jsp:include>
            <sec:authentication property="principal.authorities" />
        </div>
        <div class="barraLinks" style="align-items:center">
          
                <ul class="cont-ul"style="padding:0;margin:0">
                   
                   <!-- DMS signo de admiracion que estaba en menu.jsp -->
                    <li  style="font-family:Helvetica Neue; border: none">
                   		<div >
                   		<% Long cantidadCuentas=0L;	%>
						<sec:authorize access="hasRole('ADM') or hasRole('CPBE') or hasRole('SYS') or hasRole('ASIST') or hasRole('RR')">
		  					<sec:authorize access="hasRole('EA')">
				  				<%						
					  				//System.out.println(Globales.id);
				  					cantidadCuentas=0L;
									Connection cn = null;
								    CallableStatement cl = null;
								    ResultSet rs = null;
								    Long becados=0L;
								    Long totalBe=0L;
								    
									cn = null;
								   	cl = null;
								   	rs = null;
								   	String call = "{CALL SP_AlertaCuentasEA(?)}";
									cn = Conexion.getConexion();
								    cl = cn.prepareCall(call); 
								    cl.setLong(1, Globales.id);
								    rs = cl.executeQuery();
								    while (rs.next()) { 
								    	cantidadCuentas=cantidadCuentas+1;	    
								    }
								    Conexion.cerrarCall(cl);
								    Conexion.cerrarConexion(cn);							    
								%>		  		
				  			</sec:authorize>
				  			<sec:authorize access="hasRole('RR')">
				  				<%						
				  					//System.out.println(Globales.id);
				  					cantidadCuentas=0L;
									Connection cn = null;
								    CallableStatement cl = null;
								    ResultSet rs = null;
								    Long becados=0L;
								    Long totalBe=0L;
								    
									cn = null;
								   	cl = null;
								   	rs = null;
								   	String call = "{CALL SP_AlertaCuentasRR(?)}";
									cn = Conexion.getConexion();
								    cl = cn.prepareCall(call); 
								    cl.setLong(1, Globales.id);
								    rs = cl.executeQuery();
								    while (rs.next()) { 
								    	cantidadCuentas=cantidadCuentas+1;	    
								    }
								    Conexion.cerrarCall(cl);
								    Conexion.cerrarConexion(cn);						    
								%>  		
		  					</sec:authorize>
		  					<sec:authorize access="hasRole('ADM') or hasRole('SYS') or hasRole('ASIST')">
						<%	
							cantidadCuentas=0L;
							Connection cn = null;
						    CallableStatement cl = null;
						    ResultSet rs = null;
						    Long becados=0L;
						    Long totalBe=0L;
						    
							cn = null;
						   	cl = null;
						   	rs = null;
						   	String call = "{CALL SP_AlertaCuentas()}";
							cn = Conexion.getConexion();
						    cl = cn.prepareCall(call); 
						    //cl.setString(1, anio);
						    rs = cl.executeQuery();
						    while (rs.next()) { 
						    	cantidadCuentas=cantidadCuentas+1;	    
						    }
						    Conexion.cerrarCall(cl);
						    Conexion.cerrarConexion(cn);
						%>		
						</sec:authorize>
		  					
				  			
						</sec:authorize>
						<%if(cantidadCuentas>0){%>	
				  				<center>
				  				<a  href='<c:url value="/cuenta/verCreacionCuentas.do" />'>
				  				<img src="../static/images/atencion.gif" width=13 title="Hay becados con cuentas no solicitadas o en proceso por más de 15 días" style="border:none;">		
				  				</a>
				  				</center>
				  			<%} %>
			
			
			
			
						</div>
                    </li>
                   
                   
                   
                   
<!--             ##########################Envío de informes ##################################        -->
                   
                   
                    <li class="primerNivel" style="font-family:Helvetica Neue">
                        Envío de informes 
                        <ul class="ul-second" style="padding:0">
                            <li >
                                <a  href='<c:url value="/envioInformes/listaInformes.do" />'
                              	  style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                	Listado para el envío de informes a Padrinos Individuales
                                </a>
                            </li>                            
                            <li>
                                <a href='<c:url value="/envioInformes/listaInformesCorporativos.do" />' 
                               	 style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                	Listado para el envío de informes a Padrinos Corporativos
                                </a>
                            </li>
                        </ul>
                    </li>



<!--             ###########################Gestion de becas#################################        -->




                    <li class="primerNivel" style="font-family:Helvetica Neue">
                        Gestion de becas 
                        <ul class="ul-second" style="padding:0">
                            <li>
                           		<a href='<c:url value="/perfilPadrino/listaPadrinosView.do" />'
                           			style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                           			Padrinos
                           		</a>
                            </li>                            
                            <li>
                            	<a href='<c:url value="/empresa/listaEmpresasView.do" />' 
                            		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                            		Organizaciones
                            	</a>
                            </li>
                            <li>
                          		<a href='<c:url value="/beca/listaBecasView.do" />' 
                          			style=" text-decoration: none;color: #8C4BBB;z-index:101">
                          			Becas
                          		</a>
                            </li>
                            <li>
                            <a href='<c:url value="/becadosPorEa/reporteBecasDisponibles.jsp" />'
                          	  style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                            	Becas disponibles nuevo
                            </a>
                            </li>
                            <li>
                            <a href='<c:url value="/beca/listaClonarBecas.do" />'
                           	 style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                           	 Clonar beca
                           	</a>
                            </li>
                        </ul>
                    </li>



<!--             #############################Datos maestros###############################        -->




                    <li class="primerNivel" style="font-family:Helvetica Neue">
                        Datos maestros 
                        <ul class="ul-second" style="padding:0">
                             <li class="segundoNivel">
                                Gestión bancaria
                                <ul class="ul-third" style="padding:0">
                                    <li>
                                    	<a href='<c:url value="/sucursalBanco/listaSucursalBanco.do" />' 
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                    		Sucursales bancarias
                                    	</a>
                                    </li>
                                    <li>
                                  	  <a href='<c:url value="/banco/listaBancos.do" />' 
                                  	 	 style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                  	 	 Bancos</a>
                                    </li>
                                    
                                </ul>
                            </li>
                            <li class="segundoNivel">
                                Ubicacion
                                <ul class="ul-third" style="padding:0">
                                    <li >
                                 	 	 <a href='<c:url value="/zona/listaZonas.do" />' 
                                 	 	 	style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                 	 	 	Zonas cimientos
                                 	 	 </a>
                                    </li>
                                    <li>
                                   		 <a href='<c:url value="/provincia/listaProvincias.do" />'
                                   		 	style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                                   			 Provincias
                                   		 </a>
                                    </li>
                                    <li>
                                   		 <a href='<c:url value="/localidad/listaLocalidades.do" />' 
                                   			 style=" text-decoration: none;color: #8C4BBB;z-index:101"> 
                                   			 Localidades
                                   		 </a>
                                   </li>
                                </ul>
                            </li>
                            
                        </ul>
                    </li>




<!--             #############################Usuarios###############################        -->



                    <li class="primerNivel" style="font-family:Helvetica Neue">
                        Usuarios 
                        <ul class="ul-second" style="padding:0">
                            <li >
                            	<a href='<c:url value="/usuario/listaUsuarios.do" />' 
                            		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                            		Usuarios
                            	</a>
                            </li>
                            <li >
                           		<a href='<c:url value="/perfilStaff/listaPerfilStaff.do" />'
                           			style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                           			Staff cimientos
                           		</a>
                            </li>
                            <li >
                         		<a href='<c:url value="/usuario/cambioContrasenia.do" />'
                         			style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                         			Cambia tu contraseña
                         		</a>
                            </li>                     
                        </ul>
                    </li>





<!--             ##########################Administración#################################        -->



                    <li class="primerNivel" style="font-family:Helvetica Neue">
                        Administración 
                        <ul class="ul-second" style="padding:0">                            
                            <li class="segundoNivel">
                                Pago de becados
                                <ul class="ul-third" style="padding:0">
                                    <li>
                                    	<a href='<c:url value="/pago/verAprobadosNoAprobView.do" />'
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101" > 
                                    		Pagos pendientes
                                    	</a>
                                   </li>
                                    <li>
                                   		<a href='<c:url value="/pago/verPagosRealizadosView.do?idBanco=null" />'
                                   			style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                                   			Pagos anteriores
                                   		</a>
                                    </li>
                                    <li>
                               		    <a href='<c:url value="/pago/verlistaPagosView.do" />'
                               		 	   style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                               		   	 Listado general de pagos
                               		    </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="segundoNivel">
                                Cuentas
                                <ul class="ul-third" style="padding:0">
                                    <li>
                                    	<a href='<c:url value="/cuenta/verCreacionCuentas.do" />' 
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                    		Alta de cuentas
                                    	</a>
                                    </li>
                                    <li>
                                  		<a href='<c:url value="/cuenta/importarArchivoView.do" />' 
                                  			style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                  			Importar Archivo
                                  		</a>
                                    </li>
                                    <li>
                                  		<a href='<c:url value="/cuenta/cargarAltaCuentaView.do" />' 
                                  			style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                  			Carga manual de cuentas
                                  		</a>
                                    </li>
                                    <li>
                                    	<a href='<c:url value="/cuenta/verInformeCuentas.do?idBanco=null" />'
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                                    		Informe de cuentas
                                    	</a>
                                    </li>
                                    <li>
                                    	<a href='<c:url value="/cuenta/verCuentasInactivas.do?idBanco=null" />' 
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                    		Cuentas inactivas
                                    	</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </li>




<!--             ############################Asignaciones/Ciclos################################        -->




                    <li class="primerNivel" style="font-family:Helvetica Neue">
                        Asignaciones/Ciclos 
                        <ul class="ul-second" style="padding:0">
                            <li>
                            	<a href='<c:url value="/ciclo/listaCiclos.do" />' 
                            		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                            		Ciclos de programa
                            	</a>
                            </li>
                            <li class="segundoNivel">
                                Asignaciones
                                <ul class="ul-third" style="padding:0">
                                    <li>
                                    	<a href='<c:url value="/asignacionEaRr/asignacionEaRrView.do" />' 
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                    		Asignación de EAs
                                    	</a>
                                    </li>
                                    <li>
                                    	<a href='<c:url value="/reasignacionEaRr/reasignacionEaRrView.do" />'
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                                    		 Reasignación de EAs
                                    	 </a>
                                   </li>
                                    <li>
                                    	<a href='<c:url value="/asignacionBecadosEa/asignacionBecadosEaView.do" />' 
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                    		Asignar becados a EAs
                                    	</a>
                                    </li>
                                    <li>
                                    	<a href='<c:url value="/reasignacionBecadosEa/reasignacionBecadosEaView.do" />'
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                                    		Reasignar becados a EAs
                                    	</a>
                                    </li>
                                    <li>
                                    	<a href='<c:url value="/seleccionBecas/seleccionPeriodosBecasView.do" />' 
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                    		Asignación de becas
                                    	</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                            <a href='<c:url value="/textos/verTextosMailView.do" />'
                          	  style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                          	  Textos de Mail
                            </a>
                            </li>
                        </ul>
                    </li>





<!--             ###########################Selección#################################        -->





                    <li class="primerNivel" style="font-family:Helvetica Neue">
                        Selección 
                        <ul class="ul-second" style="padding:0">
                            <li>
                           		<a href='<c:url value="/panelControl/seleccionPanelControl.do" />'
                           			style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                           			Panel de control
                           		</a>
                           	</li>
                            <li class="segundoNivel">
                                Gestión escolar
                                <ul class="ul-third" style="padding:0">
                                    <li>
                                    	<a href='<c:url value="/escuela/viewSeleccionEscuelasBecas.do" />' 
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                    		Selección de escuelas
                                    	</a>
                                    </li>
                                    <li>
                                    	<a href='<c:url value="/escuela/listaEscuelas.do" />' 
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                    		Listado y alta de escuelas
                                    	</a>
                                    </li>                                    
                                </ul>
                            </li>
                            <li class="segundoNivel">
                                Selección
                                <ul class="ul-third" style="padding:0">
                                    <li>
                                    	<a href='<c:url value="/objetivoSeleccion/listaObjetivoSeleccionAnioActual.do" />' 
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                    		Administracion de objetivo selección
                                    	</a>
                                    </li>
                                    <li>
                                    	<a href='<c:url value="/objetivoSeleccion/listarObjetivoSeleccion.do" />'
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                                    		Reporte de objetivos selección
                                    	</a>
                                    </li>  
                                    <li>
                                    	<a href='<c:url value="/entrevistaSeleccion/entrevistaSeleccionView.do" />' 
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                    		Alta entrevista selección
                                    	</a>
                                    </li>   
                                    <li>
                                    	<a href='<c:url value="/entrevistaSeleccion/reporteEntrevistaSeleccion.do" />'
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                                    		Reporte entrevista selección
                                    	</a>
                                    </li>   
                                    <li>
                                    	<a href='<c:url value="/emitirCarta/listaAlumnosCarta.do" />' 
                                   		 	style=" text-decoration: none;color: #8C4BBB;z-index:101"> 
                                    		Emisión de cartas
                                    	</a>
                                   </li>   
                                    <li>
                                    	<a href='<c:url value="/convocado/listadoDeConvocados.do" />' 
                                   	 		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                    		Listado de candidatos
                                    	</a>
                                    </li>                                     
                                </ul>
                            </li>
                            <li class="segundoNivel">
                                Gestión de becas
                                <ul class="ul-third" style="padding:0">
                                    <li>
                                    	<a href='<c:url value="/reporteBecasDisponibles/reporteBecasDisponibles.do" />' 
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                    		 Becas disponibles
                                    	 </a>
                                   </li>
                                    <li>
                                    	<a href='<c:url value="/renovacionBecas/renovacionAutomaticaView.do" />'
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                                    		 Renovación automática
                                    	 </a>
                                   </li>  
                                    <li>
                                    	<a href='<c:url value="/renovacionBecas/renovacionBecasPasoIView.do" />'
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                                    		 Renovación - paso 1
                                    	 </a>
                                   </li>   
                                    <li>
                                    	<a href='<c:url value="/renovacionBecas/renovacionBecasPasoIIView.do" />'
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                                    		 Renovación - paso 2
                                    	 </a>
                                   </li>   
                                    <li>
                                    <a href='<c:url value="/seleccionBecas/seleccionPeriodosBecasView.do" />' 
                                  	  style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                   	 Asignación de becas
                                    </a>
                                    </li>   
                                    <li>
                                    	<a href='<c:url value="/reasignacionBecas/reasignacionBecasView.do" />' 
                                	    	style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                    		Reasignación de becas
                                    	</a>
                                    </li>                                     
                                </ul>
                            </li>
                            <li class="segundoNivel">
                                Gestión de informes
                                <ul class="ul-third" style="padding:0">
                                    <li>
                                    	<a href='<c:url value="/informeFP/listaInformesFPRevision.do" />' 
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                                    		Fichas de presentación a revisar
                                    	</a>
                                    </li>                                                              
                                </ul>
                            </li>
                            <li class="segundoNivel">
                                Convocatorias
                                <ul class="ul-third" style="padding:0">
                                    <li>
                                    	<a href='<c:url value="/reporteConvocatoria/reporteConvocatoria.do" />'
                                    		style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                                    		Reporte de convocatorias abiertas
                                    	</a>
                                    </li>                                               
                                </ul>
                            </li>
                        </ul>
                    </li>
                    
                    
                    
                    
                    
<!--             ########################Listados especiales ####################################        -->
                    
                    
                    
                    
                    
                    
                    <li class="primerNivel" style="font-family:Helvetica Neue">
                        Listados especiales 
                        <ul class="ul-second" style="padding:0">
                            <li>
                            	<a href='<c:url value="/exportacionEntrevistas/verExportarEntrevistas.do" />' 
                            		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                            		Listado de entrevistas
                            	</a>
                            </li>
                            <li>
                            	<a href='<c:url value="/reporteGeneralInformes/verReporteGeneralInformes.do" />' 
                            		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                            		Listado de informes
                            	</a>
                            </li>
                            <li>
                            	<a href='<c:url value="/exportarAlumnos/listaAlumnosExportar.do" />'
                            		style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                            		 Listado de Alumnos
                            	 </a>
                           </li>
                            <li>
                            	<a href='<c:url value="/alumnosInactivos/listaAlumnosInactivos.do" />' 
                            		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                            		Listado de alumnos inactivos
                            	</a>
                            </li>
                            <li>
                            	<a href='<c:url value="/becadosPorEa/listadoBecadosPorEa.jsp" />' 
                            		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                            		Listado de becados por EA
                            	</a>
                            </li>
                            <li>
                            	<a href='<c:url value="/becadosPorEa/pagoDeBecas.jsp" />' 
                            		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                            		Pago de becas
                            	</a>
                            </li>
                            <li>
                            	<a href='<c:url value="/becadosPorEa/postPFE.jsp" />' 
                            		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                            		Listado post PFE
                            	</a>
                            </li>
                            <li>
                            	<a href='<c:url value="/entrevistas/listarEntrevistasGrupales.do" />' 
                            		style=" text-decoration: none;color: #8C4BBB;z-index:101">
                            		Lisado encuentros grupales
                            	</a>
                            </li>
                            <li>
                            	<a href='<c:url value="/eventoGenerico/listaEventosGenericos.do" />'
                            		style=" text-decoration: none;color: #8C4BBB;z-index:101" >
                            		Listado eventos genéricos
                            	</a>
                            </li>                            
                        </ul>
                    </li>

                </ul>

        </div>    
    </nav>
	
	
	
	<!-- DMS fin adaptacion -->
	
	
	
	
		
		
		
		<br><br><br><br><br><br><br><br><br><br><br><br>
		<div class="row "  >

				
				
				
				<div class="col" style="background-color: #FFF; ">  <!-- DMS usarlo completo -->
					<div id="body"  style=" background-color: #FFF;">
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
						<jsp:include page="${body}"></jsp:include>
					</div>
				</div>
			</div>
			
			
			
			
			
	</table>
</body>
</html>