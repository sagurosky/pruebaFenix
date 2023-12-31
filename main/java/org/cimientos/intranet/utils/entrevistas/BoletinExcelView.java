package org.cimientos.intranet.utils.entrevistas;

import java.util.List;
import java.util.Map;
import java.util.Date;
import java.util.logging.SimpleFormatter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;







import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.cimientos.intranet.dto.BoletinDTO;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.candidato.convocatoria.Convocatoria;
import org.cimientos.intranet.modelo.escuela.Escuela;
import org.cimientos.intranet.modelo.perfil.EstadoAlumno;
import org.cimientos.intranet.modelo.perfilEA.PerfilEA;
import org.cimientos.intranet.modelo.perfilPadrino.PerfilPadrino;
import org.cimientos.intranet.modelo.ubicacion.ZonaCimientos;
import org.cimientos.intranet.servicio.AlumnoSrv;
import org.cimientos.intranet.utils.Formateador;
import org.cimientos.intranet.web.controller.Conexion;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.cimientos.intranet.dto.MateriaDTO;
import com.cimientos.intranet.enumerativos.AnioEscolar;

public class BoletinExcelView extends AbstractExcelView{
	
	private static int bachSize = 1000;
	private static final String NO_APLICA = "No aplica";	
	
	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String,Object> model, HSSFWorkbook workbook,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		AlumnoSrv alumnoSrv = (AlumnoSrv) model.get("alumnoSrv");
		
		
		
		//HSSFSheet sheet = workbook.getSheet("Boletines");
		
		boolean becadosActivos = (Boolean) model.get("becadosActivos"); 
		EstadoAlumno estadoAlumno = (EstadoAlumno) model.get("estado");
		AnioEscolar anio = (AnioEscolar) model.get("anio");
		Boolean adicional = (Boolean) model.get("adicional"); 
		ZonaCimientos zona = (ZonaCimientos) model.get("zonaCimientos"); 
		Convocatoria convocatoria = (Convocatoria) model.get("convocatoria");
		PerfilPadrino padrino = (PerfilPadrino) model.get("padrino");
		PerfilEA ea = (PerfilEA) model.get("perfilEA");
		String nombreAlumno = (String) model.get("nombreAlumno");
		CicloPrograma ciclo = (CicloPrograma) model.get("ciclo");
		String eae=(String) model.get("eae");
		Escuela escuela = (Escuela) model.get("escuela");
		
		int totalRows = alumnoSrv.obtenerCantidadAlumnosExportar(estadoAlumno,zona,convocatoria,padrino,ea,nombreAlumno,anio,adicional,becadosActivos,eae, escuela);
		
		List<BoletinDTO> boletines = null;
		int rowNum = 3;
		int parcial = 0;
		int inicial = 0;
		HSSFRow row;
		while (parcial < totalRows) {
			parcial = parcial + bachSize;
						
			boletines = alumnoSrv.obtenerBoletinesAExportar(estadoAlumno,zona,convocatoria,padrino,ea,nombreAlumno,anio,
					adicional,becadosActivos,ciclo,inicial,bachSize,null,null, eae,escuela);		
			
			HSSFSheet sheet = workbook.getSheet("Boletines");
			if (ciclo.getId()>=31){
				sheet = workbook.getSheet("Boletines_Nuevo");
			}else{
				sheet = workbook.getSheet("Boletines");
			}
			
			String url = "jdbc:mysql://localhost/cimientos_prod";
			Connection cn = DriverManager.getConnection(url,"root","root");	
			cn = null;
	        CallableStatement cl = null;
	        ResultSet rs = null;
			int ii=0;
			if(sheet != null){
				for (BoletinDTO ic : boletines) {
					ii++;
					System.out.println(ii);
					//nuevo para boletines a partir del 2020
					if(ciclo.getId()>=31){
						
				        String call = "{CALL SP_ExportarBoletines2020(?)}";
				    	cn = Conexion.getConexion();
				        cl = cn.prepareCall(call); 
				        cl.setLong(1, ic.getIdAlumno());
				        //cl.setString(2, ic.getCicloBoletin());
				        System.out.println(ic.getIdAlumno());
				        rs = cl.executeQuery();
				        //Long anioEgreso=2020L;
				        while (rs.next()) {
				        	long posibleAnioEgreso=0;
				        	if(ic.getAnioAdicional().equals("Si")){
				    			//System.out.println("con a�o adicional");
				        		if(rs.getString("eae").equals("7/5")){
				        			if(ic.getAnioEscolar().equals("7� primaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+6;
				    				}
				    				if(ic.getAnioEscolar().equals("1� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+5;
				    				}
				    				if(ic.getAnioEscolar().equals("2� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+4;
				    				}
				    				if(ic.getAnioEscolar().equals("3� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+3;
				    				}
				    				if(ic.getAnioEscolar().equals("4� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+2;
				    				}
				    				if(ic.getAnioEscolar().equals("5� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+1;
				    				}
				    				if(ic.getAnioEscolar().equals("6� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+0;
				    				}
				    			}
				        		if(rs.getString("eae").equals("6/6")){				
				    				if(ic.getAnioEscolar().equals("1� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+6;
				    				}
				    				if(ic.getAnioEscolar().equals("2� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+5;
				    				}
				    				if(ic.getAnioEscolar().equals("3� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+4;
				    				}
				    				if(ic.getAnioEscolar().equals("4� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+3;
				    				}
				    				if(ic.getAnioEscolar().equals("5� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+2;
				    				}
				    				if(ic.getAnioEscolar().equals("6� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+1;
				    				}
				    				if(ic.getAnioEscolar().equals("7� t�cnica")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+0;
				    				}
				    			}
				    		}
				    		else{
				    			//System.out.println("sin a�o adicional");
				    			if(rs.getString("eae").equals("7/5")){
				    				if(ic.getAnioEscolar().equals("7� primaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+5;
				    				}
				    				if(ic.getAnioEscolar().equals("1� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+4;
				    				}
				    				if(ic.getAnioEscolar().equals("2� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+3;
				    				}
				    				if(ic.getAnioEscolar().equals("3� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+2;
				    				}
				    				if(ic.getAnioEscolar().equals("4� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+1;
				    				}
				    				if(ic.getAnioEscolar().equals("5� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+0;
				    				}
				    			}
				    			if(rs.getString("eae").equals("6/6")){				
				    				if(ic.getAnioEscolar().equals("1� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+5;
				    				}
				    				if(ic.getAnioEscolar().equals("2� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+4;
				    				}
				    				if(ic.getAnioEscolar().equals("3� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+3;
				    				}
				    				if(ic.getAnioEscolar().equals("4� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+2;
				    				}
				    				if(ic.getAnioEscolar().equals("5� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+1;
				    				}
				    				if(ic.getAnioEscolar().equals("6� secundaria")){
				    					posibleAnioEgreso=Long.parseLong(ciclo.getNombre())+0;
				    				}
				    			}
				    			
				    		}
				        	
				        	
				        	
				        	
				        	Integer edad=0;
				        	edad=Formateador.calcularEdad(DeStringADate(ic.getFechaNacimiento()));
				        	row = sheet.createRow(rowNum++);
							row.createCell(0).setCellValue(rs.getString("perfil_alumno"));
							row.createCell(1).setCellValue(rs.getString("becado"));
							row.createCell(2).setCellValue(rs.getString("dni"));
							row.createCell(3).setCellValue(ic.getFechaNacimiento());
							row.createCell(4).setCellValue(edad);
							row.createCell(5).setCellValue(ic.getAnioEscolar());
							row.createCell(6).setCellValue(ic.getAnioAdicional());
							row.createCell(7).setCellValue(posibleAnioEgreso);								
							row.createCell(8).setCellValue(rs.getString("escuelaNombre"));
							row.createCell(9).setCellValue(rs.getString("zonaNombre"));
							row.createCell(10).setCellValue(rs.getString("eae"));
							row.createCell(11).setCellValue(rs.getString("RA"));
							row.createCell(12).setCellValue(ic.getVinculo());
							row.createCell(13).setCellValue(ic.getFechaPBE());
							row.createCell(14).setCellValue(ic.getFechaReincorporacionPBE());
							row.createCell(15).setCellValue(rs.getString("rr"));
							row.createCell(16).setCellValue(rs.getString("ea"));
							if(rs.getString("datos_personales")==null){
								row.createCell(17).setCellValue("Corporativo");
								row.createCell(18).setCellValue(rs.getString("empresaNombre"));
							}else{
								row.createCell(17).setCellValue("Individuo");
								row.createCell(18).setCellValue(rs.getString("Individuo"));
							}																
							row.createCell(19).setCellValue(rs.getString("ciclo"));
							row.createCell(20).setCellValue(rs.getString("anioEscolar"));
							row.createCell(21).setCellValue(rs.getString("inas1"));
							row.createCell(22).setCellValue(rs.getString("qma1"));
							row.createCell(23).setCellValue(rs.getString("qmd1"));
							row.createCell(24).setCellValue(rs.getString("qmsc1"));
							row.createCell(25).setCellValue(rs.getString("qmt1"));
							row.createCell(26).setCellValue(rs.getString("cl1t"));
							row.createCell(27).setCellValue(rs.getString("cm1t"));
							row.createCell(28).setCellValue(rs.getString("inas2"));
							row.createCell(29).setCellValue(rs.getString("qma2"));
							row.createCell(30).setCellValue(rs.getString("qmd2"));
							row.createCell(31).setCellValue(rs.getString("qmsc2"));
							row.createCell(32).setCellValue(rs.getString("qmt2"));
							row.createCell(33).setCellValue(rs.getString("cl2t"));
							row.createCell(34).setCellValue(rs.getString("cm2t"));
							row.createCell(35).setCellValue(rs.getString("inas3"));
							row.createCell(36).setCellValue(rs.getString("qma3"));
							row.createCell(37).setCellValue(rs.getString("qmd3"));
							row.createCell(38).setCellValue(rs.getString("qmsc3"));
							row.createCell(39).setCellValue(rs.getString("qmt3"));
							row.createCell(40).setCellValue(rs.getString("cl3t"));
							row.createCell(41).setCellValue(rs.getString("cm3t"));
							row.createCell(42).setCellValue(rs.getString("qmasf"));
							row.createCell(43).setCellValue(rs.getString("qmdsf"));
							row.createCell(44).setCellValue(rs.getString("qmscsf"));
							row.createCell(45).setCellValue(rs.getString("qmtsf"));
							row.createCell(46).setCellValue(rs.getString("clsf"));
							row.createCell(47).setCellValue(rs.getString("cmsf"));
							row.createCell(48).setCellValue(rs.getString("qmaer"));
							row.createCell(49).setCellValue(rs.getString("qmder"));
							row.createCell(50).setCellValue(rs.getString("qmscer"));
							row.createCell(51).setCellValue(rs.getString("qmter"));
							row.createCell(52).setCellValue(rs.getString("cler"));
							row.createCell(53).setCellValue(rs.getString("cmer"));
							
							//previas
							call = "{CALL SP_TraerPreviasNuevo(?)}";
					    	//cn = Conexion.getConexion();
					        cl = cn.prepareCall(call); 
					        cl.setLong(1, ic.getIdAlumno());
					        //cl.setString(2, ic.getCicloBoletin());
					        rs = cl.executeQuery();
					        long vueltas=0L;
					        int columna=54;
					        while (rs.next()) {						        	
					        	vueltas++;				        	
					        	if(vueltas==2){
					        		columna=61;
					        	}
					        	if(vueltas==3){
					        		columna=68;
					        	}
					        	if(vueltas==4){
					        		columna=75;
					        	}
					        	if(vueltas==5){
					        		columna=82;
					        	}
					        	if(vueltas==6){
					        		columna=89;
					        	}						        	
				        		row.createCell(columna).setCellValue(rs.getString("materia"));
				        		row.createCell(columna+1).setCellValue(rs.getString("anio_escolar"));
				        		row.createCell(columna+2).setCellValue(rs.getString("ja"));
				        		row.createCell(columna+3).setCellValue(rs.getString("di"));
				        		row.createCell(columna+4).setCellValue(rs.getString("fb"));
				        		row.createCell(columna+5).setCellValue(rs.getString("ma"));
				        		row.createCell(columna+6).setCellValue(rs.getString("mam"));
					        }				       				        		
				        }
				        Conexion.cerrarCall(cl);
				        Conexion.cerrarConexion(cn);	
					
					}else{
					
						if (ic.getCicloBoletin()!=null){
							//System.out.println(ciclo.getNombre()+" - "+ ic.getCicloBoletin());
							if (ciclo.getNombre()!=ic.getCicloBoletin().toString()){
								//System.out.println("Diferente: " +ciclo.getNombre()+" - "+ ic.getCicloBoletin());
							}else{
								row = sheet.createRow(rowNum++);
								crearFila(ic, row);
							}
						}
					}
				}		
			}
			inicial = parcial;
			boletines = null;
		}	
	}

	/**
	 * Permite convertir un String en fecha (Date). 
	 * @param fecha (String) la fecha a la cual deseo convertir
	 * @return Date la fecha en formato Date
	 * @author Argenis R.
	 */

	public Date DeStringADate(String fecha){
			SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
			String strFecha = fecha;
			Date fechaDate = null;
			try {
				fechaDate = formato.parse(strFecha);
	                       // //System.out.println(fechaDate.toString());
				return fechaDate;
			} catch (ParseException ex) {
				ex.printStackTrace();
				return fechaDate;
			}
		}


	
	private void crearFila(BoletinDTO boletin, HSSFRow row) {
		
		
		
		row.createCell(0).setCellValue(boletin.getIdAlumno());
		row.createCell(1).setCellValue(boletin.getApellidoAlumno() +" " + boletin.getNombreAlumno());
		row.createCell(2).setCellValue(boletin.getDni());		
		row.createCell(3).setCellValue(boletin.getFechaNacimiento());	
		
		Integer edad=0;
		edad=Formateador.calcularEdad(DeStringADate(boletin.getFechaNacimiento()));
		row.createCell(4).setCellValue(edad);		
		row.createCell(5).setCellValue(boletin.getAnioEscolar());
		row.createCell(6).setCellValue(boletin.getAnioAdicional());
		row.createCell(7).setCellValue(boletin.getIdEscuela());
		row.createCell(8).setCellValue(boletin.getEscuelaNombre());
		row.createCell(9).setCellValue(boletin.getEscuelaLocalidad());
		row.createCell(69).setCellValue(boletin.getEae());
		
		if (boletin.getVinculo()!= null){
			row.createCell(10).setCellValue(boletin.getResponsable() + "-" + boletin.getVinculo());
		}
		else{
			row.createCell(10).setCellValue(boletin.getResponsable() + "- - ");
		}
		
		
		
		
		
		row.createCell(11).setCellValue(boletin.getFechaPBE());
		row.createCell(12).setCellValue(getFechaReIncorporacionPBE(boletin));
		row.createCell(13).setCellValue(boletin.getRr());
		row.createCell(14).setCellValue(boletin.getEa());			
		row.createCell(15).setCellValue(boletin.getTipoPadrino());
		row.createCell(16).setCellValue(boletin.getPadrino());		
		row.createCell(17).setCellValue(boletin.getExisteBoletin()==true?"Si":"No");
		row.createCell(18).setCellValue(boletin.getCicloBoletin());
		row.createCell(19).setCellValue(boletin.getAnioEscolarBoletin());			
		this.setBoletin(row, boletin);
	}	
	
	private String getFechaReIncorporacionPBE(BoletinDTO boletin) {
		return StringUtils.isNotBlank(boletin.getFechaReincorporacionPBE()) ? 
				boletin.getFechaReincorporacionPBE(): NO_APLICA;
	}
	
	private HSSFRow setBoletin(HSSFRow row, BoletinDTO boletin){
		//materias del boletin
		String notaFin="";
		String notaDic="";
		String notaMar="";
		String notaFDM="";
		String nota1="";
		String nota2="";
		String nota3="";
		String nota123="";	
		
		for (MateriaDTO materia: boletin.getMateriasDto()) {						
				nota1=materia.getNotaPrimero();
				nota2=materia.getNotaSegundo();
				nota3=materia.getNotaTercero();			
				if (materia.getNotaPrimero().equals(" ")){
					nota1="-";
				}
				if (materia.getNotaSegundo().equals(" ")){
					nota2="-";
				}
				if (materia.getNotaTercero().equals(" ")){
					nota3="-";
				}				
				
				nota123=nota1+","+nota2+","+nota3;				
				notaFin=materia.getNotaFin();
				notaDic=materia.getNotaDic();
				notaMar=materia.getNotaMarzo();
				if (materia.getNotaFin().equals(" ")){
					notaFin="-";
				}
				if (materia.getNotaDic().equals(" ")){
					notaDic="-";
				}
				if (materia.getNotaMarzo().equals(" ")){
					notaMar="-";
				}				
				notaFDM=notaFin+","+notaDic+","+notaMar;	
				
				if(materia.getNombre() != null){
					if(materia.getNombre().equals("Cantidad total de materias en el bolet�n")){	
						row.createCell(20).setCellValue(nota123);
						row.createCell(40).setCellValue(notaFDM);
					}				
					if(materia.getNombre().equals("Cantidad de materias aprobadas")){
						row.createCell(21).setCellValue(nota123);
						row.createCell(41).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("Cantidad de materias desaprobadas")){
						row.createCell(22).setCellValue(nota123);
						row.createCell(42).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("Calificaci�n de Lengua/ Literatura")){
						row.createCell(23).setCellValue(nota123);
						row.createCell(43).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("Calificaci�n de Matem�tica")){
						row.createCell(24).setCellValue(nota123);
						row.createCell(44).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("Construcci�n de ciudadan�a / Educaci�n c�vica")){
						row.createCell(25).setCellValue(nota123);
						row.createCell(45).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("Contabilidad / Educaci�n pr�ctica contable")){
						row.createCell(26).setCellValue(nota123);
						row.createCell(46).setCellValue(notaFDM);
					}		
					if(materia.getNombre().equals("Educaci�n f�sica / corporal")){
						row.createCell(27).setCellValue(nota123);
						row.createCell(47).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("F�sica")){
						row.createCell(28).setCellValue(nota123);
						row.createCell(48).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("F�sico-qu�mica")){
						row.createCell(29).setCellValue(nota123);
						row.createCell(49).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("Geograf�a")){
						row.createCell(30).setCellValue(nota123);
						row.createCell(50).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("Historia")){
						row.createCell(31).setCellValue(nota123);
						row.createCell(51).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("Ingl�s")){
						row.createCell(32).setCellValue(nota123);
						row.createCell(52).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("Lengua / Literatura")){
						row.createCell(33).setCellValue(nota123);
						row.createCell(53).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("Matem�tica")){
						row.createCell(34).setCellValue(nota123);
						row.createCell(54).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("M�sica")){
						row.createCell(35).setCellValue(nota123);
						row.createCell(55).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("Pasant�a / Pr�ctica profesional")){
						row.createCell(36).setCellValue(nota123);
						row.createCell(56).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("Qu�mica")){
						row.createCell(37).setCellValue(nota123);
						row.createCell(57).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("Salud y Adolescencia")){
						row.createCell(38).setCellValue(nota123);
						row.createCell(58).setCellValue(notaFDM);
					}
					if(materia.getNombre().equals("Tecnolog�a / TIC")){
						row.createCell(39).setCellValue(nota123);
						row.createCell(59).setCellValue(notaFDM);
					}
				}
				else{
					////System.out.println("*****" + boletin.getIdAlumno());
				}
				
		}
		if (boletin.getConductaB() != null){
			row.createCell(60).setCellValue(boletin.getConductaB());
		}
		
		if (boletin.getDiasHabiles() !=null){
			row.createCell(61).setCellValue(boletin.getDiasHabiles());
		}
		if (boletin.getDiasHabilesFinales() !=null){
			row.createCell(62).setCellValue(boletin.getDiasHabilesFinales());
		}
		if (boletin.getInasistencias() !=null){
			row.createCell(63).setCellValue(boletin.getInasistencias());
		}
		if (boletin.getInasistencasFinales() !=null){
			row.createCell(64).setCellValue(boletin.getInasistencasFinales());
		}		
		
		// materias previas		
		String previa1="";
		String previa2="";
		String previa3="";
		String notaD="";
		String notaM="";
		String notaJ="";		
		int contador=0;	
	
		for (MateriaDTO materiaP: boletin.getPreviasDTO()) {			
			if (materiaP.getNotaFin().equals(" ")){
				notaJ="-";
			}else {
				notaJ=materiaP.getNotaFin();
			}
			
			if (materiaP.getNotaDic().equals(" ")){
				notaD="-";
			}else{
				notaD=materiaP.getNotaDic();
			}						
				
			if (materiaP.getNotaMarzo().equals(" ")){
				notaM="-";
			}else{
				notaM=materiaP.getNotaMarzo();
			}
			
			if (contador==0){							
				previa1=materiaP.getNombre() + ", " +materiaP.getCiclo()+", "+ notaJ + ", "+ notaD +", "+ notaM; 
				row.createCell(65).setCellValue(previa1);
			}
			if (contador==1){
				previa2=materiaP.getNombre() + ", " +materiaP.getCiclo()+", "+ notaJ + ", "+ notaD +", "+ notaM;
				row.createCell(66).setCellValue(previa2);
			}
			if (contador==2){
				previa3=materiaP.getNombre() + ", " +materiaP.getCiclo()+", "+ notaJ + ", "+ notaD +", "+ notaM;
				row.createCell(67).setCellValue(previa3);
			}
			contador++;			
		}
		return row;
	}
}
