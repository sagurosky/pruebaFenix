package org.cimientos.intranet.web.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.cimientos.intranet.dto.CreacionCuentaDTO;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.EstadoCuenta;
import org.cimientos.intranet.modelo.ResponsableAdulto;
import org.cimientos.intranet.modelo.banco.Banco;
import org.cimientos.intranet.modelo.perfil.AlumnoPanelEA;
import org.cimientos.intranet.servicio.AlumnoPanelEASrv;
import org.cimientos.intranet.servicio.BancoSrv;
import org.cimientos.intranet.servicio.CicloProgramaSrv;
import org.cimientos.intranet.servicio.CuentaSrv;
import org.cimientos.intranet.servicio.ResponsableSrv;
import org.cimientos.intranet.servicio.SucursalBancoSrv;
import org.cimientos.intranet.utils.ConstantesMenu;
import org.cimientos.intranet.utils.Formateador;
import org.cimientos.intranet.utils.cuentas.ArchivoCuenta;
import org.cimientos.intranet.utils.cuentas.ArchivoSolicitudCuentaGalicia;
import org.cimientos.intranet.utils.cuentas.ArchivoSolicitudCuentaMacro;
import org.cimientos.intranet.utils.cuentas.ArchivoSolicitudCuentaSupervielle;
import org.cimientos.intranet.utils.cuentas.TXTFileHelper;
import org.cimientos.intranet.utils.cuentas.TipoCuenta;
import org.cimientos.intranet.utils.paginacion.ExtendedPaginatedList;
import org.cimientos.intranet.utils.paginacion.PaginateListFactory;
import org.displaytag.properties.SortOrderEnum;
import org.displaytag.tags.TableTagParameters;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;



/**
 * @author pmlabaronnie
 * 
 */
@Controller
@RequestMapping("/cuenta/*")
public class CuentaController extends BaseController{

	private static final String BANCO_GALICIA = "Galicia";

	private static final String BANCO_MACRO = "Macro";

	private static final String BANCO_INDUSTRIAL = "Industrial";
	
	private static final String BANCO_SUPERVIELLE = "Supervielle";
	
	
	
	
	
	private static final Object BANCO_SANTANDER = "Santander";
	
	private static final Object BANCO_FUNDACION_PERALTA = "Galicia FAP Tucum�n";
	
	private static final Object GALICIA_FAP_CATAMARCA = "Galicia FAP Catamarca";
	
	private static final Object GALICIA_FAP_SGO_DEL_ESTERO = "Galicia FAP Sgo del Estero";
	
	private static final Object GALICIA_FAP_JUJUY = "Galicia FAP Jujuy";
	
	private static final Object MACRO_FAP_TARTAGAL = "Macro FAP Tartagal";
	
	private static final Object GALICIA_FAP_VILLA_MARIA = "Galicia FAP Villa Mar�a";
	
	
	
	@Autowired
	private PaginateListFactory paginateListFactory;
	
	@Autowired
	private BancoSrv srvBanco;
	
	@Autowired
	private ResponsableSrv srvResponsable;
	
	@Autowired
	private CuentaSrv srvCuenta;
	
	@Autowired
	public SucursalBancoSrv sucursalService;
	
	@Autowired
	public CicloProgramaSrv svrCiclo;
	
	@Autowired
	private AlumnoPanelEASrv panelEaSrv;
	
	@Autowired
	private ResponsableSrv responsableSrv;
	
	/**
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("/cuenta/verCreacionCuentas.do")
	public ModelAndView verCreacionCuentas() throws ParseException{
		Map<String, Object> resul = new HashMap<String, Object>();

		resul.put("bancos", srvBanco.obtenerBancosParaSolicitudCuentas());
		
		return forward("/cuenta/verCreacionCuentas", resul);

	}
	
	/**
	 * @return
	 * @throws ParseException
	 * @changes esalvador
	 */
	
	@RequestMapping("/cuenta/verInformeCuentas.do")
	public ModelAndView verInformeCuentas(HttpServletRequest request, HttpSession session, 
			@RequestParam(required= false, value="idBanco") String idBanco,
			@RequestParam(required= false, value="becado") String becado,
			@RequestParam(required= false, value="titular") String titular,
			@RequestParam(required= false, value="numCuenta") String numCuenta,
			@RequestParam(required= false, value="zona") String zona,
			@RequestParam(required= false, value="idZona") Long idZona,
			@RequestParam(required= false, value="rr") String rr,
			@RequestParam(required= false, value="idRR") Long idRR,
			@RequestParam(required= false, value="estadoCuenta") String estadoCuenta,
			@RequestParam(required= false, value="idEstadoCuenta") Integer idEstadoCuenta,
			@RequestParam(required=false, value="dniTitular") String dniTitular,
			@RequestParam(required=false, value="mensaje") String mensaje,
			@RequestParam(required=false, value="error") String error) throws ParseException{
		
		session.setAttribute("menu", ConstantesMenu.menuAdministracion);
		
		Long zonaId = idZona != null && idZona.equals(0) ? null : idZona;
		Long rrId = idRR != null && idRR.equals(0) ? null : idRR;
		Integer estadoCuentaId = idEstadoCuenta != null && idEstadoCuenta.equals(0) ? null : idEstadoCuenta;
		Integer dniRA = null;			
		Map<String, Object> resul = new HashMap<String, Object>();
		boolean export = request.getParameter(TableTagParameters.PARAMETER_EXPORTING) != null; 
		ExtendedPaginatedList listaCuentasPaginadas = null;
		

		if(dniTitular != null){
			if(dniTitular == "")
				dniTitular=null;
			else{
				try {
					dniRA = new Integer(dniTitular);					
				} catch (NumberFormatException e) {
					dniTitular=null;
				}
			}			
		}
    	if ("null".equals(idBanco) || idBanco == null ) {
    		listaCuentasPaginadas = paginarCuentas(0L, export, request, becado, titular, numCuenta, zonaId, rr, rrId, estadoCuentaId, dniRA);
		}else{
			listaCuentasPaginadas = paginarCuentas(new Long(idBanco), export, request, becado, titular, numCuenta, zonaId, rr, rrId,estadoCuentaId, dniRA);
		}
    	
       	WebUtils.setSessionAttribute(request, "cuentaList", listaCuentasPaginadas);
        resul.put("cuentas", listaCuentasPaginadas);
       	resul.put("bancos", srvBanco.obtenerTodos());
        resul.put("becado", becado);
        resul.put("titular", titular);
        resul.put("numCuenta", numCuenta);
        resul.put("idZona", zonaId);
        resul.put("zona", zona);
        resul.put("rr", rr);
        resul.put("rrId", rrId);
        resul.put("estadoCuentas", EstadoCuenta.getListaEstadoCuentaParaInforme());
        resul.put("idEstadoCuenta", idEstadoCuenta);
//        resul.put("idBanco", idBanco);
        resul.put("idBanco", idBanco.equals("null")?0:Long.parseLong(idBanco));//DMS 11/8/23 lo paso a long para evitar excepcion en informe de cuentas

        resul.put("dniTitular", dniTitular);
        resul.put("tipoCuentas", TipoCuenta.getTipoCuentas());
        
		if(StringUtils.isNotBlank(mensaje))
			resul.put("mensaje", mensaje);
		if(StringUtils.isNotBlank(error))
			resul.put("error", error);
        
		return forward("/cuenta/informeCuentas", resul);
	}
	
	/**
	 * @param idBanco
	 * @param request
	 * @param todas
	 * @param export
	 * @return ExtendedPaginatedList
	 * @throws ParseException 
	 * @author esalvador
	 * @param tipoCuentaId 
	 */
	private ExtendedPaginatedList paginarCuentas(Long idBanco, boolean export, HttpServletRequest request,
			String becado,String titular, String numCuenta, Long zonaId,String rr,Long rrId,Integer idEstadoCuenta, Integer dniRA) throws ParseException {
		
		List<CreacionCuentaDTO> cuentasDTO = null;
		
		ExtendedPaginatedList listaPaginada = paginateListFactory.getPaginatedListFromRequest(request);
		
		Banco bancoSeleccionado = srvBanco.obtenerBanco(idBanco);
		int totalRowsFiltrados = srvCuenta.obtenerCantidadCuentasFiltradasAExportar(bancoSeleccionado, becado, titular, numCuenta, zonaId, rr, rrId, idEstadoCuenta, dniRA);
		
		//Si es un export debo cargar toda la lista entera, si no lo es entonces se carga la lista de a una pagina por vez
		if(export){
			cuentasDTO = obtenerCuentas(idBanco, becado, titular, numCuenta, zonaId, rr, rrId, idEstadoCuenta, dniRA, 0, totalRowsFiltrados, listaPaginada.getSortDirection(), listaPaginada.getSortCriterion());
		}else{
			cuentasDTO = obtenerCuentas(idBanco, becado, titular, numCuenta, zonaId, rr, rrId, idEstadoCuenta, dniRA, listaPaginada.getFirstRecordIndex(), listaPaginada.getPageSize(), 
					listaPaginada.getSortDirection(), listaPaginada.getSortCriterion());
		}
		listaPaginada.setList(cuentasDTO);
		listaPaginada.setTotalNumberOfRows(totalRowsFiltrados);

		return listaPaginada;
	}	
	
	/***
	 * @author esalvador
	 * @param tipoCuentaId 
	 **/
	public List<CreacionCuentaDTO> obtenerCuentas(Long idBanco, String becado,String titular, String numCuenta, Long zonaId, String rr,Long rrId, Integer idEstadoCuenta, Integer dniRA,
			int firstResult, int maxResults, SortOrderEnum sortDirection, String sortCriterion){
			//Si viene todas en true significa que trae todas las cuentas que estan en la BD sin importar su estado(creadas o no).
			List<CreacionCuentaDTO> cuentasFiltradas = new ArrayList<CreacionCuentaDTO>();
			if(idBanco != null){	
				if(idBanco.equals(0L)){
						cuentasFiltradas = srvCuenta.obtenerListaCuentasFiltradas(null,  becado, titular, numCuenta, zonaId, rr,rrId, idEstadoCuenta, dniRA, firstResult, maxResults, sortDirection, sortCriterion);
				}else {
					Banco bancoSeleccionado = srvBanco.obtenerBanco(idBanco);
						cuentasFiltradas = srvCuenta.obtenerListaCuentasFiltradas(bancoSeleccionado, becado, titular, numCuenta, zonaId, rr, rrId, idEstadoCuenta, dniRA, firstResult, maxResults, sortDirection, sortCriterion);
				}	
			}
		return cuentasFiltradas;
	}
	
	@RequestMapping("/cuenta/notificarCuentaFallida.do")
	public ModelAndView notificarCuentaFallida(
			HttpServletRequest request, HttpSession session,
			@RequestParam("tipoPersona") String tipoPersona,
			@RequestParam("id") String id,
			@RequestParam("motivo") String motivo,
			@RequestParam(required= false, value="idBanco") String idBanco,
			@RequestParam(required= false, value="becado") String becado,
			@RequestParam(required= false, value="titular") String titular,
			@RequestParam(required= false, value="numCuenta") String numCuenta,
			@RequestParam(required= false, value="zona") String zona,
			@RequestParam(required= false, value="idZona") Long idZona,
			@RequestParam(required= false, value="rr") String rr,
			@RequestParam(required= false, value="idRR") Long idRR,
			@RequestParam(required= false, value="estadoCuenta") String estadoCuenta,
			@RequestParam(required= false, value="idEstadoCuenta") Integer idEstadoCuenta,
			@RequestParam(required=false, value="dniTitular") String dniTitular)  throws ParseException{
		if(tipoPersona.equals(CreacionCuentaDTO.RA)){
			ResponsableAdulto ra = srvResponsable.obtenerPorId(Long.parseLong(id));
			ra.setEstadoCuenta(EstadoCuenta.FALLIDA);
			ra.setMotivoFallidoCuenta(motivo);
			srvResponsable.agregarResponsable(ra);
			actualizarPanelEA(ra);
		}
		return verInformeCuentas(request, session, idBanco, becado, titular, numCuenta, zona, idZona, rr, idRR, estadoCuenta, idEstadoCuenta,dniTitular, null,null);
	}
	
	
	/**
	 * @param request
	 * @param response
	 * @param ctasSeleccionadas
	 * @param idBanco
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cuenta/generarArchivoCuentas.do")
	protected ModelAndView generarExcelPOI(HttpServletRequest request,
			HttpServletResponse response, @RequestParam(required = false, value = "ctasSeleccionadas") 
			String ctasSeleccionadas,  @RequestParam(required = false, value = "idBanco") Long idBanco) throws Exception {
		HashMap<String,Object> map = new HashMap<String, Object>();
		
		String [] cuentas = ctasSeleccionadas.split(",");
		List<Long> raSeleccionados = new ArrayList<Long>();
		List<ResponsableAdulto> responsables = new ArrayList<ResponsableAdulto>();
		
		for (int i = 0; i < cuentas.length; i++) {
			String[] cuenta = cuentas[i].split("-");
			if(cuenta[1].equals(CreacionCuentaDTO.RA)){
				raSeleccionados.add(Long.parseLong( cuenta[0]));
			}
		}
		
		if(CollectionUtils.isNotEmpty(raSeleccionados)){
			responsables = srvResponsable.obtenerGrupo("id", raSeleccionados);
		}	
		
		Banco bancoSeleccionado = srvBanco.obtenerBanco(idBanco);
		ArchivoCuenta archivo = null;
		String excelView = null;
		//Necesito el monto de la beca del ciclo actual
		CicloPrograma cicloActual = svrCiclo.obtenerCicloActual();
		   
		if (bancoSeleccionado.getNombre().equals(BANCO_GALICIA) || 
				bancoSeleccionado.getNombre().equals(GALICIA_FAP_CATAMARCA) ||
				bancoSeleccionado.getNombre().equals(GALICIA_FAP_JUJUY) ||
				bancoSeleccionado.getNombre().equals(GALICIA_FAP_SGO_DEL_ESTERO) ||
				bancoSeleccionado.getNombre().equals(GALICIA_FAP_VILLA_MARIA) ||
				bancoSeleccionado.getNombre().equals(BANCO_FUNDACION_PERALTA)) {
			archivo = new ArchivoSolicitudCuentaGalicia(responsables, /*staff, */ cicloActual);
			excelView = "altaCuentaGaliciaExcelView";
			
		} else if (bancoSeleccionado.getNombre().equals(BANCO_MACRO) ||
				bancoSeleccionado.getNombre().equals(MACRO_FAP_TARTAGAL)) {
			archivo = new ArchivoSolicitudCuentaMacro(responsables, /*staff, */ cicloActual);
			excelView = "altaCuentaMacroExcelView";
			
		} else if (bancoSeleccionado.getNombre().equals(BANCO_SUPERVIELLE)) {
			archivo = new ArchivoSolicitudCuentaSupervielle(responsables, /*staff, */ cicloActual);
			excelView = "altaCuentaSupervielleExcelView";
			
		}
		else {
			map.put("bancos", srvBanco.obtenerBancosParaSolicitudCuentas());
			map.put("tipos", new String[]{CreacionCuentaDTO.RA, CreacionCuentaDTO.STAFF});
			map.put("mensaje", "No se han podido generar los archivos, por favor valide que los datos sean correctos.");
			return forward("/cuenta/verCreacionCuentas", map);
		}
		
		map.put("archivo", archivo);
		map.put("svrResponsable", srvResponsable);
		map.put("panelEaSrv", panelEaSrv);
		map.put("responsables", responsables);
		
		//return excel view
		return new ModelAndView(excelView,map);		
		
	}

	/**
	 * @param responsable
	 */
	private void actualizarPanelEA(ResponsableAdulto responsable) {
		//cambios panel de control del ea
		AlumnoPanelEA panelEa = panelEaSrv.obtenerAlumnoPanelPorIdPerfilAlumno(responsable.getIdAlumno().getId());
		panelEa.actualizarCuenta(responsable.getEstadoCuenta());
		panelEa.setCuentaRA(responsable.getNroCuenta());
		panelEaSrv.modificarAlumnoPanelEA(panelEa);
	}

	/**
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("/cuenta/importarArchivoView.do")
	public ModelAndView verImportarArchivo() throws ParseException{
		Map<String, Object> resul = new HashMap<String, Object>();
		
		resul.put("bancos", srvBanco.obtenerBancosParaSolicitudCuentas());
		
		return forward("/cuenta/importarArchivoCuentas", resul);

	}

	/**
	 * @param idBanco
	 * @param archivo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cuenta/importarArchivo.do")
	public ModelAndView importarArchivo(
			@RequestParam(required = false, value = "banco") Long idBanco,
			@RequestParam(value = "archivo", required = false) MultipartFile archivo)
			throws Exception {
		Map<String, Object> resul = new HashMap<String, Object>();
		
		if(idBanco == null || idBanco.equals(0L)){
			resul.put("bancos", srvBanco.obtenerBancosParaSolicitudCuentas());
        	resul.put("mensaje", "Por favor seleccione un banco.");
        	return forward("/cuenta/importarArchivoCuentas", resul);
		}	
		
		Banco bancoSeleccionado = srvBanco.obtenerBanco(idBanco);
		
		String error = this.validarArchivo(archivo, bancoSeleccionado);
        if (StringUtils.isNotBlank(error)) {
        	resul.put("bancos", srvBanco.obtenerBancosParaSolicitudCuentas());
        	resul.put("mensaje", error);
        	return forward("/cuenta/importarArchivoCuentas", resul);
		}
        
        int cantidadCuetasCreadas= this.crearCuentas(bancoSeleccionado, archivo);
        
        
        if (cantidadCuetasCreadas==0){
        	resul.put("mensaje", "No se cre� ninguna cuenta nueva.");
        }else{
        	resul.put("mensaje", "Fueron creadas "+ cantidadCuetasCreadas+" cuentas exitosamente.");
        }
        
        //resul.put("mensaje", "Las cuentas fueron creadas exitosamente.");
        
     	resul.put("bancos", srvBanco.obtenerBancosParaSolicitudCuentas());
    	return forward("/cuenta/importarArchivoCuentas", resul);
	}



	/**
	 * @param bancoSeleccionado
	 * @param archivo
	 * @throws IOException 
	 */
	private int crearCuentas(Banco bancoSeleccionado, MultipartFile archivo) throws IOException {
        Map<String, String> cuentas = null;
        
        if(bancoSeleccionado.getNombre().equalsIgnoreCase(BANCO_GALICIA)){
        	cuentas = TXTFileHelper.obtenerNrosCuentaGalicia(archivo);
        }else if (bancoSeleccionado.getNombre().equalsIgnoreCase(BANCO_MACRO)){
        	cuentas = TXTFileHelper.obtenerNrosCuentaMacro(archivo);
        }
        int cantidadCtasCreadas=srvCuenta.altaCuentas(cuentas, bancoSeleccionado);
		return cantidadCtasCreadas;
	}



	/**
	 * Valida que el txt no este en blanco
	 * @param archivo
	 * @throws IOException 
	 */
	private String validarArchivo(MultipartFile archivo, Banco bancoSeleccionado) throws IOException {
		String error = "";
		if (archivo.getSize() == 0){
			return "Por favor, seleccione un archivo para importar.";
		}
		String contentType = archivo.getContentType() != null ? archivo.getContentType() : "";
		if(!contentType.startsWith("text")){
			return "Por favor, seleccione un archivo con formato de texto para importar.";
		}
		 
		if ((bancoSeleccionado.getNombre().equalsIgnoreCase(BANCO_GALICIA) && 
				!TXTFileHelper.validarArchivoCuentaGalicia(archivo)) ||
				(bancoSeleccionado.getNombre().equalsIgnoreCase(BANCO_MACRO) && 
						!TXTFileHelper.validarArchivoCuentaMacro(archivo))){
			error = "Formato de archivo no v�lido.";
        }
		return error;
		
	}
	
	
	/**
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("/cuenta/cargarAltaCuentaView.do")
	public ModelAndView cargarCuentas() throws ParseException{
		Map<String, Object> resul = new HashMap<String, Object>();
		Banco bancoIndustrial = srvBanco.devolverBancoPorNombre(BANCO_INDUSTRIAL);
		resul.put("cuentasACrear", srvCuenta.obtenerListaCuentasACrear(bancoIndustrial, false));
		return forward("/cuenta/cargaManualCuenta", resul);

	}
	
	
	@RequestMapping("/cuenta/guardarCuentas.do")
	public ModelAndView guardarCuenta(
			@RequestParam("nrosCuenta") String nrosCuenta,
			@RequestParam("ctasSeleccionadas") String ctasSeleccionadas )
			throws Exception {
		
		Map<String, Object> resul = new HashMap<String, Object>();
		Map<Long, String> nuevasCuentas = new HashMap<Long, String>();
		List<Long> raSeleccionados = new ArrayList<Long>();
		List<Long> staffSeleccionados = new ArrayList<Long>();
		List<ResponsableAdulto> responsables = new ArrayList<ResponsableAdulto>();
		
		String [] ids = ctasSeleccionadas.split(",");
		String [] nrosCta = nrosCuenta.split(",");
		
		for (int i = 0; i < ids.length; i++) {
			String[] id = ids[i].split("-");
			if(id[1].equals(CreacionCuentaDTO.RA)){
				raSeleccionados.add(Long.parseLong( id[0]));
			}else{
				staffSeleccionados.add(Long.parseLong( id[0]));
			}
			nuevasCuentas.put(Long.parseLong( id[0]), nrosCta[i]);
		}
		
		if(CollectionUtils.isNotEmpty(raSeleccionados)){
			responsables = srvResponsable.obtenerGrupo("id", raSeleccionados);
		}	
		
		for (ResponsableAdulto responsable : responsables) {
			String nroCuenta = nuevasCuentas.get(responsable.getId());
			responsable.setNroCuenta(nroCuenta);
			responsable.setEstadoCuenta(EstadoCuenta.ACTIVA);
			srvResponsable.agregarResponsable(responsable);
			actualizarPanelEA(responsable);
		}
        
        resul.put("mensaje", "Las cuentas seleccionadas se crearon exitosamente.");
		Banco bancoIndustrial = srvBanco.devolverBancoPorNombre(BANCO_INDUSTRIAL);
		resul.put("cuentasACrear", srvCuenta.obtenerListaCuentasACrear(bancoIndustrial, false));
		resul.put("tipos", new String[]{CreacionCuentaDTO.RA, CreacionCuentaDTO.STAFF});
		return forward("/cuenta/cargaManualCuenta", resul);
	}
	
	   /**
	    * Valida si existe una cuenta asociada al responsable o al staff cuyo cuil se ingreso.
	 * @param request
	 * @param response
	 * @param cuil
	 */
	@RequestMapping("/cuenta/validarCuilCreacionCuenta.do")
	    public void validarCuilCreacionCuenta(HttpServletRequest request,HttpServletResponse response, 
	    		@RequestParam(required=false, value="cuil") String cuil) {
			JSONObject object = new JSONObject();
			boolean existeCta = false;
	    	if(StringUtils.isNotBlank(cuil)){
	    	  String cuilIngresado = cuil;
    	      ResponsableAdulto responsable = srvResponsable.obtenerResponsablePorCuil(cuilIngresado);
    	      if (responsable != null){
    	    	  if(responsable.getNroCuenta() != null){
    	    		  existeCta  = true;
    	    	  }
    	      }
	    	}
			try {
				object.put("existeCuenta", existeCta );	
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

		
	@RequestMapping("/cuenta/obtenerCuentasPorBanco.do")
	public void obtenerCuentasPorBanco(@RequestParam("idBanco") Long idBanco, 
			@RequestParam(required= false, value="todas") Boolean todas,
			HttpServletResponse response)
	throws JSONException {
		JSONObject resp = new JSONObject();
		
		try {

			JSONArray cuentas = new JSONArray();
			//Si viene todas en true significa que trae todas las cuentas que estan en la BD sin importar su estado(creadas o no).
			boolean traerTodasCuentas = todas != null && todas.booleanValue();
			if(idBanco != null){	
				List<CreacionCuentaDTO> cuentasFiltradas = null;
				if(idBanco.equals(0L)){
					boolean traerCuentasMenosIndustrial = true;
					if(traerTodasCuentas){						
//						cuentasFiltradas = srvCuenta.obtenerListaCuentasTodas(null);
					}else{
						cuentasFiltradas = srvCuenta.obtenerListaCuentasACrear(null, traerCuentasMenosIndustrial);
					}	
				}else {
					Banco bancoSeleccionado = srvBanco.obtenerBanco(idBanco);
					if(traerTodasCuentas){
//						cuentasFiltradas = srvCuenta.obtenerListaCuentasTodas(bancoSeleccionado);
					}else{
						cuentasFiltradas = srvCuenta.obtenerListaCuentasACrear(bancoSeleccionado, false);
					}
					
				}	
	
				for (CreacionCuentaDTO cuenta : cuentasFiltradas) {
					JSONArray ctaObj = new JSONArray();
					ctaObj.put(cuenta.getId() + "-" + cuenta.getTipoPersona());
					ctaObj.put(cuenta.getBanco());	
					//alumno
					String nombreApellidoAlumno = (cuenta.getNombreAlumno() != null ? cuenta.getApellidoAlumno() + ", " + cuenta.getNombreAlumno() : cuenta.getApellidoAlumno());
					ctaObj.put(nombreApellidoAlumno);
					//ra o staff
					ctaObj.put(cuenta.getApellido() + ", " + cuenta.getNombre());
					ctaObj.put(cuenta.getNroCuil());
					//rr
					String nombreApellidoRR = (cuenta.getNombreRR() != null ? cuenta.getApellidoRR() + ", " + cuenta.getNombreRR() : cuenta.getApellidoRR());
					ctaObj.put(nombreApellidoRR);
					//zona
					ctaObj.put(cuenta.getZona());
					if(traerTodasCuentas){
						String fechaExp = "";
						if(cuenta.getFechaExportacion() != null){
							fechaExp = Formateador.formatearFecha(cuenta.getFechaExportacion(), "dd/MM/yyyy");
						}
						ctaObj.put(fechaExp);
						if(cuenta.getEstado()!= null){
						ctaObj.put(cuenta.getEstado().getValor());
						String motivo = ( cuenta.getEstado().equals(EstadoCuenta.FALLIDA) ? cuenta.getMotivoFallido() : "");
						ctaObj.put(motivo);
						}else{
							ctaObj.put(EstadoCuenta.NO_SOLICITADA.getValor());
							ctaObj.put("");
						}
						String botonNotificar = "<div  style=\"width:0.5cm\" class=\"ui-state-default ui-corner-all\">" + 
							"<a  onclick=\"notificarFallido(\'"+ cuenta.getId()+ "\',\'" + cuenta.getTipoPersona() + "\')\">" + 
							"<span class=\"ui-icon ui-icon-alert\" >" + 
							"</span></a></div>";
						ctaObj.put(botonNotificar);

					}
					cuentas.put(ctaObj);
				}
			}
			
			resp.put("aaData", cuentas);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("ISO-8859-1");
		try {
			response.getWriter().write(resp.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@RequestMapping("/cuenta/notificarFallido.do")
	public ModelAndView notificarFallido(@RequestParam("id") String id,
			@RequestParam("tipoPersona") String tipoPersona,
			@RequestParam("motivo") String motivo){
		
		if(tipoPersona.equals(CreacionCuentaDTO.RA)){
			ResponsableAdulto ra = srvResponsable.obtenerPorId(Long.parseLong(id));
			ra.setEstadoCuenta(EstadoCuenta.FALLIDA);
			ra.setMotivoFallidoCuenta(motivo);
			srvResponsable.agregarResponsable(ra);
			actualizarPanelEA(ra);
		}
		
		Map<String, Object> resul = new HashMap<String, Object>();
		resul.put("bancos", srvBanco.obtenerTodos());
		return forward("/cuenta/informeCuentas", resul);
	}

	
	@RequestMapping("/cuenta/verCuentasInactivas.do")
	public ModelAndView verCuentasInactivas(HttpServletRequest request, HttpSession session, 
			@RequestParam(required= false, value="idBanco") String idBanco,
			@RequestParam(required= false, value="becado") String becado,
			@RequestParam(required= false, value="titular") String titular,
			@RequestParam(required= false, value="numCuenta") String numCuenta,
			@RequestParam(required=false, value="dniTitular") String dniTitular,
			@RequestParam(required= false, value="zona") String zona,
			@RequestParam(required= false, value="idZona") Long idZona,
			@RequestParam(required=false, value="mensaje") String mensaje,
			@RequestParam(required=false, value="error") String error) throws ParseException{
		
		session.setAttribute("menu", ConstantesMenu.menuAdministracion);
		
		Long zonaId = idZona != null && idZona.equals(0) ? null : idZona;
		Integer dniRA = null;
		Map<String, Object> resul = new HashMap<String, Object>();
		boolean export = request.getParameter(TableTagParameters.PARAMETER_EXPORTING) != null; 
		ExtendedPaginatedList listaCuentasPaginadas = null;
		
		if(dniTitular != null){
			if(dniTitular == "")
				dniTitular=null;
			else{
				try {
					dniRA = new Integer(dniTitular);					
				} catch (NumberFormatException e) {
					dniTitular=null;
				}
			}			
		}

    	if ("null".equals(idBanco) || idBanco == null ) {
    		listaCuentasPaginadas = paginarCuentasInactivas(0L, export, request, becado, titular, numCuenta, dniRA, zonaId);
		}else{
			listaCuentasPaginadas = paginarCuentasInactivas(new Long(idBanco), export, request, becado, titular, numCuenta, dniRA, zonaId);
		}
    	
       	WebUtils.setSessionAttribute(request, "cuentaList", listaCuentasPaginadas);
        resul.put("cuentas", listaCuentasPaginadas);
       	resul.put("bancos", srvBanco.obtenerTodos());
        resul.put("becado", becado);
        resul.put("titular", titular);
        resul.put("numCuenta", numCuenta);
        resul.put("dniTitular", dniTitular);
        resul.put("idZona", zonaId);
        resul.put("zona", zona);
//        resul.put("idBanco", idBanco);
        resul.put("idBanco", idBanco.equals("null")?0:Long.parseLong(idBanco));//DMS 7/8/23 lo paso a long para evitar excepcion en pagos anteriores
        
		if(StringUtils.isNotBlank(mensaje))
			resul.put("mensaje", mensaje);
		if(StringUtils.isNotBlank(error))
			resul.put("error", error);
        
		return forward("/cuenta/cuentasInactivas", resul);
	}

	private ExtendedPaginatedList paginarCuentasInactivas(long idBanco,	boolean export, HttpServletRequest request, String becado,
			String titular, String numCuenta, Integer dniRA, Long zonaId) {
		
		List<ResponsableAdulto> cuentasInactivas = null;
		
		ExtendedPaginatedList listaPaginada = paginateListFactory.getPaginatedListFromRequest(request);
		
		Banco bancoSeleccionado = srvBanco.obtenerBanco(idBanco);
		int totalRowsFiltrados = responsableSrv.obtenerCantidadCuentasInactivas(bancoSeleccionado, becado, titular, numCuenta, dniRA, zonaId);
		
		//Si es un export debo cargar toda la lista entera, si no lo es entonces se carga la lista de a una pagina por vez
		if(export){
			cuentasInactivas = responsableSrv.obtenerCuentasInactivas(bancoSeleccionado, becado, titular, numCuenta, dniRA, zonaId, 0,
					totalRowsFiltrados, listaPaginada.getSortDirection(), listaPaginada.getSortCriterion());
		}else{
			cuentasInactivas = responsableSrv.obtenerCuentasInactivas(bancoSeleccionado, becado, titular, numCuenta, dniRA, zonaId,
					listaPaginada.getFirstRecordIndex(), listaPaginada.getPageSize(), listaPaginada.getSortDirection(), listaPaginada.getSortCriterion());
		}
		listaPaginada.setList(cuentasInactivas);
		listaPaginada.setTotalNumberOfRows(totalRowsFiltrados);

		return listaPaginada;
	}
	
	@RequestMapping("/cuenta/moficarEstadoCuenta.do")
	public ModelAndView moficarEstadoCuenta(HttpServletRequest request,	
			HttpSession session,
			@RequestParam("idRA") String id)  throws ParseException{

		String mensaje = "";
		String error = "";
		try {
			ResponsableAdulto ra = srvResponsable.obtenerPorId(Long.parseLong(id));
			ra.setEstadoCuenta(EstadoCuenta.ACTIVA);
			srvResponsable.agregarResponsable(ra);
			actualizarPanelEA(ra);
			mensaje = "Se modific� el estado de la cuenta del Titular " + ra.getApellido() + ", " + ra.getNombre() + " de manera satisfactoria";
		} catch (Exception e) {
			//System.out.println("************" + e.getMessage() + "******************");
			error = "Se produjo un error al querer modificar el estado de la cuenta del Titular seleccionado";
		}
		
		
		return verInformeCuentas(request, session, null, null, null, null, null, null, null, null, null, null,null, mensaje, error);
	}
	
}
