package com.cimientos.intranet.enumerativos.entrevista;

import java.security.InvalidParameterException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public enum EvaluacionIncorporacion {

	INCORPORA(1,"Incorpora"),
	NOINCORPORA(2,"No incorpora"),
	INCORPORAPENDIENTE(3,"Incorporación Pendiente");
	
	
	private Integer id;
	private String valor;
	
	
	private EvaluacionIncorporacion(Integer id, String valor) {
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
	
	public static List<EvaluacionIncorporacion> getEvaluacionesIncorporacion(List<Integer> ids){
		ArrayList<EvaluacionIncorporacion> valor = new ArrayList<EvaluacionIncorporacion>();
		
		for (Integer id: ids)
			valor.add(EvaluacionIncorporacion.getEvaluacionIncorporacion(id));
		
		return valor;
	}
	
	public static EvaluacionIncorporacion getEvaluacionIncorporacion(Integer id){
		switch (id) {
		case 1:
			return INCORPORA;
		case 2:
			return NOINCORPORA;
		case 3:
			return INCORPORAPENDIENTE;
					
		default:
			throw new InvalidParameterException("Evaluacion de incorporacion desconocida: "
					+ id);
		}
	}


	public static List<EvaluacionIncorporacion> getEvaluacionIncorporacion() {
		return Arrays.asList(values());
	}
		
}
