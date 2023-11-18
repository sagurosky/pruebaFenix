package org.cimientos.intranet.web.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.EstadoCuenta;
import org.cimientos.intranet.modelo.Pago;
import org.cimientos.intranet.modelo.Periodo;
import org.cimientos.intranet.modelo.banco.Banco;
import org.cimientos.intranet.modelo.perfil.AlumnoPanelEA;
import org.cimientos.intranet.modelo.perfilEA.PerfilEA;
import org.cimientos.intranet.modelo.perfilRR.PerfilRR;
import org.cimientos.intranet.modelo.persona.Persona;
import org.cimientos.intranet.modelo.ubicacion.ZonaCimientos;
import org.cimientos.intranet.modelo.usuario.Recordatorio;
import org.cimientos.intranet.modelo.usuario.Usuario;
import org.cimientos.intranet.servicio.AlumnoPanelEASrv;
import org.cimientos.intranet.servicio.BancoSrv;
import org.cimientos.intranet.servicio.CicloProgramaSrv;
import org.cimientos.intranet.servicio.PagoSrv;
import org.cimientos.intranet.servicio.PerfilEASrv;
import org.cimientos.intranet.servicio.PerfilRRSrv;
import org.cimientos.intranet.servicio.PeriodoSrv;
import org.cimientos.intranet.servicio.RecordatorioSrv;
import org.cimientos.intranet.servicio.UsuarioSrv;
import org.cimientos.intranet.servicio.ZonaCimientosSrv;
import org.cimientos.intranet.utils.ConstantesMenu;
import org.cimientos.intranet.utils.Formateador;
import org.cimientos.intranet.utils.paginacion.ExtendedPaginatedList;
import org.cimientos.intranet.utils.paginacion.PaginateListFactory;
import org.cimientos.intranet.utils.pagos.ArchivoPago;
import org.cimientos.intranet.utils.pagos.ArchivoPagoBecaGalicia;
import org.cimientos.intranet.utils.pagos.ArchivoPagoBecaIndustrial;
import org.cimientos.intranet.utils.pagos.ArchivoPagoBecaMacro;
import org.cimientos.intranet.utils.pagos.ArchivoPagoBecaSupervielle;
import org.cimientos.intranet.utils.pagos.ArchivoPagoBecaXGalicia;
import org.cimientos.intranet.utils.pagos.ArchivoPagoBecaSantander;
import org.displaytag.properties.SortOrderEnum;
import org.displaytag.tags.TableTagParameters;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;




import com.cimientos.intranet.dto.ZonaCimientosDTO;
import com.cimientos.intranet.enumerativos.EstadoPago;


/**
 * @author msagarduy
 * 
 */
@Controller
@RequestMapping("/pago/*")
public class PagoController extends BaseController{
	private static final Logger log = Logger.getLogger(PagoController.class);
	
	private static final Object BANCO_GALICIA = "Galicia";

	private static final Object BANCO_MACRO = "Macro";

	private static final Object BANCO_INDUSTRIAL = "Industrial";

	
	private static final Object BANCO_SUPERVIELLE = "Supervielle";
	
	private static final Object BANCO_SANTANDER = "Santander";
	
	private static final Object BANCO_FUNDACION_PERALTA = "Galicia FAP Tucum�n";
	
	private static final Object GALICIA_FAP_CATAMARCA = "Galicia FAP Catamarca";
	
	private static final Object GALICIA_FAP_SGO_DEL_ESTERO = "Galicia FAP Sgo del Estero";
	
	private static final Object GALICIA_FAP_JUJUY = "Galicia FAP Jujuy";
	
	private static final Object MACRO_FAP_TARTAGAL = "Macro FAP Tartagal";
	
	private static final Object GALICIA_FAP_VILLA_MARIA = "Galicia FAP Villa Mar�a";

	@Autowired
	private ZonaCimientosSrv zonaCimientosSrv;
	
	@Autowired
	private PaginateListFactory paginateListFactory;
	
	@Autowired
	private PagoSrv srvPago;
	
	@Autowired
	private PerfilEASrv srvEa;
	
	@Autowired
	private RecordatorioSrv srvRecordatorio;
	
	@Autowired
	private PerfilRRSrv srvRr;
	
	@Autowired
	private BancoSrv srvBanco;
	
	@Autowired
	private AlumnoPanelEASrv panelEaSrv;
	
	@Autowired
	private CicloProgramaSrv cicloProgramaSrv;
	
	@Autowired
	private PeriodoSrv svrPeriodo;
	
	@Autowired
	UsuarioSrv srvUsuario;
	
	
	@RequestMapping("/pago/listaPagoEntrevistadoresView.do")
	public ModelAndView mostrarPagoEntrevistadores()
	{
		Map<String, Object> resul = new HashMap<String, Object>();

		return forward("/pago/listaPagoEntrevistadores", resul);
	}


	@RequestMapping("/pago/verAprobadosNoAprobView.do")
	public ModelAndView mostrarPagosAprobadosNoAprobados(HttpServletRequest request, HttpSession session,
			@RequestParam(required= false, value="idBanco") String idBanco,
			@RequestParam(required= false, value="becado") String becado,
			@RequestParam(required= false, value="ra") String ra,
//			@RequestParam(required= false, value="zona") String zona,
			@RequestParam(required= false, value="idsZona") List<Long> idsZona,
			@RequestParam(required= false, value="estadoCuenta") String estadoCta,
			@RequestParam(required= false, value="idsEstadoCuenta") List<Integer> idsEstadoCuenta,
			@RequestParam(required= false, value="_chk") List<Long> idPagos,
			@RequestParam(required= false, value="page") Long page,
			@RequestParam(required= false, value="mostrarTotal") Boolean verTotal,
			@RequestParam(required= false, value="limpiarChks") Boolean limpiarChecks,
			@RequestParam(required= false, value="totalPagos") String totalPagos,
			@RequestParam(required= false, value="sort") String sort,
			@RequestParam(required= false, value="dir") String dir,
			@RequestParam(required= false, value="idsPeriodo") List<Long> idPeriodo
			) throws ParseException
	{
		
		
		Map<String, Object> resul = new HashMap<String, Object>();
		resul.put("bancos", srvBanco.obtenerTodos());
		session.setAttribute("menu", ConstantesMenu.menuAdministracion);
		Double total = null;
		if(totalPagos != null && totalPagos.contains(","))
		{
			totalPagos = totalPagos.replace(",", ".");
			total = Double.valueOf(totalPagos);
		}
		else
		{
			total = 0d;
		}
		ExtendedPaginatedList listaPagosBecadosPaginados = null;
//		Long zonaId = idZona != null && idZona.equals(0) ? null : idZona;
//		Long estadoCuentaId = idsEstadoCuenta != null && idsEstadoCuenta.equals(0) ? null : idsEstadoCuenta;
//		Long periodoId = idPeriodo != null && idPeriodo.equals(0L) ? null : idPeriodo;
		List<Long> 		idsLocalPeriodo = null;
		List<Integer>	idsLocalEstadoCuenta = null;
		List<Long> 		idsLocalZona = null;

		if (idsZona!=null && idsZona.size()>0){
			idsLocalZona = new ArrayList<Long>();
			idsLocalZona.addAll(idsZona);

			if (idsLocalZona.contains(0)){
				idsLocalZona.remove(new Long(0));
			}
		}
		
		if (idsEstadoCuenta!=null && idsEstadoCuenta.size()>0){	//ok
			idsLocalEstadoCuenta = new ArrayList<Integer>();
			idsLocalEstadoCuenta.addAll(idsEstadoCuenta);

			if (idsLocalEstadoCuenta.contains(0)){
				idsLocalEstadoCuenta.remove(new Integer(0));
			}
		}
		
		if (idPeriodo!=null && idPeriodo.size()>0){
			idsLocalPeriodo = new ArrayList<Long>();
			idsLocalPeriodo.addAll(idPeriodo);

			if (idsLocalPeriodo.contains(0L)){
				idsLocalPeriodo.remove(new Long(0));
			}
		}
		
		//si el usuario pidio ver el total
		if(verTotal!= null && verTotal){
			if(idPagos!= null && !idPagos.isEmpty() && !limpiarChecks){
				if (idsLocalPeriodo != null && idsLocalPeriodo.size()>0) //si hay periodos seleccionados hay que usarlos
					total = srvPago.obtenerTotalPagosPeriodo(idPagos, idsLocalPeriodo);
				else
					total = srvPago.obtenerTotalPagos(idPagos);
			}else {
				total = 0d;
			}
		}
		boolean export = request.getParameter(TableTagParameters.PARAMETER_EXPORTING) != null; 
		
		//parche para el export
		guardarFiltrosExportacion(request, export, idBanco, becado, ra, idsLocalZona, idsLocalPeriodo, idsEstadoCuenta, null, null);
		
		if ("null".equals(idBanco) || idBanco == null || "".equals(idBanco)) {
    		listaPagosBecadosPaginados = paginarPagosBecados(0L, export, request, becado, ra, idsLocalZona, idsLocalPeriodo, idsEstadoCuenta);
		}else{
			listaPagosBecadosPaginados = paginarPagosBecados(new Long(idBanco), export, request, becado, ra, idsLocalZona, idsLocalPeriodo, idsEstadoCuenta);
		}
		
       	WebUtils.setSessionAttribute(request, "pagosList", listaPagosBecadosPaginados);
       	Double totalFiltro = this.obtenerMontoTotalPagosFiltrados(idBanco, becado, ra, idsLocalZona, idsLocalPeriodo, idsEstadoCuenta);
       	DecimalFormat decimales = new DecimalFormat("#.00");
       	decimales.format(totalFiltro);
       	resul.put("totalFiltro", decimales.format(totalFiltro));
        resul.put("pagosList", listaPagosBecadosPaginados);
       	resul.put("bancos", srvBanco.obtenerTodos());
        resul.put("becado", becado);
//        resul.put("idZona", zonaId);
        resul.put("idsZona", idsZona);
//        resul.put("zona", zona);

        resul.put("zonas", this.obtenerZonaCimientosDto(zonaCimientosSrv.obtenerTodos()));
        
        resul.put("ra", ra);
        resul.put("estadoCuentas",EstadoCuenta.getListaEstados());
        resul.put("periodos", cicloProgramaSrv.obtenerCicloActual().getPeriodos());
        resul.put("idsPeriodo", idPeriodo);
        resul.put("idBanco", idBanco);
        resul.put("idsEstadoCuenta", idsEstadoCuenta);
        	      
        if(total != 0.0)
        	resul.put("totalPagos", decimales.format(total));
        else
        	resul.put("totalPagos", total);
        resul.put("mostrarTotal", null);
        resul.put("limpiarChks", null);
        
        resul.put("page", page);
        resul.put("sort", sort);
        resul.put("dir", dir);
		return forward("/pago/verAprobadosNoAprob", resul);
	}

	private List<ZonaCimientosDTO> obtenerZonaCimientosDto(List<ZonaCimientos> padrinos) {
		List<ZonaCimientosDTO> dtos = new ArrayList<ZonaCimientosDTO>();

		for (ZonaCimientos pp : padrinos) {
			ZonaCimientosDTO dto = new ZonaCimientosDTO();
			dto.setNombre(pp.getNombre());

			if (dto.getNombre() != null && dto.getNombre().length() > 30)
				dto.setNombre(dto.getNombre().substring(0, 30).trim());

			dto.setId(pp.getId());
			
			dtos.add(dto);
		}
		
		return dtos;
	}
	
	
	/**
	 * Se utiliza para guardar los filtros de busqueda en la sesion
	 * solo para que los pueda utilizar el exportar
	 * @param request
	 * @param export
	 * @param idBanco
	 * @param becado
	 * @param ra
	 * @param idZona
	 * @param idEstadoCuenta
	 */
	private void guardarFiltrosExportacion(HttpServletRequest request,
			boolean export, String idBanco, String becado, String ra,
			List<Long> idZona, List<Long> idPeriodo, List<Integer> idEstadoCuenta, List<Integer> idEstadoPago, CicloPrograma ciclo) {
		//si es una busqueda guardo los filtros de busqueda
		if(!export){
			request.getSession().setAttribute("filtroBanco", idBanco);
			request.getSession().setAttribute("filtroBecado", becado);
			request.getSession().setAttribute("filtroRA", ra);
			request.getSession().setAttribute("filtroZona", idZona != null && idZona.equals(0) ? null : idZona);
			request.getSession().setAttribute("filtroEstado", idEstadoCuenta != null && idEstadoCuenta.equals(0) ? null : idEstadoCuenta);
			request.getSession().setAttribute("filtroPeriodo", idPeriodo != null && idPeriodo.equals(0) ? null : idPeriodo);
			request.getSession().setAttribute("filtroEstadoPago", idEstadoPago != null && idEstadoPago.equals(0) ? null : idEstadoPago);
			request.getSession().setAttribute("filtroCiclo", ciclo != null ? ciclo : null);
		}
	}
	

	/**
	 * Obtiene el monto total de los pagos filtrados
	 * @param idBanco
	 * @param becado
	 * @param ra
	 * @param zonaId
	 * @param estadoCuentaId
	 * @return
	 */
	private Double obtenerMontoTotalPagosFiltrados(String idBanco,
			String becado, String ra, List<Long > zonaId, List<Long > idPeriodo, List<Integer> estadoCuentaId) {
		Banco bancoSeleccionado = srvBanco.obtenerBanco((StringUtils.isNotBlank(idBanco)&&!idBanco.equals("null")) ? Long.parseLong(idBanco) : 0L);
		return srvPago.obtenerMontoTotalPagosBecadosFiltradosAExportar(bancoSeleccionado, becado, ra, zonaId, idPeriodo, estadoCuentaId);
	}
	
	/**
	 * Obtiene el monto total de los pagos filtrados para pagos anteriores
	 * @param idBanco
	 * @param becado
	 * @param ra
	 * @param periodoId
	 * @param zonaId
	 * @param estadoPagoId
	 * @return
	 */
	private Double obtenerMontoTotalPagosFiltradosAnteriores(String idBanco,
			String becado, String ra, CicloPrograma ciclo, Long periodoId, List<Long > zonaId, Long estadoPagoId) {
		Banco bancoSeleccionado = srvBanco.obtenerBanco((StringUtils.isNotBlank(idBanco)&&!idBanco.equals("null")) ? Long.parseLong(idBanco) : 0L);
		return srvPago.obtenerMontoTotalPagosBecadosFiltradosAnteriores(bancoSeleccionado, becado, ra, ciclo, periodoId, zonaId, estadoPagoId);
	}


	private ExtendedPaginatedList paginarPagosBecados(Long idBanco, boolean export,
			HttpServletRequest request, String becado, String ra, List<Long> zonaId, List<Long > idPeriodo, List<Integer> estadoCuentaId) {

		List<PagoDTO> pagosDTO = null;
		int totalRowsFiltrados = 0;
		
		ExtendedPaginatedList listaPaginada = paginateListFactory.getPaginatedListFromRequest(request);
		
		Banco bancoSeleccionado = srvBanco.obtenerBanco(idBanco);
		

		if(export){
			//parche para el export, toma los filtros de la sesion
			String filtroBanco = (String) request.getSession().getAttribute("filtroBanco");
			becado = (String) request.getSession().getAttribute("filtroBecado");
			ra = (String) request.getSession().getAttribute("filtroRA");
//			zonaId = (Long) request.getSession().getAttribute("filtroZona");
			zonaId = (List<Long>) request.getSession().getAttribute("filtroZona");
			
			idPeriodo = (List<Long>) request.getSession().getAttribute("filtroPeriodo");
			
//			Long filtroEstado = (Long) request.getSession().getAttribute("filtroEstado");
			List<Integer> filtroEstado = (List<Integer>) request.getSession().getAttribute("filtroEstado");
			idBanco = StringUtils.isNotBlank(filtroBanco)? Long.parseLong(filtroBanco) : null;
			estadoCuentaId = filtroEstado;
			totalRowsFiltrados = srvPago.obtenerCantidadPagosBecadosFiltradosAExportar(bancoSeleccionado, becado, ra, zonaId, idPeriodo, 
					estadoCuentaId);
			pagosDTO = obtenerPagosBecadosPaginados(idBanco, becado, ra, zonaId, idPeriodo, estadoCuentaId, 0, 
								totalRowsFiltrados, listaPaginada.getSortDirection(), listaPaginada.getSortCriterion());
		}else{
			totalRowsFiltrados = srvPago.obtenerCantidadPagosBecadosFiltradosAExportar(bancoSeleccionado, becado, ra, zonaId, idPeriodo, 
					estadoCuentaId);
			pagosDTO = obtenerPagosBecadosPaginados(idBanco, becado, ra, zonaId, idPeriodo, estadoCuentaId, listaPaginada.getFirstRecordIndex(), 
								listaPaginada.getPageSize(), listaPaginada.getSortDirection(), listaPaginada.getSortCriterion());
		}
		listaPaginada.setList(pagosDTO);
		listaPaginada.setTotalNumberOfRows(totalRowsFiltrados);

		return listaPaginada;
	}

	@RequestMapping("/pago/verPagosRealizadosView.do")
	public ModelAndView verPagosRealizadosView(HttpServletRequest request, HttpSession session,
			@RequestParam(required= false, value="idBanco") String idBanco,
			@RequestParam(required= false, value="becado") String becado,
			@RequestParam(required= false, value="ra") String ra,
			@RequestParam(required= false, value="zona") String zona,
			@RequestParam(required= false, value="idZona") Long idZona,
			@RequestParam(required= false, value="estadoPago") String estadoPago,
			@RequestParam(required= false, value="idEstadoPago") Long idEstadoPago,
			@RequestParam(required= false, value="idCiclo") String idCiclo,
			@RequestParam(required= false, value="idPeriodo") Long periodoId
			) throws ParseException
	{
		Long zonaId = idZona != null && idZona.equals(0) ? null : idZona;
		Long estadoPagoId = idEstadoPago != null && idEstadoPago.equals(0) ? null : idEstadoPago;
		Long idPeriodo = periodoId != null && periodoId.equals(0L) ? null : periodoId;
		CicloPrograma ciclo = null;
		Long cicloId = null;

		List<Long> idsLocalZona = null;
		
		if (idZona != null) {
			if (!idZona.equals(0L)) {
				idsLocalZona = new ArrayList<Long>();
				idsLocalZona.add(idZona);
			}
		}
		
		if(StringUtils.isNotBlank(idCiclo)){
			cicloId = Long.parseLong(idCiclo);
		}else {
			cicloId = cicloProgramaSrv.obtenerCicloActual().getId();
			idCiclo = cicloId.toString();
		}	
		
		if (!cicloId.equals(0L)) {
			ciclo = cicloProgramaSrv.obtenerCiclo(cicloId);
		}
		
		Map<String, Object> resul = new HashMap<String, Object>();
		boolean export = request.getParameter(TableTagParameters.PARAMETER_EXPORTING) != null; 
		ExtendedPaginatedList listaPagosPaginados = null;
		
    	if ("null".equals(idBanco) || idBanco == null ) {
    		listaPagosPaginados = paginarPagosAnteriores(0L, export, request, becado, ra, ciclo, idPeriodo, idsLocalZona, estadoPagoId);
		}else{
			listaPagosPaginados = paginarPagosAnteriores(new Long(idBanco), export, request, becado, ra, ciclo, idPeriodo, idsLocalZona, estadoPagoId);
		}
    	
       	WebUtils.setSessionAttribute(request, "pagosList", listaPagosPaginados);
        resul.put("pagosList", listaPagosPaginados);
       	resul.put("bancos", srvBanco.obtenerTodos());
        resul.put("becado", becado);
        resul.put("idZona", zonaId);
        resul.put("zona", zona);
        resul.put("ra", ra);
        resul.put("estadoPagos",EstadoPago.getListaEstadoPagosAnteriores());
        resul.put("idEstadoPago",idEstadoPago);
        
        
        resul.put("idBanco", idBanco.equals("null")?0:Long.parseLong(idBanco));//DMS 7/8/23 lo paso a long para evitar excepcion en pagos anteriores
        
        resul.put("periodos", svrPeriodo.buscarPeriodosPorCiclo(cicloId));
        resul.put("idPeriodo", idPeriodo);
        List<CicloPrograma> ciclos = cicloProgramaSrv.obtenerCiclosClonarBecas();
        ciclos.remove(ciclos.size()-1);
        resul.put("ciclos", ciclos);
        resul.put("idCiclo", cicloId);

        Double totalFiltro = this.obtenerMontoTotalPagosFiltradosAnteriores(idBanco, becado, ra, ciclo, idPeriodo, idsLocalZona, estadoPagoId);
    	DecimalFormat decimales = new DecimalFormat("#.00");
        resul.put("totalFiltro", decimales.format(totalFiltro));

        return forward("/pago/listaPagoBecados", resul);
	}
	
	
	/**
	 * @param idBanco
	 * @param request
	 * @param todas
	 * @param export
	 * @return ExtendedPaginatedList
	 * @throws ParseException 
	 * @author esalvador
	 */
	private ExtendedPaginatedList paginarPagosAnteriores(Long idBanco, boolean export, HttpServletRequest request,
			String becado, String ra, CicloPrograma ciclo, Long periodoId, List<Long> zonaId, Long estadoPagoId) throws ParseException {
		
		List<PagoDTO> pagosDTO = null;
		
		ExtendedPaginatedList listaPaginada = paginateListFactory.getPaginatedListFromRequest(request);
		
				
		Banco bancoSeleccionado = srvBanco.obtenerBanco(idBanco);
		int totalRowsFiltrados = srvPago.obtenerCantidadPagosFiltradosAExportar(bancoSeleccionado, becado, ra, ciclo, periodoId, zonaId, estadoPagoId);

		if(export){
			pagosDTO = obtenerPagosAnterioresPaginados(idBanco, becado, ra, ciclo, periodoId, zonaId, estadoPagoId, 0, totalRowsFiltrados, 
					listaPaginada.getSortDirection(), listaPaginada.getSortCriterion());
		}else{
			pagosDTO = obtenerPagosAnterioresPaginados(idBanco, becado, ra, ciclo, periodoId, zonaId, estadoPagoId,listaPaginada.getFirstRecordIndex(), listaPaginada.getPageSize(),
					listaPaginada.getSortDirection(), listaPaginada.getSortCriterion());
		}
		listaPaginada.setList(pagosDTO);
		listaPaginada.setTotalNumberOfRows(totalRowsFiltrados);

		return listaPaginada;
	}
	
	
	public List<PagoDTO> obtenerPagosAnterioresPaginados(Long idBanco, String becado, String ra, CicloPrograma ciclo, Long periodoId, 
			List<Long > zonaId, Long idEstadoCuenta, int firstResult, int maxResults, SortOrderEnum sortDirection, String sortCriterion){

		List<PagoDTO> pagosFiltrados = new ArrayList<PagoDTO>();
			if(idBanco != null){
				if(idBanco.equals(0L)){
					pagosFiltrados = srvPago.obtenerPagosFiltradosRealizadosPorBanco(null,  becado, ra, ciclo, periodoId, zonaId, idEstadoCuenta,
							firstResult, maxResults, sortDirection, sortCriterion);
				}else {
					Banco bancoSeleccionado = srvBanco.obtenerBanco(idBanco);
					pagosFiltrados = srvPago.obtenerPagosFiltradosRealizadosPorBanco(bancoSeleccionado, becado, ra, ciclo, periodoId, zonaId, 
							idEstadoCuenta, firstResult, maxResults, sortDirection, sortCriterion);
				}	
			}
		return pagosFiltrados;
	}
	
	
	public List<PagoDTO> obtenerPagosBecadosPaginados(Long idBanco, String becado, String ra, List<Long > zonaId, List<Long > idPeriodo, 
			List<Integer> idEstadoCuenta, int firstResult, int maxResults, SortOrderEnum sortDirection, String sortCriterion){

		List<PagoDTO> pagosFiltrados = new ArrayList<PagoDTO>();
			if(idBanco != null){
				if(idBanco.equals(0L)){
					pagosFiltrados = srvPago.obtenerPagosBecadosFiltradosRealizadosPorBanco(null, becado, ra, zonaId, idPeriodo, 
															idEstadoCuenta, firstResult, maxResults, sortDirection, sortCriterion);
				}else {
					Banco bancoSeleccionado = srvBanco.obtenerBanco(idBanco);
					pagosFiltrados = srvPago.obtenerPagosBecadosFiltradosRealizadosPorBanco(bancoSeleccionado, becado, ra, zonaId, idPeriodo, 
															idEstadoCuenta, firstResult, maxResults, sortDirection, sortCriterion);
				}	
			}
			//esto se hace para el caso que no haya filtro de banco seleccionado. Opci�n "Todos"
			else
			{
				pagosFiltrados = srvPago.obtenerPagosBecadosFiltradosRealizadosPorBanco(null,  becado, ra, zonaId, idPeriodo, 
													idEstadoCuenta, firstResult, maxResults, sortDirection, sortCriterion);
			}
		return pagosFiltrados;
	}
	
	
	@RequestMapping("/pago/listaPagoBecados.do")
	public ModelAndView informePagoBecado(
										  @RequestParam(required=false,value="idsEa") List<Long> idsEa,
										  @RequestParam(required=false,value="pagosSeleccionados") String pagosSeleccionados) throws ParseException
	{
		Map<String, Object> resul = new HashMap<String, Object>();
		List<Recordatorio> listaRecordatorios = new ArrayList<Recordatorio>();
		if(StringUtils.isNotBlank(pagosSeleccionados))
		{
			List<Pago> pagosFallidos = srvPago.obtenerGrupo("id", Formateador.toListOfLongs(pagosSeleccionados));
			List<PerfilEA> perfilesEa = srvEa.obtenerPagosEAsPorIds(idsEa);
			List<PerfilRR> perfilesRr = new ArrayList<PerfilRR>();
			Recordatorio recordatorio = new Recordatorio("Aviso Pagos Fallidos", "Pagos Fallidos", new Date());
			recordatorio.setPagos(pagosFallidos);
			listaRecordatorios.add(recordatorio);
			for (PerfilEA perfilEA : perfilesEa) {
				perfilEA.setRecordatorios(listaRecordatorios);
				
				PerfilRR rr = perfilEA.getRr();
				perfilesRr.add(rr);
				rr.setRecordatorios(listaRecordatorios);
			}
			recordatorio.setEa(perfilesEa);
			recordatorio.setRr(perfilesRr);
			listaRecordatorios.add(recordatorio);
			srvRecordatorio.agregarRecordatorio(recordatorio);
			srvEa.agregarTodos(perfilesEa);
			srvRr.agregarPerfilesRR(perfilesRr);
			resul.put("perfilesEA", perfilesEa);
			resul.put("recordatorio", recordatorio);
			resul.put("recordatorios", listaRecordatorios);
			return forward("/pago/verEas", resul);
			
		}
		else 
		{
			//FIXME ver !
			List<Pago> pagos = srvPago.obtenerListaPagosFallidosRealizadosBecados();
			if(pagos != null)
			{
				resul.put("listaPagoBecados", pagos);
				return forward("/pago/listaPagoBecados", resul);
			}
			else
			{
				resul.put("listaPagoBecados", null);
				return forward("/pago/listaPagoBecados", resul);
			}
		}
	}
	
	@RequestMapping("/pago/listaPagoEntrevistadores.do")
	public ModelAndView informePagoEntrevistador(@RequestParam (required=false,value="fechaInicio") String fechaInicio,
										  @RequestParam (required=false,value="fechaFin") String fechaFin,
										  @RequestParam(required=false,value="idsEa") List<Long> idsEa
										  ) throws ParseException
	{
		Map<String, Object> resul = new HashMap<String, Object>();
		Date fInicio = Formateador.parsearFechaPatron(fechaInicio);
		Date fFin = Formateador.parsearFechaPatron(fechaFin);
		List<Pago> pagos = srvPago.obtenerListaEstadoPagoEntrevistadores(fInicio, fFin);
		resul.put("listaPagoEntrevistadores", pagos);

		return forward("/pago/listaPagoEntrevistadores", resul);
	
	}

	
	@RequestMapping("/pago/verPagosRecordatorio.do")
	public ModelAndView mostrarPagosRecordatorio(@RequestParam("idRecordatorio") Long idRecordatorio)
	{
		Map<String, Object> resul = new HashMap<String, Object>();

		Recordatorio recordatorio = srvRecordatorio.obtenerRecordatorio(idRecordatorio);
		resul.put("recordatorio", recordatorio);

		return forward("/pago/verPagosRecordatorio", resul);
	}
	
	
	@RequestMapping("/pago/obtenerPagosPorBanco.do")
	public void obtenerPagosPorBanco(@RequestParam("idBanco") Long idBanco, 
			@RequestParam(required=false, value="selectedPagos") String selectedPagos, HttpServletResponse response)
	throws JSONException {
		JSONObject resp = new JSONObject();
		
		try {

			JSONArray pagos = new JSONArray();

			if(idBanco != null){	
				List<PagoDTO> filtrados = null;
				if(idBanco.equals(0L)){
					filtrados = srvPago.obtenerPagosBecasPorBanco(null);
				}else {
					Banco bancoSeleccionado = srvBanco.obtenerBanco(idBanco);	
					filtrados = srvPago.obtenerPagosBecasPorBanco(bancoSeleccionado);
				}	
				
				for (PagoDTO pago : filtrados) {
					JSONArray pagoObj = new JSONArray();
					pagoObj.put(pago.getBecado().getId());
					pagoObj.put(pago.getBecado().getDatosPersonales().getApellido() + ", " + pago.getBecado().getDatosPersonales().getNombre() );
					pagoObj.put(pago.getResponsable() != null ? 
							pago.getResponsable().getApellido() + ", " 
							+ pago.getResponsable().getNombre() : "");
					pagoObj.put(pago.getResponsable() != null ? pago.getResponsable().getCuilCuit() : "");
					pagoObj.put(pago.getResponsable().getEstadoCuenta()!= null ? pago.getResponsable().getEstadoCuenta().getValor() : EstadoCuenta.NO_SOLICITADA.getValor());

					String periodos = "";
					for (Periodo periodo : pago.getListaPeriodos()) {
						periodos += periodo.getNombre() + ";";
					}
					pagoObj.put(periodos);

					pagoObj.put(pago.getBecado().getEscuela().getLocalidad().getZona().getNombre());

					Double montoTotal = (pago.getMonto()!= null ? pago.getMonto() + ( pago.getExtra() != null ? pago.getExtra() : 0) : 0);
					pagoObj.put(montoTotal.toString());
					
					pagos.put(pagoObj);

				}
	
			}
			
			resp.put("aaData", pagos);
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
	
	

	@RequestMapping("/pago/verTotalPagos.do")
	protected ModelAndView verTotal(HttpServletRequest request,
			HttpServletResponse response, @RequestParam(required=false,
					value="_chk") List<Long> pagosSeleccionados) throws Exception {
		HashMap<String,Object> map = new HashMap<String, Object>();
		Double total = 0d;
		//obtiene los pagos correspondientes a los alumnos seleccionados
		total = srvPago.obtenerTotalPagos(pagosSeleccionados);
		map.put("totalPagos", total);
		return forward("/pago/verAprobadosNoAprob", map);
	}
	

	@RequestMapping("/pago/generarArchivoPagos.do")
	protected ModelAndView generarExcelPOI(HttpServletRequest request,
						HttpServletResponse response, 
						@RequestParam(required= false, value="idBanco") String idBanco,
						@RequestParam(required= false, value="becado") String becado,
						@RequestParam(required= false, value="ra") String ra,
						@RequestParam(required= false, value="zona") String zona,
						@RequestParam(required= false, value="idsZona") List<Long> idsZona,
//						@RequestParam(required= false, value="idZona") List<Long > idPeriodo,
						@RequestParam(required= false, value="idsPeriodo") List<Long> idPeriodo,
						@RequestParam(required= false, value="estadoCuenta") String estadoCta,
//						@RequestParam(required= false, value="idEstadoCuenta") Long idEstadoCuenta,
						@RequestParam(required= false, value="idEstadoCuenta") List<Integer> idsEstadoCuenta,
						@RequestParam(required= false, value="pagaXGalicia") String pagaXGalicia,						
						@RequestParam(required=false,value="_chk") List<Long> pagosSeleccionados) throws Exception {
			
			HashMap<String,Object> map = new HashMap<String, Object>();
			String fd= request.getParameter("fd");
			String fp= request.getParameter("fp");
			String mensaje = "";
			List<Pago> pagos = new ArrayList<Pago>();
			List<Long> idsPagos;
			ExtendedPaginatedList listaPagosBecadosPaginados = null;
//			Long zonaId = idZona != null && idZona.equals(0) ? null : idZona;
//			Long estadoCuentaId = idEstadoCuenta != null && idEstadoCuenta.equals(0) ? null : idEstadoCuenta;
			Banco bancoSeleccionado = srvBanco.obtenerBanco(StringUtils.isNotBlank(idBanco) ? Long.parseLong(idBanco) : 0L);
			
			//System.out.println(pagaXGalicia);
			List<Long> idsLocalZona = null;
			List<Integer> idsLocalEstadoCuenta = null;
			List<Long> 	idsLocalPeriodo = null;
			
			if (idsZona!=null && idsZona.size()>0){
				idsLocalZona = new ArrayList<Long>();
				idsLocalZona.addAll(idsZona);

				if (idsLocalZona.contains(0)){
					idsLocalZona.remove(new Long(0));
				}
			}

			if (idsEstadoCuenta!=null && idsEstadoCuenta.size()>0){
				idsLocalEstadoCuenta = new ArrayList<Integer>();
				idsLocalEstadoCuenta.addAll(idsEstadoCuenta);

				if (idsLocalEstadoCuenta.contains(0)){
					idsLocalEstadoCuenta.remove(new Integer(0));
				}
			}
			
			if (idPeriodo!=null && idPeriodo.size()>0){
				idsLocalPeriodo = new ArrayList<Long>();
				idsLocalPeriodo.addAll(idPeriodo);

				if (idsLocalPeriodo.contains(0L)){
					idsLocalPeriodo.remove(new Long(0));
				}
			}			
			
			if(pagosSeleccionados != null && !pagosSeleccionados.isEmpty()){
				//obtiene los pagos correspondientes a los alumnos seleccionados
				if (idsLocalPeriodo != null && idsLocalPeriodo.size()>0)  //si hay filtros de periodos, hay que usarlos
					pagos = srvPago.obtenerPagosPorAlumnosPeriodo(pagosSeleccionados, idsLocalPeriodo);
				else
					pagos = srvPago.obtenerPagosPorAlumnos(pagosSeleccionados);
			}else{
				idsPagos = srvPago.obtenerIdsPagosBecasFiltrados(bancoSeleccionado, becado, ra, idsLocalZona, idsLocalPeriodo, idsLocalEstadoCuenta);
				if(idsPagos != null && !idsPagos.isEmpty()){
					if (idsLocalPeriodo != null && idsLocalPeriodo.size()>0)  //si hay filtros de periodos, hay que usarlos
						pagos = srvPago.obtenerPagosPorAlumnosPeriodo(idsPagos, idsLocalPeriodo);
					else
						pagos = srvPago.obtenerPagosPorAlumnos(idsPagos);
				}
			}
			
			mensaje = this.validarGeneracionPagos(pagos);
			if(StringUtils.isBlank(mensaje) && pagos != null && !pagos.isEmpty()){
				
				ArchivoPago archivo = null;
				String excelView = null;
				if (pagaXGalicia!=null){
					//System.out.println("entre");
					archivo = new ArchivoPagoBecaXGalicia(pagos, fd,fp,bancoSeleccionado.getNombre());
					if (idBanco.equals("17")){
						excelView = "FAPpagoBecaXGaliciaExcelView";
					}else{
						
					
						excelView = "pagoBecaXGaliciaExcelView";
					}
					
				}else{
				   
					/*
					if (bancoSeleccionado.getNombre().equals(BANCO_GALICIA)) {
						archivo = new ArchivoPagoBecaGalicia(pagos);
						excelView = "pagoBecaGaliciaExcelView";
					*/
					if (bancoSeleccionado.getNombre().equals(BANCO_GALICIA) || bancoSeleccionado.getNombre().equals(BANCO_FUNDACION_PERALTA)
							|| bancoSeleccionado.getNombre().equals(GALICIA_FAP_CATAMARCA) || bancoSeleccionado.getNombre().equals(GALICIA_FAP_JUJUY)
							|| bancoSeleccionado.getNombre().equals(GALICIA_FAP_VILLA_MARIA)
							|| bancoSeleccionado.getNombre().equals(GALICIA_FAP_SGO_DEL_ESTERO)) {
						archivo = new ArchivoPagoBecaGalicia(pagos);
						excelView = "pagoBecaGaliciaExcelView";
					
					} else if (bancoSeleccionado.getNombre().equals(MACRO_FAP_TARTAGAL)) {
						archivo = new ArchivoPagoBecaMacro(pagos);
						excelView = "FAPpagoBecaGaliciaExcelView";
						
					
					
					
					} else if (bancoSeleccionado.getNombre().equals(BANCO_MACRO)) {
						archivo = new ArchivoPagoBecaMacro(pagos);
						excelView = "pagoBecaMacroExcelView";
						
					} 
					/*
					else if (bancoSeleccionado.getNombre().equals(BANCO_INDUSTRIAL) || bancoSeleccionado.getNombre().equals(BANCO_FUNDACION_PERALTA)
							|| bancoSeleccionado.getNombre().equals(GALICIA_FAP_CATAMARCA) || bancoSeleccionado.getNombre().equals(GALICIA_FAP_JUJUY)
							|| bancoSeleccionado.getNombre().equals(GALICIA_FAP_VILLA_MARIA)
							|| bancoSeleccionado.getNombre().equals(GALICIA_FAP_SGO_DEL_ESTERO) || bancoSeleccionado.getNombre().equals(MACRO_FAP_TARTAGAL)) {
						archivo = new ArchivoPagoBecaIndustrial(pagos);
						excelView = "pagoBecaIndustrialExcelView";
					*/
					
					else if (bancoSeleccionado.getNombre().equals(BANCO_INDUSTRIAL) || bancoSeleccionado.getNombre().equals(MACRO_FAP_TARTAGAL)) {
						archivo = new ArchivoPagoBecaIndustrial(pagos);
						excelView = "pagoBecaIndustrialExcelView";
					
					} else if (bancoSeleccionado.getNombre().equals(BANCO_SUPERVIELLE)) {
						archivo = new ArchivoPagoBecaSupervielle(pagos);
						excelView = "pagoBecaSupervielleExcelView";
					} else if (bancoSeleccionado.getNombre().equals(BANCO_SANTANDER)) {
						archivo = new ArchivoPagoBecaSantander(pagos);
						excelView = "pagoBecaSantanderExcelView";
					}
					
					else {
						map.put("bancos", srvBanco.obtenerTodos());
						String mensajeError =  "Error : Banco inexistente. ";
						map.put("mensaje", mensajeError);
						return forward("/pago/verAprobadosNoAprob", map);
					}
				}   
				map.put("archivo", archivo);
				map.put("srvPago", srvPago);
				map.put("panelEaSrv", panelEaSrv);
				map.put("pagos", pagos);
				
				/*if (bancoSeleccionado.getNombre().equals(BANCO_SUPERVIELLE)){
					map.put("bancos", srvBanco.obtenerTodos());
					String mensajeError =  "Proceso terminado. ";
					map.put("mensaje", mensajeError);
					return forward("/pago/verAprobadosNoAprob", map);
				}else {*/
				return new ModelAndView(excelView,map);
				
				
				
				
			}
			
		//hubo error
		map.put("bancos", srvBanco.obtenerTodos());
		String mensajeError =  "No se ha podido generar el archivo de pago. " + mensaje;
		map.put("mensaje", mensajeError);
    	
		//Consultar si periodo va null!!!
    	listaPagosBecadosPaginados = paginarPagosBecados(0L, false, request, null, null, null, null, null);

    	
       	WebUtils.setSessionAttribute(request, "pagosList", listaPagosBecadosPaginados);
        Double totalFiltro = this.obtenerMontoTotalPagosFiltrados(idBanco, becado, ra, idsLocalZona, idPeriodo, idsLocalEstadoCuenta);
        DecimalFormat decimales = new DecimalFormat("#.00");
       	map.put("totalFiltro", decimales.format(totalFiltro));
		return forward("/pago/verAprobadosNoAprob", map);
		
		
	}

	/**
	 * �	Valor del campo �Numero de cuenta� del RA del becado NO este en blanco.
		�	Valor del campo �Evaluacion del Cobro de la beca� sea igual a �Aprobado�.
		�	Valor del campo �Estado del Alumno� sea igual a �Incorporado� o �Renovado�.
		�	Valor del campo �Estado del Formulario� sea igual a �Aprobado�. VER.
		�	Valor del campo �Cierre de Zona� sea igual a �True�.
	 * @param pagos
	 * @return
	 */
	private String validarGeneracionPagos(List<Pago> pagos) {
		String msj = "";
		boolean ok = true;
		for (Pago pago : pagos) {
			ok = StringUtils.isNotBlank( pago.getBecado().getResponsable1().getNroCuenta());
			if(!ok){
				msj += "Por favor verifique que los responsables cuyos pagos fueron seleccionados posean n� de cuenta.";
			}
		}
		if(pagos == null ||(pagos != null && pagos.isEmpty())){
			msj += "El archivo de pago con los pagos seleccionados ya ha sido generado.";
		}
		return msj;
	}
	
	@RequestMapping("/pago/notificarFallido.do")
	public ModelAndView notificarFallido(@RequestParam("idBecado") String idBecado,
			@RequestParam("fechaExportacion") String fechaExportacion,
			@RequestParam("motivo") String motivo,
			HttpServletRequest request, HttpSession session) throws ParseException
	{
		
		Date fecha = Formateador.parsearFecha(fechaExportacion);
		AlumnoPanelEA alumnoPanel = panelEaSrv.obtenerAlumnoPanelPorIdPerfilAlumno(Long.parseLong(idBecado));
		List<Pago> pagos = srvPago.obtenerPagosPorBecadoYFechaExportacion(Long.parseLong(idBecado), fecha);
		for (Pago pago : pagos) {
			
			pago.setEstadoPago(EstadoPago.FALLIDO);
			pago.setMotivo(motivo);
			alumnoPanel.actualizarSemaforoPago(pago.getEstadoPago());
			srvPago.agregarPago(pago);
		}
		
	
		Map<String, Object> resul = new HashMap<String, Object>();
		resul.put("bancos", srvBanco.obtenerTodos());

		return verPagosRealizadosView(request, session, null, null, null, null, null, null, null, null, null);
	}
	
	@RequestMapping("/pago/verlistaPagosView.do")
	public ModelAndView verListaPagosView(HttpServletRequest request,
			@RequestParam(required= false, value="idBanco") String idBanco,
			@RequestParam(required= false, value="becado") String becado,
			@RequestParam(required= false, value="ra") String ra,
			@RequestParam(required= false, value="idsZona") List<Long> idsZona,
			@RequestParam(required= false, value="idsEstadoCuenta") List<Integer> idsEstadoCuenta,
			@RequestParam(required= false, value="idsEstadoPago") List<Integer> idsEstadoPago,
			@RequestParam(required= false, value="_chk") List<Long> idPagos,
			@RequestParam(required= false, value="page") Long page,
			@RequestParam(required= false, value="mostrarTotal") Boolean verTotal,
			@RequestParam(required= false, value="limpiarChks") Boolean limpiarChecks,
			@RequestParam(required= false, value="sort") String sort,
			@RequestParam(required= false, value="dir") String dir,
			@RequestParam(required= false, value="idCiclo") String idCiclo,
			@RequestParam(required= false, value="idsPeriodo") List<Long> idPeriodo) throws Exception{
		
        HttpSession session = request.getSession();
		session.setAttribute("menu", ConstantesMenu.menuAdministracion);
		Map<String, Object> resul = new HashMap<String, Object>();
		CicloPrograma ciclo = null;
		Long cicloId = null;
		List<Integer> idsLocalEstadoCuenta = null;
		List<Integer> idsLocalEstadoPago = null;
		List<Long> idsLocalZona = null;
		List<Long> idsLocalPeriodo =  null;
		
		if(StringUtils.isNotBlank(idCiclo)){
			cicloId = Long.parseLong(idCiclo);
		}else {
			cicloId = cicloProgramaSrv.obtenerCicloActual().getId();
			idCiclo = cicloId.toString();
		}	
		
		if (!cicloId.equals(0L)) {
			ciclo = cicloProgramaSrv.obtenerCiclo(cicloId);
		}
		
		if (idPeriodo!=null && idPeriodo.size()>0){
			idsLocalPeriodo = new ArrayList<Long>();
			idsLocalPeriodo.addAll(idPeriodo);

			if (idsLocalPeriodo.contains(0L)){
				idsLocalPeriodo.remove(new Long(0));
			}
		}
		
		if (idsZona!=null && idsZona.size()>0){
			idsLocalZona = new ArrayList<Long>();
			idsLocalZona.addAll(idsZona);

			if (idsLocalZona.contains(0)){
				idsLocalZona.remove(new Long(0));
			}
		}
		
		if (idsEstadoCuenta!=null && idsEstadoCuenta.size()>0){	//ok
			idsLocalEstadoCuenta = new ArrayList<Integer>();
			idsLocalEstadoCuenta.addAll(idsEstadoCuenta);

			if (idsLocalEstadoCuenta.contains(0)){
				idsLocalEstadoCuenta.remove(new Integer(0));
			}
		}
		
		if (idsEstadoPago!=null && idsEstadoPago.size()>0){	//ok
			idsLocalEstadoPago = new ArrayList<Integer>();
			idsLocalEstadoPago.addAll(idsEstadoPago);

			if (idsLocalEstadoPago.contains(0)){
				idsLocalEstadoPago.remove(new Integer(0));
			}
		}
	
		boolean export = request.getParameter(TableTagParameters.PARAMETER_EXPORTING) != null; 
		ExtendedPaginatedList listaPagosPaginados = null;
		
		//parche para el export
		guardarFiltrosExportacion(request, export, idBanco, becado, ra, idsLocalZona, idsLocalPeriodo, idsLocalEstadoCuenta, idsLocalEstadoPago, 
				ciclo);
		
    	if ("null".equals(idBanco) || idBanco == null ) {
    		listaPagosPaginados = paginarPagos(0L, export, request, becado, ra, ciclo, idsLocalPeriodo, idsLocalZona, 
    				idsLocalEstadoPago, idsLocalEstadoCuenta);
		}else{
			listaPagosPaginados = paginarPagos(new Long(idBanco), export, request, becado, ra, ciclo, idsLocalPeriodo, idsLocalZona, 
					idsLocalEstadoPago, idsLocalEstadoCuenta);
		}        
 //    	WebUtils.setSessionAttribute(request, "reportePagos", listaPagosPaginados);
        resul.put("reportePagos", listaPagosPaginados);
       	resul.put("bancos", srvBanco.obtenerTodos());
        resul.put("idBanco", idBanco);
        resul.put("becado", becado);
        resul.put("ra", ra);
        resul.put("zonas", this.obtenerZonaCimientosDto(zonaCimientosSrv.obtenerTodos()));
        resul.put("idsZona", idsZona);
        resul.put("estadoPagos",EstadoPago.getListaEstadoPagosBecados());
        resul.put("idsEstadoPago", idsEstadoPago);
        resul.put("estadoCuentas",EstadoCuenta.getListaEstados());
        resul.put("idsEstadoCuenta", idsEstadoCuenta);        
        resul.put("periodos", svrPeriodo.buscarPeriodosPorCiclo(cicloId));
        resul.put("idsPeriodo", idPeriodo);
        List<CicloPrograma> ciclos = cicloProgramaSrv.obtenerCiclosClonarBecas();
        ciclos.remove(ciclos.size()-1);
        resul.put("ciclos", ciclos);
        resul.put("idCiclo", cicloId);


        Double totalFiltro = this.obtenerMontoTotalListaPagosBecados(idBanco, becado, ra, ciclo, idsLocalPeriodo, idsLocalZona, 
        		idsLocalEstadoPago, idsLocalEstadoCuenta);
    	DecimalFormat decimales = new DecimalFormat("#.00");
        resul.put("totalFiltro", decimales.format(totalFiltro));
        
        resul.put("mostrarTotal", null);
        resul.put("limpiarChks", limpiarChecks);        


        return forward("/pago/listaPagos", resul);
	}
	
	private ExtendedPaginatedList paginarPagos(Long idBanco, boolean export, HttpServletRequest request,
			String becado, String ra, CicloPrograma ciclo, List<Long> periodoId, List<Long> zonaId, List<Integer> estadoPagoId,
			List<Integer> estadoCuentaId) throws ParseException {
		
		List<PagoDTO> pagosDTO = null;
		int totalRowsFiltrados = 0;
		ExtendedPaginatedList listaPaginada = paginateListFactory.getPaginatedListFromRequest(request);		
		
		Banco bancoSeleccionado = srvBanco.obtenerBanco(idBanco);
		
		if(export){
			//parche para el export, toma los filtros de la sesion
			String filtroBanco = (String) request.getSession().getAttribute("filtroBanco");
			becado = (String) request.getSession().getAttribute("filtroBecado");
			ra = (String) request.getSession().getAttribute("filtroRA");
			zonaId = (List<Long>) request.getSession().getAttribute("filtroZona");			
			periodoId = (List<Long>) request.getSession().getAttribute("filtroPeriodo");
			List<Integer> filtroEstado = (List<Integer>) request.getSession().getAttribute("filtroEstado");
			List<Integer> filtroEstadoPago = (List<Integer>) request.getSession().getAttribute("filtroEstadoPago");
			ciclo = (CicloPrograma)request.getSession().getAttribute("filtroCiclo");
			idBanco = StringUtils.isNotBlank(filtroBanco)? Long.parseLong(filtroBanco) : null;
			estadoCuentaId = filtroEstado;
			estadoPagoId = filtroEstadoPago;
			totalRowsFiltrados = srvPago.obtenerCantidadListaPagosBecados(bancoSeleccionado, becado, ra, ciclo, periodoId, zonaId, estadoPagoId, 
					estadoCuentaId);
			pagosDTO = obtenerPagosBecadosPaginados(idBanco, becado, ra, ciclo, periodoId, zonaId, estadoPagoId, estadoCuentaId, 0, totalRowsFiltrados, 
					listaPaginada.getSortDirection(), listaPaginada.getSortCriterion());
		}else{
			totalRowsFiltrados = srvPago.obtenerCantidadListaPagosBecados(bancoSeleccionado, becado, ra, ciclo, periodoId, zonaId, estadoPagoId, 
					estadoCuentaId);
			pagosDTO = obtenerPagosBecadosPaginados(idBanco, becado, ra, ciclo, periodoId, zonaId, estadoPagoId, estadoCuentaId, 
					listaPaginada.getFirstRecordIndex(), listaPaginada.getPageSize(), listaPaginada.getSortDirection(), 
					listaPaginada.getSortCriterion());
		}
		listaPaginada.setList(pagosDTO);
		listaPaginada.setTotalNumberOfRows(totalRowsFiltrados);

		return listaPaginada;
	}
	
	public List<PagoDTO> obtenerPagosBecadosPaginados(Long idBanco, String becado, String ra, CicloPrograma ciclo, List<Long> periodoId, 
			List<Long> zonaId, List<Integer> idEstadoPago, List<Integer> idEstadoCuenta, int firstResult, int maxResults, SortOrderEnum sortDirection, 
			String sortCriterion){

		List<PagoDTO> pagosFiltrados = new ArrayList<PagoDTO>();
			if(idBanco != null){
				if(idBanco.equals(0L)){
					pagosFiltrados = srvPago.obtenerPagosBecadosPorBanco(null,  becado, ra, ciclo, periodoId, zonaId, idEstadoPago, idEstadoCuenta, 
							firstResult, maxResults, sortDirection, sortCriterion);
				}else {
					Banco bancoSeleccionado = srvBanco.obtenerBanco(idBanco);
					pagosFiltrados = srvPago.obtenerPagosBecadosPorBanco(bancoSeleccionado, becado, ra, ciclo, periodoId, zonaId, idEstadoPago, 
							idEstadoCuenta, firstResult, maxResults, sortDirection, sortCriterion);
				}	
			}
		return pagosFiltrados;
	}
	
	/**
	 * Obtiene el monto total de los pagos filtrados para pagos anteriores
	 * @param idBanco
	 * @param becado
	 * @param ra
	 * @param periodoId
	 * @param zonaId
	 * @param estadoPagoId
	 * @return
	 */
	private Double obtenerMontoTotalListaPagosBecados(String idBanco,String becado, String ra, CicloPrograma ciclo, List<Long> periodoId, 
			List<Long> zonaId,  List<Integer> estadoPagoId, List<Integer> estadoCuentaId) {
		Banco bancoSeleccionado = srvBanco.obtenerBanco((StringUtils.isNotBlank(idBanco)&&!idBanco.equals("null")) ? Long.parseLong(idBanco) : 0L);
		return srvPago.obtenerMontoTotalListaPagosBecados(bancoSeleccionado, becado, ra, ciclo, periodoId, zonaId, estadoPagoId, estadoCuentaId);
	}
	
	
	/**
	 * @param request
	 * @param idPagos
	 * @param idPago
	 * @param estadoNuevoId
	 * Modifica el estado de el/los pagos que fueron seleccionado/s para el estado seleccionado
	 * @throws ParseException 
	 */
	@RequestMapping("/pago/moficarEstadoPago.do")
	public ModelAndView moficarEstadoPago(HttpServletRequest request,@RequestParam(required=false,value="_chk") List<Long> idPagos,
			@RequestParam(required=false, value="idPago") Long idPago, 
			@RequestParam("estadoNuevoId") Integer estadoNuevoId,
			HttpSession session) throws Exception{

		
		String detalleCambioEsado= request.getParameter("detalleCambioEstado");
		EstadoPago nuevoEstado = EstadoPago.getEstadoPago(estadoNuevoId);
		//System.out.println(detalleCambioEsado);
		
		Usuario logeado = srvUsuario.obtenerPorUsuario((String)session.getAttribute("SPRING_SECURITY_LAST_USERNAME"),true);
		Persona persona= logeado.getPersona();
		session.setAttribute(PERSONA_LOGUEADA, persona);
		
		String usuario=persona.getNombre() + " " + persona.getApellido();
		List<Long> listaPagos = null;
		logeado = srvUsuario.obtenerPorUsuario((String)session.getAttribute("SPRING_SECURITY_LAST_USERNAME"),true);
		persona= logeado.getPersona();
		session.setAttribute(PERSONA_LOGUEADA, persona);
		if(idPago != null){
			listaPagos = new ArrayList<Long>();		
			listaPagos.add(idPago);
		}
		if(idPagos != null){
			listaPagos = idPagos;
		}		
		if(listaPagos != null){
			
			
			usuario=persona.getNombre() + " " + persona.getApellido();
			for (Long pagoId : listaPagos) {
				Pago pago = srvPago.obtenerPorId(pagoId.longValue());
				srvPago.modificarEstadoPago(pago, nuevoEstado);				

				
				// alta pago historia				
				String url = "jdbc:mysql://localhost/cimientos_prod";
				Connection cn = DriverManager.getConnection(url,"root","root");						        
		        String call=null;	        
		        call="insert into pago_historia (idPago,estado,motivo,usuario) values(?,?,?,?)";
		        PreparedStatement preparedStmt = cn.prepareStatement(call);
		        preparedStmt.setLong (1, pago.getId());	        
		        preparedStmt.setString(2, nuevoEstado.getValor());
		        preparedStmt.setString(3,detalleCambioEsado);
		        preparedStmt.setString(4,usuario);
		        preparedStmt.execute();
		        cn.close();	            		        								
		        // fin alta
				AlumnoPanelEA alumnoPanel = panelEaSrv.obtenerAlumnoPanelPorIdPerfilAlumno(pago.getBecado().getId());
				alumnoPanel.actualizarSemaforoPago(pago.getEstadoPago());
			}
			detalleCambioEsado="";
		}		
		return verListaPagosView(request, null, null, null, null, null, null, null, null, null, true, null, null, null, null);
	}
	
		@RequestMapping("/pago/agregarMontoExtra.do")
	public ModelAndView agregarMontoExtra(@RequestParam("idBecado") String idBecado,			
			@RequestParam("input_extra") String extra,
			@RequestParam("idsPeriodo") String idsPeriodo,
			HttpServletRequest request, HttpSession session) throws ParseException{
		Double montoExtra = Double.valueOf(extra);
		AlumnoPanelEA alumnoPanel = panelEaSrv.obtenerAlumnoPanelPorIdPerfilAlumno(Long.parseLong(idBecado));
		List<Long> 	idsLocalPeriodo = null;
		List<Long> idsPagos = null;
		idsPagos = Formateador.toListOfLongs(idsPeriodo);
		if (idsPagos!=null && idsPagos.size()>0){
			idsLocalPeriodo = new ArrayList<Long>();
			idsLocalPeriodo.addAll(idsPagos);
			if (idsLocalPeriodo.contains(0L)){
				idsLocalPeriodo.remove(new Long(0));
			}
		}		
		List<Pago> pagos;
		//obtiene los pagos correspondientes a los alumnos seleccionados
		pagos = srvPago.obtenerPagosPorAlumnoPeriodo(Long.parseLong(idBecado), idsLocalPeriodo);

		for (Pago pago : pagos) {				
			pago.setExtra(pago.getExtra() + montoExtra);
			srvPago.agregarPago(pago);
		}		
	
		Map<String, Object> resul = new HashMap<String, Object>();
		resul.put("bancos", srvBanco.obtenerTodos());

		return mostrarPagosAprobadosNoAprobados(request, session, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
	}
}
