package com.cimientos.intranet.enumerativos.entrevista;

import java.security.InvalidParameterException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.cimientos.intranet.utils.GustosTiempoLibreOrdenadoPorValor;
import org.cimientos.intranet.utils.PropositoAnioOrdenadoPorValor;

public enum PropositoAnioComienza {
	
	MASTIEMPOESTUDIO(1,"Dedicarle m�s tiempo al estudio"),
	NOLLEVARMEMATERIAS(2,"No llevarme materias"),
	PORTARMEBIENCLASE(3,"Portarme mejor en clase"),
	PRESTARMASATENCIO(4,"Prestar m�s atenci�n en clase"),
	PARTICIPARENCLASE(5,"Participar m�s activamente en clase"),
	CARPETAORDENADA(6,"Mantener mi carpeta ordenada"),
	PREGUNTARENCLASE(7,"Preguntar en clase cada vez que no entiendo algo"),
	CLASESPARTICULARES(8,"Acudir a clases particulares en las materias que m�s me cuestan"),
	HACERLATAREA(9,"Hacer la tarea ni bien llego a mi casa"),
	RELEERTODOSLOSDIAS(10,"Releer todos los d�as lo que me dan en la escuela"),
	BUENARELACIONCOMPA�EROS(11,"Llevarme mejor con mis compa�eros"),
	HACERMASAMIGOS(12,"Hacerme m�s amigos"),
	LEERMAS(13,"Leer m�s"),
	ESFORZARMEENMATERIAS(14,"Esforzarme m�s en la materia que m�s me cuesta"),
	MATERIASALDIA(15,"Llevar al d�a las materias"),
	CONVERSARMENOS(16,"Conversar menos en clase"),
	BUENDESEMPA�OENMATERIAS(17,"Desempe�arme bien en todas las materias"),
	SERABANDERADO(18,"Ser abanderada/o"),
	APROBARPREVIAS(19,"Aprobar las materias previas"),
	ESTRATEGIASPARAMISPARES(20,"Generar estrategias para relacionarme con mis pares"),
	COMPROMISOCONESCUELA(21,"Comprometerme m�s con la escuela"),
	RENDIMIENTOINICIOA�O(22,"Tener buen rendimiento desde comienzo de a�o"),
	ESFORZARSEDIAADIA(23,"Esforzarme d�a a d�a"),
	FINALIZARCONBUENASNOTAS(24,"Terminar el a�o con muy buenas notas"),
	NOFALTARACLASE(25,"No faltar tanto a clase"),
	CARPETASALDIA(26,"Llevar al d�a las carpetas"),
	PEDIRDEBERES(27,"Pedir las cosas que se hicieron cada vez que falto a la escuela"),
	PONERSELASPILAS(28,"Ponerme las pilas"),
	ACTIVIDADESEXTRACURRICULARES(29,"Poder continuar con las actividades extracurriculares"),
	NOCONFIARMECOMOA�OANTERIOR(30,"No confiarme como el a�o pasado, ya que no me fue tan bien"),
	OBTENERTITULO(31,"Terminar bien la escuela y obtener el t�tulo"),
	SERMASORDENADO(32,"Tratar de ser un poco m�s ordenado, este a�o"),
	CARPETASCOMPLEJASYPROLIJAS(33,"Tener carpetas completas y prolijas"),
	ORGANIZARELTIEMPO(34,"Organizar mejor mis tiempos"),
	PRODUCTIVIDADTIEMPOLIBRE(35,"Hacer cosas productivas en mi tiempo libre"),
	ESMERARSEMAS(36,"Esmerarme m�s"),
	ESTUDIARPARARENOVARBECA(37,"Estudiar para renovar la beca"),
	PONERSELASPILASPARASIEMPRE(38,"Ponerme las pilas de una vez por todas con la escuela"),
	MEJORARMATERIASCONDIFICULTAD(39,"Mejorar en las materias que tengo m�s dificultad"),
	TERMINARBIENELA�O(40,"Terminar bien el a�o escolar"),
	RENDIMIENTOA�OANTERIOR(41,"Mantener el rendimiento del a�o anterior"),
	ADAPTACIONNUEVASCIRCUNSTANCIAS(42,"Poder adaptarme a las nuevas circunstancias"),
	LOGRARCAMBIOTURNO(43,"Poder lograr el cambio de turno"),
	GANASDEESTUDIAR(44,"Mantener las ganas de estudiar"),
	RESULTADOSSIMILARESA�OANTERIOR(45,"Obtener resultados similares al a�o anterior"),
	APROVECHARNETRBOOK(46,"Aprovechar la netbook que me fue otorgada"),
	TENERBUENRENDIMIENTO(47,"Tener un buen rendimiento"),
	BUENARELACIONCONPROFESORES(48,"Llevarme bien con los profesores"),
	NODEJARESCUELAPORHIJO(49,"No dejar la escuela al nacer mi beb�"),
	ACTIVIDADPROXIMOA�O(50,"Encontrar algo que me guste hacer para el pr�ximo a�o"),
	CARRERAASEGUIR(51,"Definir la carrera que me gustar�a seguir"),
	REALIZARDEPORTE(52,"Comenzar a hacer alg�n deporte"),
	MEJORAREXPRESIONORAL(53,"Mejorar en expresi�n oral"),
	MEJORAREXPRESIONESCRITA(54,"Mejorar en expresi�n escrita"),
	COMPROMISOCONELPROGRAMA(55,"Sostener mi compromiso para con el Programa"),
	ACTITUDPOSITIVACONELESTUDIO(56,"Tener una actitud positiva hacia el estudio"),
	OBTENERBUENOSRESULTADOS(57,"Obtener buenos resultados"),
	APROBARPREVIASJULIO(58,"Aprobar las previas en julio"),
	NOMOLESTARACOMPA�EROS(59,"No molestar tanto a mis compa�eros"),
	IRATUTORIAS(60,"Ir a las tutor�as"),
	NOESPERARAQUEMEVAYAMAL(61,"No esperar a que me vaya mal, para reaccionar"),
	SERMASTOLERANTECONCOMPA�EROS(62,"Ser m�s tolerante con mis compa�eros"),
	LEVANTARNOTAS(63,"Levantar algunas notas"),
	PASARDEA�OSINLLEVARSEMATERIAS(64,"Pasar de a�o sin llevarme materias"),
	BUENDESEMPE�OENNUEVAESCUELA(65,"Que me vaya bien en la nueva escuela"),
	CONSTANTEDURANTEELA�O(66,"Ser m�s constante durante el a�o"),
	PASARDEA�O(67,"Pasar de a�o"),
	CUMPLIRPROPOSITOSPLANTEADOS(68,"Cumplir con los prop�sitos que me plant�e en las entrevistas"),
	COMENZARESTUDIANDOPARAEXAMENES(69,"Comenzar el a�o estudiando para los ex�menes"),
	NOBAJARRENDIMIENTO(70,"No bajar el rendimiento"),
	NOPERDERREGULARIDAD(71,"No perder la condici�n de alumno regular"),
	NOESTARAJUSTADOCONLASNOTAS(72,"No estar tan ajustado con las notas"),
	SUPERARTIMIDEZ(73,"Superar mi timidez para hablar con los profesores y con mis compa�eros"),
	COMENZARCURSOSDEINTERES(74,"Comenzar con los cursos de mi inter�s"),
	ESTUDIARMASPARAEVALUACIONES(75,"Estudiar m�s para las evaluaciones"),
	MEJORARPLANIFICACIONACTIVIDADES(76,"Mejorar en la planificaci�n de mis actividades"),
	APRENDERCOSASNUEVAS(77,"Aprender cosas nuevas"),
	TERMINARULTIMOA�OCONDIPLOMA(78,"Terminar el �ltimo a�o, con diploma en mano"),
	SUPERARSERESPECTOA�OANTERIOR(79,"Superarme respecto de lo que logr� el a�o pasado"),
	NODISTRAERSETANTO(80,"No distraerme tanto"),
	MEJORARLALETRA(81,"Mejorar mi letra"),
	PARTICIPARENLASREUNIONESDELPROGRAMA(82,"Participar de las reuniones del Programa Futuros Egresados"),
	ADAPTACIONESCUELAACTUAL(83,"Tratar de adaptarme a mi actual escuela"),
	ENTENDERMAS(84,"Entender m�s"),
	FORMAREQUIPOESTUDIO(85,"Formar un equipo de estudio "),
	MEJORARORTOGRAFIA(86,"Mejorar la ortograf�a"),
	NOLLEVARSEMATERIAS(87,"No volver a llevarme materias"),
	ESTUDIARENLAUNIVERSIDAD(88,"Seguir estudiando en la universidad"),
	TERMINARYCONSEGUIRTRABAJO(89,"Terminar la escuela y conseguir un trabajo"),
	OBTENERMEJORPROMEDIO(90,"Obtener el mejor promedio del curso"),
	TERMINARESCUELASECUNDARIA(91,"Terminar la escuela secundaria"),
	MANTENERBUENDIALOGO(92,"Mantener buen di�logo con las autoridades y docentes de la escuela"),
	SUPERARPROBLEMASFAMILIARES(93,"Superar los problemas familiares para continuar con buen rendimiento escolar"),
	NOTENERMATERIASBAJAS(94,"No tener ninguna materia baja"),
	NOESTUDIARDEMEMORIA(95,"Tratar de no estudiar m�s de memoria"),
	ASISTIRATODASLASENTREVISTAS(96,"Asistir a todas las entrevistas de acompa�amiento"),
	CONTARCONUNAAGENDA(97,"Contar con una agenda que me ayude en la organizaci�n"),
	NOSERTANCONTESTADOR(98,"No ser tan contestador/a"),
	ESTUDIARDURANTEELA�O(99,"Estudiar durante el a�o, para no sacrificar las vacaciones "),
	CONTROLARELCARACTER(100,"Controlar mi car�cter para no tener problemas con nadie"),
	DEDICARLEMENOSTIEMPOACOSASAJENAS(101,"Dedicarle menos tiempo a cosas ajenas a la escuela"),
	ENTREGARENTIEMPOLOSPRACTICOS(102,"Entregar los trabajos pr�cticos en tiempo y forma"),
	SERMEJORQUEELA�OANTERIOR(103,"Ser mejor que el a�o anterior"),
	NODEJARTODOPARAULTIMOMOMENTO(104,"No dejar todo para �ltimo momento"),
	DISFRUTAR(105,"Disfrutar"),
	PUNTUALIDADENLASENTREVISTAS(106,"Llegar puntual a las entrevistas de acompa�amiento"),
	SUPERARLASDIFICULTADESQUESEPRESENTAN(107,"Superar las dificultades que se me presenten"),
	CONFORMERENDIMIENTOESCOLAR(108,"Es hacer lo posible para quedarme conforme con mi rendimiento escolar"),
	EVITARACUMULACIONACTIVIDADES(109,"Evitar la acumulaci�n de actividades escolares sin realizar"),
	CUMPLIRCONLOMEPROPONGO(110,"Cumplir con lo que me propongo"),
	SERMASCREATIVO(111,"Ser m�s creativa/o"),
	SERMEJORCOMPA�ERO(112,"Ser mejor compa�ero/a"),
	VALORARLOQUETENGO(113,"Valorar lo que tengo"),
	LLEGARAHORARIOESCUELA(114,"Llegar en horario a la escuela"),
	SEGUROYCONFIANZAENSIMISMO(115,"Ser m�s segura/o  y confiar m�s en m� misma/o");

	private Integer id;
	private String valor;
	
	
	private PropositoAnioComienza(Integer id, String valor) {
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
	
	
	public static PropositoAnioComienza getPropositoAnioComienza(Integer id){
		switch (id) {
		case 1:
			return 	MASTIEMPOESTUDIO;
		case 2:
			return NOLLEVARMEMATERIAS;
		case 3:
			return PORTARMEBIENCLASE;
		case 4:
			return PRESTARMASATENCIO;
		case 5:
			return PARTICIPARENCLASE;
		case 6:
			return CARPETAORDENADA;
		case 7:
			return PREGUNTARENCLASE;
		case 8:
			return CLASESPARTICULARES;
		case 9:
			return HACERLATAREA;
		case 10:
			return RELEERTODOSLOSDIAS;
		case 11:
			return BUENARELACIONCOMPA�EROS;
		case 12:
			return HACERMASAMIGOS;
		case 13:
			return LEERMAS;
		case 14:
			return ESFORZARMEENMATERIAS;
		case 15:
			return MATERIASALDIA;
		case 16:
			return CONVERSARMENOS;
		case 17:
			return BUENDESEMPA�OENMATERIAS;
		case 18:
			return SERABANDERADO;
		case 19:
			return APROBARPREVIAS;
		case 20:
			return ESTRATEGIASPARAMISPARES;
		case 21:
			return COMPROMISOCONESCUELA;
		case 22:
			return RENDIMIENTOINICIOA�O;
		case 23:
			return ESFORZARSEDIAADIA;
		case 24:
			return FINALIZARCONBUENASNOTAS;
		case 25:
			return NOFALTARACLASE;
		case 26:
			return CARPETASALDIA;
		case 27:
			return PEDIRDEBERES;
		case 28:
			return PONERSELASPILAS;
		case 29:
			return ACTIVIDADESEXTRACURRICULARES;
		case 30:
			return NOCONFIARMECOMOA�OANTERIOR;
		case 31:
			return OBTENERTITULO;
		case 32:
			return SERMASORDENADO;
		case 33:
			return CARPETASCOMPLEJASYPROLIJAS;
		case 34:
			return ORGANIZARELTIEMPO;
		case 35:
			return PRODUCTIVIDADTIEMPOLIBRE;
		case 36:	
			return ESMERARSEMAS;
		case 37:
			return ESTUDIARPARARENOVARBECA;
		case 38:
			return PONERSELASPILASPARASIEMPRE;
		case 39:
			return MEJORARMATERIASCONDIFICULTAD;
		case 40:
			return TERMINARBIENELA�O;
		case 41:
			return RENDIMIENTOA�OANTERIOR;
		case 42:
			return ADAPTACIONNUEVASCIRCUNSTANCIAS;
		case 43:
			return LOGRARCAMBIOTURNO;
		case 44:
			return GANASDEESTUDIAR;
		case 45:
			return RESULTADOSSIMILARESA�OANTERIOR;
		case 46:
			return APROVECHARNETRBOOK;
		case 47:
			return TENERBUENRENDIMIENTO;
		case 48:
			return BUENARELACIONCONPROFESORES;
		case 49:
			return NODEJARESCUELAPORHIJO;
		case 50:
			return ACTIVIDADPROXIMOA�O;
		case 51:
			return CARRERAASEGUIR;
		case 52:
			return REALIZARDEPORTE;
		case 53:
			return MEJORAREXPRESIONORAL;
		case 54:
			return MEJORAREXPRESIONESCRITA;
		case 55:
			return COMPROMISOCONELPROGRAMA;
		case 56:
			return ACTITUDPOSITIVACONELESTUDIO;
		case 57:
			return OBTENERBUENOSRESULTADOS;
		case 58:
			return APROBARPREVIASJULIO;
		case 59:
			return NOMOLESTARACOMPA�EROS;
		case 60:
			return IRATUTORIAS;
		case 61:
			return NOESPERARAQUEMEVAYAMAL;
		case 62:
			return SERMASTOLERANTECONCOMPA�EROS;
		case 63:
			return LEVANTARNOTAS;
		case 64:
			return PASARDEA�OSINLLEVARSEMATERIAS;
		case 65:
			return BUENDESEMPE�OENNUEVAESCUELA;
		case 66:
			return CONSTANTEDURANTEELA�O;
		case 67:
			return PASARDEA�O;
		case 68:
			return CUMPLIRPROPOSITOSPLANTEADOS;
		case 69:
			return COMENZARESTUDIANDOPARAEXAMENES;
		case 70:
			return NOBAJARRENDIMIENTO;
		case 71:
			return NOPERDERREGULARIDAD;
		case 72:
			return NOESTARAJUSTADOCONLASNOTAS;
		case 73:
			return SUPERARTIMIDEZ;
		case 74:
			return COMENZARCURSOSDEINTERES;
		case 75:
			return ESTUDIARMASPARAEVALUACIONES;
		case 76:
			return MEJORARPLANIFICACIONACTIVIDADES;
		case 77:
			return APRENDERCOSASNUEVAS;
		case 78:
			return TERMINARULTIMOA�OCONDIPLOMA;
		case 79:
			return SUPERARSERESPECTOA�OANTERIOR;
		case 80:
			return NODISTRAERSETANTO;
		case 81:
			return MEJORARLALETRA;
		case 82:
			return PARTICIPARENLASREUNIONESDELPROGRAMA;
		case 83:
			return ADAPTACIONESCUELAACTUAL;
		case 84:
			return ENTENDERMAS;
		case 85:
			return FORMAREQUIPOESTUDIO;
		case 86:
			return MEJORARORTOGRAFIA;
		case 87:
			return NOLLEVARSEMATERIAS;
		case 88:
			return ESTUDIARENLAUNIVERSIDAD;
		case 89:
			return TERMINARYCONSEGUIRTRABAJO;
		case 90:
			return OBTENERMEJORPROMEDIO;
		case 91:
			return TERMINARESCUELASECUNDARIA;
		case 92:
			return MANTENERBUENDIALOGO;
		case 93:
			return SUPERARPROBLEMASFAMILIARES;
		case 94:
			return NOTENERMATERIASBAJAS;
		case 95:
			return NOESTUDIARDEMEMORIA;
		case 96:
			return ASISTIRATODASLASENTREVISTAS;
		case 97:
			return CONTARCONUNAAGENDA;
		case 98:
			return NOSERTANCONTESTADOR;
		case 99:
			return ESTUDIARDURANTEELA�O;
		case 100:
			return CONTROLARELCARACTER;
		case 101:
			return DEDICARLEMENOSTIEMPOACOSASAJENAS;
		case 102:
			return ENTREGARENTIEMPOLOSPRACTICOS;
		case 103:
			return SERMEJORQUEELA�OANTERIOR;
		case 104:
			return NODEJARTODOPARAULTIMOMOMENTO;
		case 105:
			return DISFRUTAR;
		case 106:
			return PUNTUALIDADENLASENTREVISTAS;
		case 107:
			return SUPERARLASDIFICULTADESQUESEPRESENTAN;
		case 108:
			return CONFORMERENDIMIENTOESCOLAR;
		case 109:
			return EVITARACUMULACIONACTIVIDADES;
		case 110:
			return CUMPLIRCONLOMEPROPONGO;	
		case 111:
			return SERMASCREATIVO;
		case 112:
			return SERMEJORCOMPA�ERO;
		case 113:
			return VALORARLOQUETENGO;
		case 114:
			return LLEGARAHORARIOESCUELA;
		case 115:
			return SEGUROYCONFIANZAENSIMISMO;
		default:
			throw new InvalidParameterException("Prop�sito para el a�o que comienza desconocido: "
					+ id);
		}

	}
	
	public static List<PropositoAnioComienza> getPropositoAnioComienza(){
		List<PropositoAnioComienza> listProposito = Arrays.asList(values());
		Collections.sort(listProposito, new PropositoAnioOrdenadoPorValor());
		return listProposito;
	}
	
	/**
	 * Ordena alfab�ticamente los gustos en el tiempo libre
	 * 
	 * @param becas
	 */
	public void ordenarGustosTiempoLibre(List<GustosTiempoLibre> gustosTiempoLibre){
		
		Collections.sort(gustosTiempoLibre, new GustosTiempoLibreOrdenadoPorValor());
	}
}
