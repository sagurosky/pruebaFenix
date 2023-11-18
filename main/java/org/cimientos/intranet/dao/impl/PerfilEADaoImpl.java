package org.cimientos.intranet.dao.impl;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

import org.cimientos.intranet.dao.PerfilEADao;
import org.cimientos.intranet.dao.base.SpringHibernateDao;
import org.cimientos.intranet.modelo.EstadoCiclo;
import org.cimientos.intranet.modelo.perfilEA.PerfilEA;
import org.cimientos.intranet.modelo.perfilRR.PerfilRR;
import org.cimientos.intranet.modelo.persona.Persona;
import org.cimientos.intranet.modelo.ubicacion.ZonaCimientos;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


/**
 * PerfilEADaoImpl
 * @author Nicolas Lopez
 *
 */

@Repository
public class PerfilEADaoImpl extends SpringHibernateDao<PerfilEA> implements PerfilEADao {


	/**
	 * @param sessionFactory
	 */
	@Autowired
	public PerfilEADaoImpl(SessionFactory sessionFactory){		
		super(sessionFactory);		
	}
	
	@Override
	protected Class<PerfilEA> getObjetoManejado() {
		return PerfilEA.class;
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.PerfilEADao#obtenerEAsSinAsignacionRR()
	 */
	@Override
	public List<PerfilEA> obtenerEAsSinAsignacionRR() {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		//no debe tener rr asignado
		List<PerfilEA> result = null;
		criteria.add(Restrictions.isNull("rr"));
		criteria.add(Restrictions.isNotEmpty("zona"));
		criteria.add(Restrictions.eq("activo", true));
		result = criteria.list();
		
		return result;
	}

	
	@SuppressWarnings("unchecked")
	@Override
	public List<Long> obtenerIdsBecadosEas(List<Long> idsEas) 
	{
		StringBuffer idEa = new StringBuffer();
		for (Long string : idsEas) 
		{
			idEa.append("");
			idEa.append(string).append("");
			idEa.append(",");
		}
		idEa.deleteCharAt(idEa.lastIndexOf(","));
		String  sqlQuery = "SELECT pa.id,ea.id_perfilea FROM perfilea as ea \n" +
		" INNER JOIN perfil_alumno as pa ON pa.perfil_ea_id = ea.id_perfilea \n" +
	    " WHERE pa.perfil_ea_id IN ("+ idEa.toString() + 
	    ") AND pa.perfil_ea_id IS NOT NULL AND pa.estado_alumno = 9 \n" +
	    " GROUP BY pa.id"; 
		SQLQuery q = getSession().createSQLQuery(sqlQuery);
		List<Object> result = q.list();
		List<Long> ids = new ArrayList<Long>(result.size());
		for(Object row : result){
			ids.add(casteo(((Object[])row)[0]));
			
		}
		if(ids.isEmpty()){
			return null;
		}else{
			return ids;		
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Long> obtenerIdsAltaBecadosEas(List<Long> idsEas) 
	{
		StringBuffer idEa = new StringBuffer();
		for (Long string : idsEas) 
		{
			idEa.append("");
			idEa.append(string).append("");
			idEa.append(",");
		}
		idEa.deleteCharAt(idEa.lastIndexOf(","));
		String  sqlQuery = "SELECT pa.id,ea.idPerfilEA FROM perfilea as ea \n" +
		" INNER JOIN perfilalumno as pa ON pa.PerfilEa_id = ea.idPerfilEA \n" +
	    " WHERE pa.PerfilEa_id IN ("+ idEa.toString() + 
	    ") AND pa.PerfilEa_id IS NOT NULL AND pa.estadoAlumno = 0 \n" +
	    " GROUP BY pa.id"; 
		SQLQuery q = getSession().createSQLQuery(sqlQuery);
		List<Object> result = q.list();
		List<Long> ids = new ArrayList<Long>(result.size());
		for(Object row : result){
			ids.add(casteo(((Object[])row)[0]));
			
		}
		if(ids.isEmpty()){
			return null;
		}else{
			return ids;		
		}
	}
	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.PerfilEADao#obtenerEasConRRAsignado()
	 */
	@Override
	public List<PerfilEA> obtenerEasConRRAsignado() {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		//no debe tener rr asignado		
		//criteria.createAlias("becados", "ciclum");		
		criteria.add(Restrictions.isNotNull("rr"));
		criteria.add(Restrictions.eq("activo", true));	
		//criteria.add(Restrictions.eq("ciclum.beca.ciclo", EstadoCiclo.ACTUAL) );
		return criteria.list();
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.PerfilEADao#obtenerEasConBecadosAsignados()
	 */
	@Override
	public List<PerfilEA> obtenerEasConBecadosAsignados() {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		//deben tener becados asignados
		criteria.add(Restrictions.sizeGt("becados", 0));
		criteria.add(Restrictions.eq("activo", true));
		return criteria.list();
	}

	
	@Override
	public boolean existeEAPorPersona(Persona persona) {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		criteria.add(Restrictions.eq("datosPersonales", persona));
		return !criteria.list().isEmpty();
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.PerfilEADao#obtenerEAsPorZona(java.util.List)
	 */
	@Override
	public List<PerfilEA> obtenerEAsSegunZonaRR(PerfilRR perfilRR) {
		
		Query query = getSession().createQuery("select distinct ea from PerfilEA ea join ea.zona zonas " +
		"where ea.rr is null and zonas.nombre in (" +
		" select zona.nombre from PerfilRR rr join rr.zona zona where rr.idPerfilRR = " + perfilRR.getIdPerfilRR().toString() +
		" ) ");
		List<PerfilEA>  perfiles = query.list();
		
		return perfiles;
	}
	
	/**
	 * @param row
	 * @return
	 */
	private Long casteo(Object id) {
		if(id instanceof BigDecimal){
			return ((BigDecimal)id).longValue();
		}else{
			return ((BigInteger)id).longValue();
		}
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.PerfilEADao#obtenerEAsParaReasignacionSegunZonaRR(org.cimientos.intranet.modelo.perfilRR.PerfilRR)
	 */
	@Override
	public List<PerfilEA> obtenerEAsParaReasignacionSegunZonaRR(
			PerfilRR perfilRR) {
		String queryStr = "select distinct ea from PerfilEA ea join ea.zona zonas " +
		"where ea.rr is not null and ea.activo = 1 ";
		if(perfilRR != null){
			queryStr += " and zonas.id in (" +
			" select zona.id from PerfilRR rr join rr.zona zona where rr.idPerfilRR = " + perfilRR.getIdPerfilRR().toString() +
			" ) ";
		}
		
		Query query = getSession().createQuery(queryStr);
		return query.list();
	}

	@Override
	public List<PerfilEA> obtenerTodos(boolean activos) {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		criteria.add(Restrictions.eq("activo", activos));
		return criteria.list();
	}
	
	
	@Override
	public List<PerfilEA> obtenerEasConBecadosAsignadosYRR() {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		//deben tener becados asignados
		criteria.add(Restrictions.isNotNull("rr"));
		criteria.add(Restrictions.sizeGt("becados", 0));
		criteria.setFetchMode("rr", FetchMode.JOIN);
		criteria.setFetchMode("becados", FetchMode.DEFAULT);
		criteria.add(Restrictions.eq("activo", true));
		return criteria.list();
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.PerfilEADao#obtenerEasPorZona(org.cimientos.intranet.modelo.ubicacion.ZonaCimientos)
	 */
	@Override
	public List<PerfilEA> obtenerEasPorNombreYZona(ZonaCimientos  zona,String texto,int cantidadMax) {
		String sql ="select ea.* from perfilea_zona zona, perfilea ea,persona persona where ea.activo = true and zona.zona=:idZona and zona.perfilea = ea.id_perfilea " +
				" and (persona.id = ea.datos_personales and (persona.nombre like :texto or persona.apellido like :texto ))";
		SQLQuery sqlQuery = getSession().createSQLQuery(sql);
		if (zona!=null)
		sqlQuery.setLong("idZona", zona.getId());
		sqlQuery.setString("texto", "%"+texto+"%");
		sqlQuery.setMaxResults(cantidadMax);
		sqlQuery.addEntity(getObjetoManejado());
		return sqlQuery.list();
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.PerfilEADao#obtenerEAsPorNombreYRR(org.cimientos.intranet.modelo.perfilRR.PerfilRR, java.lang.String)
	 */
	@Override
	public List<PerfilEA> obtenerEAsPorNombreYRR(PerfilRR rr, String texto) {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		criteria.createAlias("datosPersonales", "persona");
		Disjunction disjunction = Restrictions.disjunction(); 
		disjunction.add(Restrictions.like("persona.apellido", "%"+texto+"%")); 
		disjunction.add(Restrictions.like("persona.nombre", "%"+texto+"%")); 
		criteria.add(disjunction);
		criteria.add(Restrictions.eq("activo", true));
		criteria.add(Restrictions.eq("rr", rr));
		List<PerfilEA> lista = criteria.list();
		if(lista.size()>0){
			return lista;
		}else{
			return null;
		}
	}

	@Override
	public List<PerfilEA> obtenerEAsPorNombre(String texto) {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		criteria.createAlias("datosPersonales", "persona");
		Disjunction disjunction = Restrictions.disjunction(); 
		disjunction.add(Restrictions.like("persona.apellido", "%"+texto+"%")); 
		disjunction.add(Restrictions.like("persona.nombre", "%"+texto+"%")); 
		criteria.add(disjunction);
		criteria.add(Restrictions.eq("activo", true));

		List<PerfilEA> lista = criteria.list();
		if(lista.size()>0){
			return lista;
		}else{
			return null;
		}
	}

	@Override
	public List<PerfilEA> obtenerTodosEAsPorNombre(String texto) {
		Criteria criteria = getSession().createCriteria(getObjetoManejado());
		criteria.createAlias("datosPersonales", "persona");
		Disjunction disjunction = Restrictions.disjunction(); 
		disjunction.add(Restrictions.like("persona.apellido", "%"+texto+"%")); 
		disjunction.add(Restrictions.like("persona.nombre", "%"+texto+"%")); 
		criteria.add(disjunction);

		List<PerfilEA> lista = criteria.list();
		if(lista.size()>0){
			return lista;
		}else{
			return null;
		}
	}
	
}


