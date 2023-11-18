package org.cimientos.intranet.servicio;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.cimientos.intranet.dao.AlumnoDao;
import org.cimientos.intranet.dao.BoletinDao;
import org.cimientos.intranet.dto.AlumnoActivoDTO;
import org.cimientos.intranet.dto.BoletinDTO;
import org.cimientos.intranet.dto.EaDto;
import org.cimientos.intranet.dto.ExportarAlumnosDTO;
import org.cimientos.intranet.modelo.Beca;
import org.cimientos.intranet.modelo.Boletin;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.Materia;
import org.cimientos.intranet.modelo.NotaMateria;
import org.cimientos.intranet.modelo.Trimestre;
import org.cimientos.intranet.modelo.candidato.convocatoria.Convocatoria;
import org.cimientos.intranet.modelo.escuela.Escuela;
import org.cimientos.intranet.modelo.perfil.EstadoAlumno;
import org.cimientos.intranet.modelo.perfil.PerfilAlumno;
import org.cimientos.intranet.modelo.perfilEA.PerfilEA;
import org.cimientos.intranet.modelo.perfilPadrino.PerfilPadrino;
import org.cimientos.intranet.modelo.perfilRR.PerfilRR;
import org.cimientos.intranet.modelo.perfilTS.PerfilTS;
import org.cimientos.intranet.modelo.ubicacion.Provincia;
import org.cimientos.intranet.modelo.ubicacion.ZonaCimientos;
import org.cimientos.intranet.utils.AlumnoActivoHelper;
import org.cimientos.intranet.utils.Formateador;
import org.displaytag.properties.SortOrderEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cimientos.intranet.dto.MateriaDTO;
import com.cimientos.intranet.enumerativos.AnioEscolar;
import com.cimientos.intranet.enumerativos.CalificacionMateria;
import com.cimientos.intranet.enumerativos.EmitioCarta;
import com.cimientos.intranet.enumerativos.SituacionEscolarAlumno;
import com.googlecode.ehcache.annotations.Cacheable;
/**
 * AlumnoSrv
 * @author Julian Rios
 *
 */

@Service
@Transactional
public class AlumnoSrv {

	@Autowired
	private AlumnoDao dao;
	
	@Autowired
	private BoletinDao daoBoletin;
	
	@Autowired
	private AlumnoActivoHelper alumnoActivoHelper;
	

	/**
	 * Persiste un alumno en la base de datos.
	 * @param alumno
	 */

	public void agregarAlumno(PerfilAlumno alumno){
		alumno.setActivo(true);
		dao.guardar(alumno);
		dao.flush();		
	}
	
	/**
	 * Persiste un alumno modificado en la base de datos
	 * @param alumno
	 */
	public void modificarAlumno(PerfilAlumno alumno){
		dao.guardar(alumno);
		dao.flush();
	}
	
	/**
	 * Elimina un alumno de la base de datos
	 * @param alumno
	 */

	public void eliminarAlumno(PerfilAlumno alumno){
		dao.eliminar(alumno);
		dao.flush();
	}
	
	/**
	 * Recupera, si es que existe, el alumno con id=id
	 * @param id
	 * @return 
	 */
	public PerfilAlumno obtenerAlumno(long id){
		return dao.obtener(id);
	}
	
	/**
	 * Recupera en una lista todos los alumnos de la base de datos
	 * @return
	 */
	public List<PerfilAlumno> obtenerTodos(){
		return dao.obtenerTodos();
	}
	
	/**
	 * Este metodo trae ademas de los cesados, los usuarios inactivos (NO_RENOVADO,NO_INCORPORADO)
	 * @param ea
	 * @return
	 */
	public List<PerfilAlumno> obtenerCesadosPorEa(PerfilEA ea){
		return dao.obtenerCesadosPorEa(ea);
	}

	public List<PerfilAlumno> obtenerCesadosPorRr(PerfilRR rr){
		return dao.obtenerCesadosPorRr(rr);
	}
	
	/**
	 * Obtiene la lista de alumnos correspondiente a los ids pasados como parametro
	 * 
	 * @param list la lista de ids de los alumnos
	 * @return la lista de alumnos
	 */
	public List<PerfilAlumno> obtenerAlumnosPorIds(List<Long> list) {
		return dao.obtenerGrupo("id", list);
	}

	/**
	 * Obtiene la lista de alumnos que aun no tienen beca asignada
	 * 
	 * @return la lista de alumnos sin beca
	 */
	public List<PerfilAlumno> obtenerAlumnosSinBecaAsignada(List<EstadoAlumno> estadoAlumnos) {
		return dao.obtenerAlumnosSinBecaAsignada(estadoAlumnos);
	}

	/**
	 *  Obtiene la lista de alumnos que son becados (estado = altaBecado) 
	 *  y que aun no tienen EA asignado
	 *  
	 * @return la lista de alumnos sin EA
	 */
	public List<PerfilAlumno> obtenerBecadosSinAsignacionEA() {
		return dao.obtenerBecadosSinAsignacionEA();
	}

	/**
	 * Obtiene la lista de alumnos que estan en lista de espera(estado = listaEspera) 
	 * 
	 * @return la lista de alumnos  en lista de espera
	 */
	public List<PerfilAlumno> obtenerBecadosListaEspera() {
		return dao.obtenerBecadosListaEspera();
	}

	/**
	 * Obtiene la lista de alumnos listos para crear entrevistas de acompa�amiento. Los alumnos disponibles son
	 * aquello que tienen EA asignado.
	 * @return lista de alumnos que cumplen condicion
	 */
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerParaEntrevistaAcom(CicloPrograma ciclo) {
		return dao.obtenerParaEntrevistaAcom(ciclo);
	}



	/**
	 * @param idPerfilEA 
	 * @return
	 */
	public List<PerfilAlumno> obtenerBecadosSegunEa(Long idPerfilEA) {
		return dao.obtenerBecadosSinAsignacionEA(idPerfilEA);
	}

	/**
	 * Obtiene la lista de alumnos cuya escuela pertenece a la zona pasada por
	 * parametro. Esta lista es utlizada al asignar becas.
	 * 
	 * @param zona
	 * @param cantidadMostrar 
	 * @param primero 
	 * @return la lista de alumnos
	 */
	public List<PerfilAlumno> obtenerAlumnosPorZonaParaAsignacionBecas(ZonaCimientos zona) {
		List<EstadoAlumno> estados = new ArrayList<EstadoAlumno>();
		estados.add(EstadoAlumno.APROBADO);
		estados.add(EstadoAlumno.APROBADO_TS);
		return dao.obtenerAlumnosPorZona(zona, estados);
	}
	

	/**
	 * Obtiene la lista de alumnos cuya escuela pertenece a la zona pasada por
	 * parametro. Esta lista es utilizada al renovar becas paso II.
	 * 
	 * @param zona
	 * @return la lista de alumnos
	 */
	public List<PerfilAlumno> obtenerAlumnosPorZonaParaRenovacionBecasPasoII(
			ZonaCimientos zona) {
		List<EstadoAlumno> estados = new ArrayList<EstadoAlumno>();
		estados.add(EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION);
		return dao.obtenerAlumnosPorZona(zona, estados);
	}
	
	/**
	 * @param becaSeleccionada
	 * @return
	 */
	public List<PerfilAlumno> obtenerAlumnosMismaBecaCicloAnterior(Beca becaSeleccionada){
		List<EstadoAlumno> estados = new ArrayList<EstadoAlumno>();
		estados.add(EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION);
		return dao.obtenerAlumnosMismaBecaCicloAnterior(becaSeleccionada, estados);
		
	}
	
	
	/**
	 * Obtener alumnos por estado.
	 *
	 * @param estadosAlumnos the estados alumnos
	 * @return Devuelve una lista de alumnos, filtrados por varios estados.
	 * @since 22-dic-2010
	 * @author cfigueroa
	 */
	public List<PerfilAlumno> obtenerAlumnosPorEstado(List<EstadoAlumno> estadosAlumnos){
		return dao.obtenerAlumnosPorEstado(estadosAlumnos);
	}

	/**
	 * Calcula los datos de todos los alumnos del EA pasado por parametro, para armar los indicadores
	 * para el panel del RR en el ciclo dado
	 * @param perfilEA
	 * @param cicloPrograma 
	 * @return
	 */
	public EaDto obtenerDatosAlumnosPorEA(PerfilEA perfilEA, CicloPrograma cicloPrograma) {
		return dao.obtenerDatosAlumnosPorEA(perfilEA, cicloPrograma);
	}
	

	public Boletin getBoletinAnioAnterior(PerfilAlumno alumno) {
			return daoBoletin.obtenerBoletinCicloAnterior(alumno);
	}

	public PerfilAlumno obtenerPorDni(Integer dni) {
		return dao.obtenerPorDni(dni);
	}

	public List<PerfilAlumno> obtenerBecadosPorEa(PerfilEA ea)
	{
		return dao.obtenerSoloBecadosPorEa(ea);
	}
	
	public List<PerfilAlumno> obtenerBecadosPorRr(PerfilRR rr, CicloPrograma ciclo)
	{
		return dao.obtenerSoloBecadosPorRr(rr, ciclo);
	}
	
	public List<PerfilAlumno> obtenerAlumnos(List<Long> ids)
	{
		return dao.obtenerGrupo("id", ids);
	}

	/**
	 * @param eaSeleccionado
	 * @return
	 */
	public List<PerfilAlumno> obtenerAlumnosSegunZonaEA(PerfilEA ea) {
		return dao.obtenerAlumnosSegunZonaEA(ea);
	}

	/**
	 * @param object
	 * @return
	 */
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerAlumnosConBecaAsignada() {
		return dao.obtenerAlumnosConBecaAsignada();
	}

	/**
	 * @param zona
	 * @return
	 */
	public List<PerfilAlumno> obtenerAlumnosPorZonaParaReasignacion(
			ZonaCimientos zona) {
		List<EstadoAlumno> estados = new ArrayList<EstadoAlumno>();
		return dao.obtenerAlumnosPorZonaParaReasignacion(zona, estados);
	}

	/**
	 * @param eaSeleccionado
	 * @return
	 */
	public List<PerfilAlumno> obtenerAlumnosParaReasignarSegunZonaEA(
			PerfilEA eaSeleccionado) {
		return dao.obtenerAlumnosParaReasignarSegunZonaEA(eaSeleccionado);
	}
	
	/**
	 * Este metodo borra de la session de hibernate el objeto.
	 * <b>Solo utilizar cuando se necesite guardar el mismo objeto dos veces en un mismo metodo</b>
	 *
	 * @since 04-feb-2011
	 * @author cfigueroa
	 */
	public void clearObjetoCache(){
		dao.clear();
	}
	
	/**
	 * Obtiene todos los alumnos disponible de un EA. Los alumnos disponibles son los que no estan cesados y tienen una beca asignada.
	 * Ademas son los del ciclo pasado por parametro
	 * @param perfilEA
	 * @param cicloActual
	 * @return
	 */
	public List<PerfilAlumno> obtenerBecadosDisponibles(PerfilEA perfilEA,CicloPrograma ciclo) {
		return dao.obtenerBecadosDisponibles(perfilEA,ciclo);
	}

	public List<PerfilAlumno> obtenerBecadosParaPanelEA(List<Long> becados){
		return dao.obtenerBecadosParaPanelEA(becados);
	}
	
	public List<PerfilAlumno> obtenerBecadosParaActivarPanelEA(List<Long> becados){
		return dao.obtenerBecadosParaActivarPanelEA(becados);
	}

	/**
	 * @param idEA
	 * @param cicloActual
	 * @return
	 */
	public List<PerfilAlumno> obtenerBecadosParaPanelEA(Long idEA,
			CicloPrograma cicloActual) {
		return dao.obtenerBecadosParaPanelEA(idEA, cicloActual);
	}
	
	

	/**
	 * @param id
	 * @return
	 */
	public Boolean verSiAlumnoTieneBoletin(Long id) {
		return dao.verSiAlumnoTieneBoletin(id);
	}
	
	
	/**
	 * Obtener alumno ts seleccion.
	 *
	 * @param perfilTS the perfil ts
	 * @param entrevistaSeleccion Si es true es de seleccion , sino es de acompa�amiento
	 * @return the list
	 * @since 08-abr-2011
	 * @author cfigueroa
	 */
	public List<PerfilAlumno> obtenerAlumnoParaTS(PerfilTS perfilTS,Boolean entrevistaSeleccion){
		return dao.obtenerAlumnoParaTS(perfilTS, entrevistaSeleccion);
	}
	
	

	/**
	 * @param ea
	 * @return
	 */
	public List<PerfilAlumno> obtenerBecadosCicloActualPorEA(PerfilEA ea) {
		return dao.obtenerBecadosCicloActualPorEA(ea);
	}
	
	
	/**
	 * Obtener alumnos exportar.
	 *
	 * @return the list
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
	public List<ExportarAlumnosDTO> obtenerAlumnosExportar(int firstResult, int maxResults,
            SortOrderEnum sortDirection, String sortCriterion, EstadoAlumno estadoAlumno, ZonaCimientos zona, 
            Convocatoria convocatoria, PerfilPadrino padrino, PerfilEA ea, String nombreAlumno, AnioEscolar anio,
            Boolean adicional, boolean becadosActivos, String eae, Escuela escuela){
		return dao.obtenerAlumnosExportar(firstResult,maxResults,sortDirection,sortCriterion,estadoAlumno,zona,
				convocatoria,padrino,ea,nombreAlumno,anio,adicional, becadosActivos,eae, escuela);
	}
	
	/**
	 * Obtener cantidad alumnos exportar.
	 *
	 * @param estadoAlumno the estado alumno
	 * @param zona the zona
	 * @param convocatoria the convocatoria
	 * @param padrino the padrino
	 * @param ea the ea
	 * @return the integer
	 * @since 26-abr-2011
	 * @author cfigueroa
	 * @param nombreAlumno 
	 * @param adicional 
	 * @param anio 
	 * @param becadosActivos 
	 */
	public Integer obtenerCantidadAlumnosExportar(EstadoAlumno estadoAlumno, 
			ZonaCimientos zona, Convocatoria convocatoria, PerfilPadrino padrino, PerfilEA ea, String nombreAlumno, AnioEscolar anio, Boolean adicional, boolean becadosActivos, String eae, Escuela escuela){
		return dao.obtenerCantidadAlumnosExportar(estadoAlumno,zona,convocatoria,padrino,ea,nombreAlumno,anio,adicional,becadosActivos,eae, escuela);
	}
	
	/**
	 * Obtener alumnos para emision cartas.
	 *
	 * @param estadosAlumnos the estados alumnos
	 * @param firstResult the first result
	 * @param maxResults the max results
	 * @param sortDirection the sort direction
	 * @param sortCriterion the sort criterion
	 * @return the list
	 * @since 28-abr-2011
	 * @author cfigueroa
	 * @param emitioCarta 
	 * @param escuela 
	 * @param zona 
	 * @param estadoAlumno 
	 * @param nombreAlumno 
	 * @param idCiclo 
	 */
	public List<PerfilAlumno> obtenerAlumnosParaEmisionCartas(List<EstadoAlumno> estadosAlumnos,int firstResult, int maxResults,
            												SortOrderEnum sortDirection, String sortCriterion, 
            												String nombreAlumno, EstadoAlumno estadoAlumno, 
            												ZonaCimientos zona, Escuela escuela, EmitioCarta emitioCarta, Long idCiclo){
		return dao.obtenerAlumnosParaEmisionCartas(estadosAlumnos,firstResult,maxResults,sortDirection,sortCriterion,nombreAlumno,estadoAlumno,zona,escuela,emitioCarta,idCiclo);
	}
	
	/**
	 * Cantidad alumnos emision cartas.
	 *
	 * @param estadosAlumnos the estados alumnos
	 * @param firstResult the first result
	 * @param maxResults the max results
	 * @param sortDirection the sort direction
	 * @param sortCriterion the sort criterion
	 * @return the integer
	 * @since 28-abr-2011
	 * @author cfigueroa
	 * @param emitioCarta 
	 * @param escuela 
	 * @param zona 
	 * @param estadoAlumno 
	 * @param nombreAlumno 
	 * @param idCiclo 
	 */
	public Integer cantidadAlumnosEmisionCartas(List<EstadoAlumno> estadosAlumnos,int firstResult, int maxResults,
			SortOrderEnum sortDirection, String sortCriterion, String nombreAlumno, EstadoAlumno estadoAlumno, ZonaCimientos zona, Escuela escuela, EmitioCarta emitioCarta, Long idCiclo){
		return dao.cantidadAlumnosEmisionCartas(estadosAlumnos,firstResult,maxResults,sortDirection,sortCriterion,nombreAlumno,estadoAlumno,zona,escuela,emitioCarta,idCiclo);
	}
	
	public List<PerfilAlumno> obtenerGrupo(List<Long> ids)
	{
		return dao.obtenerGrupo("id", ids);
	}

	public List<PerfilAlumno> obtenerBecadosParaActivarPanelEASeleccion(List<Long> candidatosId) {
		return dao.obtenerBecadosParaActivarPanelEASeleccion(candidatosId);
	}

	public int obtenerCantidadBecados(Long idRr, Long idEa, EstadoAlumno estadoAlumno, ZonaCimientos zona, PerfilPadrino padrino, String nombreAlumno, AnioEscolar anio, Boolean adicional, Long idCiclo) {
		return dao.obtenerCantidadBecados(idRr,idEa,estadoAlumno,zona,padrino,nombreAlumno,anio,adicional, idCiclo);
	}

	public List<AlumnoActivoDTO> obtenerBecadosExportar(int firstResult,int maxResults, SortOrderEnum sortDirection,
			String sortCriterion,Long idRr, Long idEa, EstadoAlumno estadoAlumno, ZonaCimientos zona, PerfilPadrino padrino, String nombreAlumno, AnioEscolar anio, Boolean adicional, Long idCiclo) {
		List<PerfilAlumno> alumnos = dao.obtenerBecadosExportar(firstResult,maxResults,sortDirection,sortCriterion,idRr,idEa,estadoAlumno,zona,padrino,nombreAlumno,anio,adicional,idCiclo);
		return alumnoActivoHelper.obtenerAlumnos(alumnos);
	}

	
	/**
	 * Este metodo cambia el a�o escolar de los alumnos. Incrementa el a�o escolar.
	 * Ver documento "Documento de Relevamiento - Noviembre - CERRADO" para detalle de que alumnos son los que
	 * cambian de a�o
	 */
	public void avanzarAnioEscolar(){
		dao.avanzarAnioEscolar();
	}


	public int obtenerCantidadAlumnosInactivos(ZonaCimientos zona, PerfilPadrino padrino,PerfilEA ea,
			Integer dni, String nombreAlumno, EstadoAlumno estadoAlumno, Escuela escuelaAlumno, AnioEscolar anio,
			SituacionEscolarAlumno situacionEscolar, List<Long> listPeriodosIdBaja, List<Long> listPeriodosIdEgreso, 
			Integer cantPrevias, Integer idTipo, Boolean sexo, Provincia prov, Date dFechaDesde, Date dFechaHasta, String eae) {
		return dao.obtenerCantidadAlumnosInactivos(zona,padrino,ea,dni,nombreAlumno,estadoAlumno, escuelaAlumno,anio,situacionEscolar,
				listPeriodosIdBaja,listPeriodosIdEgreso, cantPrevias,idTipo,sexo,prov,dFechaDesde,dFechaHasta,eae);
	}


	/**
	 * Retorna la lista de alumnos inactivos, aplicando los criterios pasados en los filtros
	 * @param i
	 * @param totalRows
	 * @param sortDirection
	 * @param sortCriterion
	 * @param zona
	 * @param padrino
	 * @param ea
	 * @param nombreAlumno
	 * @param estadoAlumno 
	 * @param escuelaAlumno 
	 * @param nombreAlumno2 
	 * @param anio
	 * @param adicional
	 * @param situacionEscolar 
	 * @param idPeriodo 
	 * @param idPeriodoEgreso 
	 * @param cantPrevias 
	 * @param idTipo 
	 * @param sexo 
	 * @param prov 
	 * @param dFechaHasta 
	 * @param dFechaDesde 
	 * @return
	 */
	public List<PerfilAlumno> obtenerAlumnosInactivos(int i,int totalRows, SortOrderEnum sortDirection,	String sortCriterion,ZonaCimientos zona,
			PerfilPadrino padrino, PerfilEA ea,	Integer dni, String nombreAlumno, EstadoAlumno estadoAlumno, Escuela escuelaAlumno,
			AnioEscolar anio,SituacionEscolarAlumno situacionEscolar, List<Long> listPeriodosIdBaja, List<Long> listPeriodosIdEgreso, Integer cantPrevias, Integer idTipo,
			Boolean sexo, Provincia prov, Date dFechaDesde, Date dFechaHasta, String eae) {
		return dao.obtenerAlumnosInactivos(i,totalRows, sortDirection,sortCriterion,zona,padrino,ea,dni,nombreAlumno,estadoAlumno,
				escuelaAlumno,anio,situacionEscolar,listPeriodosIdBaja,listPeriodosIdEgreso, cantPrevias,idTipo,sexo,prov,dFechaDesde,dFechaHasta,eae);
	}

	/**
	 * Calcula la cantidad de alumnos que tienen una beca igual del a�o anterior
	 * @param idZona - id de zona de la beca
	 * @param idPadrino - id del padrino de la beca
	 * @param ordenCiclo - orden del ciclo para calcular el ciclo anterior
	 * @return
	 */
	public int cantidadAlumnosMismaBecaCicloAnterior(Long idZona, Long idPadrino, Integer ordenCiclo) {
		List<EstadoAlumno> estados = new ArrayList<EstadoAlumno>();
		estados.add(EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION);
		return dao.cantidadAlumnosMismaBecaCicloAnterior(idZona, idPadrino, ordenCiclo, estados);
	}

	public List<PerfilAlumno> alumnosMismaBecaCicloAnterior(Beca beca) {
		return dao.alumnosMismaBecaCicloAnterior(beca);
	}

	public List<PerfilAlumno> obtenerAlumnosMismaZonaBeca(Beca beca) {
		return dao.obtenerAlumnosMismaZonaBeca(beca);
	}
	
	public int cantidadAlumnosActivosMismaEscuela(Escuela escuela){
		return dao.cantidadAlumnosActivosMismaEscuela(escuela);
	}
	
	
	public List<BoletinDTO> obtenerBoletinesAExportar(EstadoAlumno estadoAlumno, ZonaCimientos zona, 
            Convocatoria convocatoria, PerfilPadrino padrino, PerfilEA ea, String nombreAlumno, AnioEscolar anio,
            Boolean adicional, boolean becadosActivos, CicloPrograma ciclo, int firstResult, int maxResults,
            SortOrderEnum sortDirection, String sortCriterion, String eae, Escuela escuela){
		 List<ExportarAlumnosDTO> alumnosDTO = dao.obtenerAlumnosExportar(firstResult,maxResults,sortDirection,sortCriterion,estadoAlumno,zona,
				convocatoria,padrino,ea,nombreAlumno,anio,adicional, becadosActivos, eae, escuela);
		 
		 return cargaBoletinDTO(alumnosDTO, ciclo);
	}
		
	public List<BoletinDTO> cargaBoletinDTO(List<ExportarAlumnosDTO> alumnosDTO, CicloPrograma ciclo){		
		
		List<BoletinDTO> boletinesDTO = new ArrayList<BoletinDTO>();
		BoletinDTO boletinDTO = null;
		
		for (ExportarAlumnosDTO alumnoDTO : alumnosDTO){			
			//if (alumnoDTO.getAlumno().getBoletin().getCiclo()!=null){
			//if (ciclo!=alumnoDTO.getAlumno().getBoletin().getCiclo()){
				
				
			//}else{
			boletinDTO = new BoletinDTO();			
			boletinDTO.setIdAlumno(alumnoDTO.getAlumno().getId());			
			boletinDTO.setApellidoAlumno(alumnoDTO.getAlumno().getDatosPersonales().getApellido());
			boletinDTO.setNombreAlumno(alumnoDTO.getAlumno().getDatosPersonales().getNombre());			
			boletinDTO.setDni(alumnoDTO.getAlumno().getDatosPersonales().getDni().toString());			
			boletinDTO.setFechaNacimiento(Formateador.formatearFecha(alumnoDTO.getAlumno().getDatosPersonales().getFechaNacimiento(), "dd/MM/yyyy"));
			boletinDTO.setAnioEscolar(alumnoDTO.getAlumno().getAnioEscolar().getValor());		
			boletinDTO.setAnioAdicional(alumnoDTO.getAlumno().getAnioAdicional()?"Si" : "No");
			boletinDTO.setIdEscuela(alumnoDTO.getAlumno().getEscuela().getId());
			boletinDTO.setEscuelaNombre(alumnoDTO.getAlumno().getEscuela().getNombre());
			boletinDTO.setEscuelaLocalidad(alumnoDTO.getAlumno().getEscuela().getZonaCimientos().getNombre());	
			boletinDTO.setEae(alumnoDTO.getAlumno().getEae());
			// verificar si existe RA2
			if (alumnoDTO.getAlumno().getResponsable2() !=null && StringUtils.isNotBlank(alumnoDTO.getAlumno().getResponsable2().getNombre())){
				boletinDTO.setResponsable(alumnoDTO.getAlumno().getResponsable2().getApellido() + " " + alumnoDTO.getAlumno().getResponsable2().getNombre());
				if(alumnoDTO.getAlumno().getResponsable2().getIdVinculo() != null){
					boletinDTO.setVinculo(alumnoDTO.getAlumno().getResponsable2().getIdVinculo().getValor());
				}			
			}
			else{
				boletinDTO.setResponsable(alumnoDTO.getAlumno().getResponsable1().getApellido() + " " + alumnoDTO.getAlumno().getResponsable1().getNombre());
				if(alumnoDTO.getAlumno().getResponsable1().getIdVinculo() != null){
					boletinDTO.setVinculo(alumnoDTO.getAlumno().getResponsable1().getIdVinculo().getValor());					
				}
			}
			if(alumnoDTO.getAlumno().getFechaPBE() != null)
				boletinDTO.setFechaPBE(Formateador.formatearFecha(alumnoDTO.getAlumno().getFechaPBE(), "dd/MM/yyyy"));
			if(alumnoDTO.getAlumno().getFechaReincorporacionPBE() != null)
				boletinDTO.setFechaReincorporacionPBE(Formateador.formatearFecha(alumnoDTO.getAlumno().getFechaReincorporacionPBE(), "dd/MM/yyyy"));
			if(alumnoDTO.getAlumno().getEa() != null){
				boletinDTO.setEa(alumnoDTO.getAlumno().getEa().getDatosPersonales().getApellido() + " " + 
						alumnoDTO.getAlumno().getEa().getDatosPersonales().getNombre());
				if(alumnoDTO.getAlumno().getEa().getRr() != null)
					boletinDTO.setRr(alumnoDTO.getAlumno().getEa().getRr().getDatosPersonales().getApellido() + " " + 
							alumnoDTO.getAlumno().getEa().getRr().getDatosPersonales().getNombre());			
			}
			if(alumnoDTO.getAlumno().getBeca() != null){
				if(alumnoDTO.getAlumno().getBeca().getPadrino() != null){
					boletinDTO.setTipoPadrino(alumnoDTO.getAlumno().getBeca().getPadrino().getTipo().getValor());
					if(alumnoDTO.getAlumno().getBeca().getPadrino().getDatosPersonales() != null)				
						boletinDTO.setPadrino(alumnoDTO.getAlumno().getBeca().getPadrino().getDatosPersonales().getApellido() + ", " 
								+ alumnoDTO.getAlumno().getBeca().getPadrino().getDatosPersonales().getNombre());
					else
						boletinDTO.setPadrino(alumnoDTO.getAlumno().getBeca().getPadrino().getEmpresa().getDenominacion());
				}
			}
			
			
			if(alumnoDTO.getAlumno().getBoletin() != null){
				if(alumnoDTO.getAlumno().getBoletin().getCiclo().equals(ciclo)){
					this.cargarBoletin(alumnoDTO.getAlumno().getBoletin(), boletinDTO);
					boletinDTO.setCicloBoletin(alumnoDTO.getAlumno().getBoletin().getCiclo().getNombre());
					boletinDTO.setAnioEscolarBoletin(alumnoDTO.getAlumno().getBoletin().getAno().getValor());
					boletinDTO.setExisteBoletin(true);
				}
				else{
					if(!alumnoDTO.getAlumno().getHistorialBoletin().isEmpty()){
						Boletin boletin = alumnoDTO.getAlumno().obtenerBoletinCiclo(ciclo);
						if(boletin != null){
							this.cargarBoletin(boletin, boletinDTO);
							boletinDTO.setCicloBoletin(boletin.getCiclo().getNombre());
							boletinDTO.setAnioEscolarBoletin(boletin.getAno().getValor());
							boletinDTO.setExisteBoletin(true);
						}
						else{
							boletinDTO.setExisteBoletin(false);
						}
					}
					else{
						boletinDTO.setExisteBoletin(false);
					}
				}
			}
			else{				
				if(!alumnoDTO.getAlumno().getHistorialBoletin().isEmpty()){
					Boletin boletin = alumnoDTO.getAlumno().obtenerBoletinCiclo(ciclo);
					if(boletin != null){
						this.cargarBoletin(boletin, boletinDTO);
						boletinDTO.setCicloBoletin(boletin.getCiclo().getNombre());
						boletinDTO.setAnioEscolarBoletin(boletin.getAno().getValor());
						boletinDTO.setExisteBoletin(true);
					}
					else{
						boletinDTO.setExisteBoletin(false);
					}
				}
				else{
					boletinDTO.setExisteBoletin(false);
				}				
			}
			boletinesDTO.add(boletinDTO);
		}
		//}
		//}	
		return boletinesDTO;
	}	
	
	private BoletinDTO cargarBoletin(Boletin boletin, BoletinDTO boletinDTO){		
		if(boletin != null){				
			// Previas			
			List<MateriaDTO> previas = new ArrayList<MateriaDTO>();			
			if(boletin.getPrevias() != null && boletin.getPrevias().size() > 0){			
				List<NotaMateria> notasPreviasMarzo = new ArrayList<NotaMateria>();
				List<NotaMateria> notasPreviasJulio = new ArrayList<NotaMateria>();
				List<NotaMateria> notasPreviasDiciembre = new ArrayList<NotaMateria>();				
				Trimestre previasJulio = boletin.getPrevias().get(0);
				Trimestre previasDiciembre = boletin.getPrevias().get(1);
				Trimestre previasMarzo = boletin.getPrevias().get(2);				
				for (NotaMateria notaMateria : previasMarzo.getMaterias()) {
					notasPreviasMarzo.add(notaMateria);
				}
				for (NotaMateria notaMateria : previasJulio.getMaterias()) {
					notasPreviasJulio.add(notaMateria);
				}
				for (NotaMateria notaMateria : previasDiciembre.getMaterias()) {
					notasPreviasDiciembre.add(notaMateria);
				}				
				for (int i = 0; i < boletin.getMateriasPrevias().size(); i++) {
					Materia materiaP = boletin.getMateriasPrevias().get(i);
					MateriaDTO materiaDTO = new MateriaDTO();
					NotaMateria notaMarzo = notasPreviasMarzo.get(i);
					NotaMateria notaJulio = notasPreviasJulio.get(i);
					NotaMateria notaDic = notasPreviasDiciembre.get(i);										
					if (materiaP.equals(notaMarzo.getMateria())) {
						materiaDTO.setNombre(notaMarzo.getMateria().getNombre());
						materiaDTO.setCiclo(notaMarzo.getCiclo());
						if(CalificacionMateria.getListaCalificacionesAptasParaBoletinExportarIS1().contains(notaMarzo.getCalificacion())
								|| CalificacionMateria.getListaCalificacionesAptasParaBoletinExportarIS1().contains(notaJulio.getCalificacion())
								|| CalificacionMateria.getListaCalificacionesAptasParaBoletinExportarIS1().contains(notaDic.getCalificacion())){
							
							// PARA EL VALOR DE LA CALIFICACION
							materiaDTO.setNotaMarzo(notaMarzo.getCalificacion().getValor());
							materiaDTO.setNotaFin(notaJulio.getCalificacion().getValor());
							materiaDTO.setNotaDic(notaDic.getCalificacion().getValor());
							
							// PARA PONER APROBROBADA DESAPROBADA
							materiaDTO.setNotaMarzo(notaMarzo.getEstado().getValor());
							materiaDTO.setNotaFin(notaJulio.getEstado().getValor());
							materiaDTO.setNotaDic(notaDic.getEstado().getValor());
						}
						
						previas.add(materiaDTO);
					}					
				}
			}							
			boletinDTO.setPreviasDTO(previas);	
			// boletin anterior			
			List<NotaMateria> notasPrimero = new ArrayList<NotaMateria>();
			List<NotaMateria> notasSegundo = new ArrayList<NotaMateria>();
			List<NotaMateria> notasTercero = new ArrayList<NotaMateria>();
			List<NotaMateria> notasFin = new ArrayList<NotaMateria>();
			List<NotaMateria> notasDiciembre = new ArrayList<NotaMateria>();
			List<NotaMateria> notasMarzo = new ArrayList<NotaMateria>();
			List<MateriaDTO> materias = new ArrayList<MateriaDTO>();			
			if (isUnTrimestreConMaterias(boletin) || isBoletinSinMaterias(boletin)) {				
				Trimestre primero = boletin.getTrimestres().get(0);
				Trimestre segundo = boletin.getTrimestres().get(1);
				Trimestre tercero = boletin.getTrimestres().get(2);
				Trimestre fin = boletin.getTrimestres().get(3);
				Trimestre diciembre = boletin.getTrimestres().get(4);
				Trimestre marzo = boletin.getTrimestres().get(5);				
				for (NotaMateria notaMateria : primero.getMaterias()) {
					notasPrimero.add(notaMateria);
				}
				for (NotaMateria notaMateria : segundo.getMaterias()) {
					notasSegundo.add(notaMateria);
				}
				for (NotaMateria notaMateria : tercero.getMaterias()) {
					notasTercero.add(notaMateria);
				}
				for (NotaMateria notaMateria : fin.getMaterias()) {
					notasFin.add(notaMateria);
				}
				for (NotaMateria notaMateria : diciembre.getMaterias()) {
					notasDiciembre.add(notaMateria);
				}
				for (NotaMateria notaMateria : marzo.getMaterias()) {
					notasMarzo.add(notaMateria);
				}			
				for (int i = 0; i < boletin.getMaterias().size(); i++) {					
					Materia materia1 = boletin.getMaterias().get(i);
					MateriaDTO materiaDTO = new MateriaDTO();
					NotaMateria notaPri = notasPrimero.get(i);
					NotaMateria notaSeg = notasSegundo.get(i);
					NotaMateria notaTerc = notasTercero.get(i);
					NotaMateria notaFin = notasFin.get(i);
					NotaMateria notaDic = notasDiciembre.get(i);
					NotaMateria notaMarzo = notasMarzo.get(i);				
					////System.out.println(boletin.getId()+" -------");
					if (materia1.equals(notaPri.getMateria())) {
						if(CalificacionMateria.getListaCalificacionesAptasParaBoletinExportarIS1().contains(notaPri.getCalificacion())){
							this.getMateriaParaBoletinIS1(materiaDTO, notaPri, notaSeg, notaTerc, notaFin, notaDic, notaMarzo, materia1);
						}
						else{
							if(CalificacionMateria.getListaCalificacionesAptasParaBoletinExportarIS1().contains(notaSeg.getCalificacion())){
								this.getMateriaParaBoletinIS1(materiaDTO, notaPri, notaSeg, notaTerc, notaFin, notaDic, notaMarzo, materia1);
							}
							else{
								if(CalificacionMateria.getListaCalificacionesAptasParaBoletinExportarIS1().contains(notaTerc.getCalificacion())){
									this.getMateriaParaBoletinIS1(materiaDTO, notaPri, notaSeg, notaTerc, notaFin, notaDic, notaMarzo, materia1);
								}
								else{
									materiaDTO = null;
								}
							}
						}
					}								
					if(materiaDTO != null){
						materias.add(materiaDTO);				
					}							
				}			
			}		
			boletinDTO.setMateriasDto(materias);			
			// conducta		
			String conducta="";
			String diasHabiles="";
			Float totalDiasHabiles=(float) 0;
			if (boletin.getConductaPrimerTrimestre()!=null){
				conducta=boletin.getConductaPrimerTrimestre().getValor();
			}			
			if (boletin.getConductaSegundoTrimestre()!=null){
				conducta=conducta+", "+boletin.getConductaSegundoTrimestre().getValor();							
			}			
			if (boletin.getConductaTercerTrimestre()!=null){
				conducta=conducta+", "+boletin.getConductaTercerTrimestre().getValor();								
			}			
			boletinDTO.setConductaB(conducta);						
			// dias habiles		
			Float diasHabiles1T=(float)0;
			Float diasHabiles2T=(float)0;
			Float diasHabiles3T=(float)0;			
			String diasHabiles1S="";
			String diasHabiles2S="";
			String diasHabiles3S="";		
			if (boletin.getDiasHabilesPrimerTrimestre() !=null){				
				diasHabiles1T= Float.parseFloat(boletin.getDiasHabilesPrimerTrimestre().toString());
				diasHabiles1S=boletin.getDiasHabilesPrimerTrimestre().toString();				
			}			
			if (boletin.getDiasHabilesSegundoTrimestre() !=null){				
				diasHabiles2T=Float.parseFloat(boletin.getDiasHabilesSegundoTrimestre().toString());
				diasHabiles2S=boletin.getDiasHabilesSegundoTrimestre().toString();			
			}				
			if (boletin.getDiasHabilesTercerTrimestre() !=null){				
				diasHabiles3T=Float.parseFloat(boletin.getDiasHabilesTercerTrimestre().toString());
				diasHabiles3S=boletin.getDiasHabilesTercerTrimestre().toString();
			}				
			if (diasHabiles1S==""){				
				diasHabiles1S="Sin dato";				
			}			
			if (diasHabiles2S==""){
				diasHabiles2S="Sin dato";				
			}			
			if (diasHabiles3S==""){				
				diasHabiles3S="Sin dato";				
			}			
			diasHabiles=diasHabiles1S+", " + diasHabiles2S+", "+ diasHabiles3S;
			totalDiasHabiles=diasHabiles1T+diasHabiles2T+diasHabiles3T;			
			boletinDTO.setDiasHabiles(diasHabiles);
			boletinDTO.setDiasHabilesFinales(totalDiasHabiles);			
			diasHabiles="";				
			totalDiasHabiles=(float) 0;
			diasHabiles1S="";
			diasHabiles1T=(float)0;
			diasHabiles2S="";
			diasHabiles2T=(float)0;
			diasHabiles3S="";
			diasHabiles3T=(float)0;
			totalDiasHabiles=(float)0;			
			// inasistencias			
			if (boletin.getInasistenciasPrimerTrimestre() !=null){
				diasHabiles1S=boletin.getInasistenciasPrimerTrimestre().toString();
				diasHabiles1T=Float.parseFloat(boletin.getInasistenciasPrimerTrimestre().toString());								
			}			
			if (boletin.getInasistenciasSegundoTrimestre() !=null){				
				diasHabiles2S=boletin.getInasistenciasSegundoTrimestre().toString();
				diasHabiles2T=Float.parseFloat(boletin.getInasistenciasSegundoTrimestre().toString());					
			}
			if (boletin.getInasistenciasTercerTrimestre() !=null){				
				diasHabiles3S=boletin.getInasistenciasTercerTrimestre().toString();
				diasHabiles3T=Float.parseFloat(boletin.getInasistenciasTercerTrimestre().toString());				
			}			
			if (diasHabiles1S==""){				
				diasHabiles1S="Sin dato";				
			}			
			if (diasHabiles2S==""){				
				diasHabiles2S="Sin dato";				
			}			
			if (diasHabiles3S==""){				
				diasHabiles3S="Sin dato";				
			}	
			diasHabiles=diasHabiles1S+", " + diasHabiles2S+", "+ diasHabiles3S;
			totalDiasHabiles=diasHabiles1T+diasHabiles2T+diasHabiles3T;			
			boletinDTO.setInasistencias(diasHabiles);
			boletinDTO.setInasistencasFinales(totalDiasHabiles);	
		}
		return boletinDTO;
	}
	
	private Boolean isUnTrimestreConMaterias(Boletin boletin){
		Boolean tieneUnTrimestreCargado = false;			
		Trimestre primero = boletin.getTrimestres().get(0);
		Trimestre segundo = boletin.getTrimestres().get(1);
		Trimestre tercero = boletin.getTrimestres().get(2);
		Trimestre fin = boletin.getTrimestres().get(3);
		Trimestre diciembre = boletin.getTrimestres().get(4);
		Trimestre marzo = boletin.getTrimestres().get(5);
			
		if ((primero.getMaterias().size() != 0)
				|| (segundo.getMaterias().size() != 0)
				|| (tercero.getMaterias().size() != 0)
				|| (fin.getMaterias().size() != 0)
				|| (diciembre.getMaterias().size() != 0)
				|| (marzo.getMaterias().size() != 0)) {
			tieneUnTrimestreCargado = true;
		}		
		return tieneUnTrimestreCargado;
	}
	
	private Boolean isBoletinSinMaterias(Boletin boletin){
		Trimestre primero = boletin.getTrimestres().get(0);
		Trimestre segundo = boletin.getTrimestres().get(1);
		Trimestre tercero = boletin.getTrimestres().get(2);
		Trimestre fin = boletin.getTrimestres().get(3);
		Trimestre diciembre = boletin.getTrimestres().get(4);
		Trimestre marzo = boletin.getTrimestres().get(5);
		Boolean boletinSinMaterias = false;		
		if((primero.getMaterias().size() != 0) && (segundo.getMaterias().size() != 0) 
			&& (tercero.getMaterias().size() != 0) && (fin.getMaterias().size() != 0) && (diciembre.getMaterias().size() != 0)
			&& (marzo.getMaterias().size() != 0)){
			boletinSinMaterias = true;
		}
		return boletinSinMaterias;
	}
	
	private void getMateriaParaBoletinIS1(MateriaDTO materiaDTO, NotaMateria notaPri, NotaMateria notaSeg, 
			NotaMateria notaTerc, NotaMateria notaFin, NotaMateria notaDic, NotaMateria notaMarzo, 
			Materia materiaBoletin){		
			//System.out.println(materiaBoletin.getId());
		materiaDTO.setNombre(notaPri.getMateria().getNombre());
		materiaDTO.setNotaPrimero(notaPri.getCalificacion().getValor());
		materiaDTO.setNotaSegundo(notaSeg.getCalificacion().getValor());		
		materiaDTO.setNotaTercero(notaTerc.getCalificacion().getValor());
		materiaDTO.setNotaFin(notaFin.getCalificacion().getValor());
		materiaDTO.setNotaDic(notaDic.getCalificacion().getValor());
		materiaDTO.setNotaMarzo(notaMarzo.getCalificacion().getValor());				
	}
}
