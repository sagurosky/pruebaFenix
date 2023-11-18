package com.cimientos.intranet.dto;

import java.util.ArrayList;
import java.util.List;

import org.cimientos.intranet.modelo.Boletin;
import org.cimientos.intranet.web.controller.MateriaPreviaDTO;




public class ReporteInformeICDTO{

	private Long id;
	
	private String tipoInforme;
	
	private String cicloActual;
	
	private String estadoInforme;	
	
	private String fechaUltimoCambioEstado;
	
	private String fechaEnvio;
	
	private String tipoPadrino;
	
	private String padrino;
	
	private String contacto;
	
	private String mail;
	
	private Long idAlumno; 	
	
	private String apellidoAlumno;
	
	private String nombreAlumno;	
	
	private String dni;
	
	private String fechaNacimiento;
	
	private String edad;
	
	private String localidad;
	
	private String anioEscolar;
	
	private String anioAdicional;
	
	private String escuelaNombre;
	
	private String escuelaLocalidad;
	
	private String responsable;
	
	private String vinculo;
	
	private String fechaPBE;
	
	private String rr;
	
	private String ea;
	
	private String mesCesacion;
	
	private String motivoCesacion;
	
	private String comentariosCesacion;
	
	private String suspensionesDeBeca;
	
	private String destinoDineroBeca;
	
	private String observacionesGenerales;
	
	private String compromisoAlumnoEscolaridad;
	
	private String esfuerzo;
	
	private String conducta;
	
	private String compromisoRAEscolaridad;
	
	private String asistioBecadoEntrevista;
	
	private String presentacionMaterial;
	
	private String compromisoAlumnoPrograma;
	
	private String asistenciaRAEntrevista;
	
	private String compromisoRAPrograma;
	
	private String actividadAcompanamiento;
	
	private List<MateriaDTO> materias = new ArrayList<MateriaDTO>();
	
	private List<Boletin> boletin = new ArrayList<Boletin>();
	
	private String conductaB;
	
	private String diasHabiles;
	
	private Float diasHabilesFinales;
	
	private String inasistencias;
	
	private Long nroCtesPlataformaContable;
	
	private String materiasAprobadas;
	
	private String materiasDesaprobadas;
	
	private Boolean datosEstimadosCheck;
	
	private Float inasistencias2;
	
	private String fechaReincorporacionPBE;	
	
	private String fechaUltimaModificacion;
	
	private String eae;
	
	
	
	
	public String getEae() {
		return eae;
	}

	public void setEae(String eae) {
		this.eae = eae;
	}

	public String getFechaUltimaModificacion() {
		return fechaUltimaModificacion;
	}

	public void setFechaUltimaModificacion(String fechaUltimaModificacion) {
		this.fechaUltimaModificacion = fechaUltimaModificacion;
	}
	
	
	public Float getInasistencias2() {
		return inasistencias2;
	}

	public void setInasistencias2(Float inasistencias2) {
		this.inasistencias2 = inasistencias2;
	}

	public Boolean getDatosEstimadosCheck() {
		return datosEstimadosCheck;
	}

	public void setDatosEstimadosCheck(Boolean datosEstimadosCheck) {
		this.datosEstimadosCheck = datosEstimadosCheck;
	}

	public String getMateriasAprobadas() {
		return materiasAprobadas;
	}

	public void setMateriasAprobadas(String materiasAprobadas) {
		this.materiasAprobadas = materiasAprobadas;
	}

	public String getMateriasDesaprobadas() {
		return materiasDesaprobadas;
	}

	public void setMateriasDesaprobadas(String materiasDesaprobadas) {
		this.materiasDesaprobadas = materiasDesaprobadas;
	}

	private List<MateriaPreviaDTO> materiasPrevias = new ArrayList<MateriaPreviaDTO>();
	
	private List<MateriaDTO> previas = new ArrayList<MateriaDTO>();
	
	
	public List<MateriaDTO> getPreviasDTO() {
		return previas;
	}

	public void setPreviasDTO(List<MateriaDTO> previas) {
		this.previas = previas;
	} 
	
	public List<MateriaPreviaDTO> getMateriasPrevias() {
		return materiasPrevias;
	}

	public void setMateriasPrevias(List<MateriaPreviaDTO> materiasPrevias) {
		this.materiasPrevias = materiasPrevias;
	}

	public List<MateriaDTO> getMaterias() {
		return materias;
	}

	public void setMaterias(List<MateriaDTO> materias) {
		this.materias = materias;
	}

	public String getConductaB() {
		return conductaB;
	}

	public void setConductaB(String conductaB) {
		this.conductaB = conductaB;
	}

	public String getDiasHabiles() {
		return diasHabiles;
	}

	public void setDiasHabiles(String diasHabiles) {
		this.diasHabiles = diasHabiles;
	}

	public Float getDiasHabilesFinales() {
		return diasHabilesFinales;
	}

	public void setDiasHabilesFinales(Float diasHabilesFinales) {
		this.diasHabilesFinales = diasHabilesFinales;
	}

	public String getInasistencias() {
		return inasistencias;
	}

	public void setInasistencias(String inasistencias) {
		this.inasistencias = inasistencias;
	}

	public Float getInasistencasFinales() {
		return inasistencasFinales;
	}

	public void setInasistencasFinales(Float inasistencasFinales) {
		this.inasistencasFinales = inasistencasFinales;
	}

	private Float inasistencasFinales;
	
	
	
	
	
	public List<Boletin> getBoletin() {
		return boletin;
	}

	public void setBoletin(List<Boletin> boletin) {
		this.boletin = boletin;
	}

	public String getCompromisoAlumnoEscolaridad() {
		return compromisoAlumnoEscolaridad;
	}

	public void setCompromisoAlumnoEscolaridad(String compromisoAlumnoEscolaridad) {
		this.compromisoAlumnoEscolaridad = compromisoAlumnoEscolaridad;
	}

	public String getObservacionesGenerales() {
		return observacionesGenerales;
	}

	public void setObservacionesGenerales(String observacionesGenerales) {
		this.observacionesGenerales = observacionesGenerales;
	}

	public List<MateriaDTO> getMateriasDto() {
		return materias;
	}

	public void setMateriasDto(List<MateriaDTO> materias) {
		this.materias = materias;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTipoInforme() {
		return tipoInforme;
	}

	public void setTipoInforme(String tipoInforme) {
		this.tipoInforme = tipoInforme;
	}

	public String getCicloActual() {
		return cicloActual;
	}

	public void setCicloActual(String cicloActual) {
		this.cicloActual = cicloActual;
	}

	public String getEstadoInforme() {
		return estadoInforme;
	}

	public void setEstadoInforme(String estadoInforme) {
		this.estadoInforme = estadoInforme;
	}

	public String getFechaUltimoCambioEstado() {
		return fechaUltimoCambioEstado;
	}

	public void setFechaUltimoCambioEstado(String fechaUltimoCambioEstado) {
		this.fechaUltimoCambioEstado = fechaUltimoCambioEstado;
	}

	public String getFechaEnvio() {
		return fechaEnvio;
	}

	public void setFechaEnvio(String fechaEnvio) {
		this.fechaEnvio = fechaEnvio;
	}

	public String getTipoPadrino() {
		return tipoPadrino;
	}

	public void setTipoPadrino(String tipoPadrino) {
		this.tipoPadrino = tipoPadrino;
	}

	public String getPadrino() {
		return padrino;
	}

	public void setPadrino(String padrino) {
		this.padrino = padrino;
	}

	public String getContacto() {
		return contacto;
	}

	public void setContacto(String contacto) {
		this.contacto = contacto;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public Long getIdAlumno() {
		return idAlumno;
	}

	public void setIdAlumno(Long idAlumno) {
		this.idAlumno = idAlumno;
	}

	public String getApellidoAlumno() {
		return apellidoAlumno;
	}

	public void setApellidoAlumno(String apellidoAlumno) {
		this.apellidoAlumno = apellidoAlumno;
	}

	public String getNombreAlumno() {
		return nombreAlumno;
	}

	public void setNombreAlumno(String nombreAlumno) {
		this.nombreAlumno = nombreAlumno;
	}

	public String getDni() {
		return dni;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}

	public String getFechaNacimiento() {
		return fechaNacimiento;
	}

	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}

	public String getEdad() {
		return edad;
	}

	public void setEdad(String edad) {
		this.edad = edad;
	}

	public String getLocalidad() {
		return localidad;
	}

	public void setLocalidad(String localidad) {
		this.localidad = localidad;
	}

	public String getAnioEscolar() {
		return anioEscolar;
	}

	public void setAnioEscolar(String anioEscolar) {
		this.anioEscolar = anioEscolar;
	}

	public String getAnioAdicional() {
		return anioAdicional;
	}

	public void setAnioAdicional(String anioAdicional) {
		this.anioAdicional = anioAdicional;
	}

	public String getEscuelaNombre() {
		return escuelaNombre;
	}

	public void setEscuelaNombre(String escuelaNombre) {
		this.escuelaNombre = escuelaNombre;
	}

	public String getEscuelaLocalidad() {
		return escuelaLocalidad;
	}

	public void setEscuelaLocalidad(String escuelaLocalidad) {
		this.escuelaLocalidad = escuelaLocalidad;
	}

	public String getResponsable() {
		return responsable;
	}

	public void setResponsable(String responsable) {
		this.responsable = responsable;
	}

	public String getVinculo() {
		return vinculo;
	}

	public void setVinculo(String vinculo) {
		this.vinculo = vinculo;
	}

	public String getFechaPBE() {
		return fechaPBE;
	}

	public void setFechaPBE(String fechaPBE) {
		this.fechaPBE = fechaPBE;
	}

	public String getRr() {
		return rr;
	}

	public void setRr(String rr) {
		this.rr = rr;
	}

	public String getEa() {
		return ea;
	}

	public void setEa(String ea) {
		this.ea = ea;
	}

	public String getMesCesacion() {
		return mesCesacion;
	}

	public void setMesCesacion(String mesCesacion) {
		this.mesCesacion = mesCesacion;
	}

	public String getMotivoCesacion() {
		return motivoCesacion;
	}

	public void setMotivoCesacion(String motivoCesacion) {
		this.motivoCesacion = motivoCesacion;
	}

	public String getComentariosCesacion() {
		return comentariosCesacion;
	}

	public void setComentariosCesacion(String comentariosCesacion) {
		this.comentariosCesacion = comentariosCesacion;
	}

	public String getSuspensionesDeBeca() {
		return suspensionesDeBeca;
	}

	public void setSuspensionesDeBeca(String suspensionesDeBeca) {
		this.suspensionesDeBeca = suspensionesDeBeca;
	}

	public String getDestinoDineroBeca() {
		return destinoDineroBeca;
	}

	public void setDestinoDineroBeca(String destinoDineroBeca) {
		this.destinoDineroBeca = destinoDineroBeca;
	}

	public String getEsfuerzo() {
		return esfuerzo;
	}

	public void setEsfuerzo(String esfuerzo) {
		this.esfuerzo = esfuerzo;
	}

	public String getConducta() {
		return conducta;
	}

	public void setConducta(String conducta) {
		this.conducta = conducta;
	}

	public String getCompromisoRAEscolaridad() {
		return compromisoRAEscolaridad;
	}

	public void setCompromisoRAEscolaridad(String compromisoRAEscolaridad) {
		this.compromisoRAEscolaridad = compromisoRAEscolaridad;
	}

	public String getAsistioBecadoEntrevista() {
		return asistioBecadoEntrevista;
	}

	public void setAsistioBecadoEntrevista(String asistioBecadoEntrevista) {
		this.asistioBecadoEntrevista = asistioBecadoEntrevista;
	}

	public String getPresentacionMaterial() {
		return presentacionMaterial;
	}

	public void setPresentacionMaterial(String presentacionMaterial) {
		this.presentacionMaterial = presentacionMaterial;
	}

	public String getCompromisoAlumnoPrograma() {
		return compromisoAlumnoPrograma;
	}

	public void setCompromisoAlumnoPrograma(String compromisoAlumnoPrograma) {
		this.compromisoAlumnoPrograma = compromisoAlumnoPrograma;
	}

	public String getAsistenciaRAEntrevista() {
		return asistenciaRAEntrevista;
	}

	public void setAsistenciaRAEntrevista(String asistenciaRAEntrevista) {
		this.asistenciaRAEntrevista = asistenciaRAEntrevista;
	}

	public String getCompromisoRAPrograma() {
		return compromisoRAPrograma;
	}

	public void setCompromisoRAPrograma(String compromisoRAPrograma) {
		this.compromisoRAPrograma = compromisoRAPrograma;
	}

	public String getActividadAcompanamiento() {
		return actividadAcompanamiento;
	}

	public void setActividadAcompanamiento(String actividadAcompanamiento) {
		this.actividadAcompanamiento = actividadAcompanamiento;
	}

	

	public Long getNroCtesPlataformaContable() {
		return nroCtesPlataformaContable;
	}

	public void setNroCtesPlataformaContable(Long nroCtesPlataformaContable) {
		this.nroCtesPlataformaContable = nroCtesPlataformaContable;
	}

	public String getFechaReincorporacionPBE() {
		return fechaReincorporacionPBE;
	}

	public void setFechaReincorporacionPBE(String fechaReincorporacionPBE) {
		this.fechaReincorporacionPBE = fechaReincorporacionPBE;
	}
	
}
