package org.cimientos.intranet.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.cimientos.intranet.dto.ExportarAlumnosDTO;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.candidato.convocatoria.Convocatoria;
import org.cimientos.intranet.modelo.escuela.Escuela;
import org.cimientos.intranet.modelo.perfil.EstadoAlumno;
import org.cimientos.intranet.modelo.perfilEA.PerfilEA;
import org.cimientos.intranet.modelo.perfilPadrino.PerfilPadrino;
import org.cimientos.intranet.modelo.ubicacion.ZonaCimientos;
import org.cimientos.intranet.servicio.AlumnoSrv;
import org.cimientos.intranet.servicio.CicloProgramaSrv;
import org.cimientos.intranet.servicio.ConvocatoriaSrv;
import org.cimientos.intranet.servicio.EscuelaSrv;
import org.cimientos.intranet.servicio.PerfilEASrv;
import org.cimientos.intranet.servicio.PerfilPadrinoSvr;
import org.cimientos.intranet.servicio.ZonaCimientosSrv;
import org.cimientos.intranet.utils.ConstantesMenu;
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

/**
 * The Class ExportarAlumnosController.
 */
@Controller("/exportarAlumnos/*")
public class ExportarAlumnosController extends BaseController {
	
	/** The alumno srv. */
	@Autowired
	private AlumnoSrv alumnoSrv;
	
	/** The paginate list factory. */
	@Autowired
	private PaginateListFactory paginateListFactory;
	@Autowired
	private ZonaCimientosSrv zonaCimientosSrv;
	@Autowired
	private EscuelaSrv escuelaSrv;
	@Autowired
	private PerfilPadrinoSvr padrinoSvr;
	@Autowired
	private ConvocatoriaSrv convocatoriaSrv;
	@Autowired
	private PerfilEASrv eaSrv;
	
	/** The map. */
	private Map<String,Object> map;
	
	@Autowired
	private CicloProgramaSrv cicloSrv;
	
	/**
	 * Lista alumno exportar.
	 *
	 * @param request the request
	 * @return the model and view
	 * @since 26-abr-2011
	 * @author cfigueroa
	 */
	@RequestMapping("/exportarAlumnos/listaAlumnosExportar.do")
	public ModelAndView listaAlumnoExportar(HttpServletRequest request,
											@RequestParam(required=false,value="idEstadoAlumno")Integer idEstadoAlumno,
											@RequestParam(required=false,value="idAnioEscolar")Integer idAnioEscolar,
											@RequestParam(required=false,value="eae")String eae,
											@RequestParam(required=false,value="anioAdicional")String anioAdicional,
											@RequestParam(required=false,value="idZonaCimientos")Long idZonaCimientos,
											@RequestParam(required=false,value="idConvocatoria")Long idConvocatoria,
											@RequestParam(required=false,value="idPadrino")Long idPadrino,
											@RequestParam(required=false,value="idEa")Long idEa,
											@RequestParam(value="nombreAlumno",required=false) String nombreAlumno,
											@RequestParam(required=false, value="becadosActivos") boolean becadosActivos,
											@RequestParam(required= false, value="mensaje") String mensaje,
											@RequestParam(required=false,value="idEscuela")Long idEscuela,
											@RequestParam(required= false, value="error") String error,
											@RequestParam(required= false, value="anioEgreso") Long anioEgreso){
		
		boolean export = request.getParameter(TableTagParameters.PARAMETER_EXPORTING) != null;
		EstadoAlumno estadoAlumno = null;
		AnioEscolar anio = null;
		Boolean adicional = null;
		ZonaCimientos zona=null;
		Convocatoria convocatoria=null;
		PerfilPadrino padrino=null;
		PerfilEA ea=null;
		Escuela escuela= null;
		List<EstadoAlumno> estadosParaExportacion = new ArrayList<EstadoAlumno>();
		Integer estadoAlumnoId = idEstadoAlumno != null && idEstadoAlumno.equals(0) ? null : idEstadoAlumno;
		Integer idAnio = idAnioEscolar != null && idAnioEscolar.equals(0) ? null : idAnioEscolar;
		
		map = new HashMap<String, Object>();
		//Filtros de busqueda
		
		map.put("becadosActivos", becadosActivos);
		
		//System.out.println("becados activos: "+becadosActivos);
		//System.out.println("EAE: "+eae);
		if(estadoAlumnoId != null){
			estadoAlumno= EstadoAlumno.getEstados(estadoAlumnoId);
			map.put("estado", estadoAlumno);
		}		
		if(idAnio != null){
			anio= AnioEscolar.getAnioEscolar(idAnio);
			map.put("anio", anio);
		}
		
		if(anioAdicional != null){
			adicional = generarAdicional(anioAdicional);
			map.put("adicional", anioAdicional);
		}		
		if(anioEgreso!=null){
			
			map.put("anioEgreso", anioEgreso);
		}
		
		if(idZonaCimientos != null){
			zona = zonaCimientosSrv.obtenerZonaCimientos(idZonaCimientos);
			map.put("zonaCimientos", zona);
		}
		if(idEscuela != null){			
			escuela = escuelaSrv.obtenerEscuelaPorId(idEscuela);
			map.put("escuela", escuela.getNombre());
		}
		
		if(idConvocatoria != null ){
			convocatoria = convocatoriaSrv.obtenerConvocatoriaPorId(idConvocatoria);
			map.put("convocatoria", convocatoria);
		}
		if(idPadrino != null ){
			padrino = padrinoSvr.obtenerPorId(idPadrino);
			map.put("padrino", padrino);
		}
		if(idEa != null){
			ea = eaSrv.obtenerPerfilEA(idEa);
			map.put("perfilEA",ea );
		}
		
		if(nombreAlumno != null){
			if(nombreAlumno == "")
				nombreAlumno=null;
			map.put("nombreAlumno", nombreAlumno);
		}
	
		ExtendedPaginatedList listaPaginada = paginarAlumnos(export, request,estadoAlumno,zona,convocatoria,
				padrino,ea,nombreAlumno,anio,adicional,becadosActivos, eae, escuela,anioEgreso);
		map.put("alumnos",listaPaginada);
		map.put("eae",eae);
		llenarComboEstadoAlumno(estadosParaExportacion);
		
		ArrayList<String> listaAdicional = generarListaAdicional();
		map.put("listAdicional", listaAdicional);
		map.put("listEstadoAlumnos",estadosParaExportacion);
		map.put("listAniosEscolares", AnioEscolar.getAnioEscolares());
		map.put("ciclos", cicloSrv.obtenerCiclosClonarBecas());
		map.put("urlRegreso", "/exportarAlumnos/listaAlumnosExportar.do");
		HttpSession session = request.getSession();
		session.setAttribute("menu", ConstantesMenu.menuExportacion);
		
		if(StringUtils.isNotBlank(mensaje))
			map.put("mensaje", mensaje);	
		
		if(StringUtils.isNotBlank(error))
			map.put("error", error);
		
		return forward("/exportarAlumnos/listaAlumnosExportar", map);
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

	private void llenarComboEstadoAlumno(List<EstadoAlumno> estadosParaExportacion) 
	{
		EstadoAlumno pendiente = EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION;
		pendiente.setValor("Pendiente");
		EstadoAlumno enCondicionesDeRenovar = EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION;
		enCondicionesDeRenovar.setValor("En condiciones de renovar");

		estadosParaExportacion.add(EstadoAlumno.LISTA_ESPERA);
		estadosParaExportacion.add(EstadoAlumno.LISTA_ESPERA_MATERIAS);
		estadosParaExportacion.add(EstadoAlumno.PRESELECCIONADO);
		estadosParaExportacion.add(EstadoAlumno.RECHAZADO);
		estadosParaExportacion.add(EstadoAlumno.APROBADO);	
		estadosParaExportacion.add(EstadoAlumno.ALTA_BECADO);
		estadosParaExportacion.add(EstadoAlumno.RENOVADO);
		estadosParaExportacion.add(EstadoAlumno.NO_RENOVADO);
		estadosParaExportacion.add(EstadoAlumno.INCORPORADO);
		estadosParaExportacion.add(EstadoAlumno.INCORPORACION_PENDIENTE);
		estadosParaExportacion.add(EstadoAlumno.NO_INCORPORADO);
		estadosParaExportacion.add(pendiente);
		estadosParaExportacion.add(enCondicionesDeRenovar);
		estadosParaExportacion.add(EstadoAlumno.EGRESADO);
		estadosParaExportacion.add(EstadoAlumno.CESADO);
	}
	
	/**
	 * Paginar alumnos.
	 *
	 * @param export the export
	 * @param request the request
	 * @return the extended paginated list
	 * @since 26-abr-2011
	 * @author cfigueroa
	 * @param ea 
	 * @param padrino 
	 * @param convocatoria 
	 * @param zona 
	 * @param estadoAlumno 
	 * @param nombreAlumno 
	 * @param adicional 
	 * @param anio 
	 * @param becadosActivos 
	 */
	private ExtendedPaginatedList paginarAlumnos(boolean export, HttpServletRequest request, EstadoAlumno estadoAlumno,
			ZonaCimientos zona, Convocatoria convocatoria, PerfilPadrino padrino, PerfilEA ea, String nombreAlumno,
			AnioEscolar anio, Boolean adicional, boolean becadosActivos, String eae, Escuela escuela, Long anioEgreso) {
		
		List<ExportarAlumnosDTO> dtos = null;
		
		ExtendedPaginatedList listaPaginada = paginateListFactory.getPaginatedListFromRequest(request);
		
		
		int totalRows = alumnoSrv.obtenerCantidadAlumnosExportar(estadoAlumno,zona,convocatoria,padrino,ea,nombreAlumno,anio,adicional,becadosActivos,eae, escuela);
		
		//Si es un export debo cargar toda la lista entera, si no lo es entonces se carga la lista de a una pagina por vez
		if(export){
			dtos = alumnoSrv.obtenerAlumnosExportar(0, totalRows,listaPaginada.getSortDirection(), listaPaginada.getSortCriterion(),
													estadoAlumno,zona,convocatoria,padrino,ea,nombreAlumno,anio,adicional,becadosActivos,eae, escuela);
		}else{
			dtos = alumnoSrv.obtenerAlumnosExportar(listaPaginada.getFirstRecordIndex(), 
													listaPaginada.getPageSize(),listaPaginada.getSortDirection(), 
													listaPaginada.getSortCriterion(),
													estadoAlumno,zona,convocatoria,padrino,ea,nombreAlumno,anio,adicional,becadosActivos,eae, escuela);
		}
		listaPaginada.setList(dtos);
		listaPaginada.setTotalNumberOfRows(totalRows);

		return listaPaginada;
	}
	
	@RequestMapping("/exportarAlumnos/exportarBoletines.do")
	public ModelAndView exportarBoletin(HttpServletRequest request, 
			@RequestParam(required=false,value="idEstadoAlumno")Integer idEstadoAlumno,
			@RequestParam(required=false,value="idAnioEscolar")Integer idAnioEscolar,
			@RequestParam(required=false,value="anioAdicional")String anioAdicional,
			@RequestParam(required=false,value="eae")String eae,
			@RequestParam(required=false,value="idZonaCimientos")Long idZonaCimientos,
			@RequestParam(required=false,value="idConvocatoria")Long idConvocatoria,
			@RequestParam(required=false,value="idPadrino")Long idPadrino,
			@RequestParam(required=false,value="idEa")Long idEa,
			@RequestParam(value="nombreAlumno",required=false) String nombreAlumno,
			@RequestParam(required=false, value="becadosActivos") boolean becadosActivos,
			@RequestParam("cicloNuevoId") Long cicloNuevoId){

		String excelView =  "exportarBoletinView";
		EstadoAlumno estadoAlumno = null;
		AnioEscolar anio = null;
		Boolean adicional = null;
		ZonaCimientos zona=null;
		Convocatoria convocatoria=null;
		PerfilPadrino padrino=null;
		PerfilEA ea=null;
		Integer estadoAlumnoId = idEstadoAlumno != null && idEstadoAlumno.equals(0) ? null : idEstadoAlumno;
		Integer idAnio = idAnioEscolar != null && idAnioEscolar.equals(0) ? null : idAnioEscolar;
		
		map = new HashMap<String, Object>();
		//Filtros de busqueda		
		map.put("becadosActivos", becadosActivos);		
		
		if(estadoAlumnoId != null){
			estadoAlumno= EstadoAlumno.getEstados(estadoAlumnoId);
			map.put("estado", estadoAlumno);
		}		
		if(idAnio != null){
			anio= AnioEscolar.getAnioEscolar(idAnio);
			map.put("anio", anio);
		}
		if(anioAdicional != null){
			adicional = generarAdicional(anioAdicional);
			map.put("adicional", adicional);
		}		
		if(idZonaCimientos != null){
			zona = zonaCimientosSrv.obtenerZonaCimientos(idZonaCimientos);
			map.put("zonaCimientos", zona);
		}
		if(idConvocatoria != null ){
			convocatoria = convocatoriaSrv.obtenerConvocatoriaPorId(idConvocatoria);
			map.put("convocatoria", convocatoria);
		}
		if(idPadrino != null ){
			padrino = padrinoSvr.obtenerPorId(idPadrino);
			map.put("padrino", padrino);
		}
		if(idEa != null){
			ea = eaSrv.obtenerPerfilEA(idEa);
			map.put("perfilEA",ea );
		}
		
		if(nombreAlumno != null){
			if(nombreAlumno == "")
				nombreAlumno=null;
			map.put("nombreAlumno", nombreAlumno);
		}

		CicloPrograma ciclo = cicloSrv.obtenerCiclo(cicloNuevoId);		
		map.put("alumnoSrv", alumnoSrv);
		map.put("ciclo", ciclo);
		map.put("eae", eae);
				
		LiberarMemoria lm = new LiberarMemoria();
		Thread tlm = new Thread(lm);
		tlm.start();
		
		return new ModelAndView(excelView,map);			
	}
	
	/**
	 * Lista alumno exportar.
	 *
	 * @param request the request
	 * @return the model and view
	 * @since 26-abr-2011
	 * @author cfigueroa
	 */
	@RequestMapping("/exportarAlumnos/reporteEventosGenericos.do")
	public ModelAndView reporteEventosGenericos(HttpServletRequest request,
											@RequestParam(required=false,value="idEstadoAlumno")Integer idEstadoAlumno,
											@RequestParam(required=false,value="idAnioEscolar")Integer idAnioEscolar,
											@RequestParam(required=false,value="anioAdicional")String anioAdicional,
											@RequestParam(required=false,value="idZonaCimientos")Long idZonaCimientos,
											@RequestParam(required=false,value="idConvocatoria")Long idConvocatoria,
											@RequestParam(required=false,value="idPadrino")Long idPadrino,
											@RequestParam(required=false,value="idEscuela")Long idEscuela,
											@RequestParam(required=false,value="idEa")Long idEa,
											@RequestParam(value="nombreAlumno",required=false) String nombreAlumno,
											@RequestParam(required=false, value="becadosActivos") boolean becadosActivos,
											@RequestParam(required= false, value="mensaje") String mensaje,
											@RequestParam(required= false, value="error") String error,
											@RequestParam(required= false, value="anioEgreso") Long anioEgreso){
		String eae="";
		boolean export = request.getParameter(TableTagParameters.PARAMETER_EXPORTING) != null;
		EstadoAlumno estadoAlumno = null;
		AnioEscolar anio = null;
		Boolean adicional = null;
		ZonaCimientos zona=null;
		Convocatoria convocatoria=null;
		PerfilPadrino padrino=null;
		PerfilEA ea=null;
		Escuela escuela=null;
		List<EstadoAlumno> estadosParaExportacion = new ArrayList<EstadoAlumno>();
		Integer estadoAlumnoId = idEstadoAlumno != null && idEstadoAlumno.equals(0) ? null : idEstadoAlumno;
		Integer idAnio = idAnioEscolar != null && idAnioEscolar.equals(0) ? null : idAnioEscolar;
		
		map = new HashMap<String, Object>();
		//Filtros de busqueda
		
		map.put("becadosActivos", becadosActivos);
		
		//System.out.println(becadosActivos);
		
		if(estadoAlumnoId != null){
			estadoAlumno= EstadoAlumno.getEstados(estadoAlumnoId);
			map.put("estado", estadoAlumno);
		}		
		if(idAnio != null){
			anio= AnioEscolar.getAnioEscolar(idAnio);
			map.put("anio", anio);
		}
		if(anioAdicional != null){
			adicional = generarAdicional(anioAdicional);
			map.put("adicional", anioAdicional);
		}		
		if(anioEgreso!=null){			
			map.put("anioEgreso", anioEgreso);
		}
		if(idZonaCimientos != null){
			zona = zonaCimientosSrv.obtenerZonaCimientos(idZonaCimientos);
			map.put("zonaCimientos", zona);
		}
		if(idConvocatoria != null ){
			convocatoria = convocatoriaSrv.obtenerConvocatoriaPorId(idConvocatoria);
			map.put("convocatoria", convocatoria);
		}
		if(idEscuela != null ){
			escuela = escuelaSrv.obtenerEscuelaPorId(idEscuela);
			map.put("escuela", escuela);
		}
		
		
		if(idPadrino != null ){
			padrino = padrinoSvr.obtenerPorId(idPadrino);
			map.put("padrino", padrino);
		}
		if(idEa != null){
			ea = eaSrv.obtenerPerfilEA(idEa);
			map.put("perfilEA",ea );
		}
		
		if(nombreAlumno != null){
			if(nombreAlumno == "")
				nombreAlumno=null;
			map.put("nombreAlumno", nombreAlumno);
		}
	
		ExtendedPaginatedList listaPaginada = paginarAlumnos(export, request,estadoAlumno,zona,convocatoria,
				padrino,ea,nombreAlumno,anio,adicional,becadosActivos, eae, escuela,anioEgreso);
		map.put("alumnos",listaPaginada);
		
		llenarComboEstadoAlumno(estadosParaExportacion);
		
		ArrayList<String> listaAdicional = generarListaAdicional();
		map.put("listAdicional", listaAdicional);
		map.put("listEstadoAlumnos",estadosParaExportacion);
		map.put("listAniosEscolares", AnioEscolar.getAnioEscolares());
		map.put("ciclos", cicloSrv.obtenerCiclosClonarBecas());
		map.put("urlRegreso", "/exportarAlumnos/listaAlumnosExportar.do");
		HttpSession session = request.getSession();
		session.setAttribute("menu", ConstantesMenu.menuExportacion);
		
		if(StringUtils.isNotBlank(mensaje))
			map.put("mensaje", mensaje);	
		
		if(StringUtils.isNotBlank(error))
			map.put("error", error);
		
		return forward("/exportarAlumnos/reporteEventosGenericos", map);
	}
		
	


}
