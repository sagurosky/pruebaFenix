package org.cimientos.intranet.dao;

/**
 * AlumnoDao
 * @author Julian Rios
 */

import java.util.Date;
import java.util.List;

import org.cimientos.intranet.dao.base.Dao;
import org.cimientos.intranet.dto.EaDto;
import org.cimientos.intranet.dto.ExportarAlumnosDTO;
import org.cimientos.intranet.modelo.Beca;
import org.cimientos.intranet.modelo.CicloPrograma;
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
import org.displaytag.properties.SortOrderEnum;

import com.cimientos.intranet.enumerativos.AnioEscolar;
import com.cimientos.intranet.enumerativos.EmitioCarta;
import com.cimientos.intranet.enumerativos.SituacionEscolarAlumno;

public interface AlumnoDao extends Dao<PerfilAlumno>{
	

	/**
	 * Obtiene la lista de alumnos que aun no tienen beca asignada.
	 *
	 * @param estadoAlumnos the estado alumnos
	 * @return la lista de alumnos sin beca
	 * @since 31-ene-2011
	 * @author cfigueroa  
	 */
	public List<PerfilAlumno> obtenerAlumnosSinBecaAsignada(List<EstadoAlumno> estadoAlumnos);
	
	public List<PerfilAlumno> obtenerCesadosPorEa(PerfilEA ea);

	public List<PerfilAlumno> obtenerCesadosPorRr(PerfilRR rr);
	
	public List<PerfilAlumno> obtenerSoloBecadosPorEa(PerfilEA ea);
	
	public List<PerfilAlumno> obtenerSoloBecadosPorRr(PerfilRR rr, CicloPrograma ciclo);
	
	/**
	 * Este metodo obtiene los estados de los alumnos, por cada 
	 * estado de la lista  se agrega el condicional OR por cada estado
	 * EJ: (estado = estado1  OR estado = estado2)
	 * @param estadosAlumnos lista de estados de los alumnos
	 * @return the list
	 * @since 16-nov-2010
	 * @author cfigueroa 
	 */
	public List<PerfilAlumno> obtenerAlumnosPorEstado(List<EstadoAlumno> estadosAlumnos);
	//

	/**
	 * Obtiene la lista de alumnos que son becados (estado = altaBecado) y que aun no tienen EA asignado
	 *  
	 * @return la lista de alumnos sin EA
	 */
	public List<PerfilAlumno> obtenerBecadosSinAsignacionEA();

	/**
	 * Obtiene la lista de alumnos que estan en lista de espera(estado = listaEspera) 
	 * 
	 * @return la lista de alumnos  en lista de espera
	 */
	public List<PerfilAlumno> obtenerBecadosListaEspera();


	/**
	 * Obtiene la lista de alumnos listos para crear entrevistas de acompa�amiento. Los alumnos disponibles son
	 * aquello que tienen EA asignado.
	 * @return lista de alumnos que cumplen condicion
	 */
	public List<PerfilAlumno> obtenerParaEntrevistaAcom(CicloPrograma ciclo);



	/**
	 * Obtiene la lista de alumnos asignados a un EA en particular.
	 * 
	 * @param idPerfilEA
	 * @return la lista de alumnos
	 * 
	 */
	public List<PerfilAlumno> obtenerBecadosSinAsignacionEA(Long idPerfilEA);



	/**
	 * Obtiene la lista de alumnos cuya escuela pertenece a la zona pasada por
	 * parametro. Incluye paginado
	 * 
	 * @param zona
	 * @return la lista de alumnos
	 */
	public List<PerfilAlumno> obtenerAlumnosPorZona(ZonaCimientos zona, List<EstadoAlumno> estados);
	
	/**
	 * Obtiene la cantidad total de registros al ejecutar la consulta de alumnos por zona.
	 * 
	 * @param zona
	 * @return
	 */
	public int contarResultadosAlummnosZonaBeca(ZonaCimientos zona, List<EstadoAlumno> estados);

	/**
	 * @param padrino
	 * @param zona
	 * @param estados
	 * @param fechaInicio
	 * @param fechaFin
	 * @return
	 */
	public List<PerfilAlumno> obtenerAlumnosMismaBecaCicloAnterior(
			Beca becaActual,
			List<EstadoAlumno> estados);

	public EaDto obtenerDatosAlumnosPorEA(PerfilEA perfilEA, CicloPrograma cicloPrograma);
	
	public PerfilAlumno obtenerPorDni(Integer dni);

	/**
	 * @param ea
	 * @return
	 */
	public List<PerfilAlumno> obtenerAlumnosSegunZonaEA(PerfilEA ea);

	/**
	 * @return
	 */
	public List<PerfilAlumno> obtenerAlumnosConBecaAsignada();

	/**
	 * @param zona
	 * @param estados
	 * @return
	 */
	public List<PerfilAlumno> obtenerAlumnosPorZonaParaReasignacion(
			ZonaCimientos zona, List<EstadoAlumno> estados);
	
	/**
	 * @param ea
	 * @return
	 */
	public List<PerfilAlumno> obtenerAlumnosParaReasignarSegunZonaEA(PerfilEA ea);

	public List<PerfilAlumno> obtenerBecadosDisponibles(PerfilEA perfilEA,CicloPrograma ciclo);
	
	/**
	 * @param becados
	 * @return
	 */
	public List<PerfilAlumno> obtenerBecadosParaPanelEA(List<Long> becados);

	/**
	 * @param idEA
	 * @param cicloActual
	 * @return
	 */
	public List<PerfilAlumno> obtenerBecadosParaPanelEA(Long idEA,
			CicloPrograma cicloActual);

	/**
	 * @param id
	 * @return
	 */
	public Boolean verSiAlumnoTieneBoletin(Long id);

	/**
	 * @param ea
	 * @return
	 */
	public List<PerfilAlumno> obtenerBecadosCicloActualPorEA(PerfilEA ea);
	
	/**
	 * Obtener alumnos ts.
	 *
	 * @param idPerfilTS the id perfil ts
	 * @return the list
	 * @since 30-mar-2011
	 * @author cfigueroa
	 */
	public List<PerfilAlumno> obtenerAlumnosTS(PerfilTS perfilTS);
	
	public List<PerfilAlumno> obtenerBecadosParaActivarPanelEA(List<Long> becados);

	
	/**
	 * Obtener alumno ts.
	 *
	 * @param perfilTS the perfil ts
	 * @param entrevistaSeleccion Si es true es de seleccion , sino es de acompa�amiento
	 * @return the list
	 * @since 08-abr-2011
	 * @author cfigueroa
	 */
	public List<PerfilAlumno> obtenerAlumnoParaTS(PerfilTS perfilTS,Boolean entrevistaSeleccion);

	/**
	 * Reporte alumnos.
	 *
	 * @return the list
	 * @since 18-abr-2011
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
            Boolean adicional, boolean becadosActivos, String eae, Escuela escuela);
	
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
			ZonaCimientos zona, Convocatoria convocatoria, PerfilPadrino padrino, PerfilEA ea, String nombreAlumno, AnioEscolar anio, Boolean adicional, boolean becadosActivos, String eae, Escuela escuela);

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
	public List<PerfilAlumno> obtenerAlumnosParaEmisionCartas(
			List<EstadoAlumno> estadosAlumnos, int firstResult, int maxResults,
			SortOrderEnum sortDirection, String sortCriterion, 
			String nombreAlumno, EstadoAlumno estadoAlumno, 
			ZonaCimientos zona, Escuela escuela, 
			EmitioCarta emitioCarta, Long idCiclo);

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
	public Integer cantidadAlumnosEmisionCartas(
			List<EstadoAlumno> estadosAlumnos, int firstResult, int maxResults,
			SortOrderEnum sortDirection, String sortCriterion, String nombreAlumno, EstadoAlumno estadoAlumno, 
			ZonaCimientos zona, Escuela escuela, 
			EmitioCarta emitioCarta, Long idCiclo);

	public List<PerfilAlumno> obtenerBecadosParaActivarPanelEASeleccion(
			List<Long> candidatosId);
	
	
	public List<PerfilAlumno> obtenerAlumnosPadrinoCimientosPorZonaCicloPeriodo(Long idZona, Long idCicloActual, Long idPeriodo);

	public int obtenerCantidadBecados(Long idRr, Long idEa, EstadoAlumno estadoAlumno, ZonaCimientos zona, PerfilPadrino padrino, String nombreAlumno, AnioEscolar anio, Boolean adicional, Long idCiclo);

	public List<PerfilAlumno> obtenerBecadosExportar(int firstResult,	int maxResults, SortOrderEnum sortDirection, String sortCriterion,
			Long idRr, Long idEa, EstadoAlumno estadoAlumno, ZonaCimientos zona, PerfilPadrino padrino, String nombreAlumno, AnioEscolar anio, Boolean adicional, Long idCiclo);

	
	/**
	 * Este metodo cambia el a�o escolar de los alumnos. Incrementa el a�o escolar.
	 * Ver documento "Documento de Relevamiento - Noviembre - CERRADO" para detalle de que alumnos son los que
	 * cambian de a�o
	 */
	public void avanzarAnioEscolar();

	public int obtenerCantidadAlumnosInactivos(ZonaCimientos zona,PerfilPadrino padrino, PerfilEA ea, Integer dni,
			String nombreAlumno, EstadoAlumno estadoAlumno, Escuela escuelaAlumno, AnioEscolar anio, SituacionEscolarAlumno situacionEscolar,
			List<Long> listPeriodosIdBaja, List<Long> listPeriodosIdEgreso, Integer cantPrevias, Integer idTipo, Boolean sexo, 
			Provincia prov, Date dFechaDesde, Date dFechaHasta, String eae);

	public List<PerfilAlumno> obtenerAlumnosInactivos(int i,int totalRows, SortOrderEnum sortDirection, String sortCriterion,
			ZonaCimientos zona, PerfilPadrino padrino, PerfilEA ea, Integer dni, String nombreAlumno, EstadoAlumno estadoAlumno,
			Escuela escuelaAlumno, AnioEscolar anio, SituacionEscolarAlumno situacionEscolar, List<Long> listPeriodosIdBaja,
			List<Long> listPeriodosIdEgreso,Integer cantPrevias, Integer idTipo, Boolean sexo, Provincia prov, Date dFechaDesde, Date dFechaHasta, String eae);

	public int cantidadAlumnosMismaBecaCicloAnterior(Long idZona, Long idPadrino, Integer ordenCiclo, List<EstadoAlumno> estados);

	public List<PerfilAlumno> alumnosMismaBecaCicloAnterior(Beca beca);

	public List<PerfilAlumno> obtenerAlumnosMismaZonaBeca(Beca beca);

	public int cantidadAlumnosActivosMismaEscuela(Escuela escuela);
	
}