package org.cimientos.intranet.utils.entrevistas;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaFinal;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaIndividual;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaReIncorporacion;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaRenovacion;
import org.cimientos.intranet.servicio.CicloProgramaSrv;
import org.cimientos.intranet.servicio.EntrevistaSrv;
import org.cimientos.intranet.utils.ExportacionEspecialHelper;
import org.cimientos.intranet.utils.Formateador;
import org.cimientos.intranet.web.controller.Conexion;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.cimientos.intranet.enumerativos.entrevista.ContenidosAbordados;
import com.cimientos.intranet.enumerativos.entrevista.DetalleGastos;
import com.cimientos.intranet.enumerativos.entrevista.EstrategiaComplementaria;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionCobroBeca;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionIncorporacion;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionRenovacionFinal;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionRenovacionMergeada;
import com.cimientos.intranet.enumerativos.entrevista.MotivoAusencia;
import com.cimientos.intranet.enumerativos.entrevista.MotivoIncorporacionPendiente;
import com.cimientos.intranet.enumerativos.entrevista.MotivoPendiente;
import com.cimientos.intranet.enumerativos.entrevista.PropositoAnioComienza;
import com.cimientos.intranet.enumerativos.entrevista.SituacionCrisis;
import com.cimientos.intranet.enumerativos.entrevista.TipoContacto;
import com.cimientos.intranet.enumerativos.entrevista.TipoEntrevista;
import com.cimientos.intranet.enumerativos.entrevista.motivoNoIncorporacion;

public class EntrevistaExcelView extends AbstractExcelView{
	
	private static int bachSize = 1000;
	private static final String PATRON_FECHA = "dd/MM/yyyy";
	private static final String NO_APLICA = "No aplica";
	private static final String SI = "Si";
	private static final String NO = "No";

	
	
	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String,Object> model, HSSFWorkbook workbook,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		CicloProgramaSrv cicloSrv = (CicloProgramaSrv) model.get("cicloSrv");
		
		EntrevistaSrv entrevistaSrv = (EntrevistaSrv) model.get("entrevistaSrv");
		
		ExportacionEspecialHelper exportacionHelper = (ExportacionEspecialHelper) model.get("exportacionHelper");
		
		HSSFSheet sheet = workbook.getSheet("entrevistas_nuevo");
		
		List<Long> idsCiclo = (List<Long>) model.get("idsCiclo");
		List<Integer> idsTipo = (List<Integer>) model.get("idsTipo");
		List<Integer> idsEstado = (List<Integer>) model.get("idsEstado");
		List<Integer> idsSituacion = (List<Integer>) model.get("idsSituacion");
		List<Long> idsPeriodo = (List<Long>) model.get("idsPeriodo");
		Integer idForma = (Integer) model.get("idForma");
		Long idPadrino = (Long) model.get("idPadrino");
		Long idZona = (Long) model.get("idZona");
		Long idRR = (Long) model.get("idRR");
		Long idEa = (Long) model.get("idEa");
		String nombreAlum = (String) model.get("nombreAlum");
		String eae = (String) model.get("eae");		
		List<Integer> idsAnioEscolar = (List<Integer>) model.get("idsAnioEscolar");
		Boolean adicional = (Boolean) model.get("adicional");
		Long idEscuela = (Long) model.get("idEscuela");
		List<Integer> idsEstadoRenovacion = (List<Integer>) model.get("idsEstadoRenovacion"); 
		List<Integer> idsMotivoNoRenovacion = (List<Integer>) model.get("idsMotivoNoRenovacion");
		List<Integer> idsMotivoPendiente = (List<Integer>) model.get("idsMotivoPendiente");
		List<Integer> idsMotivoSuspension = (List<Integer>) model.get("idsMotivoSuspension");
		List<Integer> idsMotivoCesacion = (List<Integer>) model.get("idsMotivoCesacion");
		List<Integer> idsEstadoIncorporacion = (List<Integer>) model.get("idsEstadoIncorporacion");
		List<Integer> idsMotivoIncorporacionPendiente = (List<Integer>) model.get("idsMotivoIncorporacionPendiente");
		List<Integer> idsMotivoNoIncorporacion = (List<Integer>) model.get("idsMotivoNoIncorporacion");
		List<Integer> idsEstadoEntrevista = (List<Integer>) model.get("idsEstadoEntrevista");
		List<Integer> idsSituacioneEscolares = (List<Integer>) model.get("idsSituacionEscolar");	
		
		//System.out.println("eae: "+eae);
		List<CicloPrograma> ciclo = null;
		if (idsCiclo!=null && idsCiclo.size()>0){
			ciclo = new ArrayList<CicloPrograma>();
			CicloPrograma valor;
			for (Long id:idsCiclo){
				valor = cicloSrv.obtenerCiclo(id);
				if (valor!=null)
					ciclo.add(valor);
			}
		}		
		
		int totalRows = entrevistaSrv.obtenerCantidadEntrevistasAExportar(ciclo, idsTipo, idsEstado, idsSituacion, idsPeriodo,
				idForma, idPadrino, idZona, idRR, idEa, nombreAlum,idsAnioEscolar,adicional,idEscuela, idsEstadoRenovacion,
				idsMotivoNoRenovacion, idsMotivoPendiente, idsMotivoSuspension, idsMotivoCesacion, idsEstadoIncorporacion,
				idsMotivoIncorporacionPendiente, idsMotivoNoIncorporacion, idsEstadoEntrevista, idsSituacioneEscolares,eae);
		
		List<EntrevistaIndividual> entrevistas = null;
		int rowNum = 1;
		int parcial = 0;
		int inicial = 0;
		HSSFRow row;
		while (parcial < totalRows) {
			parcial = parcial + bachSize;
			
			entrevistas = entrevistaSrv.obtenerEntrevistasAExportar(ciclo, idsTipo, idsEstado, idsSituacion, idsPeriodo,
					idForma, idPadrino, idZona, idRR, idEa, nombreAlum,idsAnioEscolar,adicional,idEscuela, idsEstadoRenovacion,
					idsMotivoNoRenovacion, idsMotivoPendiente, idsMotivoSuspension, idsMotivoCesacion, idsEstadoIncorporacion,
					idsMotivoIncorporacionPendiente, idsMotivoNoIncorporacion, idsEstadoEntrevista, idsSituacioneEscolares
					,inicial, bachSize,null, null,eae);			
		
			if(sheet != null){
				for (EntrevistaIndividual e : entrevistas) {
					row = sheet.createRow(rowNum++);
					crearFila(e, exportacionHelper, row);
				}		
			}
			inicial = parcial;
			entrevistas = null;
		}	
	}

	
	private void crearFila(EntrevistaIndividual e, ExportacionEspecialHelper exportacionHelper, HSSFRow row) {
		row.createCell(0).setCellValue(e.getPerfilAlumno().getId());
		row.createCell(1).setCellValue(e.getPeriodoEntrevista() + "-" + e.getCicloLectivo());
		row.createCell(2).setCellValue(e.getEscuelaAlumno().getId());
		row.createCell(3).setCellValue(e.getEscuela());		
		row.createCell(4).setCellValue(e.getAnioEscolar().getValor());
		row.createCell(5).setCellValue(e.getPerfilAlumno().getAnioAdicional()?"Si":"No");		
		row.createCell(6).setCellValue(e.getApellidoAlumno() +", "+ e.getNombreAlumno());
		row.createCell(7).setCellValue(e.getZonaCimientos());
		row.createCell(8).setCellValue(e.getResponsableRegional());
		row.createCell(9).setCellValue(e.getNombreEa());
		row.createCell(10).setCellValue(e.getFormaEntrevista());
		row.createCell(11).setCellValue(e.getTipoEntrevista().getValor());		
		row.createCell(12).setCellValue(Formateador.formatearFecha(e.getFechaCarga() , PATRON_FECHA));
		row.createCell(13).setCellValue(e.getPerfilAlumno().getDatosPersonales().getDni());
		row.createCell(14).setCellValue(e.getExportacionEspecial().getEdad()!=null?e.getExportacionEspecial().getEdad():0);
		row.createCell(15).setCellValue(e.getPerfilAlumno().getDatosPersonales().getSex());
		row.createCell(16).setCellValue(getIncorporacion(e));		
		row.createCell(17).setCellValue(getMotivoIncorporacion(e));		
		row.createCell(18).setCellValue(getSituacionEscolarDiciembre(e));
		row.createCell(19).setCellValue(getSituacionRenovacionDiciembre(e));
		row.createCell(20).setCellValue(getSituacionEscolar(e));
		row.createCell(21).setCellValue(getSituacionRenovacion(e));		
		row.createCell(22).setCellValue(getMotivoRenovacionUnificado(e));		
		row.createCell(23).setCellValue(getPropositoAnioComienza(e));		
		row.createCell(24).setCellValue(getFechaIncorporacionPBE(e));
		row.createCell(25).setCellValue(e.isParticipoBecado()? SI : NO);		
		if(e.isParticipoBecado()){
			row.createCell(26).setCellValue("");
		}else{
			row.createCell(26).setCellValue(getMotivoAusenciaBecadoUnificado(e));
		}	
		row.createCell(27).setCellValue(getMateriasFechasDiciembre(e));
		row.createCell(28).setCellValue(exportacionHelper.getMateriasFechasFebreroMarzo(e));
		row.createCell(29).setCellValue(getCantidadInasistencias(e));
		row.createCell(30).setCellValue((e.getMotivoInasistenciaR()));
		
		
		// va para julio y diciembre sino no aplica
		if(e.getPeriodoEntrevista().equals("Julio") || e.getPeriodoEntrevista().equals("Diciembre")){
			row.createCell(31).setCellValue(getEvaluacionPropositoAnual(e));
		}else{
			row.createCell(31).setCellValue("No aplica");
		}
		
		row.createCell(32).setCellValue(getResultadoAnioEscolar(e));
		
		
		
		row.createCell(33).setCellValue(getSituacionCrisis(e));
				
		
		row.createCell(34).setCellValue(e.getEvaluacionCobroBeca() != null ? e.getEvaluacionCobroBeca().getValor() :"");		
		row.createCell(35).setCellValue(getMotivoSuspensionCesacion(e,exportacionHelper));				
		row.createCell(36).setCellValue(e.getObservacionesGenerales());		
		row.createCell(37).setCellValue(e.getComentariosRevision());
		row.createCell(38).setCellValue(e.getExportacionEspecial().getNombresPrevias());		
		row.createCell(39).setCellValue(e.getPadrino());
		row.createCell(40).setCellValue(e.getExportacionEspecial().getTipoPadrino());
		row.createCell(41).setCellValue(e.getEstadoEntrevista().getValor());
		
				
		if(e.getExcepcion()==null ){
			//row.createCell(71).setCellValue("");
			row.createCell(42).setCellValue("");
		}else
		{
			if(e.getExcepcion()==true ){
				//row.createCell(71).setCellValue("Si");
				row.createCell(42).setCellValue("Si");
			}else{
				//row.createCell(71).setCellValue("No");
				row.createCell(42).setCellValue("No");
			}
		}	
		
		row.createCell(43).setCellValue(e.getPerfilAlumno().getEae());
		row.createCell(44).setCellValue(e.getPerfilAlumno().getResponsable1().getBanco().getNombre());
		row.createCell(45).setCellValue(e.getTipoEncuentroAcompanamiento());	
	
		Long anioEgreso=0L;
		if(e.getPerfilAlumno().getEscuela().getZonaCimientos().getEae().equals("6/6")){
			if(e.getPerfilAlumno().getAnioAdicional()){
				anioEgreso=Long.parseLong(e.getCicloLectivo())+14-e.getPerfilAlumno().getAnioEscolar().getId()+1;
				row.createCell(46).setCellValue(anioEgreso);
			}else{
				anioEgreso=Long.parseLong(e.getCicloLectivo())+14-e.getPerfilAlumno().getAnioEscolar().getId();
				row.createCell(46).setCellValue(anioEgreso);
			}
		}
		if(e.getPerfilAlumno().getEscuela().getZonaCimientos().getEae().equals("7/5")){
			if(e.getPerfilAlumno().getAnioAdicional()){
				anioEgreso=Long.parseLong(e.getCicloLectivo())+13-e.getPerfilAlumno().getAnioEscolar().getId()+1;
				row.createCell(46).setCellValue(anioEgreso);
			}else{
				anioEgreso=Long.parseLong(e.getCicloLectivo())+13-e.getPerfilAlumno().getAnioEscolar().getId();
				row.createCell(46).setCellValue(anioEgreso);
			}
		}	
				
		row.createCell(47).setCellValue(e.getPropositoAnual());
				
		row.createCell(48).setCellValue(e.getHsTrabajarA�o());
		
		
		
		//buscamos contenidos trabajado en el anio
		
		String cta="";
		Connection cn0 = null;
        try {            
            String query="select * from contenidos_trabajar_en_el_anio where contenidos_trabajar_en_el_anio.entrevista="+e.getId();
            
            cn0 = Conexion.getConexion();
            Statement st = cn0.createStatement();
            ResultSet rs0 = st.executeQuery(query);          
                         
            while (rs0.next()) {
            	//System.out.println(rs0.getString(2));
            	if(Long.parseLong(rs0.getString(2))==0){cta=cta+"Autoconcepto - Autoconocimiento y autoestima";}
            	if(Long.parseLong(rs0.getString(2))==1){cta=cta+"Autoconcepto - Autoeficacia y autoconfianza";}
            	if(Long.parseLong(rs0.getString(2))==2){cta=cta+"Responsabilidad y autonom�a - Responsabilidad y compromiso";}
            	if(Long.parseLong(rs0.getString(2))==3){cta=cta+"Responsabilidad y autonom�a - Autocontrol y determinaci�n";}
            	if(Long.parseLong(rs0.getString(2))==4){cta=cta+"Responsabilidad y autonom�a - Autonom�a";}
            	if(Long.parseLong(rs0.getString(2))==5){cta=cta+"Planificaci�n y organizaci�n del tiempo - Planificaci�n y proyecto de vida";}
            	if(Long.parseLong(rs0.getString(2))==6){cta=cta+"Planificaci�n y organizaci�n del tiempo - Organizaci�n del tiempo";}
            	if(Long.parseLong(rs0.getString(2))==7){cta=cta+"Planificaci�n y organizaci�n del tiempo - H�bitos de estudio";}
            	if(Long.parseLong(rs0.getString(2))==8){cta=cta+"Toma de decisiones - Pensamiento cr�tico y creativo";}
            	if(Long.parseLong(rs0.getString(2))==9){cta=cta+"Toma de decisiones - Entusiasmo por aprender";}
            	if(Long.parseLong(rs0.getString(2))==10){cta=cta+"Toma de decisiones - Sentido de la oportunidad";}
            	if(Long.parseLong(rs0.getString(2))==11){cta=cta+"Relaciones Interpersonales - Asertividad y comunicaci�n";}
            	if(Long.parseLong(rs0.getString(2))==12){cta=cta+"Relaciones Interpersonales - Empat�a y trabajo con otros";}
            	if(Long.parseLong(rs0.getString(2))==13){cta=cta+"Relaciones Interpersonales - Convivencia y resoluci�n de conflictos";}
            	if(Long.parseLong(rs0.getString(2))==14){cta=cta+"Relaciones Interpersonales - Participaci�n";}
            	if(Long.parseLong(rs0.getString(2))==15){cta=cta+"Egreso Efectivo y transici�n post-escolar";}
            	if(Long.parseLong(rs0.getString(2))==16){cta=cta+"Elecci�n de la orientaci�n y cambio de ciclo";}
            	if(Long.parseLong(rs0.getString(2))==17){cta=cta+"Transici�n primaria-secundaria";}
            	cta=cta+"\n";
            	
            	         	
            }
            st.close();           
            Conexion.cerrarConexion(cn0);
        } catch (SQLException e1) {
            e1.printStackTrace();
            
            Conexion.cerrarConexion(cn0);
        } catch (Exception e1) {
            e1.printStackTrace();
            
            Conexion.cerrarConexion(cn0);
        }
		
        //if(e.getContenidosTrabajarDuranteAnio()!=null ){
			row.createCell(49).setCellValue(cta);
		//}
        
        
		
        try {            
            String query="SELECT * FROM situacion_riesgo_escolar s WHERE s.id_entrevista="+e.getId();
            
            cn0 = Conexion.getConexion();
            Statement st = cn0.createStatement();
            ResultSet rs0 = st.executeQuery(query);          
            cta="";             
            while (rs0.next()) {
            	//System.out.println(rs0.getString(2));
            	if(Long.parseLong(rs0.getString(2))==0){cta=cta+"Dificultad en la comprensi�n de los contenidos escolares";}
            	if(Long.parseLong(rs0.getString(2))==1){cta=cta+"Falta de devoluci�n de profesores";}
            	if(Long.parseLong(rs0.getString(2))==2){cta=cta+"Desmotivaci�n por las actividades escolares virtuales";}
            	if(Long.parseLong(rs0.getString(2))==3){cta=cta+"Ausentismo prolongado a las actividades escolares";}
            	if(Long.parseLong(rs0.getString(2))==4){cta=cta+"Otro";}
            	if(Long.parseLong(rs0.getString(2))==5){cta=cta+"Ninguno";}
            	
            	cta=cta+"\n";
            	
            	         	
            }
            st.close();           
            Conexion.cerrarConexion(cn0);
        } catch (SQLException e1) {
            e1.printStackTrace();
            
            Conexion.cerrarConexion(cn0);
        } catch (Exception e1) {
            e1.printStackTrace();
            
            Conexion.cerrarConexion(cn0);
        }
		
       // if(e.getContenidosTrabajarDuranteAnio()!=null ){
			row.createCell(76).setCellValue(cta);
		//}
		        
        
        try {            
            String query="SELECT * FROM situacion_crisis s WHERE s.id_entrevista="+e.getId();
            
            cn0 = Conexion.getConexion();
            Statement st = cn0.createStatement();
            ResultSet rs0 = st.executeQuery(query);          
            cta="";             
            while (rs0.next()) {
            	//System.out.println(rs0.getString(2));
            	if(Long.parseLong(rs0.getString(2))==0){cta=cta+"Fallecimiento de una persona significativa";}
            	if(Long.parseLong(rs0.getString(2))==1){cta=cta+"Enfermedad propia o de una persona significativa";}
            	if(Long.parseLong(rs0.getString(2))==2){cta=cta+"Maternidad/Paternidad";}
            	if(Long.parseLong(rs0.getString(2))==3){cta=cta+"Mudanza";}
            	if(Long.parseLong(rs0.getString(2))==4){cta=cta+"Situaci�n de violencia familiar";}
            	if(Long.parseLong(rs0.getString(2))==5){cta=cta+"Situaci�n de crisis econ�mica en la familia";}
            	if(Long.parseLong(rs0.getString(2))==6){cta=cta+"Cambio de estructura familiar/convivientes";}
            	if(Long.parseLong(rs0.getString(2))==7){cta=cta+"Consumo problem�tico";}
            	if(Long.parseLong(rs0.getString(2))==8){cta=cta+"Situaci�n de violencia escolar";}
            	if(Long.parseLong(rs0.getString(2))==9){cta=cta+"Otro";}
            	if(Long.parseLong(rs0.getString(2))==10){cta=cta+"Ninguno";}
            	if(Long.parseLong(rs0.getString(2))==11){cta=cta+"Problemas de conectividad (acceso a internet y/o equipo)";}
            	if(Long.parseLong(rs0.getString(2))==12){cta=cta+"Estudiante con responsabilidades laborales";}
            	
            	cta=cta+"\n";
            	
            	         	
            }
            st.close();           
            Conexion.cerrarConexion(cn0);
        } catch (SQLException e1) {
            e1.printStackTrace();
            
            Conexion.cerrarConexion(cn0);
        } catch (Exception e1) {
            e1.printStackTrace();
            
            Conexion.cerrarConexion(cn0);
        }
		
        //if(e.getContenidosTrabajarDuranteAnio()!=null ){
			row.createCell(77).setCellValue(cta);
		//}
		        
		row.createCell(50).setCellValue(e.getObservacionesSR());
		
		if (e.getExcepcion()!=null){
			if(e.getExcepcion()==true){
				row.createCell(51).setCellValue("Si");
			}else{
				row.createCell(51).setCellValue("No");
			}		
		}	
		row.createCell(52).setCellValue(e.getMotivoExcepcion());		
		row.createCell(53).setCellValue(e.getObservacionesExcepcion());
		
		
		// ENTREVISTA JULIO (2018)
		if(e.getEcabp()!=null ){
			row.createCell(54).setCellValue(e.getEcabp());
		}
		if(e.getVcrae()!=null ){
			row.createCell(55).setCellValue(e.getVcrae());
		}
		if(e.getPropositoAnual()!=null ){
			row.createCell(56).setCellValue(e.getPropositoAnual());
		}
		
		if(e.getOsme()!=null ){
			row.createCell(57).setCellValue(e.getOsme());
		}
		
		// solo durante julio y diciembre sino NO APLICA				
		if(e.getHsTrabajarA�o()!=null ){
			row.createCell(58).setCellValue(e.getHsTrabajarA�o());
		}
		
		// solo durante julio y diciembre sino NO APLICA		
		if(e.getPeriodoEntrevista().equals("Julio") || e.getPeriodoEntrevista().equals("Diciembre")){
			if(e.getContenidosTrabajarDuranteAnio()!=null ){
				row.createCell(59).setCellValue(e.getContenidosTrabajarDuranteAnio());
			}
		}else{
			row.createCell(59).setCellValue("No aplica");
		}
			
			
		// solo durante julio y diciembre sino NO APLICA
		if(e.getPeriodoEntrevista().equals("Julio") || e.getPeriodoEntrevista().equals("Diciembre")){
			if(e.isUsasteFichero()==true ){
				row.createCell(60).setCellValue("Si");
			}else{
				row.createCell(60).setCellValue("No");
			}
		}else{
			row.createCell(60).setCellValue("No aplica");
		}
		
		
		
		// solo durante julio y diciembre sino NO APLICA
		if(e.getPeriodoEntrevista().equals("Julio") || e.getPeriodoEntrevista().equals("Diciembre")){
			if(e.isBrujula()==true ){
				row.createCell(61).setCellValue("Si");
			}else{
				row.createCell(61).setCellValue("No");
			}
			if(e.getQtam()!=null ){
				row.createCell(62).setCellValue(e.getQtam());
			}
		}else{
			row.createCell(62).setCellValue("No aplica");
		}
		if(e.getSarpepe()!=null ){
			row.createCell(63).setCellValue(e.getSarpepe());
		}
		if(e.getTe()!=null ){
			row.createCell(64).setCellValue(e.getTe());
		}
		if(e.getIe()!=null ){
			row.createCell(65).setCellValue(e.getIe());
		}
		
		// solo durante julio y diciembre sino NO APLICA
		if(e.getPeriodoEntrevista().equals("Julio") || e.getPeriodoEntrevista().equals("Diciembre")){
			if(e.isCv()==true ){
				row.createCell(66).setCellValue("Si");
			}else{
				row.createCell(66).setCellValue("No");
			}
		}else{
			row.createCell(66).setCellValue("No aplica");
		}
			
		// solo durante julio y diciembre sino NO APLICA
		if(e.getPeriodoEntrevista().equals("Julio") || e.getPeriodoEntrevista().equals("Diciembre")){	
			if(e.isTma()==true ){
				row.createCell(67).setCellValue("Si");
			}else{
				row.createCell(67).setCellValue("No");
			}
		}else{
			row.createCell(67).setCellValue("No aplica");
		}
		
		if(e.getDirMail()!=null ){
			row.createCell(68).setCellValue(e.getDirMail());
		}
		if(e.getFacebook()!=null ){
			row.createCell(69).setCellValue(e.getFacebook());
		}
		if(e.getTelFijo()!=null ){
			row.createCell(70).setCellValue(e.getTelFijo());
		}
		if(e.getCelular()!=null ){
			row.createCell(71).setCellValue(e.getCelular());
		}
		if(e.getMotivoAusenciaRa2()!=null ){
			row.createCell(72).setCellValue(e.getMotivoAusenciaRa2());
		}
		
		
		if(e.getObjetivoEncuentro()!=null ){
			row.createCell(73).setCellValue(e.getObjetivoEncuentro());
		}
		if(e.getObservacionesGenerales()!=null ){
			row.createCell(74).setCellValue(e.getObservacionesGenerales());
		}
		if(e.getMotivoInasistencia()!=null ){
			row.createCell(75).setCellValue(e.getMotivoInasistencia());
		}
		
		//row.createCell(79).setCellValue(getMotivoRenovacionUnificado2(e));
		
		if(e.getAse2020()!=null){
			row.createCell(78).setCellValue(e.getAse2020());
		}
		if(e.getAlo()!=null){
			row.createCell(79).setCellValue(e.getAlo());
		}
		
		
	}
		
	private String getMotivoSuspensionCesacion(EntrevistaIndividual e, ExportacionEspecialHelper exportacionHelper) {
		if(e.getEvaluacionCobroBeca() != null && e.getEvaluacionCobroBeca() == EvaluacionCobroBeca.SUSPENDIDO)
			return exportacionHelper.getMotivoSuspension(e);
		else
			return exportacionHelper.getMotivoCesacion(e);
	}

	private String getMotivoAusenciaRAUnificado(EntrevistaIndividual e, ExportacionEspecialHelper exportacionHelper) {
		String motivoAusencia = exportacionHelper.getMotivoAusenciaRA(e);
		String otroMotivoAusencia = exportacionHelper.getOtroMotivoAusenciaRA(e);
		if(motivoAusencia != "" && motivoAusencia != MotivoAusencia.OTROS.getValor())
			return motivoAusencia;
		else
			if(motivoAusencia != "" && motivoAusencia == MotivoAusencia.OTROS.getValor())
				return "Otro," + otroMotivoAusencia;
			else
				return NO_APLICA;
	}

	private String getMotivoAusenciaBecadoUnificado(EntrevistaIndividual e) {
		if(e.getMotivoAusencia() != null && e.getMotivoAusencia() != MotivoAusencia.OTROS)
			return e.getMotivoAusencia().getValor();
		else
			if(e.getMotivoAusencia() != null && e.getMotivoAusencia() == MotivoAusencia.OTROS)
				return "Otro," + e.getOtroMotivoAusencia();
			else
				return NO_APLICA;
	}

	private String getTipoContactoUnificado(EntrevistaIndividual e, ExportacionEspecialHelper exportacionHelper) {
		String contactoTipo = exportacionHelper.getTipoContacto(e);
		if(contactoTipo != "" && contactoTipo != TipoContacto.OTRO.getValor())
			return contactoTipo;
		else{
			String otroContacto = exportacionHelper.getOtroTipoContacto(e);
			if(contactoTipo != "" && contactoTipo == TipoContacto.OTRO.getValor())
				return "Otro," + otroContacto;
			else
				return "";
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
								//valor = String.valueOf(er.getMotivoNoRenovacion().getId());							
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
							//valor = String.valueOf(ef.getMotivoNoRenovacion().getId());
					}
					else
						valor = NO_APLICA;
				}
		}
		else
			valor = NO_APLICA;
		
		return valor;
	}
	
	public String getMotivoRenovacionUnificado2(EntrevistaIndividual e) {
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
								//valor = er.getMotivoNoRenovacion().getValor();
								valor = String.valueOf(er.getMotivoNoRenovacion().getId());							
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
							//valor = ef.getMotivoNoRenovacion().getValor();
							valor = String.valueOf(ef.getMotivoNoRenovacion().getId());
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
			else{
				valor =  new StringBuffer("");
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
	
	public String getPropositoAnioComienza(EntrevistaIndividual entrevista) {
		String valor="";
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.RENOVACION)){ 
			EntrevistaRenovacion er = (EntrevistaRenovacion)entrevista;
			if (er.getPropositoAnioComienza()!=null){
				valor=er.getPropositoAnioComienza();
			}else{
				valor="";
			}
		}	
		if(entrevista.getTipoEntrevista().equals(TipoEntrevista.INCORPORACION)){ 
			if (entrevista.getProposito()!=null){
				valor=entrevista.getProposito();
			}else{
				valor="";
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