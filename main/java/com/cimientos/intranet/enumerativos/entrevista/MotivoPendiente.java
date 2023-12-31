package com.cimientos.intranet.enumerativos.entrevista;

import java.security.InvalidParameterException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public enum MotivoPendiente {

	DEBERENDIR(1,"A�n debe rendir materias"),
	LOCALIZAR(2,"Todav�a no se ha podido localizar"),	
	OTRO(3,"Otro"),
	RENOEXCEPCION(4,"Se solicita pedido de renovaci�n por excepci�n");
	
	
	private Integer id;
	private String valor;
	
	
	private MotivoPendiente(Integer id, String valor) {
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
	
	public static List<MotivoPendiente> getMotivosPendientes(List<Integer> ids){
		ArrayList<MotivoPendiente> valor = new ArrayList<MotivoPendiente>();
		
		for (Integer id: ids)
			valor.add(MotivoPendiente.getMotivoPendiente(id));
		
		return valor;
	}
	
	public static MotivoPendiente getMotivoPendiente(Integer id){
		switch (id) {
		case 1:
			return DEBERENDIR;
		case 2:
			return LOCALIZAR;
		case 3:
			return OTRO;
		case 4:
			return RENOEXCEPCION;
			
				
		default:
			throw new InvalidParameterException("Evaluacion de cobro de beca desconocida: "
					+ id);
		}
	}


	public static List<MotivoPendiente> getMotivoPendiente() {
		return Arrays.asList(values());
	}
}
