package org.cimientos.intranet.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.WeakHashMap;

import org.cimientos.intranet.dao.BecaDao;
import org.cimientos.intranet.dao.base.HQLHelper;
import org.cimientos.intranet.dao.base.SpringHibernateDao;
import org.cimientos.intranet.modelo.Beca;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.EstadoBeca;
import org.cimientos.intranet.modelo.EstadoCiclo;
import org.cimientos.intranet.modelo.Periodo;
import org.cimientos.intranet.modelo.perfil.EstadoAlumno;
import org.cimientos.intranet.modelo.perfil.PerfilAlumno;
import org.cimientos.intranet.modelo.perfilPadrino.PerfilPadrino;
import org.cimientos.intranet.modelo.perfilPadrino.TipoPadrino;
import org.cimientos.intranet.modelo.ubicacion.ZonaCimientos;
import org.displaytag.properties.SortOrderEnum;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.type.IntegerType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cimientos.intranet.enumerativos.TipoBeca;
import com.googlecode.ehcache.annotations.Cacheable;

/**
 * @author plabaronnie
 *
 */
@Repository
public class BecaDaoImpl extends SpringHibernateDao<Beca> implements BecaDao {

	/**
	 * @param sessionFactory Objeto para abrir una sesion a la DB.
	 * Constructor de la clase.
	 */
	@Autowired
	public BecaDaoImpl(SessionFactory sessionFactory) {
		super(sessionFactory);
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.base.SpringHibernateDao#getObjetoManejado()
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.Beca")
	protected Class<Beca> getObjetoManejado() {
		return Beca.class;
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.BecaDao#obtenerBecasConCupo()
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.Beca")
	public List<Beca> obtenerBecasConCupo(int year) {
		List<EstadoBeca> estados = new ArrayList<EstadoBeca>();
		estados.add(EstadoBeca.CONFIRMADA);
		estados.add(EstadoBeca.PLANIFICADA);
		List<Beca> becas ;
		Query query = getSession().createQuery(" from Beca beca " +
				" where beca.activo = true and year(beca.ciclo.fechaInicio) = " + year +
				" and estado in (:estados) " +
				" and beca.cantidad > beca.becados.size ").
				setParameterList("estados", estados);
		becas = query.list();
		return becas;
	}
	
	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.BecaDao#obtenerBecasConCupo()
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.Beca")
	public List<Beca> obtenerBecasPorEstado(EstadoBeca estadoBeca) {
		DetachedCriteria criteria = DetachedCriteria.forClass(getObjetoManejado());
		Boolean activo = true;
		criteria.add(Restrictions.eq("activo", activo) );

		criteria.add(Restrictions.eq("estado", estadoBeca));
		return getHibernateTemplate().findByCriteria(criteria);
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.BecaDao#obtenerBecasActivas()
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.Beca")
	public List<Beca> obtenerBecasActivas() {
		DetachedCriteria criteria = DetachedCriteria.forClass(getObjetoManejado());
		Boolean activo = true;
		criteria.add(Restrictions.eq("activo", activo) );
		return getHibernateTemplate().findByCriteria(criteria);

	}


	
	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.BecaDao#buscarBecaCorrespondienteCicloAnterior(org.cimientos.intranet.modelo.perfilPadrino.PerfilPadrino, org.cimientos.intranet.modelo.ubicacion.ZonaCimientos, int)
	 */
	@Override
	public Beca buscarBecaCorrespondienteCicloAnterior(PerfilPadrino padrino,
			ZonaCimientos zona, int anioCicloAnterior) {
		DetachedCriteria criteria = DetachedCriteria.forClass(PerfilAlumno.class);
		Boolean activo = true;
		criteria.add(org.hibernate.criterion.Property.forName("activo").eq(activo));
		criteria.createAlias("beca", "beca");
		criteria.add(Restrictions.eq("beca.padrino", padrino));
		criteria.add(Restrictions.eq("beca.zona", zona));
		criteria.add(Restrictions.eq("estado", EstadoAlumno.INCORPORADO));
		criteria.add(Restrictions.eq("estado", EstadoAlumno.PENDIENTE_RENOVACION_SIN_ASIGNACION));
		criteria.add(Restrictions.sqlRestriction(" {alias}.beca_id in (select c.id from ciclo_programa c where year(c.fecha_inicio) = ?)", anioCicloAnterior, new IntegerType()));
		final List<Beca> becas = getHibernateTemplate().findByCriteria(criteria);

		if (becas != null && !becas.isEmpty()){
			return becas.get(0);
		} else {
			return null;

		}
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.BecaDao#obtenerBecasPorPeriodo(org.cimientos.intranet.modelo.Periodo)
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.Beca")
	public List<Beca> obtenerBecasPorPeriodo(Periodo periodo) {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		criteria.add(Restrictions.eq("periodoPago", periodo));
		return criteria.list();
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.BecaDao#cantidadBecasUltimoAnioEscolarPorZona(java.lang.Long, java.lang.Long)
	 */
	@Override
	public Integer cantidadBecasUltimoAnioEscolarPorZona(Long idPeriodo , Long idZona) {
   //TODO retorna 0 porque no esta definido como discriminar el ultimo anio escolar, la funcion comentada retorna solamente los alumnos del septimo anio.- 
		
//		Criteria criteria = getSession().createCriteria(PerfilAlumno.class);
//		getCriteriaBecasCesadas(idPeriodo, idZona, criteria);
//		criteria.add(Restrictions.eq("anioEscolar", AnioEscolar.SEPTIMO_SEC)); // Se refactorizo y se agrego ultimo a�o escolar
//		criteria.setProjection(Projections.rowCount());
//		List result = criteria.list();
//		return (Integer)result.get(0);
		
		return 0;
	}


	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.BecaDao#cantidadBecasCesadasPorZona(java.lang.Long, java.lang.Long)
	 */
	@Override
	public Integer cantidadBecasCesadasPorZona(Long idPeriodo , Long idZona) {
		
		String sql = " select entrevista.id from entrevista " +
					 " join exportacion_especial as ee on entrevista.exportacion_especial = ee.id " +
					 " join beca as b on ee.id_beca = b.id " +
					 " join zona_cimientos as z on z.id = b.zona " +
					 " join periodo as p on p.id = " + idPeriodo +
					 " join ciclo_programa as c on c.id = p.ciclo " +
					 " where entrevista.evaluacion_cobro_beca = 3 and entrevista.tipo = 'individual'  " +
					 " and b.periodo_pago = " + idPeriodo + " and b.ciclo = c.id and b.zona = " + idZona;
		
		SQLQuery query = getSession().createSQLQuery(sql);
		 
		return query.list().size();
		
	}
	
	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.BecaDao#obtenerBecasActivas()
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.Beca")
	public List<Beca> obtenerBecasCicloActual() {
		List<EstadoBeca> estados = new ArrayList<EstadoBeca>();
		estados.add(EstadoBeca.CONFIRMADA);
		estados.add(EstadoBeca.PLANIFICADA);
		List<Beca> becas = new ArrayList<Beca>();
		String query = " select beca.id, beca.zona.nombre, beca.padrino.datosPersonales.apellido, " +
				" beca.padrino.datosPersonales.nombre, beca.padrino.tipo, beca.estado, beca.cantidad, " +
				" beca.cantidadAsignada, beca.tipo, beca.comentarios, beca.fechaBajaBecado " +
				" from Beca beca " +
				" where beca.activo = true " +
				" and beca.ciclo.estado = :estadoActual " +
				" and beca.estado in (:estados) " +
				" and beca.periodoPago.fechaInicio <= :fechaActual" +
				" and beca.cantidad > beca.cantidadAsignada and beca.padrino.tipo = 1" +
				"";
		Query hqlquery = getSession().createQuery(query).
				setParameterList("estados", estados).setParameter("estadoActual", EstadoCiclo.ACTUAL )
				.setParameter("fechaActual", new Date());
		becas = HQLHelper.find(hqlquery, getObjetoManejado());
		
		
		query = " select beca.id, beca.zona.nombre, " +
		" beca.padrino.tipo, beca.estado, beca.cantidad, " +
		" beca.cantidadAsignada, beca.padrino.empresa.denominacion, beca.tipo " +
		" from Beca beca " +
		" where beca.activo = true " +
		" and beca.ciclo.estado = :estadoActual " +
		" and beca.estado in (:estados) " +
		" and beca.periodoPago.fechaInicio <= :fechaActual" +
		" and beca.cantidad > beca.cantidadAsignada and beca.padrino.tipo = 0" +
		"";
		
		hqlquery = getSession().createQuery(query).
				setParameterList("estados", estados).setParameter("estadoActual", EstadoCiclo.ACTUAL )
				.setParameter("fechaActual", new Date());
		becas.addAll(HQLHelper.find(hqlquery, getObjetoManejado()));		
		
		return becas;

	}
	
	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.BecaDao#obtenerBecasActivas()
	 */
	@Override
	@Cacheable(cacheName = "org.cimientos.intranet.modelo.Beca")
	public List<Beca> obtenerBecasCicloActualParaReasignacion() {
		List<EstadoBeca> estados = new ArrayList<EstadoBeca>();
		estados.add(EstadoBeca.CONFIRMADA);
		estados.add(EstadoBeca.PLANIFICADA);
		List<Beca> becas ;
		Query query = getSession().createQuery(" from Beca beca " +
				" where beca.activo = true and beca.ciclo.estado = :estadoActual " +
				" and estado in (:estados) ").
				setParameterList("estados", estados).setParameter("estadoActual", EstadoCiclo.ACTUAL );
		becas = query.list();
		
		return becas;

	}

	@Override
	public Map<Long, Integer> obtenerCantidadBecados() {
		Criteria criteria = getSession().createCriteria(PerfilAlumno.class);
		ProjectionList list = Projections.projectionList();
		list.add(Projections.groupProperty("beca.id"));
		list.add(Projections.count("id"));
		criteria.setProjection(list);
		List<Object[]> resultado =  criteria.list();
		Map<Long, Integer> cantidades = new WeakHashMap<Long, Integer>();
		for (Object[] strings : resultado) {
			if(strings[0]!=null){
				cantidades.put((Long)strings[0], (Integer)strings[1]);
			}
			
		}

		return cantidades;
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.BecaDao#obtenerCantidadEntrevistasAExportar(org.cimientos.intranet.modelo.CicloPrograma, java.lang.Integer, java.lang.Integer, java.lang.Long, java.lang.Integer, java.lang.Long, java.lang.Long)
	 */
	@Override
	public int obtenerCantidadBecasAExportar(CicloPrograma ciclo,
			Integer idTipo, Integer idEstado, Long idPeriodo,
			Integer tipoBecaId, Long padrinoId, Long zonaId,boolean total, Boolean becaClonada) {
		DetachedCriteria criteria = getCriteriaBecasAExportar(ciclo, idTipo, idEstado, idPeriodo, tipoBecaId, padrinoId, zonaId, total,becaClonada);
		criteria.setProjection(Projections.rowCount());
		List results = getHibernateTemplate().findByCriteria(criteria);
		int count = ((Integer) results.get(0)).intValue();
		return count;

	}

	/**
	 * @param ciclo
	 * @param idTipo
	 * @param idEstado
	 * @param idPeriodo
	 * @param tipoBecaId
	 * @param padrinoId
	 * @param zonaId
	 * @param total - Se utiliza para clonar becas, si es 'true' no trae las becas inactivas
	 * @param becaClonada 
	 * @return
	 */
	private DetachedCriteria getCriteriaBecasAExportar(
			CicloPrograma ciclo, Integer idTipoPadrino, Integer idEstado,
			Long idPeriodo, Integer tipoBecaId, Long padrinoId, Long zonaId, boolean total, Boolean becaClonada) {
		DetachedCriteria criteria = DetachedCriteria.forClass(Beca.class);
		
		criteria.add(Restrictions.eq("activo", true));
		
		if(ciclo != null){
			criteria.add(Restrictions.eq("ciclo", ciclo));
		}
		if(idTipoPadrino != null || padrinoId != null){
			criteria.createAlias("padrino", "padrino");
		}
		if(idTipoPadrino != null){	
			criteria.add(Restrictions.eq("padrino.tipo", TipoPadrino.getTipoPadrino(idTipoPadrino)));
		}
		if(idEstado != null){
			criteria.add(Restrictions.eq("estado", EstadoBeca.getEstadoBeca(idEstado)));
		}
		
		if(idPeriodo != null){
			criteria.add(Restrictions.eq("periodoPago.id", idPeriodo));
		}
		if(padrinoId != null){
			criteria.add(Restrictions.eq("padrino.id", padrinoId));
		}

		if(zonaId != null){
			criteria.createAlias("zona", "zona");
			criteria.add(Restrictions.eq("zona.id", zonaId));
		}
		
		if(tipoBecaId != null){
			criteria.add(Restrictions.eq("tipo", TipoBeca.getTipoBeca(tipoBecaId)));
		}
		
		if(total)
			criteria.add(Restrictions.ne("estado", EstadoBeca.INACTIVA));
		
		if(becaClonada != null)
			if(becaClonada)
				criteria.add(Restrictions.ne("clonada", "NO"));
			else
				criteria.add(Restrictions.or(Restrictions.isNull("clonada"), Restrictions.eq("clonada", "NO")));

		return criteria;
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.BecaDao#obtenerEntrevistasAExportar(org.cimientos.intranet.modelo.CicloPrograma, java.lang.Integer, java.lang.Integer, java.lang.Long, java.lang.Integer, java.lang.Long, java.lang.Long, int, int, org.displaytag.properties.SortOrderEnum, java.lang.String)
	 */
	@Override
	public List<Beca> obtenerBecasAExportar(CicloPrograma ciclo,Integer idTipo, Integer idEstado, Long idPeriodo,
			Integer tipoBecaId, Long padrinoId, Long zonaId, boolean total, Boolean becaClonada,
			int firstResult, int maxResults, SortOrderEnum sortDirection, String sortCriterion) {
		DetachedCriteria criteria = getCriteriaBecasAExportar(ciclo, idTipo, idEstado, idPeriodo, tipoBecaId, padrinoId, zonaId,total, becaClonada);
	       if (sortCriterion != null) {
	            if (sortDirection.equals(SortOrderEnum.ASCENDING)) {
	                criteria.addOrder(Order.asc(sortCriterion));
	            }
	            if (sortDirection.equals(SortOrderEnum.DESCENDING)) {
	                criteria.addOrder(Order.desc(sortCriterion));
	            }
	        }
			return getHibernateTemplate().findByCriteria(criteria,
	                firstResult, maxResults);
	}
	

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.BecaDao#cantidadBecasPorEstados(java.util.List)
	 */
	@Override
	public Integer cantidadBecasPorEstados(List<EstadoBeca> estadoBecas) {
		Criteria criteria = getSession().createCriteria(Beca.class);
		criteria.add(Restrictions.eq("activo", true));
		criteria.add(Restrictions.in("estado", estadoBecas));
		criteria.setProjection(Projections.rowCount());
		return (Integer)criteria.list().get(0);
	}

	@Override
	public List<Beca> obtenerBecasCicloActualPorFecha(Date fecha) {

		List<EstadoBeca> estados = new ArrayList<EstadoBeca>();
		estados.add(EstadoBeca.CONFIRMADA);
		estados.add(EstadoBeca.PLANIFICADA);
		List<Beca> becas = new ArrayList<Beca>();
		String query = " select beca.id, beca.zona.nombre, beca.zona.id, beca.padrino.datosPersonales.apellido, " +
				" beca.padrino.datosPersonales.nombre, beca.padrino.tipo, beca.padrino.id, beca.estado, beca.cantidad, " +
				" beca.cantidadAsignada, beca.tipo, beca.ciclo, beca.periodoPago.nombre, beca.comentarios, beca.fechaBajaBecado " +
				" from Beca beca " +
				" where beca.activo = true " +
				" and beca.ciclo.estado = :estadoActual " +
				" and beca.estado in (:estados) " +
				" and beca.periodoPago.fechaInicio <= :fechaActual" +
				" and beca.cantidad > beca.cantidadAsignada and beca.padrino.tipo = 1" +
				"";
		Query hqlquery = getSession().createQuery(query).
				setParameterList("estados", estados).setParameter("estadoActual", EstadoCiclo.ACTUAL )
				.setParameter("fechaActual", fecha);
		becas = HQLHelper.find(hqlquery, getObjetoManejado());
		
		
		query = " select beca.id, beca.zona.nombre, beca.zona.id, " +
		" beca.padrino.tipo, beca.estado, beca.cantidad, " +
		" beca.cantidadAsignada, beca.padrino.empresa.denominacion, beca.padrino.id, beca.tipo, beca.ciclo, beca.periodoPago.nombre, beca.comentarios, beca.fechaBajaBecado " +
		" from Beca beca " +
		" where beca.activo = true " +
		" and beca.ciclo.estado = :estadoActual " +
		" and beca.estado in (:estados) " +
		" and beca.periodoPago.fechaInicio <= :fechaActual" +
		" and beca.cantidad > beca.cantidadAsignada and beca.padrino.tipo = 0" +
		"";
		
		hqlquery = getSession().createQuery(query).
				setParameterList("estados", estados).setParameter("estadoActual", EstadoCiclo.ACTUAL )
				.setParameter("fechaActual", fecha);
		becas.addAll(HQLHelper.find(hqlquery, getObjetoManejado()));		
		
		return becas;
	}
	@Override
	public List<Beca> buscarBecaPorCicloPorZona(ZonaCimientos zona, Long ciclo) {
		Criteria criteria = getSession().createCriteria(Beca.class);
		List<EstadoBeca> estados = new ArrayList<EstadoBeca>();
		estados.add(EstadoBeca.CONFIRMADA);
		estados.add(EstadoBeca.PLANIFICADA);
		criteria.add(Restrictions.eq("activo", true));
		criteria.add(Restrictions.in("estado", estados));
		criteria.add(Restrictions.eq("zona", zona));
		criteria.add(Restrictions.eq("ciclo.id", ciclo));		
		return criteria.list();
	}
}
