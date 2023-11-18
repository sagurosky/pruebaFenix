/**
 * 
 */
package org.cimientos.intranet.web.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.cimientos.intranet.modelo.Beca;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.Periodo;
import org.cimientos.intranet.modelo.Texto;
import org.cimientos.intranet.modelo.banco.Banco;
import org.cimientos.intranet.modelo.candidato.convocatoria.Convocatoria;
import org.cimientos.intranet.modelo.empresa.Empresa;
import org.cimientos.intranet.modelo.escuela.Escuela;
import org.cimientos.intranet.modelo.escuela.EscuelaSeleccion;
import org.cimientos.intranet.modelo.perfil.EstadoAlumno;
import org.cimientos.intranet.modelo.perfil.PerfilAlumno;
import org.cimientos.intranet.modelo.perfilEA.PerfilEA;
import org.cimientos.intranet.modelo.perfilPadrino.PerfilPadrino;
import org.cimientos.intranet.modelo.perfilRR.PerfilRR;
import org.cimientos.intranet.modelo.perfilTS.PerfilTS;
import org.cimientos.intranet.modelo.persona.Persona;
import org.cimientos.intranet.modelo.seleccion.EntrevistaSeleccion;
import org.cimientos.intranet.modelo.sucursalBanco.SucursalBanco;
import org.cimientos.intranet.modelo.ubicacion.Localidad;
import org.cimientos.intranet.modelo.ubicacion.Provincia;
import org.cimientos.intranet.modelo.ubicacion.ZonaCimientos;
import org.cimientos.intranet.servicio.AlumnoSrv;
import org.cimientos.intranet.servicio.BancoSrv;
import org.cimientos.intranet.servicio.BecaSvr;
import org.cimientos.intranet.servicio.CicloProgramaSrv;
import org.cimientos.intranet.servicio.ConvocatoriaSrv;
import org.cimientos.intranet.servicio.EmpresaSrv;
import org.cimientos.intranet.servicio.EntrevistaSeleccionSrv;
import org.cimientos.intranet.servicio.EscuelaSeleccionSrv;
import org.cimientos.intranet.servicio.EscuelaSrv;
import org.cimientos.intranet.servicio.LocalidadSrv;
import org.cimientos.intranet.servicio.PerfilEASrv;
import org.cimientos.intranet.servicio.PerfilPadrinoSvr;
import org.cimientos.intranet.servicio.PerfilRRSrv;
import org.cimientos.intranet.servicio.PerfilTSSrv;
import org.cimientos.intranet.servicio.PeriodoSrv;
import org.cimientos.intranet.servicio.PersonaSrv;
import org.cimientos.intranet.servicio.ProvinciaSrv;
import org.cimientos.intranet.servicio.RegistrarEscuelasBecasSrv;
import org.cimientos.intranet.servicio.SucursalBancoSrv;
import org.cimientos.intranet.servicio.TextoSrv;
import org.cimientos.intranet.servicio.ZonaCimientosSrv;
import org.cimientos.intranet.utils.Formateador;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cimientos.intranet.enumerativos.SituacionEscolarMergeada;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionRenovacionFinal;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionRenovacionMergeada;
import com.cimientos.intranet.enumerativos.entrevista.MotivoNoRenovacion;
import com.cimientos.intranet.enumerativos.entrevista.MotivoPendiente;



// TODO: Auto-generated Javadoc
/**
 * The Class AjaxController.
 *
 * @author plabaronnie
 */
@Controller
@RequestMapping("/ajax/*")
public class AjaxController {
	
	/** The Constant log. */
	private static final Logger log = Logger.getLogger(AjaxController.class);
	
	/** The empresa srv. */
	@Autowired
	public EmpresaSrv empresaSrv;
	
	/** The srv persona. */
	@Autowired
	public PersonaSrv srvPersona;
	
	/** The periodo srv. */
	@Autowired
	public PeriodoSrv periodoSrv;

	/** The srv zona. */
	@Autowired
	public ZonaCimientosSrv srvZona;
	
	/** The srv localidad. */
	@Autowired
	public LocalidadSrv srvLocalidad;
		
	/** The padrino svr. */
	@Autowired
	public PerfilPadrinoSvr padrinoSvr;
	
	/** The escuela svr. */
	@Autowired
	public RegistrarEscuelasBecasSrv escuelaSvr;
	
	/** The beca svr. */
	@Autowired
	public BecaSvr becaSvr;

	/** The escuela service. */
	@Autowired
	public EscuelaSrv escuelaService;
	
	/** The alumno srv. */
	@Autowired
	public AlumnoSrv alumnoSrv;
	
	/** The sucursal service. */
	@Autowired
	public SucursalBancoSrv sucursalService;
	
	/** The entrevista seleccion srv. */
	@Autowired
	private EntrevistaSeleccionSrv entrevistaSeleccionSrv;
	
	/** The srv perfil ea. */
	@Autowired
	private PerfilEASrv srvPerfilEa;

	/** The banco srv. */
	@Autowired
	private BancoSrv bancoSrv;
	
	/** The persona srv. */
	@Autowired
	private PersonaSrv personaSrv;
	
	/** The convocatoria srv. */
	@Autowired
	private ConvocatoriaSrv convocatoriaSrv;
	
	/** The rr svr. */
	@Autowired
	private PerfilRRSrv rrSvr;
	
	/** The escuela seleccion srv. */
	@Autowired
	private EscuelaSeleccionSrv escuelaSeleccionSrv; 
	
	/** The perfil ts srv. */
	@Autowired
	private PerfilTSSrv perfilTSSrv;
		
	@Autowired
	private ProvinciaSrv provinciaSrv;
	
	@Autowired
	private TextoSrv textoSrv;
	
	@Autowired
	private CicloProgramaSrv cicloSrv;
	
	/**
	 * Busca una empresa en base a su cuil. Este metodo se utiliza en la vista
	 * para verificar que el cuit ingresado pertenezca a una empresa persistida
	 * en la BD y que en caso de que no exista se abra un popup de alta de empresa.
	 *
	 * @param request el request
	 * @param response el response
	 * @param cuit el cuit de la empresa
	 * @since 30-dic-2010
	 * @author plabaronnie
	 */
    @RequestMapping("/ajax/validarCuitEmpresa.do")
    public void buscarEmpresa(HttpServletRequest request,HttpServletResponse response, 
    		@RequestParam(required=false, value="cuit_cuil") String cuit) {
		JSONObject object = new JSONObject();
		boolean existe = true;
		cuit=Formateador.formatearCuilSinGuiones(cuit);
    	if(StringUtils.isNotBlank(cuit) && StringUtils.isNumeric(cuit)){
    		cuit=Formateador.formatearCuilSinGuiones(cuit);
    		Empresa empresa = empresaSrv.buscarPorCUIT(cuit);
    		existe = empresa != null;
    	}
		try {
			object.put("existeEmpresa", existe );	
			response.setContentType("application/json");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("ISO-8859-1");
			response.getWriter().write(object.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}

    }
        
    /**
     * Busca una persona en base a su cuil. Este metodo se utiliza en la vista
     * para verificar que el cuil ingresado pertenezca a una persona persistida
     * en la BD y que en caso de que no exista se abra un popup de alta de persona.
     *
     * @param request el request
     * @param response el response
     * @param cuil el cuil de la persona
     * @since 30-dic-2010
     * @author plabaronnie
     */
    @RequestMapping("/ajax/validarCuilPersona.do")
    public void buscarPersona(HttpServletRequest request,HttpServletResponse response, 
    		@RequestParam(required=false, value="cuit_cuil") String cuil) {
		JSONObject object = new JSONObject();
		boolean existe = true;
		cuil=Formateador.formatearCuilSinGuiones(cuil);
    	if(StringUtils.isNotBlank(cuil) && StringUtils.isNumeric(cuil)){
    		cuil=Formateador.formatearCuilSinGuiones(cuil);
    		Persona persona = srvPersona.buscarPorCuil(cuil);
    		existe = persona != null;
    	}
		try {
			object.put("existePersona", existe );	
			response.setContentType("application/json");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("ISO-8859-1");
			response.getWriter().write(object.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}

    }
    
    /**
     * Buscar escuela.
     *
     * @param response the response
     * @param texto the texto
     * @throws JSONException the jSON exception
     * @since 26-abr-2011
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarEscuelaZona.do")
    public void buscarEscuela(
    		HttpServletResponse response,
    		@RequestParam("name_startsWith") String texto
    		) throws JSONException{
    	
    	JSONObject jSon = new JSONObject();
    	JSONArray escuelas = new JSONArray();
		List<Escuela> escuelasBD = new ArrayList<Escuela>();
    		 escuelasBD = escuelaService.getPorNombreConAjax(texto);
    	
    	if(escuelasBD.isEmpty()){
    		JSONObject escuelaObj = new JSONObject();
    		escuelaObj.put("nombre","no hay datos");
    		escuelaObj.put("localidad", "no hay datos ");
			escuelas.put(escuelaObj);
    	}else{
    		for (Escuela escuela : escuelasBD) {
    			JSONObject escuelaObj = new JSONObject();
    			escuelaObj.put("nombre", escuela.getNombre());
    			escuelaObj.put("id", escuela.getId());
    			
    			escuelaObj.put("localidad", escuela.getLocalidad().getNombre());
    			escuelaObj.put("zona", escuela.getZonaCimientos().getNombre());
    			escuelaObj.put("idZona", escuela.getZonaCimientos().getId());
    			escuelaObj.put("eae", escuela.getZonaCimientos().getEae());
    			
    			escuelas.put(escuelaObj);
			}
    	}
    	
    	jSon.put("escuelas", escuelas);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}

    }
    
      
    /**
     * Retorna la lista de localidades.
     * Este metodo se utiliza autocompletar las localidades
     *
     * @param response the response
     * @param texto the texto
     * @param cantidadMax the cantidad max
     * @throws JSONException the jSON exception
     * @since 30-dic-2010
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarLocalidadPorNombre.do")
	public void buscarLocalidad(HttpServletResponse response,
			@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException {
		JSONObject jSon = new JSONObject();
		JSONArray localidades = new JSONArray();
		List<Localidad> localidadesBD= srvLocalidad.getPorNombreConAjax(texto, cantidadMax);

		for (Localidad localidad : localidadesBD)
		{
			
			JSONObject localidadObj = new JSONObject();
			localidadObj.put("nombre", localidad.getNombre());
			localidadObj.put("id", localidad.getId());
			try{
				localidadObj.put("nombreZona", localidad.getZona().getNombre());
				localidadObj.put("idZona", localidad.getZona().getId());
				localidadObj.put("nombreProvincia", localidad.getProvincia().getDescripcion());
				localidadObj.put("idProvincia", localidad.getProvincia().getId());
				localidades.put(localidadObj);
			
			}catch(NullPointerException e){
				localidadObj.put("nombre", localidad.getNombre() + " debe tener asociada una provincia y/o zona");
				localidades.put(localidadObj);
			}
		}

		jSon.put("localidades", localidades);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}

	}
    
    
    
    /**
     * Retorna la lista de zonas.
     * Este metodo se utiliza para autocompletar las zonas
     *
     * @param response the response
     * @param texto the texto
     * @throws JSONException the jSON exception
     * @since 30-dic-2010
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarZonaPorNombre.do")
	public void buscarZona(HttpServletResponse response,
			@RequestParam("name_startsWith") String texto) throws JSONException {
		JSONObject jSon = new JSONObject();
		JSONArray zonas = new JSONArray();
		List<ZonaCimientos> zonasBD = srvZona.getPorNombreConAjax(texto);
		
		if(zonasBD != null){
			for (ZonaCimientos zona : zonasBD)
			{
				JSONObject zonaObj = new JSONObject();
				zonaObj.put("nombre", zona.getNombre());
				zonaObj.put("id", zona.getId());
				
				zonas.put(zonaObj);
			}
		}else{
			JSONObject zonaObj = new JSONObject();
			zonaObj.put("nombre", "no hay datos");
			zonaObj.put("id", "");
			
			zonas.put(zonaObj);
		}
		
		jSon.put("zonas", zonas);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}

	}
    
    /**
     * Retorna la lista de colegios de una zona.
     * Este metodo se utiliza para completar un combo de colegios
     *
     * @param response the response
     * @param idZona the id zona
     * @throws JSONException the jSON exception
     * @since 30-dic-2010
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarColegiosZona.do")
	public void buscarColegiosZona(HttpServletResponse response,
			@RequestParam("idZona") long idZona,
			@RequestParam("name_startsWith") String texto) throws JSONException {
		
    	JSONObject jSon = new JSONObject();
		JSONArray escuelas = new JSONArray();
		
		List<Escuela> escuelasBD =  srvZona.getEscuelasZonaConAjax(idZona, texto);
		
		jSon.put("idZona", idZona);
		
		for (Escuela zona : escuelasBD)
		{
			JSONObject zonaObj = new JSONObject();
			zonaObj.put("nombre", zona.getNombre());
			zonaObj.put("id", zona.getId());
			
			escuelas.put(zonaObj);
		}

		jSon.put("escuelas", escuelas);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}

	}
    
    /**
     * Este metodo obtiene la lista de periodos correspondientes
     * al ciclo pasado por parametro. Se utiliza en la vista para
     * cargar el combo de periodos correspondientes a un ciclo
     * de manera asincronica luego que el usuario ha seleccionado un ciclo.
     *
     * @param request el request
     * @param response el response
     * @param idCiclo el id del ciclo
     * @since 30-dic-2010
     * @author plabaronnie
     */
    @RequestMapping("/ajax/obtenerListaPeriodos.do")
    public void obtenerListaPeriodos(HttpServletRequest request,HttpServletResponse response, 
    		@RequestParam(required=false, value="idCiclo") Long idCiclo) {
		try {
			JSONObject jSon = new JSONObject();
			JSONArray periodos = new JSONArray();
			List<Periodo> periodosPorCiclo = periodoSrv.buscarPeriodosPorCiclo(idCiclo);

			for (Periodo periodo : periodosPorCiclo) {
				JSONObject periodoObj = new JSONObject();
				periodoObj.put("nombre", periodo.getNombre());
				periodoObj.put("fechaInicio", periodo.getFechaInicio());
				periodoObj.put("fechaFin", periodo.getFechaFin());
				periodoObj.put("id", periodo.getId());
				periodos.put(periodoObj);
			}

			jSon.put("periodos", periodos);
			response.setContentType("application/json");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("ISO-8859-1");
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}

    }
    
    /**
     * Obtener evaluacion renovacion.
     *
     * @param request the request
     * @param response the response
     * @param idSituacionEscolar the id situacion escolar
     * @since 26-abr-2011
     * @author cfigueroa
     */
    @RequestMapping("/ajax/obtenerEvaluacionRenovacion.do")
    public void obtenerEvaluacionRenovacion(HttpServletRequest request,HttpServletResponse response, 
    		@RequestParam(required=false, value="idSituacionEscolar") Long idSituacionEscolar) {
		try {
			JSONObject jSon = new JSONObject();
			JSONArray evaluaciones = new JSONArray();
			
			/*	if (idSituacionEscolar == 3){
				JSONObject evaluacionObj = new JSONObject();
				evaluacionObj.put("valor", EvaluacionRenovacion.NORENUEVA.getValor());
				evaluacionObj.put("id", EvaluacionRenovacion.NORENUEVA.getId());
				evaluaciones.put(evaluacionObj);
			
			}else */
			
			//Antes SituacionEscolar		 ->PENDIENTE(4,"Pendiente")
			//Ahora SituacionEscolarMergeada ->PENDIENTE(2,"Pendiente") 
//			if (idSituacionEscolar == 4){
			if (SituacionEscolarMergeada.getSituacionEscolar(idSituacionEscolar.intValue()) == SituacionEscolarMergeada.PENDIENTE){
				JSONObject evaluacionObj = new JSONObject();
				evaluacionObj.put("valor", EvaluacionRenovacionMergeada.PENDIENTE.getValor());
				evaluacionObj.put("id", EvaluacionRenovacionMergeada.PENDIENTE.getId());
				evaluaciones.put(evaluacionObj);
				JSONObject evaluacionObj2 = new JSONObject();
				evaluacionObj2.put("valor", EvaluacionRenovacionMergeada.NO_RENUEVA.getValor());
				evaluacionObj2.put("id", EvaluacionRenovacionMergeada.NO_RENUEVA.getId());
				evaluaciones.put(evaluacionObj2);
				JSONObject evaluacionObj3 = new JSONObject();
				evaluacionObj3.put("valor", EvaluacionRenovacionMergeada.COVID.getValor());
				evaluacionObj3.put("id", EvaluacionRenovacionMergeada.COVID.getId());
				evaluaciones.put(evaluacionObj3);
				
			}else{
					JSONObject evaluacionObj = new JSONObject();
					evaluacionObj.put("valor", EvaluacionRenovacionMergeada.RENUEVA.getValor());
					evaluacionObj.put("id", EvaluacionRenovacionMergeada.RENUEVA.getId());
					evaluaciones.put(evaluacionObj);
					JSONObject evaluacionObj2 = new JSONObject();
					evaluacionObj2.put("valor", EvaluacionRenovacionMergeada.PENDIENTE.getValor());
					evaluacionObj2.put("id", EvaluacionRenovacionMergeada.PENDIENTE.getId());
					evaluaciones.put(evaluacionObj2);
					JSONObject evaluacionObj3 = new JSONObject();
					evaluacionObj3.put("valor", EvaluacionRenovacionMergeada.NO_RENUEVA.getValor());
					evaluacionObj3.put("id", EvaluacionRenovacionMergeada.NO_RENUEVA.getId());
					evaluaciones.put(evaluacionObj3);
			}

			jSon.put("evaluaciones", evaluaciones);
			response.setContentType("application/json");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("ISO-8859-1");
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}

    }    
 

    /**
     * Obtener evaluacion renovacion final.
     */
    @RequestMapping("/ajax/obtenerEvaluacionRenovacionFinal.do")
    public void obtenerEvaluacionRenovacionFinal(HttpServletRequest request,HttpServletResponse response, 
    		@RequestParam(required=false, value="idResultadoAnioEscolar") Long idresultadoAnioEscolar,
    		@RequestParam(required=false, value="ultimoAnio") String ultimoAnio) {
			//System.out.println(idresultadoAnioEscolar);
			//System.out.println(ultimoAnio);
    	try {
			JSONObject jSon = new JSONObject();
			JSONArray evaluaciones = new JSONArray();
			
			if(idresultadoAnioEscolar != null){			
				if (idresultadoAnioEscolar == 4 || idresultadoAnioEscolar == 6){
					//Opcion "egreso"
					JSONObject evaluacionObj = new JSONObject();
					evaluacionObj.put("valor", EvaluacionRenovacionFinal.FIN_PARTICIPACION_PFE.getValor());
					evaluacionObj.put("id", EvaluacionRenovacionFinal.FIN_PARTICIPACION_PFE.getId());
					evaluaciones.put(evaluacionObj);
				}
				else 
					if (idresultadoAnioEscolar == 2){
						//Opcion "pendiente"
						if(ultimoAnio.equals("false")){							
							JSONObject evaluacionObj = new JSONObject();
							evaluacionObj.put("valor", EvaluacionRenovacionFinal.PENDIENTE.getValor());
							evaluacionObj.put("id", EvaluacionRenovacionFinal.PENDIENTE.getId());
							evaluaciones.put(evaluacionObj);
							JSONObject evaluacionObj2 = new JSONObject();
							evaluacionObj2.put("valor", EvaluacionRenovacionFinal.NO_RENUEVA.getValor());
							evaluacionObj2.put("id", EvaluacionRenovacionFinal.NO_RENUEVA.getId());
							evaluaciones.put(evaluacionObj2);
							JSONObject evaluacionObj3 = new JSONObject();
							evaluacionObj3.put("valor", EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getValor());
							evaluacionObj3.put("id", EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getId());
							evaluaciones.put(evaluacionObj3);
						}
						else{							
							JSONObject evaluacionObj3 = new JSONObject();
							evaluacionObj3.put("valor", EvaluacionRenovacionFinal.FIN_PARTICIPACION_PFE.getValor());
							evaluacionObj3.put("id", EvaluacionRenovacionFinal.FIN_PARTICIPACION_PFE.getId());
							evaluaciones.put(evaluacionObj3);				
						}
					}
					else 
						if (idresultadoAnioEscolar == 3){
							//Opcion "repitio"
							JSONObject evaluacionObj = new JSONObject();
							evaluacionObj.put("valor", EvaluacionRenovacionFinal.PENDIENTE.getValor());
							evaluacionObj.put("id", EvaluacionRenovacionFinal.PENDIENTE.getId());
							evaluaciones.put(evaluacionObj);
							JSONObject evaluacionObj2 = new JSONObject();
							evaluacionObj2.put("valor", EvaluacionRenovacionFinal.NO_RENUEVA.getValor());
							evaluacionObj2.put("id", EvaluacionRenovacionFinal.NO_RENUEVA.getId());
							evaluaciones.put(evaluacionObj2);
						}
						else{
							//Opcion "promovido"
							JSONObject evaluacionObj = new JSONObject();
							evaluacionObj.put("valor", EvaluacionRenovacionFinal.PENDIENTE.getValor());
							evaluacionObj.put("id", EvaluacionRenovacionFinal.PENDIENTE.getId());
							evaluaciones.put(evaluacionObj);
							JSONObject evaluacionObj2 = new JSONObject();
							evaluacionObj2.put("valor", EvaluacionRenovacionFinal.NO_RENUEVA.getValor());
							evaluacionObj2.put("id", EvaluacionRenovacionFinal.NO_RENUEVA.getId());
							evaluaciones.put(evaluacionObj2);
							JSONObject evaluacionObj3 = new JSONObject();
							evaluacionObj3.put("valor", EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getValor());
							evaluacionObj3.put("id", EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getId());
							evaluaciones.put(evaluacionObj3);
						}
			}

			jSon.put("evaluaciones", evaluaciones);
			response.setContentType("application/json");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("ISO-8859-1");
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}

    } 
    
	/**
	 * Buscar padrinos.
	 *
	 * @param response the response
	 * @param texto the texto
	 * @param cantidadMax the cantidad max
	 * @throws JSONException the jSON exception
	 * @since 30-dic-2010
	 * @author plabaronnie
	 */
	@RequestMapping("/ajax/buscarPadrinosPorNombre.do")
	public void buscarPadrinos(HttpServletResponse response,
			@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException {
		JSONObject jSon = new JSONObject();
		JSONArray padrinos = new JSONArray();
		List<PerfilPadrino> padrinosBD = padrinoSvr.buscarPorNombreDenominacion(texto,
				cantidadMax);

		for (PerfilPadrino padrino : padrinosBD) {
			JSONObject padrinoObj = new JSONObject();
			String nombre = null;
			if(padrino.getEmpresa() != null){
				nombre = padrino.getEmpresa().getDenominacion();
			}else if(padrino.getDatosPersonales() != null){
				nombre = padrino.getDatosPersonales().getApellido()+ ", "
				+ padrino.getDatosPersonales().getNombre();
			}
			padrinoObj.put("nombre", nombre);
			padrinoObj.put("id", padrino.getId());
			padrinos.put(padrinoObj);
		}

		jSon.put("padrinos", padrinos);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

    /**
     * Retorna la lista de colegios por nombre
     * Este metodo se utiliza para completar un combo de colegios.
     *
     * @param response the response
     * @param texto the texto
     * @param cantidadMax the cantidad max
     * @throws JSONException the jSON exception
     * @since 30-dic-2010
     * @author plabaronnie
     */
    @RequestMapping("/ajax/buscarEscuelasPorNombre.do")
	public void buscarEscuelaPorNombre(HttpServletResponse response,
			@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException {
		JSONObject jSon = new JSONObject();
		JSONArray escuelas = new JSONArray();
		List<Escuela> escuelasDB= escuelaSvr.getPorNombreConAjax(texto, cantidadMax);

		for (Escuela escuela : escuelasDB)
		{
			JSONObject escuelaObj = new JSONObject();
			escuelaObj.put("nombre", escuela.getNombre());
			escuelaObj.put("id", escuela.getId());
			String label = escuela.getNombre();
			if(escuela.getLocalidad() != null && escuela.getLocalidad().getZona()!= null){
				escuelaObj.put("zona", escuela.getLocalidad().getZona().getNombre());
				label = label + " / " + escuela.getLocalidad().getZona().getNombre();
			}
			escuelaObj.put("labelEscuelaZona", label); 
			escuelas.put(escuelaObj);
		}

		jSon.put("escuelas", escuelas);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}

	}
    
    /**
     * Buscar becas cesadas disponer egreso.
     *
     * @param response the response
     * @param idZona the id zona
     * @param idPeriodo the id periodo
     * @return the string
     * @throws JSONException the jSON exception
     * @since 30-dic-2010
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarBecasCesadasDisponerEgreso")
  
    public void buscarBecasCesadasDisponerEgreso(HttpServletResponse response,
    											   @RequestParam("idZona") Long idZona,
    											   @RequestParam("idPeriodo")Long idPeriodo) throws JSONException{
		JSONObject jSon = new JSONObject();
		
		jSon.put("becasCesadas",becaSvr.obtenerBecasCesadasPorZona(idPeriodo, idZona));
		jSon.put("becasADisponerEgreso",becaSvr.obtenerBecasUltimoAnioEscolarPorZona(idPeriodo, idZona));
		
		//becasArray.put(becaJson);
		
		//jSon.put("becas", becasArray);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
    
   	/**
	    * Este metodo lo que busca si alumno tiene una entrevista seleccion
	    * lo busca por el dni.
	    *
	    * @param response the response
	    * @param dni the dni
	    * @return the string
	    * @throws JSONException the jSON exception
	    * @since 17-ene-2011
	    * @author cfigueroa
   	 * @throws SQLException 
	    */
	@RequestMapping("/ajax/buscarAlumnoEntrevistaSeleccion.do")

    public void buscarAlumnoEntrevistaSeleccion(HttpServletResponse response,
    	@RequestParam("dni") Integer dni) throws JSONException, SQLException{
		JSONObject jSon = new JSONObject();
		EntrevistaSeleccion entrevistaSeleccion = entrevistaSeleccionSrv.obtenerEntrevistaPorDniAlumno(dni);
		Boolean puedeCargarEntrevista = true;
		//Boolean dniExistePersona = false;
		
			
		
		if(entrevistaSeleccion != null)
		{
			PerfilAlumno alumno = alumnoSrv.obtenerAlumno(entrevistaSeleccion.getIdPerfilAlumno());
			if(!alumno.getEstadoAlumno().equals(EstadoAlumno.APROBADO) && !alumno.getEstadoAlumno().equals(EstadoAlumno.RECHAZADO) &&
			   !alumno.getEstadoAlumno().equals(EstadoAlumno.LISTA_ESPERA) && !alumno.getEstadoAlumno().equals(EstadoAlumno.LISTA_ESPERA_MATERIAS) &&
			   !alumno.getEstadoAlumno().equals(EstadoAlumno.PRESELECCIONADO))
					puedeCargarEntrevista = false;
		}
		if(entrevistaSeleccion == null){
			/*
			if(srvPersona.buscarPorDNI(dni) != null){
				//model.put("error", "Esta persona ya tiene asignado un usuario");
				//model.put("zonas", srvZona.obtenerTodos());
				//return forward("/usuario/altaUsuarioView", model);
				////System.out.println("existe");
				//dniExistePersona=true;
				jSon.put("dniExistePersona", new Boolean(true));
			}else{
				jSon.put("dniExistePersona", new Boolean(false));
			}
			*/
			jSon.put("entrevistaSeleccion", new Boolean(false));
			
		}else{
			jSon.put("entrevistaSeleccion", new Boolean(true));
			jSon.put("id", entrevistaSeleccion.getId());
		}
		
		
		String url = "jdbc:mysql://localhost/cimientos_prod";
		Connection cn = DriverManager.getConnection(url,"root","root");
		Statement stmt = cn.createStatement();
        ResultSet rs = null;
        String call=null;
        call="Select id from persona_seleccion where dni='" + dni +"'" ;
        cn = Conexion.getConexion();	            
        rs = stmt.executeQuery(call);					
		String existePersonaSeleccion="";
		String existePersona="";
        while ( rs.next() ) {
        	existePersonaSeleccion="si";
            //System.out.println("IdPersona: "+rs.getLong("id"));                
        }		
        call="Select id from persona where dni='" + dni +"'" ;
        cn = Conexion.getConexion();	            
        rs = stmt.executeQuery(call);							
        while ( rs.next() ) {
        	existePersona="si";
            //System.out.println("IdPersona: "+rs.getLong("id"));                
        }	        
        Conexion.cerrarConexion(cn);
		if(existePersonaSeleccion.equals("si") || existePersona.equals("si") ){
			//System.out.println("ESTOY EN AJAX CONTROLLER: existe DNI "+ dni +" EN LA BASE DE DATOS !!!!");
			//dniExistePersona=true;
			jSon.put("dniExistePersona", new Boolean(true));
		}else{
			//System.out.println("ESTOY EN AJAX CONTROLLER: NO existe DNI "+ dni +" EN LA BASE DE DATOS !!!!");
			jSon.put("dniExistePersona", new Boolean(false));
		}
		jSon.put("puedeCargarEntrevista", puedeCargarEntrevista);
		//jSon.put("dniExistePersona", dniExistePersona);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    
    /**
     * Este metodo obtiene la lista de sucursales correspondientes
     * al banco pasado por parametro. Se utiliza en la vista para
     * cargar el combo de sucursales correspondientes a un banco
     * de manera asincronica luego que el usuario ha seleccionado un banco.
     *
     * @param request el request
     * @param response el response
     * @param idBanco the id banco
     * @since 30-dic-2010
     * @author plabaronnie
     */
    @RequestMapping("/ajax/obtenerListaSucursales.do")
    public void obtenerListaSucursales(HttpServletRequest request,HttpServletResponse response, 
    		@RequestParam(required=false, value="idBanco") Long idBanco) {
		try {
			JSONObject jSon = new JSONObject();
			JSONArray sucursalesAjax = new JSONArray();
			List<SucursalBanco> sucursales = sucursalService.buscarSucursalesPorBanco(idBanco);

			for (SucursalBanco sucursal : sucursales) {
				JSONObject sucursalObj = new JSONObject();
				sucursalObj.put("direccion", sucursal.getDireccion());
				sucursalObj.put("id", sucursal.getId());
				sucursalesAjax.put(sucursalObj);
			}

			jSon.put("sucursales", sucursalesAjax);
			response.setContentType("application/json");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("ISO-8859-1");
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}

    }
    
    /**
     * Buscar sucursal banco por zona.
     *
     * @param response the response
     * @param idZona the id zona
     * @return the string
     * @throws JSONException the jSON exception
     * @since 28-ene-2011
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarSucursalBancoPorZona.do")

    public void buscarSucursalBancoPorZona(HttpServletResponse response,@RequestParam("idZona")Long idZona ) throws JSONException{
    	JSONObject jSon = new JSONObject();
    	JSONArray sucursalesAjax = new JSONArray();
    	List<SucursalBanco> sucursalBancos = sucursalService.obtenerSucursalPorZona(idZona);
    	for (SucursalBanco sucursalBanco : sucursalBancos) {
    		JSONObject sucursalObj = new JSONObject();
			sucursalObj.put("id",sucursalBanco.getId());
			sucursalObj.put("nombre",sucursalBanco.getNombre());
			sucursalObj.put("banco",sucursalBanco.getBanco().getNombre());
			sucursalObj.put("zona",sucursalBanco.getZona().getNombre());
			sucursalObj.put("eae",sucursalBanco.getZona().getEae());
			sucursalesAjax.put(sucursalObj);
		}
    	jSon.put("sucursales",sucursalesAjax);
    	response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }


    /**
     * Obtener personas sin usuario.
     *
     * @param response the response
     * @param nombre the nombre
     * @since 26-abr-2011
     * @author cfigueroa
     */
    @RequestMapping("/ajax/obtenerPersonasSinUsuario.do")
    public void obtenerPersonasSinUsuario(HttpServletResponse response, @RequestParam("persona") String nombre) {
		try {
			JSONObject jSon = new JSONObject();
			JSONArray personaList = new JSONArray();
			List<Persona> personas = personaSrv.buscarPorNombre(nombre);
			for (Persona persona : personas) {
				JSONObject personaObj = new JSONObject();
				personaObj.put("nombre", persona.getApellido()+","+persona.getNombre());
				personaObj.put("id", persona.getId());
				personaList.put(personaObj);	
			}
			

			jSon.put("personas", personaList);
			response.setContentType("application/json");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("ISO-8859-1");
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}

    }
    
    /**
     * Retorna la lista de colegios por nombre
     * Este metodo se utiliza para completar un combo de colegios.
     *
     * @param response the response
     * @param texto the texto
     * @param cantidadMax the cantidad max
     * @param idEA the id ea
     * @throws JSONException the jSON exception
     * @since 30-dic-2010
     * @author plabaronnie
     */
    @RequestMapping("/ajax/buscarEscuelaPorEA.do")
	public void buscarEscuelaPorEA(HttpServletResponse response,
			@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax, 
			@RequestParam("idEA")Long idEA) throws JSONException {
		JSONObject jSon = new JSONObject();
		JSONArray escuelas = new JSONArray();
		PerfilEA ea = srvPerfilEa.obtenerPerfilEA(idEA);
		List<Escuela> escuelasDB= escuelaSvr.getPorEAyNombre(texto, cantidadMax, ea);

		for (Escuela escuela : escuelasDB)
		{
			JSONObject escuelaObj = new JSONObject();
			escuelaObj.put("nombre", escuela.getNombre());
			escuelaObj.put("id", escuela.getId());
			String label = escuela.getNombre();
			if(escuela.getLocalidad() != null && escuela.getLocalidad().getZona()!= null){
				escuelaObj.put("zona", escuela.getLocalidad().getZona().getNombre());
				label = label + " / " + escuela.getLocalidad().getZona().getNombre();
			}
			escuelaObj.put("labelEscuelaZona", label); 
			escuelas.put(escuelaObj);
		}

		jSon.put("escuelas", escuelas);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}

	}
    
    /**
     * Buscar bancos por nombre.
     *
     * @param response the response
     * @param texto the texto
     * @param cantidadMax the cantidad max
     * @throws JSONException the jSON exception
     * @since 26-abr-2011
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarBancosPorNombre.do")
	public void buscarBancosPorNombre(HttpServletResponse response,
			@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException {
		JSONObject jSon = new JSONObject();
		JSONArray bancos = new JSONArray();
		List<Banco> bancosDB= bancoSrv.obtenerBancosPorNombre(texto);

		for (Banco banco : bancosDB)
		{
			JSONObject bancoObj = new JSONObject();
			bancoObj.put("nombre", banco.getNombre());
			bancoObj.put("id", banco.getId());
			bancos.put(bancoObj);
		}

		jSon.put("bancos", bancos);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}

	}
    
    /**
     * Buscar sucursal por banco id.
     *
     * @param response the response
     * @param bancoID the banco id
     * @throws JSONException the jSON exception
     * @since 26-abr-2011
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarSucursalPorBancoID.do")
	public void buscarSucursalPorBancoID(HttpServletResponse response,
			@RequestParam("bancoID") Long bancoID) throws JSONException {
		
    	Banco bancoBD = bancoSrv.obtenerBanco(bancoID);
    	List<SucursalBanco> sucursalesDB= bancoBD.getSucursales();
    	
    	JSONObject jSon = new JSONObject();
		JSONArray sucursales = new JSONArray();

		for (SucursalBanco sucursal : sucursalesDB)
		{
			JSONObject sucursalObj = new JSONObject();
			sucursalObj.put("nombre", sucursal.getNombre());
			sucursalObj.put("id", sucursal.getId());
			sucursales.put(sucursalObj);
		}

		jSon.put("sucursales", sucursales);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}

	}
    
    /**
     * Buscar eas por zona.
     *
     * @param response the response
     * @param idZona the id zona
     * @param texto the texto
     * @param cantidadMax the cantidad max
     * @return the string
     * @throws JSONException the jSON exception
     * @since 26-abr-2011
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarEasPorZonaYNombre.do")
   
    public void buscarEasPorZonaYNombre(HttpServletResponse response,@RequestParam("idZona") Long idZona,
    		@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException{
    	
    	JSONObject jSon = new JSONObject();
    	JSONArray easAjax = new JSONArray();
    	ZonaCimientos zona = srvZona.obtenerZonaCimientos(idZona);
    	List<PerfilEA> eas = srvPerfilEa.obtenerEasPorNombreYZona(zona, texto,cantidadMax);
    	if(eas.isEmpty()){
    		JSONObject eaObj = new JSONObject();
    		eaObj.put("id",0);
    		eaObj.put("nombre","no hay EAS para la zona cargada");
    		easAjax.put(eaObj);
    	}
    	for (PerfilEA ea : eas) {
    		JSONObject eaObj = new JSONObject();
    		eaObj.put("id",ea.getIdPerfilEA());
    		eaObj.put("nombre",ea.getDatosPersonales().getApellido() +","+ea.getDatosPersonales().getNombre());
    		easAjax.put(eaObj);
		}
    	jSon.put("json",easAjax);
    	response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    //DMS 18/8/23 agrego funcion para filtrar por eas sin depender de zona
    
    @RequestMapping("/ajax/buscarEasPorNombre.do")
    
    public void buscarEasPorNombre(HttpServletResponse response,
    		@RequestParam("name_startsWith") String texto,
    		@RequestParam("maxRows") int cantidadMax) throws JSONException{
    	JSONObject jSon = new JSONObject();
    	JSONArray easAjax = new JSONArray();
    	List<PerfilEA> eas = srvPerfilEa.obtenerEAsPorNombre(texto);
    	if(eas.isEmpty()){
    		JSONObject eaObj = new JSONObject();
    		eaObj.put("id",0);
    		eaObj.put("nombre","no hay EAS para la zona cargada");
    		easAjax.put(eaObj);
    	}
    	for (PerfilEA ea : eas) {
    		JSONObject eaObj = new JSONObject();
    		eaObj.put("id",ea.getIdPerfilEA());
    		eaObj.put("nombre",ea.getDatosPersonales().getApellido() +","+ea.getDatosPersonales().getNombre());
    		easAjax.put(eaObj);
    	}
    	jSon.put("json",easAjax);
    	response.setContentType("application/json");
    	response.setHeader("Cache-Control", "no-cache");
    	response.setCharacterEncoding("ISO-8859-1");
    	try {
    		response.getWriter().write(jSon.toString());
    	} catch (IOException e) {
    		// TODO Auto-generated catch block
    		e.printStackTrace();
    	}
    }
    
    /**
     * Buscar convocatoria por zona.
     *
     * @param response the response
     * @param idZona the id zona
     * @param texto the texto
     * @param cantidadMax the cantidad max
     * @return the string
     * @throws JSONException the jSON exception
     * @since 26-abr-2011
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarConvocatoriaPorZonaYNombre.do")
   
    public void buscarConvocatoriaPorZona(HttpServletResponse response,@RequestParam("idZona") Long idZona,
    		@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException{
    	
    	JSONObject jSon = new JSONObject();
    	JSONArray easAjax = new JSONArray();
    	ZonaCimientos zona = srvZona.obtenerZonaCimientos(idZona);
    	List<Convocatoria> convocatorias = convocatoriaSrv.obtenerConvocatoriasPorZonaYNombre(zona,texto,cantidadMax);
    	if(convocatorias.isEmpty()){
    		JSONObject eaObj = new JSONObject();
    		eaObj.put("id",0);
    		eaObj.put("nombre","no hay Convocatorias  para la zona cargada");
    		easAjax.put(eaObj);
    	}
    	for (Convocatoria convocatoria : convocatorias) {
    		JSONObject eaObj = new JSONObject();
    		eaObj.put("id",convocatoria.getIdConvocatoria());
    		eaObj.put("nombre",convocatoria.getNombre());
    		easAjax.put(eaObj);
		}
    	jSon.put("json",easAjax);
    	response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
   // @RequestMapping("/ajax/buscarConvocatoriaPorNombre.do")
    
   /*
     public void buscarConvocatoriaPorNombre(HttpServletResponse response,
    
    		@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException{
    	
    	JSONObject jSon = new JSONObject();
    	JSONArray easAjax = new JSONArray();
    	//ZonaCimientos zona = srvZona.obtenerZonaCimientos(idZona);
    	List<Convocatoria> convocatorias = convocatoriaSrv.obtenerConvocatoriasPorNombre(texto,cantidadMax);
    	if(convocatorias.isEmpty()){
    		JSONObject eaObj = new JSONObject();
    		eaObj.put("id",0);
    		eaObj.put("nombre","no hay Convocatorias  para la zona cargada");
    		easAjax.put(eaObj);
    	}
    	for (Convocatoria convocatoria : convocatorias) {
    		JSONObject eaObj = new JSONObject();
    		eaObj.put("id",convocatoria.getIdConvocatoria());
    		eaObj.put("nombre",convocatoria.getNombre());
    		easAjax.put(eaObj);
		}
    	jSon.put("json",easAjax);
    	response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    
    /**
     * Buscar rr por nombre y zona.
     *
     * @param response the response
     * @param idZona the id zona
     * @param texto the texto
     * @param cantidadMax the cantidad max
     * @throws JSONException the jSON exception
     * @since 04-may-2011
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarRRPorNombreYZona.do")
	public void buscarRRPorNombreYZona(HttpServletResponse response,
			@RequestParam(required=false, value="idZona") Long idZona,
			@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException {
    JSONObject jSon = new JSONObject();
	JSONArray rrs = new JSONArray();	
	if(idZona != null){	
    	ZonaCimientos zona = srvZona.obtenerZonaCimientos(idZona);
    	List<PerfilRR> rrList = rrSvr.obtenerRRsPorNombreYZona(zona, texto);

		if(rrList != null && !rrList.isEmpty()){
			
			for (PerfilRR rr : rrList)
			{
				JSONObject rrObj = new JSONObject();
				rrObj.put("nombre", rr.getDatosPersonales().getApellido() + ", " + rr.getDatosPersonales().getNombre());
				rrObj.put("id", rr.getIdPerfilRR());
				rrs.put(rrObj);
			}

		}
		}
		jSon.put("rrs", rrs);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}
	}

    /**
     * Buscar rr por nombre y zona.
     *
     * @param response the response
     * @param idZona the id zona
     * @param texto the texto
     * @param cantidadMax the cantidad max
     * @throws JSONException the jSON exception
     * @since 22-Mar-2012
     * @author wtrujillo
     */
    @RequestMapping("/ajax/buscarRRPorNombreYZonaOrNombre.do")
	public void buscarRRPorNombreYZonaOrNombre(HttpServletResponse response,
			@RequestParam(required=false, value="idZona") Long idZona,
			@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException {
	    JSONObject jSon = new JSONObject();
		JSONArray rrs = new JSONArray();
		List<PerfilRR> rrList = null;
		if(idZona != null){	
	    	ZonaCimientos zona = srvZona.obtenerZonaCimientos(idZona);
	    	rrList = rrSvr.obtenerRRsPorNombreYZona(zona, texto);
		} else {
	    	rrList = rrSvr.obtenerRRsPorNombre(texto);
		}
	
		if(rrList != null && !rrList.isEmpty()){
			for (PerfilRR rr : rrList) {
				JSONObject rrObj = new JSONObject();
				rrObj.put("nombre", rr.getDatosPersonales().getApellido() + ", " + rr.getDatosPersonales().getNombre());
				rrObj.put("id", rr.getIdPerfilRR());
				rrs.put(rrObj);
			}
		}

		jSon.put("rrs", rrs);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}
	}
    
    
    @RequestMapping("/ajax/buscarRRPorNombre.do")
	public void buscarRRPorNombre(HttpServletResponse response,
			@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException {
    JSONObject jSon = new JSONObject();
	JSONArray rrs = new JSONArray();	
	
    	List<PerfilRR> rrList = rrSvr.obtenerRRsPorNombre(texto);
		if(rrList != null && !rrList.isEmpty())
		{
			for (PerfilRR rr : rrList)
			{
				JSONObject rrObj = new JSONObject();
				rrObj.put("nombre", rr.getDatosPersonales().getApellido() + ", " + rr.getDatosPersonales().getNombre());
				rrObj.put("id", rr.getIdPerfilRR());
				rrs.put(rrObj);
			}
		}
		else
		{
			JSONObject rrObj = new JSONObject();
			rrObj.put("nombre", "no hay datos");
			rrObj.put("id", "");
			rrs.put(rrObj);
		}
		jSon.put("rrs", rrs);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try 
		{
			response.getWriter().write(jSon.toString());
		}
		catch (IOException e) 
		{
			log.error(e.getMessage());
			e.printStackTrace();
		}
	}
    
    /**
     * Buscar ea por nombre yrr.
     *
     * @param response the response
     * @param idRR the id rr
     * @param texto the texto
     * @param cantidadMax the cantidad max
     * @throws JSONException the jSON exception
     * @since 04-may-2011
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarEAPorNombreYRR.do")
	public void buscarEAPorNombreYRR(HttpServletResponse response,
			@RequestParam(required= false, value="idRR") Long idRR,
			@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException {
    	
    	JSONObject jSon = new JSONObject();
		JSONArray eas = new JSONArray();
		if(idRR != null){
	    	PerfilRR rr = rrSvr.obtenerPerfilRR(idRR);
	    	List<PerfilEA> eaList = srvPerfilEa.obtenerEAsPorNombreYRR(rr, texto);
	
			if(eaList != null && !eaList.isEmpty()){
				
				for (PerfilEA ea : eaList)
				{
					JSONObject eaObj = new JSONObject();
					eaObj.put("nombre", ea.getDatosPersonales().getApellido() + ", " + ea.getDatosPersonales().getNombre());
					eaObj.put("id", ea.getIdPerfilEA());
					eas.put(eaObj);
				}
	
			}
		}	
		jSon.put("eas", eas);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}
	}

    /**
     * Buscar ea por nombre yrr.
     *
     * @param response the response
     * @param idRR the id rr
     * @param texto the texto
     * @param cantidadMax the cantidad max
     * @throws JSONException the jSON exception
     * @since 22-Mar-2012
     * @author wtrujillo
     */
    @RequestMapping("/ajax/buscarEAPorNombreYRROrNombre.do")
	public void buscarEAPorNombreYRROrNombre(HttpServletResponse response,
			@RequestParam(required= false, value="idRR") Long idRR,
			@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException {
    	
    	JSONObject jSon = new JSONObject();
		JSONArray eas = new JSONArray();
		
		List<PerfilEA> eaList = null;
		if(idRR != null){
	    	PerfilRR rr = rrSvr.obtenerPerfilRR(idRR);
	    	eaList = srvPerfilEa.obtenerEAsPorNombreYRR(rr, texto);
		} else {
		    eaList = srvPerfilEa.obtenerEAsPorNombre(texto);
		}
			
		if(eaList != null && !eaList.isEmpty()){
			for (PerfilEA ea : eaList) {
				JSONObject eaObj = new JSONObject();
				eaObj.put("nombre", ea.getDatosPersonales().getApellido() + ", " + ea.getDatosPersonales().getNombre());
				eaObj.put("id", ea.getIdPerfilEA());
				eas.put(eaObj);
			}
		}
			
		jSon.put("eas", eas);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}
	}
    
    
    @RequestMapping("/ajax/buscarEAPorNombre.do")
	public void buscarEAPorNombre(HttpServletResponse response,
			@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException 
	{
    	JSONObject jSon = new JSONObject();
		JSONArray eas = new JSONArray();
	    List<PerfilEA> eaList = srvPerfilEa.obtenerEAsPorNombre(texto);
		if(eaList != null && !eaList.isEmpty())
		{			
				for (PerfilEA ea : eaList)
				{
					JSONObject eaObj = new JSONObject();
					eaObj.put("nombre", ea.getDatosPersonales().getApellido() + ", " + ea.getDatosPersonales().getNombre());
					eaObj.put("id", ea.getIdPerfilEA());
					eas.put(eaObj);
				}
			}
			else
			{
				JSONObject eaObj = new JSONObject();
				eaObj.put("nombre", "no hay datos");
				eaObj.put("id", "");
				eas.put(eaObj);
			}	
		jSon.put("eas", eas);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}
	}
    /**
     * Buscar escuela.
     *
     * @param response the response
     * @param texto the texto
     * @param idZona the id zona
     * @param maxResults the max results
     * @throws JSONException the jSON exception
     * @since 26-abr-2011
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarEscuelaSeleccionNombre.do")
    public void buscarEscuelaSeleccionNombre(HttpServletResponse response,
    		@RequestParam("name_startsWith") String texto,
    		@RequestParam("idZona") Long idZona,
    		@RequestParam("maxResults") int maxResults
    		) throws JSONException{
    	
    	JSONObject jSon = new JSONObject();
    	JSONArray escuelas = new JSONArray();
		List<EscuelaSeleccion> escuelasBD = new ArrayList<EscuelaSeleccion>();
		ZonaCimientos zona = srvZona.obtenerZonaCimientos(idZona);
    	escuelasBD = escuelaSeleccionSrv.obtenerEscuelaPornombreYZona(texto,  maxResults,zona);
    	if(escuelasBD.isEmpty()){
    		JSONObject escuelaObj = new JSONObject();
    		escuelaObj.put("nombre","no hay datos");
    		escuelaObj.put("localidad", "no hay datos ");
			escuelas.put(escuelaObj);
    	}else{
    		for (EscuelaSeleccion escuela : escuelasBD) {
    			JSONObject escuelaObj = new JSONObject();
    			escuelaObj.put("nombre", escuela.getNombre());
    			escuelaObj.put("id", escuela.getId());
    			
    			escuelas.put(escuelaObj);
			}
    	}
    	
    	jSon.put("escuelas", escuelas);
    	response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    /**
     * Buscar perfil ts nombre.
     *
     * @param response the response
     * @param texto the texto
     * @param maxResults the max results
     * @throws JSONException the jSON exception
     * @since 04-may-2011
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarPerfilTSNombre.do")
    public void buscarPerfilTSNombre(HttpServletResponse response,
    		@RequestParam("name_startsWith") String texto,
    		@RequestParam("maxResults") int maxResults
    		) throws JSONException{
    	
    	JSONObject jSon = new JSONObject();
    	JSONArray perfiTSArray = new JSONArray();
		List<PerfilTS> perfilTSs = new ArrayList<PerfilTS>();
		perfilTSs = perfilTSSrv.obtenerTSPorNombre(texto,  maxResults);
    	if(perfilTSs.isEmpty()){
    		JSONObject perfilTSObject = new JSONObject();
    		perfilTSObject.put("nombre","no hay datos");
    		perfiTSArray.put(perfilTSObject);
    	}else{
    		for (PerfilTS perfilTS : perfilTSs) {
    			JSONObject perfilTSObject = new JSONObject();
    			perfilTSObject.put("nombre", perfilTS.getDatosPersonales().getApellidoNombre());
    			perfilTSObject.put("id", perfilTS.getIdPerfilTS());
    			
    			perfiTSArray.put(perfilTSObject);
			}
    	}
    	
    	jSon.put("perfilTSs", perfiTSArray);
    	response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    /**
     * Retorna la lista de zonas.
     * Este metodo se utiliza para autocompletar las zonas
     *
     * @param response the response
     * @param texto the texto
     * @throws JSONException the jSON exception
     * @since 30-dic-2010
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarCorrectoraPorNombre.do")
	public void buscarCorrectora(HttpServletResponse response,
			@RequestParam("name_startsWith") String texto) throws JSONException {
		JSONObject jSon = new JSONObject();
		JSONArray correctoras = new JSONArray();
		List<Persona> correctorasDB = srvPersona.buscarCorrectoraPorNombre(texto);
		
		if(correctorasDB != null){
			for (Persona correctora : correctorasDB)
			{
				JSONObject correctoraObj = new JSONObject();
				correctoraObj.put("nombre", correctora.getApellidoNombre());
				correctoraObj.put("id", correctora.getId());
				
				correctoras.put(correctoraObj);
			}
		}else{
			JSONObject zonaObj = new JSONObject();
			zonaObj.put("nombre", "no hay datos");
			zonaObj.put("id", "");
			
			correctoras.put(zonaObj);
		}
		
		jSon.put("correctoras", correctoras);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}

	}
    
    /**
     * Retorna la lista de convocatorias del ciclo actual y de los disponibles.
     * Este metodo se utiliza para autocompletar la convocatoria
     *
     * @param response the response
     * @param texto the texto
     * @throws JSONException the jSON exception
     * @since 01-dic-2011
     * @author jbaracco
     */
    @RequestMapping("/ajax/buscarConvocatoriaPorNombre.do")
	public void buscarConvocatoriaPorNombre(HttpServletResponse response,
			@RequestParam("name_startsWith") String texto) throws JSONException {
		JSONObject jSon = new JSONObject();
		JSONArray convocatorias = new JSONArray();
		List<Convocatoria> convocatoriasDB = convocatoriaSrv.obtenerConvocatoriaPorAjax(texto);
		
		if(convocatoriasDB != null){
			for (Convocatoria convocatoria : convocatoriasDB)
			{
				JSONObject convocatoriaObj = new JSONObject();
				convocatoriaObj.put("nombre", convocatoria.getNombre());
				convocatoriaObj.put("id", convocatoria.getIdConvocatoria());
				
				convocatorias.put(convocatoriaObj);
			}
		}else{
			JSONObject convocatoriaObj = new JSONObject();
			convocatoriaObj.put("nombre", "no hay datos");
			convocatoriaObj.put("id", "");
			
			convocatorias.put(convocatoriaObj);
		}
		
		jSon.put("convocatorias", convocatorias);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}

	}
    
    
    /**
     * Retorna la lista de provincias.
     * Este metodo se utiliza para autocompletar las provincias
     *
     * @param response the response
     * @param texto the texto
     * @throws JSONException the jSON exception
     * @since 30-dic-2010
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarProvincia.do")
	public void buscarProvincia(HttpServletResponse response,
			@RequestParam("name_startsWith") String texto) throws JSONException {
		JSONObject jSon = new JSONObject();
		JSONArray zonas = new JSONArray();
		List<Provincia> provBD = provinciaSrv.obtenerProvinciasTexto(texto);
		
		if(provBD != null){
			for (Provincia prov : provBD){
				JSONObject provObj = new JSONObject();
				provObj.put("nombre", prov.getDescripcion());
				provObj.put("id", prov.getId());
				
				zonas.put(provObj);
			}
		}else{
			JSONObject provObj = new JSONObject();
			provObj.put("nombre", "no hay datos");
			provObj.put("id", "");
			
			zonas.put(provObj);
		}
		
		jSon.put("zonas", zonas);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}

	}
    
    
    /**
     * Retorna la lista de todas las zonas, tanto las activas como las inactivas. Se utiliza para el listado de
     * alumnos inactivos
     * Este metodo se utiliza para autocompletar las zonas
     *
     * @param response the response
     * @param texto the texto
     * @throws JSONException the jSON exception
     * @since 30-dic-2010
     * @author cfigueroa
     */
    @RequestMapping("/ajax/buscarTodasZonaPorNombre.do")
	public void buscarTodasZonas(HttpServletResponse response,
			@RequestParam("name_startsWith") String texto) throws JSONException {
		JSONObject jSon = new JSONObject();
		JSONArray zonas = new JSONArray();
		List<ZonaCimientos> zonasBD = srvZona.getTodasPorNombreConAjax(texto);
		
		if(zonasBD != null){
			for (ZonaCimientos zona : zonasBD)
			{
				JSONObject zonaObj = new JSONObject();
				zonaObj.put("nombre", zona.getNombre());
				zonaObj.put("id", zona.getId());
				
				zonas.put(zonaObj);
			}
		}else{
			JSONObject zonaObj = new JSONObject();
			zonaObj.put("nombre", "no hay datos");
			zonaObj.put("id", "");
			
			zonas.put(zonaObj);
		}
		
		jSon.put("zonas", zonas);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}

	}
    
    
    @RequestMapping("/ajax/buscarTodosEAPorNombre.do")
	public void buscarTodosEAPorNombre(HttpServletResponse response,
			@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException 
	{
    	JSONObject jSon = new JSONObject();
		JSONArray eas = new JSONArray();
	    List<PerfilEA> eaList = srvPerfilEa.obtenerTodosEAsPorNombre(texto);
		if(eaList != null && !eaList.isEmpty())
		{			
				for (PerfilEA ea : eaList)
				{
					JSONObject eaObj = new JSONObject();
					eaObj.put("nombre", ea.getDatosPersonales().getApellido() + ", " + ea.getDatosPersonales().getNombre());
					eaObj.put("id", ea.getIdPerfilEA());
					eas.put(eaObj);
				}
			}
			else
			{
				JSONObject eaObj = new JSONObject();
				eaObj.put("nombre", "no hay datos");
				eaObj.put("id", "");
				eas.put(eaObj);
			}	
		jSon.put("eas", eas);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}
	}
    
    
    /**
     * Retorna todos los padrinos,tanto los activos como los inactivos
     * @param response
     * @param texto
     * @param cantidadMax
     * @throws JSONException
     */
	@RequestMapping("/ajax/buscarTodosPadrinosPorNombre.do")
	public void buscarTodosPadrinos(HttpServletResponse response,
			@RequestParam("name_startsWith") String texto,
			@RequestParam("maxRows") int cantidadMax) throws JSONException {
		JSONObject jSon = new JSONObject();
		JSONArray padrinos = new JSONArray();
		List<PerfilPadrino> padrinosBD = padrinoSvr.buscarTodosPorNombreDenominacion(texto,
				cantidadMax);

		for (PerfilPadrino padrino : padrinosBD) {
			JSONObject padrinoObj = new JSONObject();
			String nombre = null;
			if(padrino.getEmpresa() != null){
				nombre = padrino.getEmpresa().getDenominacion();
			}else if(padrino.getDatosPersonales() != null){
				nombre = padrino.getDatosPersonales().getApellido()+ ", "
				+ padrino.getDatosPersonales().getNombre();
			}
			padrinoObj.put("nombre", nombre);
			padrinoObj.put("id", padrino.getId());
			padrinos.put(padrinoObj);
		}

		jSon.put("padrinos", padrinos);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	@RequestMapping("/ajax/buscarPadrinosPorAlumno.do")
	public void buscarPadrinosPorAlumno(HttpServletResponse response,
			@RequestParam("idAlumno") Long idAlumno,
			@RequestParam("idCiclo") Long idCiclo) throws JSONException {
		JSONObject jSon = new JSONObject();
		JSONArray padrinos = new JSONArray();
		PerfilAlumno perfilAlumno = alumnoSrv.obtenerAlumno(idAlumno);		
		ZonaCimientos zona = perfilAlumno.getEscuela().getLocalidad().getZona();
		List<Beca> becas = new ArrayList<Beca>();
		if(zona != null){
			becas = becaSvr.obtenerBecaPorCicloPorZona(zona, idCiclo);
		}

		for (Beca beca : becas) {
			JSONObject padrinoObj = new JSONObject();
			String nombre = null;
			PerfilPadrino padrino = beca.getPadrino();
			if(padrino.getEmpresa() != null){
				nombre = padrino.getEmpresa().getDenominacion();
			}else if(padrino.getDatosPersonales() != null){
				nombre = padrino.getDatosPersonales().getApellido()+ ", "
				+ padrino.getDatosPersonales().getNombre();
			}
			padrinoObj.put("nombre", nombre);
			padrinoObj.put("idPadrino", padrino.getId());
			padrinoObj.put("idBeca", beca.getId());
			padrinos.put(padrinoObj);
		}

		jSon.put("padrinos", padrinos);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(jSon.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	@RequestMapping("/ajax/generarVisualizacionMail.do")
	public void generarVisualizacionMail(HttpServletResponse response,
			@RequestParam("idTexto") Long idTexto) throws JSONException {
		JSONObject object = new JSONObject();

		Texto texto = new Texto();
		String destinatario = "";
		String cuerpo = "";
		String firma = "";
		String mail = "";
		
		
		if(idTexto != null){
			texto = textoSrv.obtenerTextoPorId(idTexto);
//			destinatario = texto.getDestinatario().replace("[nombrePadrino]", "Marcela Carolina");
//			destinatario = destinatario.replace("[apellidoPadrino]", "Aguirre");
//			cuerpo = texto.getCuerpo().replace("[nombreBecado]", "Maria Juana");
//			cuerpo = cuerpo.replace("[apellidoBecado]", "Rodriguez");
//			cuerpo= cuerpo.replace("[zonaBeca]", "Campana");
//			firma = texto.getFirma().replace("[nombreUsuario]", "Maria Grace");
//			firma= firma.replace("[apellidoUsuario]", "Nogu�s");		
//			mail = texto.getTitulo() + "<br><br>" + destinatario + cuerpo + firma;	
			if((texto.getDestinatario().length() > 4 )&&(texto.getDestinatario().substring(0, 4).equals("<br>")))
				destinatario = "<br>" + texto.getDestinatario().replace("[nombrePadrino]", "Marcela Carolina").replace("[apellidoPadrino]", "Aguirre");
			else
				destinatario = texto.getDestinatario().replace("[nombrePadrino]", "Marcela Carolina").replace("[apellidoPadrino]", "Aguirre");
			if((texto.getCuerpo().length() > 4)&&(texto.getCuerpo().substring(0, 4).equals("<br>")))
				cuerpo = "<br>" + texto.getCuerpo().replace("[nombreBecado]", "Maria Juana").replace("[apellidoBecado]", "Rodriguez").replace("[zonaBeca]", "Campana");
			else
				cuerpo = texto.getCuerpo().replace("[nombreBecado]", "Maria Juana").replace("[apellidoBecado]", "Rodriguez").replace("[zonaBeca]", "Campana");
			if((texto.getFirma().length() > 4)&&(texto.getFirma().substring(0, 4).equals("<br>")))
				firma = "<br>" + texto.getFirma().replace("[nombreUsuario]", "Maria Grace").replace("[apellidoUsuario]", "Nogu�s");
			else
				firma = texto.getFirma().replace("[nombreUsuario]", "Maria Grace").replace("[apellidoUsuario]", "Nogu�s");
			mail = texto.getTitulo() + "<br><br><br>" + destinatario + cuerpo + firma;	
		}
		
		try {
			object.put("mail", mail);	
			response.setContentType("application/json");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("ISO-8859-1");
			response.getWriter().write(object.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/ajax/generarVisualizacionMailAnterior.do")
	public void generarVisualizacionMailAnterior(HttpServletResponse response,
			@RequestParam("cicloId") Long cicloId,
			@RequestParam("tipoInformeId") Integer tipoInformeId,
			@RequestParam("tipoMailId") String  tipoMailId,
			@RequestParam(required= false, value="idMotivoNoRenovacion") Integer idMotivoNoRenovacion,
			@RequestParam(required= false, value="idMotivoPendiente") Integer idMotivoPendiente) throws JSONException {
		
		JSONObject object = new JSONObject();
		Texto texto = new Texto();

		CicloPrograma ciclo = cicloSrv.obtenerCiclo(cicloId);
		Integer motivoNoRenovacion = idMotivoNoRenovacion != null && idMotivoNoRenovacion.equals(0) ? null : idMotivoNoRenovacion;
		Integer motivoRenovacionPendiente = idMotivoPendiente != null && idMotivoPendiente.equals(0) ? null : idMotivoPendiente;
		MotivoPendiente motivoPendiente = null;
		MotivoNoRenovacion motivoNoRenov = null;
		String idTipoInforme = null;
		if(tipoInformeId == 1)			
			idTipoInforme = "Informe de Seguimiento N�1";
		else if(tipoInformeId == 2)
			idTipoInforme = "Informe de Seguimiento N�2";
		else if(tipoInformeId == 3)
			idTipoInforme = "Informe de Seguimiento N�3";
		else if(tipoInformeId == 4)
			idTipoInforme = "Informe de Cesaci�n";
		else if(tipoInformeId == 5)
			idTipoInforme = "Comunicado de NO Renovaci�n";
		else if(tipoInformeId == 6)
			idTipoInforme = "Comunicado de Renovaci�n Pendiente";
		else if(tipoInformeId == 7)
			idTipoInforme = "Ficha de Presentaci�n";
		
		if(motivoNoRenovacion != null){
			motivoNoRenov = MotivoNoRenovacion.getmotivoNoIncorporacion(motivoNoRenovacion);
		}
		if(motivoRenovacionPendiente != null){
			motivoPendiente = MotivoPendiente.getMotivoPendiente(motivoRenovacionPendiente);			
		}		
		texto = textoSrv.obtenerTextoPorCicloTipoInfTipoMailYMotivo(ciclo, idTipoInforme, tipoMailId, motivoPendiente, motivoNoRenov);
		
		if(texto != null){
			object.put("titulo", texto.getTitulo());
			object.put("destinatario", texto.getDestinatario().replace("<br>","\r\n"));
			object.put("cuerpo", texto.getCuerpo().replace("<br>","\r\n"));
			object.put("firma", texto.getFirma().replace("<br>","\r\n"));	
			object.put("mensaje", "");
		}
		else
			object.put("mensaje", "No existe un mail cargado para los filtros seleccionados");

		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(object.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
