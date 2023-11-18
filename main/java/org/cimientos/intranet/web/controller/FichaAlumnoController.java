package org.cimientos.intranet.web.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.beans.PropertyEditorSupport;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.BatchUpdateException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cimientos.intranet.modelo.Beca;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.EstadoCuenta;
import org.cimientos.intranet.modelo.FichaFamiliar;
import org.cimientos.intranet.modelo.Pago;
import org.cimientos.intranet.modelo.Periodo;
import org.cimientos.intranet.modelo.ResponsableAdulto;
import org.cimientos.intranet.modelo.escuela.Escuela;
import org.cimientos.intranet.modelo.informe.EstadoInforme;
import org.cimientos.intranet.modelo.informe.FichaPresentacion;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaIndividual;
import org.cimientos.intranet.modelo.perfil.AlumnoPanelEA;
import org.cimientos.intranet.modelo.perfil.EstadoAlumno;
import org.cimientos.intranet.modelo.perfil.PerfilAlumno;
import org.cimientos.intranet.modelo.perfil.Turno;
import org.cimientos.intranet.modelo.perfilEA.PerfilEA;
import org.cimientos.intranet.modelo.persona.Persona;
import org.cimientos.intranet.modelo.seleccion.EntrevistaSeleccion;
import org.cimientos.intranet.modelo.sucursalBanco.SucursalBanco;
import org.cimientos.intranet.modelo.ubicacion.Localidad;
import org.cimientos.intranet.servicio.AlumnoPanelEASrv;
import org.cimientos.intranet.servicio.AlumnoSrv;
import org.cimientos.intranet.servicio.BancoSrv;
import org.cimientos.intranet.servicio.BecaSvr;
import org.cimientos.intranet.servicio.CicloProgramaSrv;
import org.cimientos.intranet.servicio.EntrevistaSeleccionSrv;
import org.cimientos.intranet.servicio.EntrevistaSrv;
import org.cimientos.intranet.servicio.EscuelaSrv;
import org.cimientos.intranet.servicio.InformeFPSrv;
import org.cimientos.intranet.servicio.LocalidadSrv;
import org.cimientos.intranet.servicio.PagoSrv;
import org.cimientos.intranet.servicio.PeriodoSrv;
import org.cimientos.intranet.servicio.PersonaSrv;
import org.cimientos.intranet.servicio.ProvinciaSrv;
import org.cimientos.intranet.servicio.ResponsableSrv;
import org.cimientos.intranet.servicio.SucursalBancoSrv;
import org.cimientos.intranet.servicio.ZonaCimientosSrv;
import org.cimientos.intranet.utils.ConstantesInformes;
import org.cimientos.intranet.utils.ConstantesPaneles;
import org.cimientos.intranet.utils.Formateador;
import org.cimientos.intranet.utils.PeriodoHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.cimientos.intranet.enumerativos.AnioEscolar;
import com.cimientos.intranet.enumerativos.Convive;
import com.cimientos.intranet.enumerativos.EstadoPago;
import com.cimientos.intranet.enumerativos.NivelEducativo;
import com.cimientos.intranet.enumerativos.ProyeccionDeseada;
import com.cimientos.intranet.enumerativos.SituacionActual;
import com.cimientos.intranet.enumerativos.SituacionEscolarAlumno;
import com.cimientos.intranet.enumerativos.TipoDni;
import com.cimientos.intranet.enumerativos.Vinculo;
import com.cimientos.intranet.enumerativos.entrevista.EstadoEntrevista;
import com.cimientos.intranet.enumerativos.entrevista.RelacionVivienda;
import com.cimientos.intranet.enumerativos.entrevista.TipoEntrevista;


@Controller
@RequestMapping("/fichaAlumno/*")
public class FichaAlumnoController extends BaseController{

	@Autowired
	AlumnoSrv alumnoSrv;
	
	@Autowired
	EntrevistaSeleccionSrv entrevistaSeleccionSrv;
	
	@Autowired
	private EscuelaSrv escuelaSrv;

	@Autowired
	private ProvinciaSrv provinciaSrv;

	@Autowired
	private LocalidadSrv localidadSrv;
	
	@Autowired
	private SucursalBancoSrv sucursalSrv;
	
	@Autowired
	private BancoSrv bancoSrv;
	
	@Autowired
	private ZonaCimientosSrv zonaSrv;
	
	@Autowired
	AlumnoPanelEASrv alumnoPanelSrv;
	
	@Autowired
	PersonaSrv personaSrv;
	
	@Autowired
	ResponsableSrv responsableSrv;

	@Autowired
	EntrevistaSrv entrevistaSrv;
	
	@Autowired
	InformeFPSrv fpSrv;
	
	@Autowired
	PagoSrv pagoSrv;
		
	@Autowired
	private PeriodoSrv svrPeriodo;
	
	@Autowired
	private CicloProgramaSrv svrCiclo;
	
	@Autowired
	private EntrevistaSrv srvEntrevistas;
	
	@Autowired
	private PagoSrv srvPagos;
	
	@Autowired
	private BecaSvr becaSrv;
	
	private static final int IMG_WIDTH = 400;
	private static final int IMG_HEIGHT = 300;
	
	//Constante para identificar desde cuando se necesitan los ciclos
	private static String ciclo2010 = "2010";
	
	/**
	 * Ficha alumno view.
	 *
	 * @param id the id
	 * @return the model and view
	 * @author hhrodriguez
	 * @since 31-ene-2011
	 */
	@RequestMapping("/fichaAlumno/fichaAlumnoView.do")
	public ModelAndView fichaAlumnoView(HttpServletRequest request,
			@RequestParam("idAlumno") Long id,
			@RequestParam(required=false, value="urlRegreso") String urlRegreso,
			@RequestParam(required=false, value="mensaje") String mensaje,
			@RequestParam(required=false, value="error") String error){
		
		Map<String, Object> resul = new HashMap<String, Object>();
		PerfilAlumno perfilAlumno = alumnoSrv.obtenerAlumno(id);
		Long idCicloEgreso = null;
		Long periodoIdEgreso = null;
		File file = new File(getProps().getProperty(ConstantesInformes.pathImagen) 
				+ perfilAlumno.getDatosPersonales().getDni().toString() + ConstantesInformes.extensionImagen);
		if(file.exists()){
			resul.put("tieneFoto", true);			
		}
		if(perfilAlumno.getBeca() != null){		
			resul.put("tieneBeca", true);
			Periodo periodoBecaAsignada = svrPeriodo.obtenerPeriodoPorFechaFP(perfilAlumno.getFechaAltaBeca());
			Periodo periodoActual = PeriodoHelper.getPeriodoActual(perfilAlumno.getBeca().getCiclo().getPeriodos(), new Date());
			Periodo ultimoPeriodo = periodoActual.getCiclo().getPeriodos().get(periodoActual.getCiclo().getPeriodos().size()-1);
			resul.put("periodoAsignacion", periodoBecaAsignada);
			List<Periodo> periodosBeca = svrPeriodo.obtenerPeriodosBeca(perfilAlumno.getBeca().getPeriodoPago(), periodoActual);
			resul.put("periodosBeca", periodosBeca);
			resul.put("periodoIdAsignacion", periodoBecaAsignada.getId());
			if(periodoActual.equals(ultimoPeriodo))
				resul.put("modificacionPeriodo", false);
			else{
				if(perfilAlumno.getEstadoAlumno().equals(EstadoAlumno.ALTA_BECADO) || 
						perfilAlumno.getEstadoAlumno().equals(EstadoAlumno.INCORPORADO) ||
						perfilAlumno.getEstadoAlumno().equals(EstadoAlumno.INCORPORACION_PENDIENTE))
					resul.put("modificacionPeriodo", true);
			}
			if(perfilAlumno.getEstadoAlumno().equals(EstadoAlumno.ALTA_BECADO)){
				List<EntrevistaIndividual> entrevistas = srvEntrevistas.obtenerEntrevistasPorAlumnoOrden(perfilAlumno.getId(), periodoActual.getCiclo(), "descendiente");
				if(entrevistas != null && !entrevistas.isEmpty())
					resul.put("desasignarBeca", false);
				else
					resul.put("desasignarBeca", true);
			}
			else
				resul.put("desasignarBeca", false);
		}
		else{
			resul.put("tieneBeca", false);
			resul.put("desasignarBeca", false);
		}
		
		if(perfilAlumno.getPeriodoDeEgreso() != null){
			idCicloEgreso = perfilAlumno.getPeriodoDeEgreso().getCiclo().getId();
			periodoIdEgreso = perfilAlumno.getPeriodoDeEgreso().getId();
		}
		
		long idZona = perfilAlumno.getEscuela().getZonaCimientos().getId();
		List<SucursalBanco> sucursales = sucursalSrv.obtenerSucursalPorZona(idZona);
		resul.put("sucursales", sucursales);
		resul.put("perfilAlumno", perfilAlumno);
		resul.put("listDni", TipoDni.getListaTipos());
		resul.put("listAnioEscolar",AnioEscolar.getAnioEscolares());		
		resul.put("listTurno", Turno.getListaTurnos());
		resul.put("localidades", localidadSrv.obtenerTodos());
		resul.put("listProvincias", provinciaSrv.obtenerTodas());
		resul.put("escuelaTecnica", AnioEscolar.SEPTIMO_SEC.getId());
		resul.put("listVinculo", Vinculo.getListaVinculos());
		resul.put("listConvive", Convive.getListaConvives());
		resul.put("listaZona", zonaSrv.obtenerTodos());
		resul.put("listNivelEducativo", NivelEducativo.getListaNivelEducativo());
		resul.put("listRelacionVivienda", RelacionVivienda.getRelacionViviendas());
		
		resul.put("situacionActual", SituacionActual.getSituacionActual());
		resul.put("proyeccionDeseada", ProyeccionDeseada.getProyeccionDeseada());
		resul.put("ciclos", svrCiclo.obtenerCiclosConvocatoriaDesde(ciclo2010));
		resul.put("cicloIdEgreso", idCicloEgreso);
		resul.put("periodosEgreso", svrPeriodo.buscarPeriodosPorCiclo(idCicloEgreso));
		resul.put("periodoIdEgreso", periodoIdEgreso);		
		
		if(StringUtils.isNotBlank(urlRegreso))
			resul.put("urlRegreso", urlRegreso);
		
		if(StringUtils.isNotBlank(mensaje))
			resul.put("mensaje", mensaje);
		
		if(StringUtils.isNotBlank(error))
			resul.put("error", error);
		
		Persona personaLogueada = obtenerPersona(request);
		if(personaLogueada.getPerfilSuperUsuario())
			resul.put("perfil", "SuperUsuario");
		else
			resul.put("perfil", "");
		
		return forward("fichaAlumno/fichaAlumnoView", resul);
	}
	
	@RequestMapping("/fichaAlumno/guardarCambios.do")
	public ModelAndView guardarCambios(HttpServletRequest request,
			@ModelAttribute("perfilAlumno") PerfilAlumno alumno,
			@RequestParam("idAlumno") Long idAlumno,
			@RequestParam("tipoDNI") Integer tipoDNI,
			@RequestParam("idLocalidad") Long idLocalidad,
			@RequestParam("idProvincia") Long idProvincia,
			@RequestParam("tipoDniResponsable") Integer tipoDniResponsable,
			@RequestParam("idEscuela") Long idEscuela,
			@RequestParam("anioEscuela") Integer anioEscuela,
			@RequestParam("idTurno") Integer turno,
			@RequestParam("fechaNac") String fechaNac,
			@RequestParam("sucursalID") Long sucursalID,
			@RequestParam("sucursal") String sucursal,
			@RequestParam("cbu") String cbu,
			@RequestParam("bancoID")Long bancoID,
			@RequestParam("vinculoRA") Integer vinculoRA,
			@RequestParam("relacionVivienda") Integer relacionVivienda,
			@RequestParam("alumnoNacionalidad") String alumnoNacionalidad,
			@RequestParam("responsableNacionalidad") String responsableNacionalidad,			
			@RequestParam(required=false, value="vinculoFFs") String[] vinculoFFs,
			@RequestParam(required=false, value="nombreFichas") String[] nombreFichas,
			@RequestParam(required=false, value="apellidoFichas") String[] apellidoFichas,
			@RequestParam(required=false, value="edadFichas") String[] edadFichas,
			@RequestParam(required=false, value="conviveFichas") String[] conviveFichas,
			@RequestParam(required=false, value="nivelEducativoFichas") String[] nivelEducativoFichas,
			@RequestParam(required=false, value="abandonoRepitenciaFichas") String[] abandonoRepitenciaFichas,
			@RequestParam(required=false, value="ocupacionLaboralFichas") String[] ocupacionLaboralFichas,
			@RequestParam(required=false, value="estabilidadLaboralFichas") String[] estabilidadLaboralFichas,
			@RequestParam(required=false, value="renumeracionFichas") String[] renumeracionFichas,
			@RequestParam(required=false, value="otrosIngresosFichas") String[] otrosIngresosFichas,
			@RequestParam(required=false, value="vinculoRA2") Integer vinculoRA2,
			@RequestParam(required=false, value="urlRegreso") String urlRegreso,
			@RequestParam(required=false, value="eae") String eae,
			@RequestParam(required=false, value="reapertura") boolean reapertura,
			@RequestParam(required=false, value="foto") Object foto,
			@RequestParam("actualizacionPBE") boolean actualizacionPBE,
			@RequestParam(required=false, value="actualizacionDatosEgreso") boolean actualizacionDatosEgreso,
			@RequestParam(required=false, value="actualizacionSituacionActual") boolean actualizacionSituacionActual,
			@RequestParam(required=false, value="actualizacionProyeccionDeseada") boolean actualizacionProyeccionDeseada,
			@RequestParam(required= false, value="periodoIdEgreso") Long periodoIdEgreso,
			@RequestParam(required= false, value="periodoIdAsignacion") Long periodoIdAsignacion,
			@RequestParam("actualizacionPeriodoAsignacion") boolean actualizacionPeriodoAsignacion,
			@RequestParam(required=false, value="perfilAlumno.saludBecado") boolean saludBecado,
			@RequestParam(required=false, value="saludBecadoCual") String saludBecadoCual,
			@RequestParam(required=false, value="perfilAlumno.saludFamilia") boolean saludFamilia,
			@RequestParam(required=false, value="saludFamiliarCual") String saludFamiliarCual,
			@RequestParam(required=false, value="observacionesGenerales") String observacionesGenerales,
			@RequestParam(required=false, value="tiempoLibre") String tiempoLibre,
			@RequestParam(required=false, value="cuandoTermine") String cuandoTermine,
			@RequestParam("becaDesasignar") boolean becaDesasignar) throws BatchUpdateException{
		
			if (alumnoNacionalidad==null){
				alumnoNacionalidad="Argentina";
			}
			if (responsableNacionalidad==null){
				responsableNacionalidad="Argentina";
			}
		
		
			Map<String, Object> resul = new HashMap<String, Object>();
			PerfilAlumno alumnoBD = alumnoSrv.obtenerAlumno(idAlumno);
			Persona personaBD = alumnoBD.getDatosPersonales();
			Persona persona = alumno.getDatosPersonales();
			//System.out.println(eae);
			
			alumno.getDatosPersonales().setNacionalidad(alumnoNacionalidad);
			alumnoBD.setEae(eae);
			/* Responsable Adulto 1*/
			ResponsableAdulto responsableAdulto1Base = alumnoBD.getResponsable1();
			ResponsableAdulto responsable1 = alumno.getResponsable1();			
			Localidad localidad = localidadSrv.obtenerLocalidad(idLocalidad);
			
			responsable1.setNacionalidad(responsableNacionalidad);
			responsableAdulto1Base.setNacionalidad(responsableNacionalidad);
			String mensaje = "";
			alumnoBD.setSaludBecado(saludBecado);
			alumnoBD.setSaludBecadoCual(saludBecadoCual);
			alumnoBD.setSaludFamilia(saludFamilia);
			alumnoBD.setSaludFamiliarCual(saludFamiliarCual);
			alumnoBD.setCuandoTermine(cuandoTermine);
			alumnoBD.setTiempoLibre(tiempoLibre);
			alumnoBD.setObservacionesGenerales(observacionesGenerales);
			
			
			
			
			
			boolean error = false;
			/**if (cbu==null || cbu==""){
				cbu="'";
			}
			
			
			if (cbu.length()!=23){				
				cbu=cbu;				
			}*/
			responsableAdulto1Base.setCelular(cbu);
			try{
				/*Si quiere hacer una reapertura de cuenta chequea que no exista ya el nro de cuenta ingresado*/
				if(reapertura){
									
					ResponsableAdulto nuevoResp = crearRA(tipoDniResponsable,
							sucursal, bancoID, vinculoRA, relacionVivienda,
							alumnoBD, persona, responsableAdulto1Base, responsable1, localidad);
									
					alumnoBD.setResponsable1(nuevoResp);
					responsableAdulto1Base.setEstadoCuenta(EstadoCuenta.INACTIVA);
					responsableAdulto1Base.setFechaInactivo(new Date());
					
					
					responsableSrv.agregarResponsable(responsableAdulto1Base);
					pagoSrv.actualzarPagosRA(alumnoBD.getId(),nuevoResp.getId());				
				}
				else{
					String nroCuenta = responsable1.getNroCuenta();
					if(StringUtils.isNotBlank(nroCuenta) && !nroCuenta.equals(responsableAdulto1Base.getNroCuenta()))
						/* sacado para que pegue el nro de cuenta en cualquier ra 
						/ if(responsableSrv.existeNumeroCuenta(nroCuenta)){
						/ 	return fichaAlumnoView(request,idAlumno, urlRegreso,"","Ya existe el nro de cuenta que ingres�");
						/}else{*/
							cambiarEstadoCuenta(responsableAdulto1Base);//}
					setearCamposResponsable(tipoDniResponsable, sucursal, bancoID,vinculoRA, relacionVivienda, 
							responsableAdulto1Base, responsable1, persona, localidad);				
				}
				
				/* Datos Personales */ 
				personaBD.setNombre(persona.getNombre());
				personaBD.setApellido(persona.getApellido());
				personaBD.setTipoDni(TipoDni.getTipoDni(tipoDNI));
				personaBD.setNacionalidad(alumnoNacionalidad);
				personaBD.setDni(persona.getDni());
				personaBD.setNacionalidad(persona.getNacionalidad());
				personaBD.setSexo(persona.isSexo());
				/* fechaNac */
				DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				Date fechaNacimiento = null;
				try {
					fechaNacimiento = (Date) formatter.parse(fechaNac);
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				personaBD.setFechaNacimiento(fechaNacimiento);
				
				personaBD.setDireccion(persona.getDireccion());
				personaBD.setNumeroCalle(persona.getNumeroCalle());
				personaBD.setPiso(persona.getPiso());
				personaBD.setCodigoPostal(persona.getCodigoPostal());
				personaBD.setEntreCalles(persona.getEntreCalles());
				personaBD.setBarrio(persona.getBarrio());
				personaBD.setLocalidad(localidad);
				personaBD.setProvincia(provinciaSrv.obtenerPorId(idProvincia));
				personaBD.setTelefono(persona.getTelefono());
				alumnoBD.setContactoTelefono1(alumno.getContactoTelefono1());
				alumnoBD.setTelefono1(alumno.getTelefono1());
				alumnoBD.setContactoTelefono2(alumno.getContactoTelefono2());
				alumnoBD.setTelefono2(alumno.getTelefono2());
				personaBD.setMail(persona.getMail());
				
				alumnoBD.setSaludBecado(saludBecado);
				alumnoBD.setSaludBecadoCual(saludBecadoCual);
				alumnoBD.setSaludFamilia(saludFamilia);
				alumnoBD.setSaludFamiliarCual(saludFamiliarCual);
				alumnoBD.setCuandoTermine(cuandoTermine);
				alumnoBD.setTiempoLibre(tiempoLibre);
				alumnoBD.setObservacionesGenerales(observacionesGenerales);
				
				
							
				/* Responsable Adulto 2*/ 
				ResponsableAdulto responsableAdulto2Base = null;
				ResponsableAdulto responsable2 = null;
				if(alumnoBD.getResponsable2() != null)
				{
					responsableAdulto2Base = alumnoBD.getResponsable2();
					responsable2 = alumno.getResponsable2(); 
					if(responsable2 != null)
					{
						responsableAdulto2Base.setNombre(responsable2.getNombre());
						responsableAdulto2Base.setActivo(true);
						responsableAdulto2Base.setApellido(responsable2.getApellido());
						responsableAdulto2Base.setContactoTelefono1(responsable2.getContactoTelefono1());
						responsableAdulto2Base.setTelefono1(responsable2.getTelefono1());
						if(vinculoRA2 != null)
							responsableAdulto2Base.setIdVinculo(Vinculo.getVinculo(vinculoRA2));
						else
							responsableAdulto2Base.setIdVinculo(null);
						responsableAdulto2Base.setIdAlumno(alumnoBD);
						alumnoBD.setResponsable2(responsableAdulto2Base);
					}
					else{
						alumnoBD.setResponsable2(null);
					}
				}
				else if(alumno.getResponsable2() != null)
				{
					responsableAdulto2Base = new ResponsableAdulto();
					responsable2 = alumno.getResponsable2();
					responsableAdulto2Base.setNombre(responsable2.getNombre());
					responsableAdulto2Base.setActivo(true);
					responsableAdulto2Base.setApellido(responsable2.getApellido());
					responsableAdulto2Base.setContactoTelefono1(responsable2.getContactoTelefono1());
					responsableAdulto2Base.setTelefono1(responsable2.getTelefono1());
					if(vinculoRA2 != null)
						responsableAdulto2Base.setIdVinculo(Vinculo.getVinculo(vinculoRA2));
					else
						responsableAdulto2Base.setIdVinculo(null);
					responsableAdulto2Base.setIdAlumno(alumnoBD);
					alumnoBD.setResponsable2(responsableAdulto2Base);
					
					alumnoBD.setSaludBecado(saludBecado);
					alumnoBD.setSaludBecadoCual(saludBecadoCual);
					alumnoBD.setSaludFamilia(saludFamilia);
					alumnoBD.setSaludFamiliarCual(saludFamiliarCual);
					alumnoBD.setCuandoTermine(cuandoTermine);
					alumnoBD.setTiempoLibre(tiempoLibre);
					alumnoBD.setObservacionesGenerales(observacionesGenerales);
					
				}
				
				/* Datos Escolares */
				Escuela escuela = escuelaSrv.obtenerEscuelaPorId(idEscuela);
				if(!alumnoBD.getEscuela().equals(escuela)){
					if(alumnoBD.getHistorialEscuela() == null){
						alumnoBD.setHistorialEscuela(new ArrayList<Escuela>());
					}
					alumnoBD.getHistorialEscuela().add(alumnoBD.getEscuela());
				}
				alumnoBD.setEscuela(escuela);
				
				alumnoBD.setAnioEscolar(AnioEscolar.getAnioEscolar(anioEscuela));
				if (alumnoBD.getBeca()!= null){
					if (alumnoBD.getBoletin()!= null)
						alumnoBD.getBoletin().setAno(AnioEscolar.getAnioEscolar(anioEscuela));
					List<EntrevistaIndividual> entrevistas = entrevistaSrv.obtenerEntrevistasPorAlumno(idAlumno, alumnoBD.getBeca().getCiclo());
					if(!entrevistas.isEmpty())
						setearAnioEscolarEntrevistas(entrevistas, anioEscuela);
				}
				alumnoBD.setDivision(alumno.getDivision());
				alumnoBD.setTurno(Turno.getTurnos(turno));
				alumnoBD.setAnioAdicional(alumno.getAnioAdicional());
				
				alumnoBD.setSaludBecado(saludBecado);
				alumnoBD.setSaludBecadoCual(saludBecadoCual);
				alumnoBD.setSaludFamilia(saludFamilia);
				alumnoBD.setSaludFamiliarCual(saludFamiliarCual);
				alumnoBD.setCuandoTermine(cuandoTermine);
				alumnoBD.setTiempoLibre(tiempoLibre);
				alumnoBD.setObservacionesGenerales(observacionesGenerales);
				
				
				/* Actualizacion de los datos ingresados en el tab Actualizacion situacion actual*/
				if(actualizacionPBE)
					actualizarSituacionPBE(alumnoBD, alumno, periodoIdEgreso, actualizacionDatosEgreso, 
							actualizacionSituacionActual, actualizacionProyeccionDeseada);					
				
				/* Ficha Familiar */
				List<FichaFamiliar> listFichaFamiliars = new ArrayList<FichaFamiliar>();
				FichaFamiliar fichaFamiliar = null;
				FichaPresentacion fp = null;
				if(nombreFichas != null){
					for (int i = 0; i < nombreFichas.length; i++) {
						fichaFamiliar = new FichaFamiliar();
						
						if(nombreFichas[i].equals("")){
							break;
						}
						
						fichaFamiliar.setNombre(nombreFichas[i]);
						fichaFamiliar.setApellido(apellidoFichas[i]);
						
						try{
							fichaFamiliar.setEdad(Integer.parseInt(edadFichas[i]));
						}catch(NumberFormatException e){};
						
						try{
							fichaFamiliar.setVinculo(Vinculo.getVinculo(Integer.parseInt(vinculoFFs[i])));
						}catch(NumberFormatException e){};
						
						try{
							fichaFamiliar.setConvive(Convive.getConvive(Integer.parseInt(conviveFichas[i])));
						}catch(NumberFormatException e){};
						
						
						try{
							fichaFamiliar.setNivelEducativo(NivelEducativo.getNivelEducativo(Integer.parseInt(nivelEducativoFichas[i])));
						}catch(NumberFormatException e){};
						
						fichaFamiliar.setAbandonoRepitencia(abandonoRepitenciaFichas[i]);
						fichaFamiliar.setOcupacionLaboral(ocupacionLaboralFichas[i]);
						fichaFamiliar.setEstabilidadLaboral(estabilidadLaboralFichas[i]);
						
						try{
							fichaFamiliar.setRenumeracion(Integer.parseInt(renumeracionFichas[i]));
						}catch(NumberFormatException e){};
						
						try{
							fichaFamiliar.setOtrosIngresos(otrosIngresosFichas[i]);
						}catch(NumberFormatException e){};
	
						
						listFichaFamiliars.add(fichaFamiliar);
					}					
				}
				alumnoBD.setFichaFamiliar(listFichaFamiliars);
				fp = fpSrv.obtenerInformePorAlumno(alumnoBD.getId());
				AlumnoPanelEA alumnoPanel = alumnoPanelSrv.obtenerAlumnoPanelPorIdPerfilAlumno(idAlumno);
				/*Modificacion del periodo de asignaci�n*/
				if(actualizacionPeriodoAsignacion){ 
					Connection cn = null;
			        CallableStatement cl = null;
			        ResultSet rs = null;
			        String call=null;
			        try {
				        call = "{CALL SP_ModificarFechaAsignacionFP(?,?)}";
			            cn = Conexion.getConexion();
			            cl = cn.prepareCall(call);
			            cl.setLong(1, fp.getId());
			            cl.setLong(2, periodoIdAsignacion);
			            rs = cl.executeQuery();
			            Conexion.cerrarCall(cl);
			            Conexion.cerrarConexion(cn);
			            
			        } catch (Exception e) {
			            e.printStackTrace();
			            Conexion.cerrarCall(cl);
			            Conexion.cerrarConexion(cn);
			        }
					
					
					mensaje = this.modificarPeriodoAsignacionBeca(periodoIdAsignacion, alumnoBD, alumnoPanel, fp);
					if(StringUtils.isNotBlank(mensaje))
						return fichaAlumnoView(request,idAlumno, urlRegreso, "", mensaje);
				}					
				
				
				/*Desasignar Beca*/
				if(becaDesasignar){
					mensaje = this.desasignacionBeca(alumnoBD, alumnoPanel);
					if(StringUtils.isNotBlank(mensaje))
						return fichaAlumnoView(request,idAlumno, urlRegreso, "", mensaje);
				}
				
				if(fp != null){
					fp.setConvivientes(listFichaFamiliars);
					fpSrv.guardarInformeFP(fp);
				}			
				
				/* Actualizaci�n del alumno panel ea */			
				if(alumnoPanel != null){				
					alumnoPanel.setAnio(alumnoBD.getAnioEscolar());
					alumnoPanel.setDni(alumnoBD.getDatosPersonales().getDni());
					alumnoPanel.setNombreApellido(alumnoBD.getDatosPersonales().getApellido() + "," + alumnoBD.getDatosPersonales().getNombre());
					alumnoPanel.setZona(alumnoBD.getEscuela().getZonaCimientos().getNombre());
					alumnoPanel.setEscuela(alumnoBD.getEscuela().getNombre());
					
					if(StringUtils.isNotBlank(alumnoBD.getResponsable1().getNroCuenta()))
						alumnoPanel.setCuentaRA(alumnoBD.getResponsable1().getNroCuenta());
					else
						alumnoPanel.setCuentaRA(null);
					
					if(alumnoBD.getResponsable1().getEstadoCuenta() != null){					
						if(alumnoBD.getResponsable1().getEstadoCuenta().equals(EstadoCuenta.ACTIVA))
							alumnoPanel.setColorRA(ConstantesPaneles.GREEN);
						else
							if(alumnoBD.getResponsable1().getEstadoCuenta().equals(EstadoCuenta.CORREGIDA))
								alumnoPanel.setColorRA(ConstantesPaneles.YELLOW);
							else
								alumnoPanel.setColorRA(ConstantesPaneles.RED);
					}
					else
						alumnoPanel.setColorRA(ConstantesPaneles.RED);
					
					alumnoPanelSrv.modificarAlumnoPanelEA(alumnoPanel);
				}
				
				alumnoSrv.agregarAlumno(alumnoBD);			
				
				guardarFoto(foto, alumnoBD.getDatosPersonales().getDni());
			}
			catch (DataIntegrityViolationException e) {
				error = true;				
			}
			
			if(error)
				return fichaAlumnoView(request, idAlumno, urlRegreso,"","Ya existe una persona con el DNI ingresado. Por favor ingrese un nuevo DNI");
			else{			
				if(StringUtils.isNotBlank(urlRegreso))
					return new ModelAndView("redirect:" + urlRegreso + "?mensaje=Los cambios se han guardado satisfactoriamente");
				else{					
					/* Carga de objetos de formulario */
					resul.put("mensaje", "Los cambios se han guardado satisfactoriamente");
					resul.put("perfilAlumno", alumnoBD);
					resul.put("listDni", TipoDni.getListaTipos());
					resul.put("listAnioEscolar",AnioEscolar.getAnioEscolares());					
					resul.put("listTurno", Turno.getListaTurnos());
					resul.put("localidades", localidadSrv.obtenerTodos());
					resul.put("listProvincias", provinciaSrv.obtenerTodas());
					resul.put("listVinculo", Vinculo.getListaVinculos());
					resul.put("listConvive", Convive.getListaConvives());
					resul.put("listNivelEducativo", NivelEducativo.getListaNivelEducativo());
					resul.put("listRelacionVivienda", RelacionVivienda.getRelacionViviendas());
					resul.put("volver","volver");
					return forward("fichaAlumno/fichaAlumnoView", resul);			
				}
			}
	}


	/**
	 * Siempre y cuando el estado de la cuenta no sea "Inactiva", se pasa a "Activa"
	 * @param responsableAdulto1Base
	 */
	private void cambiarEstadoCuenta(ResponsableAdulto responsableAdulto1Base) {
		responsableAdulto1Base.setEstadoCuenta(EstadoCuenta.ACTIVA);
	}

	/**
	 * Crea un nuevo RA a partir de los datos completados en el formulario. Se usa cuando se hace una reapertura de cuenta.
	 * Deja la cuenta en estado "no solicitada"
	 * @param tipoDniResponsable
	 * @param sucursal
	 * @param bancoID
	 * @param vinculoRA
	 * @param relacionVivienda
	 * @param alumnoBD
	 * @param responsableAdulto1Base
	 * @param responsable1
	 * @return
	 */
	private ResponsableAdulto crearRA(Integer tipoDniResponsable,
			String sucursal, Long bancoID, Integer vinculoRA,
			Integer relacionVivienda, PerfilAlumno alumnoBD,
			Persona persona, ResponsableAdulto responsableAdulto1Base,
			ResponsableAdulto responsable1, Localidad localidad) {
		ResponsableAdulto nuevoResp = new ResponsableAdulto();
		nuevoResp.setEstadoCuenta(EstadoCuenta.NO_SOLICITADA);
		setearCamposResponsable(tipoDniResponsable, sucursal, bancoID, vinculoRA, relacionVivienda, nuevoResp, responsable1, persona, localidad);
		nuevoResp.setIdAlumno(alumnoBD);
		nuevoResp.setNroCuenta(null);
		nuevoResp.setActivo(true);
		nuevoResp.setCelular(persona.getCelular());
		nuevoResp.setContactoTelefono1(responsableAdulto1Base.getContactoTelefono1());
		nuevoResp.setContactoTelefono2(responsableAdulto1Base.getContactoTelefono2());
		nuevoResp.setIdAptoComoRA(responsableAdulto1Base.getIdAptoComoRA());
		nuevoResp.setIdCompromiso(responsableAdulto1Base.getIdCompromiso());
		nuevoResp.setIdCompromisoPBE(responsableAdulto1Base.getIdCompromisoPBE());
		nuevoResp.setIdEntrevistador(responsableAdulto1Base.getIdEntrevistador());
		nuevoResp.setIdEstadoCivil(responsableAdulto1Base.getIdEstadoCivil());
		nuevoResp.setIdTipoAfyp(responsableAdulto1Base.getIdTipoAfyp());
		nuevoResp.setInformacionComplementaria(responsableAdulto1Base.getInformacionComplementaria());
		nuevoResp.setIngresos(responsableAdulto1Base.getIngresos());
		nuevoResp.setLegajo(responsableAdulto1Base.getLegajo());
		nuevoResp.setMail(responsableAdulto1Base.getMail());
		nuevoResp.setMotivoFallidoCuenta(responsableAdulto1Base.getMotivoFallidoCuenta());
		nuevoResp.setObservaciones(responsableAdulto1Base.getObservaciones());
		nuevoResp.setObservacionesParaTS(responsableAdulto1Base.getObservacionesParaTS());
		nuevoResp.setPercepcionesSobreRA(responsableAdulto1Base.getPercepcionesSobreRA());
		nuevoResp.setSolicitudCuenta(responsableAdulto1Base.isSolicitudCuenta());
		nuevoResp.setSucursalPago(responsableAdulto1Base.getSucursalPago());
		nuevoResp.setTelefono1(responsableAdulto1Base.getTelefono1());
		nuevoResp.setTelefono2(responsableAdulto1Base.getTelefono2());
		return nuevoResp;
	}

	/**
	 * En responsableOrigen se cargan todos los datos de responsable1
	 * @param tipoDniResponsable
	 * @param sucursal
	 * @param bancoID
	 * @param vinculoRA
	 * @param relacionVivienda
	 * @param responsableOrigen
	 * @param responsable1
	 */
	private void setearCamposResponsable(Integer tipoDniResponsable,String sucursal, Long bancoID, Integer vinculoRA,
			Integer relacionVivienda, ResponsableAdulto responsableOrigen,ResponsableAdulto responsable1, 
			Persona persona, Localidad localidad) {
		responsableOrigen.setEgresosTotales(responsable1.getEgresosTotales());
		responsableOrigen.setNombre(responsable1.getNombre());
		responsableOrigen.setApellido(responsable1.getApellido());
		responsableOrigen.setIdTipoDni(TipoDni.getTipoDni(tipoDniResponsable));
		responsableOrigen.setIdVinculo(Vinculo.getVinculo(vinculoRA));
		responsableOrigen.setIdRelacionVivienda(RelacionVivienda.getRelacionVivienda(relacionVivienda));
		responsableOrigen.setDni(responsable1.getDni());
		responsableOrigen.setCuilCuit(Formateador.formatearCuilSinGuiones(responsable1.getCuilCuit()));
		responsableOrigen.setNacionalidad(responsable1.getNacionalidad());
		if(responsable1.getFechaNacimiento() != null)
		{
			responsableOrigen.setFechaNacimiento(responsable1.getFechaNacimiento());	
		}
		if(StringUtils.isNotBlank(responsable1.getNroCuenta()))
			responsableOrigen.setNroCuenta(responsable1.getNroCuenta());
		else if(responsable1.getNroCuenta() != null){			
				responsableOrigen.setNroCuenta(null);
				if(StringUtils.isBlank(responsable1.getNroCuenta()) && responsableOrigen.getEstadoCuenta().equals(EstadoCuenta.ACTIVA))
					responsableOrigen.setEstadoCuenta(EstadoCuenta.INACTIVA);
		}
		responsableOrigen.setSucursalBanco(sucursalSrv.obtenerSucursalBanco( Integer.parseInt(sucursal)));
		responsableOrigen.setBanco(bancoID != null ? bancoSrv.obtenerBanco(bancoID) : null);
		responsableOrigen.setSexo(responsable1.getSexo());
		responsableOrigen.setNoAsisteEntrevista(responsable1.getNoAsisteEntrevista());
		responsableOrigen.setDireccion(persona.getDireccion());
		responsableOrigen.setCalle(persona.getDireccion());
		responsableOrigen.setNroCalle(persona.getNumeroCalle());
		responsableOrigen.setPiso(persona.getPiso());
		responsableOrigen.setCodigoPostal(persona.getCodigoPostal());
		responsableOrigen.setEntreCalles(persona.getEntreCalles());
		responsableOrigen.setIdLocalidad(persona.getLocalidad());
		responsableOrigen.setTelefono(persona.getTelefono());
		responsableOrigen.setDpto(persona.getDepartamento());
		responsableOrigen.setIdLocalidad(localidad);
	}

	private void setearAnioEscolarEntrevistas(List<EntrevistaIndividual> entrevistas, Integer anioEscuela) {
		
		for (EntrevistaIndividual entrevista : entrevistas) {
			if ((entrevista.getTipoEntrevista()!= TipoEntrevista.RENOVACION))
			{				
				entrevista.setAnioEscolar(AnioEscolar.getAnioEscolar(anioEscuela));
				entrevistaSrv.guardarEntrevista(entrevista);
			}
		}
	}
	
	private void actualizarSituacionPBE(PerfilAlumno alumnoBD, PerfilAlumno alumno, Long periodoIdEgreso, boolean actualizacionDatosEgreso, 
			boolean actualizacionSituacionActual, boolean actualizacionProyeccionDeseada){
		
		if(actualizacionDatosEgreso){//Se actualiza la situacion escolar
			Long idPeriodoEgreso = periodoIdEgreso != null && periodoIdEgreso.equals(0l) ? null : periodoIdEgreso;		
			if(idPeriodoEgreso != null){ 
				Periodo periodoDeEgreso = svrPeriodo.obtenerPeriodo(idPeriodoEgreso);		
				if(periodoDeEgreso != null){
					alumnoBD.setPeriodoDeEgreso(periodoDeEgreso);
					alumnoBD.setUltimaActualizacion(new Date());
					alumnoBD.setSituacionEscolar(SituacionEscolarAlumno.EGRESO);					
				}
			}
			else{
				alumnoBD.setPeriodoDeEgreso(null);
				alumnoBD.setUltimaActualizacion(null);
				alumnoBD.setSituacionEscolar(alumnoBD.getSituacionEscolarUltimaEntevista());				
			}
		}
		
		if(actualizacionSituacionActual){ //Se actualiza la situacion actual
			alumnoBD.setSituacionActual(alumno.getSituacionActual());
			alumnoBD.setOtraSituacion(alumno.getOtraSituacion());
			alumnoBD.setFechaSituacionActual(new Date());
		}
		
		if(actualizacionProyeccionDeseada){ //Se actualiza la proyeccion deseada
			alumnoBD.setProyeccionDeseada(alumno.getProyeccionDeseada());
			alumnoBD.setOtraProyeccion(alumno.getOtraProyeccion());
			alumnoBD.setFechaProyeccionDeseada(new Date());
		}
		
		alumnoBD.setObsPostPBE(alumno.getObsPostPBE());
	}
	
	private String modificarPeriodoAsignacionBeca(Long periodoIdAsignacion, PerfilAlumno perfilAlumno, AlumnoPanelEA alumnoPanel, FichaPresentacion fp){
		Long idPeriodoAsignacion = periodoIdAsignacion != null && periodoIdAsignacion.equals(0l) ? null : periodoIdAsignacion;		
		String mensaje = "";
		if(idPeriodoAsignacion != null){
			Periodo periodoDeAsignacion = svrPeriodo.obtenerPeriodo(idPeriodoAsignacion);
			CicloPrograma cicloActual = svrCiclo.obtenerCicloActual();
			Periodo periodoActual = PeriodoHelper.getPeriodoActual(perfilAlumno.getBeca().getCiclo().getPeriodos(), new Date());
			Periodo periodoBecaAsignada = PeriodoHelper.getPeriodoActual(perfilAlumno.getBeca().getCiclo().getPeriodos(), perfilAlumno.getFechaAltaBeca());
			if(periodoDeAsignacion != null){
				List<EntrevistaIndividual> entrevistas = new ArrayList<EntrevistaIndividual>();
				List<EntrevistaSeleccion> entrevistasSeleccion = entrevistaSeleccionSrv.obtenerEntrevistasSeleccionPorAlumno(perfilAlumno);
				List<Pago> pagos = new ArrayList<Pago>();
				int ordenPeriodo = periodoDeAsignacion.getOrden();
				int ultimoOrdenPeriodo = 0;
				int ordenPeriodoPago = periodoDeAsignacion.getOrden();
				int ultimoOrdenPeriodoPago = 0;
				int cantidadSemaforos = (periodoActual.getOrden() - periodoDeAsignacion.getOrden())+1;
				List<Long> periodosIds = PeriodoHelper.obtenerListaIdsPeriodos(perfilAlumno.getBeca().getCiclo().getPeriodos());
				boolean sePuedeModificar = true;
				if(periodoDeAsignacion.getOrden() >= periodoBecaAsignada.getOrden()){
					entrevistas = srvEntrevistas.obtenerEntrevistasPorAlumnoOrden(perfilAlumno.getId(), cicloActual, "descendiente");
					pagos = srvPagos.obtenerPagosPorAlumnoDecreciente(perfilAlumno.getId(),periodosIds);
					ultimoOrdenPeriodo = (entrevistas.size() + ordenPeriodo) - 1;
					ultimoOrdenPeriodoPago = (pagos.size() + ordenPeriodoPago) - 1;
					int cantidadEntrevistas = entrevistas.size();
					Periodo ultimoPeriodo = periodoActual.getCiclo().getPeriodos().get(periodoActual.getCiclo().getPeriodos().size()-1);
					List<Periodo> periodos = svrPeriodo.obtenerPeriodosBeca(periodoDeAsignacion, ultimoPeriodo);					
					int cantidadPeriodos = (periodos.size());
					if(cantidadEntrevistas >=  cantidadPeriodos){
						sePuedeModificar = false;
						mensaje = "No se puede modificar el periodo de asignaci�n del becado " + perfilAlumno.getDatosPersonales().getApellidoNombre()+ 
							" porque la cantidad de entrevistas realizadas supera la cantidad a realizar";
					}
					else
						if(perfilAlumno.getEstadoAlumno().equals(EstadoAlumno.INCORPORACION_PENDIENTE) && 
								cantidadEntrevistas == (cantidadPeriodos-1)){
							sePuedeModificar = false;
							mensaje = "No se puede modificar el periodo de asignaci�n del becado " + perfilAlumno.getDatosPersonales().getApellidoNombre()+ 
								" porque la cantidad de entrevistas realizadas supera la cantidad a realizar";
						}
				}
				else{
					entrevistas = srvEntrevistas.obtenerEntrevistasPorAlumnoOrden(perfilAlumno.getId(), cicloActual, "ascendente");
					pagos = srvPagos.obtenerPagosPorAlumno(perfilAlumno.getId(),periodosIds);
					ultimoOrdenPeriodo = ordenPeriodo;
					ultimoOrdenPeriodoPago = ordenPeriodo;
				}	
				if(sePuedeModificar){
					if(perfilAlumno.getEstadoAlumno().equals(EstadoAlumno.ALTA_BECADO)){ //Aun no se ha aprobado la incorporacion efectiva
						perfilAlumno.setFechaAltaBeca(periodoDeAsignacion.getFechaInicio());
						alumnoPanel.setFechaAltaBeca(periodoDeAsignacion.getFechaInicio());		
						alumnoPanel.setEntrevistas(cantidadSemaforos);
						alumnoPanel.setPagos(cantidadSemaforos);
						if(entrevistas.size() == 1){ //la entrevista de incorporacion aun no est� finalizada
							EntrevistaIndividual entrevistaIncorporacion = (EntrevistaIndividual) entrevistas.get(0);
							entrevistaIncorporacion.setPeriodoDePago(periodoDeAsignacion);
							entrevistaIncorporacion.setFechaAltaBeca(periodoDeAsignacion.getFechaInicio());
							if(alumnoPanel.getEntrevistasRealizadas() == alumnoPanel.getEntrevistas() && 
									!entrevistaIncorporacion.getEstadoEntrevista().equals(EstadoEntrevista.CONSTRUCCION))
								alumnoPanel.setColorEntrevistas(ConstantesPaneles.GREEN);
							else
								alumnoPanel.setColorEntrevistas(ConstantesPaneles.RED);
							if(alumnoPanel.getPagosRealizados() == alumnoPanel.getPagos() && this.evaluarSemaforoPagos(pagos))
								alumnoPanel.setColorPagos(ConstantesPaneles.GREEN);	
							else
								alumnoPanel.setColorPagos(ConstantesPaneles.RED);							
							srvEntrevistas.guardarEntrevista(entrevistaIncorporacion);					
						}					
					}
					else{
						if(perfilAlumno.getEstadoAlumno().equals(EstadoAlumno.INCORPORACION_PENDIENTE)){ //al menos ya tiene una entrevista finalizada
							perfilAlumno.setFechaAltaBeca(periodoDeAsignacion.getFechaInicio());
							alumnoPanel.setFechaAltaBeca(periodoDeAsignacion.getFechaInicio());	
							alumnoPanel.setEntrevistas(cantidadSemaforos);
							alumnoPanel.setPagos(cantidadSemaforos);
							if(!entrevistas.isEmpty()){						
								for(EntrevistaIndividual entrevista: entrevistas){						
									Periodo periodoDeAsignacionEntrevista = PeriodoHelper.obtenerPeriodoPorOrden(perfilAlumno.getBeca().getCiclo().getPeriodos(),ultimoOrdenPeriodo);
									entrevista.setPeriodoDePago(periodoDeAsignacionEntrevista);
									entrevista.setFechaAltaBeca(periodoDeAsignacion.getFechaInicio());
									if(periodoDeAsignacion.getOrden() >= periodoBecaAsignada.getOrden())
										ultimoOrdenPeriodo = periodoDeAsignacionEntrevista.getOrden()-1;
									else
										ultimoOrdenPeriodo = periodoDeAsignacionEntrevista.getOrden()+1;
									srvEntrevistas.guardarEntrevista(entrevista);
								}
								for(Pago pago: pagos){
									Periodo periodoDeAsignacionPago = PeriodoHelper.obtenerPeriodoPorOrden(perfilAlumno.getBeca().getCiclo().getPeriodos(),ultimoOrdenPeriodoPago);
									pago.setPeriodo(periodoDeAsignacionPago);
									if(periodoDeAsignacion.getOrden() >= periodoBecaAsignada.getOrden())
										ordenPeriodo = periodoDeAsignacionPago.getOrden()-1;
									else
										ordenPeriodo = periodoDeAsignacionPago.getOrden()+1;
									srvPagos.agregarPago(pago);
								}
								EntrevistaIndividual entrevistaIncorporacion = (EntrevistaIndividual) entrevistas.get(0);
								if(entrevistaIncorporacion != null){
									if(alumnoPanel.getEntrevistasRealizadas() == alumnoPanel.getEntrevistas() &&
											!entrevistaIncorporacion.getEstadoEntrevista().equals(EstadoEntrevista.CONSTRUCCION))
										alumnoPanel.setColorEntrevistas(ConstantesPaneles.GREEN);
									else
										alumnoPanel.setColorEntrevistas(ConstantesPaneles.RED);
				
									if(alumnoPanel.getPagosRealizados() == alumnoPanel.getPagos() && this.evaluarSemaforoPagos(pagos))
										alumnoPanel.setColorPagos(ConstantesPaneles.GREEN);	
									else
										alumnoPanel.setColorPagos(ConstantesPaneles.RED);	
								}
							}
							else
								mensaje = "Existe una inconsistencia entre el estado del alumno " +
									perfilAlumno.getDatosPersonales().getApellidoNombre() + " y la cantidad de entrevistas realizadas";
						}
						else{
							if(perfilAlumno.getEstadoAlumno().equals(EstadoAlumno.INCORPORADO)){ //al menos tiene una entrevista de incorporacion finalizada
								if(fp != null){
									if(!fp.getEstado().equals(EstadoInforme.ENVIADO)){
										perfilAlumno.setFechaAltaBeca(periodoDeAsignacion.getFechaInicio());
										perfilAlumno.setFechaPBE(periodoDeAsignacion.getFechaInicio());
										alumnoPanel.setFechaAltaBeca(periodoDeAsignacion.getFechaInicio());	
										fp.setFechaAlta(periodoDeAsignacion.getFechaInicio());
										fp.setFechaPBE(periodoDeAsignacion.getFechaInicio());
										alumnoPanel.setEntrevistas(cantidadSemaforos);
										alumnoPanel.setPagos(cantidadSemaforos);
										if(!entrevistas.isEmpty()){
											for(EntrevistaIndividual entrevista: entrevistas){						
												Periodo periodoDeAsignacionEntrevista = PeriodoHelper.obtenerPeriodoPorOrden(perfilAlumno.getBeca().getCiclo().getPeriodos(),ultimoOrdenPeriodo);
												entrevista.setPeriodoDePago(periodoDeAsignacionEntrevista);
												entrevista.setFechaAltaBeca(periodoDeAsignacion.getFechaInicio());
												if(periodoDeAsignacion.getOrden() >= periodoBecaAsignada.getOrden())
													ultimoOrdenPeriodo = periodoDeAsignacionEntrevista.getOrden()-1;	
												else
													ultimoOrdenPeriodo = periodoDeAsignacionEntrevista.getOrden()+1;	
												srvEntrevistas.guardarEntrevista(entrevista);
											}
											for(Pago pago: pagos){
												Periodo periodoDeAsignacionPago = PeriodoHelper.obtenerPeriodoPorOrden(perfilAlumno.getBeca().getCiclo().getPeriodos(),ultimoOrdenPeriodoPago);
												pago.setPeriodo(periodoDeAsignacionPago);
												if(periodoDeAsignacion.getOrden() >= periodoBecaAsignada.getOrden())
													ultimoOrdenPeriodoPago = periodoDeAsignacionPago.getOrden()-1;		
												else
													ultimoOrdenPeriodoPago = periodoDeAsignacionPago.getOrden()+1;	
												srvPagos.agregarPago(pago);
											}
											EntrevistaIndividual entrevistaIncorporacion = (EntrevistaIndividual) entrevistas.get(0);
											if(entrevistaIncorporacion != null){
												if(alumnoPanel.getEntrevistasRealizadas() == alumnoPanel.getEntrevistas() &&
														!entrevistaIncorporacion.getEstadoEntrevista().equals(EstadoEntrevista.CONSTRUCCION))
													alumnoPanel.setColorEntrevistas(ConstantesPaneles.GREEN);
												else
													alumnoPanel.setColorEntrevistas(ConstantesPaneles.RED);
												
												if(alumnoPanel.getPagosRealizados() == alumnoPanel.getPagos() && this.evaluarSemaforoPagos(pagos))
													alumnoPanel.setColorPagos(ConstantesPaneles.GREEN);	
												else
													alumnoPanel.setColorPagos(ConstantesPaneles.RED);	
											}
										}
									}
									else{
										mensaje = "No se puede modificar el periodo de asignaci�n del becado " +
											perfilAlumno.getDatosPersonales().getApellidoNombre()+ " porque su FP ya fue enviada al padrino";
									}
								}
								else{
									perfilAlumno.setFechaAltaBeca(periodoDeAsignacion.getFechaInicio());
									perfilAlumno.setFechaPBE(periodoDeAsignacion.getFechaInicio());
									alumnoPanel.setFechaAltaBeca(periodoDeAsignacion.getFechaInicio());									
									alumnoPanel.setEntrevistas(cantidadSemaforos);
									alumnoPanel.setPagos(cantidadSemaforos);
									if(!entrevistas.isEmpty()){
										for(EntrevistaIndividual entrevista: entrevistas){						
											Periodo periodoDeAsignacionEntrevista = PeriodoHelper.obtenerPeriodoPorOrden(perfilAlumno.getBeca().getCiclo().getPeriodos(),ultimoOrdenPeriodo);
											entrevista.setPeriodoDePago(periodoDeAsignacionEntrevista);
											entrevista.setFechaAltaBeca(periodoDeAsignacion.getFechaInicio());
											if(periodoDeAsignacion.getOrden() >= periodoBecaAsignada.getOrden())
												ultimoOrdenPeriodo = periodoDeAsignacionEntrevista.getOrden()-1;	
											else
												ultimoOrdenPeriodo = periodoDeAsignacionEntrevista.getOrden()+1;	
											srvEntrevistas.guardarEntrevista(entrevista);
										}
										for(Pago pago: pagos){
											Periodo periodoDeAsignacionPago = PeriodoHelper.obtenerPeriodoPorOrden(perfilAlumno.getBeca().getCiclo().getPeriodos(),ultimoOrdenPeriodoPago);
											pago.setPeriodo(periodoDeAsignacionPago);
											if(periodoDeAsignacion.getOrden() >= periodoBecaAsignada.getOrden())
												ultimoOrdenPeriodoPago = periodoDeAsignacionPago.getOrden()-1;		
											else
												ultimoOrdenPeriodoPago = periodoDeAsignacionPago.getOrden()+1;	
											srvPagos.agregarPago(pago);
										}
										EntrevistaIndividual entrevistaIncorporacion = (EntrevistaIndividual) entrevistas.get(0);
										if(entrevistaIncorporacion != null){
											if(alumnoPanel.getEntrevistasRealizadas() == alumnoPanel.getEntrevistas() &&
													!entrevistaIncorporacion.getEstadoEntrevista().equals(EstadoEntrevista.CONSTRUCCION))
												alumnoPanel.setColorEntrevistas(ConstantesPaneles.GREEN);
											else
												alumnoPanel.setColorEntrevistas(ConstantesPaneles.RED);
											
											if(alumnoPanel.getPagosRealizados() == alumnoPanel.getPagos() && this.evaluarSemaforoPagos(pagos))
												alumnoPanel.setColorPagos(ConstantesPaneles.GREEN);	
											else
												alumnoPanel.setColorPagos(ConstantesPaneles.RED);	
										}
									}
								}
							}					
						}
					}
					if(entrevistasSeleccion != null){
						for (EntrevistaSeleccion entrevistaSeleccion : entrevistasSeleccion) {
							entrevistaSeleccion.setNombrePeriodo(periodoDeAsignacion.getNombre());
							entrevistaSeleccionSrv.guardarEntrevista(entrevistaSeleccion);						
						}
					}
				}
			}
			else
				mensaje = "Debe seleccionar un per�odo v�lido";
		}
		
		return mensaje;
	}
	
	private String desasignacionBeca(PerfilAlumno alumnoBD, AlumnoPanelEA alumnoPanelEA){
		String error = "";
		if(alumnoBD.getEstadoAlumno().equals(EstadoAlumno.ALTA_BECADO)){
			CicloPrograma cicloActual = svrCiclo.obtenerCicloActual();
			List<EntrevistaIndividual> entrevistas = srvEntrevistas.obtenerEntrevistasPorAlumnoOrden(alumnoBD.getId(), cicloActual, "descendiente");
			if(entrevistas != null && !entrevistas.isEmpty())
				error = "No se puede desasignar la beca porque el/la alumno/a " + alumnoBD.getDatosPersonales().getApellidoNombre() 
					+ " cuenta con al menos una entrevista de acompa�amiento creada";
			else{
				alumnoBD.setFechaAltaBeca(null);				
				PerfilEA perfilEA = alumnoBD.getEa();
				if(perfilEA != null){
					perfilEA.getBecados().remove(alumnoBD);
					alumnoBD.setEa(null);
				}
				alumnoPanelEA.setFechaAltaBeca(null);
				alumnoPanelEA.setActivo(false);
				alumnoPanelEA.setIdPerfilEA(null);
				Beca beca = alumnoBD.getBeca();
				if(beca != null){
					beca.setCantidadAsignada(beca.getCantidadAsignada()-1);
					becaSrv.guardarBeca(beca);
					alumnoBD.setBeca(null);
				}	
				List<EntrevistaSeleccion> entrevistasSeleccion = entrevistaSeleccionSrv.obtenerEntrevistasSeleccionPorAlumno(alumnoBD);
				if(entrevistasSeleccion != null){
					for (EntrevistaSeleccion entrevistaSeleccion : entrevistasSeleccion) {
						entrevistaSeleccion.setNombrePeriodo(null);
						entrevistaSeleccionSrv.guardarEntrevista(entrevistaSeleccion);						
					}
				}
				alumnoBD.setEstadoAlumno(EstadoAlumno.APROBADO);
				
			}
		}
		else
			error = "No se puede desasignar la beca porque el/la alumno/a " + alumnoBD.getDatosPersonales().getApellidoNombre() 
			+ " no cuenta con el estado correcto para realizar esta acci�n";
		return error;
	}

	@InitBinder
	public void initBinder(HttpServletRequest request,WebDataBinder binder) {
		
	    // custom date binding
	    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	    
	    binder.registerCustomEditor(SituacionActual.class, new PropertyEditorSupport() {
	        @Override
	        public void setAsText(String text) {
	        	if(!StringUtils.isBlank(text)){
		            int id = Integer.parseInt(text);
		            SituacionActual valor = SituacionActual.getSituacionActual(id);
		            setValue(valor);
	        	 }else{
	        		 setValue("");
			     }
	        }
	    });
	    
	    binder.registerCustomEditor(ProyeccionDeseada.class, new PropertyEditorSupport() {
	        @Override
	        public void setAsText(String text) {
	        	if(!StringUtils.isBlank(text)){
		            int id = Integer.parseInt(text);
		            ProyeccionDeseada valor = ProyeccionDeseada.getProyeccionDeseada(id);
		            setValue(valor);
	        	 }else{
	        		 setValue("");
			     }
	        }
	    });
	}
	
	@RequestMapping("/fichaAlumno/mostrarImagen.do")
	public void mostrarFirma(HttpServletResponse response,@RequestParam("dni") Integer dni) {		
//		response.setContentType("image/jpeg");
//		OutputStream output = null;
//		FileInputStream input = null;
//		File file = null;
//		if(dni == 0)
//			file = new File(getProps().getProperty(ConstantesInformes.pathImagen) + ConstantesInformes.imagenGenerica + ConstantesInformes.extensionImagen);
//		else
//			file = new File(getProps().getProperty(ConstantesInformes.pathImagen) + dni.toString() + ConstantesInformes.extensionImagen);
//			
//		try {
//			
//			output = response.getOutputStream();
//			input = new FileInputStream(file);
//			byte[] buffer = new byte[(int) file.length()];
//			input.read(buffer);
//			response.setContentLength(buffer.length);
//			output.write(buffer);
//		} catch (Exception e) {
//			file = new File(getProps().getProperty(ConstantesInformes.pathImagen)+"sinfoto.jpg");
//			try {
//				output = response.getOutputStream();
//				input = new FileInputStream(file);
//				byte[] buffer = new byte[(int) file.length()];
//				input.read(buffer);
//				response.setContentLength(buffer.length);
//				output.write(buffer);
//			} catch (Exception ex) {
//				ex.printStackTrace();
//			}
//			//e.printStackTrace();
//		} finally {
//			try {
//				input.close();
//				output.close();
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//		}
	}

	
	private void guardarFoto(Object foto, Integer dni) {
		try {
			CommonsMultipartFile imagen = (CommonsMultipartFile) foto;
			if((imagen.getFileItem().getName().contains(".jpg") || imagen.getFileItem().getName().contains(".JPG"))){ 
				File file = new File(getProps().getProperty(ConstantesInformes.pathImagen) 
						+ dni.toString() + ConstantesInformes.extensionImagen);
				imagen.transferTo(file);
				
				BufferedImage originalImage = ImageIO.read(file);
				int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
				
				//Reduce solo las imagenes mayores al tama�o que predefinimos(400x300)
				if(originalImage.getWidth() > IMG_WIDTH){					
					BufferedImage resizeImageJpg = resizeImage(originalImage, type);
					ImageIO.write(resizeImageJpg, "jpg", file); 
				}
			}
			
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
    private static BufferedImage resizeImage(BufferedImage originalImage, int type){
    	BufferedImage resizedImage;
    	if(originalImage.getHeight() > originalImage.getWidth())
    		resizedImage = new BufferedImage(IMG_HEIGHT,IMG_WIDTH, type);
    	else
    		resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
    	
    	Graphics2D g = resizedImage.createGraphics();
    	if(originalImage.getHeight() > originalImage.getWidth())
    		g.drawImage(originalImage, 0, 0, IMG_HEIGHT,IMG_WIDTH, null);
    	else
    		g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
    	g.dispose();
     
    	return resizedImage;
        }
    
    
	@RequestMapping("/fichaAlumno/guardarPostPBE.do")
	public ModelAndView guardarguardarPostPBE(@RequestParam("idAlumno") Long idAlumno,
			@RequestParam(required=false, value="urlRegreso") String urlRegreso){
		
		return new ModelAndView("redirect:" + urlRegreso);		
	}
	
	private boolean evaluarSemaforoPagos(List<Pago> pagos){
		boolean existe = true;
		Iterator iterator = pagos.iterator();
		while(iterator.hasNext() && existe){
			Pago pago = (Pago) iterator.next();
			if(pago.getEstadoPago().equals(EstadoPago.CORREGIDO) || pago.getEstadoPago().equals(EstadoPago.FALLIDO)
					|| pago.getEstadoPago().equals(EstadoPago.APROBADO)){
				existe = false;
			}
		}		
		return existe;
	}
}