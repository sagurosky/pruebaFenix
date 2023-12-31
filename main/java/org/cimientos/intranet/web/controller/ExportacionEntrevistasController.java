package org.cimientos.intranet.web.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.cimientos.intranet.modelo.Beca;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.Pago;
import org.cimientos.intranet.modelo.informe.EstadoInforme;
import org.cimientos.intranet.modelo.informe.Informe;
import org.cimientos.intranet.modelo.informe.InformeIS3;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.Entrevista;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaFinal;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaIndividual;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaReIncorporacion;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaRenovacion;
import org.cimientos.intranet.modelo.perfil.AlumnoPanelEA;
import org.cimientos.intranet.modelo.perfil.PerfilAlumno;
import org.cimientos.intranet.modelo.perfilPadrino.TipoPadrino;
import org.cimientos.intranet.modelo.persona.Persona;
import org.cimientos.intranet.servicio.AlumnoPanelEASrv;
import org.cimientos.intranet.servicio.AlumnoSrv;
import org.cimientos.intranet.servicio.BecaSvr;
import org.cimientos.intranet.servicio.CicloProgramaSrv;
import org.cimientos.intranet.servicio.EntrevistaSrv;
import org.cimientos.intranet.servicio.InformeSrv;
import org.cimientos.intranet.servicio.PeriodoSrv;
import org.cimientos.intranet.utils.ExportacionEspecialHelper;
import org.cimientos.intranet.utils.hilos.LiberarMemoria;
import org.cimientos.intranet.utils.paginacion.ExtendedPaginatedList;
import org.cimientos.intranet.utils.paginacion.PaginateListFactory;
import org.displaytag.tags.TableTagParameters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cimientos.intranet.enumerativos.AnioEscolar;
import com.cimientos.intranet.enumerativos.SituacionEscolarMergeada;
import com.cimientos.intranet.enumerativos.entrevista.EstadoEntrevista;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionCobroBeca;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionIncorporacion;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionRenovacionMergeada;
import com.cimientos.intranet.enumerativos.entrevista.FormaEntrevista;
import com.cimientos.intranet.enumerativos.entrevista.MotivoCesacion;
import com.cimientos.intranet.enumerativos.entrevista.MotivoIncorporacionPendiente;
import com.cimientos.intranet.enumerativos.entrevista.MotivoNoRenovacion;
import com.cimientos.intranet.enumerativos.entrevista.MotivoPendiente;
import com.cimientos.intranet.enumerativos.entrevista.MotivoSuspension;
import com.cimientos.intranet.enumerativos.entrevista.SituacionCrisis;
import com.cimientos.intranet.enumerativos.entrevista.ContenidosTrabajarEnElAnio;
import com.cimientos.intranet.enumerativos.entrevista.TipoEntrevista;
import com.cimientos.intranet.enumerativos.entrevista.motivoNoIncorporacion;

/**
 * @author plabaronnie
 *
 */
@Controller
@RequestMapping("/exportacionEntrevistas/*")
public class ExportacionEntrevistasController extends BaseController{
	
	
	@Autowired
	private EntrevistaSrv entrevistaSrv;
	
	@Autowired
	private CicloProgramaSrv cicloSrv;
	
	@Autowired
	private PeriodoSrv svrPeriodo;
	
	@Autowired
	private PaginateListFactory paginateListFactory;
	
	@Autowired
	ExportacionEspecialHelper exportacionHelper;
	
	@Autowired
	private BecaSvr svrBeca;
	
	@Autowired
	private AlumnoSrv perfilAlumnoSrv;
	
	@Autowired
	private InformeSrv informeSrv;
	
	private static final Logger log = Logger.getLogger(ExportacionEntrevistasController.class);
	
	/**
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("/exportacionEntrevistas/verExportarEntrevistas.do")
	public ModelAndView verExportarEntrevistas(HttpServletRequest request, HttpSession session,
			@RequestParam(required = false, value="cantRows") String totalRows, 
			@RequestParam(required = false, value="idsCiclo") List<Long> idsCiclo,
			@RequestParam(required = false, value="idsTipo") List<Integer> tipoId, 
			@RequestParam(required = false, value="idsEstado") List<Integer > estadoId,
			@RequestParam(required = false, value="idsSituacion") List<Integer > situacionId,
			@RequestParam(required = false, value="idsPeriodo") List<Long > periodoId,
			@RequestParam(required = false, value="formaId") Integer formaId, @RequestParam(required= false, value="idPadrino") Long padrinoId,
			@RequestParam(required = false, value="padrino") String padrino, @RequestParam(required= false, value="idZona") Long zonaId,
			@RequestParam(required = false, value="zona") String zona, @RequestParam(required= false, value="idEA") Long eaId,
			@RequestParam(required = false, value="ea") String ea, @RequestParam(required= false, value="idRR") Long rrId,
			@RequestParam(required = false, value="rr") String rr,@RequestParam(value="nombreAlumno",required=false) String nombreAlumno,
			@RequestParam(required = false, value="idsAniosEscolares") List<Integer> idsAniosEscolares,
			@RequestParam(required = false, value="anioAdicional") String anioAdicional,
			@RequestParam(required = false, value="escuela") String escuela,
			@RequestParam(required = false, value="eae") String eae,
			@RequestParam(required = false, value="idEscuela") Long escuelaId,
			@RequestParam(required = false, value="idsEstadoRenovacion") 		List <Integer> idsEstadoRenovacion,
			@RequestParam(required = false, value="idsMotivoNoRenovacion") 		List <Integer> idsMotivoNoRenovacion,
			@RequestParam(required = false, value="idsMotivoPendiente") 		List <Integer> idsMotivoPendiente,
			@RequestParam(required = false, value="idsMotivoSuspension")        List <Integer> idsMotivoSuspension,
			@RequestParam(required = false, value="idsMotivoCesacion")          List <Integer> idsMotivoCesacion,
			@RequestParam(required = false, value="idsEstadoIncorporacion")     List <Integer> idsEstadoIncorporacion,         
			@RequestParam(required = false, value="idsMotivoIncorporacionPendiente") List <Integer> idsMotivoIncorporacionPendiente,
			@RequestParam(required = false, value="idsMotivoNoIncorporacion")   List <Integer> idsMotivoNoIncorporacion,
			@RequestParam(required = false, value="idsEstadoEntrevista")        List <Integer> idsEstadoEntrevista,
			@RequestParam(required = false, value="idsSituacioneEscolares")     List <Integer> idsSituacioneEscolares,
			@RequestParam(required=false, value="mensaje") String mensaje,
			@RequestParam(required=false, value="error") String error){
		
		Map<String, Object> resul = new HashMap<String, Object>();
		
		List<Integer> idsLocalEstadoRenovacion 		= null;
		List<Integer> idsLocalMotivoNoRenovacion 	= null;
		List<Integer> idsLocalMotivoPendiente 		= null;
		List<Integer> idsLocalMotivoSuspension 		= null;
		List<Integer> idsLocalMotivoCesacion 		= null;
		List<Integer> idsLocalEstadoIncorporacion 	= null;
		List<Integer> idsLocalMotivoIncorporacionPendiente = null;
		List<Integer> idsLocalMotivoNoIncorporacion = null;
		List<Integer> idsLocalEstadoEntrevista 		= null;
		List<Integer> idsLocalSituacioneEscolares 	= null;
		
		List<Long> 		idsLocalCiclo = null;
		List<Integer> 	idsLocalAnioEscolar = null;
		List<Integer> 	idsLocalTipo = null;
		List<Integer> 	idsLocalEstado = null;
		List<Long> 		idsLocalPeriodo = null;
		List<Integer> 	idsLocalSituacion = null;
		
		Integer idForma = formaId != null && formaId.equals(0) ? null : formaId;
		Boolean adicional = null;
		Long idEscuela = escuelaId!=null && escuelaId.equals(0L) ? null : escuelaId;

//		if (situacionId!=null && !situacionId.contains(0)){
		
		if (ea==""){
        	ea = null;
        	eaId=null;
        }
		
        if (rr==""){
        	 rr= null;
        	rrId=null;
        }
		
		
		if (situacionId!=null){	/*usa in con sql*/
			idsLocalSituacion = new ArrayList<Integer>();
			idsLocalSituacion.addAll(situacionId);
		}
		
		if (periodoId!=null){	//ok
			idsLocalPeriodo = new ArrayList<Long>();
			idsLocalPeriodo.addAll(periodoId);

			if (idsLocalPeriodo.contains(0L)){
				idsLocalPeriodo.remove(new Long(0));
			}
		}
		
		if (estadoId!=null){	//ok
			idsLocalEstado = new ArrayList<Integer>();
			idsLocalEstado.addAll(estadoId);

			if (idsLocalEstado.contains(0)){
				idsLocalEstado.remove(new Integer(0));
			}
		}
		
		if (tipoId!=null){		//ok
			idsLocalTipo = new ArrayList<Integer>();
			idsLocalTipo.addAll(tipoId);

			if (idsLocalTipo.contains(0)){
				idsLocalTipo.remove(new Integer(0));
			}
		}
		
		if (idsAniosEscolares!=null){	//ok
			idsLocalAnioEscolar = new ArrayList<Integer>();
			idsLocalAnioEscolar.addAll(idsAniosEscolares);

			if (idsLocalAnioEscolar.contains(0)){
				idsLocalAnioEscolar.remove(new Integer(0));
			}
		}

		if (idsEstadoRenovacion!=null){	//ok
			idsLocalEstadoRenovacion = new ArrayList<Integer>();
			idsLocalEstadoRenovacion.addAll(idsEstadoRenovacion);

			if (idsLocalEstadoRenovacion.contains(0)){
				idsLocalEstadoRenovacion.remove(new Integer(0));
			}
		}

		if (idsMotivoNoRenovacion!=null){
			idsLocalMotivoNoRenovacion = new ArrayList<Integer>();
			idsLocalMotivoNoRenovacion.addAll(idsMotivoNoRenovacion);

			if (idsLocalMotivoNoRenovacion.contains(0)){
				idsLocalMotivoNoRenovacion.remove(new Integer(0));
			}
		}

		if (idsMotivoPendiente!=null){
			idsLocalMotivoPendiente = new ArrayList<Integer>();
			idsLocalMotivoPendiente.addAll(idsMotivoPendiente);

			if (idsLocalMotivoPendiente.contains(0)){
				idsLocalMotivoPendiente.remove(new Integer(0));
			}
		}

		if (idsMotivoSuspension!=null){
			idsLocalMotivoSuspension = new ArrayList<Integer>();
			idsLocalMotivoSuspension.addAll(idsMotivoSuspension);

			if (idsLocalMotivoSuspension.contains(0)){
				idsLocalMotivoSuspension.remove(new Integer(0));
			}
		}

		if (idsMotivoCesacion!=null){
			idsLocalMotivoCesacion = new ArrayList<Integer>();
			idsLocalMotivoCesacion.addAll(idsMotivoCesacion);

			if (idsLocalMotivoCesacion.contains(0)){
				idsLocalMotivoCesacion.remove(new Integer(0));
			}
		}

		if (idsEstadoIncorporacion!=null){
			idsLocalEstadoIncorporacion = new ArrayList<Integer>();
			idsLocalEstadoIncorporacion.addAll(idsEstadoIncorporacion);

			if (idsLocalEstadoIncorporacion.contains(0)){
				idsLocalEstadoIncorporacion.remove(new Integer(0));
			}
		}

		if (idsMotivoIncorporacionPendiente!=null){
			idsLocalMotivoIncorporacionPendiente = new ArrayList<Integer>();
			idsLocalMotivoIncorporacionPendiente.addAll(idsMotivoIncorporacionPendiente);

			if (idsLocalMotivoIncorporacionPendiente.contains(0)){
				idsLocalMotivoIncorporacionPendiente.remove(new Integer(0));
			}
		}

		if (idsMotivoNoIncorporacion!=null){
			idsLocalMotivoNoIncorporacion = new ArrayList<Integer>();
			idsLocalMotivoNoIncorporacion.addAll(idsMotivoNoIncorporacion);

			if (idsLocalMotivoNoIncorporacion.contains(0)){
				idsLocalMotivoNoIncorporacion.remove(new Integer(0));
			}
		}
		
		if (idsEstadoEntrevista!=null){		//ok
			idsLocalEstadoEntrevista = new ArrayList<Integer>();
			idsLocalEstadoEntrevista.addAll(idsEstadoEntrevista);

			if (idsLocalEstadoEntrevista.contains(0)){
				idsLocalEstadoEntrevista.remove(new Integer(0));
			}
		}

		if (idsSituacioneEscolares!=null){	//ok
			idsLocalSituacioneEscolares = new ArrayList<Integer>();
			idsLocalSituacioneEscolares.addAll(idsSituacioneEscolares);

			if (idsLocalSituacioneEscolares.contains(0)){
				idsLocalSituacioneEscolares.remove(new Integer(0));
			}
		}
		
		if(anioAdicional != null){
			adicional = generarAdicional(anioAdicional);
			resul.put("adicional", anioAdicional);
		}

		idsLocalCiclo = new ArrayList<Long>();
		if (idsCiclo==null || (idsCiclo!=null && idsCiclo.size()==0)){
			idsLocalCiclo.add(cicloSrv.obtenerCicloActual().getId());
			
			idsCiclo = new ArrayList<Long>();
			idsCiclo.addAll(idsLocalCiclo);
		} else {
			idsLocalCiclo.addAll(idsCiclo);
		}

		boolean export = request.getParameter(TableTagParameters.PARAMETER_EXPORTING) != null; 
		
		ExtendedPaginatedList listaPaginada = paginarEntrevistas(idsLocalCiclo, export, request, idsLocalTipo, idsLocalEstado, idsLocalSituacion, 
												idsLocalPeriodo, idForma, padrinoId, zonaId, rrId, eaId, nombreAlumno, /*anio*/ idsLocalAnioEscolar, adicional,
												idEscuela, idsLocalEstadoRenovacion, idsLocalMotivoNoRenovacion, idsLocalMotivoPendiente, idsLocalMotivoSuspension, 
												idsLocalMotivoCesacion, idsLocalEstadoIncorporacion,idsLocalMotivoIncorporacionPendiente, 
												idsLocalMotivoNoIncorporacion, idsLocalEstadoEntrevista, idsLocalSituacioneEscolares, eae
												);
		
		ArrayList<String> listaAdicional = generarListaAdicional();
		resul.put("listAdicional", listaAdicional);
		resul.put("aniosEscolares", AnioEscolar.getAnioEscolares());
		resul.put("idsAniosEscolares", idsAniosEscolares);
        resul.put("listaEntrevistas", listaPaginada);
        resul.put("ciclos", cicloSrv.obtenerCiclosClonarBecas());
        resul.put("idsCiclo", idsCiclo); 
        resul.put("tipos", TipoEntrevista.getTipoEntrevistas());
        resul.put("idsTipo", tipoId);
        resul.put("estados", EvaluacionCobroBeca.getEvaluacionCobroBeca());
        resul.put("idsEstado", estadoId); 
        resul.put("situaciones", SituacionCrisis.values());
        resul.put("contenidosTrabajarEnElAnio", ContenidosTrabajarEnElAnio.values());
        resul.put("idsSituacion", situacionId);

		if (idsCiclo!=null && idsCiclo.size()==1){
			resul.put("periodos", svrPeriodo.buscarPeriodosPorCiclo(idsCiclo.get(0)));
		}
        
        resul.put("idsPeriodo", periodoId);
        resul.put("formaId", formaId);
        resul.put("formas", FormaEntrevista.getFormasEntrevista());
        resul.put("idPadrino", padrinoId);
        resul.put("padrino", padrino);
        resul.put("eae", eae);
        resul.put("idZona", zonaId);
        resul.put("zona", zona);
        resul.put("idEA", eaId);
        resul.put("ea", ea);
        resul.put("idRR", rrId);
        resul.put("rr", rr);
        resul.put("nombreAlumno", nombreAlumno);
        resul.put("idEscuela", escuelaId);
        resul.put("escuela", escuela);
        
        resul.put("estadosRenovacion", EvaluacionRenovacionMergeada.getTodosEvaluacionRenovacionMergeada());
        resul.put("idsEstadoRenovacion", idsEstadoRenovacion);
        
        resul.put("motivosNoRenovacion", MotivoNoRenovacion.getmotivoNoRenovacion());
        resul.put("idsMotivoNoRenovacion", idsMotivoNoRenovacion);
        
        resul.put("motivosPendiente", MotivoPendiente.getMotivoPendiente());
        resul.put("idsMotivoPendiente", idsMotivoPendiente);
        
        resul.put("motivosSuspension", MotivoSuspension.getMotivoSuspension());
        resul.put("idsMotivoSuspension", idsMotivoSuspension);
        
        resul.put("motivosCesacion", MotivoCesacion.getMotivoCesacion());
        resul.put("idsMotivoCesacion", idsMotivoCesacion);

        resul.put("estadosIncorporacion", EvaluacionIncorporacion.getEvaluacionIncorporacion());
        resul.put("idsEstadoIncorporacion", idsEstadoIncorporacion);

        resul.put("motivosIncorporacionPendiente", MotivoIncorporacionPendiente.getMotivoIncorporacionPendiente());
        resul.put("idsMotivoIncorporacionPendiente", idsMotivoIncorporacionPendiente);

        resul.put("motivosNoIncorporacion", motivoNoIncorporacion.getmotivoNoIncorporacion());
        resul.put("idsMotivoNoIncorporacion", idsMotivoNoIncorporacion);
        
        resul.put("estadosEntrevista", EstadoEntrevista.getEstadoEntrevista());
        resul.put("idsEstadoEntrevista", idsEstadoEntrevista);
        
        resul.put("situacionesEscolares", SituacionEscolarMergeada.getSituacionEscolar());
        resul.put("idsSituacioneEscolares", idsSituacioneEscolares);
        
		resul.put("estadoEntrevistaFin", EstadoEntrevista.FINALIZADA.getValor());
		if(StringUtils.isNotBlank(mensaje))
			resul.put("mensaje", mensaje);
		if(StringUtils.isNotBlank(error))
			resul.put("error", error);
		Persona personaLogueada = obtenerPersona(request);
		if(personaLogueada.getPerfilSuperUsuario())
			resul.put("tipoPerfil", "superUsuario");
		else
			resul.put("tipoPerfil", "");
		resul.put("formaEntrevista", FormaEntrevista.GRUPAL.getValor());
		
		return forward("/exportacionEntrevistas/exportarEntrevistas", resul);
	}

	private Boolean generarAdicional(String anioAdicional) {
		if(anioAdicional.equals("Todos"))
			return null;
		else
			return anioAdicional.equals("Si");
	}

	private ArrayList<String> generarListaAdicional() {
		ArrayList<String> listaAdicional = new ArrayList<String>();
		listaAdicional.add("Si");
		listaAdicional.add("No");
		return listaAdicional;
	}

	/**
	 * @param idCiclo
	 * @param listaPaginada
	 * @param export
	 * @param padrinoId 
	 * @param idForma 
	 * @param idPeriodo 
	 * @param idSituacion 
	 * @param idEstado 
	 * @param eaId 
	 * @param rrId 
	 * @param nombreAlumno 
	 * @param adicional 
	 * @param anio 
	 * @return
	 */
	private ExtendedPaginatedList paginarEntrevistas(List<Long> idCiclo, boolean export, HttpServletRequest request,
			List<Integer> tipoId, List<Integer> idEstado, List<Integer > idSituacion, List<Long> idPeriodo, Integer idForma, Long padrinoId,
			Long zonaId, Long rrId, Long eaId, String nombreAlumno, List<Integer> anio, Boolean adicional, 
			Long escuelaId, List <Integer> idsEstadoRenovacion, List<Integer >idsMotivoNoRenovacion,
			List <Integer> idsMotivoPendiente, List <Integer> idsMotivoSuspension, List <Integer> idsMotivoCesacion,
			List <Integer> idsEstadoIncorporacion, List <Integer> idsMotivoIncorporacionPendiente, List <Integer> idsMotivoNoIncorporacion,
			List <Integer> idsEstadoEntrevista, List <Integer> idsSituacioneEscolares, String eae) {
		
		//List<ExportacionEntrevistaDTO> entrevistasDTO = null;
		List<EntrevistaIndividual> entrevistasDTO = null;
		
		ExtendedPaginatedList listaPaginada = paginateListFactory.getPaginatedListFromRequest(request);
		
		List<CicloPrograma> ciclo = null;
		if (idCiclo!=null && idCiclo.size()>0){
			ciclo = new ArrayList<CicloPrograma>();
			
			for (Long id:idCiclo){
				CicloPrograma valor = cicloSrv.obtenerCiclo(id);
				if (valor!=null)
					ciclo.add(valor);
			}
		}
		
		int totalRows = entrevistaSrv.obtenerCantidadEntrevistasAExportar(ciclo, tipoId, idEstado, idSituacion, 
				idPeriodo, idForma, padrinoId, zonaId, rrId, eaId, nombreAlumno,anio,adicional,
				escuelaId, idsEstadoRenovacion, idsMotivoNoRenovacion,
				idsMotivoPendiente, idsMotivoSuspension, idsMotivoCesacion, idsEstadoIncorporacion, 
				idsMotivoIncorporacionPendiente, idsMotivoNoIncorporacion, idsEstadoEntrevista, idsSituacioneEscolares, eae);
		
		//Si es un export debo cargar toda la lista entera, si no lo es entonces se carga la lista de a una pagina por vez
		if(export){
			entrevistasDTO = entrevistaSrv.obtenerEntrevistasAExportar(ciclo, tipoId , idEstado, idSituacion, idPeriodo, idForma, padrinoId, zonaId, rrId, eaId, nombreAlumno,
					anio, adicional, escuelaId, idsEstadoRenovacion, idsMotivoNoRenovacion,
					idsMotivoPendiente, idsMotivoSuspension, idsMotivoCesacion, idsEstadoIncorporacion, 
					idsMotivoIncorporacionPendiente, idsMotivoNoIncorporacion, idsEstadoEntrevista, idsSituacioneEscolares,
					0, totalRows,listaPaginada.getSortDirection(), listaPaginada.getSortCriterion(), eae);
		}else{
		entrevistasDTO = entrevistaSrv
				.obtenerEntrevistasAExportar(ciclo, tipoId,idEstado, idSituacion, idPeriodo, idForma, padrinoId, zonaId, rrId, eaId, nombreAlumno,
						anio,adicional, escuelaId, idsEstadoRenovacion, idsMotivoNoRenovacion,
						idsMotivoPendiente, idsMotivoSuspension, idsMotivoCesacion, idsEstadoIncorporacion, 
						idsMotivoIncorporacionPendiente, idsMotivoNoIncorporacion, idsEstadoEntrevista, idsSituacioneEscolares,
						listaPaginada.getFirstRecordIndex(), listaPaginada.getPageSize(),listaPaginada.getSortDirection(),
						listaPaginada.getSortCriterion(),eae);
		}
		
		listaPaginada.setList(entrevistasDTO);
		listaPaginada.setTotalNumberOfRows(totalRows);

		return listaPaginada;
	}
	

	@RequestMapping("/exportacionEntrevistas/exportarEntrevistas.do")
	public ModelAndView exportarEntrevistas(HttpServletRequest request, HttpSession session,
			@RequestParam(required = false, value="cantRows") String totalRows, 
			@RequestParam(required = false, value="idsCiclo") List<Long> idsCiclo,
			@RequestParam(required = false, value="idsTipo") List<Integer> tipoId, 
			@RequestParam(required = false, value="idsEstado") List<Integer > estadoId,
			@RequestParam(required = false, value="idsSituacion") List<Integer > situacionId,
			@RequestParam(required = false, value="idsPeriodo") List<Long > periodoId,
			@RequestParam(required = false, value="formaId") Integer formaId, @RequestParam(required= false, value="idPadrino") Long padrinoId,
			@RequestParam(required = false, value="padrino") String padrino, @RequestParam(required= false, value="idZona") Long zonaId,
			@RequestParam(required = false, value="zona") String zona, @RequestParam(required= false, value="idEA") Long eaId,
			@RequestParam(required = false, value="ea") String ea, @RequestParam(required= false, value="idRR") Long rrId,
			@RequestParam(required = false, value="rr") String rr,@RequestParam(value="nombreAlumno",required=false) String nombreAlumno,
			@RequestParam(required = false, value="idsAniosEscolares") List<Integer> idsAniosEscolares,
			@RequestParam(required = false, value="anioAdicional") String anioAdicional,
			@RequestParam(required = false, value="eae") String eae,
			@RequestParam(required = false, value="escuela") String escuela,
			@RequestParam(required = false, value="idEscuela") Long escuelaId,
			@RequestParam(required = false, value="idsEstadoRenovacion") 		List <Integer> idsEstadoRenovacion,
			@RequestParam(required = false, value="idsMotivoNoRenovacion") 		List <Integer> idsMotivoNoRenovacion,
			@RequestParam(required = false, value="idsMotivoPendiente") 		List <Integer> idsMotivoPendiente,
			@RequestParam(required = false, value="idsMotivoSuspension")        List <Integer> idsMotivoSuspension,
			@RequestParam(required = false, value="idsMotivoCesacion")          List <Integer> idsMotivoCesacion,
			@RequestParam(required = false, value="idsEstadoIncorporacion")     List <Integer> idsEstadoIncorporacion,         
			@RequestParam(required = false, value="idsMotivoIncorporacionPendiente") List <Integer> idsMotivoIncorporacionPendiente,
			@RequestParam(required = false, value="idsMotivoNoIncorporacion")   List <Integer> idsMotivoNoIncorporacion,
			@RequestParam(required = false, value="idsEstadoEntrevista")        List <Integer> idsEstadoEntrevista,
			@RequestParam(required = false, value="idsSituacioneEscolares")     List <Integer> idsSituacioneEscolares )
	{
		String excelView = "exportarEntrevistasView";
		HashMap<String,Object> resul = new HashMap<String, Object>();
		
		List<Integer> idsLocalEstadoRenovacion 		= null;
		List<Integer> idsLocalMotivoNoRenovacion 	= null;
		List<Integer> idsLocalMotivoPendiente 		= null;
		List<Integer> idsLocalMotivoSuspension 		= null;
		List<Integer> idsLocalMotivoCesacion 		= null;
		List<Integer> idsLocalEstadoIncorporacion 	= null;
		List<Integer> idsLocalMotivoIncorporacionPendiente = null;
		List<Integer> idsLocalMotivoNoIncorporacion = null;
		List<Integer> idsLocalEstadoEntrevista 		= null;
		List<Integer> idsLocalSituacioneEscolares 	= null;
		
		List<Long> 		idsLocalCiclo = null;
		List<Integer> 	idsLocalAnioEscolar = null;
		List<Integer> 	idsLocalTipo = null;
		List<Integer> 	idsLocalEstado = null;
		List<Long> 		idsLocalPeriodo = null;
		List<Integer> 	idsLocalSituacion = null;
		
		
		Integer idForma = formaId != null && formaId.equals(0) ? null : formaId;
		Boolean adicional = null;
		Long idEscuela = escuelaId!=null && escuelaId.equals(0L) ? null : escuelaId;

		if (situacionId!=null){
			idsLocalSituacion = new ArrayList<Integer>();
			idsLocalSituacion.addAll(situacionId);
		}
		
		if (periodoId!=null){
			idsLocalPeriodo = new ArrayList<Long>();
			idsLocalPeriodo.addAll(periodoId);

			if (idsLocalPeriodo.contains(0L)){
				idsLocalPeriodo.remove(new Long(0));
			}
		}
		
		if (estadoId!=null){
			idsLocalEstado = new ArrayList<Integer>();
			idsLocalEstado.addAll(estadoId);

			if (idsLocalEstado.contains(0)){
				idsLocalEstado.remove(new Integer(0));
			}
		}
		
		if (tipoId!=null){
			idsLocalTipo = new ArrayList<Integer>();
			idsLocalTipo.addAll(tipoId);

			if (idsLocalTipo.contains(0)){
				idsLocalTipo.remove(new Integer(0));
			}
		}
		
		if (idsAniosEscolares!=null){
			idsLocalAnioEscolar = new ArrayList<Integer>();
			idsLocalAnioEscolar.addAll(idsAniosEscolares);

			if (idsLocalAnioEscolar.contains(0)){
				idsLocalAnioEscolar.remove(new Integer(0));
			}
		}

		if (idsEstadoRenovacion!=null){
			idsLocalEstadoRenovacion = new ArrayList<Integer>();
			idsLocalEstadoRenovacion.addAll(idsEstadoRenovacion);

			if (idsLocalEstadoRenovacion.contains(0)){
				idsLocalEstadoRenovacion.remove(new Integer(0));
			}
		}

		if (idsMotivoNoRenovacion!=null){
			idsLocalMotivoNoRenovacion = new ArrayList<Integer>();
			idsLocalMotivoNoRenovacion.addAll(idsMotivoNoRenovacion);

			if (idsLocalMotivoNoRenovacion.contains(0)){
				idsLocalMotivoNoRenovacion.remove(new Integer(0));
			}
		}

		if (idsMotivoPendiente!=null){
			idsLocalMotivoPendiente = new ArrayList<Integer>();
			idsLocalMotivoPendiente.addAll(idsMotivoPendiente);

			if (idsLocalMotivoPendiente.contains(0)){
				idsLocalMotivoPendiente.remove(new Integer(0));
			}
		}

		if (idsMotivoSuspension!=null){
			idsLocalMotivoSuspension = new ArrayList<Integer>();
			idsLocalMotivoSuspension.addAll(idsMotivoSuspension);

			if (idsLocalMotivoSuspension.contains(0)){
				idsLocalMotivoSuspension.remove(new Integer(0));
			}
		}

		if (idsMotivoCesacion!=null){
			idsLocalMotivoCesacion = new ArrayList<Integer>();
			idsLocalMotivoCesacion.addAll(idsMotivoCesacion);

			if (idsLocalMotivoCesacion.contains(0)){
				idsLocalMotivoCesacion.remove(new Integer(0));
			}
		}

		if (idsEstadoIncorporacion!=null){
			idsLocalEstadoIncorporacion = new ArrayList<Integer>();
			idsLocalEstadoIncorporacion.addAll(idsEstadoIncorporacion);

			if (idsLocalEstadoIncorporacion.contains(0)){
				idsLocalEstadoIncorporacion.remove(new Integer(0));
			}
		}

		if (idsMotivoIncorporacionPendiente!=null){
			idsLocalMotivoIncorporacionPendiente = new ArrayList<Integer>();
			idsLocalMotivoIncorporacionPendiente.addAll(idsMotivoIncorporacionPendiente);

			if (idsLocalMotivoIncorporacionPendiente.contains(0)){
				idsLocalMotivoIncorporacionPendiente.remove(new Integer(0));
			}
		}

		if (idsMotivoNoIncorporacion!=null){
			idsLocalMotivoNoIncorporacion = new ArrayList<Integer>();
			idsLocalMotivoNoIncorporacion.addAll(idsMotivoNoIncorporacion);

			if (idsLocalMotivoNoIncorporacion.contains(0)){
				idsLocalMotivoNoIncorporacion.remove(new Integer(0));
			}
		}
		
		if (idsEstadoEntrevista!=null){
			idsLocalEstadoEntrevista = new ArrayList<Integer>();
			idsLocalEstadoEntrevista.addAll(idsEstadoEntrevista);

			if (idsLocalEstadoEntrevista.contains(0)){
				idsLocalEstadoEntrevista.remove(new Integer(0));
			}
		}

		if (idsSituacioneEscolares!=null){
			idsLocalSituacioneEscolares = new ArrayList<Integer>();
			idsLocalSituacioneEscolares.addAll(idsSituacioneEscolares);

			if (idsLocalSituacioneEscolares.contains(0)){
				idsLocalSituacioneEscolares.remove(new Integer(0));
			}
		}
		
		if(anioAdicional != null){
			adicional = generarAdicional(anioAdicional);
			resul.put("adicional", anioAdicional);
		}

		idsLocalCiclo = new ArrayList<Long>();
		if (idsCiclo==null || (idsCiclo!=null && idsCiclo.size()==0)){
			idsLocalCiclo.add(cicloSrv.obtenerCicloActual().getId());
		} else {
			idsLocalCiclo.addAll(idsCiclo);
		}
		
		
		resul.put("idsCiclo", idsLocalCiclo);
		resul.put("idsTipo", idsLocalTipo);
		resul.put("idsEstado", idsLocalEstado);
		resul.put("idsSituacion", idsLocalSituacion);
		resul.put("idsPeriodo", idsLocalPeriodo);
		resul.put("idForma", idForma);
		resul.put("idPadrino", padrinoId);
		resul.put("idZona", zonaId);
		resul.put("idRR", rrId);
		resul.put("idEa", eaId);
		resul.put("nombreAlum", nombreAlumno);
		resul.put("idsAnioEscolar", idsLocalAnioEscolar);
		resul.put("adicional", adicional);
		resul.put("idEscuela", idEscuela);
		resul.put("idsEstadoRenovacion", idsLocalEstadoRenovacion);
		resul.put("idsMotivoNoRenovacion", idsLocalMotivoNoRenovacion);
		resul.put("idsMotivoPendiente", idsLocalMotivoPendiente);
		resul.put("idsMotivoSuspension", idsLocalMotivoSuspension);
		resul.put("idsMotivoCesacion", idsLocalMotivoCesacion);
		resul.put("idsEstadoIncorporacion", idsLocalEstadoIncorporacion);
		resul.put("idsMotivoIncorporacionPendiente", idsLocalMotivoIncorporacionPendiente);
		resul.put("idsMotivoNoIncorporacion", idsLocalMotivoNoIncorporacion);
		resul.put("idsEstadoEntrevista", idsLocalEstadoEntrevista);
		resul.put("idsSituacionEscolar", idsLocalSituacioneEscolares);
		resul.put("eae", eae);
		resul.put("entrevistaSrv", entrevistaSrv);
		resul.put("cicloSrv", cicloSrv);
		resul.put("exportacionHelper", exportacionHelper);
		
		LiberarMemoria lm = new LiberarMemoria();
		Thread tlm = new Thread(lm);
		tlm.start();
		
		return new ModelAndView(excelView,resul);	
		
	}
	
	@RequestMapping("/exportacionEntrevistas/modificarPadrino.do")
	public ModelAndView modificarPadrino(@RequestParam("idEntrevista") Long idEntrevista,
			@RequestParam("becaId") Long idBeca,
			HttpServletRequest request, HttpSession session){
				
		Entrevista entrevista = entrevistaSrv.obtenerEntrevista(idEntrevista);
		Beca beca = svrBeca.obtenerPorId(idBeca);
		String padrino = "";
		String mensaje = "";
		String error = "";
		if(beca != null){
			if(beca.getPadrino().getTipo().equals(TipoPadrino.CORPORATIVO))
				padrino = beca.getPadrino().getEmpresa().getDenominacion();
			else
				padrino = beca.getPadrino().getDatosPersonales().getApellidoNombre();
		}
		else
			error = "El padrino seleccionado no est� asociado a ninguna beca";
		if(entrevista != null && StringUtils.isNotBlank(padrino)){
			entrevista.getExportacionEspecial().setPadrino(padrino);
			entrevista.getExportacionEspecial().setIdBeca(idBeca);
			entrevista.getExportacionEspecial().setIdPadrino(beca.getPadrino().getId());
			entrevista.getExportacionEspecial().setTipoPadrino(beca.getPadrino().getTipo().getValor());
			entrevistaSrv.guardarEntrevista(entrevista);
			mensaje = "Se modifico el padrino de la entrevista seleccionada de forma satisfactoria";
		}
		else
			error = "No existe la entrevista seleccionada";
		
		
		return verExportarEntrevistas(request, session, null, null, null, null, null, null, null, null, null, null,null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, mensaje, error);
	}
}