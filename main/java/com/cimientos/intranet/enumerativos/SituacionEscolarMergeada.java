package com.cimientos.intranet.enumerativos;

import java.security.InvalidParameterException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public enum SituacionEscolarMergeada {

	
	PROMOVIDO(1,"Promovido sin adeudar materias"),
	PENDIENTE(2,"Pendiente"),
	REPITIO(3,"Repitio"),
	EGRESO(4,"Egres�"),
	PROMOVIDO_CON_PREVIAS(5,"Promovido con materias a rendir"),
	PROMOVIDOIS3(6,"Pas� de a�o sin adeudar materias"),
	PENDIENTEIS3(7,"Pendiente"),
	REPITIOIS3(8,"Repet�"),
	EGRESOIS3(9,"Egres�"),
	PROMOVIDO_CON_PREVIASIS3(10,"Pas� de a�o adeudando materias"),
	EGRESO_PENDIENTE(11,"Egreso pendiente"),
	EGRESO_PENDIENTEIS3(12,"Egreso pendiente");
	
	
	
	private Integer id;
	private String valor;
	
	
	private SituacionEscolarMergeada(Integer id, String valor) {
		this.id = id;
		this.valor = valor;
	}


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public String getValor() {
		return valor;
	}


	public void setValor(String valor) {
		this.valor = valor;
	}
	
	public static List<SituacionEscolarMergeada> getSituacionesEscolares(List<Integer> ids){
		ArrayList<SituacionEscolarMergeada> valor = new ArrayList<SituacionEscolarMergeada>();
		
		for (Integer id: ids)
			valor.add(SituacionEscolarMergeada.getSituacionEscolar(id));
		
		return valor;
	}
	
	public static SituacionEscolarMergeada getSituacionEscolar(Integer id){
		switch (id) {
		case 1:
			return PROMOVIDO;
		case 2:
			return PENDIENTE;
		case 3:
			return REPITIO;
		case 4:
			return EGRESO;
		case 5:
			return PROMOVIDO_CON_PREVIAS;
		case 6:
			return EGRESO_PENDIENTE;
		case 11:
			return EGRESO_PENDIENTE;	
		default:
			throw new InvalidParameterException("Tipo de estado desconocido: " + id);
		}
	}	
	
	public static List<SituacionEscolarMergeada> getSituacionEscolar(){
		return Arrays.asList(PROMOVIDO, PENDIENTE, REPITIO, EGRESO, PROMOVIDO_CON_PREVIAS, EGRESO_PENDIENTE);
	}

	public static List<SituacionEscolarMergeada> getSituacionEscolarRenovacion(){
		return Arrays.asList(PROMOVIDO, PENDIENTE, REPITIO, PROMOVIDO_CON_PREVIAS);
	}

	/**
	 * @return Resultado Anio Escolar IS3
	 */
	public static SituacionEscolarMergeada getResultadoAnioEscolarIS3(Integer id){
		switch (id) {
		case 1:
			return PROMOVIDOIS3;
		case 2:
			return PENDIENTEIS3;
		case 3:
			return REPITIOIS3;
		case 4:
			return EGRESOIS3;
		case 5:
			return PROMOVIDO_CON_PREVIASIS3;
		case 11:
			return EGRESO_PENDIENTEIS3;
		case 12:
			return EGRESO_PENDIENTEIS3;	
		default:
			throw new InvalidParameterException("Tipo de estado desconocido: " + id);
		}
	}	
}
