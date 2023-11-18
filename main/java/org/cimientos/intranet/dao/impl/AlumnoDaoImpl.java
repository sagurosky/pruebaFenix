package org.cimientos.intranet.dao.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.cimientos.intranet.dao.AlumnoDao;
import org.cimientos.intranet.dao.base.HQLHelper;
import org.cimientos.intranet.dao.base.SpringHibernateDao;
import org.cimientos.intranet.dto.EaDto;
import org.cimientos.intranet.dto.ExportarAlumnosDTO;
import org.cimientos.intranet.modelo.Beca;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.EstadoCiclo;
import org.cimientos.intranet.modelo.candidato.convocatoria.Convocatoria;
import org.cimientos.intranet.modelo.escuela.Escuela;
import org.cimientos.intranet.modelo.perfil.AlumnoPanelEA;
import org.cimientos.intranet.modelo.perfil.EstadoAlumno;
import org.cimientos.intranet.modelo.perfil.PerfilAlumno;
import org.cimientos.intranet.modelo.perfilEA.PerfilEA;
import org.cimientos.intranet.modelo.perfilPadrino.PerfilPadrino;
import org.cimientos.intranet.modelo.perfilRR.PerfilRR;
import org.cimientos.intranet.modelo.perfilTS.PerfilTS;
import org.cimientos.intranet.modelo.ubicacion.Provincia;
import org.cimientos.intranet.modelo.ubicacion.ZonaCimientos;
import org.cimientos.intranet.servicio.AlumnoPanelEASrv;
import org.cimientos.intranet.utils.ConstantesPaneles;
import org.displaytag.properties.SortOrderEnum;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.type.LongType;
import org.hibernate.type.Type;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cimientos.intranet.enumerativos.AnioEscolar;
import com.cimientos.intranet.enumerativos.EmitioCarta;
import com.cimientos.intranet.enumerativos.SituacionEscolarAlumno;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionRenovacionFinal;
import com.googlecode.ehcache.annotations.Cacheable;


/**
 * AlumnoDaoImpl
 * @author Julian Rios
 *
 */

@Repository
public class AlumnoDaoImpl extends SpringHibernateDao<PerfilAlumno> implements AlumnoDao{
	
	
	/**
	 * @param sessionFactory
	 */
	@Autowired
	public AlumnoDaoImpl(SessionFactory sessionFactory) 
	{
		super(sessionFactory);
	}

	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	protected Class<PerfilAlumno> getObjetoManejado() 
	{
		return PerfilAlumno.class;
	}

	
	@Autowired
	private AlumnoPanelEASrv alumnoPanelEaSrv;

	private static final String  SIN_ZONA = "SIN ZONA";
	
	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerAlumnosPorEstado(java.lang.String)
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerAlumnosPorEstado(List<EstadoAlumno> estadosAlumnos) {
		  DetachedCriteria criteria = DetachedCriteria.forClass(PerfilAlumno.class);
		  Disjunction disjunction = Restrictions.disjunction(); 
		  for (EstadoAlumno estado : estadosAlumnos) {
			  disjunction.add(Restrictions.eq("estadoAlumno", estado)); 
		}
		criteria.add(disjunction);
		return getHibernateTemplate().findByCriteria(criteria);
	}
	

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerAlumnosSinBecaAsignada()
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerAlumnosSinBecaAsignada(List<EstadoAlumno> estadoAlumnos) {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		//no debe tener beca asignada
		criteria.add(Restrictions.isNull("beca"));
		//el alumno debe estar en estado aprobado o aprobado_ts
		criteria.add(Restrictions.in("estadoAlumno", estadoAlumnos));
		return criteria.list();
	}
	
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerSoloBecadosPorEa(PerfilEA ea) {
		List<EstadoAlumno> estados = new ArrayList<EstadoAlumno>();
		estados.add(EstadoAlumno.ALTA_BECADO);
		estados.add(EstadoAlumno.RENOVADO);
		estados.add(EstadoAlumno.INCORPORADO);
		estados.add(EstadoAlumno.NO_RENOVADO);
		estados.add(EstadoAlumno.NO_INCORPORADO);
		estados.add(EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION);
		estados.add(EstadoAlumno.REASIGNADO);
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		criteria.add(Restrictions.in("estadoAlumno", estados));
		criteria.createAlias("ea", "ea");
		criteria.add(Restrictions.eq("ea", ea));
		criteria.add(Restrictions.isNotNull("ea.becados"));
		if(!criteria.list().isEmpty() )
		{
			return criteria.list();
		}
		else
		{
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerSoloBecadosPorRr(PerfilRR rr, CicloPrograma ciclo) 
	{
		List<EstadoAlumno> estados = new ArrayList<EstadoAlumno>();
		estados.add(EstadoAlumno.NO_RENOVADO);
		estados.add(EstadoAlumno.NO_INCORPORADO);
		estados.add(EstadoAlumno.CESADO);
		estados.add(EstadoAlumno.EGRESADO);
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		criteria.add(Restrictions.not(Restrictions.in("estadoAlumno", estados)));
		criteria.createAlias("ea", "ea");
		criteria.add(Restrictions.eq("ea.rr", rr));
		criteria.createAlias("beca", "beca");
		criteria.add(Restrictions.isNotNull("beca"));
		criteria.add(Restrictions.eq("beca.ciclo", ciclo));
		criteria.createAlias("datosPersonales", "datosPersonales");
		criteria.addOrder(Order.asc("datosPersonales.apellido")).addOrder(Order.asc("datosPersonales.nombre"));
		if(!criteria.list().isEmpty() )
		{
			return criteria.list();
		}
		else
		{
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerCesadosPorEa(PerfilEA ea) 
	{
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		List<EstadoAlumno> estadosEspera = new ArrayList<EstadoAlumno>();
		estadosEspera.add(EstadoAlumno.CESADO);
		estadosEspera.add(EstadoAlumno.NO_INCORPORADO);
		estadosEspera.add(EstadoAlumno.NO_RENOVADO);
		criteria.add(Restrictions.in("estadoAlumno", estadosEspera));
		criteria.createAlias("ea", "ea");
		criteria.add(Restrictions.eq("ea", ea));
		criteria.add(Restrictions.isNotNull("ea.becados"));
		if(!criteria.list().isEmpty() )
		{
			return criteria.list();
		}
		else
		{
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerCesadosPorRr(PerfilRR rr) 
	{
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		criteria.createAlias("ea", "ea");
		criteria.add(Restrictions.eq("ea.rr", rr));
		criteria.add(Restrictions.isNotNull("ea.rr"));
		List<EstadoAlumno> estadosEspera = new ArrayList<EstadoAlumno>();
		estadosEspera.add(EstadoAlumno.CESADO);
		estadosEspera.add(EstadoAlumno.NO_INCORPORADO);
		estadosEspera.add(EstadoAlumno.NO_RENOVADO);
		criteria.add(Restrictions.in("estadoAlumno", estadosEspera));
		List<PerfilAlumno> result = criteria.list();
		if(!result.isEmpty() )
		{
			return result;
		}
		else
		{
			return null;
		}
	}
	
	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerBecadosSinAsignacionEA()
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerBecadosSinAsignacionEA() {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		//no debe tener rr asignada
		criteria.add(Restrictions.isNull("ea"));
		//el alumno debe estar en estado altaBecado
		criteria.add(Restrictions.eq("estadoAlumno", EstadoAlumno.ALTA_BECADO));
		criteria.add(Restrictions.isNotNull("beca"));
		return criteria.list();
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerBecadosListaEspera()
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerBecadosListaEspera() {
		List<EstadoAlumno> estadosEspera = new ArrayList<EstadoAlumno>();
		estadosEspera.add(EstadoAlumno.LISTA_ESPERA);
		estadosEspera.add(EstadoAlumno.LISTA_ESPERA_MATERIA_TS);
		estadosEspera.add(EstadoAlumno.LISTA_ESPERA_MATERIAS);
		estadosEspera.add(EstadoAlumno.LISTA_ESPERA_TS);
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		//el alumno debe estar en estado lista de espera
		criteria.add(Restrictions.in("estadoAlumno", estadosEspera));
		return criteria.list();
	}

	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerParaEntrevistaAcom(CicloPrograma ciclo) {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		//debe tener rr asignada
		criteria.createAlias("beca", "beca");
		criteria.add(Restrictions.isNotNull("ea"));
		criteria.add(Restrictions.ne("estadoAlumno", EstadoAlumno.CESADO));
		criteria.add(Restrictions.isNotNull("beca"));
		criteria.add(Restrictions.eq("beca.ciclo", ciclo));
		return criteria.list();
	}

	
	
	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerBecadosSinAsignacionEA(java.lang.Long)
	 */
	@Override
	public List<PerfilAlumno> obtenerBecadosSinAsignacionEA(Long idPerfilEA) {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		//debe tener el ea asignado
		criteria.add(Restrictions.eq("ea.idPerfilEA", idPerfilEA));
		return criteria.list();
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerAlumnosPorZona(org.cimientos.intranet.modelo.ubicacion.ZonaCimientos)
	 */
	@Override
	public List<PerfilAlumno> obtenerAlumnosPorZona(ZonaCimientos zona, List<EstadoAlumno> estados) {
		
		List<PerfilAlumno> alumnos = new ArrayList<PerfilAlumno>();
		String query = " select alumno.id, alumno.datosPersonales.apellido, " +
				" alumno.datosPersonales.nombre, alumno.escuela.localidad.zona.nombre, alumno.escuela.nombre, alumno.anioEscolar, " +
				" alumno.estadoRenovacion " +
				" from PerfilAlumno alumno " +
				" where alumno.estadoAlumno in (:estados) ";

		if(zona != null && !zona.getNombre().equals(SIN_ZONA)){
			query += " and alumno.escuela.localidad.zona = :zonaBeca ";
		}
		
		Query hqlquery = getSession().createQuery(query).setParameterList("estados", estados);
		
		if(zona != null  && !zona.getNombre().equals(SIN_ZONA)){
			hqlquery.setParameter("zonaBeca", zona );
		}		
		alumnos = HQLHelper.find(hqlquery, getObjetoManejado());
		
		return alumnos;
	}
	
	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#contarResultadosAlummnosZonaBeca(org.cimientos.intranet.modelo.ubicacion.ZonaCimientos)
	 */
	@Override
	public int contarResultadosAlummnosZonaBeca(ZonaCimientos zona, List<EstadoAlumno> estados){
		Criteria criteria = getCriteriaAlummnosZonaBeca(zona, estados);
		criteria.setProjection(Projections.rowCount());
		return ((Integer)criteria.list().get(0)).intValue();
	}
	
	/**
	 * @param zona
	 * @return
	 */
	private Criteria getCriteriaAlummnosZonaBeca(ZonaCimientos zona, List<EstadoAlumno> estados){
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		//el alumno debe estar en estado aprobado o aprobado_ts
		if(estados != null && !estados.isEmpty()){
			criteria.add(Restrictions.in("estadoAlumno", estados));
		}

		if(zona != null && !zona.getNombre().equals(SIN_ZONA)){
			//su escuela debe ser de la zona de la beca
			criteria.createAlias("escuela", "escuela");
			criteria.createAlias("escuela.localidad", "localidad");
			criteria.add(Restrictions.eq("localidad.zona.id", zona.getId()));
		}
		return criteria;

	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerAlumnosMismaBecaCicloAnterior(org.cimientos.intranet.modelo.perfilPadrino.PerfilPadrino, org.cimientos.intranet.modelo.ubicacion.ZonaCimientos, java.util.List, java.util.Date, java.util.Date)
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerAlumnosMismaBecaCicloAnterior(
			Beca becaActual,
			List<EstadoAlumno> estados) {
		
		List<PerfilAlumno> alumnos = new ArrayList<PerfilAlumno>();
		String query = " select alumno.id, alumno.datosPersonales.apellido, " +
				" alumno.datosPersonales.nombre, alumno.escuela.localidad.zona.nombre, alumno.estadoRenovacion " +
				" from PerfilAlumno alumno " +
				" where alumno.estadoAlumno in (:estados) ";

		if(becaActual != null){
			query += " and beca.padrino = :padrino and beca.zona = :zona and beca.ciclo.orden = :orden";
		}

		Query hqlquery = getSession().createQuery(query).setParameterList("estados", estados);
		
		if(becaActual != null){
			hqlquery.setParameter("zona", becaActual.getZona() )
			.setParameter("padrino", becaActual.getPadrino())
			.setParameter("orden", becaActual.getCiclo().getOrden() - 1);
		}		
		alumnos = HQLHelper.find(hqlquery, getObjetoManejado());
		
		return alumnos;
	}

	@Override
	public EaDto obtenerDatosAlumnosPorEA(PerfilEA perfilEA, CicloPrograma ciclo) {
		EaDto ea = new EaDto();
		ea.setId(perfilEA.getIdPerfilEA());
		for (ZonaCimientos zona : perfilEA.getZona()) {
			ea.agregarZona(zona.getNombre());
		}
		ea.setNombreApellido(perfilEA.getDatosPersonales().getApellido() + "," + perfilEA.getDatosPersonales().getNombre());		
		ea.setNombreApellidoRR(perfilEA.getRr().getDatosPersonales().getNombre() + " " + perfilEA.getRr().getDatosPersonales().getApellido());
		List<AlumnoPanelEA> alumnos = alumnoPanelEaSrv.obtenerAlumnosPorEa(perfilEA.getIdPerfilEA());
		String colorEntrevistas = ConstantesPaneles.GREEN;
		String colorInformes = ConstantesPaneles.GREEN;
		String colorCuentaRA = ConstantesPaneles.GREEN;
		String colorPagos = ConstantesPaneles.GREEN;
		String colorInformeIs1 = obtenerColorSemaforoIs1(alumnos);
		for (AlumnoPanelEA alumnoDTO : alumnos) {
			ea.setEntrevistas(ea.getEntrevistas() + alumnoDTO.getEntrevistas());
			ea.setEntrevistasRealizadas(ea.getEntrevistasRealizadas() + alumnoDTO.getEntrevistasRealizadas());
			ea.setPagos(ea.getPagos() + alumnoDTO.getPagos());
			ea.setPagosRealizados(ea.getPagosRealizados() + alumnoDTO.getPagosRealizados());
			setearIndicadoresInformes(ea,alumnoDTO);
			colorEntrevistas = obtenerColorEntrevistaPorEA(colorEntrevistas, alumnoDTO);
			colorCuentaRA = obtenerColorCuentaRA(colorCuentaRA,alumnoDTO);
			colorPagos = obtenerColorPagosPorEa(colorPagos,alumnoDTO);			
		}
		
		setearColoresEA(ea, colorEntrevistas, colorInformes, colorInformeIs1, colorCuentaRA, colorPagos);
		
		return ea;
	}

	
	private String obtenerColorPagosPorEa(String color, AlumnoPanelEA alumnoDTO) {
		if(!color.equals(ConstantesPaneles.RED))
			if(!color.equals(ConstantesPaneles.YELLOW))
				return alumnoDTO.getColorPagos();
			else
				return color;		
		else
			return color;
	}

	private String obtenerColorCuentaRA(String colorCuentaRA,AlumnoPanelEA alumnoDTO) {
		if(!colorCuentaRA.equals(ConstantesPaneles.RED)){			
			if(alumnoDTO.getCuentaRA() == null)
				colorCuentaRA = ConstantesPaneles.RED;
			return colorCuentaRA;		
		}
		else
			return colorCuentaRA;
	}

	
	private String obtenerColorSemaforoIs1(List<AlumnoPanelEA> alumnos)
	{
		Boolean isRojo = false;
		Boolean isVerde = false;
		Integer cantidad = 0;
		for (AlumnoPanelEA alumnoPanelEA : alumnos) 
		{
			
			if(alumnoPanelEA.getColorIS1().equalsIgnoreCase(ConstantesPaneles.RED))
			{	
				isRojo =  true;
				break;
			}
			else
			{
				if(alumnoPanelEA.getColorIS1().equalsIgnoreCase(ConstantesPaneles.GREEN))
				{
					isVerde = true;
				}
				if(alumnoPanelEA.getColorIS1().equalsIgnoreCase(ConstantesPaneles.GRAY))
				{	
					cantidad = cantidad + 1;
				}
			}
		}
		if(cantidad.equals(alumnos.size() - 1) || cantidad.equals(alumnos.size()))
			return ConstantesPaneles.GRAY;
		if(isRojo)
			return ConstantesPaneles.RED;
		if(isVerde)
			return ConstantesPaneles.GREEN;
		if(alumnos.isEmpty())
			return ConstantesPaneles.GREEN;
		else
			return null;
	}
	
	
	private void setearIndicadoresInformes(EaDto ea, AlumnoPanelEA a) {
		//TODO no alcanza con el color de semaforo del alumno, ademas hay que controlar si tiene entrevistas
		// para saber si ya se creo el is1 en caso de una renovacion. Hay que tener cuidado con los colores
		// y la epoca en cual a un chico se le activa el panelEA, ya que depende de eso el color del semaforo
		if(a.getColorIS1().equalsIgnoreCase(ConstantesPaneles.GREEN) || a.getColorIS1().equalsIgnoreCase(ConstantesPaneles.RED))
			ea.setInformesIS1(ea.getInformesIS1() + 1);
		else
			ea.setInformesIS1(ea.getInformesIS1());
		
		ea.setInformesRealizadosIS1(ea.getInformesRealizadosIS1() + ((a.getColorIS1().equals(ConstantesPaneles.GREEN) || a.getColorIS1().equals(ConstantesPaneles.YELLOW))?1:0));		
		
		ea.setInformesIS2(ea.getInformesIS2() + 1);
		ea.setInformesRealizadosIS2(ea.getInformesRealizadosIS2() + ((a.getColorIS2().equals(ConstantesPaneles.GREEN) || a.getColorIS2().equals(ConstantesPaneles.YELLOW))?1:0));
		
		ea.setInformesIS3(ea.getInformesIS3() + 1);
		ea.setInformesRealizadosIS3(ea.getInformesRealizadosIS3() + ((a.getColorIS3().equals(ConstantesPaneles.GREEN) || a.getColorIS3().equals(ConstantesPaneles.YELLOW))?1:0));
		
		ea.setCuentasRA(ea.getCuentasRA() + 1);
		ea.setCuentasRARealizadas(ea.getCuentasRARealizadas() + (a.getColorRA().equals(ConstantesPaneles.GREEN)?1:0));
	}

	private void setearColoresEA(EaDto ea, String colorEntrevistas, String colorInformes, String colorInformeIs1, String colorCuentaRA, String colorPagos) {
		if(ea.getEntrevistasRealizadas() < ea.getEntrevistas())
			ea.setColorEntrevistas(ConstantesPaneles.RED);
		else
			ea.setColorEntrevistas(colorEntrevistas);
				
		ea.setColorIS1(colorInformeIs1);
		
		if(ea.getInformesRealizadosIS2() < ea.getInformesIS2())
			ea.setColorIS2(ConstantesPaneles.RED);
		else
			ea.setColorIS2(colorInformes);
		
		if(ea.getInformesRealizadosIS3() < ea.getInformesIS3())
			ea.setColorIS3(ConstantesPaneles.RED);
		else
			ea.setColorIS3(colorInformes);
		
		if(ea.getCuentasRARealizadas() < ea.getCuentasRA())
			ea.setColorRA(ConstantesPaneles.RED);
		else
			ea.setColorRA(colorCuentaRA);
		
		if(ea.getPagosRealizados() < ea.getPagos())
			ea.setColorPagos(ConstantesPaneles.RED);
		else
			ea.setColorPagos(colorPagos);
	}


	private String obtenerColorEntrevistaPorEA(String color, AlumnoPanelEA alumnoDTO) {
		if(!color.equals(ConstantesPaneles.RED))
			if(!color.equals(ConstantesPaneles.YELLOW))
				return alumnoDTO.getColorEntrevistas();
			else
				return color;
		else
			return color;
	}

	@Override
	public PerfilAlumno obtenerPorDni(Integer dni)  {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		criteria.createAlias("datosPersonales", "datosPersonales");
		criteria.add(Restrictions.eq("datosPersonales.dni", dni));
		List<PerfilAlumno> result = criteria.list();
		if(result.isEmpty()){
			return null;
		}else{
			return result.get(0);		
		}
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerAlumnosSegunZonaEA(org.cimientos.intranet.modelo.perfilEA.PerfilEA)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PerfilAlumno> obtenerAlumnosSegunZonaEA(PerfilEA ea) {
		//si viene de renovacion desasignado y si aun no se le ha asignado nunca un ea
		EstadoAlumno[] estados = new EstadoAlumno[]{EstadoAlumno.ALTA_BECADO,
				EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION};
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		//no debe tener ea asignada
		criteria.add(Restrictions.isNull("ea"));
		//el alumno debe estar en estado altaBecado
		criteria.add(Restrictions.in("estadoAlumno", estados));
		criteria.add(Restrictions.isNotNull("beca"));
		if(ea != null){
			List<ZonaCimientos> zonasEa = ea.getZona();
			criteria.createAlias("escuela.localidad", "localidad");
			criteria.add(Restrictions.in("localidad.zona", zonasEa));
		}	
		return criteria.list();
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerAlumnosConBecaAsignada()
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerAlumnosConBecaAsignada() {
		DetachedCriteria criteria = DetachedCriteria.forClass(PerfilAlumno.class);
		Boolean activo = true;
		criteria.add(org.hibernate.criterion.Property.forName("activo").eq(activo));
		criteria.createAlias("beca", "beca");
		criteria.add(Restrictions.isNotNull("beca"));
		criteria.createAlias("beca.ciclo", "ciclo");
		criteria.add(Restrictions.le("ciclo.estado", EstadoCiclo.ACTUAL) );
		return getHibernateTemplate().findByCriteria(criteria);
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerAlumnosPorZonaParaReasignacion(org.cimientos.intranet.modelo.ubicacion.ZonaCimientos, java.util.List)
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerAlumnosPorZonaParaReasignacion(
			ZonaCimientos zona, List<EstadoAlumno> estados) {
		Criteria criteria = this.getCriteriaAlummnosZonaBeca(zona, estados);
		//Se agrega este filtro por estados, pero no deberia ser necesario
		EstadoAlumno[] estadosExcluyentes = new EstadoAlumno[]{EstadoAlumno.CESADO, 
				EstadoAlumno.NO_INCORPORADO, EstadoAlumno.NO_RENOVADO, EstadoAlumno.EGRESADO};
		criteria.add( Restrictions.not(Restrictions.in("estadoAlumno", estadosExcluyentes)));
		criteria.createAlias("beca", "beca");
		criteria.add(Restrictions.isNotNull("beca"));
		criteria.createAlias("beca.ciclo", "ciclo");
		criteria.add(Restrictions.le("ciclo.estado", EstadoCiclo.ACTUAL) );
		return criteria.list();
	}
	
	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerAlumnosSegunZonaEA(org.cimientos.intranet.modelo.perfilEA.PerfilEA)
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerAlumnosParaReasignarSegunZonaEA(PerfilEA ea) {

		Criteria criteria = getSession().createCriteria(getObjetoManejado());

		criteria.add(Restrictions.isNotNull("ea"));
		criteria.add(Restrictions.isNotNull("beca"));
		if(ea != null){
			List<ZonaCimientos> zonasEa = ea.getZona();
			criteria.createAlias("escuela.localidad", "localidad");
			criteria.add(Restrictions.in("localidad.zona", zonasEa));
		}	
		return criteria.list();
	}

	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerBecadosDisponibles(PerfilEA perfilEA,CicloPrograma ciclo) {
		List<PerfilAlumno> alumnos = new ArrayList<PerfilAlumno>();
		
		EstadoAlumno[] estadosExcluyentes = new EstadoAlumno[]{EstadoAlumno.CESADO};
		
		String query = " select alumno.id, alumno.datosPersonales.apellido, " +
				" alumno.datosPersonales.nombre, alumno.escuela.localidad.zona.nombre, " +
				" alumno.estadoAlumno, alumno.beca.zona.nombre, alumno.escuela.nombre, alumno.anioEscolar, " +
				" alumno.datosPersonales.dni, alumno.responsable1.nombre, " +
				" alumno.responsable1.apellido, alumno.responsable1.id, alumno.responsable1.motivoFallidoCuenta, alumno.responsable1.sucursalBanco.banco.nombre, " +
				" alumno.beca, alumno.fechaAltaBeca, alumno.ea.datosPersonales.apellido, alumno.ea.datosPersonales.nombre, alumno.fechaPBE, " +
				" alumno.estadoRenovacion, alumno.responsable1.nroCuenta, alumno.responsable1.estadoCuenta " +
				" from PerfilAlumno alumno " +
				" where alumno.estadoAlumno not in (:estados) " +
				" and alumno.beca is not null and alumno.beca.ciclo = :ciclo " +
				" and alumno.ea = :perfilEa ";

		Query hqlquery = getSession().createQuery(query).setParameterList("estados", estadosExcluyentes)
		.setParameter("ciclo", ciclo).setParameter("perfilEa", perfilEA);
				
		alumnos = HQLHelper.find(hqlquery, getObjetoManejado());
		
		query = " select alumno.id, alumno.datosPersonales.apellido, " +
				" alumno.datosPersonales.nombre, alumno.escuela.localidad.zona.nombre, " +
				" alumno.estadoAlumno, alumno.beca.zona.nombre, alumno.escuela.nombre, alumno.anioEscolar, " +
				" alumno.datosPersonales.dni, alumno.responsable1.nombre, " +
				" alumno.responsable1.apellido, alumno.responsable1.id, alumno.responsable1.motivoFallidoCuenta, " + //alumno.responsable1.sucursalBanco.banco.nombre, " +
				" alumno.beca, alumno.fechaAltaBeca, alumno.ea.datosPersonales.apellido, alumno.ea.datosPersonales.nombre, alumno.fechaPBE, " +
				" alumno.estadoRenovacion " +
				" from PerfilAlumno alumno " +
				" where alumno.estadoAlumno not in (:estados) " +
				" and alumno.beca is not null and alumno.beca.ciclo = :ciclo " +
				" and alumno.ea = :perfilEa ";
		
		hqlquery = getSession().createQuery(query).setParameterList("estados", estadosExcluyentes)
		.setParameter("ciclo", ciclo).setParameter("perfilEa", perfilEA);
		
		List<PerfilAlumno> alumnosSinsucursal = new ArrayList<PerfilAlumno>();
		alumnosSinsucursal = HQLHelper.find(hqlquery, getObjetoManejado());
		for (PerfilAlumno pa : alumnosSinsucursal) {
			agregarAlumno(alumnos,pa);
		}
		
		return alumnos;
	}

	private void agregarAlumno(List<PerfilAlumno> alumnos, PerfilAlumno pa) {
		boolean existe = false;
		for (PerfilAlumno perfilAlumno : alumnos) {
			existe = perfilAlumno.getId().equals(pa.getId());
			if(existe)
				break;
		}
		if(!existe)
			alumnos.add(pa);
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerBecadosParaPanelEA(java.util.List)
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerBecadosParaPanelEA(List<Long> becados){
		List<PerfilAlumno> alumnos = new ArrayList<PerfilAlumno>();
		if(becados != null && !becados.isEmpty()){
			String query = " select alumno.id, alumno.datosPersonales.apellido, alumno.datosPersonales.dni, alumno.boletin, " +
					" alumno.datosPersonales.nombre, alumno.escuela.localidad.zona.nombre, alumno.fechaAltaBeca, alumno.escuela.nombre, " +
					" alumno.estadoAlumno, alumno.anioEscolar, alumno.beca.zona.nombre, alumno.responsable1.nroCuenta " +
					" from PerfilAlumno alumno " +
					" where alumno.id in (:becados) ";
			
			Query hqlquery = getSession().createQuery(query).setParameterList("becados", becados);
			
			alumnos = HQLHelper.find(hqlquery, getObjetoManejado());
		}
		return alumnos;
	}

	
	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerBecadosParaPanelEA(java.util.List)
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public List<PerfilAlumno> obtenerBecadosParaActivarPanelEA(List<Long> becados){
		List<PerfilAlumno> alumnos = new ArrayList<PerfilAlumno>();
		if(becados != null && !becados.isEmpty()){
			String query = " select alumno.id, alumno.datosPersonales.apellido, alumno.datosPersonales.dni, alumno.fechaAltaBeca, alumno.boletin, " +
					" alumno.datosPersonales.nombre, alumno.escuela.localidad.zona.nombre, alumno.escuela.nombre, " +
					" alumno.estadoAlumno, alumno.anioEscolar, alumno.beca.zona.nombre, alumno.responsable1 " +
					" from PerfilAlumno alumno " +
					" where alumno.id in (:becados) ";
			
			Query hqlquery = getSession().createQuery(query).setParameterList("becados", becados);
			
			alumnos = HQLHelper.find(hqlquery, getObjetoManejado());
		}
		return alumnos;
	}
	
	
	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerBecadosParaPanelEA(java.lang.Long, org.cimientos.intranet.modelo.CicloPrograma)
	 */
	@Override
	public List<PerfilAlumno> obtenerBecadosParaPanelEA(Long idEA,
			CicloPrograma cicloActual) {
		List<PerfilAlumno> alumnos = new ArrayList<PerfilAlumno>();
		EstadoAlumno[] estadosExcluyentes = new EstadoAlumno[]{EstadoAlumno.CESADO, EstadoAlumno.NO_INCORPORADO, EstadoAlumno.NO_RENOVADO, EstadoAlumno.EGRESADO};
			String query = " select alumno.id, alumno.datosPersonales.apellido, " +
					" alumno.datosPersonales.nombre, alumno.escuela.localidad.zona.nombre, alumno.fechaAltaBeca, " +
					" alumno.estadoAlumno " +
					" from PerfilAlumno alumno " +
					" where alumno.estadoAlumno not in (:estados) " +
					" and alumno.beca is not null and alumno.beca.ciclo = :ciclo " +
					" and alumno.ea.idPerfilEA = :perfilEa ";
			Query hqlquery = getSession().createQuery(query).setParameterList("estados", estadosExcluyentes)
			.setParameter("ciclo", cicloActual).setParameter("perfilEa", idEA);
			
			alumnos = HQLHelper.find(hqlquery, getObjetoManejado());
		return alumnos;
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerAlumnosTS(org.cimientos.intranet.modelo.perfilTS.PerfilTS)
	 */
	@Override
	public List<PerfilAlumno> obtenerAlumnosTS(PerfilTS perfilTS) {
		List<PerfilAlumno> list = new ArrayList<PerfilAlumno>();
		String sql = "select alumno.datosPersonales.nombre,alumno.datosPersonales.apellido,alumno.id,alumno.telefono1, " +
					 "alumno.telefono2,alumno.contactoTelefono1,alumno.contactoTelefono2,alumno.responsable1.dni,alumno.responsable1.nombre, " +
					 "alumno.responsable1.apellido,alumno.anioEscolar,alumno.escuela.nombre,alumno.datosPersonales.dni,alumno.motivoEnvioTS " +
					 " from PerfilAlumno alumno " +
					 " where alumno.perfilTS.idPerfilTS = :perfilTS and alumno.estadoAlumno = :estados";
		Query query = getSession().createQuery(sql);
		query.setParameter("perfilTS", perfilTS.getIdPerfilTS());
		query.setParameter("estados", EstadoAlumno.PRESELECCIONADO);
		list = HQLHelper.find(query, getObjetoManejado());
		return list;
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#verSiAlumnoTieneBoletin(java.lang.Long)
	 */
	@Override
	public Boolean verSiAlumnoTieneBoletin(Long id) {
		//String sql = "select * from perfil_alumno where id = " + id + " and boletin is not null ";
		//Query query = getSession().createSQLQuery(sql);
		//if(!query.list().isEmpty())
	//	{
			return true;
		//}
		//else
		//{
		//	return false;
		//}
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerBecadosCicloActualPorEA(org.cimientos.intranet.modelo.perfilEA.PerfilEA)
	 */
	@Override
	public List<PerfilAlumno> obtenerBecadosCicloActualPorEA(PerfilEA ea) {
		DetachedCriteria criteria = DetachedCriteria.forClass(PerfilAlumno.class);		

		criteria.createAlias("datosPersonales", "persona");
		criteria.createAlias("ea", "ea");
				
		if(ea.getIdPerfilEA() != null){
			Object [] objects = new Object[1];
			objects[0] = ea.getIdPerfilEA();			
			Type[]  objectTypes = new Type[1];
			objectTypes[0] = Hibernate.LONG;						
			String sql  = "{alias}.id in (select ape.id_perfil_alumno  from alumno_panelea ape where ape.activo = true and ape.id_perfilea = ?)";
			criteria.add(Restrictions.sqlRestriction(sql,objects,objectTypes));
			criteria.add(Restrictions.eq("ea.idPerfilEA", ea.getIdPerfilEA()));
		}		
		EstadoAlumno[] estados = new EstadoAlumno[]{EstadoAlumno.INCORPORADO, EstadoAlumno.RENOVADO, EstadoAlumno.NO_RENOVADO
						, EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION, EstadoAlumno.EGRESADO};
		criteria.add(Restrictions.in("estadoAlumno",estados));				
		criteria.addOrder(Order.asc("persona.apellido")).addOrder(Order.asc("persona.nombre"));
		return getHibernateTemplate().findByCriteria(criteria);		
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerAlumnoTS(org.cimientos.intranet.modelo.perfilTS.PerfilTS, java.lang.Boolean)
	 */
	@Override
	public List<PerfilAlumno> obtenerAlumnoParaTS(PerfilTS perfilTS,Boolean entrevistaSeleccion) {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		criteria.add(Restrictions.eq("perfilTS", perfilTS));
		if(entrevistaSeleccion){
			criteria.add(Restrictions.eq("entrevistaTSSeleccion", new Boolean(true)));
		}else{
			criteria.add(Restrictions.eq("entrevistaTSAcompaniamento", new Boolean(true)));
		}
		criteria.add(Restrictions.eq("entrevistaTS", new Boolean(false)));
		
		List<PerfilAlumno> list = criteria.list();
		return list;
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#reporteAlumnos()
	 */
	@Override
	public List<ExportarAlumnosDTO> obtenerAlumnosExportar(int firstResult, int maxResults,
            SortOrderEnum sortDirection, String sortCriterion,EstadoAlumno estadoAlumno, 
            ZonaCimientos zona, Convocatoria convocatoria, PerfilPadrino padrino, PerfilEA ea, String nombreAlumno,
            AnioEscolar anio, Boolean anioAdicional, boolean becadosActivos, String eae, Escuela escuela) {
		
		//System.out.println("eae: "+eae);
		String consulta = "";
		String sql3 = "";
		if(nombreAlumno != null){
			int cont = 0; 
			for ( String split : nombreAlumno.split(" "))
				if (cont != 0)
					consulta= consulta + "and (per.nombre like '%"+split+"%' or per.apellido like '%"+split+"%')";
				else{
					consulta= consulta + "(per.nombre like '%"+split+"%' or per.apellido like '%"+split+"%')";
					cont=1;
					}
			}
		
		if(padrino == null && nombreAlumno == null){
			
			String sql ="select alum.*, sel.*, con.* from perfil_alumno alum, entrevista_seleccion sel, convocatoria con,escuela esc, localidad loc, beca beca, zona_cimientos zona,"
						+ " (select a.id, max(es.id) id_entrevista from perfil_alumno a, entrevista_seleccion es where a.id = es.id_perfil_alumno"
						+ " group by a.id) filtro where alum.id = sel.id_perfil_alumno and sel.convocatoria = con.id_convocatoria and sel.id = filtro.id_entrevista"
						+ " and alum.beca_id = beca.id and alum.escuela = esc.id and esc.localidad = loc.id and loc.zona = zona.id";
			
			String sql2 = "select alum.*, sel.*, con.* from perfil_alumno alum, entrevista_seleccion sel, convocatoria con,escuela esc, localidad loc, zona_cimientos zona,"
						 + " (select a.id, max(es.id) id_entrevista from perfil_alumno a, entrevista_seleccion es where a.id = es.id_perfil_alumno"
						 + " group by a.id) filtro where alum.id = sel.id_perfil_alumno and sel.convocatoria = con.id_convocatoria and sel.id = filtro.id_entrevista"
						 + " and alum.escuela = esc.id and esc.localidad = loc.id and loc.zona = zona.id";
			
			if(estadoAlumno != null){
				if(estadoAlumno.equals(EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION)){
					sql+=" and alum.estado_alumno in ( " + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1); 
					sql+=" , " + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1);
					sql+=  " ) and alum.estado_renovacion= " + (EvaluacionRenovacionFinal.PENDIENTE.getId()-1);
					sql2+=" and alum.estado_alumno in ( " + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1);	
					sql2+=" , " + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1);
					sql2+= " ) and alum.estado_renovacion= " + (EvaluacionRenovacionFinal.PENDIENTE.getId()-1);
						
				}
				else{
					if(estadoAlumno.equals(EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION)){
						sql+=" and alum.estado_alumno in ( " + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1); 
						sql+=" , " + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1);
						sql+=  " ) and alum.estado_renovacion= " + (EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getId()-1);
						sql2+=" and alum.estado_alumno in ( " + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1);	
						sql2+=" , " + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1);
						sql2+= " ) and alum.estado_renovacion= " + (EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getId()-1);
					}
					else{	
						sql+=" and alum.estado_alumno= " + (estadoAlumno.getId()-1);
						sql2+=" and alum.estado_alumno= " + (estadoAlumno.getId()-1);
					}
				}
			}
			
			if(zona != null ){
				sql+=" and zona.id = " + zona.getId(); 
				sql2+=" and zona.id = " + zona.getId();
			}
			
			if(convocatoria != null){
				sql+=" and con.id_convocatoria = " +convocatoria.getIdConvocatoria(); 
				sql2+=" and con.id_convocatoria = " +convocatoria.getIdConvocatoria();
			}
			
			if(ea != null ){
				sql+=" and perfil_ea_id = " +ea.getIdPerfilEA(); 
				sql2+=" and perfil_ea_id = " +ea.getIdPerfilEA();
			}
			
			if(anio != null){
				sql += " and alum.anio_escolar= " + (anio.getId() -1);
				sql2 += " and alum.anio_escolar= " + (anio.getId() -1);
			}
			
			if(anioAdicional != null){
				sql += " and alum.anio_adicional= " + anioAdicional;
				sql2 += " and alum.anio_adicional= " + anioAdicional;
			}
			
			if(escuela != null ){
				sql+=" and esc.id = " + escuela.getId(); 
				sql2+=" and esc.id = " + escuela.getId();
			}
			
			
			
			
			
			if(eae!= null){
				if(eae.equals("todos") ){
					eae=null;
				}else{					
					sql+=" and alum.eae = '" +eae+"'"; 
					sql2+=" and alum.eae = '" +eae+"'";					
				}
			}
			
			//Solo trae los alumnos activos(Renovada,Incorporado,pendiente con asignacion, pendiente sin asignacion)
			if(becadosActivos){
				sql += " and (alum.estado_alumno in(" + (EstadoAlumno.RENOVADO.getId() - 1) + "," + (EstadoAlumno.INCORPORADO.getId() - 1) + ") " +
						"or (alum.estado_alumno in (" + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1) + "," + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1) + 
						") and alum.estado_renovacion in(" + (EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getId()-1) +
						"," + (EvaluacionRenovacionFinal.PENDIENTE.getId()-1)+ ")))";
				
				sql2 += " and (alum.estado_alumno in(" + (EstadoAlumno.RENOVADO.getId() - 1) + "," + (EstadoAlumno.INCORPORADO.getId() - 1) + ") " +
						"or (alum.estado_alumno in (" + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1) + "," + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1) + 
						") and alum.estado_renovacion in(" + (EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getId()-1) +
						"," + (EvaluacionRenovacionFinal.PENDIENTE.getId()-1)+ ")))";
			}
			
			sql3 =  sql + " UNION " + sql2;
			
		}else{			
			
			
			
			if(padrino != null){				
				sql3 ="select alum.*, sel.*, con.* from perfil_alumno alum, entrevista_seleccion sel, convocatoria con,escuela esc, localidad loc, beca beca, zona_cimientos zona,"
					+ " (select a.id, max(es.id) id_entrevista from perfil_alumno a, entrevista_seleccion es where a.id = es.id_perfil_alumno"
					+ " group by a.id) filtro where alum.id = sel.id_perfil_alumno and sel.convocatoria = con.id_convocatoria and sel.id = filtro.id_entrevista"
					+ " and alum.beca_id = beca.id and alum.escuela = esc.id and esc.localidad = loc.id and loc.zona = zona.id and (beca.id=alum.beca_id and beca.padrino = "+padrino.getId()+ ")";
			}
			
			if(nombreAlumno != null && padrino != null){
				if(zona != null){
					sql3 ="select alum.*, sel.*, con.* from perfil_alumno alum, entrevista_seleccion sel, convocatoria con, persona per, escuela esc, localidad loc, zona_cimientos zona, beca beca,"
						+ " (select a.id, max(es.id) id_entrevista from perfil_alumno a, entrevista_seleccion es where a.id = es.id_perfil_alumno group by a.id) filtro"
						+ " where alum.id = sel.id_perfil_alumno and sel.convocatoria = con.id_convocatoria and sel.id = filtro.id_entrevista"
						+ " and alum.datos_personales = per.id and alum.escuela = esc.id and esc.localidad = loc.id and loc.zona = zona.id and (beca.id=alum.beca_id and beca.padrino = "+padrino.getId()+ ")"
						+ " and ("+consulta+ ")";
				}
				else{
					sql3 ="select alum.*, sel.*, con.* from perfil_alumno alum, entrevista_seleccion sel, convocatoria con, persona per, beca beca, "
						+ " (select a.id, max(es.id) id_entrevista from perfil_alumno a, entrevista_seleccion es where a.id = es.id_perfil_alumno group by a.id) filtro"
						+ " where alum.id = sel.id_perfil_alumno and sel.convocatoria = con.id_convocatoria and sel.id = filtro.id_entrevista and alum.datos_personales = per.id" 
						+ " and (beca.id=alum.beca_id and beca.padrino = "+padrino.getId()+ ") and ("+consulta+ ")";
				}
			}

			if(nombreAlumno != null && padrino == null ){
				if(zona != null){
					sql3 ="select alum.*, sel.*, con.* from perfil_alumno alum, entrevista_seleccion sel, convocatoria con, persona per, zona_cimientos zona, escuela esc, localidad loc,"
						+ " (select a.id, max(es.id) id_entrevista from perfil_alumno a, entrevista_seleccion es where a.id = es.id_perfil_alumno group by a.id) filtro where alum.id = sel.id_perfil_alumno" 
						+ " and sel.convocatoria = con.id_convocatoria and alum.datos_personales = per.id and alum.escuela = esc.id and esc.localidad = loc.id and sel.id = filtro.id_entrevista"
						+ " and loc.zona = zona.id and ("+consulta+ ")";
				}
				else{
					sql3 ="select alum.*, sel.*, con.* from perfil_alumno alum, entrevista_seleccion sel, convocatoria con, persona per,"
						+ " (select a.id, max(es.id) id_entrevista from perfil_alumno a, entrevista_seleccion es where a.id = es.id_perfil_alumno group by a.id) filtro where alum.id = sel.id_perfil_alumno" 
						+ " and sel.convocatoria = con.id_convocatoria and alum.datos_personales = per.id and sel.id = filtro.id_entrevista"
						+ " and ("+consulta+ ")";
				}
			}
			
			
			if(estadoAlumno != null){
				if(estadoAlumno.equals(EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION)){
					sql3+=" and alum.estado_alumno in ( " + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1); 
					sql3+=" , " + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1);
					sql3+=  " ) and alum.estado_renovacion= " + (EvaluacionRenovacionFinal.PENDIENTE.getId()-1);	
				}
				else{
					if(estadoAlumno.equals(EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION)){
						sql3+=" and alum.estado_alumno in ( " + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1); 
						sql3+=" , " + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1);
						sql3+=  " ) and alum.estado_renovacion= " + (EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getId()-1);						
					}
					else{	
						sql3+=" and alum.estado_alumno= " + (estadoAlumno.getId()-1);						
					}
				}
			}
			
			if(zona != null ){
				sql3+= " and zona.id = " + zona.getId();
			
			}
			
			if(convocatoria != null){
				sql3 += " and con.id_convocatoria = " +convocatoria.getIdConvocatoria();
			}
			
			if(ea != null ){
				sql3 += " and perfil_ea_id = " +ea.getIdPerfilEA();
			}
			
			if(escuela != null ){
				sql3 +=" and esc.id = " + escuela.getId(); 
				
			}
			
			if(anio != null){
				sql3 += " and alum.anio_escolar= " + (anio.getId() -1); 
			}
			
			if(anioAdicional != null){
				sql3 += " and alum.anio_adicional= " + anioAdicional;
			}
			
			if(eae!= null){
				if(eae.equals("todos") ){
					eae=null;
				}else{					
					sql3+=" and alum.eae = '" +eae+"'";					
				}
			}
			
			//Solo trae los alumnos activos(Renovada,Incorporado,pendiente con asignacion, pendiente sin asignacion)
			if(becadosActivos){
				sql3 += " and (alum.estado_alumno in(" + (EstadoAlumno.RENOVADO.getId() - 1) + "," + (EstadoAlumno.INCORPORADO.getId() - 1) + ") " +
						"or (alum.estado_alumno in (" + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1) + "," + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1) + 
						") and alum.estado_renovacion in(" + (EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getId()-1) +
						"," + (EvaluacionRenovacionFinal.PENDIENTE.getId()-1)+ ")))";			
			}
		}
			System.out.println("###########################");
			System.out.println(sql3);
		//sql3=sql3+" ORDER BY per.id ASC";
		SQLQuery sqlQuery = getSession().createSQLQuery(sql3);

		
		//((Criteria) sqlQuery).addOrder( Order.asc("per.apellido") );
		sqlQuery.setFirstResult(firstResult);
		sqlQuery.setMaxResults(maxResults);
		sqlQuery.addEntity("alum", PerfilAlumno.class);
		sqlQuery.addEntity("con", Convocatoria.class);
		List<ExportarAlumnosDTO> list = new ArrayList<ExportarAlumnosDTO>();
		ExportarAlumnosDTO dto = null;
		
	
		List<Object[]> objects =sqlQuery.list();
		
		for(Object[] object : objects ){
			dto = new ExportarAlumnosDTO();
			PerfilAlumno alumno = (PerfilAlumno)object[0];
			Convocatoria con = (Convocatoria) object[1];
			dto.setAlumno(alumno);
			dto.setConvocatoria(con);
			list.add(dto);

		};
		
		return list;
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerCantidadAlumnosExportar()
	 */
	@Override
	public Integer obtenerCantidadAlumnosExportar(EstadoAlumno estadoAlumno, 
            ZonaCimientos zona, Convocatoria convocatoria, PerfilPadrino padrino, PerfilEA ea, String nombreAlumno, 
            AnioEscolar anio, Boolean anioAdicional, boolean becadosActivos, String eae, Escuela escuela) {
		
		String consulta = "";
		String sql3 = "";
		if(nombreAlumno != null){
			int cont = 0; 
			for ( String split : nombreAlumno.split(" "))
				if (cont != 0)
					consulta= consulta + "and (per.nombre like '%"+split+"%' or per.apellido like '%"+split+"%')";
				else{
					consulta= consulta + "(per.nombre like '%"+split+"%' or per.apellido like '%"+split+"%')";
					cont=1;
					}
			}
		
		if(padrino == null && nombreAlumno == null){
			
			String sql ="select alum.id from perfil_alumno alum, entrevista_seleccion sel, convocatoria con,escuela esc, localidad loc, beca beca, zona_cimientos zona,"
						+ " (select a.id, max(es.id) id_entrevista from perfil_alumno a, entrevista_seleccion es where a.id = es.id_perfil_alumno"
						+ " group by a.id) filtro where alum.id = sel.id_perfil_alumno and sel.convocatoria = con.id_convocatoria and sel.id = filtro.id_entrevista"
						+ " and alum.beca_id = beca.id and alum.escuela = esc.id and esc.localidad = loc.id and loc.zona = zona.id";
			
			String sql2 = "select alum.id from perfil_alumno alum, entrevista_seleccion sel, convocatoria con,escuela esc, localidad loc, zona_cimientos zona,"
						 + " (select a.id, max(es.id) id_entrevista from perfil_alumno a, entrevista_seleccion es where a.id = es.id_perfil_alumno"
						 + " group by a.id) filtro where alum.id = sel.id_perfil_alumno and sel.convocatoria = con.id_convocatoria and sel.id = filtro.id_entrevista"
						 + " and alum.escuela = esc.id and esc.localidad = loc.id and loc.zona = zona.id";
			
			if(estadoAlumno != null){
				if(estadoAlumno.equals(EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION)){
					sql+=" and alum.estado_alumno in ( " + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1); 
					sql+=" , " + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1);
					sql+=  " ) and alum.estado_renovacion= " + (EvaluacionRenovacionFinal.PENDIENTE.getId()-1);
					sql2+=" and alum.estado_alumno in ( " + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1);	
					sql2+=" , " + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1);
					sql2+= " ) and alum.estado_renovacion= " + (EvaluacionRenovacionFinal.PENDIENTE.getId()-1);
						
				}
				else{
					if(estadoAlumno.equals(EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION)){
						sql+=" and alum.estado_alumno in ( " + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1); 
						sql+=" , " + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1);
						sql+=  " ) and alum.estado_renovacion= " + (EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getId()-1);
						sql2+=" and alum.estado_alumno in ( " + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1);	
						sql2+=" , " + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1);
						sql2+= " ) and alum.estado_renovacion= " + (EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getId()-1);
					}
					else{	
						sql+=" and alum.estado_alumno= " + (estadoAlumno.getId()-1);
						sql2+=" and alum.estado_alumno= " + (estadoAlumno.getId()-1);
					}
				}
			}
			
			if(zona != null ){
				sql+=" and zona.id = " + zona.getId(); 
				sql2+=" and zona.id = " + zona.getId();
			}
			
			if(escuela != null ){
				sql+=" and esc.id = " + escuela.getId(); 
				sql2+=" and esc.id = " + escuela.getId();
			}
			
			if(convocatoria != null){
				sql+=" and con.id_convocatoria = " +convocatoria.getIdConvocatoria(); 
				sql2+=" and con.id_convocatoria = " +convocatoria.getIdConvocatoria();
			}
			
			if(ea != null ){
				sql+=" and perfil_ea_id = " +ea.getIdPerfilEA(); 
				sql2+=" and perfil_ea_id = " +ea.getIdPerfilEA();
			}
			
			if(eae!= null){
				if(eae.equals("todos") ){
					eae=null;
				}else{					
					sql+=" and alum.eae = '" +eae+"'"; 
					sql2+=" and alum.eae = '" +eae+"'";					
				}
			}
			
			if(anio != null){
				sql += " and alum.anio_escolar= " + (anio.getId() -1);
				sql2 += " and alum.anio_escolar= " + (anio.getId() -1);
			}
			
			if(anioAdicional != null){
				sql += " and alum.anio_adicional= " + anioAdicional;
				sql2 += " and alum.anio_adicional= " + anioAdicional;
			}
			
			//Solo trae los alumnos activos(Renovada,Incorporado,pendiente con asignacion, pendiente sin asignacion)
			if(becadosActivos){
				sql += " and (alum.estado_alumno in(" + (EstadoAlumno.RENOVADO.getId() - 1) + "," + (EstadoAlumno.INCORPORADO.getId() - 1) + ") " +
						"or (alum.estado_alumno in (" + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1) + "," + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1) + 
						") and alum.estado_renovacion in(" + (EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getId()-1) +
						"," + (EvaluacionRenovacionFinal.PENDIENTE.getId()-1)+ ")))";
				
				sql2 += " and (alum.estado_alumno in(" + (EstadoAlumno.RENOVADO.getId() - 1) + "," + (EstadoAlumno.INCORPORADO.getId() - 1) + ") " +
						"or (alum.estado_alumno in (" + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1) + "," + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1) + 
						") and alum.estado_renovacion in(" + (EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getId()-1) +
						"," + (EvaluacionRenovacionFinal.PENDIENTE.getId()-1)+ ")))";
			}
			
			sql3 = "select COUNT(*) as row from ("+ sql + " UNION " + sql2 +") contador";
			//System.out.println(sql3);
			
		}else{
			
			if(padrino != null){				
				sql3 ="select COUNT(alum.id) as row from perfil_alumno alum, entrevista_seleccion sel, convocatoria con,escuela esc, localidad loc, beca beca, zona_cimientos zona,"
					+ " (select a.id, max(es.id) id_entrevista from perfil_alumno a, entrevista_seleccion es where a.id = es.id_perfil_alumno"
					+ " group by a.id) filtro where alum.id = sel.id_perfil_alumno and sel.convocatoria = con.id_convocatoria and sel.id = filtro.id_entrevista"
					+ " and alum.beca_id = beca.id and alum.escuela = esc.id and esc.localidad = loc.id and loc.zona = zona.id and (beca.id=alum.beca_id and beca.padrino = "+padrino.getId()+ ")";
			}
			
			if(nombreAlumno != null && padrino != null){
				if(zona != null){
					sql3 ="select COUNT(alum.id) as row from perfil_alumno alum, entrevista_seleccion sel, convocatoria con, persona per, escuela esc, localidad loc, zona_cimientos zona, beca beca,"
						+ " (select a.id, max(es.id) id_entrevista from perfil_alumno a, entrevista_seleccion es where a.id = es.id_perfil_alumno group by a.id) filtro"
						+ " where alum.id = sel.id_perfil_alumno and sel.convocatoria = con.id_convocatoria and sel.id = filtro.id_entrevista"
						+ " and alum.datos_personales = per.id and alum.escuela = esc.id and esc.localidad = loc.id and loc.zona = zona.id and (beca.id=alum.beca_id and beca.padrino = "+padrino.getId()+ ")"
						+ " and ("+consulta+ ")";
				}
				else{
					sql3 ="select COUNT(alum.id) as row from perfil_alumno alum, entrevista_seleccion sel, convocatoria con, persona per, beca beca, "
						+ " (select a.id, max(es.id) id_entrevista from perfil_alumno a, entrevista_seleccion es where a.id = es.id_perfil_alumno group by a.id) filtro"
						+ " where alum.id = sel.id_perfil_alumno and sel.convocatoria = con.id_convocatoria and sel.id = filtro.id_entrevista and alum.datos_personales = per.id" 
						+ " and (beca.id=alum.beca_id and beca.padrino = "+padrino.getId()+ ") and ("+consulta+ ")";
				}
			}

			if(nombreAlumno != null && padrino == null ){
				if(zona != null){
					sql3 ="select COUNT(alum.id) as row from perfil_alumno alum, entrevista_seleccion sel, convocatoria con, persona per, zona_cimientos zona, escuela esc, localidad loc,"
						+ " (select a.id, max(es.id) id_entrevista from perfil_alumno a, entrevista_seleccion es where a.id = es.id_perfil_alumno group by a.id) filtro where alum.id = sel.id_perfil_alumno" 
						+ " and sel.convocatoria = con.id_convocatoria and alum.datos_personales = per.id and alum.escuela = esc.id and esc.localidad = loc.id and sel.id = filtro.id_entrevista"
						+ " and loc.zona = zona.id and ("+consulta+ ")";
				}
				else{
					sql3 ="select COUNT(alum.id) as row from perfil_alumno alum, entrevista_seleccion sel, convocatoria con, persona per,"
						+ " (select a.id, max(es.id) id_entrevista from perfil_alumno a, entrevista_seleccion es where a.id = es.id_perfil_alumno group by a.id) filtro where alum.id = sel.id_perfil_alumno" 
						+ " and sel.convocatoria = con.id_convocatoria and alum.datos_personales = per.id and sel.id = filtro.id_entrevista"
						+ " and ("+consulta+ ")";
					}
			}
			
			if(estadoAlumno != null){
				if(estadoAlumno.equals(EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION)){
					sql3+=" and alum.estado_alumno in ( " + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1); 
					sql3+=" , " + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1);
					sql3+=  " ) and alum.estado_renovacion= " + (EvaluacionRenovacionFinal.PENDIENTE.getId()-1);	
				}
				else{
					if(estadoAlumno.equals(EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION)){
						sql3+=" and alum.estado_alumno in ( " + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1); 
						sql3+=" , " + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1);
						sql3+=  " ) and alum.estado_renovacion= " + (EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getId()-1);						
					}
					else{	
						sql3+=" and alum.estado_alumno= " + (estadoAlumno.getId()-1);						
					}
				}
			}
			
			if(zona != null ){
				sql3+= " and zona.id = " + zona.getId();			
			}
			
			if(escuela != null ){
				sql3+= " and esc.id = " + escuela.getId();			
			}
			
			if(convocatoria != null){
				sql3 += " and con.id_convocatoria = " +convocatoria.getIdConvocatoria();
			}
			
			if(ea != null ){
				sql3 += " and perfil_ea_id = " +ea.getIdPerfilEA();
			}
			
			if(eae!= null){
				if(eae.equals("todos") ){
					eae=null;
				}else{					
					sql3+=" and alum.eae = '" +eae+"'";					
				}
			}
			
			if(anio != null){
				sql3 += " and alum.anio_escolar= " + (anio.getId() -1); 
			}
			
			if(anioAdicional != null){
				sql3 += " and alum.anio_adicional= " + anioAdicional;
			}
			
			//Solo trae los alumnos activos(Renovada,Incorporado,pendiente con asignacion, pendiente sin asignacion)
			if(becadosActivos){
				sql3 += " and (alum.estado_alumno in(" + (EstadoAlumno.RENOVADO.getId() - 1) + "," + (EstadoAlumno.INCORPORADO.getId() - 1) + ") " +
						"or (alum.estado_alumno in (" + (EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION.getId()-1) + "," + (EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION.getId()-1) + 
						") and alum.estado_renovacion in(" + (EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR.getId()-1) +
						"," + (EvaluacionRenovacionFinal.PENDIENTE.getId()-1)+ ")))";			
			}
			//System.out.println(sql3);
		}
		
		SQLQuery sqlQuery = getSession().createSQLQuery(sql3);
		sqlQuery.addScalar("row", Hibernate.INTEGER);
		List list =  sqlQuery.list();
		if(list.isEmpty()){
			return 0;
		}else{
			return (Integer) sqlQuery.list().get(0);
		}
		
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#obtenerAlumnosParaEmisionCartas(java.util.List, int, int, org.displaytag.properties.SortOrderEnum, java.lang.String)
	 */
	@Override
	public List<PerfilAlumno> obtenerAlumnosParaEmisionCartas(
			List<EstadoAlumno> estadosAlumnos, int firstResult, int maxResults,
			SortOrderEnum sortDirection, String sortCriterion,String nombreAlumno, EstadoAlumno estadoAlumno, 
			ZonaCimientos zona, Escuela escuela, 
			EmitioCarta emitioCarta, Long idCiclo) {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		criteria.createAlias("escuela","escuela");
		
		if(estadoAlumno != null){
			criteria.add(Restrictions.eq("estadoAlumno",estadoAlumno));
		}else{
			Disjunction disjunction = Restrictions.disjunction(); 
			for (EstadoAlumno estado : estadosAlumnos) {
				disjunction.add(Restrictions.eq("estadoAlumno", estado)); 
			}
			criteria.add(disjunction);
		}
		if(zona != null){
			criteria.add(Restrictions.eq("escuela.zonaCimientos",zona));
		}
		if(escuela != null ){
			criteria.add(Restrictions.eq("escuela", escuela));
		}
		if(nombreAlumno != null ){
			criteria.createAlias("datosPersonales", "persona");
			for ( String split : nombreAlumno.split(" "))
				criteria.add(Restrictions.or(Restrictions.like("persona.nombre", "%"+split+"%"), Restrictions.like("persona.apellido", "%"+split+"%")));
		}
		if(emitioCarta != null ){
			criteria.add(Restrictions.eq("emitioCarta", emitioCarta));
		}
		
		if(idCiclo != null){				
			criteria.add(Restrictions.sqlRestriction("{alias}.id = " +
					"(select distinct(id_perfil_alumno) from entrevista_seleccion es, convocatoria as c, ciclo_programa as cp" +
					" where es.convocatoria = c.id_convocatoria and c.ciclo_programa = cp.id and" +
					" es.id_perfil_alumno = {alias}.id and cp.id = ? )",
					idCiclo, new LongType())); 
		}

		criteria.setFirstResult(firstResult);
		criteria.setMaxResults(maxResults);
		return criteria.list();
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.AlumnoDao#cantidadAlumnosEmisionCartas(java.util.List, int, int, org.displaytag.properties.SortOrderEnum, java.lang.String)
	 */
	@Override
	public Integer cantidadAlumnosEmisionCartas(
			List<EstadoAlumno> estadosAlumnos, int firstResult, int maxResults,
			SortOrderEnum sortDirection, String sortCriterion,String nombreAlumno, EstadoAlumno estadoAlumno, 
			ZonaCimientos zona, Escuela escuela, 
			EmitioCarta emitioCarta, Long idCiclo) {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		criteria.createAlias("escuela","escuela");
		
		if(estadoAlumno != null){
			criteria.add(Restrictions.eq("estadoAlumno",estadoAlumno));
		}else{
			Disjunction disjunction = Restrictions.disjunction(); 
			for (EstadoAlumno estado : estadosAlumnos) {
				disjunction.add(Restrictions.eq("estadoAlumno", estado)); 
			}
			criteria.add(disjunction);
		}
		if(zona != null){
			criteria.add(Restrictions.eq("escuela.zonaCimientos",zona));
		}
		if(escuela != null ){
			criteria.add(Restrictions.eq("escuela", escuela));
		}
		if(nombreAlumno != null ){
			criteria.createAlias("datosPersonales", "persona");
			for ( String split : nombreAlumno.split(" "))
				criteria.add(Restrictions.or(Restrictions.like("persona.nombre", "%"+split+"%"), Restrictions.like("persona.apellido", "%"+split+"%")));

			
		}
		if(emitioCarta != null ){
			criteria.add(Restrictions.eq("emitioCarta", emitioCarta));
		}
		
 
		if(idCiclo != null){			
			criteria.add(Restrictions.sqlRestriction("{alias}.id = " +
					"(select distinct(id_perfil_alumno) from entrevista_seleccion es, convocatoria as c, ciclo_programa as cp" +
					" where es.convocatoria = c.id_convocatoria and c.ciclo_programa = cp.id and" +
					" es.id_perfil_alumno = {alias}.id and cp.id = ? )",
					idCiclo, new LongType())); 
		}

		criteria.setProjection(Projections.rowCount());

		List list = criteria.list();
		if(list.isEmpty()){
			return 0;
		}else{
			return (Integer)list.get(0);
		}
		
	}

	@Override
	public List<PerfilAlumno> obtenerBecadosParaActivarPanelEASeleccion(List<Long> candidatosId) {
		List<PerfilAlumno> alumnos = new ArrayList<PerfilAlumno>();
		if(candidatosId != null && !candidatosId.isEmpty()){
			String query = " select alumno.id, alumno.datosPersonales.apellido, alumno.datosPersonales.dni, alumno.fechaAltaBeca, " +
					" alumno.datosPersonales.nombre, alumno.escuela.localidad.zona.nombre, alumno.escuela.nombre, " +
					" alumno.estadoAlumno, alumno.anioEscolar, alumno.beca.zona.nombre, alumno.responsable1 " +
					" from PerfilAlumno alumno " +
					" where alumno.id in (:becados) ";
			
			Query hqlquery = getSession().createQuery(query).setParameterList("becados", candidatosId);
			
			alumnos = HQLHelper.find(hqlquery, getObjetoManejado());
		}
		return alumnos;
	}

	@Override
	public List<PerfilAlumno> obtenerAlumnosPadrinoCimientosPorZonaCicloPeriodo(
			Long idZona, Long idCicloActual, Long idPeriodo) 
	{
		String sql = " select pa.id, e.id, b.id, z.id, pp.id, c.id "+
		 " from perfil_padrino as pp" + 
		 " join beca as b on b.padrino = pp.id " +
		 " join empresa as e on pp.empresa = e.id " +
		 " join zona_cimientos as z on z.id = b.zona " +
		 " join ciclo_programa as c on c.id = b.ciclo " +
		 " join perfil_alumno as pa on pa.beca_id = b.id " +
		 " where e.denominacion = 'Fundacion Cimientos' and b.estado != 2 " +
		 " and b.periodo_pago = " + idPeriodo + " and b.ciclo = " + idCicloActual + 
		 " and b.zona = " + idZona;


		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();
	}


	@Override
	public int obtenerCantidadBecados(Long idRr,Long idEa, EstadoAlumno estadoAlumno, ZonaCimientos zona, PerfilPadrino padrino,
			String nombreAlumno, AnioEscolar anio, Boolean adicional, Long idCiclo) {
		DetachedCriteria criteria = getCriteriaBecadosAExportar(idRr,idEa,estadoAlumno,zona,padrino,nombreAlumno,anio,adicional,idCiclo);
		criteria.setProjection(Projections.rowCount());
		List results = getHibernateTemplate().findByCriteria(criteria);
		int count = ((Integer) results.get(0)).intValue();
		return count;
	}

	@Override
	public List<PerfilAlumno> obtenerBecadosExportar(int firstResult,int maxResults, SortOrderEnum sortDirection, String sortCriterion,
			Long idRr,Long idEa, EstadoAlumno estadoAlumno, ZonaCimientos zona, PerfilPadrino padrino,
			String nombreAlumno, AnioEscolar anio, Boolean adicional, Long idCiclo) {
		DetachedCriteria criteria = getCriteriaBecadosAExportar(idRr,idEa,estadoAlumno,zona,padrino,nombreAlumno,anio,adicional,idCiclo);
		if (sortCriterion != null) {
			if (sortDirection.equals(SortOrderEnum.ASCENDING)) {
				criteria.addOrder(Order.asc(sortCriterion));
			}
			if (sortDirection.equals(SortOrderEnum.DESCENDING)) {
					criteria.addOrder(Order.desc(sortCriterion));
			}
		}
		criteria.addOrder(Order.asc("persona.apellido")).addOrder(Order.asc("persona.nombre"));
		return getHibernateTemplate().findByCriteria(criteria,firstResult, maxResults);
	}
	
	
	private DetachedCriteria getCriteriaBecadosAExportar(Long idRr, Long idEa, EstadoAlumno estadoAlumno, ZonaCimientos zona, PerfilPadrino padrino,
			String nombreAlumno, AnioEscolar anio, Boolean adicional, Long idCiclo){
		DetachedCriteria criteria = DetachedCriteria.forClass(PerfilAlumno.class);		
		
		criteria.createAlias("ea", "ea");
		criteria.createAlias("ea.datosPersonales", "datosPersonales");
		criteria.createAlias("datosPersonales", "persona");
		criteria.createAlias("escuela", "escuela");
		criteria.createAlias("escuela.localidad", "localidad");
		
		if(idRr != null){
			String sql  = "{alias}.id in (select ape.id_perfil_alumno  from alumno_panelea ape where ape.activo = true)";
			criteria.add(Restrictions.sqlRestriction(sql));
			criteria.add(Restrictions.eq("ea.rr.idPerfilRR", idRr));
		}
		if(idEa != null){
			Object [] objects = new Object[1];
			objects[0] = idEa;			
			Type[]  objectTypes = new Type[1];
			objectTypes[0] = Hibernate.LONG;						
			String sql  = "{alias}.id in (select ape.id_perfil_alumno  from alumno_panelea ape where ape.activo = true and ape.id_perfilea = ?)";
			criteria.add(Restrictions.sqlRestriction(sql,objects,objectTypes));
			criteria.add(Restrictions.eq("ea.idPerfilEA", idEa));
		}
		
		if(estadoAlumno != null){			
			if(estadoAlumno.equals(EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION)){
				List<EstadoAlumno> estados = new ArrayList<EstadoAlumno>();
				estados.add(EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION);
				estados.add(EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION);
				criteria.add(Restrictions.in("estadoAlumno", estados));
				criteria.add(Restrictions.eq("estadoRenovacion", EvaluacionRenovacionFinal.PENDIENTE));
			}
			else{
				if(estadoAlumno.equals(EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION)){
					List<EstadoAlumno> estados = new ArrayList<EstadoAlumno>();
					estados.add(EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION);
					estados.add(EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION);
					criteria.add(Restrictions.in("estadoAlumno", estados));
					criteria.add(Restrictions.eq("estadoRenovacion", EvaluacionRenovacionFinal.EN_CONDICIONES_DE_RENOVAR));
				}
				else	
					criteria.add(Restrictions.eq("estadoAlumno",estadoAlumno));
			}
		}
		else
			criteria.add(Restrictions.in("estadoAlumno", EstadoAlumno.getListaEstadoAcompaniamiento()));
				
		if(zona != null && !zona.getNombre().equals(SIN_ZONA)){
			//su escuela debe ser de la zona de la beca
			criteria.add(Restrictions.eq("localidad.zona.id", zona.getId()));
		}
		
		if(padrino != null){			
			Object [] objects = new Object[2];
			objects[0] = idCiclo;
			objects[1] = padrino.getId();
			Type[]  objectTypes = new Type[2];
			objectTypes[0] = Hibernate.LONG;
			objectTypes[1] = Hibernate.LONG;
			
			String sql = "{alias}.id in(select his.perfil_alumno from perfil_alumno_historial_beca his, beca b where his.historial_beca = b.id" +
					" and b.ciclo = ? and b.padrino = ?)";
			
			Object [] objects2 = new Object[1];
			objects2[0] = padrino.getId();
			Type[]  objectTypes2 = new Type[1];
			objectTypes2[0] = Hibernate.LONG;
			
			String sql2 = "{alias}.beca_id in(select b.id from beca b, perfil_padrino pp where b.padrino = pp.id and pp.id = ?)";
			
			criteria.add(Restrictions.or(Restrictions.sqlRestriction(sql,objects,objectTypes),Restrictions.sqlRestriction(sql2,objects2,objectTypes2)));
			
		}
		
		if(nombreAlumno != null ){			
			for ( String split : nombreAlumno.split(" "))
				criteria.add(Restrictions.or(Restrictions.like("persona.nombre", "%"+split+"%"), Restrictions.like("persona.apellido", "%"+split+"%")));	
		}
		
		if(anio != null)
			criteria.add(Restrictions.eq("anioEscolar", anio));
		
		if(adicional != null)
			criteria.add(Restrictions.eq("anioAdicional", adicional));
		
		return criteria;

	}

	@Override
	public void avanzarAnioEscolar() {
		/*
		 * 
		 *
		//Avanza 1 a�o a los alumnos con estados de seleccion
		String sql = "update perfil_alumno set anio_escolar = (anio_escolar + 1) " +
				"where anio_escolar < 14 and estado_alumno in (1,3,11,12,17)";		
		Query query = getSession().createSQLQuery(sql);
		query.executeUpdate();		
		
		//Avanza 1 a�o mas a los alumos con estados de seleccion y sin a�o adicional que esten "7 tecnica",
		//porque significa que no tienen que estar en "7 tecnica", sino en "-"
		sql = "update perfil_alumno set anio_escolar = (anio_escolar + 1) " +
		"where anio_escolar = 13 and anio_adicional = false and estado_alumno in (1,3,11,12,17)";		
		query = getSession().createSQLQuery(sql);
		query.executeUpdate();
		
		//Los alumnos que en diciembre terminan su participacion, estado "egresado", cambian su a�o escolar a "-"
		sql = "update perfil_alumno set anio_escolar = 14 where estado_alumno = 8";		
		query = getSession().createSQLQuery(sql);
		query.executeUpdate();
		*/
		//Avanza 1 a�o a los alumnos con estados de seleccion
				String sql = "update perfil_alumno set anio_escolar = (anio_escolar + 1) " +
						"where anio_escolar < 14 and estado_alumno in (1,3,11,12,17)";		
				Query query = getSession().createSQLQuery(sql);
				query.executeUpdate();		
				
				//Avanza 1 a�o mas a los alumos con estados de seleccion y sin a�o adicional que esten "7 tecnica",
				//porque significa que no tienen que estar en "7 tecnica", sino en "-"
				sql = "update perfil_alumno set anio_escolar = (anio_escolar + 1) " +
				"where anio_escolar = 14 and anio_adicional = false and estado_alumno in (1,3,11,12,17)";		
				query = getSession().createSQLQuery(sql);
				query.executeUpdate();
				
				//Los alumnos que en diciembre terminan su participacion, estado "egresado", cambian su a�o escolar a "-"
				sql = "update perfil_alumno set anio_escolar = 15 where estado_alumno = 8";		
				query = getSession().createSQLQuery(sql);
				query.executeUpdate();
		
		
		
	}

	@Override
	public int obtenerCantidadAlumnosInactivos(ZonaCimientos zona,PerfilPadrino padrino, PerfilEA ea, Integer dniAlumno,String nombreAlumno,
			EstadoAlumno estadoAlumno, Escuela escuela,AnioEscolar anio,SituacionEscolarAlumno situacionEscolar,
			List<Long> listPeriodosIdBaja,List<Long> listPeriodosIdEgreso, Integer cantPrevias, Integer idTipo,Boolean sexo, Provincia prov,
			Date fechaDesde, Date fechaHasta, String eae) {
		DetachedCriteria criteria = getCriteriaBecadosInactivos(zona,padrino,ea,dniAlumno,nombreAlumno,estadoAlumno,
				escuela,anio,situacionEscolar,listPeriodosIdBaja,listPeriodosIdEgreso,cantPrevias,idTipo,sexo, prov,fechaDesde,fechaHasta,eae);
		criteria.setProjection(Projections.rowCount());
		List results = getHibernateTemplate().findByCriteria(criteria);
		
		int count = ((Integer) results.get(0)).intValue();
		return count;
	}

	private DetachedCriteria getCriteriaBecadosInactivos(ZonaCimientos zona,PerfilPadrino padrino, PerfilEA ea,
			Integer dniAlumno, String nombreAlumno, EstadoAlumno estadoAlumno, Escuela escuela, AnioEscolar anio,
			SituacionEscolarAlumno situacionEscolar, List<Long> listPeriodosIdBaja, List<Long> listPeriodosIdEgreso,
			Integer cantPrevias, Integer idTipo, Boolean sexo, Provincia prov, Date fechaDesde, Date fechaHasta, String eae) {
		
		DetachedCriteria criteria = DetachedCriteria.forClass(PerfilAlumno.class);		
		criteria.createAlias("datosPersonales", "persona");
		
		if(ea != null){
			criteria.add(Restrictions.eq("ea", ea));
		}
		
		if(idTipo != null){
			Object [] objects = new Object[1];
			objects[0] = idTipo -1;
			Type[]  objectTypes = new Type[1];
			objectTypes[0] = Hibernate.INTEGER;
						
			String sql = "{alias}.id in(select his.perfil_alumno from perfil_alumno_historial_beca his, beca b, perfil_padrino pp" +
					" where his.historial_beca = b.id and b.padrino = pp.id and pp.tipo = ?)";
			
			String sql2 = "{alias}.beca_id in(select b.id from beca b, perfil_padrino pp where b.padrino = pp.id and pp.tipo = ?)";
			
			criteria.add(Restrictions.or(Restrictions.sqlRestriction(sql,objects,objectTypes),Restrictions.sqlRestriction(sql2,objects,objectTypes)));

		}
		
		if(padrino != null){			
			Object [] objects = new Object[1];
			objects[0] = padrino.getId();
			Type[]  objectTypes = new Type[1];
			objectTypes[0] = Hibernate.LONG;
						
			String sql = "{alias}.id in(select his.perfil_alumno from perfil_alumno_historial_beca his, beca b where his.historial_beca = b.id" +
					" and b.padrino = ?)";
			
			String sql2 = "{alias}.beca_id in(select b.id from beca b, perfil_padrino pp where b.padrino = pp.id and pp.id = ?)";
			
			criteria.add(Restrictions.or(Restrictions.sqlRestriction(sql,objects,objectTypes),Restrictions.sqlRestriction(sql2,objects,objectTypes)));
			
		}
		
		if(zona != null && !zona.getNombre().equals(SIN_ZONA)){
			//su escuela debe ser de la zona de la beca
			criteria.createAlias("escuela", "escuela");
			criteria.createAlias("escuela.localidad", "localidad");
			criteria.add(Restrictions.eq("localidad.zona.id", zona.getId()));
		}
				
		if(nombreAlumno != null ){
			for ( String split : nombreAlumno.split(" "))
				criteria.add(Restrictions.or(Restrictions.like("persona.nombre", "%"+split+"%"), Restrictions.like("persona.apellido", "%"+split+"%")));	
		}
		
		if(eae!= null){
			if(eae.equals("todos") ){
				eae=null;
			}
		}
						
		if(eae!= null ){	
			criteria.add(Restrictions.eq("eae",eae));
		}
		
		if(anio != null)
			criteria.add(Restrictions.eq("anioEscolar", anio));
		
		if(dniAlumno != null)
			criteria.add(Restrictions.eq("persona.dni", dniAlumno));
		
		if(estadoAlumno != null)
			criteria.add(Restrictions.eq("estadoAlumno", estadoAlumno));
		else
			criteria.add(Restrictions.in("estadoAlumno", EstadoAlumno.getListaEstadosInactivos()));
		
		if(escuela != null)
			criteria.add(Restrictions.eq("escuela", escuela));
		
		if(situacionEscolar != null)
			criteria.add(Restrictions.eq("situacionEscolar", situacionEscolar));
		
//		if(idPeriodo != null)
//			criteria.add(Restrictions.eq("periodoDeBaja.id", idPeriodo));
		
		if(listPeriodosIdBaja != null && listPeriodosIdBaja.size() > 0){
			criteria.add(Restrictions.in("periodoDeBaja.id", listPeriodosIdBaja));
		}
		
//		if(idPeriodoEgreso != null)
//			criteria.add(Restrictions.eq("periodoDeEgreso.id", idPeriodoEgreso));
		if(listPeriodosIdEgreso != null && listPeriodosIdEgreso.size() > 0){
			criteria.add(Restrictions.in("periodoDeEgreso.id", listPeriodosIdEgreso));
		}
		
		if(prov != null)
			criteria.add(Restrictions.eq("persona.provincia.id", prov.getId()));
		
		if(cantPrevias != null){
			String sql = "";
			if(cantPrevias != 4){
				sql = "{alias}.id in(select ape.id_perfil_alumno from alumno_panelea ape where ape.id_perfil_alumno = {alias}.id and ape.cantidad_previas = ?)";				
			}
			else{
				sql = "{alias}.id in(select ape.id_perfil_alumno from alumno_panelea ape where ape.id_perfil_alumno = {alias}.id and ape.cantidad_previas > ?)";
				cantPrevias = 3;
			}			
			Object [] objects = new Object[1];
			objects[0] = cantPrevias;
			Type[]  objectTypes = new Type[1];
			objectTypes[0] = Hibernate.INTEGER;
			criteria.add(Restrictions.sqlRestriction(sql,objects,objectTypes));
		}
		
		if(sexo != null)
			criteria.add(Restrictions.eq("persona.sexo", sexo));
		
		if (fechaDesde!=null){
			criteria.add(Restrictions.ge("ultimaActualizacion", fechaDesde));
		}

		if (fechaHasta!=null){
			Calendar c = Calendar.getInstance();
			c.setTime(fechaHasta);
			c.set(Calendar.HOUR_OF_DAY, 23);
			c.set(Calendar.MINUTE, 59);
			c.set(Calendar.SECOND, 59);
			c.set(Calendar.MILLISECOND, 999);
			Date endOfDate = c.getTime();
		        
			criteria.add(Restrictions.le("ultimaActualizacion", endOfDate));
		}
		
		//Los alumnos que tienen el alumnoPanelEa activo en false, son los que tiene que traerse en la consulta, los que aun estan en true
		//aunque su estado haya cambiado no deben aparecer en este listado aun
		String sqlActivo = "{alias}.id in(select ape.id_perfil_alumno from alumno_panelea ape where ape.id_perfil_alumno = {alias}.id and ape.activo = false)";
		criteria.add(Restrictions.sqlRestriction(sqlActivo));
			
		return criteria;
	}

	@Override
	public List<PerfilAlumno> obtenerAlumnosInactivos(int firstResult,int maxResults, SortOrderEnum sortDirection,
			String sortCriterion, ZonaCimientos zona, PerfilPadrino padrino, PerfilEA ea, Integer dniAlumno,String nombreAlumno,
			EstadoAlumno estadoAlumno, Escuela escuela,AnioEscolar anio,SituacionEscolarAlumno situacionEscolar,
			List<Long> listPeriodosIdBaja,List<Long> listPeriodosIdEgreso, Integer cantPrevias, Integer idTipo,Boolean sexo, Provincia prov,
			Date fechaDesde, Date fechaHasta, String eae) {
		
		DetachedCriteria criteria = getCriteriaBecadosInactivos(zona, padrino, ea, dniAlumno, nombreAlumno,estadoAlumno,escuela,
				anio, situacionEscolar,listPeriodosIdBaja,listPeriodosIdEgreso,cantPrevias, idTipo,sexo, prov,fechaDesde,fechaHasta,eae);
	       if (sortCriterion != null) {
	            if (sortDirection.equals(SortOrderEnum.ASCENDING)) {
	                criteria.addOrder(Order.asc(sortCriterion));
	            }
	            if (sortDirection.equals(SortOrderEnum.DESCENDING)) {
	                criteria.addOrder(Order.desc(sortCriterion));
	            }
	        }
	       else{
	    	   criteria.addOrder(Order.desc("ultimaActualizacion"));
	       }
			return getHibernateTemplate().findByCriteria(criteria,firstResult, maxResults);
	}

	@Override
	public int cantidadAlumnosMismaBecaCicloAnterior(Long idZona, Long idPadrino, Integer ordenCiclo, List<EstadoAlumno> estados) {
		List<Long> alumnos = new ArrayList<Long>();
		String query = " select alumno.id, alumno.estadoAlumno from PerfilAlumno alumno where alumno.estadoAlumno in (:estados) ";
		query += " and beca.padrino.id = :padrino and beca.zona.id = :zona and beca.ciclo.orden = :orden";

		Query hqlquery = getSession().createQuery(query).setParameterList("estados", estados);
		
		hqlquery.setParameter("zona", idZona )
			.setParameter("padrino", idPadrino)
			.setParameter("orden", ordenCiclo - 1);
	
		alumnos = HQLHelper.find(hqlquery, getObjetoManejado());
		
		return alumnos.size();
	}

	@Override
	public List<PerfilAlumno> alumnosMismaBecaCicloAnterior(Beca beca) {
		DetachedCriteria criteria = DetachedCriteria.forClass(PerfilAlumno.class);
		Boolean activo = true;
		criteria.add(org.hibernate.criterion.Property.forName("activo").eq(activo));
		criteria.add(Restrictions.eq("estadoAlumno", EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION));
		criteria.createAlias("beca", "beca");
		criteria.add(Restrictions.eq("beca.padrino", beca.getPadrino()));
		criteria.add(Restrictions.eq("beca.zona", beca.getZona()));
		criteria.createAlias("beca.ciclo", "ciclo");
		criteria.add(Restrictions.le("ciclo.orden", beca.getCiclo().getOrden() - 1) );
	
		return getHibernateTemplate().findByCriteria(criteria);
	}

	@Override
	public List<PerfilAlumno> obtenerAlumnosMismaZonaBeca(Beca beca) {
		DetachedCriteria criteria = DetachedCriteria.forClass(PerfilAlumno.class);
		Boolean activo = true;
		criteria.add(org.hibernate.criterion.Property.forName("activo").eq(activo));
		criteria.add(Restrictions.eq("estadoAlumno", EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION));
		criteria.createAlias("beca", "beca");
		criteria.add(Restrictions.eq("beca.zona", beca.getZona()));
			
		return getHibernateTemplate().findByCriteria(criteria);
	}
	
	@Override
	public int cantidadAlumnosActivosMismaEscuela(Escuela escuela) {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		EstadoAlumno[] estados = new EstadoAlumno[]{EstadoAlumno.ALTA_BECADO,
				EstadoAlumno.PENDIENTE_RENOVACION_CON_ASIGNACION, EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION,
				EstadoAlumno.INCORPORACION_PENDIENTE, EstadoAlumno.INCORPORADO, EstadoAlumno.RENOVADO};		
		criteria.add(Restrictions.in("estadoAlumno", estados));
		criteria.add(Restrictions.isNotNull("escuela"));
		if(escuela != null){
			criteria.add(Restrictions.eq("escuela", escuela));
		}	
		List list = criteria.list();
		if(list.isEmpty()){
			return 0;
		}else{
			return list.size();
		}
	}
	
}
