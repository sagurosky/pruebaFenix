package org.cimientos.intranet.web.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.cimientos.intranet.modelo.escuela.Escuela;
import org.cimientos.intranet.modelo.evento.eventoGenerico.AsistenciaEventoGenerico;
import org.cimientos.intranet.modelo.evento.eventoGenerico.EvaluacionEncuentro;
import org.cimientos.intranet.modelo.evento.eventoGenerico.EventoGenerico;
import org.cimientos.intranet.modelo.evento.eventoGenerico.TipoEventoGenerico;
import org.cimientos.intranet.modelo.perfil.PerfilAlumno;
import org.cimientos.intranet.modelo.perfilEA.PerfilEA;
import org.cimientos.intranet.modelo.perfilRR.PerfilRR;
import org.cimientos.intranet.servicio.AlumnoSrv;
import org.cimientos.intranet.servicio.EventoGenericoSrv;
import org.cimientos.intranet.servicio.PerfilEASrv;
import org.cimientos.intranet.servicio.PersonaSrv;
import org.cimientos.intranet.servicio.RegistrarEscuelasBecasSrv;
import org.cimientos.intranet.servicio.ResponsableSrv;
import org.cimientos.intranet.utils.Formateador;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cimientos.intranet.enumerativos.entrevista.ContenidosAbordados;

/**
 * @author plabaronnie
 * 
 */
@Controller
@RequestMapping("/eventoGenerico/*")
public class EventoGenericoController extends BaseController {

	@Autowired
	private EventoGenericoSrv eventoGenericoSrv;

	@Autowired
	private PerfilEASrv perfilEASrv;

	@Autowired
	public RegistrarEscuelasBecasSrv escuelaSvr;

	@Autowired
	public AlumnoSrv alumnoSvr;

	@Autowired
	public PersonaSrv srvPersona;
	
	@Autowired
	public ResponsableSrv srvResponsable;

	/**
	 * @param idEa
	 * @return
	 */
	@RequestMapping("/eventoGenerico/altaEventoGenericoView.do")
	public ModelAndView agregarEventoGenerico(
			@RequestParam("idEa") Long idEa) {
		Map<String, Object> resul = new HashMap<String, Object>();
		EventoGenerico eventoGenerico = new EventoGenerico();
		eventoGenerico.setFechaCarga(new Date());
		if(idEa!=null){
			PerfilEA ea = perfilEASrv.obtenerPerfilEA(idEa);
			List<PerfilAlumno> becadosEa = obtenerBecadosCicloActual(ea);
			eventoGenerico.setPagaEntrevista(true);
			eventoGenerico.setConvocados(this.cargarAsistencias(becadosEa));
			eventoGenerico.setEa(ea);
		
		}
		

		
		
		resul.put("evento", eventoGenerico);
		resul.put("tiposEvento", TipoEventoGenerico.getListaTipos());
		resul.put("tiposContenido", ContenidosAbordados.values());
		resul.put("evaluaciones", EvaluacionEncuentro.getListaTipos());

		return forward("/eventoGenerico/altaEventoGenerico", resul);
	}
	
	/**
	 * @return
	 */
	@RequestMapping("/eventoGenerico/exportarEventosGenericos.do")
	public ModelAndView exportarEventos(@RequestParam("idEvento") Long idEvento) {
		Map<String, Object> resul = new HashMap<String, Object>();
		//List<EventoGenerico> eventos = new ArrayList<EventoGenerico>();
		//PerfilEA ea = this.getPerfilEA(request);
		//if (ea != null) {
			//eventos = eventoGenericoSrv.getListaEventosGenericosPorEA(ea);
			//resul.put("idEa", ea.getIdPerfilEA());
			//resul.put("idEa", ea.getIdPerfilEA());
			resul.put("idEvento", idEvento);
			////System.out.println(idEvento);
			//}
		//resul.put("eventos", eventos);
		//return forward("/eventoGenerico/listaEventosGenericos", resul);
		
		String excelView = null;
		excelView = "exportarEventoGenericoView";

		// return forward(excelView, map);
		return new ModelAndView(excelView, resul);
		
		
	}

	
	/**
	 * @return
	 */
	@RequestMapping("/eventoGenerico/exportarEventosGenericosTodos.do")
	public ModelAndView exportarEventosTodos(@RequestParam("idPerfilEA") Long idEvento) {
		Map<String, Object> resul = new HashMap<String, Object>();
		//List<EventoGenerico> eventos = new ArrayList<EventoGenerico>();
		//PerfilEA ea = this.getPerfilEA(request);
		//if (ea != null) {
			//eventos = eventoGenericoSrv.getListaEventosGenericosPorEA(ea);
			//resul.put("idEa", ea.getIdPerfilEA());
			//resul.put("idEa", ea.getIdPerfilEA());
			resul.put("idEvento", idEvento);
			////System.out.println(idEvento);
			//}
		//resul.put("eventos", eventos);
		//return forward("/eventoGenerico/listaEventosGenericos", resul);
		
		String excelView = null;
		excelView = "exportarEventoGenericoView";

		// return forward(excelView, map);
		return new ModelAndView(excelView, resul);
		
		
	}

	/**
	 * @return
	 */
	@RequestMapping("/eventoGenerico/exportarEventosGenericosTodosRR.do")
	public ModelAndView exportarEventosTodosRR(@RequestParam("idPerfilRR") Long idEvento) {
		Map<String, Object> resul = new HashMap<String, Object>();
		//List<EventoGenerico> eventos = new ArrayList<EventoGenerico>();
		//PerfilEA ea = this.getPerfilEA(request);
		//if (ea != null) {
			//eventos = eventoGenericoSrv.getListaEventosGenericosPorEA(ea);
			//resul.put("idEa", ea.getIdPerfilEA());
			//resul.put("idEa", ea.getIdPerfilEA());
			resul.put("idEvento", idEvento);
			////System.out.println(idEvento);
			//}
		//resul.put("eventos", eventos);
		//return forward("/eventoGenerico/listaEventosGenericos", resul);
		
		String excelView = null;
		excelView = "exportarEventoGenericoViewRR";

		// return forward(excelView, map);
		return new ModelAndView(excelView, resul);
		
		
	}

	/**
	 * @param ea
	 * @return
	 */
	private List<PerfilAlumno> obtenerBecadosCicloActual(PerfilEA ea) {
		return alumnoSvr.obtenerBecadosCicloActualPorEA(ea);
	}

	/**
	 * @param becados
	 * @return
	 */
	private List<AsistenciaEventoGenerico> cargarAsistencias(
			List<PerfilAlumno> becados) {
		List<AsistenciaEventoGenerico> convocados = new ArrayList<AsistenciaEventoGenerico>();
		AsistenciaEventoGenerico convocado = null;
		for (PerfilAlumno becado : becados) {
			convocado = new AsistenciaEventoGenerico();
			convocado.setBecado(becado);
			if (becado.getResponsable1() != null) {
				if(becado.getResponsable1().getApellido() != null && becado.getResponsable1().getNombre() != null){
					convocado.setResponsable1(becado.getResponsable1().getApellido()
						+ ", " + becado.getResponsable1().getNombre());
					if (becado.getResponsable1().getIdVinculo() != null)
						convocado.setVinculo1(becado.getResponsable1().getIdVinculo().getValor());
					else
						convocado.setVinculo1(" ");
				}
				else
					convocado.setResponsable1(" ");
			}
			if (becado.getResponsable2() != null) {
				if(becado.getResponsable2().getApellido() != null && becado.getResponsable2().getNombre() != null){
					convocado.setResponsable2(becado.getResponsable2().getApellido()
						+ ", " + becado.getResponsable2().getNombre());
					if (becado.getResponsable2().getIdVinculo() != null) {
						convocado.setVinculo2(becado.getResponsable2().getIdVinculo().getValor());
					} else
						convocado.setVinculo2(" ");
				}
				else
					convocado.setResponsable2(" ");
			}

			convocado.setConvocado(false);
			convocado.setAsistenciaAlumno(false);
			convocados.add(convocado);
		}
		return convocados;
	}

	/**
	 * @param eventoGenerico
	 * @return
	 * @throws ParseException
	 * @throws IOException
	 */
	@RequestMapping("/eventoGenerico/guardarEventoGenerico.do")
	public ModelAndView guardarEventoGenerico(
			@ModelAttribute("evento") EventoGenerico eventoGenerico,
			@RequestParam("becados") String becados,
			@RequestParam("responsables1") String responsables1,
			@RequestParam("vinculos1") String vinculos1,
			@RequestParam("responsables2") String responsables2,
			@RequestParam("vinculos2") String vinculos2,
			@RequestParam("chekConvocados") String chekConvocados,
			@RequestParam("chekAsistio") String chekAsistio,
			@RequestParam("obser") String obser,
			HttpServletRequest request) throws ParseException, IOException {
		Map<String, Object> resul = new HashMap<String, Object>();
		List<Long>   idsBecados = null;
		List<String> resp1Values = null;
		List<String> resp2Values = null;
		List<String> vinc1Values = null;
		List<String> vinc2Values = null;
		List<Boolean> convocadosValues = null;
		List<Boolean> asistioValues = null;
		List<String> obsValues = null;
		List<AsistenciaEventoGenerico> asistencias = eventoGenerico.getConvocados();
		if(becados != null)
		{
			idsBecados = Formateador.toListOfLongs(becados);
		}
		
		 for (int i = 0; i < idsBecados.size(); i++) 
		 {
			  PerfilAlumno alumno = alumnoSvr.obtenerAlumno(idsBecados.get(i));
			  asistencias.get(i).setBecado(alumno); 
		 }
		
		
		resp1Values = Formateador.toListOfStringValues(responsables1);
		resp2Values = Formateador.toListOfStringValues(responsables2);
		vinc1Values = Formateador.toListOfStringValues(vinculos1);
		vinc2Values = Formateador.toListOfStringValues(vinculos2);
		convocadosValues = Formateador.toListOfBoolean(chekConvocados);
		asistioValues = Formateador.toListOfBoolean(chekAsistio);
		obsValues = Formateador.toListOfStringValues(obser);
		
		for(int i = 0; i < resp1Values.size(); i++)
		{
			asistencias.get(i).setResponsable1(resp1Values.get(i));
		}
		for(int i = 0; i < resp2Values.size(); i++)
		{
			asistencias.get(i).setResponsable2(resp2Values.get(i));
		}
		for(int i = 0; i < vinc1Values.size(); i++)
		{
			asistencias.get(i).setVinculo1(vinc1Values.get(i));
		}
		for(int i = 0; i < vinc2Values.size(); i++)
		{
			asistencias.get(i).setVinculo2(vinc2Values.get(i));
		}
		for(int i = 0; i < convocadosValues.size(); i++)
		{
			asistencias.get(i).setConvocado(convocadosValues.get(i));
		}
		for(int i = 0; i < asistioValues.size(); i++)
		{
			asistencias.get(i).setAsistenciaAlumno(asistioValues.get(i));
		}
		for(int i = 0; i < obsValues.size(); i++)
		{
			asistencias.get(i).setObservaciones(obsValues.get(i));
		}

		eventoGenerico.setActivo(true);
		eventoGenericoSrv.guardarEvento(eventoGenerico);
		PerfilRR rr = this.getPerfilRR(request);
		List<EventoGenerico> eventos = new ArrayList<EventoGenerico>();
		if (rr != null) {
			resul.put("idRr", rr.getIdPerfilRR());
			resul.put("rr", rr.getDatosPersonales());
			eventos = eventoGenericoSrv.getListaEventosGenericosPorRR(rr);
			resul.put("eventos", eventos);
			return listaEventosPorRR(request);
		} else {
			eventos = eventoGenericoSrv
					.getListaEventosGenericosPorEA(eventoGenerico.getEa());
			resul.put("ea", eventoGenerico.getEa().getDatosPersonales());
			resul.put("idEa", eventoGenerico.getEa().getIdPerfilEA());
			resul.put("eventos", eventos);
			return listaEventos(request);
		}
	}

	/**
	 * @return
	 */
	@RequestMapping("/eventoGenerico/listaEventosGenericos.do")
	public ModelAndView listaEventos(HttpServletRequest request) {
		Map<String, Object> resul = new HashMap<String, Object>();
		List<EventoGenerico> eventos = new ArrayList<EventoGenerico>();
		PerfilEA ea = this.getPerfilEA(request);
		PerfilRR rr = this.getPerfilRR(request);
		if (ea != null) {
			eventos = eventoGenericoSrv.getListaEventosGenericosPorEA(ea);
			resul.put("idEa", ea.getIdPerfilEA());
			resul.put("ea", ea.getDatosPersonales());
		}else{
				if (rr != null) {
					resul.put("idRr", rr.getIdPerfilRR());
					resul.put("rr", rr.getDatosPersonales());
					eventos = eventoGenericoSrv.getListaEventosGenericosPorRR(rr);
				}else{
					eventos = eventoGenericoSrv.getListaEventosGenericosTodos();
				}
		}
		resul.put("eventos", eventos);
		return forward("/eventoGenerico/listaEventosGenericos", resul);
	}

	/**
	 * @return
	 */
	@RequestMapping("/eventoGenerico/listaEventosGenericosRR.do")
	public ModelAndView listaEventosPorRR(HttpServletRequest request) {
		Map<String, Object> resul = new HashMap<String, Object>();
		List<EventoGenerico> eventos = new ArrayList<EventoGenerico>();
		PerfilRR rr = this.getPerfilRR(request);
		if (rr != null) {
			eventos = eventoGenericoSrv.getListaEventosGenericosPorRR(rr);
			resul.put("idRr", rr.getIdPerfilRR());
			resul.put("rr", rr.getDatosPersonales());
		}
		resul.put("eventos", eventos);
		return forward("/eventoGenerico/listaEventosGenericos", resul);
	}

	/**
	 * @param idEvento
	 * @return
	 */
	@RequestMapping("/eventoGenerico/eliminarEventoGenerico.do")
	public ModelAndView eliminarEventoGenerico(
			@RequestParam("idEvento") Long idEvento) {
		Map<String, Object> resul = new HashMap<String, Object>();
		EventoGenerico evento = eventoGenericoSrv.getEventoGenerico(idEvento);
		evento.setActivo(false);
		eventoGenericoSrv.guardarEvento(evento);
		List<EventoGenerico> eventos = eventoGenericoSrv
				.getListaEventosGenericosPorEA(evento.getEa());
		resul.put("eventos", eventos);
		resul.put("ea", evento.getEa().getDatosPersonales());
		resul.put("idEa", evento.getEa().getIdPerfilEA());
		return forward("/eventoGenerico/listaEventosGenericos", resul);
	}

	/**
	 * @param idEvento
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/eventoGenerico/modificarEventoGenerico.do")
	public ModelAndView modificarEventoGenerico(
			@RequestParam("idEvento") Long idEvento) throws IOException {
		Map<String, Object> resul = new HashMap<String, Object>();
		EventoGenerico eventoGenerico = eventoGenericoSrv
				.getEventoGenerico(idEvento);

		resul.put("evento", eventoGenerico);
		resul.put("tiposEvento", TipoEventoGenerico.getListaTipos());
		resul.put("tiposContenido", ContenidosAbordados.values());
		resul.put("evaluaciones", EvaluacionEncuentro.getListaTipos());
		resul.put("idEa", eventoGenerico.getEa().getIdPerfilEA());
		resul.put("op1", eventoGenerico.getOp1());
		resul.put("op2", eventoGenerico.getOp2());
		resul.put("op3", eventoGenerico.getOp3());
		resul.put("op4", eventoGenerico.getOp4());
		resul.put("op5", eventoGenerico.getOp5());
		resul.put("op6", eventoGenerico.getOp6());
		resul.put("op", eventoGenerico.getOp());
		return forward("/eventoGenerico/altaEventoGenerico", resul);
	}

	@RequestMapping("/eventoGenerico/aprobarEventoGenerico.do")
	public ModelAndView aprobarEventoGenerico(
			@RequestParam("idEvento") Long idEvento, HttpServletRequest request)
			throws IOException {
		Map<String, Object> resul = new HashMap<String, Object>();
		EventoGenerico eventoGenerico = eventoGenericoSrv
				.getEventoGenerico(idEvento);
		PerfilRR rr = this.getPerfilRR(request);

		resul.put("evento", eventoGenerico);
		resul.put("tiposEvento", TipoEventoGenerico.getListaTipos());
		resul.put("tiposContenido", ContenidosAbordados.values());
		resul.put("evaluaciones", EvaluacionEncuentro.getListaTipos());
		resul.put("idRr", rr.getIdPerfilRR());
		resul.put("op1", eventoGenerico.getOp1());
		resul.put("op2", eventoGenerico.getOp2());
		resul.put("op3", eventoGenerico.getOp3());
		resul.put("op4", eventoGenerico.getOp4());
		resul.put("op5", eventoGenerico.getOp5());
		resul.put("op6", eventoGenerico.getOp6());
		resul.put("op", eventoGenerico.getOp());
		return forward("/eventoGenerico/altaEventoGenerico", resul);
	}

	@InitBinder
	protected void initBinder(HttpServletRequest request,
			ServletRequestDataBinder binder) throws Exception {
		if (binder.getTarget() != null && !binder.getTarget().equals("")) {
			binder.setDisallowedFields(new String[] { "lugarEncuentro",
					"tipoEvento",  "contenidosAbordados", "becados","evaluacionEncuentro",
					"fechaEvento", "fechaCarga" });
			if ((binder.getTarget() instanceof EventoGenerico)) {
				EventoGenerico evento = (EventoGenerico) binder.getTarget();
				String idEscuela = request.getParameter("idEscuela");
				String idTipoEvento = request.getParameter("tipoEvento");
				String[] contenidos = request
						.getParameterValues("contenidosAbordados");
				String idEvaluacion = request
						.getParameter("evaluacionEncuentro");
				
				String fechaEvento = request.getParameter("fechaEvento");
				String fechaCarga = request.getParameter("fechaCarga");
				List<ContenidosAbordados> contenidosAbordados;
				
				if (StringUtils.isNotBlank(idEscuela)) {
					Escuela escuela = escuelaSvr.obtenerEscuelaPorId(Long
							.parseLong(idEscuela));
					evento.setLugarEncuentro(escuela);
				}
				if (StringUtils.isNotBlank(idTipoEvento)) {
					TipoEventoGenerico tipoEvento = TipoEventoGenerico
							.getTipoEventoGenerico(Integer
									.parseInt(idTipoEvento));
					evento.setTipoEvento(tipoEvento);
				}
				if (StringUtils.isNotBlank(idEvaluacion)) {
					EvaluacionEncuentro evaluacion = EvaluacionEncuentro
							.getEvaluacionEncuentro(Integer
									.parseInt(idEvaluacion));
					evento.setEvaluacionEncuentro(evaluacion);
				}
				if (contenidos != null && contenidos.length > 0) {
					contenidosAbordados = new ArrayList<ContenidosAbordados>();
					for (int i = 0; i < contenidos.length; i++) {
						contenidosAbordados.add(ContenidosAbordados
								.getContenidosAbordados(Integer
										.parseInt(contenidos[i])));
					}
					evento.setContenidosAbordados(contenidosAbordados);
				}
				if (StringUtils.isNotBlank(fechaEvento)) {
					evento
							.setFechaEvento(Formateador
									.parsearFecha(fechaEvento));
				}
				if (StringUtils.isNotBlank(fechaCarga)) {
					evento.setFechaCarga(Formateador.parsearFecha(fechaCarga));
				}

			}
		}
	}
}