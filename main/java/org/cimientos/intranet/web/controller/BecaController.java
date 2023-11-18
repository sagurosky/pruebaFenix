package org.cimientos.intranet.web.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.cimientos.intranet.modelo.Beca;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.EstadoBeca;
import org.cimientos.intranet.modelo.MailUtil;
import org.cimientos.intranet.modelo.perfilPadrino.PerfilPadrino;
import org.cimientos.intranet.modelo.perfilPadrino.TipoPadrino;
import org.cimientos.intranet.modelo.persona.Persona;
import org.cimientos.intranet.modelo.usuario.Usuario;
import org.cimientos.intranet.servicio.BecaSvr;
import org.cimientos.intranet.servicio.CicloProgramaSrv;
import org.cimientos.intranet.servicio.PerfilPadrinoSvr;
import org.cimientos.intranet.servicio.PeriodoSrv;
import org.cimientos.intranet.servicio.ZonaCimientosSrv;
import org.cimientos.intranet.utils.BecaOrdenadoPorPadrino;
import org.cimientos.intranet.utils.ConstantesMenu;
import org.cimientos.intranet.utils.Formateador;
import org.cimientos.intranet.utils.paginacion.ExtendedPaginatedList;
import org.cimientos.intranet.utils.paginacion.PaginateListFactory;
import org.displaytag.tags.TableTagParameters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cimientos.intranet.enumerativos.TipoBeca;

import org.cimientos.intranet.modelo.usuario.Usuario;
import org.cimientos.intranet.web.controller.LoginController;



import org.cimientos.intranet.modelo.MailSender; 
import org.cimientos.intranet.modelo.MailUtil;

/**
 * Clase que se utiliza para  hacer la redireccion (mapeo) a las vistas.
 * Extiende de BaseController para incluir el Template
 * 
 * @author plabaronnie
 *
 */
@Controller
@RequestMapping("/beca/*")
public class BecaController extends BaseController {
	
	@Autowired
	private BecaSvr svrBeca;
	
	@Autowired
	private PeriodoSrv svrPeriodo;
	
	@Autowired
	private CicloProgramaSrv svrCiclo;
	
	@Autowired
	private PerfilPadrinoSvr svrPadrino;
	
	@Autowired
	private ZonaCimientosSrv svrZona;

	@Autowired
	private CicloProgramaSrv cicloSrv;
	
	@Autowired
	private PaginateListFactory paginateListFactory;
	
	

	/**
	 * @return lista de bacas que cumplan con los filtros dados
	 * @throws ParseException
	 */
	@RequestMapping("/beca/listaBecasView.do")
	public ModelAndView verListaBecas(HttpServletRequest request, 
			@RequestParam(required= false, value="cantRows") String totalRows, @RequestParam(required= false, value="cicloId") String cicloId,
			 @RequestParam(required= false, value="idZona") Long zonaId, @RequestParam(required= false, value="idPadrino") Long padrinoId,
			 @RequestParam(required= false, value="tipoId") Integer tipoId, @RequestParam(required= false, value="estadoId") Integer estadoId,
			 @RequestParam(required= false, value="periodoId") Long periodoId,@RequestParam(required= false, value="tipoBecaId") Integer tipoBecaId,
			 @RequestParam(required= false, value="padrinoBeca") String padrino,@RequestParam(required= false, value="zona") String zona) 
	{
		Map<String, Object> resul = new HashMap<String, Object>();
		
		Long idCiclo = null;
		Integer idTipo = tipoId != null && tipoId.equals(0) ? null : tipoId;
		Integer idEstado = estadoId != null && estadoId.equals(0) ? null : estadoId;
		Long idPeriodo = periodoId != null && periodoId.equals(0l) ? null : periodoId;
		Integer idTipoBeca = tipoBecaId != null && tipoBecaId.equals(0) ? null : tipoBecaId;
		
		//DMS 	9/9/22 agregue toString en la linea 108 y comente la 119 por excepcion de tipo de datos. ver a futuro	

		if(cicloId != null){
			//if(!cicloId.equals("Todos")){ 
			if(!cicloId.toString().equals("Todos")){
				idCiclo = Long.parseLong(cicloId);
				idCiclo = cicloSrv.obtenerCiclo(idCiclo).getId();
				cicloId = idCiclo.toString();
			}
			else {
				idCiclo = 0L;	
			}
		}
		else{
			idCiclo = 0L;
	//		cicloId = "Todos";
		}

		boolean export = request.getParameter(TableTagParameters.PARAMETER_EXPORTING) != null; 
		
		ExtendedPaginatedList listaPaginada = paginarBecas(idCiclo, export, request, idTipo, idEstado, idPeriodo, idTipoBeca, padrinoId, zonaId, false, null);
		
        resul.put("becas", listaPaginada);
        
        resul.put("ciclos", cicloSrv.obtenerCiclosClonarBecas());
        resul.put("cicloId", cicloId); 
        resul.put("tipos", TipoPadrino.getListaTipos());
        resul.put("tipoId", tipoId);
        resul.put("estados", EstadoBeca.getListaEstados());
        resul.put("estadoId", estadoId); 
        resul.put("periodos", svrPeriodo.buscarPeriodosPorCiclo(idCiclo));
        resul.put("periodoId", periodoId);
        resul.put("tipoBecaId", idTipoBeca);
        resul.put("tiposBecas", TipoBeca.getListaTipoBecas());
        resul.put("idPadrino", padrinoId);
        resul.put("padrinoBeca", padrino);
        resul.put("idZona", zonaId);
        resul.put("zona", zona);
        
        HttpSession session = request.getSession();
        session.setAttribute("menu", ConstantesMenu.menuGestionBecas);
		return forward("/beca/listaBecas", resul);
	}
	
	/**
	 * @return lista de bacas que cumplan con los filtros dados
	 * @throws ParseException
	 */
	@RequestMapping("/beca/exportarBecasView.do")
	public ModelAndView exportarListaBecas(HttpServletRequest request, 
			@RequestParam(required= false, value="cantRows") String totalRows, @RequestParam(required= false, value="cicloId") String cicloId,
			 @RequestParam(required= false, value="idZona") Long zonaId, @RequestParam(required= false, value="idPadrino") Long padrinoId,
			 @RequestParam(required= false, value="tipoId") Integer tipoId, @RequestParam(required= false, value="estadoId") Integer estadoId,
			 @RequestParam(required= false, value="periodoId") Long periodoId,@RequestParam(required= false, value="tipoBecaId") Integer tipoBecaId,
			 @RequestParam(required= false, value="padrinoBeca") String padrino,@RequestParam(required= false, value="zona") String zona) 
	{
		Map<String, Object> resul = new HashMap<String, Object>();
		
		Long idCiclo = null;
		Integer idTipo = tipoId != null && tipoId.equals(0) ? null : tipoId;
		Integer idEstado = estadoId != null && estadoId.equals(0) ? null : estadoId;
		Long idPeriodo = periodoId != null && periodoId.equals(0l) ? null : periodoId;
		Integer idTipoBeca = tipoBecaId != null && tipoBecaId.equals(0) ? null : tipoBecaId;
		String excelView = null;
		
		if(cicloId != null){
			if(!cicloId.equals("Todos")){
				idCiclo = Long.parseLong(cicloId);
				idCiclo = cicloSrv.obtenerCiclo(idCiclo).getId();
				cicloId = idCiclo.toString();
			}
			else {
				idCiclo = 0L;	
			}
		}
		else{
			idCiclo = 0L;
			cicloId = "Todos";
		}

		boolean export = request.getParameter(TableTagParameters.PARAMETER_EXPORTING) != null; 
		
		ExtendedPaginatedList listaPaginada = paginarBecas(idCiclo, export, request, idTipo, idEstado, idPeriodo, idTipoBeca, padrinoId, zonaId, false, null);
		
        resul.put("becas", listaPaginada);
        
        resul.put("ciclos", cicloSrv.obtenerCiclosClonarBecas());
        resul.put("cicloId", cicloId); 
        resul.put("tipos", TipoPadrino.getListaTipos());
        resul.put("tipoId", tipoId);
        resul.put("estados", EstadoBeca.getListaEstados());
        resul.put("estadoId", estadoId); 
        resul.put("periodos", svrPeriodo.buscarPeriodosPorCiclo(idCiclo));
        resul.put("periodoId", periodoId);
        resul.put("tipoBecaId", idTipoBeca);
        resul.put("tiposBecas", TipoBeca.getListaTipoBecas());
        resul.put("idPadrino", padrinoId);
        resul.put("padrinoBeca", padrino);
        resul.put("idZona", zonaId);
        resul.put("zona", zona);
        
        //HttpSession session = request.getSession();
        //session.setAttribute("menu", ConstantesMenu.menuGestionBecas);
		//return forward("/beca/listaBecas", resul);
		
		excelView = "exportarBecasView";
		return new ModelAndView(excelView,resul);	
		
		
	}

	

	/**
	 * @param idCiclo
	 * @param export
	 * @param request
	 * @param idTipo
	 * @param idEstado
	 * @param idPeriodo
	 * @param tipoBecaId
	 * @param padrinoId
	 * @param zonaId
	 * @param total - se utiliza para saber si se quiere paginar o no. Para el clonar becas se pasa en 'true' para que traiga todos los resultados
	 * @param becaClonada 
	 * @return
	 */
	private ExtendedPaginatedList paginarBecas(Long idCiclo, boolean export,
			HttpServletRequest request, Integer idTipo, Integer idEstado,
			Long idPeriodo, Integer tipoBecaId, Long padrinoId, Long zonaId, boolean total, Boolean becaClonada) {
		List<Beca> becas = null;
				
		CicloPrograma ciclo = null;
		if (!idCiclo.equals(0L)) {
			ciclo = cicloSrv.obtenerCiclo(idCiclo);
		}
		
		int totalRows = svrBeca.obtenerCantidadEntrevistasAExportar(ciclo, idTipo, idEstado,  
				idPeriodo, tipoBecaId, padrinoId, zonaId,total, becaClonada);
		
		ExtendedPaginatedList listaPaginada = paginateListFactory.getPaginatedListFromRequest(request);
		
		if(total && totalRows != 0)
			listaPaginada.setPageSize(totalRows);

		//Si es un export debo cargar toda la lista entera, si no lo es entonces se carga la lista de a una pagina por vez
		if(export){			
			becas = svrBeca
			.obtenerBecasAExportar(ciclo, idTipo, idEstado,  idPeriodo, tipoBecaId, padrinoId, zonaId, total,becaClonada,
					0, totalRows,listaPaginada.getSortDirection(), listaPaginada.getSortCriterion());
		}else{
			becas = svrBeca
				.obtenerBecasAExportar(ciclo, idTipo, idEstado,  idPeriodo, tipoBecaId, padrinoId, zonaId, total, becaClonada,
						listaPaginada.getFirstRecordIndex(), listaPaginada.getPageSize(),listaPaginada.getSortDirection(),
						listaPaginada.getSortCriterion());
		}
		
		//Si la lista de becas se va a visualizar en el listado de Clonaci�n de Becas, se ordena alfabeticamente
		if(total)
			this.reordenarPadrinos(becas);
		
		listaPaginada.setList(becas);
		listaPaginada.setTotalNumberOfRows(totalRows);

		return listaPaginada;
	}

	
	
	
	/**
	 * @return la vista del alta del formulario de la Beca
	 */
	@RequestMapping("/beca/altaBecaView.do")
	public ModelAndView altaBecaView(){
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("fechaAlta", new Date());
		model.put("ciclos", svrCiclo.obtenerCiclosParaCreacionBeca());
		model.put("zonas", svrZona.obtenerTodos());
		model.put("estados", EstadoBeca.getListaEstados());
		model.put("tipos", TipoBeca.getListaTipoBecas());
		
		return forward("/beca/altaBeca", model);
	}
			
	/**
	 * Este metodo persiste los datos de la Beca que llegan del formulario de alta.
	 * Setea el estado de la Beca como activo.
	 * Verifica que el Beca a registrar no este dado de alta.
	 *
	 * @param request el request
	 * @param monto el monto de la beca
	 * @param fechaAlta la fecha de alta de la beca
	 * @param cuit_cuil el cuit_cuil del padrino de la beca
	 * 
	 *  @return la vista que me devuelve las Becas activas 
	 */
	@RequestMapping("/beca/altaBeca.do")
	public ModelAndView altaBeca( 
			HttpServletRequest request,
			@RequestParam("fechaAlta") String fechaAlta,
			@RequestParam("fechaAlta") String fechaModificacion,
			@RequestParam(required=false, value="idPadrino") Long idPadrino,
			@RequestParam("ciclo") Long cicloId,
			@RequestParam("periodo") Long periodoId,
			@RequestParam("zona") Long zonaId,
			@RequestParam("tipo") Integer tipoId,
			@RequestParam("estado") int estadoId,
			@RequestParam("cantidad") Integer cantidad,
			@RequestParam("comentarios") String comentarios) {
		
		Map<String, Object> model = new HashMap<String, Object>();
		Beca beca = new Beca();
		beca.setActivo(true);
		
		beca.setCiclo(svrCiclo.obtenerCiclo(cicloId));
		beca.setPeriodoPago(svrPeriodo.obtenerPeriodo(periodoId));
		beca.setEstado(EstadoBeca.getEstadoBeca(estadoId));
		beca.setZona(svrZona.obtenerZonaCimientos(zonaId));
		beca.setCantidad(cantidad);
		beca.setComentarios(comentarios +" ("+fechaModificacion+")" + "\n");
		//beca.setFechaBajaBecado(fechaBajaBecado);
		if(tipoId != null){
			beca.setTipo(TipoBeca.getTipoBeca(tipoId));
		}
		
		PerfilPadrino padrino = null;
		if(idPadrino != null){
			padrino =  svrPadrino.obtenerPorId(idPadrino);
		}	
		if(padrino == null){
			model.put("error","No existe el padrino ingresado");
			model.put("beca", beca);
			model.put("ciclos", svrCiclo.obtenerCiclosParaCreacionBeca());
			model.put("periodos", svrPeriodo.buscarPeriodosPorCiclo(beca.getCiclo().getId()));
			model.put("zonas", svrZona.obtenerTodos());
			model.put("estados", EstadoBeca.getListaEstados());
			model.put("tipos", TipoBeca.getListaTipoBecas());
			return forward("/beca/modificarBeca", model);
		}
		
		beca.setPadrino(padrino);
		
		if(fechaAlta != null){
			Date fecha = Formateador.parsearFecha(fechaAlta);
			if( fecha.after(new Date()))
			{
				model.put("error", "La fecha de confirmacion no puede ser posterior a la fecha actual");
				model.put("beca", beca);
				model.put("ciclos", svrCiclo.obtenerCiclosParaCreacionBeca());
				model.put("periodos", svrPeriodo.buscarPeriodosPorCiclo(beca.getCiclo().getId()));
				model.put("zonas", svrZona.obtenerTodos());
				model.put("estados", EstadoBeca.getListaEstados());
				model.put("tipos", TipoBeca.getListaTipoBecas());
				return forward("/beca/modificarBeca", model);
			}
			beca.setFechaAlta(fecha);
			beca.setFechaModificacion(fecha);
		}	
		
		svrBeca.guardarBeca(beca);
		model.put("becas", svrBeca.obtenerTodos());
		
		return verListaBecas( request, null, null, null, null,null, null,
				 null, null, null,null); 

	}
	
	
	/**
	 * @param idBeca el id de la beca
	 * 
	 * @return la vista de la modificacion del formulario de la Beca
	 */
	@RequestMapping("/beca/modificarBecaView.do")
	public ModelAndView modificarBecaView(@RequestParam("idBeca") Long idBeca){
		Beca beca = svrBeca.obtenerPorId(idBeca);
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("fechaModif", new Date());
		model.put("beca", beca);
		model.put("ciclos", svrCiclo.obtenerCiclosParaCreacionBeca());
		model.put("periodos", svrPeriodo.buscarPeriodosPorCiclo(beca.getCiclo().getId()));
		model.put("zonas", svrZona.obtenerTodos());
		model.put("estados", EstadoBeca.getListaEstados());
		model.put("tipos", TipoBeca.getListaTipoBecas());
		return forward("/beca/modificarBeca", model);
	}
	
	/**
	 * @param idBeca el id de la beca
	 * 
	 * @return la vista de la modificacion del formulario de la Beca
	 */
	@RequestMapping("/beca/verBecaDetalleView.do")
	public ModelAndView verBecaDetalleView(@RequestParam("idBeca") Long idBeca){
		Beca beca = svrBeca.obtenerPorId(idBeca);
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("beca", beca);
		model.put("ciclos", svrCiclo.obtenerCiclosParaCreacionBeca());
		model.put("periodos", svrPeriodo.buscarPeriodosPorCiclo(beca.getCiclo().getId()));
		model.put("zonas", svrZona.obtenerTodos());
		model.put("estados", EstadoBeca.getListaEstados());
		model.put("tipos", TipoBeca.getListaTipoBecas());
		return forward("/beca/verDetalleBeca", model);
	}
	
	/**
	 * 
	 * Este metodo permite modificar los datos de la Beca
	 * 
	 * @param request el request
	 * @param monto el monto de la beca
	 * @param fechaAlta la fecha de alta de la beca
	 * @param cuit_cuil el cuit_cuil del padrino de la beca
	 * @param idBeca el id de la beca
	 *  
	 * @return la vista de la lista de Becas persistidas
	 */
	@RequestMapping("/beca/modificar.do")
	public ModelAndView modificarBeca(
			HttpServletRequest request,
			@RequestParam("fechaAlta") String fechaAlta,
			@RequestParam("fechaModif") String fechaModificar,
			@RequestParam("idPadrino") Long idPadrino,
			@RequestParam(required=false,value="idBeca") String idBeca,
			@RequestParam("ciclo") String cicloId,
			@RequestParam("periodo") String periodoId,
			@RequestParam("zona") Long zonaId,
			@RequestParam("zonaVieja") Long zonaVieja,
			@RequestParam("zonaViejaS") String zonaViejaS,
			@RequestParam("tipo") Integer tipoId,
			@RequestParam("estado") int estadoId,
			@RequestParam("cantidad") Integer cantidad,
			@RequestParam("cantidadOriginal") Integer cantidadOriginal,
			@RequestParam("comentarios") String comentarios)  
	{
		Beca beca;
		Map<String, Object> model = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(idBeca)){
			beca = svrBeca.obtenerPorId(Long.valueOf( idBeca));
		}else {
			beca = new Beca();
		}
		
		beca.setActivo(true);
		beca.setCiclo(svrCiclo.obtenerCiclo(Long.valueOf(cicloId)));
		beca.setPeriodoPago(svrPeriodo.obtenerPeriodo(Long.valueOf(periodoId)));
		beca.setEstado(EstadoBeca.getEstadoBeca(estadoId));
		beca.setZona(svrZona.obtenerZonaCimientos(zonaId));
		beca.setCantidad(cantidad);
		beca.setComentarios(comentarios +" ("+fechaModificar+")" + "\n");
		if(tipoId != null){
			beca.setTipo(TipoBeca.getTipoBeca(tipoId));
		}
		
		PerfilPadrino padrino = null;
		if(idPadrino != null){
			padrino =  svrPadrino.obtenerPorId(idPadrino);
		}
		if(padrino == null){
		    model.put("error","No existe el padrino ingresado");
			model.put("beca", beca);
			model.put("ciclos", svrCiclo.obtenerTodos());
			model.put("periodos", svrPeriodo.buscarPeriodosPorCiclo(beca.getCiclo().getId()));
			model.put("zonas", svrZona.obtenerTodos());
			model.put("estados", EstadoBeca.getListaEstados());
			model.put("tipos", TipoBeca.getListaTipoBecas());
			return forward("/beca/modificarBeca", model);
		}

		beca.setPadrino(padrino);
		
		if(fechaAlta != null){
			Date fecha = Formateador.parsearFecha(fechaAlta);
			Date fechaM = Formateador.parsearFecha(fechaModificar);
			if( fecha.after(new Date())){
				model.put("error", "La fecha de confirmacion no puede ser posterior a la fecha actual");
				model.put("beca", beca);
				model.put("ciclos", svrCiclo.obtenerTodos());
				model.put("periodos", svrPeriodo.buscarPeriodosPorCiclo(beca.getCiclo().getId()));
				model.put("zonas", svrZona.obtenerTodos());
				model.put("estados", EstadoBeca.getListaEstados());
				model.put("tipos", TipoBeca.getListaTipoBecas());
				return forward("/beca/modificarBeca", model);
			}
			beca.setFechaAlta(fecha);
			beca.setFechaModificacion(fechaM);
		}

		svrBeca.guardarBeca(beca);
		
		// enviar mail si la cantidad de becas es modificada
		
		
		
		String firma=Globales.tenant;
		
		// vacia firma
		
		firma="";
		
		if(beca.getCiclo().getEstado().getValor() == "Actual"){
		
			if (zonaId != zonaVieja){
				
				//System.out.println("Distintas zonas: "+ zonaId + " " + zonaVieja);
				if (padrino.getDatosPersonales() !=null){
					
					
						String[] recipients = new String[]{"lisandramauri@cimientos.org"};   //destino
						//String[] recipients = new String[]{"carlosquetto@cimientos.org"};   //destino
						//String[] bccRecipients = new String[]{"gracielanogues@cimientos.org"};   
						String[] bccRecipients = new String[]{"pauladaffra@cimientos.org","lisandramauri@cimientos.org","carlosquetto@cimientos.org","victoriafaiella@cimientos.org","pilarmagdalena@cimientos.org","padrinos@cimientos.org","florenciagelabert@cimientos.org"};
						//String[] bccRecipients = new String[]{"carlosquetto@hotmail.com"};
						String subject = "Aviso cambio de zona Beca";    
						String messageBody = "El padrino " + padrino.getDatosPersonales().getNombre().toString() + " " +padrino.getDatosPersonales().getApellido().toString() + ", cambio de zona "+ zonaViejaS+ " a "+ beca.getZona().getNombre()+ ".<br><br>Cantidad de becas: "+ cantidad +  ".<br><br><b>Record� desprender al/los becado/s que corresponda a dicha/s beca/s.<b><br><br>"+ firma;   						
						new MailUtil().sendMail(recipients, bccRecipients, subject, messageBody);
					
				}else{
					
					String[] recipients = new String[]{"lisandramauri@cimientos.org"};   //destino
					//String[] recipients = new String[]{"carlosquetto@cimientos.org"};   //destino
					String[] bccRecipients = new String[]{"pauladaffra@cimientos.org","lisandramauri@cimientos.org","carlosquetto@cimientos.org","victoriafaiella@cimientos.org","pilarmagdalena@cimientos.org","padrinos@cimientos.org","florenciagelabert@cimientos.org"};   
					//String[] bccRecipients = new String[]{"carlosquetto@hotmail.com"};
					String subject = "Aviso cambio de zona Beca";
					String messageBody = "El padrino " + padrino.getEmpresa().getDenominacion().toString()+ ", cambio de zona "+ zonaViejaS+ " a "+ beca.getZona().getNombre()+ ".<br><br>Cantidad de becas: "+ cantidad + ".<br><br><b>Record� desprender al/los becado/s que corresponda a dicha/s beca/s.<b><br><br>"+ firma;   						
					new MailUtil().sendMail(recipients, bccRecipients, subject, messageBody);
					
				}
				
				
			} else{
				//System.out.println("Zonas iguales "+ zonaId + " " + zonaVieja);
				
				
			}
			
			if ((beca.getEstado().getValor()=="Inactiva") && (beca.getCantidadAsignada()>0)){
				
				
				if (padrino.getDatosPersonales() !=null){
				
					if (cantidad==1){
						String[] recipients = new String[]{"lisandramauri@cimientos.org"};   //destino
						//String[] recipients = new String[]{"carlosquetto@cimientos.org"};   //destino
						String[] bccRecipients = new String[]{"pauladaffra@cimientos.org","lisandramauri@cimientos.org","carlosquetto@cimientos.org","victoriafaiella@cimientos.org","pilarmagdalena@cimientos.org","padrinos@cimientos.org","florenciagelabert@cimientos.org"};   
						//String[] bccRecipients = new String[]{"carlosquetto@hotmail.com"};
						String subject = "Aviso beca inactiva";    
						String messageBody = "Se ha inactivado " + cantidad + " beca para el padrino " + padrino.getDatosPersonales().getNombre().toString() + " " +padrino.getDatosPersonales().getApellido().toString() + " en la zona "+ beca.getZona().getNombre()+ ".<br><br><b>Record� desprender al/los becado/s que corresponda a dicha/s beca/s.<b><br><br>"+ firma;   						
						new MailUtil().sendMail(recipients, bccRecipients, subject, messageBody);
					}
					else{					
						String[] recipients = new String[]{"lisandramauri@cimientos.org"};   //destino
						//String[] recipients = new String[]{"carlosquetto@cimientos.org"};   //destino
						String[] bccRecipients = new String[]{"pauladaffra@cimientos.org","lisandramauri@cimientos.org","carlosquetto@cimientos.org","victoriafaiella@cimientos.org","pilarmagdalena@cimientos.org","padrinos@cimientos.org","florenciagelabert@cimientos.org"};   
						//String[] bccRecipients = new String[]{"carlosquetto@hotmail.com"};
						String subject = "Aviso becas inactivas";   
						String messageBody = "Se han inactivado " + cantidad + " becas para el padrino " + padrino.getDatosPersonales().getNombre().toString() + " " +padrino.getDatosPersonales().getApellido().toString() + " en la zona "+ beca.getZona().getNombre()+ ".<br><br><b>Record� desprender al/los becado/s que corresponda a dicha/s beca/s.<b><br><br>"+ firma;   
						new MailUtil().sendMail(recipients, bccRecipients, subject, messageBody);
						
					}
				}else{
					if (cantidad==1){
						String[] recipients = new String[]{"lisandramauri@cimientos.org"};   //destino
						//String[] recipients = new String[]{"carlosquetto@cimientos.org"};   //destino
						String[] bccRecipients = new String[]{"pauladaffra@cimientos.org","lisandramauri@cimientos.org","carlosquetto@cimientos.org","victoriafaiella@cimientos.org","pilarmagdalena@cimientos.org","padrinos@cimientos.org","florenciagelabert@cimientos.org"};   
						//String[] bccRecipients = new String[]{"carlosquetto@hotmail.com"};
						String subject = "Aviso beca inactiva";    
						String messageBody = "Se ha inactivado " + cantidad + " beca para el padrino " + padrino.getEmpresa().getDenominacion().toString()+ " en la zona "+ beca.getZona().getNombre()+ ".<br><br><b>Record� desprender al/los becado/s que corresponda a dicha/s beca/s.<b><br><br>"+ firma;   
						new MailUtil().sendMail(recipients, bccRecipients, subject, messageBody);
					}
					else{					
						String[] recipients = new String[]{"lisandramauri@cimientos.org"};   //destino
						//String[] recipients = new String[]{"carlosquetto@cimientos.org"};   //destino
						String[] bccRecipients = new String[]{"pauladaffra@cimientos.org","lisandramauri@cimientos.org","carlosquetto@cimientos.org","victoriafaiella@cimientos.org","pilarmagdalena@cimientos.org","padrinos@cimientos.org","florenciagelabert@cimientos.org"};   
						//String[] bccRecipients = new String[]{"carlosquetto@hotmail.com"};
						String subject = "Aviso becas inactivas";   
						String messageBody = "Se han inactivado " + cantidad + " becas para el padrino " + padrino.getEmpresa().getDenominacion().toString()+ "  en la zona "+ beca.getZona().getNombre()+ ".<br><br><b>Record� desprender al/los becado/s que corresponda a dicha/s beca/s.<b><br><br>"+ firma;   
						new MailUtil().sendMail(recipients, bccRecipients, subject, messageBody);
						
					}
				}
				
			}else{
				if ((beca.getCantidadAsignada()>0) && beca.getCantidadAsignada()>cantidad ){
				
					if (padrino.getDatosPersonales() !=null){
						
					
					if (beca.getEstado().getValor()=="Confirmada"){
					
						if(cantidad>cantidadOriginal){
							String[] recipients = new String[]{"lisandramauri@cimientos.org"};   //destino
							//String[] recipients = new String[]{"carlosquetto@cimientos.org"};   //destino
							String[] bccRecipients = new String[]{"pauladaffra@cimientos.org","lisandramauri@cimientos.org","carlosquetto@cimientos.org","victoriafaiella@cimientos.org","pilarmagdalena@cimientos.org","padrinos@cimientos.org","florenciagelabert@cimientos.org"};   
							//String[] bccRecipients = new String[]{"carlosquetto@hotmail.com"};
							String subject = "Aumento cantidad de Becas padrino";   
							String messageBody = "El Padrino "+ padrino.getDatosPersonales().getNombre().toString() + " " +padrino.getDatosPersonales().getApellido().toString() + " aument� la cantidad de becas de "+ cantidadOriginal +" a "  + cantidad +" en la zona "+ beca.getZona().getNombre()+ ".<br><br><b>Record� desprender al/los becado/s que corresponda a dicha/s beca/s.<b><br><br>"+ firma;   
							new MailUtil().sendMail(recipients, bccRecipients, subject, messageBody);
						}
						
						if(cantidad<cantidadOriginal){
							String[] recipients = new String[]{"lisandramauri@cimientos.org"};   //destino
							//String[] recipients = new String[]{"carlosquetto@cimientos.org"};   //destino
							String[] bccRecipients = new String[]{"pauladaffra@cimientos.org","lisandramauri@cimientos.org","carlosquetto@cimientos.org","victoriafaiella@cimientos.org","pilarmagdalena@cimientos.org","padrinos@cimientos.org","florenciagelabert@cimientos.org"};   
							//String[] bccRecipients = new String[]{"carlosquetto@hotmail.com"};
							String subject = "Disminuci�n cantidad de Becas padrino";   
							String messageBody = "El Padrino "+ padrino.getDatosPersonales().getNombre().toString() + " " +padrino.getDatosPersonales().getApellido().toString() + " disminuy� la cantidad de becas de "+ cantidadOriginal +" a " + cantidad +" en la zona "+ beca.getZona().getNombre()+ ".<br><br><b>Record� desprender al/los becado/s que corresponda a dicha/s beca/s.<b><br><br>"+ firma;   
							new MailUtil().sendMail(recipients, bccRecipients, subject, messageBody);
						}
					}
					}else{
						if (beca.getEstado().getValor()=="Confirmada"){
							
							if(cantidad>cantidadOriginal){
								String[] recipients = new String[]{"lisandramauri@cimientos.org"};   //destino
								//String[] recipients = new String[]{"carlosquetto@cimientos.org"};   //destino
								String[] bccRecipients = new String[]{"pauladaffra@cimientos.org","lisandramauri@cimientos.org","carlosquetto@cimientos.org","victoriafaiella@cimientos.org","pilarmagdalena@cimientos.org","padrinos@cimientos.org","florenciagelabert@cimientos.org"};   
								//String[] bccRecipients = new String[]{"carlosquetto@hotmail.com"};
								String subject = "Aumento cantidad de Becas padrino";   
								String messageBody = "El Padrino " + padrino.getEmpresa().getDenominacion().toString()+ " aument� la cantidad de becas de "+ cantidadOriginal +" a "  + cantidad +" en la zona "+ beca.getZona().getNombre()+ ".<br><br><b>Record� desprender al/los becado/s que corresponda a dicha/s beca/s.<b><br><br>"+ firma;   
								new MailUtil().sendMail(recipients, bccRecipients, subject, messageBody);
							}
							
							if(cantidad<cantidadOriginal){
								String[] recipients = new String[]{"lisandramauri@cimientos.org"};   //destino
								//String[] recipients = new String[]{"carlosquetto@cimientos.org"};   //destino
								String[] bccRecipients = new String[]{"pauladaffra@cimientos.org","lisandramauri@cimientos.org","carlosquetto@cimientos.org","victoriafaiella@cimientos.org","pilarmagdalena@cimientos.org","padrinos@cimientos.org","florenciagelabert@cimientos.org"};   
								//String[] bccRecipients = new String[]{"carlosquetto@hotmail.com"};
								String subject = "Disminuci�n cantidad de Becas padrino";   
								String messageBody = "El Padrino "+  padrino.getEmpresa().getDenominacion().toString()+ " disminuy� la cantidad de becas de "+ cantidadOriginal +" a " + cantidad +" en la zona "+ beca.getZona().getNombre()+ ".<br><br><b>Record� desprender al/los becado/s que corresponda a dicha/s beca/s.<b><br><br>"+ firma;   
								new MailUtil().sendMail(recipients, bccRecipients, subject, messageBody);
							}
						}
						
					}
				}
			}	
		}
		
		
		return verListaBecas( request, null, null, null, null,null, null,null, null, null,null);
		
	}
	
	/**
	 * Setea como inactivo a la Beca que se quiere eliminar y se guarda el estado.
	 * 
	 * @param idBeca
	 * @return la vista de la lista de Becas persistidas
	 */
	@RequestMapping("/beca/eliminarBeca.do")
	public ModelAndView eliminarBeca(HttpServletRequest request,@RequestParam("idBeca") Long idBeca){
		Map<String, Object> resul = new HashMap<String, Object>();
		Beca beca = svrBeca.obtenerPorId(idBeca); 
		beca.setActivo(false);
		svrBeca.guardarBeca(beca);
		resul.put("mensaje", "La Beca " + beca.getId() + " ha sido eliminado");
		return verListaBecas( request, null, null, null, null,null, null, null, null, null, null);
	}

	
	/**
	 * 
	 * @param request
	 * @param totalRows
	 * @param cicloId
	 * @param zonaId
	 * @param padrinoId
	 * @param tipoId
	 * @param estadoId
	 * @param periodoId
	 * @param tipoBecaId
	 * @param padrino
	 * @param zona
	 * @param clonada
	 * @return lista de becas disponibles para clonar que cumplan con los filtros dados
	 */
	@RequestMapping("/beca/listaClonarBecas.do")
	public ModelAndView listaClonarBecas(HttpServletRequest request, 
			@RequestParam(required= false, value="cantRows") String totalRows, @RequestParam(required= false, value="cicloId") String cicloId,
			 @RequestParam(required= false, value="idZona") Long zonaId, @RequestParam(required= false, value="idPadrino") Long padrinoId,
			 @RequestParam(required= false, value="tipoId") Integer tipoId, @RequestParam(required= false, value="estadoId") Integer estadoId,
			 @RequestParam(required= false, value="periodoId") Long periodoId,@RequestParam(required= false, value="tipoBecaId") Integer tipoBecaId,
			 @RequestParam(required= false, value="padrinoBeca") String padrino,@RequestParam(required= false, value="zona") String zona,
			 @RequestParam(required=false,value="becaClonada") String clonada){
		
		Map<String, Object> resul = new HashMap<String, Object>();
		
		Long idCiclo = null;
		Integer idTipo = tipoId != null && tipoId.equals(0) ? null : tipoId;
		Integer idEstado = estadoId != null && estadoId.equals(0) ? null : estadoId;
		Long idPeriodo = periodoId != null && periodoId.equals(0l) ? null : periodoId;
		Integer idTipoBeca = tipoBecaId != null && tipoBecaId.equals(0) ? null : tipoBecaId;		
		Boolean becaClonada = null;
		
		CicloPrograma cicloActual = cicloSrv.obtenerCicloActual();
		
		if(StringUtils.isNotBlank(cicloId)){
			idCiclo = Long.parseLong(cicloId);
		}else {
			idCiclo = cicloActual.getId();
			cicloId = idCiclo.toString();
		}
		
		if(clonada != null){
			becaClonada = generarAdicional(clonada);
			resul.put("clonada", clonada);
		}
		
		becaClonada = cicloId.equals(cicloActual.getId().toString())?null:becaClonada;

		boolean export = request.getParameter(TableTagParameters.PARAMETER_EXPORTING) != null; 
		boolean total = true;
		ExtendedPaginatedList listaPaginada = paginarBecas(idCiclo, export, request, idTipo, idEstado,
				idPeriodo, idTipoBeca, padrinoId, zonaId, total, becaClonada);
		ArrayList<String> listaClonada = generarListaClonada();
		resul.put("listClonada", listaClonada);		
		resul.put("becas", listaPaginada);
        resul.put("limpiarChks", true);
        resul.put("ciclos", cicloSrv.obtenerCiclosClonarBecas());
        resul.put("cicloId", cicloId);
        resul.put("cicloActual", cicloActual.getId());
        resul.put("tipos", TipoPadrino.getListaTipos());
        resul.put("tipoId", tipoId);
        resul.put("estados", EstadoBeca.getListaEstadosParaClonar());
        resul.put("estadoId", estadoId); 
        resul.put("periodos", svrPeriodo.buscarPeriodosPorCiclo(idCiclo));
        resul.put("periodoId", periodoId);
        resul.put("tipoBecaId", idTipoBeca);
        resul.put("tiposBecas", TipoBeca.getListaTipoBecas());
        resul.put("idPadrino", padrinoId);
        resul.put("padrinoBeca", padrino);
        resul.put("idZona", zonaId);
        resul.put("zona", zona);
       
        HttpSession session = request.getSession();
        session.setAttribute("menu", ConstantesMenu.menuGestionBecas);
	    return forward("/beca/clonarBecas", resul);
	}
	
	private ArrayList<String> generarListaClonada() {
		ArrayList<String> listaClonada = new ArrayList<String>();
		listaClonada.add("Si");
		listaClonada.add("No");
		return listaClonada;
	}



	private Boolean generarAdicional(String clonada) {
		if(clonada.equals("Todos"))
			return null;
		else
			return clonada.equals("Si");
	}
	
	/**
	 * 
	 * @param request
	 * @param idBecas
	 * @param idBeca
	 * @param cicloNuevoId
	 * Clona la/s becas que fueron seleccionadas para el ciclo seleccionado, siempre en estado "estimada"
	 */
	@RequestMapping("/beca/clonarBecas.do")
	public ModelAndView clonarBecas(HttpServletRequest request,@RequestParam(required=false,value="_chk") List<Long> idBecas,
			@RequestParam(required=false, value="idBeca") Long idBeca, @RequestParam("cicloNuevoId") Long cicloNuevoId){

		CicloPrograma ciclo = cicloSrv.obtenerCiclo(cicloNuevoId);
		if(idBeca != null){
			List<Long> becas = new ArrayList<Long>();
			becas.add(idBeca);
			svrBeca.clonarBecas(becas,ciclo);
		}
		else{
			if(idBecas != null)
				svrBeca.clonarBecas(idBecas,ciclo);
		}
		
		return listaClonarBecas(request, null, null, null, null, null, null, null, null, null, null,null);
	}
	
	/**
	 * Reordena las becas segun su padrino alfabeticamente
	 * 
	 * @param becas
	 */
	public void reordenarPadrinos(List<Beca> becas){		
		Collections.sort(becas, new BecaOrdenadoPorPadrino());
	}
	
	
	@RequestMapping("/beca/cambioMail.do")
	public ModelAndView cambioMail(HttpServletRequest request, 
			@RequestParam(required= false, value="cantRows") String totalRows, @RequestParam(required= false, value="cicloId") String cicloId,
			 @RequestParam(required= false, value="idZona") Long zonaId, @RequestParam(required= false, value="idPadrino") Long padrinoId,
			 @RequestParam(required= false, value="tipoId") Integer tipoId, @RequestParam(required= false, value="estadoId") Integer estadoId,
			 @RequestParam(required= false, value="periodoId") Long periodoId,@RequestParam(required= false, value="tipoBecaId") Integer tipoBecaId,
			 @RequestParam(required= false, value="padrinoBeca") String padrino,@RequestParam(required= false, value="zona") String zona,
			 @RequestParam(required=false,value="becaClonada") String clonada){
		
		Map<String, Object> resul = new HashMap<String, Object>();
		
		Long idCiclo = null;
		Integer idTipo = tipoId != null && tipoId.equals(0) ? null : tipoId;
		Integer idEstado = estadoId != null && estadoId.equals(0) ? null : estadoId;
		Long idPeriodo = periodoId != null && periodoId.equals(0l) ? null : periodoId;
		Integer idTipoBeca = tipoBecaId != null && tipoBecaId.equals(0) ? null : tipoBecaId;		
		Boolean becaClonada = null;
		
		CicloPrograma cicloActual = cicloSrv.obtenerCicloActual();
		
		if(StringUtils.isNotBlank(cicloId)){
			idCiclo = Long.parseLong(cicloId);
		}else {
			idCiclo = cicloActual.getId();
			cicloId = idCiclo.toString();
		}
		
		if(clonada != null){
			becaClonada = generarAdicional(clonada);
			resul.put("clonada", clonada);
		}
		
		becaClonada = cicloId.equals(cicloActual.getId().toString())?null:becaClonada;

		boolean export = request.getParameter(TableTagParameters.PARAMETER_EXPORTING) != null; 
		boolean total = true;
		ExtendedPaginatedList listaPaginada = paginarBecas(idCiclo, export, request, idTipo, idEstado,
				idPeriodo, idTipoBeca, padrinoId, zonaId, total, becaClonada);
		ArrayList<String> listaClonada = generarListaClonada();
		resul.put("listClonada", listaClonada);		
		resul.put("becas", listaPaginada);
        resul.put("limpiarChks", true);
        resul.put("ciclos", cicloSrv.obtenerCiclosClonarBecas());
        resul.put("cicloId", cicloId);
        resul.put("cicloActual", cicloActual.getId());
        resul.put("tipos", TipoPadrino.getListaTipos());
        resul.put("tipoId", tipoId);
        resul.put("estados", EstadoBeca.getListaEstadosParaClonar());
        resul.put("estadoId", estadoId); 
        resul.put("periodos", svrPeriodo.buscarPeriodosPorCiclo(idCiclo));
        resul.put("periodoId", periodoId);
        resul.put("tipoBecaId", idTipoBeca);
        resul.put("tiposBecas", TipoBeca.getListaTipoBecas());
        resul.put("idPadrino", padrinoId);
        resul.put("padrinoBeca", padrino);
        resul.put("idZona", zonaId);
        resul.put("zona", zona);
       
        HttpSession session = request.getSession();
        session.setAttribute("menu", ConstantesMenu.menuGestionBecas);
	    return forward("/beca/clonarBecas", resul);
	}
	
	
	
	

}
