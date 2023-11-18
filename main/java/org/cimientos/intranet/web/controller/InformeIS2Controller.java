package org.cimientos.intranet.web.controller;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.cimientos.intranet.modelo.Boletin;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.Materia;
import org.cimientos.intranet.modelo.Periodo;
import org.cimientos.intranet.modelo.escuela.Escuela;
import org.cimientos.intranet.modelo.informe.EstadoInforme;
import org.cimientos.intranet.modelo.informe.Informe;
import org.cimientos.intranet.modelo.informe.InformeIS2;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.Entrevista;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaIndividual;
import org.cimientos.intranet.modelo.perfil.AlumnoPanelEA;
import org.cimientos.intranet.modelo.perfil.PerfilAlumno;
import org.cimientos.intranet.modelo.perfilEA.PerfilEA;
import org.cimientos.intranet.modelo.persona.Persona;
import org.cimientos.intranet.servicio.AlumnoPanelEASrv;
import org.cimientos.intranet.servicio.AlumnoSrv;
import org.cimientos.intranet.servicio.CicloProgramaSrv;
import org.cimientos.intranet.servicio.EntrevistaSrv;
import org.cimientos.intranet.servicio.EscuelaSrv;
import org.cimientos.intranet.servicio.InformeIS1Srv;
import org.cimientos.intranet.servicio.InformeIS2Srv;
import org.cimientos.intranet.servicio.InformeSrv;
import org.cimientos.intranet.servicio.MateriaSrv;
import org.cimientos.intranet.servicio.PeriodoSrv;
import org.cimientos.intranet.utils.ConstantesInformes;
import org.cimientos.intranet.utils.ConstantesMenu;
import org.cimientos.intranet.utils.ConstantesPaneles;
import org.cimientos.intranet.utils.Formateador;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cimientos.intranet.enumerativos.EnumPBE;

@Controller
@RequestMapping("/informeIS2/*")
public class InformeIS2Controller extends BaseController {

	@Autowired
	private AlumnoSrv srvAlumno;

	@Autowired
	private InformeIS2Srv srvInformeIS2;

	@Autowired
	private InformeSrv srvInforme;

	@Autowired
	private InformeIS1Srv srvIS1;

	@Autowired
	private CicloProgramaSrv srvCiclo;

	@Autowired
	private AlumnoPanelEASrv alumnoPanelEaSrv;

	@Autowired
	private EntrevistaSrv srvEntrevistas;

	@Autowired
	private PeriodoSrv srvPeriodo;

	@Autowired
	private EscuelaSrv srvEscuela;

	@Autowired
	private MateriaSrv srvMateria;

	private static final String ACCION_FINALIZAR = "finalizar";
	private static final String ACCION_REVISAR = "revisar";

	@RequestMapping("/informeIS2/listaCandidatos.do")
	public ModelAndView listaCandidatos() {
		Map<String, Object> resul = new HashMap<String, Object>();

		resul.put("alumnos", srvAlumno.obtenerTodos());

		return forward("/informeIS2/listaCandidatos", resul);
	}

	@RequestMapping("/informeIS2/registrarInformeIS2.do")
	public ModelAndView registrarInformeIS2(@RequestParam("idAlumno") Long id) {

		Map<String, Object> resul = new HashMap<String, Object>();
		PerfilAlumno becado = srvAlumno.obtenerAlumno(id);
		Integer edad = Formateador.calcularEdad(becado.getDatosPersonales()
				.getFechaNacimiento());
		List<EntrevistaIndividual> entrevistasPagosSuspendidos = srvEntrevistas
				.obtenerEntrevistasConPagoSuspendidoPorAlumno(becado.getId());
		resul.put("suspensiones",
				generarDetalleSuspensiones(entrevistasPagosSuspendidos));
		// Boletin boletin = becado.getBoletin();

		Boletin boletin = srvInforme.getBoletinCicloInforme(becado,
				srvCiclo.obtenerCicloActual());
		List<Materia> listaMaterias = null;
		if (boletin != null) {
			listaMaterias = boletin.getMaterias();
		} else {
			listaMaterias = srvMateria.obtenerMateriasBasicas(true);
		}
		Periodo periodoFechaPBE = srvPeriodo.obtenerPeriodoPorFechaFP(becado
				.getFechaPBE());
		Escuela escuela = srvEscuela.obtenerEscuelaPorId(becado.getEscuela()
				.getId());
		String modalidadTrabajoEscuela = new String();
		File file = new File(getProps().getProperty(
				ConstantesInformes.pathImagen)
				+ becado.getDatosPersonales().getDni().toString()
				+ ConstantesInformes.extensionImagen);
		if (file.exists())
			resul.put("tieneFoto", true);
		else
			resul.put("tieneFoto", false);

		if (becado.getFechaPBE() != null)
			if (periodoFechaPBE != null)
				resul.put("periodoFechaPBE", periodoFechaPBE.getNombre() + " "
						+ periodoFechaPBE.getCiclo().getNombre());
			else
				resul.put("periodoFechaPBE", Formateador.formatearFechas(
						becado.getFechaPBE(), "dd/MM/yyyy"));

		if (becado.getFechaReincorporacionPBE() != null) { // es un chico
															// reincorporado
			Periodo periodoFechaReincorporacionPBE = srvPeriodo
					.obtenerPeriodoPorFechaFP(becado
							.getFechaReincorporacionPBE());
			if (periodoFechaReincorporacionPBE != null)
				resul.put("periodoFechaReincorporacionPBE",
						periodoFechaReincorporacionPBE.getNombre()
								+ " "
								+ periodoFechaReincorporacionPBE.getCiclo()
										.getNombre());
			else
				resul.put("periodoFechaReincorporacionPBE", Formateador
						.formatearFechas(becado.getFechaReincorporacionPBE(),
								"dd/MM/yyyy"));
		} else {
			resul.put("periodoFechaReincorporacionPBE", null);
		}

		resul.put("becado", becado);
		resul.put("cicloActual", srvCiclo.obtenerCicloActual());
		resul.put("valores", EnumPBE.getEnumPBE());
		resul.put("edad", edad);
		resul.put("escuela", escuela);
		if (escuela.getModalidadTrabajoEscuela() != null)
			modalidadTrabajoEscuela = escuela.getModalidadTrabajoEscuela()
					.getValor();
		resul.put("modalidadTrabajoEscuela", modalidadTrabajoEscuela);

		resul.put("cantidadBecadosCimiento",
				srvAlumno.cantidadAlumnosActivosMismaEscuela(escuela));
		if (boletin != null) {
			resul.put("boletin", boletin);
			resul.put("listMateriasInteres", boletin.getMaterias());
			resul.put("listMateriasCuestan", boletin.getMaterias());
			resul.put("primero", boletin.getTrimestres().get(0));
			resul.put("segundo", boletin.getTrimestres().get(1));
			resul.put("tercero", boletin.getTrimestres().get(2));
		} else {
			List<Materia> materiasTroncales = srvMateria
					.obtenerMateriasBasicas(true);
			resul.put("listMateriasInteres", materiasTroncales);
			resul.put("listMateriasCuestan", materiasTroncales);
		}
		resul.put("cantMateriasCuestan", 0);
		resul.put("cantMateriasInteres", 0);
		resul.put("incluirBoletinCheck", 0);

		Long idEntrevista = 0L;
		Connection cn0 = null;
		try {
			String query = "select tarang,paa,vtepa,vtepb,vtepc,vtepd,vtepe,vtepf,vtepg,vteph,vtepi,iatarni,sus,ige, qtam , contenidos_trabajar_durante_anio, hs_trabajar_a�o, sarpepe, osme, id, proposito_anual,iamp from entrevista where periodo_de_pago=385 and perfil_alumno="
					+ id;

			cn0 = Conexion.getConexion();
			Statement st = cn0.createStatement();
			ResultSet rs0 = st.executeQuery(query);

			while (rs0.next()) {
				idEntrevista = Long.parseLong(rs0.getString("id"));
				resul.put("qtam", rs0.getString("qtam"));
				resul.put("actividadAcompanamiento",
						rs0.getString("contenidos_trabajar_durante_anio"));
				resul.put("hsTrabajarA�o", rs0.getString("hs_trabajar_a�o"));
				resul.put("sarpepe", rs0.getString("sarpepe"));
				resul.put("osme", rs0.getString("osme"));
				resul.put("propositoAnual", rs0.getString("proposito_anual"));
				resul.put("iamp", rs0.getString("iamp"));

				resul.put("tarang", rs0.getString("tarang"));
				resul.put("paa", rs0.getString("paa"));
				resul.put("vtepa", rs0.getString("vtepa"));
				resul.put("vtepb", rs0.getString("vtepb"));
				resul.put("vtepc", rs0.getString("vtepc"));
				resul.put("vtepd", rs0.getString("vtepd"));
				resul.put("vtepe", rs0.getString("vtepe"));
				resul.put("vtepf", rs0.getString("vtepf"));
				resul.put("vtepg", rs0.getString("vtepg"));
				resul.put("vteph", rs0.getString("vteph"));
				resul.put("vtepi", rs0.getString("vtepi"));
				resul.put("iatarni", rs0.getString("iatarni"));
				
				resul.put("sus", rs0.getString("sus"));
				resul.put("ige", rs0.getString("ige"));

			}
			st.close();
			Conexion.cerrarConexion(cn0);
		} catch (SQLException e) {
			e.printStackTrace();

			Conexion.cerrarConexion(cn0);
		} catch (Exception e) {
			e.printStackTrace();

			Conexion.cerrarConexion(cn0);
		}
		
		
		// marterias previas
		
		String materiasPendientes="";
		try {  
            String query="select materia,anio_escolar from previas_nuevo p where ja<>'Aprobado' and di<>'Aprobado' and fb<>'Aprobado' and ma<>'Aprobado' and mam<>'Aprobado' and idbecado="+id;
            cn0 = Conexion.getConexion();
            Statement st = cn0.createStatement();
            ResultSet rs0 = st.executeQuery(query);        
		    
            while (rs0.next()) {	                    
            	materiasPendientes=materiasPendientes+rs0.getString("materia")+" - "+rs0.getString("anio_escolar")+", ";
	            
            }
           //entrevistaIndividual.setMp(materiasPendientes);
           resul.put("mp", materiasPendientes);
           
           st.close();
           
            
	        Conexion.cerrarConexion(cn0);
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
	        Conexion.cerrarConexion(cn0);
		}
		
		
		

		String cta = "";
		try {
			String query = "select * from contenidos_trabajar_en_el_anio where contenidos_trabajar_en_el_anio.entrevista="
					+ idEntrevista;

			cn0 = Conexion.getConexion();
			Statement st = cn0.createStatement();
			ResultSet rs0 = st.executeQuery(query);

			while (rs0.next()) {
				// System.out.println(rs0.getString(2));
				if (Long.parseLong(rs0.getString(2)) == 0) {
					cta = "Autoconcepto - Autoconocimiento y autoestima";
				}
				if (Long.parseLong(rs0.getString(2)) == 1) {
					cta = cta + "Autoconcepto - Autoeficacia y autoconfianza";
				}
				if (Long.parseLong(rs0.getString(2)) == 2) {
					cta = cta
							+ "Responsabilidad y autonom�a - Responsabilidad y compromiso";
				}
				if (Long.parseLong(rs0.getString(2)) == 3) {
					cta = cta
							+ "Responsabilidad y autonom�a - Autocontrol y determinaci�n";
				}
				if (Long.parseLong(rs0.getString(2)) == 4) {
					cta = cta + "Responsabilidad y autonom�a - Autonom�a";
				}
				if (Long.parseLong(rs0.getString(2)) == 5) {
					cta = cta
							+ "Planificaci�n y organizaci�n del tiempo - Planificaci�n y proyecto de vida";
				}
				if (Long.parseLong(rs0.getString(2)) == 6) {
					cta = cta
							+ "Planificaci�n y organizaci�n del tiempo - Organizaci�n del tiempo";
				}
				if (Long.parseLong(rs0.getString(2)) == 7) {
					cta = cta
							+ "Planificaci�n y organizaci�n del tiempo - H�bitos de estudio";
				}
				if (Long.parseLong(rs0.getString(2)) == 8) {
					cta = cta
							+ "Toma de decisiones - Pensamiento cr�tico y creativo";
				}
				if (Long.parseLong(rs0.getString(2)) == 9) {
					cta = cta + "Toma de decisiones - Entusiasmo por aprender";
				}
				if (Long.parseLong(rs0.getString(2)) == 10) {
					cta = cta
							+ "Toma de decisiones - Sentido de la oportunidad";
				}
				if (Long.parseLong(rs0.getString(2)) == 11) {
					cta = cta
							+ "Relaciones Interpersonales - Asertividad y comunicaci�n";
				}
				if (Long.parseLong(rs0.getString(2)) == 12) {
					cta = cta
							+ "Relaciones Interpersonales - Empat�a y trabajo con otros";
				}
				if (Long.parseLong(rs0.getString(2)) == 13) {
					cta = cta
							+ "Relaciones Interpersonales - Convivencia y resoluci�n de conflictos";
				}
				if (Long.parseLong(rs0.getString(2)) == 14) {
					cta = cta + "Relaciones Interpersonales - Participaci�n";
				}
				if (Long.parseLong(rs0.getString(2)) == 15) {
					cta = cta + "Egreso Efectivo y transici�n post-escolar";
				}
				if (Long.parseLong(rs0.getString(2)) == 16) {
					cta = cta + "Elecci�n de la orientaci�n y cambio de ciclo";
				}
				if (Long.parseLong(rs0.getString(2)) == 17) {
					cta = cta + "Transici�n primaria-secundaria";
				}
				cta = cta + "\n";

			}
			st.close();
			Conexion.cerrarConexion(cn0);
		} catch (SQLException e) {
			e.printStackTrace();

			Conexion.cerrarConexion(cn0);
		} catch (Exception e) {
			e.printStackTrace();

			Conexion.cerrarConexion(cn0);
		}

		resul.put("actividadAcompanamiento", cta);

		return forward("/informeIS2/registrarInformeIS2", resul);
	}

	@RequestMapping("/informeIS2/generarIS2.do")
	public ModelAndView generarInformeInformeIS2(
			HttpServletRequest req,
			@RequestParam(required = false, value = "accion") String accion,
			@RequestParam("cantMateriasDesaprobadas") Integer cantMateriasDesaprobadas,
			@RequestParam("cantInasistencias") Float cantInasistencias,
			@RequestParam("mensajePadrino") String mensajePadrino,
			@RequestParam("actividadAcompanamiento") String actividadAcompanamiento,
			@RequestParam("materiasInteres") String materiasInteres,
			@RequestParam("materiasCuestan") String materiasCuestan,
			@RequestParam("hsTrabajarA�o") String hsTrabajarAnio,
			@RequestParam(required = false, value ="sarpepe") String sarpepe,
			@RequestParam("idAlumno") Long idAlumno,
			@RequestParam("edad") Integer edad,
			@RequestParam("qtam") String qtam,
			@RequestParam("osme") String osme,
			@RequestParam("propositoAnual") String propositoAnual,
			@RequestParam("iamp") String iamp,
			@RequestParam("tarang") String tarang,
			@RequestParam("paa") String paa,
			@RequestParam("vtepa") String vtepa,
			@RequestParam("vtepb") String vtepb,
			@RequestParam("vtepc") String vtepc,
			@RequestParam("vtepd") String vtepd,
			@RequestParam("vtepe") String vtepe,
			@RequestParam("vtepf") String vtepf,
			@RequestParam("vtepg") String vtepg,
			@RequestParam("vteph") String vteph,
			@RequestParam("vtepi") String vtepi,
			@RequestParam("iatarni") String iatarni,
			@RequestParam("mp") String mp,
			@RequestParam("sus") String sus,
			@RequestParam("ige") String ige,
			@RequestParam(required = false, value = "incluirBoletinCheck") Boolean incluirBoletinCheck,
			@RequestParam(required = false, value = "urlRegreso") String urlRegreso) {
		ModelAndView modelAndView = null;
		Map<String, Object> resul = new HashMap<String, Object>();
		PerfilAlumno becado = srvAlumno.obtenerAlumno(idAlumno);
		HttpSession session = req.getSession();
		List<AlumnoPanelEA> alumnos = new ArrayList<AlumnoPanelEA>();
		PerfilEA perfilEA = getPerfilEA(req);
		CicloPrograma cicloActual = srvCiclo.obtenerCicloActual();
		InformeIS2 informeIS2Becado = srvInformeIS2.obtenerInformePorIdAlumno(
				idAlumno, cicloActual);
		InformeIS2 informeIS2 = new InformeIS2();
		String mensaje = "";
		String error = "";
		Integer edadBecado = Formateador.calcularEdad(becado
				.getDatosPersonales().getFechaNacimiento());
		if (informeIS2Becado != null) {
			error = "El becado "
					+ becado.getDatosPersonales().getApellidoNombre()
					+ " ya posee un Informe de Seguimiento N� 2 "
					+ "en el ciclo actual";
		} else {
			Escuela escuela = srvEscuela.obtenerEscuelaPorId(becado
					.getEscuela().getId());
			informeIS2.setNombre(ConstantesInformes.nombreInformeIS2);
			informeIS2.setFechaAlta(new Date());
			informeIS2.setActividadAcompanamiento(actividadAcompanamiento);
			informeIS2.setMensajePadrino(mensajePadrino);
			informeIS2.setCicloActual(cicloActual);
			informeIS2.setEaPerfil(becado.getEa());
			informeIS2.setRrPerfil(becado.getEa().getRr());
			informeIS2.setFechaPBE(becado.getFechaPBE());
			informeIS2.setFechaReincorporacionPBE(becado
					.getFechaReincorporacionPBE());
			informeIS2.setFechaUltimaModificacion(new Date());
			informeIS2.setPadrino(becado.getBeca().getPadrino());
			informeIS2.setBeca(becado.getBeca());
			informeIS2.setBecado(becado);
			informeIS2.setEdad(edadBecado);
			informeIS2.setFechaCambioUltimoEstado(new Date());
			informeIS2.setFechaUltimaModificacion(new Date());
			informeIS2.setCantidadBecados(srvAlumno
					.cantidadAlumnosActivosMismaEscuela(escuela));
			informeIS2.setMateriasDesaprobadas(cantMateriasDesaprobadas);
			informeIS2.setInasistencias(cantInasistencias);
			informeIS2.setMateriasCuestan(materiasCuestan);
			informeIS2.setMateriasInteres(materiasInteres);
			informeIS2.setQtam(qtam);
			informeIS2.setOsme(osme);
			informeIS2.setHsTrabajarA�o(hsTrabajarAnio);
			informeIS2.setSarpepe(sarpepe);
			informeIS2.setPropositoAnual(propositoAnual);
			informeIS2.setIamp(iamp);
			informeIS2.setTarang(tarang);
			informeIS2.setPaa(paa);
			informeIS2.setVtepa(vtepa);
			informeIS2.setVtepb(vtepb);
			informeIS2.setVtepc(vtepc);
			informeIS2.setVtepd(vtepd);
			informeIS2.setVtepe(vtepe);
			informeIS2.setVtepf(vtepf);
			informeIS2.setVtepg(vtepg);
			informeIS2.setVteph(vteph);
			informeIS2.setVtepi(vtepi);
			informeIS2.setIatarni(iatarni);
			informeIS2.setMp(mp);
			informeIS2.setSus(sus);
			informeIS2.setIge(ige);
			informeIS2.setIncluirBoletinCheck(incluirBoletinCheck);
		}
		if (accion != null && accion.equals(ACCION_FINALIZAR)) {
			if (informeIS2Becado != null) {
				resul.put("error", error);
			} else {
				informeIS2.setEstado(EstadoInforme.FINALIZADO);
				srvInformeIS2.guardarInformeIS2(informeIS2);
				// mensaje = "El Informe de Seguimiento N�2 del becado " +
				// becado.getDatosPersonales().getApellidoNombre() +
				// " ha sido Finalizado";
			}
			List<Informe> informes = new ArrayList<Informe>();
			if (perfilEA != null) {
				informes = srvInforme
						.obtenerInformesConstruccionPorEA(perfilEA);
				informes.addAll(srvIS1.obtenerRevisionPorEA(perfilEA));
			}
			if (StringUtils.isNotBlank(urlRegreso)) {
				resul.put("informes", informes);
				modelAndView = new ModelAndView("redirect:" + urlRegreso, resul);
				return modelAndView;
			} else {
				modelAndView = new ModelAndView(
						"redirect:/informes/listaInformesConstruccion.do",
						resul);
				return modelAndView;
			}
		} else {
			if (informeIS2Becado != null) {
				resul.put("error", error);
			} else {
				informeIS2.setEstado(EstadoInforme.CONSTRUCCION);
				srvInformeIS2.guardarInformeIS2(informeIS2);
				// mensaje = "El Informe de Seguimiento N�2 del becado " +
				// becado.getDatosPersonales().getApellidoNombre() +
				// " ha sido guardado en Construcci�n";
			}
			alumnos = alumnoPanelEaSrv.obtenerAlumnosPorEa(perfilEA
					.getIdPerfilEA());
			resul.put("alumnos", alumnos);
			resul.put("edad", edadBecado);
			resul.put("mensaje", mensaje);
			session.setAttribute("menu", ConstantesMenu.menuAcompanamiento);
			List<Informe> informes = new ArrayList<Informe>();
			if (perfilEA != null) {
				informes = srvInforme
						.obtenerInformesConstruccionPorEA(perfilEA);
				informes.addAll(srvIS1.obtenerRevisionPorEA(perfilEA));
			}
			resul.put("informes", informes);
			modelAndView = new ModelAndView(
					"redirect:/entrevistas/listarBecados.do", resul);
			return modelAndView;
		}
	}

	@RequestMapping("/informeIS2/modificarView.do")
	public ModelAndView modificarView(
			@RequestParam("idInformeIS2") Long idInforme,
			@RequestParam(required = false, value = "urlRegreso") String urlRegreso,
			@RequestParam(required = false, value = "accion") String accion,
			@RequestParam(required = false, value = "valorPerfil") String valorPerfil) {
		Map<String, Object> resul = new HashMap<String, Object>();
		InformeIS2 informeIS2 = srvInformeIS2.obtenerInformeIS2(idInforme);
		Periodo periodoFechaPBE = srvPeriodo
				.obtenerPeriodoPorFechaFP(informeIS2.getFechaPBE());
		PerfilAlumno becado = informeIS2.getBecado();
		Escuela escuela = srvEscuela.obtenerEscuelaPorId(becado.getEscuela()
				.getId());
		String modalidadTrabajoEscuela = new String();
		List<Long> listLocalMateriasInteres = null;
		int cantMateriasInteres = 0;
		if (informeIS2.getMateriasInteres() != null
				&& !informeIS2.getMateriasInteres().equals("")) {
			listLocalMateriasInteres = new ArrayList<Long>();
			listLocalMateriasInteres = Formateador.toListOfLongs(informeIS2
					.getMateriasInteres());
			cantMateriasInteres = listLocalMateriasInteres.size();
		}
		List<Long> listLocalMateriasCuestan = null;
		int cantMateriasCuestan = 0;
		if (informeIS2.getMateriasCuestan() != null
				&& !informeIS2.getMateriasCuestan().equals("")) {
			listLocalMateriasCuestan = new ArrayList<Long>();
			listLocalMateriasCuestan = Formateador.toListOfLongs(informeIS2
					.getMateriasCuestan());
			cantMateriasCuestan = listLocalMateriasCuestan.size();
		}
		resul.put("informe", informeIS2);
		resul.put("cicloActual", srvCiclo.obtenerCicloActual());
		resul.put("cantMateriasDesaprobadas",
				informeIS2.getMateriasDesaprobadas());
		resul.put("cantInasistencias", informeIS2.getInasistencias());
		resul.put("mensajePadrino", informeIS2.getMensajePadrino());
		resul.put("actividadAcompanamiento",
				informeIS2.getActividadAcompanamiento());
		resul.put("materiasInteres", informeIS2.getMateriasInteres());
		resul.put("idMateriaInteres", listLocalMateriasInteres);
		resul.put("cantMateriasInteres", cantMateriasInteres);
		resul.put("materiasCuestan", informeIS2.getMateriasCuestan());
		resul.put("idMateriaCuestan", listLocalMateriasCuestan);
		resul.put("cantMateriasCuestan", cantMateriasCuestan);
		resul.put("qtam", informeIS2.getQtam());
		resul.put("osme", informeIS2.getOsme());
		resul.put("propositoAnual", informeIS2.getPropositoAnual());
		resul.put("iamp", informeIS2.getIamp());

		resul.put("propositoAnual", informeIS2.getPropositoAnual());
		resul.put("iamp", informeIS2.getIamp());
		resul.put("hsTrabajarA�o", informeIS2.getHsTrabajarA�o());
		resul.put("sarpepe", informeIS2.getSarpepe());
		resul.put("incluirBoletinCheck", informeIS2.getIncluirBoletinCheck());

		resul.put("tarang", informeIS2.getTarang());
		resul.put("paa", informeIS2.getPaa());
		resul.put("vtepa", informeIS2.getVtepa());
		resul.put("vtepb", informeIS2.getVtepb());
		resul.put("vtepc", informeIS2.getVtepc());
		resul.put("vtepd", informeIS2.getVtepd());
		resul.put("vtepe", informeIS2.getVtepe());
		resul.put("vtepf", informeIS2.getVtepf());
		resul.put("vtepg", informeIS2.getVtepg());
		resul.put("vteph", informeIS2.getVteph());
		resul.put("vtepi", informeIS2.getVtepi());
		resul.put("iatarni", informeIS2.getIatarni());
		resul.put("mp", informeIS2.getMp());
		resul.put("sus", informeIS2.getSus());
		resul.put("ige", informeIS2.getIge());

		if (!informeIS2.getEstado().equals(EstadoInforme.ENVIADO)) {
			Integer edad = Formateador.calcularEdad(becado.getDatosPersonales()
					.getFechaNacimiento());
			informeIS2.setEdad(edad);
		}
		srvInformeIS2.guardarInformeIS2(informeIS2);
		resul.put("edad", informeIS2.getEdad());
		resul.put("becado", becado);
		resul.put("idInformeIS2", idInforme);
		resul.put("urlRegreso", urlRegreso);
		resul.put("escuela", escuela);
		if (escuela.getModalidadTrabajoEscuela() != null)
			modalidadTrabajoEscuela = escuela.getModalidadTrabajoEscuela()
					.getValor();
		resul.put("modalidadTrabajoEscuela", modalidadTrabajoEscuela);

		resul.put("cantidadBecadosCimiento",
				srvAlumno.cantidadAlumnosActivosMismaEscuela(escuela));

		Boletin boletin = srvInforme.getBoletinCicloInforme(becado,
				informeIS2.getCicloActual());
		if (boletin != null) {
			resul.put("boletin", boletin);
			resul.put("listMateriasInteres", boletin.getMaterias());
			resul.put("listMateriasCuestan", boletin.getMaterias());
			resul.put("primero", boletin.getTrimestres().get(0));
			resul.put("segundo", boletin.getTrimestres().get(1));
			resul.put("tercero", boletin.getTrimestres().get(2));
		} else {
			List<Materia> materiasTroncales = srvMateria
					.obtenerMateriasBasicas(true);
			resul.put("listMateriasInteres", materiasTroncales);
			resul.put("listMateriasCuestan", materiasTroncales);
		}

		File file = new File(getProps().getProperty(
				ConstantesInformes.pathImagen)
				+ becado.getDatosPersonales().getDni().toString()
				+ ConstantesInformes.extensionImagen);
		if (file.exists())
			resul.put("tieneFoto", true);
		else
			resul.put("tieneFoto", false);

		if (informeIS2.getFechaPBE() != null)
			if (periodoFechaPBE != null)
				resul.put("periodoFechaPBE", periodoFechaPBE.getNombre() + " "
						+ periodoFechaPBE.getCiclo().getNombre());
			else
				resul.put("periodoFechaPBE", Formateador.formatearFechas(
						informeIS2.getFechaPBE(), "dd/MM/yyyy"));

		if (informeIS2.getFechaReincorporacionPBE() != null) { // es un chico
																// reincorporado
			Periodo periodoFechaReincorporacionPBE = srvPeriodo
					.obtenerPeriodoPorFechaFP(informeIS2
							.getFechaReincorporacionPBE());
			if (periodoFechaReincorporacionPBE != null)
				resul.put("periodoFechaReincorporacionPBE",
						periodoFechaReincorporacionPBE.getNombre()
								+ " "
								+ periodoFechaReincorporacionPBE.getCiclo()
										.getNombre());
			else
				resul.put("periodoFechaReincorporacionPBE", Formateador
						.formatearFechas(
								informeIS2.getFechaReincorporacionPBE(),
								"dd/MM/yyyy"));
		} else {
			resul.put("periodoFechaReincorporacionPBE", null);
		}

		if (accion != null && accion.equals("edicion")) {
			resul.put("urlRegreso",
					"/reporteGeneralInformes/verReporteGeneralInformes.do");
			resul.put("valorPerfil", valorPerfil);
			resul.put("estadoConstruccion",
					EstadoInforme.CONSTRUCCION.getValor());
			resul.put("estadoFinalizado", EstadoInforme.FINALIZADO.getValor());
			return forward("/informeIS2/actualizarInformeIS2", resul);
		}

		return forward("/informeIS2/modificarInformeIS2", resul);

	}

	@RequestMapping("/informeIS2/modificarIS2.do")
	public ModelAndView modificarInformeInformeIS2(
			HttpServletRequest req,
			@RequestParam(required = false, value = "idInformeIS2") Long idInforme,
			@RequestParam(required = false, value = "accion") String accion,
			@RequestParam("cantMateriasDesaprobadas") Integer cantMateriasDesaprobadas,
			@RequestParam("cantInasistencias") Float cantInasistencias,
			@RequestParam("mensajePadrino") String mensajePadrino,
			@RequestParam("actividadAcompanamiento") String actividadAcompanamiento,
			@RequestParam("materiasInteres") String materiasInteres,
			@RequestParam("materiasCuestan") String materiasCuestan,
			@RequestParam("idAlumno") Long idAlumno,
			@RequestParam("edad") Integer edad,
			@RequestParam("qtam") String qtam,
			@RequestParam("osme") String osme,
			@RequestParam("hsTrabajarA�o") String hsTrabajarAnio,
			@RequestParam("propositoAnual") String propositoAnual,
			@RequestParam("iamp") String iamp,
			@RequestParam(required = false, value ="sarpepe") String sarpepe,
			@RequestParam("tarang") String tarang,
			@RequestParam("paa") String paa,
			@RequestParam("vtepa") String vtepa,
			@RequestParam("vtepb") String vtepb,
			@RequestParam("vtepc") String vtepc,
			@RequestParam("vtepd") String vtepd,
			@RequestParam("vtepe") String vtepe,
			@RequestParam("vtepf") String vtepf,
			@RequestParam("vtepg") String vtepg,
			@RequestParam("vteph") String vteph,
			@RequestParam("vtepi") String vtepi,
			@RequestParam("iatarni") String iatarni,
			@RequestParam("mp") String mp,
			@RequestParam("sus") String sus,
			@RequestParam("ige") String ige,
			@RequestParam(required = false, value = "incluirBoletinCheck") Boolean incluirBoletinCheck,
			@RequestParam(required = false, value = "urlRegreso") String urlRegreso) {

		Map<String, Object> resul = new HashMap<String, Object>();
		ModelAndView model = null;
		PerfilAlumno becado = srvAlumno.obtenerAlumno(idAlumno);
		InformeIS2 informeIS2 = srvInformeIS2.obtenerInformeIS2(idInforme);
		if (!informeIS2.getEstado().equals(EstadoInforme.ENVIADO)) {
			Integer edadBecado = Formateador.calcularEdad(becado
					.getDatosPersonales().getFechaNacimiento());
			informeIS2.setEdad(edadBecado);
		}
		informeIS2.setActividadAcompanamiento(actividadAcompanamiento);
		informeIS2.setMensajePadrino(mensajePadrino);
		// informeIS2.setCicloActual(srvCiclo.obtenerCicloActual());
		informeIS2.setEaPerfil(becado.getEa());
		informeIS2.setRrPerfil(becado.getEa().getRr());
		informeIS2.setFechaPBE(becado.getFechaPBE());
		informeIS2.setFechaReincorporacionPBE(becado
				.getFechaReincorporacionPBE());
		informeIS2.setFechaUltimaModificacion(new Date());
		informeIS2.setPadrino(becado.getBeca().getPadrino());
		informeIS2.setBeca(becado.getBeca());
		informeIS2.setBecado(becado);
		informeIS2.setQtam(qtam);
		informeIS2.setOsme(osme);
		informeIS2.setHsTrabajarA�o(hsTrabajarAnio);
		informeIS2.setSarpepe(sarpepe);
		informeIS2.setPropositoAnual(propositoAnual);
		informeIS2.setIamp(iamp);
		Integer edadBecado = Formateador.calcularEdad(becado
				.getDatosPersonales().getFechaNacimiento());
		informeIS2.setEdad(edadBecado);
		informeIS2.setFechaCambioUltimoEstado(new Date());
		informeIS2.setCantidadBecados(srvAlumno
				.cantidadAlumnosActivosMismaEscuela(becado.getEscuela()));
		informeIS2.setMateriasDesaprobadas(cantMateriasDesaprobadas);
		informeIS2.setInasistencias(cantInasistencias);
		informeIS2.setMateriasCuestan(materiasCuestan);
		informeIS2.setMateriasInteres(materiasInteres);
		
		informeIS2.setTarang(tarang);
		informeIS2.setPaa(paa);
		informeIS2.setVtepa(vtepa);
		informeIS2.setVtepb(vtepb);
		informeIS2.setVtepc(vtepc);
		informeIS2.setVtepd(vtepd);
		informeIS2.setVtepe(vtepe);
		informeIS2.setVtepf(vtepf);
		informeIS2.setVtepg(vtepg);
		informeIS2.setVteph(vteph);
		informeIS2.setVtepi(vtepi);
		informeIS2.setIatarni(iatarni);
		informeIS2.setMp(mp);
		informeIS2.setSus(sus);
		informeIS2.setIge(ige);
		
		informeIS2.setIncluirBoletinCheck(incluirBoletinCheck);
		if (accion != null && accion.equals(ACCION_REVISAR)) {
			informeIS2.setEstado(EstadoInforme.CONSTRUCCION);
		}

		srvInformeIS2.guardarInformeIS2(informeIS2);
		resul.put("mensaje", "El Informe de Seguimiento N�2 del becado "
				+ becado.getDatosPersonales().getApellidoNombre()
				+ " ha sido guardado en Construcci�n");
		if (StringUtils.isNotBlank(urlRegreso)) {
			// model = new ModelAndView(urlRegreso, resul);
			return model = new ModelAndView("redirect:" + urlRegreso, resul);
		} else
			return model = new ModelAndView(
					"redirect:/informes/listaInformesConstruccion.do", resul);
	}

	@RequestMapping("/informeIS2/supervisar.do")
	public ModelAndView supervision(
			HttpServletRequest req,
			@RequestParam(required = false, value = "accion") String accion,
			@RequestParam(required = false, value = "idInformeIS2") Long idInforme,
			@RequestParam(required = false, value = "materiasAprobadas") Integer materiasAprobadas,
			@RequestParam(required = false, value = "materiasDesaprobadas") Integer materiasDesaprobadas,
			@RequestParam(required = false, value = "inasistencias") Float inasistencias,
			@RequestParam(required = false, value = "obsBoletin") String obsBoletin,
			@RequestParam("compromisoAlumno") Integer compromisoAlumno,
			@RequestParam("conducta") Integer conducta,
			@RequestParam("esfuerzo") Integer esfuerzo,
			@RequestParam("compromisoRA") Integer compromisoRA,
			@RequestParam("asistenciaBecadoAEntrevistaPBE") Integer asistenciaBecadoAEntrevistaPBE,
			@RequestParam("presentacionMaterialPBE") Integer presentacionMaterialPBE,
			@RequestParam("compromisoAlumnoPBE") Integer compromisoAlumnoPBE,
			@RequestParam("asistenciaRAEntrevistaPBE") Integer asistenciaRAEntrevistaPBE,
			@RequestParam("compromisoRaPBE") Integer compromisoRaPBE,
			@RequestParam("actividadAcompanamiento") String actividadAcompanamiento,
			@RequestParam("comentarios") String comentarios,
			@RequestParam("obsPersonales") String obsPersonales,
			@RequestParam("obsFamiliares") String obsFamiliares,
			@RequestParam("obsGenerales") String obsGenerales,
			@RequestParam("edad") Integer edad,
			@RequestParam("idAlumno") Long idAlumno,
			@RequestParam(required = false, value = "incluirBoletinCheck") Boolean incluirBoletinCheck,
			@RequestParam("utilizacionBeca") String utilizacionBeca,
			@RequestParam(required = false, value = "suspensiones") String suspensiones,
			@RequestParam(required = false, value = "urlRegreso") String urlRegreso) {

		ModelAndView modelAndView = null;
		Map<String, Object> resul = new HashMap<String, Object>();
		PerfilEA perfilEA = getPerfilEA(req);
		InformeIS2 informeIS2 = null;
		PerfilAlumno becado = srvAlumno.obtenerAlumno(idAlumno);
		if (idInforme != null)
			informeIS2 = srvInformeIS2.obtenerInformeIS2(idInforme);
		else {
			informeIS2 = new InformeIS2();
			informeIS2.setFechaAlta(new Date());
			informeIS2.setEaPerfil(perfilEA);
			informeIS2.setRrPerfil(perfilEA.getRr());
			informeIS2.setNombre(ConstantesInformes.nombreInformeIS2);
			informeIS2.setPadrino(becado.getBeca().getPadrino());
			informeIS2.setBecado(becado);
			informeIS2.setBeca(becado.getBeca());
		}

		guardarCamposNoSeleccionado(informeIS2, conducta, compromisoAlumno,
				esfuerzo, asistenciaBecadoAEntrevistaPBE,
				presentacionMaterialPBE, compromisoAlumnoPBE,
				asistenciaRAEntrevistaPBE, compromisoRaPBE, compromisoRA);
		informeIS2.setActividadAcompanamiento(actividadAcompanamiento);
		informeIS2.setComentarios(comentarios);
		informeIS2.setObsPersonales(obsPersonales);
		informeIS2.setObsFamiliares(obsFamiliares);
		informeIS2.setObsGenerales(obsGenerales);
		if (!informeIS2.getEstado().equals(EstadoInforme.ENVIADO)) {
			Integer edadBecado = Formateador.calcularEdad(becado
					.getDatosPersonales().getFechaNacimiento());
			informeIS2.setEdad(edadBecado);
		}
		informeIS2.setUtilizacionBeca(utilizacionBeca);
		informeIS2.setFechaPBE(becado.getFechaPBE());
		informeIS2.setEaPerfil(becado.getEa());
		informeIS2.setRrPerfil(becado.getEa().getRr());
		informeIS2.setIncluirBoletinCheck(incluirBoletinCheck);
		if (StringUtils.isNotBlank(suspensiones))
			informeIS2.setSuspensionesBeca(suspensiones);

		Boletin boletin = srvInforme.getBoletinCicloInforme(becado,
				informeIS2.getCicloActual());
		if (boletin == null) {
			informeIS2.setMateriasAprobadas(materiasAprobadas);
			informeIS2.setMateriasDesaprobadas(materiasDesaprobadas);
			informeIS2.setInasistencias(inasistencias);
			informeIS2.setObsBoletin(obsBoletin);
		}

		informeIS2.setFechaUltimaModificacion(new Date());
		informeIS2.setEstado(EstadoInforme.SUPERVISOR);
		informeIS2.setFechaCambioUltimoEstado(new Date());
		resul.put("mensaje", "El informe fue enviado a Supervision");
		srvInformeIS2.guardarInformeIS2(informeIS2);

		if (accion.equalsIgnoreCase("informeIS2/correccionInformeIS2View.do")) {
			Persona personaLogeada = this.obtenerPersona(req);
			if (personaLogeada != null && personaLogeada.getPerfilCorrector())
				informeIS2.setCorrectora(personaLogeada.getApellido() + " "
						+ personaLogeada.getNombre());
			modelAndView = new ModelAndView(
					"redirect:/informes/listaInformesCorreccion.do", resul);
			return modelAndView;
		} else if (accion.equalsIgnoreCase("construccion")) {
			List<Informe> informes = new ArrayList<Informe>();
			if (perfilEA != null) {
				informes = srvInforme
						.obtenerInformesConstruccionPorEA(perfilEA);
				informes.addAll(srvIS1.obtenerRevisionPorEA(perfilEA));
			}
			if (StringUtils.isNotBlank(urlRegreso)) {
				resul.put("informes", informes);
				modelAndView = new ModelAndView(urlRegreso, resul);
				return modelAndView;
			} else {
				resul.put("informes", informes);
				modelAndView = new ModelAndView(
						"redirect:/informes/listaInformesConstruccion.do",
						resul);
				return modelAndView;
			}
		} else {
			resul.put("informes", srvInforme
					.obtenerInformesASupervisarYRevisar(getPerfilRR(req)));
			return forward("/informes/listaInformesRevision", resul);
		}

	}

	@RequestMapping("/informeIS2/supervisionView.do")
	public ModelAndView supervisarView(
			@RequestParam("idInformeIS2") Long idInforme) {
		Map<String, Object> resul = new HashMap<String, Object>();
		InformeIS2 informeIS2 = srvInformeIS2.obtenerInformeIS2(idInforme);
		PerfilAlumno becado = informeIS2.getBecado();
		resul.put("cicloActual", srvCiclo.obtenerCicloActual());
		resul.put("materiasAprobadas", informeIS2.getMateriasAprobadas());
		resul.put("materiasDesaprobadas", informeIS2.getMateriasDesaprobadas());
		resul.put("inasistencias", informeIS2.getInasistencias());
		resul.put("obsBoletin", informeIS2.getObsBoletin());
		resul.put("compromisoAlumno", informeIS2.getCompromisoAlumno());
		resul.put("conducta", informeIS2.getConducta());
		resul.put("esfuerzo", informeIS2.getEsfuerzo());
		resul.put("compromisoRA", informeIS2.getCompromisoRA());
		resul.put("asistenciaBecadoAEntrevistaPBE",
				informeIS2.getAsistenciaBecadoAEntrevistaPBE());
		resul.put("presentacionMaterialPBE",
				informeIS2.getPresentacionMaterialPBE());
		resul.put("compromisoAlumnoPBE", informeIS2.getCompromisoAlumnoPBE());
		resul.put("asistenciaRAEntrevistaPBE",
				informeIS2.getAsistenciaRAEntrevistaPBE());
		resul.put("compromisoRaPBE", informeIS2.getCompromisoRaPBE());
		resul.put("actividadAcompanamiento",
				informeIS2.getActividadAcompanamiento());
		resul.put("comentarios", informeIS2.getComentarios());
		resul.put("obsPersonales", informeIS2.getObsPersonales());
		resul.put("obsFamiliares", informeIS2.getObsFamiliares());
		resul.put("obsGenerales", informeIS2.getObsGenerales());
		resul.put("incluirBoletinCheck", informeIS2.getIncluirBoletinCheck());
		if (!informeIS2.getEstado().equals(EstadoInforme.ENVIADO)) {
			Integer edad = Formateador.calcularEdad(becado.getDatosPersonales()
					.getFechaNacimiento());
			informeIS2.setEdad(edad);
			srvInformeIS2.guardarInformeIS2(informeIS2);
		}
		resul.put("edad", informeIS2.getEdad());
		resul.put("observaciones", informeIS2.getObservaciones());
		resul.put("valores", EnumPBE.getEnumPBE());
		resul.put("becado", becado);
		resul.put("idInformeIS2", idInforme);
		resul.put("informe", informeIS2);
		resul.put("utilizacionBeca", informeIS2.getUtilizacionBeca());
		resul.put("suspensiones", informeIS2.getSuspensionesBeca());

		Boletin boletin = srvInforme.getBoletinCicloInforme(becado,
				informeIS2.getCicloActual());
		if (boletin != null) {
			resul.put("boletin", boletin);
			resul.put("materias", boletin.getMaterias());
			resul.put("primero", boletin.getTrimestres().get(0));
			resul.put("segundo", boletin.getTrimestres().get(1));
			resul.put("tercero", boletin.getTrimestres().get(2));
		}

		return forward("/informeIS2/supervisarInformeIS2", resul);
	}

	@RequestMapping("/informeIS2/supervisionGuardar.do")
	public ModelAndView supervisarInformeIS2Guardar(
			HttpServletRequest req,
			@RequestParam("idInformeIS2") Long idInforme,
			@RequestParam(required = false, value = "materiasAprobadas") Integer materiasAprobadas,
			@RequestParam(required = false, value = "materiasDesaprobadas") Integer materiasDesaprobadas,
			@RequestParam(required = false, value = "inasistencias") Float inasistencias,
			@RequestParam(required = false, value = "obsBoletin") String obsBoletin,
			@RequestParam("compromisoAlumno") Integer compromisoAlumno,
			@RequestParam("conducta") Integer conducta,
			@RequestParam("esfuerzo") Integer esfuerzo,
			@RequestParam("compromisoRA") Integer compromisoRA,
			@RequestParam("asistenciaBecadoAEntrevistaPBE") Integer asistenciaBecadoAEntrevistaPBE,
			@RequestParam("presentacionMaterialPBE") Integer presentacionMaterialPBE,
			@RequestParam("compromisoAlumnoPBE") Integer compromisoAlumnoPBE,
			@RequestParam("asistenciaRAEntrevistaPBE") Integer asistenciaRAEntrevistaPBE,
			@RequestParam("compromisoRaPBE") Integer compromisoRaPBE,
			@RequestParam("actividadAcompanamiento") String actividadAcompanamiento,
			@RequestParam("comentarios") String comentarios,
			@RequestParam("obsPersonales") String obsPersonales,
			@RequestParam("obsFamiliares") String obsFamiliares,
			@RequestParam("obsGenerales") String obsGenerales,
			@RequestParam("edad") Integer edad,
			@RequestParam("utilizacionBeca") String utilizacionBeca,
			@RequestParam(required = false, value = "incluirBoletinCheck") Boolean incluirBoletinCheck,
			@RequestParam(required = false, value = "suspensiones") String suspensiones) {
		Map<String, Object> resul = new HashMap<String, Object>();
		ModelAndView model = null;
		InformeIS2 informeIS2 = srvInformeIS2.obtenerInformeIS2(idInforme);
		PerfilAlumno becado = informeIS2.getBecado();
		guardarCamposNoSeleccionado(informeIS2, conducta, compromisoAlumno,
				esfuerzo, asistenciaBecadoAEntrevistaPBE,
				presentacionMaterialPBE, compromisoAlumnoPBE,
				asistenciaRAEntrevistaPBE, compromisoRaPBE, compromisoRA);
		informeIS2.setActividadAcompanamiento(actividadAcompanamiento);
		informeIS2.setComentarios(comentarios);
		informeIS2.setObsPersonales(obsPersonales);
		informeIS2.setObsFamiliares(obsFamiliares);
		informeIS2.setObsGenerales(obsGenerales);
		informeIS2.setIncluirBoletinCheck(incluirBoletinCheck);
		if (!informeIS2.getEstado().equals(EstadoInforme.ENVIADO)) {
			Integer edadBecado = Formateador.calcularEdad(becado
					.getDatosPersonales().getFechaNacimiento());
			informeIS2.setEdad(edadBecado);
		}
		informeIS2.setUtilizacionBeca(utilizacionBeca);
		if (StringUtils.isNotBlank(suspensiones))
			informeIS2.setSuspensionesBeca(suspensiones);

		Boletin boletin = srvInforme.getBoletinCicloInforme(becado,
				informeIS2.getCicloActual());
		if (boletin == null) {
			informeIS2.setMateriasAprobadas(materiasAprobadas);
			informeIS2.setMateriasDesaprobadas(materiasDesaprobadas);
			informeIS2.setInasistencias(inasistencias);
			informeIS2.setObsBoletin(obsBoletin);
		}

		informeIS2.setFechaUltimaModificacion(new Date());
		srvInformeIS2.guardarInformeIS2(informeIS2);
		return model = new ModelAndView(
				"redirect:/informes/listaInformesSupervision.do", resul);
	}

	@RequestMapping("/informeIS2/correccion.do")
	public ModelAndView correcion(
			HttpServletRequest req,
			@RequestParam("idInformeIS2") Long idInforme,
			@RequestParam(required = false, value = "materiasAprobadas") Integer materiasAprobadas,
			@RequestParam(required = false, value = "materiasDesaprobadas") Integer materiasDesaprobadas,
			@RequestParam(required = false, value = "inasistencias") Float inasistencias,
			@RequestParam(required = false, value = "obsBoletin") String obsBoletin,
			@RequestParam("compromisoAlumno") Integer compromisoAlumno,
			@RequestParam("conducta") Integer conducta,
			@RequestParam("esfuerzo") Integer esfuerzo,
			@RequestParam("compromisoRA") Integer compromisoRA,
			@RequestParam("asistenciaBecadoAEntrevistaPBE") Integer asistenciaBecadoAEntrevistaPBE,
			@RequestParam("presentacionMaterialPBE") Integer presentacionMaterialPBE,
			@RequestParam("compromisoAlumnoPBE") Integer compromisoAlumnoPBE,
			@RequestParam("asistenciaRAEntrevistaPBE") Integer asistenciaRAEntrevistaPBE,
			@RequestParam("compromisoRaPBE") Integer compromisoRaPBE,
			@RequestParam("actividadAcompanamiento") String actividadAcompanamiento,
			@RequestParam("comentarios") String comentarios,
			@RequestParam("obsPersonales") String obsPersonales,
			@RequestParam("obsFamiliares") String obsFamiliares,
			@RequestParam("obsGenerales") String obsGenerales,
			@RequestParam("edad") Integer edad,
			@RequestParam("utilizacionBeca") String utilizacionBeca,
			@RequestParam(required = false, value = "incluirBoletinCheck") Boolean incluirBoletinCheck,
			@RequestParam(required = false, value = "suspensiones") String suspensiones) {
		Map<String, Object> resul = new HashMap<String, Object>();
		ModelAndView modelAndView = null;
		InformeIS2 informeIS2 = srvInformeIS2.obtenerInformeIS2(idInforme);
		PerfilAlumno becado = informeIS2.getBecado();
		guardarCamposNoSeleccionado(informeIS2, conducta, compromisoAlumno,
				esfuerzo, asistenciaBecadoAEntrevistaPBE,
				presentacionMaterialPBE, compromisoAlumnoPBE,
				asistenciaRAEntrevistaPBE, compromisoRaPBE, compromisoRA);
		informeIS2.setActividadAcompanamiento(actividadAcompanamiento);
		informeIS2.setComentarios(comentarios);
		informeIS2.setObsPersonales(obsPersonales);
		informeIS2.setObsFamiliares(obsFamiliares);
		informeIS2.setObsGenerales(obsGenerales);
		informeIS2.setIncluirBoletinCheck(incluirBoletinCheck);
		if (!informeIS2.getEstado().equals(EstadoInforme.ENVIADO)) {
			Integer edadBecado = Formateador.calcularEdad(becado
					.getDatosPersonales().getFechaNacimiento());
			informeIS2.setEdad(edadBecado);
		}
		informeIS2.setUtilizacionBeca(utilizacionBeca);
		if (StringUtils.isNotBlank(suspensiones))
			informeIS2.setSuspensionesBeca(suspensiones);

		Boletin boletin = srvInforme.getBoletinCicloInforme(becado,
				informeIS2.getCicloActual());
		if (boletin == null) {
			informeIS2.setMateriasAprobadas(materiasAprobadas);
			informeIS2.setMateriasDesaprobadas(materiasDesaprobadas);
			informeIS2.setInasistencias(inasistencias);
			informeIS2.setObsBoletin(obsBoletin);
		}

		if ((informeIS2.getEstado().equals(EstadoInforme.SUPERVISOR))) {
			informeIS2.setEstado(EstadoInforme.CORRECTORA);
			informeIS2.setFechaCambioUltimoEstado(new Date());
			informeIS2.setFechaUltimaModificacion(new Date());
			Persona personaLogeada = this.obtenerPersona(req);
			if (personaLogeada != null && personaLogeada.getPerfilCorrector())
				informeIS2.setCorrectora(personaLogeada.getApellido() + " "
						+ personaLogeada.getNombre());
			srvInformeIS2.guardarInformeIS2(informeIS2);
			modelAndView = new ModelAndView(
					"redirect:/informes/listaInformesSupervision.do", resul);
			return modelAndView;

		} else {
			informeIS2.setFechaUltimaModificacion(new Date());
			Persona personaLogeada = this.obtenerPersona(req);
			if (personaLogeada != null && personaLogeada.getPerfilCorrector())
				informeIS2.setCorrectora(personaLogeada.getApellido() + " "
						+ personaLogeada.getNombre());
			srvInformeIS2.guardarInformeIS2(informeIS2);
			modelAndView = new ModelAndView(
					"redirect:/informes/listaInformesCorreccion.do", resul);
			return modelAndView;

		}

	}

	@RequestMapping("/informeIS2/correccionInformeIS2View.do")
	public ModelAndView correcionInformeIS2View(
			@RequestParam("idInformeIS2") Long idInforme) {
		Map<String, Object> resul = cargarDatosCorreccion(idInforme);
		return forward("/informeIS2/correccionIS2", resul);
	}

	private Map<String, Object> cargarDatosCorreccion(Long idInforme) {

		Map<String, Object> resul = new HashMap<String, Object>();
		InformeIS2 informeIS2 = srvInformeIS2.obtenerInformeIS2(idInforme);
		PerfilAlumno becado = informeIS2.getBecado();
		Periodo periodoFechaPBE = srvPeriodo
				.obtenerPeriodoPorFechaFP(informeIS2.getFechaPBE());
		Escuela escuela = srvEscuela.obtenerEscuelaPorId(informeIS2.getBecado()
				.getEscuela().getId());
		String modalidadTrabajoEscuela = new String();
		File file = new File(getProps().getProperty(
				ConstantesInformes.pathImagen)
				+ informeIS2.getBecado().getDatosPersonales().getDni()
						.toString() + ConstantesInformes.extensionImagen);
		if (file.exists())
			resul.put("tieneFoto", true);
		else
			resul.put("tieneFoto", false);

		if (informeIS2.getFechaPBE() != null)
			if (periodoFechaPBE != null)
				resul.put("periodoFechaPBE", periodoFechaPBE.getNombre() + " "
						+ periodoFechaPBE.getCiclo().getNombre());
			else
				resul.put("periodoFechaPBE", Formateador.formatearFechas(
						informeIS2.getFechaPBE(), "dd/MM/yyyy"));

		if (informeIS2.getFechaReincorporacionPBE() != null) { // es un chico
																// reincorporado
			Periodo periodoFechaReincorporacionPBE = srvPeriodo
					.obtenerPeriodoPorFechaFP(informeIS2
							.getFechaReincorporacionPBE());
			if (periodoFechaReincorporacionPBE != null)
				resul.put("periodoFechaReincorporacionPBE",
						periodoFechaReincorporacionPBE.getNombre()
								+ " "
								+ periodoFechaReincorporacionPBE.getCiclo()
										.getNombre());
			else
				resul.put("periodoFechaReincorporacionPBE", Formateador
						.formatearFechas(
								informeIS2.getFechaReincorporacionPBE(),
								"dd/MM/yyyy"));
		} else {
			resul.put("periodoFechaReincorporacionPBE", null);
		}

		// Boletin boletin =
		// srvInforme.getBoletinCicloInforme(informeIS2.getBecado(),
		// informeIS2.getCicloActual());
		Boletin boletin = srvInforme.getBoletinCicloInforme(becado,
				srvCiclo.obtenerCicloActual());
		List<Materia> listaMaterias = null;
		if (boletin != null) {
			listaMaterias = boletin.getMaterias();
		} else {
			listaMaterias = srvMateria.obtenerMateriasBasicas(true);
		}
		String materiasInteres = "";
		if (informeIS2.getMateriasInteres() != null
				&& !informeIS2.getMateriasInteres().equals("")) {
			List<Long> listLocalMateriasInteres = null;
			listLocalMateriasInteres = new ArrayList<Long>();
			listLocalMateriasInteres = Formateador.toListOfLongs(informeIS2
					.getMateriasInteres());
			for (Iterator iterator = listLocalMateriasInteres.iterator(); iterator
					.hasNext();) {
				Long pos = (Long) iterator.next();
				String materia = this.obtenerMateriaSeleccionada(listaMaterias,
						pos);
				if (materiasInteres.equals(""))
					materiasInteres += materia;
				else
					materiasInteres += ", " + materia;
			}
		}
		String materiasCuestan = "";
		if (informeIS2.getMateriasCuestan() != null
				&& !informeIS2.getMateriasCuestan().equals("")) {
			List<Long> listLocalMateriasCuestan = null;
			listLocalMateriasCuestan = new ArrayList<Long>();
			listLocalMateriasCuestan = Formateador.toListOfLongs(informeIS2
					.getMateriasCuestan());
			for (Iterator iterator = listLocalMateriasCuestan.iterator(); iterator
					.hasNext();) {
				Long pos = (Long) iterator.next();
				String materia = this.obtenerMateriaSeleccionada(listaMaterias,
						pos);
				if (materiasCuestan.equals(""))
					materiasCuestan += materia;
				else
					materiasCuestan += ", " + materia;
			}
		}

		boletin = srvInforme.getBoletinCicloInforme(becado,
				informeIS2.getCicloActual());
		if (boletin != null) {
			resul.put("boletin", boletin);
			resul.put("listMateriasInteres", boletin.getMaterias());
			resul.put("listMateriasCuestan", boletin.getMaterias());
			resul.put("primero", boletin.getTrimestres().get(0));
			resul.put("segundo", boletin.getTrimestres().get(1));
			resul.put("tercero", boletin.getTrimestres().get(2));
		} else {
			List<Materia> materiasTroncales = srvMateria
					.obtenerMateriasBasicas(true);
			resul.put("listMateriasInteres", materiasTroncales);
			resul.put("listMateriasCuestan", materiasTroncales);
		}

		resul.put("informe", informeIS2);
		resul.put("cantMateriasDesaprobadas",
				informeIS2.getMateriasDesaprobadas());
		resul.put("cantInasistencias", informeIS2.getInasistencias());
		resul.put("mensajePadrino", informeIS2.getMensajePadrino());
		resul.put("actividadAcompanamiento",
				informeIS2.getActividadAcompanamiento());
		resul.put("materiasInteres", materiasInteres);
		resul.put("materiasCuestan", materiasCuestan);
		resul.put("qtam", informeIS2.getQtam());
		resul.put("osme", informeIS2.getOsme());
		resul.put("hsTrabajarA�o", informeIS2.getHsTrabajarA�o());
		resul.put("sarpepe", informeIS2.getSarpepe());
		resul.put("propositoAnual", informeIS2.getPropositoAnual());
		resul.put("iamp", informeIS2.getIamp());

		resul.put("tarang", informeIS2.getTarang());
		resul.put("paa", informeIS2.getPaa());
		resul.put("vtepa", informeIS2.getVtepa());
		resul.put("vtepb", informeIS2.getVtepb());
		resul.put("vtepc", informeIS2.getVtepc());
		resul.put("vtepd", informeIS2.getVtepd());
		resul.put("vtepe", informeIS2.getVtepe());
		resul.put("vtepf", informeIS2.getVtepf());
		resul.put("vtepg", informeIS2.getVtepg());
		resul.put("vteph", informeIS2.getVteph());
		resul.put("vtepi", informeIS2.getVtepi());
		resul.put("iatarni", informeIS2.getIatarni());
		resul.put("mp", informeIS2.getMp());
		resul.put("sus", informeIS2.getSus());
		resul.put("ige", informeIS2.getIge());

		// resul.put("boletin", informeIS2.getBoletinActual());
		resul.put("incluirBoletinCheck", informeIS2.getIncluirBoletinCheck());
		if (!informeIS2.getEstado().equals(EstadoInforme.ENVIADO)) {
			Integer edad = Formateador.calcularEdad(becado.getDatosPersonales()
					.getFechaNacimiento());
			informeIS2.setEdad(edad);
			srvInformeIS2.guardarInformeIS2(informeIS2);
		}
		resul.put("edad", informeIS2.getEdad());
		resul.put("becado", informeIS2.getBecado());
		resul.put("escuela", escuela);
		if (escuela.getModalidadTrabajoEscuela() != null)
			modalidadTrabajoEscuela = escuela.getModalidadTrabajoEscuela()
					.getValor();
		resul.put("modalidadTrabajoEscuela", modalidadTrabajoEscuela);

		resul.put("cantidadBecadosCimiento",
				srvAlumno.cantidadAlumnosActivosMismaEscuela(escuela));

		return resul;

	}

	@RequestMapping("/informeIS2/correccionGuardar.do")
	public ModelAndView correccionIS2Guardar(HttpServletRequest req,
			@RequestParam("idInformeIS2") Long idInforme,
			@RequestParam("observaciones") String observaciones)

	{
		Map<String, Object> resul = new HashMap<String, Object>();
		ModelAndView modelAndView = null;
		InformeIS2 informeIS2 = srvInformeIS2.obtenerInformeIS2(idInforme);
		PerfilAlumno becado = informeIS2.getBecado();
		if (!informeIS2.getEstado().equals(EstadoInforme.ENVIADO)) {
			Integer edad = Formateador.calcularEdad(becado.getDatosPersonales()
					.getFechaNacimiento());
			informeIS2.setEdad(edad);
		}

		informeIS2.setObservaciones(observaciones);
		srvInformeIS2.guardarInformeIS2(informeIS2);

		Persona personaLogeada = this.obtenerPersona(req);
		if (personaLogeada != null && personaLogeada.getPerfilCorrector())
			informeIS2.setCorrectora(personaLogeada.getApellido() + " "
					+ personaLogeada.getNombre());
		informeIS2.setFechaUltimaModificacion(new Date());
		resul.put("mensaje", "El informe fue guardado");
		modelAndView = new ModelAndView(
				"redirect:/informes/listaInformesCorreccion.do", resul);
		return modelAndView;

	}

	@RequestMapping("/informeIS2/revisar.do")
	public ModelAndView revisar(@RequestParam("idInformeIS2") Long idInforme,
			@RequestParam("observaciones") String observaciones) {
		Map<String, Object> resul = new HashMap<String, Object>();
		ModelAndView modelAndView = null;
		InformeIS2 informeIS2 = srvInformeIS2.obtenerInformeIS2(idInforme);
		if (!informeIS2.getEstado().equals(EstadoInforme.ENVIADO)) {
			Integer edad = Formateador.calcularEdad(informeIS2.getBecado()
					.getDatosPersonales().getFechaNacimiento());
			informeIS2.setEdad(edad);
		}
		informeIS2.setObservaciones(observaciones);
		informeIS2.setEstado(EstadoInforme.REVISION);
		informeIS2.setFechaUltimaModificacion(new Date());
		srvInformeIS2.guardarInformeIS2(informeIS2);

		resul.put("mensaje", "El informe fue enviado a revision");
		modelAndView = new ModelAndView(
				"redirect:/informes/listaInformesCorreccion.do", resul);
		return modelAndView;
	}

	@RequestMapping("/informeIS2/finalizar.do")
	public ModelAndView finalizar(
			HttpServletRequest req,
			@RequestParam(required = false, value = "idInformeIS2") Long idInforme,
			@RequestParam(required = false, value = "accion") String accion,
			@RequestParam("cantMateriasDesaprobadas") Integer cantMateriasDesaprobadas,
			@RequestParam("cantInasistencias") Float cantInasistencias,
			@RequestParam("mensajePadrino") String mensajePadrino,
			@RequestParam("actividadAcompanamiento") String actividadAcompanamiento,
			@RequestParam("materiasInteres") String materiasInteres,
			@RequestParam("materiasCuestan") String materiasCuestan,
			@RequestParam("qtam") String qtam,
			@RequestParam("osme") String osme,
			@RequestParam(required = false, value ="sarpepe") String sarpepe,
			@RequestParam("hsTrabajarA�o") String hsTrabajarAnio,
			@RequestParam("idAlumno") Long idAlumno,
			@RequestParam("edad") Integer edad,
			@RequestParam("propositoAnual") String propositoAnual,
			@RequestParam("iamp") String iamp,
			@RequestParam("tarang") String tarang,
			@RequestParam("paa") String paa,
			@RequestParam("vtepa") String vtepa,
			@RequestParam("vtepb") String vtepb,
			@RequestParam("vtepc") String vtepc,
			@RequestParam("vtepd") String vtepd,
			@RequestParam("vtepe") String vtepe,
			@RequestParam("vtepf") String vtepf,
			@RequestParam("vtepg") String vtepg,
			@RequestParam("vteph") String vteph,
			@RequestParam("vtepi") String vtepi,
			@RequestParam("iatarni") String iatarni,
			@RequestParam("mp") String mp,
			@RequestParam("sus") String sus,
			@RequestParam("ige") String ige,
			@RequestParam(required = false, value = "incluirBoletinCheck") Boolean incluirBoletinCheck,
			@RequestParam(required = false, value = "urlRegreso") String urlRegreso) {

		Map<String, Object> resul = new HashMap<String, Object>();
		ModelAndView modelAndView = null;
		InformeIS2 informeIS2 = srvInformeIS2.obtenerInformeIS2(idInforme);
		PerfilAlumno becado = informeIS2.getBecado();
		if (!informeIS2.getEstado().equals(EstadoInforme.ENVIADO)) {
			Integer edadBecado = Formateador.calcularEdad(becado
					.getDatosPersonales().getFechaNacimiento());
			informeIS2.setEdad(edadBecado);
		}
		// guardarCamposNoSeleccionado(informeIS2, conducta, compromisoAlumno,
		// esfuerzo, asistenciaBecadoAEntrevistaPBE, presentacionMaterialPBE,
		// compromisoAlumnoPBE, asistenciaRAEntrevistaPBE, compromisoRaPBE,
		// compromisoRA);
		informeIS2.setActividadAcompanamiento(actividadAcompanamiento);
		informeIS2.setMensajePadrino(mensajePadrino);
		// informeIS2.setCicloActual(srvCiclo.obtenerCicloActual());
		informeIS2.setEaPerfil(becado.getEa());
		informeIS2.setRrPerfil(becado.getEa().getRr());
		informeIS2.setFechaPBE(becado.getFechaPBE());
		informeIS2.setFechaReincorporacionPBE(becado
				.getFechaReincorporacionPBE());
		informeIS2.setFechaUltimaModificacion(new Date());
		informeIS2.setPadrino(becado.getBeca().getPadrino());
		informeIS2.setBeca(becado.getBeca());
		informeIS2.setBecado(becado);
		informeIS2.setIncluirBoletinCheck(incluirBoletinCheck);
		Integer edadBecado = Formateador.calcularEdad(becado
				.getDatosPersonales().getFechaNacimiento());
		informeIS2.setEdad(edadBecado);
		informeIS2.setFechaCambioUltimoEstado(new Date());
		informeIS2.setCantidadBecados(srvAlumno
				.cantidadAlumnosActivosMismaEscuela(becado.getEscuela()));
		informeIS2.setMateriasDesaprobadas(cantMateriasDesaprobadas);
		informeIS2.setInasistencias(cantInasistencias);
		informeIS2.setMateriasCuestan(materiasCuestan);
		informeIS2.setMateriasInteres(materiasInteres);
		informeIS2.setQtam(qtam);
		informeIS2.setOsme(osme);
		informeIS2.setHsTrabajarA�o(hsTrabajarAnio);
		informeIS2.setSarpepe(sarpepe);
		informeIS2.setPropositoAnual(propositoAnual);
		informeIS2.setIamp(iamp);
		informeIS2.setTarang(tarang);
		informeIS2.setPaa(paa);
		informeIS2.setVtepa(vtepa);
		informeIS2.setVtepb(vtepb);
		informeIS2.setVtepc(vtepc);
		informeIS2.setVtepd(vtepd);
		informeIS2.setVtepe(vtepe);
		informeIS2.setVtepf(vtepf);
		informeIS2.setVtepg(vtepg);
		informeIS2.setVteph(vteph);
		informeIS2.setVtepi(vtepi);
		informeIS2.setIatarni(iatarni);
		informeIS2.setMp(mp);
		informeIS2.setSus(sus);
		informeIS2.setIge(ige);
		informeIS2.setEstado(EstadoInforme.FINALIZADO);

		srvInformeIS2.guardarInformeIS2(informeIS2);
		resul.put("mensaje", "El Informe de Seguimiento N�2 del becado "
				+ becado.getDatosPersonales().getApellidoNombre()
				+ " ha sido Finalizado");
		if (StringUtils.isNotBlank(urlRegreso)) {
			// model = new ModelAndView(urlRegreso, resul);
			return new ModelAndView("redirect:" + urlRegreso, resul);
		} else
			return new ModelAndView(
					"redirect:/informes/listaInformesConstruccion.do", resul);
	}

	@RequestMapping("/informeIS2/revisionInformeIS2View.do")
	public ModelAndView revisionInformeIS2View(
			@RequestParam("idInformeIS2") Long idInforme) {
		Map<String, Object> resul = cargarDatosCorreccion(idInforme);

		return forward("/informeIS2/supervisarInformeIS2", resul);
	}

	@RequestMapping("/informeIS2/revisionGuardar.do")
	public ModelAndView revisionIS2Guardar(
			@RequestParam("idInformeIS2") Long idInforme,
			@RequestParam("orbservaciones") String observaciones)

	{
		Map<String, Object> resul = new HashMap<String, Object>();
		ModelAndView modelAndView = null;
		InformeIS2 informeIS2 = srvInformeIS2.obtenerInformeIS2(idInforme);
		PerfilAlumno becado = informeIS2.getBecado();

		informeIS2.setObservaciones(observaciones);
		informeIS2.setFechaUltimaModificacion(new Date());
		if (!informeIS2.getEstado().equals(EstadoInforme.ENVIADO)) {
			Integer edad = Formateador.calcularEdad(becado.getDatosPersonales()
					.getFechaNacimiento());
			informeIS2.setEdad(edad);
		}
		srvInformeIS2.guardarInformeIS2(informeIS2);
		resul.put("mensaje", "El informe fue guardado");
		modelAndView = new ModelAndView(
				"redirect:/informes/listaInformesCorreccion.do", resul);
		return modelAndView;

	}

	@RequestMapping("/informeIS2/verInformeIS2.do")
	public ModelAndView verInforme(@RequestParam("idAlumno") Long idAlumno) {

		AlumnoPanelEA alumnoPanel = alumnoPanelEaSrv
				.obtenerAlumnoPanelPorIdPerfilAlumno(idAlumno);
		InformeIS2 informe = srvInformeIS2.obtenerInformePorAlumno(
				alumnoPanel.getIdPerfilAlumno(), srvCiclo.obtenerCicloActual());
		
		String materiasPendientes="";
		Connection cn0 = null;
		try {  
            String query="select materia,anio_escolar from previas_nuevo p where ja<>'Aprobado' and di<>'Aprobado' and fb<>'Aprobado' and ma<>'Aprobado' and mam<>'Aprobado' and idbecado="+idAlumno;
            cn0 = Conexion.getConexion();
            Statement st = cn0.createStatement();
            ResultSet rs0 = st.executeQuery(query);        
		    
            while (rs0.next()) {	                    
            	materiasPendientes=materiasPendientes+rs0.getString("materia")+" - "+rs0.getString("anio_escolar")+", ";
	            
            }
           //entrevistaIndividual.setMp(materiasPendientes);
           informe.setMp(materiasPendientes);
           
           st.close();
           
            
	        Conexion.cerrarConexion(cn0);
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
	        Conexion.cerrarConexion(cn0);
		}
		
		

		if (informe.getEstado().equals(EstadoInforme.CONSTRUCCION)) {
			String urlRegreso = "/entrevistas/listarBecados.do";
			return modificarView(informe.getId(), urlRegreso, null, null);
		} else {
			Map<String, Object> resul = cargarDatosCorreccion(informe.getId());
			return forward("/informeIS2/verIS2", resul);
		}
	}

	@RequestMapping("/informeIS2/verInformeIS2General.do")
	public ModelAndView verInformeIS2(
			@RequestParam("idInformeIS2") Long idInforme) {

		InformeIS2 informe = srvInformeIS2.obtenerInformeIS2(idInforme);
		Map<String, Object> resul = new HashMap<String, Object>();// cargarDatosCorreccion(informe.getId());
		Periodo periodoFechaPBE = srvPeriodo.obtenerPeriodoPorFechaFP(informe
				.getFechaPBE());
		Escuela escuela = srvEscuela.obtenerEscuelaPorId(informe.getBecado()
				.getEscuela().getId());
		String modalidadTrabajoEscuela = new String();

		File file = new File(getProps().getProperty(
				ConstantesInformes.pathImagen)
				+ informe.getBecado().getDatosPersonales().getDni().toString()
				+ ConstantesInformes.extensionImagen);
		if (file.exists())
			resul.put("tieneFoto", true);
		else
			resul.put("tieneFoto", false);

		if (informe.getFechaPBE() != null)
			if (periodoFechaPBE != null)
				resul.put("periodoFechaPBE", periodoFechaPBE.getNombre() + " "
						+ periodoFechaPBE.getCiclo().getNombre());
			else
				resul.put("periodoFechaPBE", Formateador.formatearFechas(
						informe.getFechaPBE(), "dd/MM/yyyy"));

		if (informe.getFechaReincorporacionPBE() != null) { // es un chico
															// reincorporado
			Periodo periodoFechaReincorporacionPBE = srvPeriodo
					.obtenerPeriodoPorFechaFP(informe
							.getFechaReincorporacionPBE());
			if (periodoFechaReincorporacionPBE != null)
				resul.put("periodoFechaReincorporacionPBE",
						periodoFechaReincorporacionPBE.getNombre()
								+ " "
								+ periodoFechaReincorporacionPBE.getCiclo()
										.getNombre());
			else
				resul.put("periodoFechaReincorporacionPBE", Formateador
						.formatearFechas(informe.getFechaReincorporacionPBE(),
								"dd/MM/yyyy"));
		} else {
			resul.put("periodoFechaReincorporacionPBE", null);
		}

		Boletin boletin = srvInforme.getBoletinCicloInforme(
				informe.getBecado(), informe.getCicloActual());
		List<Materia> listaMaterias = null;
		if (boletin != null) {
			listaMaterias = boletin.getMaterias();
		} else {
			listaMaterias = srvMateria.obtenerMateriasBasicas(true);
		}
		String materiasInteres = "";
		if (informe.getMateriasInteres() != null
				&& !informe.getMateriasInteres().equals("")) {
			List<Long> listLocalMateriasInteres = null;
			listLocalMateriasInteres = new ArrayList<Long>();
			listLocalMateriasInteres = Formateador.toListOfLongs(informe
					.getMateriasInteres());
			for (Iterator iterator = listLocalMateriasInteres.iterator(); iterator
					.hasNext();) {
				Long pos = (Long) iterator.next();
				String materia = this.obtenerMateriaSeleccionada(listaMaterias,
						pos);
				if (materiasInteres.equals(""))
					materiasInteres += materia;
				else
					materiasInteres += ", " + materia;
			}
		}
		String materiasCuestan = "";
		if (informe.getMateriasCuestan() != null
				&& !informe.getMateriasCuestan().equals("")) {
			List<Long> listLocalMateriasCuestan = null;
			listLocalMateriasCuestan = new ArrayList<Long>();
			listLocalMateriasCuestan = Formateador.toListOfLongs(informe
					.getMateriasCuestan());
			for (Iterator iterator = listLocalMateriasCuestan.iterator(); iterator
					.hasNext();) {
				Long pos = (Long) iterator.next();
				String materia = this.obtenerMateriaSeleccionada(listaMaterias,
						pos);
				if (materiasCuestan.equals(""))
					materiasCuestan += materia;
				else
					materiasCuestan += ", " + materia;
			}
		}

		boletin = srvInforme.getBoletinCicloInforme(informe.getBecado(),
				informe.getCicloActual());
		if (boletin != null) {
			resul.put("boletin", boletin);
			resul.put("listMateriasInteres", boletin.getMaterias());
			resul.put("listMateriasCuestan", boletin.getMaterias());
			resul.put("primero", boletin.getTrimestres().get(0));
			resul.put("segundo", boletin.getTrimestres().get(1));
			resul.put("tercero", boletin.getTrimestres().get(2));
		} else {
			List<Materia> materiasTroncales = srvMateria
					.obtenerMateriasBasicas(true);
			resul.put("listMateriasInteres", materiasTroncales);
			resul.put("listMateriasCuestan", materiasTroncales);
		}

		resul.put("informe", informe);
		resul.put("cantMateriasDesaprobadas", informe.getMateriasDesaprobadas());
		resul.put("cantInasistencias", informe.getInasistencias());
		resul.put("mensajePadrino", informe.getMensajePadrino());
		resul.put("actividadAcompanamiento",
				informe.getActividadAcompanamiento());
		resul.put("materiasInteres", materiasInteres);
		resul.put("materiasCuestan", materiasCuestan);
		resul.put("edad", informe.getEdad());
		resul.put("becado", informe.getBecado());
		resul.put("escuela", escuela);
		resul.put("qtam", informe.getQtam());
		resul.put("propositoAnual", informe.getPropositoAnual());
		resul.put("iamp", informe.getIamp());
		resul.put("osme", informe.getOsme());
		resul.put("incluirBoletinCheck", informe.getIncluirBoletinCheck());
		resul.put("hsTrabajarA�o", informe.getHsTrabajarA�o());

		resul.put("tarang", informe.getTarang());
		resul.put("paa", informe.getPaa());
		resul.put("vtepa", informe.getVtepa());
		resul.put("vtepb", informe.getVtepb());
		resul.put("vtepc", informe.getVtepc());
		resul.put("vtepd", informe.getVtepd());
		resul.put("vtepe", informe.getVtepe());
		resul.put("vtepf", informe.getVtepf());
		resul.put("vtepg", informe.getVtepg());
		resul.put("vteph", informe.getVteph());
		resul.put("vtepi", informe.getVtepi());
		resul.put("iatarni", informe.getIatarni());
		resul.put("mp", informe.getMp());
		resul.put("sus", informe.getSus());
		resul.put("ige", informe.getIge());

		if (escuela.getModalidadTrabajoEscuela() != null)
			modalidadTrabajoEscuela = escuela.getModalidadTrabajoEscuela()
					.getValor();
		resul.put("modalidadTrabajoEscuela", modalidadTrabajoEscuela);

		resul.put("cantidadBecadosCimiento",
				srvAlumno.cantidadAlumnosActivosMismaEscuela(escuela));

		return forward("/informeIS2/verIS2", resul);

	}

	@RequestMapping("/informeIS2/verDetalleIS2.do")
	public ModelAndView verDetalleInforme(
			@RequestParam("idAlumno") Long idAlumno) {

		AlumnoPanelEA alumnoPanel = alumnoPanelEaSrv
				.obtenerAlumnoPanelPorIdPerfilAlumno(idAlumno);
		InformeIS2 informe = srvInformeIS2.obtenerInformePorAlumno(
				alumnoPanel.getIdPerfilAlumno(), srvCiclo.obtenerCicloActual());

		Map<String, Object> resul = cargarDatosCorreccion(informe.getId());
		return forward("/informeIS2/verIS2", resul);

	}

	@RequestMapping("/informeIS2/eliminarIS2.do")
	public ModelAndView eliminarIS2(@RequestParam("idIS2") Long idIS2,
			@RequestParam("urlRegreso") String urlRegreso) {
		ModelAndView modelAndView = new ModelAndView(
				"redirect:/reporteGeneralInformes/verReporteGeneralInformes.do");
		String mensaje = "";
		String error = "";
		InformeIS2 informeIS2 = srvInformeIS2.obtenerInformeIS2(idIS2);
		if (!informeIS2.getEstado().equals(EstadoInforme.ENVIADO)) {
			CicloPrograma cicloActual = srvCiclo.obtenerCicloActual();
			boolean infoCicloActual = true;
			if (!cicloActual.equals(informeIS2.getCicloActual())) {
				infoCicloActual = false;
			}
			if (infoCicloActual) {
				srvInformeIS2.eliminarInformeIS2(informeIS2);
				AlumnoPanelEA ape = alumnoPanelEaSrv
						.obtenerAlumnoPanelPorIdPerfilAlumno(informeIS2
								.getBecado().getId());
				if (ape != null) {
					ape.setColorIS2(ConstantesPaneles.RED);
					alumnoPanelEaSrv.modificarAlumnoPanelEA(ape);
				}
			} else {
				srvInformeIS2.eliminarInformeIS2(informeIS2);
			}
			mensaje = "El Informe de Seguimiento N�2 del becado "
					+ informeIS2.getBecado().getDatosPersonales()
							.getApellidoNombre() + " ha sido eliminado";
		} else
			error = "El Informe de Seguimiento N�2 del becado "
					+ informeIS2.getBecado().getDatosPersonales()
							.getApellidoNombre()
					+ " no se puede eliminar porque el mismo ya ha sido enviada al padrino";

		if (StringUtils.isNotBlank(mensaje))
			modelAndView = new ModelAndView("redirect:" + urlRegreso
					+ "?mensaje=" + mensaje);
		if (StringUtils.isNotBlank(error))
			modelAndView = new ModelAndView("redirect:" + urlRegreso
					+ "?error=" + error);

		return modelAndView;
	}

	private String generarDetalleSuspensiones(
			List<EntrevistaIndividual> entrevistasPagoSuspendido) {
		StringBuffer informacionSuspension = new StringBuffer("");
		if (entrevistasPagoSuspendido != null
				&& !entrevistasPagoSuspendido.isEmpty()) {
			informacionSuspension.append("Cantidad: "
					+ entrevistasPagoSuspendido.size());
			informacionSuspension.append(System.getProperty("line.separator"));
			for (EntrevistaIndividual entrevistaIndividual : entrevistasPagoSuspendido) {
				informacionSuspension.append("Mes: "
						+ entrevistaIndividual.getPeriodoDePago().getNombre());
				informacionSuspension
						.append(", Motivo: "
								+ entrevistaIndividual.getMotivoSuspension()
										.getValor());
				informacionSuspension.append(System
						.getProperty("line.separator"));
			}
		}
		return informacionSuspension.toString();
	}

	private void guardarCamposNoSeleccionado(InformeIS2 informeIS2,
			Integer conducta, Integer compromisoAlumno, Integer esfuerzo,
			Integer asistenciaBecadoAEntrevistaPBE,
			Integer presentacionMaterialPBE, Integer compromisoAlumnoPBE,
			Integer asistenciaRAEntrevistaPBE, Integer compromisoRaPBE,
			Integer compromisoRA) {

		if (conducta == null)
			informeIS2.setConducta(null);
		else
			informeIS2.setConducta(EnumPBE.getEnumPBE(conducta));

		if (compromisoAlumno == null)
			informeIS2.setCompromisoAlumno(null);
		else
			informeIS2
					.setCompromisoAlumno(EnumPBE.getEnumPBE(compromisoAlumno));

		if (esfuerzo == null)
			informeIS2.setEsfuerzo(null);
		else
			informeIS2.setEsfuerzo(EnumPBE.getEnumPBE(esfuerzo));

		if (asistenciaBecadoAEntrevistaPBE == null)
			informeIS2.setAsistenciaBecadoAEntrevistaPBE(null);
		else
			informeIS2.setAsistenciaBecadoAEntrevistaPBE(EnumPBE
					.getEnumPBE(asistenciaBecadoAEntrevistaPBE));

		if (presentacionMaterialPBE == null)
			informeIS2.setPresentacionMaterialPBE(null);
		else
			informeIS2.setPresentacionMaterialPBE(EnumPBE
					.getEnumPBE(presentacionMaterialPBE));

		if (compromisoAlumnoPBE == null)
			informeIS2.setCompromisoAlumnoPBE(null);
		else
			informeIS2.setCompromisoAlumnoPBE(EnumPBE
					.getEnumPBE(compromisoAlumnoPBE));

		if (asistenciaRAEntrevistaPBE == null)
			informeIS2.setAsistenciaRAEntrevistaPBE(null);
		else
			informeIS2.setAsistenciaRAEntrevistaPBE(EnumPBE
					.getEnumPBE(asistenciaRAEntrevistaPBE));

		if (compromisoRaPBE == null)
			informeIS2.setCompromisoRaPBE(null);
		else
			informeIS2.setCompromisoRaPBE(EnumPBE.getEnumPBE(compromisoRaPBE));

		if (compromisoRA == null)
			informeIS2.setCompromisoRA(null);
		else
			informeIS2.setCompromisoRA(EnumPBE.getEnumPBE(compromisoRA));

		srvInformeIS2.guardarInformeIS2(informeIS2);
	}

	@InitBinder
	public void initBinder(HttpServletRequest request, WebDataBinder binder) {

		// custom date binding
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(
				dateFormat, true));

	}

	private String obtenerMateriaSeleccionada(List<Materia> listaMaterias,
			Long pos) {
		int i = 0;
		String materia = "";
		boolean encontro = false;
		while (i < listaMaterias.size() && !encontro) {
			if (listaMaterias.get(i).getId().equals(pos)) {
				materia = listaMaterias.get(i).getNombre();
				encontro = true;
			}
			i++;
		}
		return materia;
	}
}
