package org.cimientos.intranet.utils.entrevistas;


import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
//import org.cimientos.intranet.dto.EntrevistaSeleccionDTO;
//import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaFinal;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaIndividual;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaReIncorporacion;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaRenovacion;
//import org.cimientos.intranet.servicio.CicloProgramaSrv;
//import org.cimientos.intranet.servicio.EntrevistaSrv;
import org.cimientos.intranet.utils.ExportacionEspecialHelper;
import org.cimientos.intranet.utils.Formateador;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.cimientos.intranet.dto.ReporteEntrevistaSeleccionDTO2;
import com.cimientos.intranet.enumerativos.entrevista.ContenidosAbordados;
import com.cimientos.intranet.enumerativos.entrevista.DetalleGastos;
import com.cimientos.intranet.enumerativos.entrevista.EstrategiaComplementaria;
//import com.cimientos.intranet.enumerativos.entrevista.EvaluacionCobroBeca;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionIncorporacion;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionRenovacionFinal;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionRenovacionMergeada;
//import com.cimientos.intranet.enumerativos.entrevista.MotivoAusencia;
import com.cimientos.intranet.enumerativos.entrevista.EventoGenericoDTO;
import com.cimientos.intranet.enumerativos.entrevista.MotivoIncorporacionPendiente;
import com.cimientos.intranet.enumerativos.entrevista.MotivoPendiente;
import com.cimientos.intranet.enumerativos.entrevista.PropositoAnioComienza;
import com.cimientos.intranet.enumerativos.entrevista.SituacionCrisis;
//import com.cimientos.intranet.enumerativos.entrevista.TipoContacto;
import com.cimientos.intranet.enumerativos.entrevista.TipoEntrevista;
import com.cimientos.intranet.enumerativos.entrevista.motivoNoIncorporacion;
//import com.sun.org.apache.xpath.internal.operations.Equals;

import org.cimientos.intranet.web.controller.Conexion;

import java.sql.CallableStatement;
import java.sql.Connection;
//import java.sql.ResultSet;
import java.sql.SQLException;
//import java.sql.Types;

public class EventoGenericoExcelViewRR extends AbstractExcelView{
	
	private static int bachSize = 1000;
	private static final String PATRON_FECHA = "dd/MM/yyyy";
	private static final String NO_APLICA = "No aplica";
	private static final String SI = "Si";
	private static final String NO = "No";

	
	//@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String,Object> model, HSSFWorkbook workbook,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		

		
		ExportacionEspecialHelper exportacionHelper = (ExportacionEspecialHelper) model.get("exportacionHelper");
		
		HSSFSheet sheet = workbook.getSheet("evento_generico");
		
		Long idevento=null;
		idevento=(Long) model.get("idEvento");

		//int inicial = 0;
		
		List<EventoGenericoDTO> eventoGenerico = null;
		
		int rowNum = 1;
		int parcial = 0;
		int totalRows=1000;
		HSSFRow row;
		
	
		eventoGenerico=obtenerEvento(idevento);
		    
	    
		while (parcial < totalRows) {
			parcial = parcial + bachSize;
		    for (EventoGenericoDTO e : eventoGenerico) {
		    
		    	row = sheet.createRow(rowNum++);
				crearFila(e, exportacionHelper, row);
		    	
		    }
		}
	}
	

	public static synchronized ArrayList<EventoGenericoDTO> obtenerEvento(Long idevento) {
 
		////System.out.println(idevento);
		
		//El array que contendra todos nuestras Entrevistas de Seleccion
		ArrayList<EventoGenericoDTO> lista = new ArrayList<EventoGenericoDTO>();
	
        Connection cn = null;
        CallableStatement cl = null;
        ResultSet rs = null;
        String call=null;
        int vueltas=0;
        try {
        		// traigo el evento generico           	
        		//Nombre del procedimiento almacenado
               // if (idevento>10000){
               // 	call = "{CALL SP_EventoGenerico1(?)}";
               // }else{
                	call = "{CALL SP_EventoGenericoRR1T(?)}";
               // }
        		
        		
                cn = Conexion.getConexion();
                cl = cn.prepareCall(call);
                cl.setLong(1, idevento);
                //La sentencia lo almacenamos en un resulset
                rs = cl.executeQuery();
                //Consultamos si hay datos para recorrerlo
                //e insertarlo en nuestro array
                //La sentencia lo almacenamos en un resulset
                rs = cl.executeQuery();
	            //Consultamos si hay datos para recorrerlo
	            //e insertarlo en nuestro array
	            String ea="";
                while (rs.next()) {
	    	    	ea="";
                	EventoGenericoDTO eg = new EventoGenericoDTO();
	    	    	eg.setId(rs.getString(1));
	    	    	eg.setLugarEvento(rs.getString(2));
	    	    	eg.setRr(rs.getString(3));
	    	    	eg.setTipoEvento(rs.getString(4));
	    	    	eg.setFechaCarga(rs.getString(5));
	    	    	eg.setZona(rs.getString(6));
	    	    	eg.setFechaEvento(rs.getString(7));
	    	    	eg.setObservaciones(rs.getString(8));
	    	    	eg.setOtroContenido(rs.getString(9));
	    	    	////System.out.println(rs.getString(9));
	    	    	////System.out.println(eg.getOtroContenido());
	    	    	
	    	    ////System.out.println(rs.getString(9));
	    	    	////System.out.println(eg.getOtroContenido());
	    	    	eg.setEvaluacion(rs.getString(10));	    	    	
	    	    	ea=rs.getString(11);
	    	    	
	    	    	if(rs.getString(12)!=null){
	    	    		eg.setOp1("Si");
	    	    	}else{
	    	    		eg.setOp1("");
	    	    	}
	    	    	if(rs.getString(13)!=null){
	    	    		eg.setOp2("Si");
	    	    	}else{
	    	    		eg.setOp2("");
	    	    	}
	    	    	if(rs.getString(14)!=null){
	    	    		eg.setOp3("Si");
	    	    	}else{
	    	    		eg.setOp3("");
	    	    	}
	    	    	if(rs.getString(15)!=null){
	    	    		eg.setOp4("Si");
	    	    	}else{
	    	    		eg.setOp4("");
	    	    	}
	    	    	if(rs.getString(16)!=null){
	    	    		eg.setOp5("Si");
	    	    	}else{
	    	    		eg.setOp5("");
	    	    	}
	    	    	if(rs.getString(17)!=null){
	    	    		eg.setOp6("Si");
	    	    	}else{
	    	    		eg.setOp6("");
	    	    	}
	    	    	if(rs.getString(18)!=null){
	    	    		eg.setOp(rs.getString(18));
	    	    	}else{
	    	    		eg.setOp("");
	    	    	}
	    	    	eg.setEvaluacion(rs.getString(10));
	    	    	ea=rs.getString(11);
	    	    	// busco ea 
	                
	    	    	Connection cn01 = null;
	                CallableStatement cl01 = null;
	                ResultSet rs01 = null;
	                try {
	                    //Nombre del procedimiento almacenado
	                    String call01 = "{CALL SP_EventoGenericoTraerEA(?)}";
	                    cn01 = Conexion.getConexion();
	                    cl01 = cn01.prepareCall(call01);
	                    //cl0.setLong(1, idevento);
	                    cl01.setString(1,ea);
	                    //La sentencia lo almacenamos en un resulset
	                    rs01 = cl01.executeQuery();
	                    //Consultamos si hay datos para recorrerlo
	                    //e insertarlo en nuestro array
	                    String bucleContenidos;
	                    bucleContenidos="";
	                    
	                    while (rs01.next()) {
	                    	
	                    	eg.setEa(rs01.getString(1));
	                    	                   	
	                    	
	                    }

	                    Conexion.cerrarCall(cl01);
	                    Conexion.cerrarConexion(cn01);
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                    Conexion.cerrarCall(cl01);
	                    Conexion.cerrarConexion(cn01);
	                } catch (Exception e) {
	                    e.printStackTrace();
	                    Conexion.cerrarCall(cl01);
	                    Conexion.cerrarConexion(cn01);
	                }
	    	    	
	    	    	// busco contenidos abordados
	                //String DNI=resDTO.getNroDNI();
	                Connection cn0 = null;
	                CallableStatement cl0 = null;
	                ResultSet rs0 = null;
	                try {
	                    //Nombre del procedimiento almacenado
	                    String call0 = "{CALL SP_EventoGenerico2(?)}";
	                    cn0 = Conexion.getConexion();
	                    cl0 = cn0.prepareCall(call0);
	                    //cl0.setLong(1, idevento);
	                    cl0.setString(1,eg.getId());
	                    //La sentencia lo almacenamos en un resulset
	                    rs0 = cl0.executeQuery();
	                    //Consultamos si hay datos para recorrerlo
	                    //e insertarlo en nuestro array
	                    String bucleContenidos;
	                    bucleContenidos="";
	                    String contenidoBBDD="";
	                    while (rs0.next()) {
	                    	if (rs0.getString(1).equals("0")){
	                    		contenidoBBDD="Alumno: Planificaci�n del estudio";
	                    	}
	                    	if (rs0.getString(1).equals("1")){
	                    		contenidoBBDD="Alumno: Estrategias de aprendizaje";
	                    	}
	                    	if (rs0.getString(1).equals("2")){
	                    		contenidoBBDD="Alumno: Criterios de permanencia PBE";
	                    	}
	                    	if (rs0.getString(1).equals("3")){
	                    		contenidoBBDD="Alumno: Planificaci�n Proyecto de Vida";
	                    	}
	                    	if (rs0.getString(1).equals("4")){
	                    		contenidoBBDD="Alumno: Planificaci�n Tiempo Libre";
	                    	}
	                    	if (rs0.getString(1).equals("5")){
	                    		contenidoBBDD="Alumno: Autonom�a";
	                    	}
	                    	if (rs0.getString(1).equals("6")){
	                    		contenidoBBDD="Alumno: Responsabilidad";
	                    	}
	                    	if (rs0.getString(1).equals("7")){
	                    		contenidoBBDD="Alumno: Compromiso del becado";
	                    	}
	                    	if (rs0.getString(1).equals("8")){
	                    		contenidoBBDD="RA: Compromiso del RA";
	                    	}
	                    	if (rs0.getString(1).equals("9")){
	                    		contenidoBBDD="RA: Rol de RA, apoyo y orientaci�n";
	                    	}
	                    	if (rs0.getString(1).equals("10")){
	                    		contenidoBBDD="RA: Herramientas para favorecer la terminalidad";
	                    	}
	                    	if (rs0.getString(1).equals("11")){
	                    		contenidoBBDD="RA: Relaci�n escuela y familia";
	                    	}
	                    	if (rs0.getString(1).equals("12")){
	                    		contenidoBBDD="Escuela: Desempe�o escolar";
	                    	}
	                    	if (rs0.getString(1).equals("13")){
	                    		contenidoBBDD="Escuela: Permanencia de los alumnos";
	                    	}
	                    	if (rs0.getString(1).equals("14")){
	                    		contenidoBBDD="Escuela: Promoci�n de materias";
	                    	}
	                    	if (rs0.getString(1).equals("15")){
	                    		contenidoBBDD="Escuela: Repitencia";
	                    	}
	                    	if (rs0.getString(1).equals("16")){
	                    		contenidoBBDD="Escuela: Egreso efectivo y terminalidad del secundario";
	                    	}
	                    	if (rs0.getString(1).equals("17")){
	                    		contenidoBBDD="Escuela: Dise�o y Planificaci�n de acciones conjuntas";
	                    	}
	                    	if (rs0.getString(1).equals("18")){
	                    		contenidoBBDD="Escuela: Implementaci�n de estrategia/s";
	                    	}
	                    	if (rs0.getString(1).equals("19")){
	                    		contenidoBBDD="Escuela: Reuni�n con directivos/docentes";
	                    	}
	                    	if (rs0.getString(1).equals("20")){
	                    		contenidoBBDD="Escuela: Reuni�n con equipo de orientaci�n";
	                    	}
	                    	if (rs0.getString(1).equals("21")){
	                    		contenidoBBDD="Escuela: Observaci�n de clases/taller";
	                    	}
	                    	if (rs0.getString(1).equals("22")){
	                    		contenidoBBDD="Escuela: Capacitaci�n";
	                    	}
	                    	if (rs0.getString(1).equals("23")){
	                    		contenidoBBDD="Escuela: Indicadores de rendimiento acad�mico";
	                    	}
	                    	if (rs0.getString(1).equals("24")){
	                    		contenidoBBDD="Escuela: Jornada institucional";
	                    	}
	                    	
	                    	if(vueltas==0){
	                    		
	                    		
	                    		bucleContenidos=contenidoBBDD+" - ";
	                    	}
	                    	else{
	                    		bucleContenidos=bucleContenidos+contenidoBBDD+" - ";
	                    	}
	                    	
	                    	                   	
	                    	vueltas++;
	                    }
	                    ////System.out.println(bucleContenidos);
	                    eg.setContenido(bucleContenidos);
	                    ////System.out.println(eg.getContenido());
	                    Conexion.cerrarCall(cl0);
	                    Conexion.cerrarConexion(cn0);
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                    Conexion.cerrarCall(cl0);
	                    Conexion.cerrarConexion(cn0);
	                } catch (Exception e) {
	                    e.printStackTrace();
	                    Conexion.cerrarCall(cl0);
	                    Conexion.cerrarConexion(cn0);
	                }
		        // busco los que asistieron                
	                Connection cn1 = null;
	                CallableStatement cl1 = null;
	                ResultSet rs1 = null;
	                try {
	                    //Nombre del procedimiento almacenado
	                    String call1 = "{CALL SP_EventoGenerico3(?)}";
	                    cn1 = Conexion.getConexion();
	                    cl1 = cn1.prepareCall(call1);
	                    //cl1.setLong(1, idevento);
	                    cl1.setString(1,eg.getId());
	                    //La sentencia lo almacenamos en un resulset
	                    rs1 = cl1.executeQuery();
	                    //Consultamos si hay datos para recorrerlo
	                    //e insertarlo en nuestro array
	                    String convocados="";
	                    String asistio="";
	                    String ra1="";
	                    String vin1="";
	                    String ra2="";
	                    String vin2="";
	                    vueltas=0;
	                    while (rs1.next()) {	                       
	                        if(vueltas==0){
	                        	if(rs1.getString(2).equals("CONVOCADO")){
		                        	convocados=rs1.getString(1)+" - ";
		                        }
		                        if(rs1.getString(3).equals("SI")){
		                        	asistio=rs1.getString(1)+" - ";
		                        	ra1=rs1.getString(4)+" - ";
		                        	vin1=rs1.getString(5)+" - ";
		                        	if(rs1.getString(6)!=null && rs1.getString(6)!=""){
		                        		ra2=rs1.getString(6)+" - ";
		                            	vin2=rs1.getString(7)+" - ";
		                        	}
		                        }
	                        }else{
	                        	if(rs1.getString(2).equals("CONVOCADO")){
		                        	convocados=convocados+rs1.getString(1)+" - ";
		                        }
		                        if(rs1.getString(3).equals("SI")){
		                        	asistio=asistio+rs1.getString(1)+" - ";
		                        	ra1=ra1+rs1.getString(4)+" - ";
		                        	vin1=vin1+rs1.getString(5)+" - ";
		                        	if(rs1.getString(6)!=null && rs1.getString(6)!=""){
		                        		ra2=ra2+rs1.getString(6)+" - ";
		                            	vin2=vin2+rs1.getString(7)+" - ";
		                        	}
		                        }
	                        }
	                        vueltas++;
	                    }
	                    eg.setConvocados(convocados);
	                    eg.setAsistio(asistio);
	                    eg.setResponsable1(ra1);
	                    eg.setVinculo1(vin1);
	                    eg.setResponsable2(ra2);
	                    eg.setVinculo2(vin2);
	                    Conexion.cerrarCall(cl1);
	                    Conexion.cerrarConexion(cn1);
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                    Conexion.cerrarCall(cl1);
	                    Conexion.cerrarConexion(cn1);
	                } catch (Exception e) {
	                    e.printStackTrace();
	                    Conexion.cerrarCall(cl1);
	                    Conexion.cerrarConexion(cn1);
	                }
	                //Lo adicionamos a nuestra lista
	                lista.add(eg);
        	}      
            Conexion.cerrarCall(cl);
            Conexion.cerrarConexion(cn);
        } catch (SQLException e) {
            e.printStackTrace();
            Conexion.cerrarCall(cl);
            Conexion.cerrarConexion(cn);
        } catch (Exception e) {
            e.printStackTrace();
            Conexion.cerrarCall(cl);
            Conexion.cerrarConexion(cn);
        }// empiezo a buscar
        return lista; 
    }

	private void crearFila(EventoGenericoDTO e, ExportacionEspecialHelper exportacionHelper, HSSFRow row) {
		row.createCell(0).setCellValue(Integer.parseInt(e.getId()));
		row.createCell(1).setCellValue(e.getRr());
		row.createCell(2).setCellValue(e.getEa());
		row.createCell(3).setCellValue(e.getFechaCarga());
		row.createCell(4).setCellValue(e.getFechaEvento());		
		row.createCell(5).setCellValue(e.getLugarEvento());
		row.createCell(6).setCellValue(e.getZona());
		row.createCell(7).setCellValue(e.getTipoEvento());
		row.createCell(8).setCellValue(e.getContenido());
		row.createCell(9).setCellValue(e.getOtroContenido());
		row.createCell(10).setCellValue(e.getEvaluacion());
		row.createCell(11).setCellValue(e.getObservaciones());
		row.createCell(12).setCellValue(e.getConvocados());
		row.createCell(13).setCellValue(e.getAsistio());
		row.createCell(14).setCellValue(e.getResponsable1());
		row.createCell(15).setCellValue(e.getVinculo1());
		row.createCell(16).setCellValue(e.getResponsable2());
		row.createCell(17).setCellValue(e.getVinculo2());
		row.createCell(17).setCellValue(e.getOp1());
		row.createCell(18).setCellValue(e.getOp2());
		row.createCell(19).setCellValue(e.getOp3());
		row.createCell(20).setCellValue(e.getOp5());
		row.createCell(21).setCellValue(e.getOp6());
		row.createCell(22).setCellValue(e.getOp4());
		row.createCell(23).setCellValue(e.getOp());
	}
	
	
	
}