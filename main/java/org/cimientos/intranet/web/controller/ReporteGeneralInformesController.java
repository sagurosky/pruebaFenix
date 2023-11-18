package org.cimientos.intranet.web.controller;

import java.text.Collator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.cimientos.intranet.modelo.Beca;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.informe.ComunicadoNoRenovacion;
import org.cimientos.intranet.modelo.informe.ComunicadoPendiente;
import org.cimientos.intranet.modelo.informe.EstadoInforme;
import org.cimientos.intranet.modelo.informe.FichaPresentacion;
import org.cimientos.intranet.modelo.informe.Informe;
import org.cimientos.intranet.modelo.informe.InformeCesacion;
import org.cimientos.intranet.modelo.informe.InformeIS1;
import org.cimientos.intranet.modelo.informe.InformeIS2;
import org.cimientos.intranet.modelo.informe.InformeIS3;
import org.cimientos.intranet.modelo.perfilPadrino.PerfilPadrino;
import org.cimientos.intranet.modelo.perfilPadrino.TipoPadrino;
import org.cimientos.intranet.modelo.persona.Persona;
import org.cimientos.intranet.modelo.ubicacion.ZonaCimientos;
import org.cimientos.intranet.servicio.BecaSvr;
import org.cimientos.intranet.servicio.CicloProgramaSrv;
import org.cimientos.intranet.servicio.InformeSrv;
import org.cimientos.intranet.servicio.PerfilPadrinoSvr;
import org.cimientos.intranet.servicio.ZonaCimientosSrv;
import org.cimientos.intranet.utils.ConstantesInformes;
import org.cimientos.intranet.utils.ConstantesMenu;
import org.cimientos.intranet.utils.Formateador;
import org.cimientos.intranet.utils.InformeUtils;
import org.cimientos.intranet.utils.hilos.LiberarMemoria;
import org.cimientos.intranet.utils.paginacion.ExtendedPaginatedList;
import org.cimientos.intranet.utils.paginacion.PaginateListFactory;
import org.displaytag.tags.TableTagParameters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cimientos.intranet.dto.PadrinoDTO;
import com.cimientos.intranet.dto.ReporteInformeDTO;
import com.cimientos.intranet.dto.ZonaCimientosDTO;
import com.cimientos.intranet.enumerativos.AnioEscolar;

/**
 * @author msagarduy
 *
 */
@Controller
@RequestMapping("/reporteGeneralInformes/*")
public class ReporteGeneralInformesController extends BaseController{
	
	@Autowired
	private InformeSrv srvInforme;
	
	@Autowired
	private CicloProgramaSrv cicloSrv;
	
	@Autowired
	private PaginateListFactory paginateListFactory;
			
	@Autowired
	private ZonaCimientosSrv zonaCimientosSrv;

	@Autowired
	private PerfilPadrinoSvr perfilPadrinoSrv;
	
	@Autowired
	private BecaSvr svrBeca;
	
	@RequestMapping("/reporteGeneralInformes/verReporteGeneralInformes.do")
	public ModelAndView verReporteGeneralInformes(HttpServletRequest request, HttpSession session,
			@RequestParam(required= false, value="cantRows") String totalRows, 
			@RequestParam(required= false, value="cicloId") List<Long> cicloId,
			@RequestParam(required= false, value="tipoId") Integer tipoId, 
			@RequestParam(required= false, value="estadoId") List<Integer> estadoId,
			@RequestParam(required= false, value="tipoInformeId") List<String> tipoInformeId, 
			@RequestParam(required= false, value="idPadrino") List<Long> padrinoId,
			@RequestParam(required= false, value="padrino") String padrino, 
			@RequestParam(required= false, value="idZona") List<Long> zonaId,
			@RequestParam(required= false, value="zona") String zona,
			@RequestParam(required= false, value="nombreAlumno") String nombreAlumno,
			@RequestParam(required= false, value="ea") String nombreEA,
			@RequestParam(required= false, value="idEA") Long idEA,
			@RequestParam(required= false, value="rr") String nombreRR,
			@RequestParam(required= false, value="eae") String eae,
			@RequestParam(required= false, value="idRR") Long idRR,
			@RequestParam(required= false, value="idCorrectora") Long idCorrectora,
			@RequestParam(required= false, value="correctora") String correctora,
			@RequestParam(required= false, value="idAnioEscolar") Integer idAnioEscolar,
			@RequestParam(required= false, value="fechaDesde") String fechaDesde,
			@RequestParam(required= false, value="fechaHasta") String fechaHasta,
			@RequestParam(required=false, value="mensaje") String mensaje,
			@RequestParam(required=false, value="error") String error){ 

		List<Integer> listLocalEstados = null;
		List<Number> listLocalZonas = null;
		List<Number> listLocalPadrinos = null;
		List<String> listLocalTiposInforme = null;
		AnioEscolar anioEscolar = null;
		Date dFechaDesde = null;
		Date dFechaHasta = null;
		CicloPrograma cicloActual = cicloSrv.obtenerCicloActual();
		CicloPrograma cicloAnterior = cicloSrv.obtenerCicloPorOrden(cicloActual.getOrden()-1);
		
		Map<String, Object> resul = new HashMap<String, Object>();
	
		Integer idAnio = idAnioEscolar != null && idAnioEscolar.equals(0) ? null : idAnioEscolar;
		if (idAnio!=null){
			anioEscolar = AnioEscolar.getAnioEscolar(idAnio);
		}
		
		Integer idTipo = tipoId != null && tipoId.equals(0) ? null : tipoId;

		if (tipoInformeId!=null && !tipoInformeId.contains("0")){
			listLocalTiposInforme = new ArrayList<String>();
			listLocalTiposInforme.addAll(tipoInformeId);
		}
		
		if (estadoId!=null && !estadoId.contains(0)){
			listLocalEstados = new ArrayList<Integer>();
			listLocalEstados.addAll(estadoId);
		}
			
		if (zonaId!=null && !zonaId.contains(0L)){
			listLocalZonas = new ArrayList<Number>();
			listLocalZonas.addAll(zonaId);
		}

		if (padrinoId!=null && !padrinoId.contains(0L)){
			listLocalPadrinos = new ArrayList<Number>();
			listLocalPadrinos.addAll(padrinoId);
		}
		
		if (cicloId==null || (cicloId!=null && cicloId.size()==0)){
			cicloId = new ArrayList<Long>();
			cicloId.add(cicloActual.getId());
		}

		if (StringUtils.isNotBlank(fechaDesde))
			dFechaDesde = Formateador.parsearFecha(fechaDesde);

		if (StringUtils.isNotBlank(fechaHasta))
			dFechaHasta = Formateador.parsearFecha(fechaHasta);
		
		boolean export = request.getParameter(TableTagParameters.PARAMETER_EXPORTING) != null;
		
		ExtendedPaginatedList listaPaginada = paginarInformes(cicloId, export, request, idTipo, listLocalEstados, 
												listLocalPadrinos, listLocalZonas, listLocalTiposInforme, 
												nombreAlumno, idEA, idRR, correctora, anioEscolar, dFechaDesde, dFechaHasta,eae);

        if (nombreEA==""){
        	nombreEA = null;
        	idEA=null;
        }
		
        if (nombreRR==""){
        	nombreRR = null;
        	idRR=null;
        }
        
		resul.put("listaInformes", listaPaginada);
        resul.put("size", listaPaginada.getFullListSize());
        resul.put("ciclos", cicloSrv.obtenerCiclosClonarBecas());
        resul.put("cicloId", cicloId); 
        resul.put("tipos", TipoPadrino.getListaTipos());
        resul.put("tiposInforme", InformeUtils.getTipoInformes());
        resul.put("tipoId", tipoId);
        resul.put("tipoInformeId", tipoInformeId);
        resul.put("estados", EstadoInforme.getListaEstados());
        resul.put("estadoId", estadoId); 
        resul.put("idPadrino", padrinoId);
        resul.put("padrino", padrino);
        resul.put("padrinos", this.obtenerListaPadrinoDto(perfilPadrinoSrv.obtenerActivos()));
        resul.put("idInforme", null);
        resul.put("idZona", zonaId);
        resul.put("zona", zona);
        resul.put("eae", eae);
		resul.put("zonas", this.obtenerZonaCimientosDto(zonaCimientosSrv.obtenerTodos()));
        resul.put("nombreAlumno", nombreAlumno);
		resul.put("ea", nombreEA);
		resul.put("idEA", idEA);
		resul.put("rr", nombreRR);
		resul.put("idRR", idRR);
		resul.put("correctora", correctora);
        resul.put("idCorrectora", idCorrectora);
		resul.put("listAniosEscolares", AnioEscolar.getAnioEscolares());
		resul.put("anioEscolar", anioEscolar);
		resul.put("fechaDesde", dFechaDesde);
		resul.put("fechaHasta", dFechaHasta);
		resul.put("tipoInformeIC", ConstantesInformes.nombreInformeCesacion);
		resul.put("tipoInformeIS2", ConstantesInformes.nombreInformeIS2);
		resul.put("tipoInformeIS3", ConstantesInformes.nombreInformeIS3);
		resul.put("estadoInformeFin", EstadoInforme.FINALIZADO.getValor());
		
		if(listLocalTiposInforme != null && listLocalTiposInforme.size() == 1)
			resul.put("tipoInformeExportar", listLocalTiposInforme.get(0));
		else
			resul.put("tipoInformeExportar", null);
		resul.put("urlRegreso", "/reporteGeneralInformes/verReporteGeneralInformes.do");

		resul.put("tipoInformeIS3", ConstantesInformes.nombreInformeIS3);
		resul.put("tipoInformeIS1", ConstantesInformes.nombreInformeIS1);
		resul.put("tipoInformeFP", ConstantesInformes.nombreInformeFP);
		resul.put("estadoInformeConstruccion", EstadoInforme.CONSTRUCCION.getValor());		
		resul.put("estadoInformeFin", EstadoInforme.FINALIZADO.getValor());		
		resul.put("estadoInformeEnviado", EstadoInforme.ENVIADO.getValor());		
		resul.put("estadoInformeRevision", EstadoInforme.REVISION.getValor());	
		resul.put("estadoInformePendiente", EstadoInforme.PENDIENTE_POR_RENOVACION.getValor());	
		resul.put("nombreCicloActual", cicloActual.getNombre());
		resul.put("nombreCicloAnterior", cicloAnterior.getNombre());	
		
		if(StringUtils.isNotBlank(mensaje))
			resul.put("mensaje", mensaje);
		if(StringUtils.isNotBlank(error))
			resul.put("error", error);
		
		Persona personaLogueada = obtenerPersona(request);
		if(personaLogueada.getPerfilSuperUsuario())
			resul.put("tipoPerfil", "superUsuario");
		else
			resul.put("tipoPerfil", "");
		
		session.setAttribute("menu", ConstantesMenu.menuExportacion);
		
		return forward("/reporteGeneralInformes/verReporteGeneralInformes", resul);
	}

	private List<PadrinoDTO> obtenerListaPadrinoDto(List<PerfilPadrino> padrinos) {
		List<PadrinoDTO> dtos = new ArrayList<PadrinoDTO>();
		
		for (PerfilPadrino pp : padrinos) {
			PadrinoDTO dto = new PadrinoDTO();
			if(pp.getTipo().equals(TipoPadrino.CORPORATIVO)) {
				dto.setNombre(pp.getEmpresa().getDenominacion());
			} else {
				dto.setNombre(pp.getDatosPersonales().getApellido() + ", " + pp.getDatosPersonales().getNombre());
			}
			
			if (dto.getNombre()!=null && dto.getNombre().length()>30)
				dto.setNombre(dto.getNombre().substring(0,30).trim());
					
			dto.setId(pp.getId());
			dtos.add(dto);
		}
		
		Collections.sort(dtos, new Comparator<PadrinoDTO>() {
			Locale myLocale = new Locale("es", "ES", "Traditional_WIN");
			Collator collator = Collator.getInstance(myLocale);

			{ collator.setStrength(Collator.PRIMARY); } // Replace constructor with an instance initializer

			public int compare(PadrinoDTO o1, PadrinoDTO o2) {
				return collator.compare(o1.getNombre(), o2.getNombre());
			}
		});
	    
		return dtos;
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

	
	private ExtendedPaginatedList paginarInformes(List<Long> idCiclo, Boolean export, HttpServletRequest request,
			Integer tipoId, List<Integer> idEstado,  List<Number> padrinoId, List<Number> zonaId, List<String> tipoInforme, 
			String nombreAlumno, Long idEA, Long idRR, String correctora, AnioEscolar anioEscolar, Date fechaDesde, Date fechaHasta, String eae) 
	{
		
		List<ReporteInformeDTO> informes = null;
		
		ExtendedPaginatedList listaPaginada = paginateListFactory.getPaginatedListFromRequest(request);
		

		int totalRows = srvInforme.obtenerCantidadInformesAReportar(idCiclo, tipoId, tipoInforme, idEstado, padrinoId, zonaId, 
														nombreAlumno, idEA, idRR, anioEscolar, fechaDesde, fechaHasta,eae);
		
		
		if(export){
			informes = srvInforme.obtenerInformesAReportar(idCiclo, tipoId, tipoInforme, idEstado, padrinoId, zonaId,nombreAlumno,
										idEA, idRR, anioEscolar, fechaDesde, fechaHasta,
										0, totalRows, listaPaginada.getSortDirection(), listaPaginada.getSortCriterion(),eae);
		}
		else
			informes = srvInforme.obtenerInformesAReportar(idCiclo, tipoId, tipoInforme, idEstado, padrinoId, zonaId, nombreAlumno,
										idEA, idRR, anioEscolar, fechaDesde, fechaHasta,
										listaPaginada.getFirstRecordIndex(),listaPaginada.getPageSize(),
										listaPaginada.getSortDirection(), listaPaginada.getSortCriterion(),eae);
		
		
		listaPaginada.setList(informes);
		
		listaPaginada.setTotalNumberOfRows(totalRows);

		return listaPaginada;
	}
	
	@RequestMapping("/reporteGeneralInformes/verInforme.do")
	public ModelAndView getInforme(@RequestParam("idInforme") Long idInforme,
			@RequestParam("accion") String accion,
			@RequestParam(required=false, value="retorno") String retorno,
			@RequestParam(required=false, value="valorPerfil") String valorPerfil){
		ModelAndView modelAndView = null;
		Map<String, Object> resul = new HashMap<String, Object>();
		Informe informe = srvInforme.obtenerInforme(idInforme);
		
			if(informe.getNombre().equals(ConstantesInformes.nombreInformeFP)){
				FichaPresentacion fp = (FichaPresentacion) informe;
				resul.put("ficha", fp);
				if(valorPerfil.equals("superUsuario") || valorPerfil.equals("RR"))
					if(accion.equals("edicion"))
						modelAndView = new ModelAndView("redirect:/informeFP/verInformeFPRevisionView.do?idFP=" + fp.getId() +
								"&valorPerfil=" + valorPerfil);
					else
						modelAndView = new ModelAndView("redirect:/informeFP/verFP.do?idFP=" + fp.getId());
				else
					modelAndView = new ModelAndView("redirect:/informeFP/verFP.do?idFP=" + fp.getId());
			}
			
			
			if(informe.getNombre().equals(ConstantesInformes.nombreInformeIS1)){
				InformeIS1 is1 = (InformeIS1) informe;
				resul.put("informe", is1);
				if(accion.equals("edicion")){
					modelAndView = new ModelAndView("redirect:/informeIS1/modificarView.do?idInformeIS1=" + is1.getId() + "&accion=" + accion  + 
							"&valorPerfil=" + valorPerfil);
				}
				else{
					modelAndView = new ModelAndView("redirect:/informeIS1/verInformeIS1General.do?idInformeIS1=" + is1.getId());
				}
				
			}
			
			if(informe.getNombre().equals(ConstantesInformes.nombreInformeIS2)){
				InformeIS2 is2 = (InformeIS2) informe;
				resul.put("informe", is2);
				if(accion.equals("edicion")){
					modelAndView = new ModelAndView("redirect:/informeIS2/modificarView.do?idInformeIS2=" + is2.getId() + "&accion=" + accion  + 
							"&valorPerfil=" + valorPerfil);
				}
				else{
					modelAndView = new ModelAndView("redirect:/informeIS2/verInformeIS2General.do?idInformeIS2=" + is2.getId());
				}
				
			}
			
			if(informe.getNombre().equals(ConstantesInformes.nombreInformeIS3)){
				InformeIS3 is3 = (InformeIS3) informe;
				resul.put("informe", is3);
				if(accion.equals("edicion")){
					modelAndView = new ModelAndView("redirect:/informeIS3/modificarView.do?idInformeIS3=" + is3.getId() + "&accion=" + accion + 
							"&valorPerfil=" + valorPerfil);
				}
				else{
					modelAndView = new ModelAndView("redirect:/informeIS3/verInformeIS3General.do?idInformeIS3=" + is3.getId());
				}
				
			}
			
			if(informe.getNombre().equals(ConstantesInformes.nombreInformeCesacion)){
				InformeCesacion ic = (InformeCesacion) informe;
				if(accion.equals("edicion")){
					modelAndView = new ModelAndView("redirect:/informeCesacion/verInformeCesacionDIView.do?idInformeCesacion=" + ic.getId() + 
							"&valorPerfil=" + valorPerfil);
				}
				else{
					modelAndView = new ModelAndView("redirect:/informeCesacion/verInformeCesacion.do?idInformeCesacion=" + ic.getId());
				}
			}
			
			if(modelAndView == null)
				modelAndView = new ModelAndView("redirect:/reporteGeneralInformes/verReporteGeneralInformes.do");
			
		return modelAndView;
	}
	
	@RequestMapping("/reporteGeneralInformes/exportarInformes.do")
	public ModelAndView exportarFP(HttpServletRequest request, HttpSession session,
			@RequestParam(required= false, value="cantRows") String totalRows, 
			@RequestParam(required= false, value="cicloId") List<Long> cicloId,
			@RequestParam(required= false, value="tipoId") Integer tipoId, 
			@RequestParam(required= false, value="estadoId") List<Integer> estadoId,
			@RequestParam(required= false, value="tipoInformeId") List<String> tipoInformeId, 
			@RequestParam(required= false, value="idPadrino") List<Long> padrinoId,
			@RequestParam(required= false, value="padrino") String padrino, 
			@RequestParam(required= false, value="idZona") List<Long> zonaId,
			@RequestParam(required= false, value="zona") String zona,
			@RequestParam(required= false, value="nombreAlumno") String nombreAlumno,
			@RequestParam(required= false, value="ea") String nombreEA,
			@RequestParam(required= false, value="idEA") Long idEA,
			@RequestParam(required= false, value="rr") String nombreRR,
			@RequestParam(required= false, value="eae") String eae,
			@RequestParam(required= false, value="idRR") Long idRR,
			@RequestParam(required= false, value="idAnioEscolar") Integer idAnioEscolar,
			@RequestParam(required= false, value="fechaDesde") String fechaDesde,
			@RequestParam(required= false, value="fechaHasta") String fechaHasta){
		List<Integer> listLocalEstados = null;
		List<Number> listLocalZonas = null;
		List<Number> listLocalPadrinos = null;
		List<String> listLocalTiposInforme = null;
		AnioEscolar anioEscolar = null;
		String excelView = null;
		Map<String,Object> resul = new HashMap<String, Object>();
		Integer idAnio = idAnioEscolar != null && idAnioEscolar.equals(0) ? null : idAnioEscolar;
		if (idAnio!=null){
			anioEscolar = AnioEscolar.getAnioEscolar(idAnio);
		}		
		Integer idTipo = tipoId != null && tipoId.equals(0) ? null : tipoId;	
		if (tipoInformeId!=null && !tipoInformeId.contains("0")  ){
			listLocalTiposInforme = new ArrayList<String>();
			listLocalTiposInforme.addAll(tipoInformeId);
		}
		if (estadoId!=null && !estadoId.contains(0)){
			listLocalEstados = new ArrayList<Integer>();
			listLocalEstados.addAll(estadoId);
		}			
		if (zonaId!=null && !zonaId.contains(0L)){
			listLocalZonas = new ArrayList<Number>();
			listLocalZonas.addAll(zonaId);
		}	
		if (padrinoId!=null && !padrinoId.contains(0L)){
			listLocalPadrinos = new ArrayList<Number>();
			listLocalPadrinos.addAll(padrinoId);
		}		
		if (cicloId==null || (cicloId!=null && cicloId.size()==0)){
			cicloId = new ArrayList<Long>();
			cicloId.add(cicloSrv.obtenerCicloActual().getId());
		}		
	
		resul.put("ciclos", cicloSrv.obtenerCiclosClonarBecas());
        resul.put("cicloId", cicloId); 
        resul.put("tipos", TipoPadrino.getListaTipos());
        resul.put("tiposInforme", InformeUtils.getTipoInformes());
        resul.put("idTipo", idTipo);
        resul.put("tipoInformeId", tipoInformeId);
        resul.put("estados", EstadoInforme.getListaEstados());
        resul.put("estadoId", estadoId); 
        resul.put("idPadrino", padrinoId);
        resul.put("padrino", padrino);
        resul.put("padrinos", this.obtenerListaPadrinoDto(perfilPadrinoSrv.obtenerActivos()));
        resul.put("idInforme", null);
        resul.put("idZona", zonaId);
        resul.put("zona", zona);
		resul.put("zonas", this.obtenerZonaCimientosDto(zonaCimientosSrv.obtenerTodos()));        
        resul.put("nombreAlumno", nombreAlumno);
		resul.put("ea", nombreEA);
		resul.put("eae", eae);
		resul.put("idEA", idEA);
		resul.put("rr", nombreRR);
		resul.put("idRR", idRR);
		resul.put("listAniosEscolares", AnioEscolar.getAnioEscolares());
		resul.put("anioEscolar", anioEscolar);
		resul.put("fechaDesde", fechaDesde);
		resul.put("fechaHasta", fechaHasta);
		resul.put("informeSrv", srvInforme);
		resul.put("cicloSrv", cicloSrv);
				
		LiberarMemoria lm = new LiberarMemoria();
		Thread tlm = new Thread(lm);
		tlm.start();
		
		if(listLocalTiposInforme.get(0).equals(ConstantesInformes.nombreInformeFP)){
			excelView = "exportarFPView";
		}
		if(listLocalTiposInforme.get(0).equals(ConstantesInformes.nombreInformeIS1)){
			excelView = "exportarIS1View";
		}
		if(listLocalTiposInforme.get(0).equals(ConstantesInformes.nombreInformeIS2)){
			excelView = "exportarIS2View";
		}
		if(listLocalTiposInforme.get(0).equals(ConstantesInformes.nombreInformeIS3)){
			excelView = "exportarIS3View";
		}
		if(listLocalTiposInforme.get(0).equals(ConstantesInformes.nombreInformeCesacion)){
			excelView = "exportarICView";
		}
		return new ModelAndView(excelView,resul);			
	}
	
	
	@RequestMapping("/reporteGeneralInformes/eliminarInforme.do")
	public ModelAndView eliminarInforme(HttpServletRequest request,@RequestParam("idInforme") Long idInforme){
		Map<String, Object> resul = new HashMap<String, Object>();
		ModelAndView modelAndView = null;
		String urlRegreso = "/reporteGeneralInformes/verReporteGeneralInformes.do";
		String error = "";
		Informe informe = srvInforme.obtenerInforme(idInforme);
		if(informe.getNombre().equals(ConstantesInformes.nombreInformeFP)){
			FichaPresentacion fp = (FichaPresentacion)informe;
			resul.put("ficha", fp);
			modelAndView = new ModelAndView("redirect:/informeFP/eliminarFP.do?idFP=" + fp.getId() + "&urlRegreso=" + urlRegreso);			
		}
		else{
			if(informe.getNombre().equals(ConstantesInformes.nombreInformeIS1)){
				InformeIS1 informeIS1 = (InformeIS1)informe;
				modelAndView = new ModelAndView("redirect:/informeIS1/eliminarIS1.do?idIS1=" + informeIS1.getId() + "&urlRegreso=" + urlRegreso);	
			}
			else{
				if(informe.getNombre().equals(ConstantesInformes.nombreInformeIS2)){
					InformeIS2 informeIS2 = (InformeIS2)informe;
					modelAndView = new ModelAndView("redirect:/informeIS2/eliminarIS2.do?idIS2=" + informeIS2.getId() + "&urlRegreso=" + urlRegreso);	
				}
				else{
					if(informe.getNombre().equals(ConstantesInformes.nombreInformeIS3)){
						InformeIS3 informeIS3 = (InformeIS3)informe;
						modelAndView = new ModelAndView("redirect:/informeIS3/eliminarIS3.do?idIS3=" + informeIS3.getId() + "&urlRegreso=" + 
								urlRegreso);	
					}
					else{
						if(informe.getNombre().equals(ConstantesInformes.nombreInformeCesacion)){
							InformeCesacion informeIC = (InformeCesacion)informe;
							modelAndView = new ModelAndView("redirect:/informeCesacion/eliminarIC.do?idIC=" + informeIC.getId() + "&urlRegreso=" + 
									urlRegreso);	
						}
						else{
							if(informe.getNombre().equals(ConstantesInformes.nombreComunicadoPendiente)){
								ComunicadoPendiente comunicado = (ComunicadoPendiente)informe;
								modelAndView = new ModelAndView("redirect:/informes/eliminarCRP.do?idCRP=" + comunicado.getId() + "&urlRegreso=" + 
										urlRegreso);
							}
							else{
								if(informe.getNombre().equals(ConstantesInformes.nombreComunicadoNoRenovacion)){
									ComunicadoNoRenovacion comunicado = (ComunicadoNoRenovacion)informe;
									modelAndView = new ModelAndView("redirect:/informes/eliminarCNR.do?idCNR=" + comunicado.getId() + "&urlRegreso=" + 
											urlRegreso);
								}
								else{
									error = "No se pudo eliminar el informe porque �ste no existe";
								}
							}
						}						
					}
				}
			}			
		}
		if(modelAndView == null)
			modelAndView = new ModelAndView("redirect:/reporteGeneralInformes/verReporteGeneralInformes.do?error=" + error);
		
		return modelAndView;
	}
	
	@RequestMapping("/reporteGeneralInformes/modificarPadrino.do")
	public ModelAndView informeAConstruccion(@RequestParam("idInforme") Long idInforme,	
			@RequestParam("becaId") Long idBeca,
			HttpServletRequest request, HttpSession session){
				
		Informe informe = srvInforme.obtenerInforme(idInforme);
		Beca beca = svrBeca.obtenerPorId(idBeca);
		String mensaje = "";
		String error = "";
		PerfilPadrino padrino = null;
		srvInforme.guardarInforme(informe);
		mensaje = "Se volvi� a construccion del informe seleccionado de forma satisfactoria";
		if(beca != null){
			 padrino = beca.getPadrino();
		}
		else
			error = "El padrino seleccionado no est� asociado a ninguna beca";
		if(informe != null && padrino != null){
			informe.setPadrino(padrino);
			informe.setBeca(beca);			
			srvInforme.guardarInforme(informe);
			mensaje = "Se volvi� a construccion del informe seleccionado de forma satisfactoria";
		}
		else
			error = "No existe el informe seleccionado";
		
		
		
		return verReporteGeneralInformes(request, session, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 
				null, null, null, null,null, mensaje, error);
	}
	@RequestMapping("/reporteGeneralInformes/informeAConstruccion.do")
	public ModelAndView modificarPadrino(@RequestParam("idInforme") Long idInforme,
			
			HttpServletRequest request, HttpSession session){
				
		Informe informe = srvInforme.obtenerInforme(idInforme);
		//Beca beca = svrBeca.obtenerPorId(idBeca);
		String mensaje = "";
		String error = "";
		//PerfilPadrino padrino = null;
		
		//if(beca != null){
		//	 padrino = beca.getPadrino();
		//}
		//else
		//	error = "El padrino seleccionado no est� asociado a ninguna beca";
		//if(informe != null && padrino != null){
		//	informe.setPadrino(padrino);
		//	informe.setBeca(beca);
			informe.setEstado(EstadoInforme.CONSTRUCCION);
			srvInforme.guardarInforme(informe);
			mensaje = "Se modifico el estado del informe seleccionado de forma satisfactoria";
		//}
		//else
		//	error = "No existe el informe seleccionado";
		
		
		return verReporteGeneralInformes(request, session, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 
				null, null, null, null,null, mensaje, error);
	}
	
	
	
}
