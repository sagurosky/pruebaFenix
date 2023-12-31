/**
 * 
 */
package org.cimientos.intranet.modelo.informe;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.JoinTable;
import javax.persistence.OneToOne;

import org.cimientos.intranet.modelo.Boletin;
import org.cimientos.intranet.modelo.pbe.evento.entrevistas.EntrevistaRenovacion;
import org.hibernate.annotations.CollectionOfElements;




import com.cimientos.intranet.enumerativos.EspacioApoyo;
import com.cimientos.intranet.enumerativos.SituacionEscolarMergeada;
import com.cimientos.intranet.enumerativos.entrevista.GustosTiempoLibre;
import com.cimientos.intranet.enumerativos.entrevista.PropositoAnioComienza;

/**
 * @author plabaronnie
 *
 */
@Entity
@DiscriminatorValue("informeis1")
public class InformeIS1 extends Informe {

	@OneToOne
	private EntrevistaRenovacion er;
	
	private Integer edad;
	
	private Integer anioEgreso;
	
	@Column(length=10000)
	private String observacionMateriasExamenes;
	
	@Column(length=10000)
	private String escolaridadCompromisoAnterior;
	
	@Column(length=10000)
	private String propositoAnioComienza;
	
	@Column(length=10000)
	private String actividadesVacaciones;
	
	@Column(length=10000)
	private String expectativasRA;
	
	@Column(length=10000)
	private String utilizacionBeca;
	
	@Enumerated(EnumType.ORDINAL)
//	private SituacionEscolar situacion;
	private SituacionEscolarMergeada situacion;		//!!!
	
	@Column(length=10000)
	private String comentarios;
	
	@OneToOne
	private Boletin boletinAnioAnterior;
	
	@Column(length=10000)
	private String informacionSuspension;
	
	@CollectionOfElements
	@JoinTable(name="proposito_anio_comienza_list_informes")
	@Enumerated(EnumType.ORDINAL)
	private List<PropositoAnioComienza> propositoAnioComienzaList;
	
	@CollectionOfElements
	@JoinTable(name="gustos_tiempo_libre_informes")
	@Enumerated(EnumType.ORDINAL)
	private List<GustosTiempoLibre> gustosTiempoLibre;
	
	@OneToOne
	private FichaPresentacion fp;
	
	
	@Column(length=1000)
	private String escuelaObservaciones;
	@Column(length=1000)
	private String escuelaEspacioApoyo;
	
	
	@CollectionOfElements
	@JoinTable(name="espacio_apoyo_escuela")
	@Enumerated(EnumType.ORDINAL)
	private List<EspacioApoyo> espacioApoyo;
	
	@Column(length=50)
	private String hsTrabajarA�o;
	
	@Column(length=100)
	private String tiempoLibre;
	
	private String observacionesExcepcion;
	

	public String getObservacionesExcepcion() {
		return observacionesExcepcion;
	}

	public void setObservacionesExcepcion(String observacionesExcepcion) {
		this.observacionesExcepcion = observacionesExcepcion;
	}

	public List<EspacioApoyo> getEspacioApoyo() {
		return espacioApoyo;
	}

	public void setEspacioApoyo(List<EspacioApoyo> espacioApoyo) {
		this.espacioApoyo = espacioApoyo;
	}

	/**
	 * @return the escolaridadCompromisoAnterior
	 */
	public String getEscolaridadCompromisoAnterior() {
		return escolaridadCompromisoAnterior;
	}

	/**
	 * @param escolaridadCompromisoAnterior the escolaridadCompromisoAnterior to set
	 */
	public void setEscolaridadCompromisoAnterior(
			String escolaridadCompromisoAnterior) {
		this.escolaridadCompromisoAnterior = escolaridadCompromisoAnterior;
	}

	/**
	 * @return the propositoAnioComienza
	 */
	public String getPropositoAnioComienza() {
		return propositoAnioComienza;
	}

	/**
	 * @param propositoAnioComienza the propositoAnioComienza to set
	 */
	public void setPropositoAnioComienza(String propositoAnioComienza) {
		this.propositoAnioComienza = propositoAnioComienza;
	}

	/**
	 * @return the er
	 */
	public EntrevistaRenovacion getEr() {
		return er;
	}

	/**
	 * @param er the er to set
	 */
	public void setEr(EntrevistaRenovacion er) {
		this.er = er;
	}

	/**
	 * @return the actividadesVacaciones
	 */
	public String getActividadesVacaciones() {
		return actividadesVacaciones;
	}

	/**
	 * @param actividadesVacaciones the actividadesVacaciones to set
	 */
	public void setActividadesVacaciones(String actividadesVacaciones) {
		this.actividadesVacaciones = actividadesVacaciones;
	}

	/**
	 * @return the expectativasRA
	 */
	public String getExpectativasRA() {
		return expectativasRA;
	}

	/**
	 * @param expectativasRA the expectativasRA to set
	 */
	public void setExpectativasRA(String expectativasRA) {
		this.expectativasRA = expectativasRA;
	}

	/**
	 * @return the utilizacionBeca
	 */
	public String getUtilizacionBeca() {
		return utilizacionBeca;
	}

	/**
	 * @param utilizacionBeca the utilizacionBeca to set
	 */
	public void setUtilizacionBeca(String utilizacionBeca) {
		this.utilizacionBeca = utilizacionBeca;
	}

	/**
	 * @return the comentarios
	 */
	public String getComentarios() {
		return comentarios;
	}

	/**
	 * @param comentarios the comentarios to set
	 */
	public void setComentarios(String comentarios) {
		this.comentarios = comentarios;
	}

	/**
	 * @return the edad
	 */
	public Integer getEdad() {
		return edad;
	}

	/**
	 * @param edad the edad to set
	 */
	public void setEdad(Integer edad) {
		this.edad = edad;
	}

	/**
	 * @return the boletinAnioAnterior
	 */
	public Boletin getBoletinAnioAnterior() {
		return boletinAnioAnterior;
	}

	/**
	 * @param boletinAnioAnterior the boletinAnioAnterior to set
	 */
	public void setBoletinAnioAnterior(Boletin boletinAnioAnterior) {
		this.boletinAnioAnterior = boletinAnioAnterior;
	}

	public String getObservacionMateriasExamenes() {
		return observacionMateriasExamenes;
	}

	public void setObservacionMateriasExamenes(String observacionMateriasExamenes) {
		this.observacionMateriasExamenes = observacionMateriasExamenes;
	}

//	public SituacionEscolar getSituacion() {
	public SituacionEscolarMergeada getSituacion() {	//!!!
		return situacion;
	}

//	public void setSituacion(SituacionEscolar situacion) {
	public void setSituacion(SituacionEscolarMergeada situacion) { //!!!
		this.situacion = situacion;
	}

	@Override
	public String dameUrlVer() {
		return "/informeIS1/verInformeIS1.do?idAlumno=";
	}

	/**
	 * @return the informacionSuspension
	 */
	public String getInformacionSuspension() {
		return informacionSuspension;
	}

	/**
	 * @param informacionSuspension the informacionSuspension to set
	 */
	public void setInformacionSuspension(String informacionSuspension) {
		this.informacionSuspension = informacionSuspension;
	}

	public List<PropositoAnioComienza> getPropositoAnioComienzaList() {
		return propositoAnioComienzaList;
	}

	public void setPropositoAnioComienzaList(
			List<PropositoAnioComienza> propositoAnioComienzaList) {
		this.propositoAnioComienzaList = propositoAnioComienzaList;
	}

	public List<GustosTiempoLibre> getGustosTiempoLibre() {
		return gustosTiempoLibre;
	}

	public void setGustosTiempoLibre(List<GustosTiempoLibre> gustosTiempoLibre) {
		this.gustosTiempoLibre = gustosTiempoLibre;
	}


	public String getPropositoAnioComienzaListString(){
		StringBuffer valor = new StringBuffer("");
		if(!this.getPropositoAnioComienzaList().isEmpty()){
			for (PropositoAnioComienza proposito : this.getPropositoAnioComienzaList()) {
				valor.append( proposito.getValor().toLowerCase() + ", ");			
			}
			valor.replace(0, propositoAnioComienzaList.get(0).getValor().length(), propositoAnioComienzaList.get(0).getValor());		
			valor.deleteCharAt(valor.lastIndexOf(","));
			valor.deleteCharAt(valor.length() - 1);
			valor.append(".");			
		}
		return valor.toString();
	}	
	
	public String getGustosTiempoLibreString(){
		StringBuffer valor = new StringBuffer("");
		//if(!this.getPropositoAnioComienzaList().isEmpty()){
			for (GustosTiempoLibre gusto : this.getGustosTiempoLibre()) {
				valor.append( gusto.getValor().toLowerCase() + ", ");			
			}
			valor.replace(0, gustosTiempoLibre.get(0).getValor().length(), gustosTiempoLibre.get(0).getValor());		
			valor.deleteCharAt(valor.lastIndexOf(","));
			valor.deleteCharAt(valor.length() - 1);
			valor.append(".");			
		//}
		return valor.toString();
	}

	public FichaPresentacion getFp() {
		return fp;
	}

	public void setFp(FichaPresentacion fp) {
		this.fp = fp;
	}

	public Integer getAnioEgreso() {
		
		Long aux=0L;
		String aux1="";		
		Boolean aux2=false;
		Integer aux3=0;
		aux=er.getPerfilAlumno().getId(); // 1580
		aux1=er.getPerfilAlumno().getEscuela().getZonaCimientos().getEae(); //6/6
		aux2=er.getPerfilAlumno().getAnioAdicional();  // NO
		aux3=Integer.parseInt(er.getPerfilAlumno().getBeca().getCiclo().getNombre());
		if (aux1.equals("6/6")){
			if(aux2==true){
				aux3=Integer.parseInt(er.getPerfilAlumno().getBeca().getCiclo().getNombre())+14-er.getPerfilAlumno().getAnioEscolar().getId()+1;
			}else{
				aux3=Integer.parseInt(er.getPerfilAlumno().getBeca().getCiclo().getNombre())+14-er.getPerfilAlumno().getAnioEscolar().getId();
			}
		}
		if (aux1.equals("7/5")){
			if(aux2==true){
				aux3=Integer.parseInt(er.getPerfilAlumno().getBeca().getCiclo().getNombre())+13-er.getPerfilAlumno().getAnioEscolar().getId()+1;
			}else{
				aux3=Integer.parseInt(er.getPerfilAlumno().getBeca().getCiclo().getNombre())+13-er.getPerfilAlumno().getAnioEscolar().getId();
			}
		}
		anioEgreso=aux3;
		//System.out.println(anioEgreso);
		return anioEgreso;
	}

	public void setAnioEgreso(Integer anioEgreso) {
		this.anioEgreso = anioEgreso;
	}

	public String getEscuelaObservaciones() {
		return escuelaObservaciones;
	}

	public void setEscuelaObservaciones(String escuelaObservaciones) {
		this.escuelaObservaciones = escuelaObservaciones;
	}

	public String getEscuelaEspacioApoyo() {
		return escuelaEspacioApoyo;
	}

	public void setEscuelaEspacioApoyo(String escuelaEspacioApoyo) {
		this.escuelaEspacioApoyo = escuelaEspacioApoyo;
	}

	public String getHsTrabajarA�o() {
		return hsTrabajarA�o;
	}

	public void setHsTrabajarA�o(String hsTrabajarA�o) {
		this.hsTrabajarA�o = hsTrabajarA�o;
	}

	public String getTiempoLibre() {
		return tiempoLibre;
	}

	public void setTiempoLibre(String tiempoLibre) {
		this.tiempoLibre = tiempoLibre;
	}
	
	
	
	
	
}
