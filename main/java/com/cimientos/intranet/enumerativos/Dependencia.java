package com.cimientos.intranet.enumerativos;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

/**
 * The Enum Dependencia.
 */
public enum Dependencia implements Serializable{

	/** The PRIVADA. */
	PRIVADA(1,"Privada"),
	
	/** The ESTATAL. */
	ESTATAL(2,"Estatal"),
	
	MIXTA(3,"-"),
	
	/** The PARROQUIAL. */
	PARROQUIAL(4,"-");
	
	/** The id. */
	private Integer id;
	
	/** The valor. */
	private String valor;
	
	/**
	 * Instantiates a new dependencia.
	 *
	 * @param id the id
	 * @param valor the valor
	 * @author hhrodriguez
	 * @since 01-feb-2011
	 */
	private Dependencia(Integer id, String valor) {
		this.id = id;
		this.valor = valor;
	}

	/**
	 * Gets the id.
	 *
	 * @return the id
	 * @author hhrodriguez
	 * @since 01-feb-2011
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * Sets the id.
	 *
	 * @param id the id to set
	 * @author hhrodriguez
	 * @since 01-feb-2011
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * Gets the valor.
	 *
	 * @return the valor
	 * @author hhrodriguez
	 * @since 01-feb-2011
	 */
	public String getValor() {
		return valor;
	}

	/**
	 * Sets the valor.
	 *
	 * @param valor the valor to set
	 * @author hhrodriguez
	 * @since 01-feb-2011
	 */
	public void setValor(String valor) {
		this.valor = valor;
	}
	
	/**
	 * Gets the dependencia.
	 *
	 * @param id the id
	 * @return the dependencia
	 * @author hhrodriguez
	 * @since 01-feb-2011
	 */
	public static Dependencia getDependencia(Integer id){
		switch (id) {
		case 1:
			return PRIVADA;
		case 2:
			return ESTATAL;
		case 3:
			return MIXTA;
		case 4:
			return PARROQUIAL;
		default:
			return null;
//			throw new InvalidParameterException("Dependencia  desconocida: " + id);
		}

	}
	
	/**
	 * Gets the lista dependencias.
	 *
	 * @return the lista dependencias
	 * @author hhrodriguez
	 * @since 01-feb-2011
	 */
	public static List<Dependencia> getListaDependencias() {
		return Arrays.asList(values());
	}
	
}
