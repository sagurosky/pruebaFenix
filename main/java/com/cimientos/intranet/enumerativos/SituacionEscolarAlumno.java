package com.cimientos.intranet.enumerativos;

import java.security.InvalidParameterException;
import java.util.Arrays;
import java.util.List;

public enum SituacionEscolarAlumno {

	
	PROMOVIDO(1,"Promovido sin adeudar materias"),
	PENDIENTE(2,"Pendiente"),
	REPITIO(3,"Repitio"),
	EGRESO(4,"Egres�"),
	PROMOVIDO_CON_PREVIAS(5,"Promovido con materias a rendir");
	
	
	private Integer id;
	private String valor;
	
	
	private SituacionEscolarAlumno(Integer id, String valor) {
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
	
	
	public static SituacionEscolarAlumno getSituacionEscolarAlumno(Integer id){
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
		default:
			throw new InvalidParameterException("Situacion escolar alumno desconocida: "
					+ id);
		}
	}
	
	public static List<SituacionEscolarAlumno> getSituacionEscolarAlumno(){
		return Arrays.asList(values());
	}
}
