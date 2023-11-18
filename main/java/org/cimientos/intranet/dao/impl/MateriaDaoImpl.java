package org.cimientos.intranet.dao.impl;

import java.util.List;

import org.cimientos.intranet.dao.MateriaDao;
import org.cimientos.intranet.dao.base.SpringHibernateDao;
import org.cimientos.intranet.modelo.Materia;
import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * @author msagarduy
 * @param 
 */
@Repository
public class MateriaDaoImpl extends SpringHibernateDao<Materia> implements MateriaDao{

	/**
	 * @param sessionFactory
	 */
	@Autowired
	public MateriaDaoImpl(SessionFactory sessionFactory) {
		super(sessionFactory);
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.base.SpringHibernateDao#getObjetoManejado()
	 */
	@Override
	protected Class<Materia> getObjetoManejado() {
		return Materia.class;
	}

	/* (non-Javadoc)
	 * @see org.cimientos.intranet.dao.MateriaDao#obtenerMateriasBasicas()
	 */
	@Override
	public List<Materia> obtenerMateriasBasicas(boolean traerBasicas) {
		Criteria criteria  = getSession().createCriteria(getObjetoManejado());
		criteria.add(Restrictions.eq("basica", true));		
		criteria.add(Restrictions.disjunction()
		        .add(Restrictions.eq("nombre", "Calificaci�n de Matem�tica"))
		        .add(Restrictions.eq("nombre", "Calificaci�n de Lengua/ Literatura"))
		        .add(Restrictions.eq("nombre", "Cantidad total de materias en el bolet�n"))
		        .add(Restrictions.eq("nombre", "Cantidad de materias aprobadas"))
		        .add(Restrictions.eq("nombre", "Cantidad de materias desaprobadas")));
		criteria.addOrder(Order.asc("nombre"));
		return criteria.list();
	}

}
