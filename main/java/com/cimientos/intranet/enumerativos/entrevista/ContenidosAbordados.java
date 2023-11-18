package com.cimientos.intranet.enumerativos.entrevista;

import java.security.InvalidParameterException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public enum ContenidosAbordados {

	
	
	PLANIFICACION(1,"PLANIFICACI�N Y ORGANIZACI�N DEL TIEMPO / H�bitos de estudio"),
	ESTRATEGIAS(2,"PLANIFICACI�N Y ORGANIZACI�N DEL TIEMPO / H�bitos de estudio"),
	CRITERIOS(3,"PARTICIPACI�N EN PFE / Participaci�n en PFE (varios)"),
	PLANIFICACIONPROYECTO(4,"PLANIFICACI�N Y ORGANIZACI�N DEL TIEMPO / Planificaci�n y proyecto de vida"),
	PLANIFICACIONTIEMPO(5,"PLANIFICACI�N Y ORGANIZACI�N DEL TIEMPO / Organizaci�n del tiempo"),
	AUTONOMIA(6,"RESPONSABILIDAD Y AUTONOM�A / Autonom�a"),
	AUTOCONOCIMIENTO(7,"RESPONSABILIDAD Y AUTONOM�A / Responsabilidad y compromiso"),
	COMPROMISOBECADO(8,"RESPONSABILIDAD Y AUTONOM�A / Responsabilidad y compromiso"),
	COMPROMISORA(9,"FAMILIAS / Generales"),
	ROLRA(10,"FAMILIAS / Generales"),
	HERRAMIENTASRA(11,"PLANIFICACI�N Y ORGANIZACI�N DEL TIEMPO / Egreso y Transici�n post-escolar"),
	RELACIONESCUELARA(12,"FAMILIAS / Generales"),
	DESEMPENIOESCOLAR(13, "PLANIFICACI�N Y ORGANIZACI�N DEL TIEMPO / H�bitos de estudio"),
	PERMANENCIAALUM(14,"SITUACIONES DE RIESGO EDUCATIVO / Escolares: Materias previas"),
	PROMOCIONMATERIA(15,"PARTICIPACI�N EN PFE / Participaci�n en PFE (varios)"),
	REPITENCIA(16,"RESPONSABILIDAD Y AUTONOM�A / Autocontrol y determinaci�n"),
	EGRESO(17,"AUTOCONCEPTO / Autoconocimiento y autoestima"),
	DISENIOPLANIFICACION(18,"RESPONSABILIDAD Y AUTONOM�A / Autocontrol y determinaci�n"),
	IMPLEMENESTRATEGIA(19,"RELACIONES INTERPERSONALES / Empat�a y Trabajo con otros"),
	REUNIONDIRECTIVOS(20, "RELACIONES INTERPERSONALES / Convivencia y resoluci�n de conflictos"),
	REUNIONEQUIPO(21,"TOMA DE DECISIONES / Pensamiento cr�tico y creativo"),
	OBSERCLASES(22,"PLANIFICACI�N Y ORGANIZACI�N DEL TIEMPO / H�bitos de estudio"),
	CAPACITACION(23,"TOMA DE DECISIONES / Pensamiento cr�tico y creativo"),
	INDICADORES(24,"PLANIFICACI�N Y ORGANIZACI�N DEL TIEMPO / Transici�n Primaria-Secundaria"),
	JORNADAINSTITUCIONAL(25,"PLANIFICACI�N Y ORGANIZACI�N DEL TIEMPO / Elecci�n de orientaci�n y cambio de ciclo");
	

	
	
	private Integer id;
	private String valor;
	
	
	private ContenidosAbordados(Integer id, String valor) {
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
	
	
	public static ContenidosAbordados getContenidosAbordados(Integer id){
		switch (id) {
		case 1:
			return PLANIFICACION;
		case 2:
			return ESTRATEGIAS;
		case 3:
			return CRITERIOS;
		case 4:
			return PLANIFICACIONPROYECTO;
		case 5:
			return PLANIFICACIONTIEMPO;
		case 6:
			return AUTONOMIA;
		case 7:
			return AUTOCONOCIMIENTO;
		case 8:
			return COMPROMISOBECADO;
		case 9:
			return COMPROMISORA;
		case 10:
			return ROLRA;
		case 11:
			return HERRAMIENTASRA;
		case 12:
			return RELACIONESCUELARA;
		case 13:
			return DESEMPENIOESCOLAR;
		case 14:
			return PERMANENCIAALUM;
		case 15:
			return PROMOCIONMATERIA;
		case 16:
			return REPITENCIA;
		case 17:
			return EGRESO;
		case 18:
			return DISENIOPLANIFICACION;
		case 19:
			return IMPLEMENESTRATEGIA;
		case 20:
			return REUNIONDIRECTIVOS;
		case 21:
			return REUNIONEQUIPO;
		case 22:
			return OBSERCLASES;
		case 23:
			return CAPACITACION;
		case 24:
			return INDICADORES;
		case 25:
			return JORNADAINSTITUCIONAL;
		
		default:
			throw new InvalidParameterException("Compromiso abordado desconocido: "
					+ id);
		}

	}


	public static List<ContenidosAbordados> getContenidosAbordados() {
		return Arrays.asList(values());
	}
	
	public static List<ContenidosAbordados> getContenidosAbordadosEntrevistaMensual() {
		ArrayList<ContenidosAbordados> listaContAbordadosEntrevMensual = new ArrayList<ContenidosAbordados>();
		
		
		listaContAbordadosEntrevMensual.add(PLANIFICACION);
		listaContAbordadosEntrevMensual.add(ESTRATEGIAS);
		listaContAbordadosEntrevMensual.add(CRITERIOS);
		listaContAbordadosEntrevMensual.add(PLANIFICACIONPROYECTO);
		listaContAbordadosEntrevMensual.add(PLANIFICACIONTIEMPO);
		listaContAbordadosEntrevMensual.add(AUTONOMIA);
		listaContAbordadosEntrevMensual.add(AUTOCONOCIMIENTO);
		listaContAbordadosEntrevMensual.add(COMPROMISOBECADO);
		listaContAbordadosEntrevMensual.add(COMPROMISORA);
		listaContAbordadosEntrevMensual.add(ROLRA);
		listaContAbordadosEntrevMensual.add(HERRAMIENTASRA);
		listaContAbordadosEntrevMensual.add(RELACIONESCUELARA);
		listaContAbordadosEntrevMensual.add(DESEMPENIOESCOLAR);
		listaContAbordadosEntrevMensual.add(PERMANENCIAALUM);
		listaContAbordadosEntrevMensual.add(PROMOCIONMATERIA);
		listaContAbordadosEntrevMensual.add(REPITENCIA);		
		listaContAbordadosEntrevMensual.add(EGRESO);
		listaContAbordadosEntrevMensual.add(DISENIOPLANIFICACION);
		listaContAbordadosEntrevMensual.add(IMPLEMENESTRATEGIA);
		listaContAbordadosEntrevMensual.add(REUNIONDIRECTIVOS);
		listaContAbordadosEntrevMensual.add(REUNIONEQUIPO);
		listaContAbordadosEntrevMensual.add(OBSERCLASES);
		listaContAbordadosEntrevMensual.add(CAPACITACION);
		listaContAbordadosEntrevMensual.add(INDICADORES);
		listaContAbordadosEntrevMensual.add(JORNADAINSTITUCIONAL);		
		return listaContAbordadosEntrevMensual;
	}
}
