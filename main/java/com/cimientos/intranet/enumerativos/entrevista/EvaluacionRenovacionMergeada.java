package com.cimientos.intranet.enumerativos.entrevista;

import java.security.InvalidParameterException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public enum EvaluacionRenovacionMergeada {
	 
	NO_RENUEVA(1,"No renueva"),
	PENDIENTE(2,"Renovación Pendiente"),
	EN_CONDICIONES_DE_RENOVAR(3,"En condiciones de renovar"),
	FIN_PARTICIPACION_PFE(4,"Fin participación PFE"),
	RENUEVA(5,"Renueva"),
	COVID(6,"Renovación Condicional");

	private Integer id;
	private String valor;
	
	
	private EvaluacionRenovacionMergeada(Integer id, String valor) {
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
	
	
	public static List<EvaluacionRenovacionMergeada> getEvaluacionesRenovacionMergeada(List<Integer> ids){
		ArrayList<EvaluacionRenovacionMergeada> valor = new ArrayList<EvaluacionRenovacionMergeada>();
		
		for (Integer id: ids)
			valor.add(EvaluacionRenovacionMergeada.getEvaluacionRenovacionMergeada(id));
		
		return valor;
	}
	
	public static EvaluacionRenovacionMergeada getEvaluacionRenovacionMergeada(Integer id){
		switch (id) {
		case 1:
			return NO_RENUEVA;
		case 2:
			return PENDIENTE;
		case 3:
			return EN_CONDICIONES_DE_RENOVAR;
		case 4:
			return FIN_PARTICIPACION_PFE;
		case 5:
			return RENUEVA;
		case 6:
			return COVID;	
		default:
			throw new InvalidParameterException("Evaluacion de renovacion desconocida: " + id);
		}
	}


	public static List<EvaluacionRenovacionMergeada> getTodosEvaluacionRenovacionMergeada() {
		return Arrays.asList(values());
	}
	
	public static List<EvaluacionRenovacionMergeada> getEvaluacionRenovacionFinal() {
		return Arrays.asList(NO_RENUEVA, PENDIENTE, EN_CONDICIONES_DE_RENOVAR, FIN_PARTICIPACION_PFE);
	}

	public static List<EvaluacionRenovacionMergeada> getEvaluacionRenovacion() {
		return Arrays.asList(NO_RENUEVA, PENDIENTE, RENUEVA);
	}

	public static List<EvaluacionRenovacionMergeada> getEvaluacionRenovacionPendiente() {
		return Arrays.asList(NO_RENUEVA, PENDIENTE, RENUEVA);
	}
	
}
