package com.cimientos.intranet.enumerativos;

import java.io.Serializable;
import java.security.InvalidParameterException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public enum AnioEscolar implements Serializable{
	
	INICIAL			(1	,"Nivel Inicial"),
	PRIMERO_PRIM	(2	,"1� primaria"),
	SEGUNDO_PRIM	(3	,"2� primaria"),
	TERCERO_PRIM	(4	,"3� primaria"),
	CUARTO_PRIM		(5	,"4� primaria"),
	QUINTO_PRIM		(6	,"5� primaria"),
	SEXTO_PRIM		(7	,"6� primaria"),
	SEPTIMO_PRIM	(8	,"7� primaria"),
	PRIMERO_SEC		(9	,"1� secundaria"),
	SEGUNDO_SEC		(10	,"2� secundaria"),
	TERCERO_SEC		(11	,"3� secundaria"),
	CUARTO_SEC		(12	,"4� secundaria"),
	QUINTO_SEC		(13	,"5� secundaria"),
	SEXTO_SEC		(14	,"6� secundaria"),
	SEPTIMO_SEC		(15	,"7� t�cnica"),
	RECIBIDO		(16	,"-");	
	
	private Integer id;
	private String valor;
	
	
	private AnioEscolar(Integer id, String valor) {
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

	public static List<AnioEscolar> getAniosEscolares(List<Integer> ids){
		ArrayList<AnioEscolar> valor = new ArrayList<AnioEscolar>();
		
		for (Integer id: ids)
			valor.add(AnioEscolar.getAnioEscolar(id));
		
		return valor;
	}
	
	public static AnioEscolar getAnioEscolar(Integer id){
		switch (id) {
		case 1:
			return INICIAL;
		case 2:
			return PRIMERO_PRIM;
		case 3:
			return SEGUNDO_PRIM;
		case 4:
			return TERCERO_PRIM;
		case 5:
			return CUARTO_PRIM;
		case 6:
			return QUINTO_PRIM;
		case 7:
			return SEXTO_PRIM;
		case 8:
			return SEPTIMO_PRIM; 
		case 9:
			return PRIMERO_SEC;
		case 10:
			return SEGUNDO_SEC;
		case 11:
			return TERCERO_SEC;
		case 12:
			return CUARTO_SEC;
		case 13:
			return QUINTO_SEC;
		case 14:
			return SEXTO_SEC;
		case 15:
			return SEPTIMO_SEC;
		case 16:
			return RECIBIDO;
			
		default:
			throw new InvalidParameterException("Evaluacion de A�o escolar desconocido: "
					+ id);
		}
	}


	public static List<AnioEscolar> getAnioEscolares() {
		return Arrays.asList(values());
	}
	
	/**
	 * Son todos los a�os escolares menos el "-"
	 * @return
	 */
	public static List<AnioEscolar> getAnioEscolaresActivos() {
		return Arrays.asList(INICIAL,PRIMERO_PRIM,SEGUNDO_PRIM,TERCERO_PRIM,CUARTO_PRIM,QUINTO_PRIM,
				SEXTO_PRIM,SEPTIMO_PRIM,PRIMERO_SEC,SEGUNDO_SEC,TERCERO_SEC,CUARTO_SEC,QUINTO_SEC,SEXTO_SEC,SEPTIMO_SEC);		
	}
}
