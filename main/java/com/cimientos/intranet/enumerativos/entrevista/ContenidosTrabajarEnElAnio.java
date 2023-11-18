package com.cimientos.intranet.enumerativos.entrevista;

import java.security.InvalidParameterException;
import java.util.Arrays;
import java.util.List;

public enum ContenidosTrabajarEnElAnio {
	
	AUTOCONOCIMIENTO(1,"Autoconocimiento y autoestima"),
	AUTOEFICACIA(2,"Autoeficacia y autoconfianza"),
	RESPONSABILIDAD(3,"Responsabilidad y compromiso"),
	AUTOCONTROL(4,"Autocontrol y determinaci�n"),
	AUTONOMIA(5,"Autonom�a"),
	PLANFICIACION(6,"Planificaci�n y proyecto de vida"),
	ORGANIZACION(7,"Organizaci�n del tiempo"),
	HABITOS(8,"H�bitos de estudio"),
	PENSAMIENTO(9,"Pensamiento cr�tico y creativo"),
	ENTUSIASMO(10,"Entusiasmo por aprender"),
	SENTIDO(11,"Sentido de la oportunidad"),
	ASERTIVIDAD(12,"Asertividad y comunicaci�n"),
	EMPATIA(13,"Empat�a y trabajo con otros"),
	CONVIVENCIA(14,"Convivencia y resoluci�n de conflictos"),
	PARTICIPACION(15,"Participaci�n"),
	EGRESO(16,"Egreso Efectivo y transici�n post-escolar"),
	ELECCION(17,"Elecci�n de la orientaci�n y cambio de ciclo"),
	TRANSICION(18,"Transici�n primaria-secundaria"),
	OTRO(19,"Otro");

	private Integer id;
	private String valor;
	
	
	private ContenidosTrabajarEnElAnio(Integer id, String valor) {
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




	public static ContenidosTrabajarEnElAnio getContenidosTrabajarEnElAnio(Integer id){

		switch (id) {
		case 1:
			return AUTOCONOCIMIENTO;
		case 2:
			return AUTOEFICACIA;
		case 3:
			return RESPONSABILIDAD;
		case 4:
			return AUTOCONTROL;
		case 5:
			return AUTONOMIA;
		case 6:
			return PLANFICIACION;
		case 7:
			return ORGANIZACION;
		case 8:
			return HABITOS;
		case 9:
			return PENSAMIENTO;
		case 10:
			return ENTUSIASMO;
		case 11:
			return SENTIDO;
		case 12:
			return ASERTIVIDAD;
		case 13:
			return EMPATIA;
		case 14:
			return CONVIVENCIA;
		case 15:
			return PARTICIPACION;
		case 16:
			return EGRESO;
		case 17:
			return ELECCION;
		case 18:
			return TRANSICION;
		case 19:
			return OTRO;	
		
		default:
			throw new InvalidParameterException("Contenido a trabajar en el a�o desconocido: "
					+ id);
		}

	}


	public static List<ContenidosTrabajarEnElAnio> getContenidosTrabajarEnElAnio() {
		return Arrays.asList(values());
	}
	
}
