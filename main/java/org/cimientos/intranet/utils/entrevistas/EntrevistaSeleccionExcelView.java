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
import org.cimientos.intranet.modelo.perfil.AlumnoSeleccion;
import org.cimientos.intranet.modelo.perfil.PerfilAlumno;
import org.cimientos.intranet.modelo.persona.PersonaSeleccion;
import org.cimientos.intranet.modelo.seleccion.EntrevistaSeleccion;
import org.cimientos.intranet.servicio.EntrevistaSeleccionSrv;
//import org.cimientos.intranet.servicio.CicloProgramaSrv;
//import org.cimientos.intranet.servicio.EntrevistaSrv;
import org.cimientos.intranet.utils.ExportacionEspecialHelper;
import org.cimientos.intranet.utils.Formateador;
import org.springframework.beans.factory.annotation.Autowired;
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

public class EntrevistaSeleccionExcelView extends AbstractExcelView{
	
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
		
	//	CicloProgramaSrv cicloSrv = (CicloProgramaSrv) model.get("cicloSrv");
		//EntrevistaSrv entrevistaSrv = (EntrevistaSrv) model.get("entrevistaSrv");
		
		ExportacionEspecialHelper exportacionHelper = (ExportacionEspecialHelper) model.get("exportacionHelper");
		
		HSSFSheet sheet = workbook.getSheet("Seleccion");
		
	
		
		
		String ciclo1 = null;
		String zona1 = null;
		String escuela1 = null;
		String anio1 = null;
		String alumno1 = null;
		String estado1 = null;
		String convocatoria1 = null;
		String eae = null;
		
		
		
		ciclo1 = (String) model.get("ciclo1");
		zona1 = (String) model.get("zona1");
		escuela1 = (String) model.get("escuela1");
		anio1 = (String) model.get("anio1");
		alumno1 = (String) model.get("alumno1");
		estado1 = (String) model.get("estado1");
		convocatoria1 = (String) model.get("convocatoria1");
		eae = (String) model.get("eae");
		
		
		

		List<ReporteEntrevistaSeleccionDTO2> entrevistas = null;
		int rowNum = 1;
		int parcial = 0;
		//int inicial = 0;
		int totalRows=1000;
		HSSFRow row;
		while (parcial < totalRows) {
			parcial = parcial + bachSize;
			
				
		
			entrevistas = obtenerRESDTO(ciclo1,zona1,escuela1,anio1,alumno1,estado1,convocatoria1,eae);
//			System.out.println("#### tama�o desde entrevistaSelecionExcelVew: "+entrevistas.size());
			 
				for (ReporteEntrevistaSeleccionDTO2 e : entrevistas) {			
					//System.out.println(zona1);
					if (zona1==null){
						if (anio1==null){
							if (alumno1==null){
								if (estado1==null){
									row = sheet.createRow(rowNum++);
									crearFila(e, exportacionHelper, row);
								}
								else{
									if(estado1.equals(e.getEstadoAlumno())){
										row = sheet.createRow(rowNum++);
										crearFila(e, exportacionHelper, row);
									}
								}
							}
							else{
								if (estado1==null){
									//alumno
									//if(alumno1.equals(e.getApellidoAlumno())){
										row = sheet.createRow(rowNum++);
										crearFila(e, exportacionHelper, row);
									//}
								}
								else{		
									//alumno1 y estado1;
									//if(alumno1.equals(e.getApellidoAlumno()) && estado1.equals(e.getEstadoAlumno()) ){										
										if(estado1.equals(e.getEstadoAlumno()) ){	
										row = sheet.createRow(rowNum++);
										crearFila(e, exportacionHelper, row);
									}									
								}
							}
						}
						else{
							if (alumno1==null){
								if (estado1==null){
									//anio1;
									if(e.getAnioEscolar().equals(anio1)){
										row = sheet.createRow(rowNum++);
										crearFila(e, exportacionHelper, row);
									}
								}
								else{
									//anio1, estado1;
									if(e.getAnioEscolar().equals(anio1) && estado1.equals(e.getEstadoAlumno())){
										row = sheet.createRow(rowNum++);
										crearFila(e, exportacionHelper, row);
									}
								}
							}
							else{
								if (estado1==null){
									//anio1,alumno1;
									//if(anio1.equals(e.getAnioEscolar()) && alumno1.equals(e.getApellidoAlumno()) ){
									if(anio1.equals(e.getAnioEscolar()) ){
										row = sheet.createRow(rowNum++);
										crearFila(e, exportacionHelper, row);
									}
								}
								else{
									//anio1, alumno1, estado1;
									//if(anio1.equals(e.getAnioEscolar()) && alumno1.equals(e.getApellidoAlumno()) && estado1.equals(e.getEstadoAlumno()) ){
									if(anio1.equals(e.getAnioEscolar()) && estado1.equals(e.getEstadoAlumno()) ){
										row = sheet.createRow(rowNum++);
										crearFila(e, exportacionHelper, row);
									}
									
								}
							}
						}
					}
					else{					
						//zona1 !=null
						if (escuela1==null){
							if (convocatoria1==null){
								if (anio1==null){
									if (alumno1==null){
										if (estado1==null){
											//zona
											if(zona1.equals(e.getZonaCimientos())){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}											
										}
										else
										{
											//zona,estado
											if(zona1.equals(e.getZonaCimientos()) && estado1.equals(e.getEstadoAlumno()) ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}
									else
									{	
										if (estado1==null){
											//zona,alumno
											//if(zona1.equals(e.getZonaCimientos()) && alumno1.equals(e.getApellidoAlumno()) ){
											if(zona1.equals(e.getZonaCimientos()) ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{	
											//zona,alumno,estado
											//if(zona1.equals(e.getZonaCimientos()) && alumno1.equals(e.getApellidoAlumno()) && estado1.equals(e.getEstadoAlumno()) ){
											if(zona1.equals(e.getZonaCimientos()) && estado1.equals(e.getEstadoAlumno()) ){	
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}
								}
								else
								{	
									if (alumno1==null){
										if (estado1==null){
											//zona,anio
											if(zona1.equals(e.getZonaCimientos()) && anio1.equals(e.getAnioEscolar()) ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{	
											//zona,anio, estado
											if(zona1.equals(e.getZonaCimientos()) && anio1.equals(e.getAnioEscolar()) && estado1.equals(e.getEstadoAlumno()) ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}
									else
									{	
										if (estado1==null){
											//zona, anio, alumno
											//if(zona1.equals(e.getZonaCimientos()) && anio1.equals(e.getAnioEscolar()) && alumno1.equals(e.getApellidoAlumno()) ){
											if(zona1.equals(e.getZonaCimientos()) && anio1.equals(e.getAnioEscolar())  ){	
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{	
											//zona, anio, alumno,estado
											//if(zona1.equals(e.getZonaCimientos()) && anio1.equals(e.getAnioEscolar()) && alumno1.equals(e.getApellidoAlumno()) && estado1.equals(e.getEstadoAlumno()) ){
											if(zona1.equals(e.getZonaCimientos()) && anio1.equals(e.getAnioEscolar()) && estado1.equals(e.getEstadoAlumno()) ){	
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}
								}
							}
							else
							{	
								if (anio1==null){
									if (alumno1==null){
										if (estado1==null){
											//zona,convocatoria
											if(zona1.equals(e.getZonaCimientos()) && convocatoria1.equals(e.getConvocatoria()) ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{
											//zona,convocatoria,estado
											if(zona1.equals(e.getZonaCimientos()) && convocatoria1.equals(e.getConvocatoria()) && estado1.equals(e.getEstadoAlumno()) ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}
									else
									{	
										if (estado1==null){
											//zona, convocatoria, alumno
											//if(zona1.equals(e.getZonaCimientos()) && convocatoria1.equals(e.getConvocatoria()) && alumno1.equals(e.getApellidoAlumno()) ){
											if(zona1.equals(e.getZonaCimientos()) && convocatoria1.equals(e.getConvocatoria())  ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{	
											//zona,convocatoria, alumno, estado
											//if(zona1.equals(e.getZonaCimientos()) && convocatoria1.equals(e.getConvocatoria()) && alumno1.equals(e.getApellidoAlumno()) && estado1.equals(e.getEstadoAlumno()) ){
											if(zona1.equals(e.getZonaCimientos()) && convocatoria1.equals(e.getConvocatoria()) && estado1.equals(e.getEstadoAlumno()) ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}
								}
								else
								{	
									if (alumno1==null){
										if (estado1==null){
											//zona,convocatoria,anio
											if(zona1.equals(e.getZonaCimientos()) && convocatoria1.equals(e.getConvocatoria()) && anio1.equals(e.getAnioEscolar()) ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{	
											//zona,convocatoria,anio,estado
											if(zona1.equals(e.getZonaCimientos()) && convocatoria1.equals(e.getConvocatoria()) && anio1.equals(e.getAnioEscolar()) && estado1.equals(e.getEstadoAlumno()) ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}
									else
									{	
										if (estado1==null){
											//zona,convocatoria, anio,alumno
											//if(zona1.equals(e.getZonaCimientos()) && convocatoria1.equals(e.getConvocatoria()) && anio1.equals(e.getAnioEscolar()) && alumno1.equals(e.getApellidoAlumno()) ){
											if(zona1.equals(e.getZonaCimientos()) && convocatoria1.equals(e.getConvocatoria()) && anio1.equals(e.getAnioEscolar())  ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{	
											//zona,convocatoria, anio,alumno,estado
											//if(zona1.equals(e.getZonaCimientos()) && convocatoria1.equals(e.getConvocatoria()) && anio1.equals(e.getAnioEscolar()) && alumno1.equals(e.getApellidoAlumno()) && estado1.equals(e.getEstadoAlumno())){
											if(zona1.equals(e.getZonaCimientos()) && convocatoria1.equals(e.getConvocatoria()) && anio1.equals(e.getAnioEscolar())  && estado1.equals(e.getEstadoAlumno())){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}
								}
							}							
						}
						else
						{
							if (convocatoria1==null){
								if (anio1==null){
									if (alumno1==null){
										if (estado1==null){
											//zona,escuela
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{	
											//zona,escuela,estado
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && estado1.equals(e.getEstadoAlumno()) ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}	
									else
									{	
										if (estado1==null){
											//zona,escuela,alumno
											//if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && alumno1.equals(e.getApellidoAlumno()) ){
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{	
											//zona,escuela,alumno,estado
											//if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && alumno1.equals(e.getApellidoAlumno()) && estado1.equals(e.getEstadoAlumno()) ){
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && estado1.equals(e.getEstadoAlumno()) ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}
								}
								else
								{	
									if (alumno1==null){
										if (estado1==null){
											//zona,escuela,anio
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && anio1.equals(e.getAnioEscolar())){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{	
											//zona,escuela,anio, estado
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && anio1.equals(e.getAnioEscolar()) && estado1.equals(e.getEstadoAlumno())){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}	
									else
									{	
										if (estado1==null){
											//zona, escuela, anio, alumno
											//if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && anio1.equals(e.getAnioEscolar()) && alumno1.equals(e.getApellidoAlumno())){
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && anio1.equals(e.getAnioEscolar())){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{	
											//zona, escuela, anio, alumno,estado
											//if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && anio1.equals(e.getAnioEscolar()) && alumno1.equals(e.getApellidoAlumno()) && estado1.equals(e.getEstadoAlumno())){
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && anio1.equals(e.getAnioEscolar()) && estado1.equals(e.getEstadoAlumno())){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}
								}
							}
							else
							{
								if (anio1==null){
									if (alumno1==null){
										if (estado1==null){
											//zona, escuela, convocatoria											
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && convocatoria1.equals(e.getConvocatoria())){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{	
											//zona, escuela, convocatoria,estado
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && convocatoria1.equals(e.getConvocatoria()) && estado1.equals(e.getEstadoAlumno())){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}
									else
									{	
										if (estado1==null){
											//zona, escuela, convocatoria, alumno
											//if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && convocatoria1.equals(e.getConvocatoria()) && alumno1.equals(e.getApellidoAlumno())){
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && convocatoria1.equals(e.getConvocatoria()) ){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{
											//zona, escuela, convocatoria, alumno, estado
											//if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && convocatoria1.equals(e.getConvocatoria()) && alumno1.equals(e.getApellidoAlumno()) && estado1.equals(e.getEstadoAlumno())){
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && convocatoria1.equals(e.getConvocatoria()) && estado1.equals(e.getEstadoAlumno())){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}
								}	
								else
								{	
									if (alumno1==null){
										if (estado1==null){
											//zona, escuela, convocatoria,anio
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && convocatoria1.equals(e.getConvocatoria()) && anio1.equals(e.getAnioEscolar())){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{	
											//zona, escuela, convocatoria,anio,estado
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && convocatoria1.equals(e.getConvocatoria()) && anio1.equals(e.getAnioEscolar()) && estado1.equals(e.getEstadoAlumno())){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}
									else
									{	
										if (estado1==null){
											//zona, escuela, convocatoria, anio,alumno
											//if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && convocatoria1.equals(e.getConvocatoria()) && anio1.equals(e.getAnioEscolar())){
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && convocatoria1.equals(e.getConvocatoria()) && anio1.equals(e.getAnioEscolar()) && alumno1.equals(e.getApellidoAlumno())){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
										else
										{	
											//zona, escuela, convocatoria, anio, alumno,estado
											//if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && convocatoria1.equals(e.getConvocatoria()) && anio1.equals(e.getAnioEscolar()) && alumno1.equals(e.getApellidoAlumno()) && estado1.equals(e.getEstadoAlumno())){
											if(zona1.equals(e.getZonaCimientos()) && escuela1.equals(e.getEscuela()) && convocatoria1.equals(e.getConvocatoria()) && anio1.equals(e.getAnioEscolar()) && estado1.equals(e.getEstadoAlumno())){
												row = sheet.createRow(rowNum++);
												crearFila(e, exportacionHelper, row);
											}
										}
									}
								}								
							}						
						}						
					}
					
											
					
					
					
				}					
			//inicial = parcial;
			entrevistas = null;
		}	
	}
	
	public static synchronized ArrayList<ReporteEntrevistaSeleccionDTO2> obtenerRESDTO(String ciclo1, String zona1, String escuela1, String anio1, String alumno1, String estado1, String convocatoria1, String eae) {
        //El array que contendra todos nuestras Entrevistas de Seleccion
        ArrayList<ReporteEntrevistaSeleccionDTO2> lista = new ArrayList<ReporteEntrevistaSeleccionDTO2>();
        Connection cn = null;
        CallableStatement cl = null;
        ResultSet rs = null;
        String call=null;
        
        try {
        	
        	if(ciclo1==null && alumno1==null){        		
        		call = "{CALL SP_TraerESeleccion()}";
	    		cn = Conexion.getConexion();
	            cl = cn.prepareCall(call);	
        	}
        	if(ciclo1!=null && alumno1==null){    
        		call="SELECT *  FROM entrevista_seleccion WHERE entrevista_seleccion.nombre_ciclo=(?);";
        	//	call = "{CALL SP_TraerESeleccionCi(?)}";
        		cn = Conexion.getConexion();
                cl = cn.prepareCall(call);
                cl.setString(1, ciclo1);
        	}
        	if(ciclo1==null && alumno1!=null){
        		call = "{CALL SP_TraerESeleccionAlumno(?)}";
	    		cn = Conexion.getConexion();
	            cl = cn.prepareCall(call);
	            cl.setString(1, "%"+alumno1+"%");
        	}
        	if(ciclo1!=null && alumno1!=null){
        		call = "{CALL SP_TraerESeleccionCiAlumno(?,?)}";
        		cn = Conexion.getConexion();
                cl = cn.prepareCall(call);
                cl.setString(1, ciclo1);
                cl.setString(2, "%"+alumno1+"%");
        	}
	       rs = cl.executeQuery();
            //Consultamos si hay datos para recorrerlo e insertarlo en nuestro array
	       while (rs.next()) {
	    	   
	            	ReporteEntrevistaSeleccionDTO2 resDTO = new ReporteEntrevistaSeleccionDTO2();
	            	resDTO.setCiclo(rs.getString("nombre_ciclo"));
	                resDTO.setApellidoAlumno(rs.getString("apellido"));      
	                resDTO.setNombreAlumno(rs.getString("persona_seleccion.nombre"));
	                resDTO.setTipoDNI(rs.getString("tipo_dni"));
	                resDTO.setEntraExcepcion(rs.getString("excepcion"));
	                if(rs.getString("otro_becado")!=null){
	                	resDTO.setOtroBecado("S�");
	                }else{
	                	resDTO.setOtroBecado("");
	                }
	                resDTO.setNroDNI(rs.getString("dni"));
	                resDTO.setFechaNac(rs.getDate("fecha_nacimiento"));
	                resDTO.setSexo(rs.getString("sexo"));
	                resDTO.setNacionalidad(rs.getString("nacionalidad"));
	                resDTO.setZonaCimientos(rs.getString("zona_cimientos.nombre"));
	                resDTO.setConvocatoria(rs.getString("convocatoria_seleccion.nombre"));
	                resDTO.setEscuela(rs.getString("escuela.nombre"));
	                resDTO.setModalidad(rs.getString("modalidad"));
	                resDTO.setAnioEscolar(rs.getString("Anio_Escolar"));
	                resDTO.setDivision(rs.getString("alumno_seleccion.division"));
	                resDTO.setTurno(rs.getString("Turno"));
	                resDTO.setRecibeOtraBeca(rs.getString("recibe_otra_beca"));
	                resDTO.setBecaCual(rs.getString("entrevista_seleccion.cual_beca"));
	                resDTO.setCalle(rs.getString("persona_seleccion.direccion"));
	                resDTO.setNumero(rs.getString("persona_seleccion.numero_calle"));
	                resDTO.setPiso(rs.getString("persona_seleccion.piso"));
	                resDTO.setCp(rs.getString("persona_seleccion.codigo_postal"));
	                resDTO.setBarrio(rs.getString("persona_seleccion.barrio"));
	                resDTO.setLocalidad(rs.getString("localidad.nombre"));
	                resDTO.setProvincia(rs.getString("provincia.descripcion"));
	                resDTO.setContacto1(rs.getString("contacto_telefono1")+" - "+rs.getString("telefono1"));
	                resDTO.setContacto2(rs.getString("contacto_telefono2")+" - "+rs.getString("telefono2"));
	                resDTO.setContacto3(rs.getString("contacto_telefono3")+" - "+rs.getString("telefono3"));
	                resDTO.setRepitencia(rs.getString("repitencia"));
	                resDTO.setMotivoRepitencia(rs.getString("entrevista_seleccion.motivo_repitencia"));
	                resDTO.setAbandono(rs.getString("abandono"));
	                resDTO.setAbandonoAnio(rs.getString("abandono_anio"));
	                resDTO.setMotivoAbandono(rs.getString("entrevista_seleccion.motivo_abandono"));
	                resDTO.setConducta(rs.getString("Conducta"));
	                resDTO.setInformacionComplementaria(rs.getString("entrevista_seleccion.informacion_complementaria"));                
	                resDTO.setPercepcionesCandidato(rs.getString("entrevista_seleccion.percepciones_candidato"));
	                resDTO.setCompromisoEscolaridad(rs.getString("Compromiso_Escolaridad"));
	                resDTO.setPosibilidadCompromisoPBE(rs.getString("Compromiso_Pbe"));
	                resDTO.setCantidadInasitenciasAnioPasado(rs.getString("entrevista_seleccion.cantidad_inasistencia_anio_pasado"));
	                resDTO.setCantidadInasitenciasAnioCurso(rs.getString("entrevista_seleccion.cantidad_inasistencia_anio_curso"));
	                resDTO.setIngresosTotales(rs.getString("entrevista_seleccion.ingresos_totales_ficha_familiar"));
	                resDTO.setObservacionIngresoEgreso(rs.getString("entrevista_seleccion.observaciones_egreso_ingreso"));
	                resDTO.setObservacionesGenerales(rs.getString("entrevista_seleccion.observaciones_generales"));
	                resDTO.setFechaCargaEntrevista(rs.getDate("entrevista_seleccion.fecha_carga_entrevista"));
	                resDTO.setEstadoAlumno(rs.getString("Estado_Alumno"));
	                resDTO.setMotivRechazo(rs.getString("Motivo_Rechazo"));
	                resDTO.setOtroMotivoRechazo(rs.getString("entrevista_seleccion.otro_motivo_rechazo"));
	                resDTO.setMotivoEnvioTS(rs.getString("Motivo_envioTS"));
	                resDTO.setIdAlumno(rs.getLong("id_Alumno"));
	                resDTO.setIdRA1(rs.getLong("id_RA1"));
	                resDTO.setIdRA2(rs.getLong("id_RA2"));
	                resDTO.setIdEntrevista(rs.getLong("entrevista_seleccion.id"));
	                resDTO.setFechaCargaEntrevista(rs.getDate("fecha_entrevista"));
	                resDTO.setEae(rs.getString("eae"));
	                resDTO.setOrientacion(rs.getString("orientacion"));
	
	                
	                // busco fecha asignacion 
	                String DNI=resDTO.getNroDNI();
	                Connection cn0 = null;
	                CallableStatement cl0 = null;
	                ResultSet rs0 = null;
	                try {
	                    //Nombre del procedimiento almacenado
	                    String call0 = "{CALL SP_TraerFechaAsignacion(?)}";
	                    cn0 = Conexion.getConexion();
	                    cl0 = cn0.prepareCall(call0);
	                    cl0.setString(1, DNI);
	                    //La sentencia lo almacenamos en un resulset
	                    rs0 = cl0.executeQuery();
	                    //Consultamos si hay datos para recorrerlo
	                    //e insertarlo en nuestro array
	                    
	                    while (rs0.next()) {
	                    	resDTO.setFechaAsignacion(rs0.getString("periodo.nombre"));                    	
	                    	
	                    }
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
	                
	                if(resDTO.getFechaAsignacion()==null){
	                	resDTO.setFechaAsignacion("");
	                }
	                // busco datos de RA1
	                Long codigo1=resDTO.getIdRA1();
	                Connection cn1 = null;
	                CallableStatement cl1 = null;
	                ResultSet rs1 = null;
	                try {
	                    //Nombre del procedimiento almacenado
	                    String call1 = "{CALL SP_TraerRA1(?)}";
	                    cn1 = Conexion.getConexion();
	                    cl1 = cn1.prepareCall(call1);
	                    cl1.setLong(1, codigo1);
	                    //La sentencia lo almacenamos en un resulset
	                    rs1 = cl1.executeQuery();
	                    //Consultamos si hay datos para recorrerlo
	                    //e insertarlo en nuestro array
	                    String ra1ok="";
	                    while (rs1.next()) {
	                        //Obtenemos los valores de la consulta y creamos
	                        //nuestro objeto producto
	                    	ra1ok="ok";
	                    	resDTO.setEgresosTotales(rs1.getString("responsable_adulto_seleccion.egresos_totales"));
	                    	resDTO.setApellidoRA1(rs1.getString("responsable_adulto_seleccion.apellido"));
	                    	resDTO.setNombreRA1(rs1.getString("responsable_adulto_seleccion.nombre"));
	                    	resDTO.setVinculoRA1(rs1.getString("Vinculo"));
	                    	resDTO.setTipoDNIRA1(rs1.getString("Tipo_DNI"));
	                    	resDTO.setNroDNIRA1(rs1.getString("responsable_adulto_seleccion.dni"));
	                    	resDTO.setFechaNacRA1(rs1.getDate("responsable_adulto_seleccion.fecha_nacimiento"));
	                    	resDTO.setSexoRA1(rs1.getString("Sexo"));
	                    	resDTO.setNacionalidadRA1(rs1.getString("responsable_adulto_seleccion.nacionalidad"));
	                    	resDTO.setAsisteEntrevistaRA1(rs1.getString("AsisteEntrevista"));
	                    	resDTO.setCompromisoEscolaridad(rs1.getString("Compromiso_Escolaridad"));
	                    	resDTO.setAptoComoRA(rs1.getString("Apto_comoRA"));
	                    	resDTO.setPosibilidadCompromisoPBERA(rs1.getString("CompromisoPBE"));
	                    	resDTO.setSucursal(rs1.getString("Banco"));
	                    	resDTO.setRelacionVivienda(rs1.getString("RelacionVivienda"));
	                    	
	                    	resDTO.setObservacionesTS(rs1.getString("responsable_adulto_seleccion.observaciones_parats"));
	                    }
	                    if (ra1ok==""){
	                    	call1 = "{CALL SP_TraerRA1NOOK(?)}";
	                        cn1 = Conexion.getConexion();
	                        cl1 = cn1.prepareCall(call1);
	                        cl1.setLong(1, codigo1);
	                        //La sentencia lo almacenamos en un resulset
	                        rs1 = cl1.executeQuery();
	                        //Consultamos si hay datos para recorrerlo
	                        //e insertarlo en nuestro array
	                        while (rs1.next()) {
	                            //Obtenemos los valores de la consulta y creamos
	                            //nuestro objeto producto
	                        	ra1ok="ok";
	                        	resDTO.setEgresosTotales(rs1.getString("responsable_adulto.egresos_totales"));
	                        	resDTO.setApellidoRA1(rs1.getString("responsable_adulto.apellido"));
	                        	resDTO.setNombreRA1(rs1.getString("responsable_adulto.nombre"));
	                        	resDTO.setVinculoRA1(rs1.getString("Vinculo"));
	                        	resDTO.setTipoDNIRA1(rs1.getString("Tipo_DNI"));
	                        	resDTO.setNroDNIRA1(rs1.getString("responsable_adulto.dni"));
	                        	resDTO.setFechaNacRA1(rs1.getDate("responsable_adulto.fecha_nacimiento"));
	                        	resDTO.setSexoRA1(rs1.getString("Sexo"));
	                        	resDTO.setNacionalidadRA1(rs1.getString("responsable_adulto.nacionalidad"));
	                        	resDTO.setAsisteEntrevistaRA1(rs1.getString("AsisteEntrevista"));
	                        	resDTO.setCompromisoEscolaridad(rs1.getString("Compromiso_Escolaridad"));
	                        	resDTO.setAptoComoRA(rs1.getString("Apto_comoRA"));
	                        	resDTO.setPosibilidadCompromisoPBERA(rs1.getString("CompromisoPBE"));
	                        	resDTO.setSucursal(rs1.getString("Banco"));
	                        	resDTO.setRelacionVivienda(rs1.getString("RelacionVivienda"));
	                        	
	                        	resDTO.setObservacionesTS(rs1.getString("responsable_adulto.observaciones_parats"));
	                        }
	                    	
	                    	
	                    }
	                    
	                    
	                    
	                    
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
	                
	             // busco datos de RA1 DNI
	                String codigo11=resDTO.getNroDNIRA1();
	                Connection cn11 = null;
	                CallableStatement cl11 = null;
	                ResultSet rs11 = null;
	                try {
	                    //Nombre del procedimiento almacenado
	                    String call11 = "{CALL SP_TraerRA1idEntrevistador(?)}";
	                    cn11 = Conexion.getConexion();
	                    cl11 = cn11.prepareCall(call11);
	                    cl11.setString(1, codigo11);
	                    //La sentencia lo almacenamos en un resulset
	                    rs11 = cl11.executeQuery();
	                    //Consultamos si hay datos para recorrerlo
	                    //e insertarlo en nuestro array
	                    while (rs11.next()) {
	                        //Obtenemos los valores de la consulta y creamos
	                        //nuestro objeto producto
	                    	resDTO.setEntrevistador(rs11.getString("id_entrevistador"));                    	
	                    }
	                    Conexion.cerrarCall(cl11);
	                    Conexion.cerrarConexion(cn11);
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                    Conexion.cerrarCall(cl11);
	                    Conexion.cerrarConexion(cn11);
	                } catch (Exception e) {
	                    e.printStackTrace();
	                    Conexion.cerrarCall(cl11);
	                    Conexion.cerrarConexion(cn11);
	                }
	                
	                
	                
	             // busco datos de RA2
	                if(resDTO.getIdRA2() != null){                
		                Long codigo2=resDTO.getIdRA2();
		                Connection cn2 = null;
		                CallableStatement cl2 = null;
		                ResultSet rs2 = null;
		                try {
		                    //Nombre del procedimiento almacenado
		                    String call2 = "{CALL SP_TraerRA2(?)}";
		                    cn2 = Conexion.getConexion();
		                    cl2 = cn2.prepareCall(call2);
		                    cl2.setLong(1, codigo2);
		                    //La sentencia lo almacenamos en un resulset
		                    rs2 = cl2.executeQuery();
		                    //Consultamos si hay datos para recorrerlo
		                    //e insertarlo en nuestro array
		                    while (rs2.next()) {
		                        //Obtenemos los valores de la consulta y creamos
		                        //nuestro objeto producto
		                    	resDTO.setApellidoRA2(rs2.getString("apellido"));
		                    	resDTO.setNombreRA2(rs2.getString("nombre"));
		                    	resDTO.setVinculoRA2(rs2.getString("Vinculo"));               
		                    }
		                    Conexion.cerrarCall(cl2);
		                    Conexion.cerrarConexion(cn2);
		                } catch (SQLException e) {
		                    e.printStackTrace();
		                    Conexion.cerrarCall(cl2);
		                    Conexion.cerrarConexion(cn2);
		                } catch (Exception e) {
		                    e.printStackTrace();
		                    Conexion.cerrarCall(cl2);
		                    Conexion.cerrarConexion(cn2);
		                }	                    
	                }
	                
	             // busco datos de Ficha Fliar
	                int col=1;                
	                Long codigo3=resDTO.getIdAlumno();
	                Connection cn3 = null;
	                CallableStatement cl3 = null;
	                ResultSet rs3 = null;
	                try {
	                    //Nombre del procedimiento almacenado
	                    String call3 = "{CALL SP_TraerFichaFliar(?)}";
	                    cn3 = Conexion.getConexion();
	                    cl3 = cn3.prepareCall(call3);
	                    cl3.setLong(1, codigo3);
	                    //La sentencia lo almacenamos en un resulset
	                    rs3 = cl3.executeQuery();
	                    //Consultamos si hay datos para recorrerlo
	                    //e insertarlo en nuestro array
	                    
	                    while (rs3.next()) {
	                        //Obtenemos los valores de la consulta y creamos
	                        //nuestro objeto producto
	                    	if(col==1){
	                    		resDTO.setV1(rs3.getString("vinculo"));
	                    		resDTO.setNa1(rs3.getString("convivientes"));
	                    		resDTO.setEdad1(rs3.getString("edad"));
	                    		resDTO.setConv1(rs3.getString("convive"));
	                    		resDTO.setMne1(rs3.getString("niveleducativo"));
	                    		resDTO.setMa1(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu1(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl1(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem1(rs3.getString("renumeracion"));
	                    		resDTO.setOi1(rs3.getString("otros_ingresos"));
	                    	}
	                    	if(col==2){
	                    		resDTO.setV2(rs3.getString("vinculo"));
	                    		resDTO.setNa2(rs3.getString("convivientes"));
	                    		resDTO.setEdad2(rs3.getString("edad"));
	                    		resDTO.setConv2(rs3.getString("convive"));
	                    		resDTO.setMne2(rs3.getString("niveleducativo"));
	                    		resDTO.setMa2(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu2(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl2(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem2(rs3.getString("renumeracion"));
	                    		resDTO.setOi2(rs3.getString("otros_ingresos"));
	                    	}
	                    	if(col==3){
	                    		resDTO.setV3(rs3.getString("vinculo"));
	                    		resDTO.setNa3(rs3.getString("convivientes"));
	                    		resDTO.setEdad3(rs3.getString("edad"));
	                    		resDTO.setConv3(rs3.getString("convive"));
	                    		resDTO.setMne3(rs3.getString("niveleducativo"));
	                    		resDTO.setMa3(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu3(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl3(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem3(rs3.getString("renumeracion"));
	                    		resDTO.setOi3(rs3.getString("otros_ingresos"));
	                    	}
	                    	if(col==4){
	                    		resDTO.setV4(rs3.getString("vinculo"));
	                    		resDTO.setNa4(rs3.getString("convivientes"));
	                    		resDTO.setEdad4(rs3.getString("edad"));
	                    		resDTO.setConv4(rs3.getString("convive"));
	                    		resDTO.setMne4(rs3.getString("niveleducativo"));
	                    		resDTO.setMa4(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu4(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl4(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem4(rs3.getString("renumeracion"));
	                    		resDTO.setOi4(rs3.getString("otros_ingresos"));
	                    	}
	                    	if(col==5){
	                    		resDTO.setV5(rs3.getString("vinculo"));
	                    		resDTO.setNa5(rs3.getString("convivientes"));
	                    		resDTO.setEdad5(rs3.getString("edad"));
	                    		resDTO.setConv5(rs3.getString("convive"));
	                    		resDTO.setMne5(rs3.getString("niveleducativo"));
	                    		resDTO.setMa5(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu5(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl5(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem5(rs3.getString("renumeracion"));
	                    		resDTO.setOi5(rs3.getString("otros_ingresos"));
	                    	}
	                    	if(col==6){
	                    		resDTO.setV6(rs3.getString("vinculo"));
	                    		resDTO.setNa6(rs3.getString("convivientes"));
	                    		resDTO.setEdad6(rs3.getString("edad"));
	                    		resDTO.setConv6(rs3.getString("convive"));
	                    		resDTO.setMne6(rs3.getString("niveleducativo"));
	                    		resDTO.setMa6(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu6(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl6(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem6(rs3.getString("renumeracion"));
	                    		resDTO.setOi6(rs3.getString("otros_ingresos"));
	                    	}
	                    	if(col==7){
	                    		resDTO.setV7(rs3.getString("vinculo"));
	                    		resDTO.setNa7(rs3.getString("convivientes"));
	                    		resDTO.setEdad7(rs3.getString("edad"));
	                    		resDTO.setConv7(rs3.getString("convive"));
	                    		resDTO.setMne7(rs3.getString("niveleducativo"));
	                    		resDTO.setMa7(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu7(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl7(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem7(rs3.getString("renumeracion"));
	                    		resDTO.setOi7(rs3.getString("otros_ingresos"));
	                    	}
	                    	if(col==8){
	                    		resDTO.setV8(rs3.getString("vinculo"));
	                    		resDTO.setNa8(rs3.getString("convivientes"));
	                    		resDTO.setEdad8(rs3.getString("edad"));
	                    		resDTO.setConv8(rs3.getString("convive"));
	                    		resDTO.setMne8(rs3.getString("niveleducativo"));
	                    		resDTO.setMa8(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu8(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl8(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem8(rs3.getString("renumeracion"));
	                    		resDTO.setOi8(rs3.getString("otros_ingresos"));
	                    	}
	                    	if(col==9){
	                    		resDTO.setV9(rs3.getString("vinculo"));
	                    		resDTO.setNa9(rs3.getString("convivientes"));
	                    		resDTO.setEdad9(rs3.getString("edad"));
	                    		resDTO.setConv9(rs3.getString("convive"));
	                    		resDTO.setMne9(rs3.getString("niveleducativo"));
	                    		resDTO.setMa9(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu9(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl9(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem9(rs3.getString("renumeracion"));
	                    		resDTO.setOi9(rs3.getString("otros_ingresos"));
	                    	}
	                    	if(col==10){
	                    		resDTO.setV10(rs3.getString("vinculo"));
	                    		resDTO.setNa10(rs3.getString("convivientes"));
	                    		resDTO.setEdad10(rs3.getString("edad"));
	                    		resDTO.setConv10(rs3.getString("convive"));
	                    		resDTO.setMne10(rs3.getString("niveleducativo"));
	                    		resDTO.setMa10(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu10(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl10(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem10(rs3.getString("renumeracion"));
	                    		resDTO.setOi10(rs3.getString("otros_ingresos"));
	                    	}
	                    	if(col==11){
	                    		resDTO.setV11(rs3.getString("vinculo"));
	                    		resDTO.setNa11(rs3.getString("convivientes"));
	                    		resDTO.setEdad11(rs3.getString("edad"));
	                    		resDTO.setConv11(rs3.getString("convive"));
	                    		resDTO.setMne11(rs3.getString("niveleducativo"));
	                    		resDTO.setMa11(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu11(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl11(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem11(rs3.getString("renumeracion"));
	                    		resDTO.setOi11(rs3.getString("otros_ingresos"));
	                    	}
	                    	if(col==12){
	                    		resDTO.setV12(rs3.getString("vinculo"));
	                    		resDTO.setNa12(rs3.getString("convivientes"));
	                    		resDTO.setEdad12(rs3.getString("edad"));
	                    		resDTO.setConv12(rs3.getString("convive"));
	                    		resDTO.setMne12(rs3.getString("niveleducativo"));
	                    		resDTO.setMa12(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu12(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl12(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem12(rs3.getString("renumeracion"));
	                    		resDTO.setOi12(rs3.getString("otros_ingresos"));
	                    	}
	                    	if(col==13){
	                    		resDTO.setV13(rs3.getString("vinculo"));
	                    		resDTO.setNa13(rs3.getString("convivientes"));
	                    		resDTO.setEdad13(rs3.getString("edad"));
	                    		resDTO.setConv13(rs3.getString("convive"));
	                    		resDTO.setMne13(rs3.getString("niveleducativo"));
	                    		resDTO.setMa13(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu13(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl13(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem13(rs3.getString("renumeracion"));
	                    		resDTO.setOi13(rs3.getString("otros_ingresos"));
	                    	}
	                    	if(col==14){
	                    		resDTO.setV14(rs3.getString("vinculo"));
	                    		resDTO.setNa14(rs3.getString("convivientes"));
	                    		resDTO.setEdad14(rs3.getString("edad"));
	                    		resDTO.setConv14(rs3.getString("convive"));
	                    		resDTO.setMne14(rs3.getString("niveleducativo"));
	                    		resDTO.setMa14(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu14(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl14(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem14(rs3.getString("renumeracion"));
	                    		resDTO.setOi14(rs3.getString("otros_ingresos"));
	                    	}
	                    	if(col==15){
	                    		resDTO.setV15(rs3.getString("vinculo"));
	                    		resDTO.setNa15(rs3.getString("convivientes"));
	                    		resDTO.setEdad15(rs3.getString("edad"));
	                    		resDTO.setConv15(rs3.getString("convive"));
	                    		resDTO.setMne15(rs3.getString("niveleducativo"));
	                    		resDTO.setMa15(rs3.getString("abandono_repitencia"));
	                    		resDTO.setOcu15(rs3.getString("ocupacion_laboral"));
	                    		resDTO.setDl15(rs3.getString("estabilidad_laboral"));
	                    		resDTO.setRem15(rs3.getString("renumeracion"));
	                    		resDTO.setOi15(rs3.getString("otros_ingresos"));
	                    	}
	                    	col++;                    	
	                    }
	                    Conexion.cerrarCall(cl3);
	                    Conexion.cerrarConexion(cn3);
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                    Conexion.cerrarCall(cl3);
	                    Conexion.cerrarConexion(cn3);
	                } catch (Exception e) {
	                    e.printStackTrace();
	                    Conexion.cerrarCall(cl3);
	                    Conexion.cerrarConexion(cn3);
	                }                

	                //Lo adicionamos a nuestra lista
	                if (eae.equals("todos")){
	                	lista.add(resDTO);
	                }else{
	                	if (rs.getString("eae").equals(eae)){
	                		lista.add(resDTO);
	                	}	                	
	                }
	                
	                
            	
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
        }
        // empiezo a buscar
        	
        
        
        return lista;
    }
	
	
	
	
	
	private void crearFila(ReporteEntrevistaSeleccionDTO2 e, ExportacionEspecialHelper exportacionHelper, HSSFRow row) {
		row.createCell(0).setCellValue(Integer.parseInt(e.getCiclo()));
		row.createCell(1).setCellValue(e.getApellidoAlumno());
		row.createCell(2).setCellValue(e.getNombreAlumno());
		row.createCell(3).setCellValue(e.getTipoDNI());
		row.createCell(4).setCellValue(Long.parseLong(e.getNroDNI()));
		row.createCell(5).setCellValue(e.getFechaNac());
		row.createCell(6).setCellValue(e.getSexo());
		row.createCell(7).setCellValue(e.getNacionalidad());
		row.createCell(8).setCellValue(e.getZonaCimientos());
		row.createCell(9).setCellValue(e.getConvocatoria());
		row.createCell(10).setCellValue(e.getEscuela());
		row.createCell(11).setCellValue(e.getModalidad());
		row.createCell(12).setCellValue(e.getAnioEscolar());
		row.createCell(13).setCellValue(e.getDivision());
		String turno=null;
		turno=e.getTurno();
		////System.out.println(turno);
		turno=turno.replace("�", "n");
		turno=turno.replace("�", "N");
		////System.out.println(turno);
		row.createCell(14).setCellValue(turno);
		row.createCell(15).setCellValue(e.getRecibeOtraBeca());
		row.createCell(16).setCellValue(e.getBecaCual());
		row.createCell(17).setCellValue(e.getCalle());
		row.createCell(18).setCellValue(e.getNumero());
		row.createCell(19).setCellValue(e.getPiso());
		row.createCell(20).setCellValue(e.getCp());
		row.createCell(21).setCellValue(e.getBarrio());
		row.createCell(22).setCellValue(e.getLocalidad());
		row.createCell(23).setCellValue(e.getProvincia());
		row.createCell(24).setCellValue(e.getContacto1());
		row.createCell(25).setCellValue(e.getContacto2());
		row.createCell(26).setCellValue(e.getContacto3());
		row.createCell(27).setCellValue(e.getRepitencia());
		//row.createCell(28).setCellValue(e.getRepitenciaAnio());
		row.createCell(28).setCellValue(e.getMotivoRepitencia());
		row.createCell(29).setCellValue(e.getAbandono());
		//row.createCell(31).setCellValue(e.getAbandonoAnio());
		row.createCell(30).setCellValue(e.getMotivoAbandono());
		row.createCell(31).setCellValue(e.getConducta());
		row.createCell(32).setCellValue(e.getInformacionComplementaria());
		row.createCell(33).setCellValue(e.getPercepcionesCandidato());
		row.createCell(34).setCellValue(e.getCompromisoEscolaridad());
		row.createCell(35).setCellValue(e.getPosibilidadCompromisoPBE());
		if(e.getCantidadInasitenciasAnioPasado()!=null){
			row.createCell(36).setCellValue(Long.parseLong(e.getCantidadInasitenciasAnioPasado()));
		}		
		if(e.getCantidadInasitenciasAnioCurso()!=null){
			row.createCell(37).setCellValue(Long.parseLong(e.getCantidadInasitenciasAnioCurso()));
		}		
		//row.createCell(40).setCellValue("");
		if(e.getEgresosTotales()!=null){
			System.out.println(e.getIdRA1());
			System.out.println(e.getEgresosTotales());
			row.createCell(38).setCellValue(Long.parseLong(e.getEgresosTotales()));
		}
		if (e.getIngresosTotales()!=null){
			row.createCell(39).setCellValue(Long.parseLong(e.getIngresosTotales()));
		}		
		row.createCell(40).setCellValue(e.getObservacionIngresoEgreso());
		row.createCell(41).setCellValue(e.getObservacionesGenerales());
		row.createCell(42).setCellValue(e.getEntrevistador());
		if (e.getFechaCargaEntrevista()!=null){
			row.createCell(43).setCellValue(e.getFechaCargaEntrevista());
		}
		row.createCell(44).setCellValue(e.getEstadoAlumno());
		row.createCell(45).setCellValue(e.getEntraExcepcion());
		row.createCell(46).setCellValue(e.getFechaAsignacion()); 
		row.createCell(47).setCellValue(e.getMotivRechazo());
		row.createCell(48).setCellValue(e.getOtroMotivoRechazo());
		row.createCell(49).setCellValue(e.getMotivoEnvioTS());
		row.createCell(50).setCellValue(e.getObservacionesTS());
		row.createCell(51).setCellValue(e.getIdAlumno());
		row.createCell(52).setCellValue(e.getIdRA1());
		row.createCell(53).setCellValue(e.getIdRA2());
		row.createCell(54).setCellValue(e.getIdEntrevista());
		row.createCell(55).setCellValue(e.getApellidoRA1());
		row.createCell(56).setCellValue(e.getNombreRA1());
		row.createCell(57).setCellValue(e.getVinculoRA1());
		row.createCell(58).setCellValue(e.getTipoDNIRA1());
		
		////System.out.println(e.getIdRA1());
		////System.out.println(e.getNroDNIRA1());
		System.out.println("idra1"+ e.getIdRA1() + " dni: "+e.getNroDNIRA1());
		if (e.getNroDNIRA1()!=null){
			row.createCell(59).setCellValue(Long.parseLong(e.getNroDNIRA1()));
		}
		
		row.createCell(60).setCellValue(e.getFechaNacRA1());
		row.createCell(61).setCellValue(e.getSexoRA1());
		row.createCell(62).setCellValue(e.getNacionalidadRA1());
		row.createCell(63).setCellValue(e.getAsisteEntrevistaRA1());
		row.createCell(64).setCellValue(e.getApellidoRA2());
		row.createCell(65).setCellValue(e.getNombreRA2());
		row.createCell(66).setCellValue(e.getVinculoRA2());		
		row.createCell(67).setCellValue(e.getCompromisoEscolaridad());
		row.createCell(68).setCellValue(e.getAptoComoRA());
		row.createCell(69).setCellValue(e.getPosibilidadCompromisoPBERA());
		row.createCell(70).setCellValue(e.getSucursal());
		row.createCell(71).setCellValue(e.getRelacionVivienda());		
		
		row.createCell(242).setCellValue(e.getOtroBecado());
		
		System.out.println(e.getIdEntrevista());
		System.out.println(e.getFechaCargaEntrevista());
		
		row.createCell(243).setCellValue(e.getFechaCargaEntrevista());
		row.createCell(244).setCellValue(e.getEae());
		row.createCell(245).setCellValue(e.getOrientacion());
		
		row.createCell(72).setCellValue(e.getV1());
		row.createCell(73).setCellValue(e.getNa1());
		if(e.getEdad1()!=null){
			row.createCell(74).setCellValue(Long.parseLong(e.getEdad1()));
		}		
		row.createCell(75).setCellValue(e.getConv1());
		row.createCell(76).setCellValue(e.getMne1());
		row.createCell(77).setCellValue(e.getMa1());
		row.createCell(78).setCellValue(e.getOcu1());
		row.createCell(79).setCellValue(e.getDl1());
		row.createCell(80).setCellValue(e.getRem1());
		row.createCell(81).setCellValue(e.getOi1());		
		row.createCell(82).setCellValue(e.getV2());
		row.createCell(83).setCellValue(e.getNa2());
		if(e.getEdad2()!=null){
			row.createCell(84).setCellValue(Long.parseLong(e.getEdad2()));
		}		
		row.createCell(85).setCellValue(e.getConv2());
		row.createCell(86).setCellValue(e.getMne2());
		row.createCell(87).setCellValue(e.getMa2());
		row.createCell(88).setCellValue(e.getOcu2());
		row.createCell(89).setCellValue(e.getDl2());
		row.createCell(90).setCellValue(e.getRem2());
		row.createCell(91).setCellValue(e.getOi2());
		row.createCell(92).setCellValue(e.getV3());
		row.createCell(93).setCellValue(e.getNa3());
		if(e.getEdad3()!=null){
			row.createCell(94).setCellValue(Long.parseLong(e.getEdad3()));
		}		
		row.createCell(95).setCellValue(e.getConv3());
		row.createCell(96).setCellValue(e.getMne3());
		row.createCell(97).setCellValue(e.getMa3());
		row.createCell(98).setCellValue(e.getOcu3());
		row.createCell(99).setCellValue(e.getDl3());
		row.createCell(100).setCellValue(e.getRem3());
		row.createCell(101).setCellValue(e.getOi3());
		
		row.createCell(102).setCellValue(e.getV4());
		row.createCell(103).setCellValue(e.getNa4());
		if(e.getEdad4()!=null){
			row.createCell(104).setCellValue(Long.parseLong(e.getEdad4()));
		}		
		row.createCell(105).setCellValue(e.getConv4());
		row.createCell(106).setCellValue(e.getMne4());
		row.createCell(107).setCellValue(e.getMa4());
		row.createCell(108).setCellValue(e.getOcu4());
		row.createCell(109).setCellValue(e.getDl4());
		row.createCell(110).setCellValue(e.getRem4());
		row.createCell(111).setCellValue(e.getOi4());
		
		row.createCell(112).setCellValue(e.getV5());
		row.createCell(113).setCellValue(e.getNa5());
		if(e.getEdad5()!=null){
			row.createCell(114).setCellValue(Long.parseLong(e.getEdad5()));
		}		
		row.createCell(115).setCellValue(e.getConv5());
		row.createCell(116).setCellValue(e.getMne5());
		row.createCell(117).setCellValue(e.getMa5());
		row.createCell(118).setCellValue(e.getOcu5());
		row.createCell(119).setCellValue(e.getDl15());
		row.createCell(120).setCellValue(e.getRem5());
		row.createCell(121).setCellValue(e.getOi5());
		
		row.createCell(122).setCellValue(e.getV6());
		row.createCell(123).setCellValue(e.getNa6());
		if(e.getEdad6()!=null){
			row.createCell(124).setCellValue(Long.parseLong(e.getEdad6()));
		}		
		row.createCell(125).setCellValue(e.getConv6());
		row.createCell(126).setCellValue(e.getMne6());
		row.createCell(127).setCellValue(e.getMa6());
		row.createCell(128).setCellValue(e.getOcu6());
		row.createCell(129).setCellValue(e.getDl6());
		row.createCell(130).setCellValue(e.getRem6());
		row.createCell(131).setCellValue(e.getOi6());
		
		row.createCell(132).setCellValue(e.getV7());
		row.createCell(133).setCellValue(e.getNa7());
		if(e.getEdad7()!=null){
			row.createCell(134).setCellValue(Long.parseLong(e.getEdad7()));
		}		
		row.createCell(135).setCellValue(e.getConv7());
		row.createCell(136).setCellValue(e.getMne7());
		row.createCell(137).setCellValue(e.getMa7());
		row.createCell(138).setCellValue(e.getOcu7());
		row.createCell(139).setCellValue(e.getDl7());
		row.createCell(140).setCellValue(e.getRem7());
		row.createCell(141).setCellValue(e.getOi7());
		
		row.createCell(142).setCellValue(e.getV8());
		row.createCell(143).setCellValue(e.getNa8());
		if(e.getEdad8()!=null){
			row.createCell(144).setCellValue(Long.parseLong(e.getEdad8()));
		}		
		row.createCell(145).setCellValue(e.getConv8());
		row.createCell(146).setCellValue(e.getMne8());
		row.createCell(147).setCellValue(e.getMa8());
		row.createCell(148).setCellValue(e.getOcu8());
		row.createCell(149).setCellValue(e.getDl8());
		row.createCell(150).setCellValue(e.getRem8());
		row.createCell(151).setCellValue(e.getOi8());
		
		row.createCell(152).setCellValue(e.getV9());
		row.createCell(153).setCellValue(e.getNa9());
		if(e.getEdad9()!=null){
			row.createCell(154).setCellValue(Long.parseLong(e.getEdad9()));
		}		
		row.createCell(155).setCellValue(e.getConv9());
		row.createCell(156).setCellValue(e.getMne9());
		row.createCell(157).setCellValue(e.getMa9());
		row.createCell(158).setCellValue(e.getOcu9());
		row.createCell(159).setCellValue(e.getDl9());
		row.createCell(160).setCellValue(e.getRem9());
		row.createCell(161).setCellValue(e.getOi9());
		
		row.createCell(162).setCellValue(e.getV10());
		row.createCell(163).setCellValue(e.getNa10());
		if(e.getEdad10()!=null){
			row.createCell(164).setCellValue(Long.parseLong(e.getEdad10()));
		}		
		row.createCell(165).setCellValue(e.getConv10());
		row.createCell(166).setCellValue(e.getMne10());
		row.createCell(167).setCellValue(e.getMa10());
		row.createCell(168).setCellValue(e.getOcu10());
		row.createCell(169).setCellValue(e.getDl10());
		row.createCell(170).setCellValue(e.getRem10());
		row.createCell(171).setCellValue(e.getOi10());
		
		row.createCell(172).setCellValue(e.getV11());
		row.createCell(173).setCellValue(e.getNa11());
		if(e.getEdad11()!=null){
			row.createCell(174).setCellValue(Long.parseLong(e.getEdad11()));
		}		
		row.createCell(175).setCellValue(e.getConv11());
		row.createCell(176).setCellValue(e.getMne11());
		row.createCell(177).setCellValue(e.getMa11());
		row.createCell(178).setCellValue(e.getOcu11());
		row.createCell(179).setCellValue(e.getDl11());
		row.createCell(180).setCellValue(e.getRem11());
		row.createCell(181).setCellValue(e.getOi11());
		
		row.createCell(182).setCellValue(e.getV12());
		row.createCell(183).setCellValue(e.getNa12());
		if(e.getEdad12()!=null){
			row.createCell(184).setCellValue(Long.parseLong(e.getEdad12()));
		}	
		row.createCell(185).setCellValue(e.getConv12());
		row.createCell(186).setCellValue(e.getMne12());
		row.createCell(187).setCellValue(e.getMa12());
		row.createCell(188).setCellValue(e.getOcu12());
		row.createCell(189).setCellValue(e.getDl12());
		row.createCell(190).setCellValue(e.getRem12());
		row.createCell(191).setCellValue(e.getOi12());
		
		row.createCell(192).setCellValue(e.getV13());
		row.createCell(193).setCellValue(e.getNa13());
		if(e.getEdad13()!=null){
			row.createCell(194).setCellValue(Long.parseLong(e.getEdad13()));
		}	
		row.createCell(195).setCellValue(e.getConv13());
		row.createCell(196).setCellValue(e.getMne13());
		row.createCell(197).setCellValue(e.getMa13());
		row.createCell(198).setCellValue(e.getOcu13());
		row.createCell(199).setCellValue(e.getDl13());
		row.createCell(200).setCellValue(e.getRem13());
		row.createCell(201).setCellValue(e.getOi13());
		
		row.createCell(202).setCellValue(e.getV14());
		row.createCell(203).setCellValue(e.getNa14());
		if(e.getEdad14()!=null){
			row.createCell(204).setCellValue(Long.parseLong(e.getEdad14()));
		}		
		row.createCell(205).setCellValue(e.getConv14());
		row.createCell(206).setCellValue(e.getMne14());
		row.createCell(207).setCellValue(e.getMa14());
		row.createCell(208).setCellValue(e.getOcu14());
		row.createCell(209).setCellValue(e.getDl14());
		row.createCell(210).setCellValue(e.getRem14());
		row.createCell(211).setCellValue(e.getOi14());
		
		row.createCell(212).setCellValue(e.getV15());
		row.createCell(213).setCellValue(e.getNa15());
		if(e.getEdad15()!=null){
			row.createCell(214).setCellValue(Long.parseLong(e.getEdad15()));
		}		
		row.createCell(215).setCellValue(e.getConv15());
		row.createCell(216).setCellValue(e.getMne15());
		row.createCell(217).setCellValue(e.getMa15());
		row.createCell(218).setCellValue(e.getOcu15());
		row.createCell(219).setCellValue(e.getDl15());
		row.createCell(220).setCellValue(e.getRem15());
		row.createCell(221).setCellValue(e.getOi15());	
		
		//boletin
		
		
        Connection cn3 = null;
        CallableStatement cl3 = null;
        ResultSet rs3 = null;
        try {
            //Nombre del procedimiento almacenado
            String call3 = "select " + 
            			" boletin_seleccion.*, "+
            			" nombre, entrevista_seleccion_boletin_seleccions.* "+ 
						" from boletin_seleccion , materia, entrevista_seleccion_boletin_seleccions "+
						" where boletin_seleccion.materia=materia.id "+
						" and entrevista_seleccion_boletin_seleccions.boletin_seleccions=boletin_seleccion.id "+
						" and entrevista_seleccion_boletin_seleccions.entrevista_seleccion='"+e.getIdEntrevista()+"'"+
						" order by materia;";
            ////System.out.println(call3);
            cn3 = Conexion.getConexion();
            cl3 = cn3.prepareCall(call3);
            //cl1.setLong(1, codigo1);
            //La sentencia lo almacenamos en un resulset
            rs3 = cl3.executeQuery();
            //Consultamos si hay datos para recorrerlo
            //e insertarlo en nuestro array
            int contador=0;
            String notas="";
            while (rs3.next()) {
                //Obtenemos los valores de la consulta y creamos
                //nuestro objeto producto
            	notas="";
            	if (rs3.getString(7)!=null){
            		notas=notas+rs3.getString(7)+", ";
            	}else{
            		notas=notas+"-, ";
            	}
            	if (rs3.getString(6)!=null){
            		notas=notas+rs3.getString(6)+", ";
            	}else{
            		notas=notas+"-, ";
            	}
            	if (rs3.getString(5)!=null){
            		notas=notas+rs3.getString(5)+", ";
            	}else{
            		notas=notas+"-, ";
            	}
            	if (rs3.getString(3)!=null){
            		notas=notas+rs3.getString(3)+", ";
            	}else{
            		notas=notas+"-, ";
            	}
            	if (rs3.getString(2)!=null){
            		notas=notas+rs3.getString(2)+", ";
            	}else{
            		notas=notas+"-, ";
            	}
            	if (rs3.getString(4)!=null){
            		notas=notas+rs3.getString(4)+", ";
            	}else{
            		notas=notas+"-, ";
            	}

            	
            	if (contador==0){
            		row.createCell(222).setCellValue(notas);
            	}
            	if (contador==1){
            		row.createCell(223).setCellValue(notas);
            	}
            	if (contador==2){
            		row.createCell(224).setCellValue(notas);
            	}
            	if (contador==3){
            		row.createCell(225).setCellValue(notas);
            	}
            	if (contador==4){
            		row.createCell(226).setCellValue(notas);
            	}
            	if (contador==5){
            		row.createCell(227).setCellValue(notas);
            	}
            	if (contador==6){
            		row.createCell(228).setCellValue(notas);
            	}
            	if (contador==7){
            		row.createCell(229).setCellValue(notas);
            	}
            	if (contador==8){
            		row.createCell(230).setCellValue(notas);
            	}
            	if (contador==9){
            		row.createCell(231).setCellValue(notas);
            	}
            	if (contador==10){
            		row.createCell(232).setCellValue(notas);
            	}
            	if (contador==11){
            		row.createCell(233).setCellValue(notas);
            	}
            	if (contador==12){
            		row.createCell(234).setCellValue(notas);
            	}
            	if (contador==13){
            		row.createCell(235).setCellValue(notas);
            	}
            	if (contador==14){
            		row.createCell(236).setCellValue(notas);
            	}
            	if (contador==15){
            		row.createCell(237).setCellValue(notas);
            	}
            	if (contador==16){
            		row.createCell(238).setCellValue(notas);
            	}
            	if (contador==17){
            		row.createCell(239).setCellValue(notas);
            	}
            	if (contador==18){
            		row.createCell(240).setCellValue(notas);
            	}
            	if (contador==19){
            		row.createCell(241).setCellValue(notas);
            	}
            	contador++;
            	////System.out.println(notas);
            	
            	
            	
            }
            Conexion.cerrarCall(cl3);
            Conexion.cerrarConexion(cn3);
        } catch (SQLException ee) {
            ee.printStackTrace();
            Conexion.cerrarCall(cl3);
            Conexion.cerrarConexion(cn3);
        } catch (Exception ee) {
            ee.printStackTrace();
            Conexion.cerrarCall(cl3);
            Conexion.cerrarConexion(cn3);
        }
        
		
		
		
		
		
		
	}
		
	

	public String getMotivoRenovacionUnificado(EntrevistaIndividual e) {
		String valor = "";
		if(e.getTipoEntrevista().equals(TipoEntrevista.RENOVACION)){
			EntrevistaRenovacion er = (EntrevistaRenovacion) e;
			if(er.getEvaluacionRenovacionMergeada() != null){
					if(er.getEvaluacionRenovacionMergeada() == EvaluacionRenovacionMergeada.PENDIENTE){
						if(er.getMotivoPendiente() != null && er.getMotivoPendiente() != MotivoPendiente.OTRO)
							valor = er.getMotivoPendiente().getValor();
						else
							if(er.getMotivoPendiente() != null && er.getMotivoPendiente() == MotivoPendiente.OTRO)
								valor =  "Otro," + (er.getMotivoOtro()!=null?er.getMotivoOtro():"");				
					}
					else if(er.getEvaluacionRenovacionMergeada() == EvaluacionRenovacionMergeada.NO_RENUEVA){
							if(er.getMotivoNoRenovacion() != null)
								valor = er.getMotivoNoRenovacion().getValor();							
						}
						else
							valor = NO_APLICA;
			}
		}
		else if(e.getTipoEntrevista().equals(TipoEntrevista.FINAL)){			
				EntrevistaFinal ef = (EntrevistaFinal) e;
				if(ef.getEvaluacionRenovacionFinal() != null){
					if(ef.getEvaluacionRenovacionFinal() == EvaluacionRenovacionFinal.NO_RENUEVA){
						if(ef.getMotivoNoRenovacion() != null)
							valor = ef.getMotivoNoRenovacion().getValor();			
					}
					else
						valor = NO_APLICA;
				}
		}
		else
			valor = NO_APLICA;
		
		return valor;
	}
	
	
	public String getMotivoIncorporacion(EntrevistaIndividual e) {
		if(e.getTipoEntrevista().equals(TipoEntrevista.INCORPORACION)){				
			EntrevistaReIncorporacion ei = (EntrevistaReIncorporacion) e; 
			if(ei.getIncorporacion() != null){
				if(ei.getIncorporacion() == EvaluacionIncorporacion.INCORPORA)
					return NO_APLICA;
				else
					if(ei.getIncorporacion() == EvaluacionIncorporacion.INCORPORAPENDIENTE)
						if(ei.getMotivoPendiente() != null 	&& ei.getMotivoPendiente() != MotivoIncorporacionPendiente.OTROMOTIVO)
							return ei.getMotivoPendiente().getValor();
						else
							return "Otro," + (ei.getMotivoOtroPendiente()!=null?ei.getMotivoOtroPendiente():"");
					else
						if(ei.getMotivoNoIncorporacion() != null && ei.getMotivoNoIncorporacion() != motivoNoIncorporacion.OTRO)
							return ei.getMotivoNoIncorporacion().getValor();
						else
							return "Otro," + (ei.getMotivoOtroPendiente()!=null?ei.getMotivoOtroPendiente():"");
			}
			else
				return "";
		}
		else
			return NO_APLICA;
	}
	
	public String getFechaEntrevista(EntrevistaIndividual entrevista) {
		if(entrevista.getFechaEntrevista()!= null){
			return Formateador.formatearFecha(entrevista.getFechaEntrevista(), PATRON_FECHA) ;
		}
		return "";
	}
	
	public String getCantidadInasistencias(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.MENSUAL) || entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL)){
			valor = entrevista.getCantidadInasistencias()!= null ? Float.toString(entrevista.getCantidadInasistencias()) : "";
		}
		return valor;
	}
	
	public String getLugarProximaEntrevista(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(!entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL) ){
			valor = entrevista.getLugarProximaEntrevista() != null ? entrevista.getLugarProximaEntrevista().getNombre()
					: "";
		}
		return valor;
	}
	
	public String getHoraProximaEntrevista(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(!entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL) ){
			valor = entrevista.getHoraProxEntrevista()!=null?entrevista.getHoraProxEntrevista():"";
		}
		return valor;
	}
	
	public String getExpectativasRA(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.RENOVACION)){
			EntrevistaRenovacion er = (EntrevistaRenovacion)entrevista;
			if(er.getEvaluacionRenovacionMergeada() != null)
				if(er.getEvaluacionRenovacionMergeada().equals(EvaluacionRenovacionMergeada.RENUEVA)){
					valor = er.getExpectativasRA();
			}
			else{
				valor = "";
			}
		}else if(entrevista.getTipoEntrevista().equals(TipoEntrevista.INCORPORACION)){
				EntrevistaReIncorporacion eri = (EntrevistaReIncorporacion)entrevista;
				if(eri.getIncorporacion() != null)
					if(eri.getIncorporacion().equals(EvaluacionIncorporacion.INCORPORA)){
						valor = eri.getExpectativasRA();
				}
				else{
					valor = "";
				}			
		}
		return valor;
	}
	
	public String getDestinoDineroBeca(EntrevistaIndividual entrevista) {
		StringBuffer valor = new StringBuffer(NO_APLICA);
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.RENOVACION)){
			EntrevistaRenovacion er = (EntrevistaRenovacion)entrevista;
			if(er.getEvaluacionRenovacionMergeada() != null){
				if(er.getEvaluacionRenovacionMergeada().equals(EvaluacionRenovacionMergeada.RENUEVA)){
					valor = new StringBuffer();
					if(!entrevista.getDestinoDinero().isEmpty()){
						for (DetalleGastos destino : entrevista.getDestinoDinero()) {
							valor.append( destino.getValor() + ", ");
						}
						valor.deleteCharAt(valor.lastIndexOf(","));
					}	
				}
			}
			else{				valor =  new StringBuffer("");
			}
		}else if(entrevista.getTipoEntrevista().equals(TipoEntrevista.INCORPORACION)){ 
				EntrevistaReIncorporacion eri = (EntrevistaReIncorporacion)entrevista;
				if(eri.getIncorporacion() != null){
					if(eri.getIncorporacion().equals(EvaluacionIncorporacion.INCORPORA)){
						valor = new StringBuffer();
						if(!entrevista.getDestinoDinero().isEmpty()){
							for (DetalleGastos destino : entrevista.getDestinoDinero()) {
								valor.append( destino.getValor() + ", ");
							}
							valor.deleteCharAt(valor.lastIndexOf(","));
						}
					}
				}
				else{
					valor =  new StringBuffer("");
				}
			}
		return valor.toString();
	}
	
	public String getSituacionCrisis(EntrevistaIndividual entrevista) {
		StringBuffer valor = new StringBuffer(NO_APLICA);
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.MENSUAL)){
			valor = new StringBuffer();
			if(!entrevista.getSituacionCrisis().isEmpty()){
				for (SituacionCrisis crisis : entrevista.getSituacionCrisis()) {
					valor.append( crisis.getValor() + ", ");
				}
				valor.deleteCharAt(valor.lastIndexOf(","));
			}
		}
		return valor.toString();
	}
	
	public String getRecomendacionEstrategiaComplementaria(EntrevistaIndividual entrevista) {
		StringBuffer valor = new StringBuffer(NO_APLICA);
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.MENSUAL) ){
			valor = new StringBuffer();
			if(!entrevista.getEstrategiaComp().isEmpty()){
				for (EstrategiaComplementaria estrategia : entrevista.getEstrategiaComp()) {
					valor.append( estrategia.getValor() + ", ");
				}
				valor.deleteCharAt(valor.lastIndexOf(","));
			}
			
		}
		return valor.toString();
	}
	
	public String getContenidosAbordados(EntrevistaIndividual entrevista) {
		StringBuffer valor = new StringBuffer(NO_APLICA);
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.MENSUAL)){
			valor = new StringBuffer();
			if(!entrevista.getContenidosAbordados().isEmpty()){
				for (ContenidosAbordados contenido : entrevista.getContenidosAbordados()) {
					valor.append( contenido.getValor() + ", ");
				}
				valor.deleteCharAt(valor.lastIndexOf(","));
			}	
		}
		return valor.toString();
	}
	
	public String getCompromisoRAEscolaridad(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.MENSUAL)){
			valor = entrevista.getCompromisoRA() != null ? entrevista.getCompromisoRA().getValor() : "";
		}
		return valor;
	}
	
	public String getHoraEntrevistaFebreroMarzo(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL)){
			valor = ((EntrevistaFinal)entrevista).getHoraProxEntrevista();
		}
		return valor;
	}

	/**
	 * @return the lugarEntrevistaFebreroMarzo
	 */
	public String getLugarEntrevistaFebreroMarzo(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL)){
			valor = ((EntrevistaFinal)entrevista).getLugarProximaEntrevista() != null ? ((EntrevistaFinal)entrevista).getLugarProximaEntrevista().getNombre()
					: "";
		}
		return valor;
	}
	
	public String getFechaEntrevistaFebreroMarzo(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL)){
			EntrevistaFinal entrevFinal = (EntrevistaFinal)entrevista;
			valor = entrevFinal.getFechaEntrevFebMarzo() != null ?
					Formateador.formatearFecha( ((EntrevistaFinal)entrevista).getFechaEntrevFebMarzo(), PATRON_FECHA)
					: "";
		}
		return valor;
	}
	
	public String getProyeccionAnioProximoFinalizacionPBE(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL) 
				&& ((EntrevistaFinal)entrevista).getProyAnioProximo() != null){
			valor = ((EntrevistaFinal)entrevista).getProyAnioProximo().getValor();
		}
		return valor;
	}
	
	public String getCambioEscuelaProximoAnio(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL)){
			valor = ((EntrevistaFinal)entrevista).getCambioEscuelaProxAnio();
		}
		return valor;
	}
	
	public String getEvaluacionPropositoAnual(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL)){
			valor = ((EntrevistaFinal)entrevista).getEvaluacionProposito();
		}
		return valor;
	}

	/**
	 * @return the resultadoAnioEscolar
	 */
	public String getResultadoAnioEscolar(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL)){
			valor = ((EntrevistaFinal)entrevista).getSituacionEscolarMergeada() != null ?((EntrevistaFinal)entrevista).getSituacionEscolarMergeada().getValor() : "";
		}
		return valor;
	}
	
	public String getDetalleGastos(EntrevistaIndividual entrevista) {
		StringBuffer valor = new StringBuffer(NO_APLICA);
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.MENSUAL) || entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL)){ 
			valor = new StringBuffer();
			if(!entrevista.getDetalleGastos().isEmpty()){
				for (DetalleGastos detalle : entrevista.getDetalleGastos()) {
					valor.append( detalle.getValor() + ", ");
				}
				valor.deleteCharAt(valor.lastIndexOf(","));
			}			
		}		
		return valor.toString();
	}
	
	public String getRendicionGastos(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.MENSUAL)){
			valor = ((EntrevistaIndividual)entrevista).isRendicionGastos() ? SI : NO;
		}else if(entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL)){
			valor = ((EntrevistaFinal)entrevista).isRendicionGastos() ? SI : NO;
		}
		return valor;
	}
	
	public String getMotivoInasistencias(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.MENSUAL)){
			valor = ((EntrevistaIndividual)entrevista).getMotivoInasistencia();
		}else if(entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL)){
			valor = ((EntrevistaFinal)entrevista).getMotivoInasistencia();
		}
		return valor;
	}
	
	public String getMateriasFechasDiciembre(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL)){
			valor = ((EntrevistaFinal)entrevista).getMateriasRendirDiciembre();
		}
		return valor;
	}
	
	public String getParticipoRA(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getEntrevistaGrupal() == null){
			valor = entrevista.isParticipoRA()? SI : NO;
		}
		return valor;
	}
	
	public String getEntrevistaReprogramada(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.MENSUAL)){
			valor = entrevista.getEntrevistaReprogramada() != null ? 
					entrevista.getEntrevistaReprogramada().getValor() : "";
		}
		return valor;
	}
	
	public String getFechaIncorporacionPBE(EntrevistaIndividual entrevista) {
		return entrevista.getPerfilAlumno().getFechaPBE() != null ? 
				Formateador.formatearFecha(entrevista.getPerfilAlumno().getFechaPBE(), PATRON_FECHA) :
					"";
	}
	
	public String getFechaReIncorporacionPBE(EntrevistaIndividual entrevista) {
		return entrevista.getPerfilAlumno().getFechaReincorporacionPBE() != null ? 
				Formateador.formatearFecha(entrevista.getPerfilAlumno().getFechaReincorporacionPBE(), PATRON_FECHA) :
					NO_APLICA;
	}
	
	public String getPropositoAnioComienzaList(EntrevistaIndividual entrevista) {
		StringBuffer valor = new StringBuffer(NO_APLICA);
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.RENOVACION)){ 
			EntrevistaRenovacion er = (EntrevistaRenovacion)entrevista;
			if(er.getEvaluacionRenovacionMergeada() != null){
					if(er.getEvaluacionRenovacionMergeada().equals(EvaluacionRenovacionMergeada.RENUEVA)){
					valor = new StringBuffer();
					EntrevistaRenovacion entrevistaRenovacion = (EntrevistaRenovacion)entrevista;
					if(!entrevistaRenovacion.getPropositoAnioComienzaList().isEmpty()){
						for (PropositoAnioComienza proposito : entrevistaRenovacion.getPropositoAnioComienzaList()) {
							valor.append( proposito.getValor() + ", ");
						}
						valor.deleteCharAt(valor.lastIndexOf(","));
					}
				}
			}
			else{
				valor = new StringBuffer("");
			}
		}
		return valor.toString();
	}
	
	public String getIncorporacion(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.INCORPORACION)){
			valor = ((EntrevistaReIncorporacion)entrevista).getIncorporacion() != null ? 
					((EntrevistaReIncorporacion)entrevista).getIncorporacion().getValor()
					: "";
		}
		return valor;
	}
	
	public String getSituacionEscolarDiciembre(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.RENOVACION)){
			valor = ((EntrevistaRenovacion)entrevista).getSituacionEscolarDiciembre() != null ?
					((EntrevistaRenovacion)entrevista).getSituacionEscolarDiciembre().getValor()
					: "";
		}
		return valor;
	}
	
	
	public String getSituacionRenovacionDiciembre(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.RENOVACION)){
			valor = ((EntrevistaRenovacion)entrevista).getEvaluacionRenovacionFinal() != null ?
					((EntrevistaRenovacion)entrevista).getEvaluacionRenovacionFinal().getValor() :
						"";
		}
		return valor;
	}


	public String getSituacionEscolar(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.RENOVACION)){
			valor = ((EntrevistaRenovacion)entrevista).getSituacionEscolarMergeada() != null ?
							((EntrevistaRenovacion)entrevista).getSituacionEscolarMergeada().getValor():
								"";
		}
		return valor;
	}


	public String getSituacionRenovacion(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.RENOVACION)){
			valor = ((EntrevistaRenovacion)entrevista).getEvaluacionRenovacionMergeada() != null ? 
					((EntrevistaRenovacion)entrevista).getEvaluacionRenovacionMergeada().getValor() :
						"";
		}else if(entrevista.getTipoEntrevista().equals(TipoEntrevista.FINAL)){
			valor = ((EntrevistaFinal)entrevista).getEvaluacionRenovacionFinal() != null ?
					((EntrevistaFinal)entrevista).getEvaluacionRenovacionFinal().getValor() :
						"";
		}
		return valor;
	}
	
	public String getRealizoEntrevista(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.RENOVACION)){
			if(((EntrevistaRenovacion)entrevista).getEvaluacionRenovacionMergeada() != null && 
					((EntrevistaRenovacion)entrevista).getEvaluacionRenovacionMergeada() != EvaluacionRenovacionMergeada.RENUEVA)
			valor = (((EntrevistaRenovacion)entrevista).isRealizoEntrevista()? SI : NO);
		}else if(entrevista.getTipoEntrevista().equals(TipoEntrevista.INCORPORACION)){
			if(((EntrevistaReIncorporacion)entrevista).getIncorporacion() != null && 
					((EntrevistaReIncorporacion)entrevista).getIncorporacion() != EvaluacionIncorporacion.INCORPORA)
			valor = (((EntrevistaReIncorporacion)entrevista).isRealizoEntrevista()? SI : NO);
		}
		return valor;
	}
	
	public String getObservacionesMateriasExamenes(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.RENOVACION)){
			valor = ((EntrevistaRenovacion)entrevista).getObservacionMateriasExamenes();
		}
		return valor;
	}
	
	public String getEvolucionMesAnterior(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.MENSUAL) 
				&& ((EntrevistaIndividual)entrevista).getEvolucionMesAnterior() != null){
			valor = ((EntrevistaIndividual)entrevista).getEvolucionMesAnterior();
		}
		return valor;
	}
	
	public String getLogros(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.MENSUAL) 
				&& ((EntrevistaIndividual)entrevista).getLogros() != null){
			valor = ((EntrevistaIndividual)entrevista).getLogros();
		}
		return valor;
	}
	
	public String getDificultades(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.MENSUAL) 
				&& ((EntrevistaIndividual)entrevista).getDificultades() != null){
			valor = ((EntrevistaIndividual)entrevista).getDificultades();
		}
		return valor;
	}
	
	public String getProposito(EntrevistaIndividual entrevista) {
		String valor = NO_APLICA;
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.MENSUAL) 
				&& ((EntrevistaIndividual)entrevista).getProposito() != null){
			valor = ((EntrevistaIndividual)entrevista).getProposito();
		}
		return valor;
	}
}