package com.cimientos.intranet.enumerativos.entrevista;

import java.security.InvalidParameterException;
import java.util.Arrays;
import java.util.List;


/**
 * The Enum MateriaBoletinSeleccion.
 */
public enum MateriaBoletinSeleccion {
	
	/** The LENGUA. */
	LENGUA(1,"Lengua"),
	
	/** The MATEMATICA. */
	MATEMATICA(2,"Matem�tica"),
	
	/** The CIENCIA s_ sociales. */
	CIENCIAS_SOCIALES(3,"Ciencias Sociales"),
	
	/** The INGLE s_ lengu a_ extranjera. */
	INGLES_LENGUA_EXTRANJERA(4,"Ingl�s / Lengua Extranjera"),
	
	/** The EDUCACIO n_ fisica. */
	EDUCACION_FISICA(5,"Educaci�n f�sica / Corporal"),
	
	/** The EDUCACIO n_ artistica. */
	EDUCACION_PLASTICA_ARTISTICA(6,"Educaci�n pl�stica-art�stica"),
	BIOLOGIA(7,"Biolog�a"),
	CIENCIAS_NATURALES(8,"Ciencias Naturales"),
	INFORMATICA(9,"Inform�tica"),
	CONSTR_CUIDADANIA_EDU_CIVICA(10,"Construcci�n de ciudadan�a / Educaci�n c�vica"),
	CONTABILIDAD_EDUC_PRACT_CONT(11,"Contabilidad / Educaci�n pr�ctica contable"),
	FISICA(12,"F�sica"),
	FISICO_QUIMICA(13,"F�sico-qu�mica"),
	GEOGRAFIA(14,"Geograf�a"),
	HISTORIA(15,"Historia"),
	INGLES(16,"Ingl�s"),
	LENGUA_LITERATURA(17,"Lengua / Literatura"),
	MUSICA(18,"Matem�tica"),
	PASANTIA_PRAC_PROFESIONAL(19,"Pasant�a / Pr�ctica profesional"),
	QUIMICA(20,"Qu�mica"),
	SALUD_ADOLESCENCIA(21,"Salud y Adolescencia"),
	TECNOLOGIA(22,"Tecnolog�a / TIC");
	
	;
	
	/** The id. */
	private Integer id;
	
	/** The valor. */
	private String valor;
	
	/**
	 * Instantiates a new materia boletin seleccion.
	 *
	 * @param id the id
	 * @param valor the valor
	 * @since 25-ene-2011
	 * @author cfigueroa
	 */
	private MateriaBoletinSeleccion(Integer id,String valor){
		this.id = id;
		this.valor = valor;
		
	}
	
	/**
	 * Gets the id.
	 *
	 * @return the id
	 * @since 25-ene-2011
	 * @author cfigueroa
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * Sets the id.
	 *
	 * @param id the new id
	 * @since 25-ene-2011
	 * @author cfigueroa
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * Gets the valor.
	 *
	 * @return the valor
	 * @since 25-ene-2011
	 * @author cfigueroa
	 */
	public String getValor() {
		return valor;
	}

	/**
	 * Sets the valor.
	 *
	 * @param valor the new valor
	 * @since 25-ene-2011
	 * @author cfigueroa
	 */
	public void setValor(String valor) {
		this.valor = valor;
	}
	
	/**
	 * Gets the materia boletin seleccion.
	 *
	 * @param id the id
	 * @return the materia boletin seleccion
	 * @since 25-ene-2011
	 * @author cfigueroa
	 */
	public static MateriaBoletinSeleccion getMateriaBoletinSeleccion(Integer id){
		switch (id) {
		case 1:
			return LENGUA;
		case 2:
			return MATEMATICA;
		case 3:
			return CIENCIAS_SOCIALES;
		case 4:
			return INGLES_LENGUA_EXTRANJERA;
		case 5:
			return EDUCACION_FISICA;
		case 6:
			return EDUCACION_PLASTICA_ARTISTICA;	
		case 7:
			return BIOLOGIA;
		case 8:
			return CIENCIAS_NATURALES;
		case 9:
			return INFORMATICA;
		case 10:
			return CONSTR_CUIDADANIA_EDU_CIVICA;
		case 11:
			return CONTABILIDAD_EDUC_PRACT_CONT;
		case 12:
			return FISICA;
		case 13:
			return FISICO_QUIMICA;
		case 14:
			return GEOGRAFIA;
		case 15:
			return HISTORIA;
		case 16:
				return INGLES;
		case 17:
			return LENGUA_LITERATURA;
		case 18:
			return MUSICA;
		case 19:
			return PASANTIA_PRAC_PROFESIONAL;
		case 20:
			return QUIMICA;
		case 21:
			return SALUD_ADOLESCENCIA;
		case 22:
			return TECNOLOGIA;
		default:
			throw new InvalidParameterException("Materia de Boletin de Seleccion desconocida: "
					+ id);
		}
	}


	/**
	 * Gets the materia boletin seleccion.
	 *
	 * @return the materia boletin seleccion
	 * @since 25-ene-2011
	 * @author cfigueroa
	 */
	public static List<MateriaBoletinSeleccion> getMateriaBoletinSeleccion() {
		return Arrays.asList(values());
	}
}
