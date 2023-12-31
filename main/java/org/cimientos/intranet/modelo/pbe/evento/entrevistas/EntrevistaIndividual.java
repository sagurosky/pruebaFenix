package org.cimientos.intranet.modelo.pbe.evento.entrevistas;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import org.cimientos.intranet.modelo.Materia;
import org.cimientos.intranet.modelo.Parametro;
import org.cimientos.intranet.modelo.Periodo;
import org.cimientos.intranet.modelo.escuela.Escuela;
import org.cimientos.intranet.modelo.perfil.PerfilAlumno;
import org.cimientos.intranet.modelo.perfilPadrino.PerfilPadrino;
import org.cimientos.intranet.utils.Formateador;
import org.hibernate.annotations.CollectionOfElements;

import com.cimientos.intranet.dto.PadrinoDTO;
import com.cimientos.intranet.enumerativos.AnioEscolar;
import com.cimientos.intranet.enumerativos.SituacionEscolarMergeada;
import com.cimientos.intranet.enumerativos.entrevista.Compromiso;
import com.cimientos.intranet.enumerativos.entrevista.ContenidosAbordados;
import com.cimientos.intranet.enumerativos.entrevista.ContenidosTrabajarEnElAnio;
import com.cimientos.intranet.enumerativos.entrevista.DetalleGastos;
import com.cimientos.intranet.enumerativos.entrevista.EntrevistaReprogramada;
import com.cimientos.intranet.enumerativos.entrevista.EstrategiaComplementaria;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionCobroBeca;
import com.cimientos.intranet.enumerativos.entrevista.EvaluacionRenovacionMergeada;
import com.cimientos.intranet.enumerativos.entrevista.MotivoAusencia;
import com.cimientos.intranet.enumerativos.entrevista.MotivoCesacion;
import com.cimientos.intranet.enumerativos.entrevista.MotivoNoRenovacion;
import com.cimientos.intranet.enumerativos.entrevista.MotivoSuspension;
import com.cimientos.intranet.enumerativos.entrevista.Opciones;
import com.cimientos.intranet.enumerativos.entrevista.SituacionCrisis;
import com.cimientos.intranet.enumerativos.entrevista.SituacionRiesgoEscolar;
import com.cimientos.intranet.enumerativos.entrevista.TipoEntrevista;
import com.googlecode.ehcache.annotations.Cacheable;

@Entity
@DiscriminatorValue("individual")
public class EntrevistaIndividual extends Entrevista{

	
	@CollectionOfElements
	@JoinTable(name="contenidos_trabajar_en_el_anio")
	@Enumerated(EnumType.ORDINAL)
	private List<ContenidosTrabajarEnElAnio> contenidosTrabajarEnElAnio;
	
	@OneToOne
	private PerfilAlumno perfilAlumno;
	
	@OneToOne
	@JoinColumn(name = "entrevistaGrupal_id")
	private EntrevistaGrupal entrevistaGrupal;
	
	private Date fechaAltaBeca;

	@OneToOne
	private Periodo periodoDePago;
	
	private boolean participoBecado;
	
	@Enumerated(EnumType.ORDINAL)
	private MotivoAusencia motivoAusencia;
	
	@Column(length=10000)
	private String otroMotivoAusencia;
	
	@Enumerated(EnumType.ORDINAL)
	private MotivoNoRenovacion motivoNoRenovacion;

	@Enumerated(EnumType.ORDINAL)
	private Opciones informeProfesores;
	
	
		
	public boolean isRaNoConvocado() {
		return raNoConvocado;
	}

	public void setRaNoConvocado(boolean raNoConvocado) {
		this.raNoConvocado = raNoConvocado;
	}


	@Enumerated(EnumType.ORDINAL)
	private Opciones certificadoAsistencia;
	
	private Float cantidadInasistencias;
	
	@Column(length=10000)
	private String motivoInasistencia;
	
	@CollectionOfElements
	@JoinTable(name="detalle_gastos")
	@Enumerated(EnumType.ORDINAL)
	private List<DetalleGastos> detalleGastos;
	
	private boolean materialCompleto;
	
	private boolean participoRA;  //Responsable Adulto
	
	private boolean raNoConvocado;  //RA No convocado
	
	private Boolean excepcion;
	
	@Column(length=1000)
	private String observacionesExcepcion;
	
	@Column(length=1000)
	private String motivoExcepcion;
	
	
	
	public Boolean getExcepcion() {
		return excepcion;
	}
	
	

	public void setExcepcion(Boolean excepcion) {
		this.excepcion = excepcion;
	}


	@Enumerated(EnumType.ORDINAL)
	private MotivoAusencia motivoAusenciaRA;
	
	@Column(length=10000)
	private String otroMotivoAusenciaRA;
	
	private String materia;
		
	@OneToOne
	private Parametro modalidad;
	
	@Column(length=10000)
	private String obsMateriasPrevias;
	
	@Enumerated(EnumType.ORDINAL)
	private Opciones carpeta;
	
	@Enumerated(EnumType.ORDINAL)
	private Opciones cuadernoComunicados;
	
	@Enumerated(EnumType.ORDINAL)
	private Opciones certificadoAlumnoRegular;
	
	@Enumerated(EnumType.ORDINAL)
	private Opciones boletin; 
	
	@Enumerated(EnumType.ORDINAL)
	private Opciones fotocipiaBoletin; 
	
	@Enumerated(EnumType.ORDINAL)
	private Opciones firmaActaCompromiso;
	
	@Enumerated(EnumType.ORDINAL)
	private Opciones firmaAutorizacionCierreCaja;
	
	@Enumerated(EnumType.ORDINAL)
	private Opciones firmaAutorizacionImagen;
	
	@Column(length=10000)
	private String proposito;
	
	@Enumerated(EnumType.ORDINAL)
	private Compromiso compromisoRA; // Compromiso del RA con la escolaridad:
	
	@CollectionOfElements
	@JoinTable(name="estrategia_complementaria")
	@Enumerated(EnumType.ORDINAL)
	private List<EstrategiaComplementaria> estrategiaComp; // Recomendaci�n estrategia complementaria
	
	@CollectionOfElements
	@JoinTable(name="contenidos_abordados")
	@Enumerated(EnumType.ORDINAL)
	private List<ContenidosAbordados> contenidosAbordados;
	
	@CollectionOfElements(targetElement = SituacionCrisis.class)
	@JoinTable(name="situacion_crisis", joinColumns = @JoinColumn(name = "id_entrevista"))
	@Column(name = "situacion", nullable = false)
	@Enumerated(EnumType.ORDINAL)
	private List<SituacionCrisis> situacionCrisis;
	
	
	@CollectionOfElements(targetElement = SituacionRiesgoEscolar.class)
	@JoinTable(name="situacion_riesgo_escolar", joinColumns = @JoinColumn(name = "id_entrevista"))
	@Column(name = "situacion", nullable = false)
	@Enumerated(EnumType.ORDINAL)
	private List<SituacionRiesgoEscolar> situacionRiesgoEscolar;
	
	public List<SituacionRiesgoEscolar> getSituacionRiesgoEscolar() {
		return situacionRiesgoEscolar;
	}

	public void setSituacionRiesgoEscolar(
			List<SituacionRiesgoEscolar> situacionRiesgoEscolar) {
		this.situacionRiesgoEscolar = situacionRiesgoEscolar;
	}


	@Enumerated(EnumType.ORDINAL)
	private EntrevistaReprogramada entrevistaReprogramada;
	
	@Column(length=10000)
	private String logros;
	
	@Column(length=10000)
	private String dificultades;
	
	@Column(length=10000)
	private String materialProfesores;
	
//	private String autoevaluacionBecado;
	
	@Column(length=10000)
	private String resultadoAno;
	
	private boolean cambioEscuela;
//	
//	private String modilidadProximoAno;
	
//	private String proyeccion; // Proyecci�n a�o pr�ximo para quienes finalizan participaci�n PBE
	
	@Column(length=10000)
	private String evaluacionRenovacionBeca;
	
	@Column(length=10000)
	private String evolucionMesAnterior;
	
	@Column(length=10000)
	private String objetivosAno;
	
	@Column(length=10000)
	private String expectativasRA;
	
	@CollectionOfElements
	@JoinTable(name="destino_dinero")
	@Enumerated(EnumType.ORDINAL)
	private List<DetalleGastos> destinoDinero;
	
	@Column(length=10000)
	private String observaciones;
	
	private Date proximaEntrevista;
	
	@OneToOne
	private Escuela lugarProximaEntrevista;
	
	private String horaProxEntrevista; 
	
	private boolean entregaMaterial;
	
	@Enumerated(EnumType.ORDINAL)
	private MotivoSuspension motivoSuspension;
	
	@Enumerated(EnumType.ORDINAL)
	private MotivoCesacion motivoCesacion;
	
	@Enumerated(EnumType.ORDINAL)
	private EvaluacionCobroBeca evaluacionCobroBeca;
	
	@Enumerated(EnumType.ORDINAL)
	private TipoEntrevista tipoEntrevista;
	
	@Enumerated(EnumType.ORDINAL)
	private AnioEscolar anioEscolar;
	
	@OneToOne
	private Escuela escuelaAlumno;
	
	@ManyToOne
	private Materia materiaBoletin;
	
	@Column(length=10000)
	private String comentariosRevision;
	
	@Enumerated(EnumType.ORDINAL)
	private EvaluacionRenovacionMergeada evaluacionRenovacionMergeada;

	@Enumerated(EnumType.ORDINAL)
	private SituacionEscolarMergeada situacionEscolarMergeada;
	
	@Column(length=200)
	private String dirMail;
	
	@Column(length=200)
	private String facebook;
	
	@Column(length=100)
	private String telFijo;
	
	@Column(length=100)
	private String celular;
	
	@Column(length=2)
	private String corroboradoBoletin;
	
	@Column(length=10000)
	private String objetivoEncuentro;
	
	@Column(length=100)
	private String ase2020;
	
	@Column(length=2)
	private String av;
	
	@Column(length=10000)
	private String iamp;
	
	
	@Column(length=10000)
	private String alo;
	
	//2022
	@Column(length=10000)
	private String tarang;
	@Column(length=10000)
	private String paa;
	@Column(length=20)
	private String vtepa;
	@Column(length=20)
	private String vtepb;
	@Column(length=20)
	private String vtepc;
	@Column(length=20)
	private String vtepd;
	@Column(length=20)
	private String vtepe;
	@Column(length=20)
	private String vtepf;
	@Column(length=20)
	private String vtepg;
	@Column(length=20)
	private String vteph;
	@Column(length=20)
	private String vtepi;
	@Column(length=10000)
	private String iatarni;
	@Column(length=10000)
	private String mp;
	@Column(length=20)
	private String sus;
	@Column(length=10000)
	private String ige;
	
	
	
	
	
	public String getTarang() {
		return tarang;
	}

	public void setTarang(String tarang) {
		this.tarang = tarang;
	}

	public String getPaa() {
		return paa;
	}

	public void setPaa(String paa) {
		this.paa = paa;
	}

	public String getVtepa() {
		return vtepa;
	}

	public void setVtepa(String vtepa) {
		this.vtepa = vtepa;
	}

	public String getVtepb() {
		return vtepb;
	}

	public void setVtepb(String vtepb) {
		this.vtepb = vtepb;
	}

	public String getVtepc() {
		return vtepc;
	}

	public void setVtepc(String vtepc) {
		this.vtepc = vtepc;
	}

	public String getVtepd() {
		return vtepd;
	}

	public void setVtepd(String vtepd) {
		this.vtepd = vtepd;
	}

	public String getVtepe() {
		return vtepe;
	}

	public void setVtepe(String vtepe) {
		this.vtepe = vtepe;
	}

	public String getVtepf() {
		return vtepf;
	}

	public void setVtepf(String vtepf) {
		this.vtepf = vtepf;
	}

	public String getVtepg() {
		return vtepg;
	}

	public void setVtepg(String vtepg) {
		this.vtepg = vtepg;
	}

	public String getVteph() {
		return vteph;
	}

	public void setVteph(String vteph) {
		this.vteph = vteph;
	}

	public String getVtepi() {
		return vtepi;
	}

	public void setVtepi(String vtepi) {
		this.vtepi = vtepi;
	}

	public String getIatarni() {
		return iatarni;
	}

	public void setIatarni(String iatarni) {
		this.iatarni = iatarni;
	}

	public String getMp() {
		return mp;
	}

	public void setMp(String mp) {
		this.mp = mp;
	}

	public String getSus() {
		return sus;
	}

	public void setSus(String sus) {
		this.sus = sus;
	}

	public String getIge() {
		return ige;
	}

	public void setIge(String ige) {
		this.ige = ige;
	}

	public String getAlo() {
		return alo;
	}

	public void setAlo(String alo) {
		this.alo = alo;
	}

	public String getIamp() {
		return iamp;
	}

	public void setIamp(String iamp) {
		this.iamp = iamp;
	}

	public String getAv() {
		return av;
	}

	public void setAv(String av) {
		this.av = av;
	}

	public String getAse2020() {
		return ase2020;
	}

	public void setAse2020(String ase2020) {
		this.ase2020 = ase2020;
	}

	public String getObjetivoEncuentro() {
		return objetivoEncuentro;
	}

	public void setObjetivoEncuentro(String objetivoEncuentro) {
		this.objetivoEncuentro = objetivoEncuentro;
	}

	public String getDirMail() {
		return dirMail;
	}

	public void setDirMail(String dirMail) {
		this.dirMail = dirMail;
	}

	public String getFacebook() {
		return facebook;
	}

	public void setFacebook(String facebook) {
		this.facebook = facebook;
	}

	public String getTelFijo() {
		return telFijo;
	}

	public void setTelFijo(String telFijo) {
		this.telFijo = telFijo;
	}

	public String getCelular() {
		return celular;
	}

	public void setCelular(String celular) {
		this.celular = celular;
	}

	public String getCorroboradoBoletin() {
		return corroboradoBoletin;
	}

	public void setCorroboradoBoletin(String corroboradoBoletin) {
		this.corroboradoBoletin = corroboradoBoletin;
	}

	public MotivoNoRenovacion getMotivoNoRenovacion() {
		return motivoNoRenovacion;
	}

	public void setMotivoNoRenovacion(MotivoNoRenovacion motivoNoRenovacion) {
		this.motivoNoRenovacion = motivoNoRenovacion;
	}

	public SituacionEscolarMergeada getSituacionEscolarMergeada() {
		return situacionEscolarMergeada;
	}

	public void setSituacionEscolarMergeada(
			SituacionEscolarMergeada situacionEscolarMergeada) {
		this.situacionEscolarMergeada = situacionEscolarMergeada;
	}

	public EvaluacionRenovacionMergeada getEvaluacionRenovacionMergeada() {
		return evaluacionRenovacionMergeada;
	}

	public void setEvaluacionRenovacionMergeada(
			EvaluacionRenovacionMergeada evaluacionRenovacionMergeada) {
		this.evaluacionRenovacionMergeada = evaluacionRenovacionMergeada;
	}

	public Escuela getEscuelaAlumno() {
		return escuelaAlumno;
	}

	public void setEscuelaAlumno(Escuela escuelaAlumno) {
		this.escuelaAlumno = escuelaAlumno;
	}

	public AnioEscolar getAnioEscolar() {
		return anioEscolar;
	}

	public void setAnioEscolar(AnioEscolar anioEscolar) {
		this.anioEscolar = anioEscolar;
	}

	public String getObservaciones() {
		return observaciones;
	}

	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}

	public Date getProximaEntrevista() {
		return proximaEntrevista;
	}

	public void setProximaEntrevista(Date proximaEntrevista) {
		this.proximaEntrevista = proximaEntrevista;
	}

	public Escuela getLugarProximaEntrevista() {
		return lugarProximaEntrevista;
	}

	public void setLugarProximaEntrevista(Escuela lugarProximaEntrevista) {
		this.lugarProximaEntrevista = lugarProximaEntrevista;
	}

	public String getHoraProxEntrevista() {
		return horaProxEntrevista;
	}

	public void setHoraProxEntrevista(String horaProxEntrevista) {
		this.horaProxEntrevista = horaProxEntrevista;
	}

	public boolean isEntregaMaterial() {
		return entregaMaterial;
	}

	public void setEntregaMaterial(boolean entregaMaterial) {
		this.entregaMaterial = entregaMaterial;
	}

	public MotivoSuspension getMotivoSuspension() {
		return motivoSuspension;
	}

	public void setMotivoSuspension(MotivoSuspension motivoSuspension) {
		this.motivoSuspension = motivoSuspension;
	}

	public MotivoCesacion getMotivoCesacion() {
		return motivoCesacion;
	}

	public void setMotivoCesacion(MotivoCesacion motivoCesacion) {
		this.motivoCesacion = motivoCesacion;
	}

	public EvaluacionCobroBeca getEvaluacionCobroBeca() {
		return evaluacionCobroBeca;
	}

	public void setEvaluacionCobroBeca(EvaluacionCobroBeca evaluacionCobroBeca) {
		this.evaluacionCobroBeca = evaluacionCobroBeca;
	}

	public Date getFechaAltaBeca() {
		return fechaAltaBeca;
	}

	public void setFechaAltaBeca(Date fechaAltaBeca) {
		this.fechaAltaBeca = fechaAltaBeca;
	}

	public Periodo getPeriodoDePago() {
		return periodoDePago;
	}

	public void setPeriodoDePago(Periodo periodoDePago) {
		this.periodoDePago = periodoDePago;
	}


	public boolean isParticipoBecado() {
		return participoBecado;
	}

	public void setParticipoBecado(boolean participoBecado) {
		this.participoBecado = participoBecado;
	}

	public MotivoAusencia getMotivoAusencia() {
		return motivoAusencia;
	}

	public void setMotivoAusencia(MotivoAusencia motivoAusencia) {
		this.motivoAusencia = motivoAusencia;
	}

	public String getOtroMotivoAusencia() {
		return otroMotivoAusencia;
	}

	public void setOtroMotivoAusencia(String otroMotivoAusencia) {
		this.otroMotivoAusencia = otroMotivoAusencia;
	}


	public Opciones getInformeProfesores() {
		return informeProfesores;
	}

	public void setInformeProfesores(Opciones informeProfesores) {
		this.informeProfesores = informeProfesores;
	}

	public Opciones getCertificadoAsistencia() {
		return certificadoAsistencia;
	}

	public void setCertificadoAsistencia(Opciones certificadoAsistencia) {
		this.certificadoAsistencia = certificadoAsistencia;
	}

	public Float getCantidadInasistencias() {
		return cantidadInasistencias;
	}

	public void setCantidadInasistencias(Float cantidadInasistencias) {
		this.cantidadInasistencias = cantidadInasistencias;
	}



	public boolean isMaterialCompleto() {
		return materialCompleto;
	}

	public void setMaterialCompleto(boolean materialCompleto) {
		this.materialCompleto = materialCompleto;
	}

	public boolean isParticipoRA() {
		return participoRA;
	}

	public void setParticipoRA(boolean participoRA) {
		this.participoRA = participoRA;
	}

	public MotivoAusencia getMotivoAusenciaRA() {
		return motivoAusenciaRA;
	}

	public void setMotivoAusenciaRA(MotivoAusencia motivoAusenciaRA) {
		this.motivoAusenciaRA = motivoAusenciaRA;
	}

	public String getOtroMotivoAusenciaRA() {
		return otroMotivoAusenciaRA;
	}

	public void setOtroMotivoAusenciaRA(String otroMotivoAusenciaRA) {
		this.otroMotivoAusenciaRA = otroMotivoAusenciaRA;
	}



	public String getMateria() {
		return materia;
	}

	public void setMateria(String materia) {
		this.materia = materia;
	}

	public Parametro getModalidad() {
		return modalidad;
	}

	public void setModalidad(Parametro modalidad) {
		this.modalidad = modalidad;
	}



	public Opciones getCarpeta() {
		return carpeta;
	}

	public void setCarpeta(Opciones carpeta) {
		this.carpeta = carpeta;
	}

	public Opciones getCuadernoComunicados() {
		return cuadernoComunicados;
	}

	public void setCuadernoComunicados(Opciones cuadernoComunicados) {
		this.cuadernoComunicados = cuadernoComunicados;
	}

	
	public Opciones getCertificadoAlumnoRegular() {
		return certificadoAlumnoRegular;
	}

	public void setCertificadoAlumnoRegular(Opciones certificadoAlumnoRegular) {
		this.certificadoAlumnoRegular = certificadoAlumnoRegular;
	}

	public Opciones getBoletin() {
		return boletin;
	}

	public void setBoletin(Opciones boletin) {
		this.boletin = boletin;
	}

	public Opciones getFotocipiaBoletin() {
		return fotocipiaBoletin;
	}

	public void setFotocipiaBoletin(Opciones fotocipiaBoletin) {
		this.fotocipiaBoletin = fotocipiaBoletin;
	}

	public Opciones getFirmaActaCompromiso() {
		return firmaActaCompromiso;
	}

	public void setFirmaActaCompromiso(Opciones firmaActaCompromiso) {
		this.firmaActaCompromiso = firmaActaCompromiso;
	}

	public Opciones getFirmaAutorizacionCierreCaja() {
		return firmaAutorizacionCierreCaja;
	}

	public void setFirmaAutorizacionCierreCaja(Opciones firmaAutorizacionCierreCaja) {
		this.firmaAutorizacionCierreCaja = firmaAutorizacionCierreCaja;
	}

	public Opciones getFirmaAutorizacionImagen() {
		return firmaAutorizacionImagen;
	}

	public void setFirmaAutorizacionImagen(Opciones firmaAutorizacionImagen) {
		this.firmaAutorizacionImagen = firmaAutorizacionImagen;
	}

	public String getProposito() {
		return proposito;
	}

	public void setProposito(String proposito) {
		this.proposito = proposito;
	}

	public Compromiso getCompromisoRA() {
		return compromisoRA;
	}

	public void setCompromisoRA(Compromiso compromisoRA) {
		this.compromisoRA = compromisoRA;
	}

	public List<EstrategiaComplementaria> getEstrategiaComp() {
		return estrategiaComp;
	}

	public void setEstrategiaComp(List<EstrategiaComplementaria> estrategiaComp) {
		this.estrategiaComp = estrategiaComp;
	}

	public List<ContenidosAbordados> getContenidosAbordados() {
		return contenidosAbordados;
	}

	public void setContenidosAbordados(List<ContenidosAbordados> contenidosAbordados) {
		this.contenidosAbordados = contenidosAbordados;
	}

	public List<SituacionCrisis> getSituacionCrisis() {
		return situacionCrisis;
	}

	public void setSituacionCrisis(List<SituacionCrisis> situacionCrisis) {
		this.situacionCrisis = situacionCrisis;
	}

	public EntrevistaReprogramada getEntrevistaReprogramada() {
		return entrevistaReprogramada;
	}

	public void setEntrevistaReprogramada(
			EntrevistaReprogramada entrevistaReprogramada) {
		this.entrevistaReprogramada = entrevistaReprogramada;
	}

	public String getLogros() {
		return logros;
	}

	public void setLogros(String logros) {
		this.logros = logros;
	}

	public String getDificultades() {
		return dificultades;
	}

	public void setDificultades(String dificultades) {
		this.dificultades = dificultades;
	}

	public String getMaterialProfesores() {
		return materialProfesores;
	}

	public void setMaterialProfesores(String materialProfesores) {
		this.materialProfesores = materialProfesores;
	}
//
//	public String getAutoevaluacionBecado() {
//		return autoevaluacionBecado;
//	}
//
//	public void setAutoevaluacionBecado(String autoevaluacionBecado) {
//		this.autoevaluacionBecado = autoevaluacionBecado;
//	}

	public String getResultadoAno() {
		return resultadoAno;
	}

	public void setResultadoAno(String resultadoAno) {
		this.resultadoAno = resultadoAno;
	}

	public boolean isCambioEscuela() {
		return cambioEscuela;
	}

	public void setCambioEscuela(boolean cambioEscuela) {
		this.cambioEscuela = cambioEscuela;
	}

//	public String getModilidadProximoAno() {
//		return modilidadProximoAno;
//	}
//
//	public void setModilidadProximoAno(String modilidadProximoAno) {
//		this.modilidadProximoAno = modilidadProximoAno;
//	}

//	public String getProyeccion() {
//		return proyeccion;
//	}
//
//	public void setProyeccion(String proyeccion) {
//		this.proyeccion = proyeccion;
//	}

	public String getEvaluacionRenovacionBeca() {
		return evaluacionRenovacionBeca;
	}

	public void setEvaluacionRenovacionBeca(String evaluacionRenovacionBeca) {
		this.evaluacionRenovacionBeca = evaluacionRenovacionBeca;
	}

	public String getEvolucionMesAnterior() {
		return evolucionMesAnterior;
	}

	public void setEvolucionMesAnterior(String evolucionMesAnterior) {
		this.evolucionMesAnterior = evolucionMesAnterior;
	}

	public String getObjetivosAno() {
		return objetivosAno;
	}

	public void setObjetivosAno(String objetivosAno) {
		this.objetivosAno = objetivosAno;
	}

	public String getExpectativasRA() {
		return expectativasRA;
	}

	public void setExpectativasRA(String expectativasRA) {
		this.expectativasRA = expectativasRA;
	}

	public List<DetalleGastos> getDestinoDinero() {
		return destinoDinero;
	}

	public void setDestinoDinero(List<DetalleGastos> destinoDinero) {
		this.destinoDinero = destinoDinero;
	}

	public String getObsMateriasPrevias() {
		return obsMateriasPrevias;
	}

	public void setObsMateriasPrevias(String obsMateriasPrevias) {
		this.obsMateriasPrevias = obsMateriasPrevias;
	}

	public String getMotivoInasistencia() {
		return motivoInasistencia;
	}

	public void setMotivoInasistencia(String motivoInasistencia) {
		this.motivoInasistencia = motivoInasistencia;
	}

	public List<DetalleGastos> getDetalleGastos() {
		return detalleGastos;
	}

	public void setDetalleGastos(List<DetalleGastos> detalleGastos) {
		this.detalleGastos = detalleGastos;
	}

	public TipoEntrevista getTipoEntrevista() {
		return tipoEntrevista;
	}

	public void setTipoEntrevista(TipoEntrevista tipoEntrevista) {
		this.tipoEntrevista = tipoEntrevista;
	}

	@Cacheable(cacheName = "org.cimientos.intranet.modelo.perfil.PerfilAlumno")
	public PerfilAlumno getPerfilAlumno() {
		return perfilAlumno;
	}

	public void setPerfilAlumno(PerfilAlumno perfilAlumno) {
		this.perfilAlumno = perfilAlumno;
	}

	public EntrevistaGrupal getEntrevistaGrupal() {
		return entrevistaGrupal;
	}

	public void setEntrevistaGrupal(EntrevistaGrupal entrevistaGrupal) {
		this.entrevistaGrupal = entrevistaGrupal;
	}

	@Override
	public boolean esFinal() {
		return false;
	}

	/**
	 * @return the materiaBoletin
	 */
	public Materia getMateriaBoletin() {
		return materiaBoletin;
	}

	/**
	 * @param materiaBoletin the materiaBoletin to set
	 */
	public void setMateriaBoletin(Materia materiaBoletin) {
		this.materiaBoletin = materiaBoletin;
	}
	
	/**
	 * Retorna true si en una entrevista individual se cobra beca.
	 * @return
	 */
	public boolean isCobraBeca(){
		if(this.getEvaluacionCobroBeca() != null){
			return (!this.getEvaluacionCobroBeca().equals(EvaluacionCobroBeca.CESADO) && 
				!this.getEvaluacionCobroBeca().equals(EvaluacionCobroBeca.SUSPENDIDO));
		}
		return true;
	}
	

	public String getComentariosRevision() {
		return comentariosRevision;
	}

	public void setComentariosRevision(String comentariosRevision) {
		this.comentariosRevision = comentariosRevision;
	}
	
	public String getCicloLectivo() {
		return this.periodoDePago != null ? this.periodoDePago.getCiclo().getNombre() : "";
	}
	
	public String getEscuela() {
		return this.escuelaAlumno.getNombre();
	}
	
	public String getApellidoAlumno() {
		return this.perfilAlumno.getDatosPersonales().getApellido();
	}

	public String getNombreAlumno() {
		return this.perfilAlumno.getDatosPersonales().getNombre();
	}
	
	public String getZonaCimientos() {
		String zona = "";
		try {
			zona = this.escuelaAlumno.getLocalidad().getZona().getNombre();
		} catch (Exception e) {
			// TODO: handle exception
			////System.out.println("Alumno " + this.getApellidoAlumno());
		}
		return zona;
	}
	
	public String getNombreEa() {
		if(this.getEa() != null){
			return this.getEa().getDatosPersonales().getApellido() + ", " 
			+ this.getEa().getDatosPersonales().getNombre();
		}
		return "";
		
	}

	public String getResponsableRegional() {
		return this.getRr().getDatosPersonales().getApellido() + ", " 
		+ this.getRr().getDatosPersonales().getNombre();
	}
	
	public String getFormaEntrevista() {
		if(this.entrevistaGrupal != null){
			return "Grupal";
		}
		return "Individual";
	}
	
	public String getPeriodoEntrevista() {
		return this.periodoDePago != null ? this.periodoDePago.getNombre() : "";
	}
	
	public Long getIdTipoEntrevista() {
		return this.tipoEntrevista.getId().longValue();
	}
	
	public String getFechaProximaEntrevista() {
		String valor = "No aplica";
		if(!this.tipoEntrevista.equals(TipoEntrevista.FINAL) ){
			valor = this.proximaEntrevista != null? Formateador.formatearFecha( this.proximaEntrevista, "dd/MM/yyyy")
					: "";
		}
		return valor;
	}
	
	public String getValorSituacionCrisis() {
		StringBuffer valor = new StringBuffer("No aplica");
		if(this.tipoEntrevista.equals(TipoEntrevista.MENSUAL)){
			valor = new StringBuffer();
			if(!this.situacionCrisis.isEmpty()){
				for (SituacionCrisis crisis : this.situacionCrisis) {
					valor.append( crisis.getValor() + ", ");
				}
				valor.deleteCharAt(valor.lastIndexOf(","));
			}
		}
		return valor.toString();
	}
	
	public String getValorEvaluacionCobroBeca() {
		return this.evaluacionCobroBeca != null ? this.evaluacionCobroBeca.getValor() :"";
	}
	
	public String getPadrino() {
		return this.getExportacionEspecial().getPadrino();
	}
	
	
	public String getIdPlataforma() {
        if(this.perfilAlumno.getBeca() != null)
                if(this.perfilAlumno.getBeca().getPadrino() != null)
                        if(this.perfilAlumno.getBeca().getPadrino().getNroCtesPlataformaContable() != null)
                                return this.perfilAlumno.getBeca().getPadrino().getNroCtesPlataformaContable().toString();
        return "";
	}

	public String getObservacionesExcepcion() {
		return observacionesExcepcion;
	}

	public void setObservacionesExcepcion(String observacionesExcepcion) {
		this.observacionesExcepcion = observacionesExcepcion;
	}

	public String getMotivoExcepcion() {
		return motivoExcepcion;
	}

	public void setMotivoExcepcion(String motivoExcepcion) {
		this.motivoExcepcion = motivoExcepcion;
	}

	public List<ContenidosTrabajarEnElAnio> getContenidosTrabajarEnElAnio() {
		return contenidosTrabajarEnElAnio;
	}

	public void setContenidosTrabajarEnElAnio(
			List<ContenidosTrabajarEnElAnio> contenidosTrabajarEnElAnio) {
		this.contenidosTrabajarEnElAnio = contenidosTrabajarEnElAnio;
	}

	
	
	
	
}
