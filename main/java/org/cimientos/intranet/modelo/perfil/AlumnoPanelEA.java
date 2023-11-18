package org.cimientos.intranet.modelo.perfil;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.cimientos.intranet.modelo.EstadoCuenta;
import org.cimientos.intranet.utils.ConstantesPaneles;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.cimientos.intranet.enumerativos.AnioEscolar;
import com.cimientos.intranet.enumerativos.EstadoPago;
import com.cimientos.intranet.enumerativos.entrevista.EstadoEntrevista;

@Entity
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE, region="org.cimientos.intranet.modelo.perfil.AlumnoPanelEA")
public class AlumnoPanelEA {
	
	@Id
	@GeneratedValue
	private Long id;
	
	private Long idPerfilAlumno;
	
	private Long idPerfilEA;
	
	private boolean activo; 
	
	private String nombreApellido;
	
	private int entrevistas;
	
	private int entrevistasRealizadas;
	
	private int pagos;
	
	private int pagosRealizados;
	
	private String zona;
	
	private String colorEntrevistas;
	
	private String colorPagos;
	
	private String escuela;
	
	private AnioEscolar anio;
	
	private Date fechaUltEntrevista;
	
	private Integer dni;
	
	private String colorBoletin;
	
	private String colorIS1;
	
	private String colorIS2;
	
	private String colorIS3;
	
	private Integer cantidadPagos;
	
	/**
	 * Las entrevistas totales segun el ciclo de la beca. Se usa para ver si puede hacer una entrevista global
	 */
	private int totalEntrevistasCiclo;

	private String colorRA;
	
	/**
	 * Esto se usa para saber si todas las entrevistas que tiene el alumno estan finalizadas, esto debe ser asi para poder generar
	 * la entrevista grupal
	 */
	private boolean entrevistasFinalizadas;
	
	private String cuentaRA;
	

	/**
	 * Esto se usa para saber si el alumno no tiene la renovacion de la beca pendiente, esto debe ser asi para poder generar
	 * la entrevista grupal
	 */
	private Boolean renovacionPendiente;
	
	private Integer cantidadPrevias;
	
	private Date fechaAltaBeca;
	
	private String estadoAlumno;
	
	
	
	public AlumnoPanelEA()
	{
		this.cantidadPagos = 0;
		this.cantidadPrevias = 0;
		this.renovacionPendiente = false;
		this.entrevistasFinalizadas = false;
		this.activo = false;
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNombreApellido() {
		return nombreApellido;
	}

	public void setNombreApellido(String nombreApellido) {
		this.nombreApellido = nombreApellido;
	}

	public String getZona() {
		return zona;
	}

	public void setZona(String zona) {
		this.zona = zona;
	}

	public int getEntrevistas() {
		return entrevistas;
	}

	public void setEntrevistas(int entrevistas) {
		this.entrevistas = entrevistas;
	}

	public int getEntrevistasRealizadas() {
		return entrevistasRealizadas;
	}

	public void setEntrevistasRealizadas(int entrevistasRealizadas) {
		this.entrevistasRealizadas = entrevistasRealizadas;
	}

	public int getPagos() {
		return pagos;
	}

	public void setPagos(int pagos) {
		this.pagos = pagos;
	}

	public int getPagosRealizados() {
		return pagosRealizados;
	}

	public void setPagosRealizados(int pagosRealizados) {
		this.pagosRealizados = pagosRealizados;
	}

	public String getColorEntrevistas() {
		return colorEntrevistas;
	}

	public void setColorEntrevistas(String colorEntrevistas) {
		this.colorEntrevistas = colorEntrevistas;
	}

	public String getColorPagos() {
		return colorPagos;
	}

	public void setColorPagos(String colorPagos) {
		this.colorPagos = colorPagos;
	}

	public String getEscuela() {
		return escuela;
	}

	public void setEscuela(String escuela) {
		this.escuela = escuela;
	}

	public AnioEscolar getAnio() {
		return anio;
	}

	public void setAnio(AnioEscolar anioEscolar) {
		this.anio = anioEscolar;
	}

	public Date getFechaUltEntrevista() {
		return fechaUltEntrevista;
	}

	public void setFechaUltEntrevista(Date fechaUltEntrevista) {
		this.fechaUltEntrevista = fechaUltEntrevista;
	}

	public Integer getDni() {
		return dni;
	}

	public void setDni(Integer dni) {
		this.dni = dni;
	}

	public String getColorBoletin() {
		return colorBoletin;
	}

	public void setColorBoletin(String colorBoletin) {
		this.colorBoletin = colorBoletin;
	}

	public String getColorIS1() {
		return colorIS1;
	}

	public void setColorIS1(String colorIS1) {
		this.colorIS1 = colorIS1;
	}

	public String getColorIS2() {
		return colorIS2;
	}

	public void setColorIS2(String colorIS2) {
		this.colorIS2 = colorIS2;
	}

	public String getColorIS3() {
		return colorIS3;
	}

	public void setColorIS3(String colorIS3) {
		this.colorIS3 = colorIS3;
	}

	public int getTotalEntrevistasCiclo() {
		return totalEntrevistasCiclo;
	}

	public void setTotalEntrevistasCiclo(int totalEntrevistasCiclo) {
		this.totalEntrevistasCiclo = totalEntrevistasCiclo;
	}

	public String getColorRA() {
		return colorRA;
	}

	public void setColorRA(String colorRA) {
		this.colorRA = colorRA;
	}

	public boolean isEntrevistasFinalizadas() {
		return entrevistasFinalizadas;
	}

	public void setEntrevistasFinalizadas(boolean entrevistasFinalizadas) {
		this.entrevistasFinalizadas = entrevistasFinalizadas;
	}

	public String getCuentaRA() {
		return cuentaRA;
	}

	public void setCuentaRA(String cuentaRA) {
		this.cuentaRA = cuentaRA;
	}

	public Boolean isRenovacionPendiente() {
		return renovacionPendiente;
	}

	public void setRenovacionPendiente(Boolean renovacionPendiente) {
		this.renovacionPendiente = renovacionPendiente;
	}

	public Long getIdPerfilAlumno() {
		return idPerfilAlumno;
	}

	public void setIdPerfilAlumno(Long idPerfilAlumno) {
		this.idPerfilAlumno = idPerfilAlumno;
	}

	public Long getIdPerfilEA() {
		return idPerfilEA;
	}

	public void setIdPerfilEA(Long idPerfilEA) {
		this.idPerfilEA = idPerfilEA;
	}

	public boolean isActivo() {
		return activo;
	}

	public void setActivo(boolean activo) {
		this.activo = activo;
	}

	public Integer getCantidadPagos() {
		return cantidadPagos;
	}

	public void setCantidadPagos(Integer cantidadPagos) {
		this.cantidadPagos = cantidadPagos;
	}

	/**
	 * Actualiza el alumnoPanelEa cuando se crea una nueva entrevista. Se actualiza el contador y el color
	 * @param estadoEntrevista 
	 */
	public void incrementarEntrevista(EstadoEntrevista estadoEntrevista) {
		this.entrevistasRealizadas = this.entrevistasRealizadas + 1;		
		if(this.getEntrevistasRealizadas() < this.getEntrevistas()){
			this.colorEntrevistas = ConstantesPaneles.RED;
		}
		else{
			this.colorEntrevistas = (estadoEntrevista.equals(EstadoEntrevista.CONSTRUCCION)?ConstantesPaneles.RED:ConstantesPaneles.GREEN);
		}
	}

	/**
	 * Actualiza el alumnoPanelEa cuando se actualiza el estado de una entrevista. Se actualiza el color
	 * @param estadoEntrevista 
	 */
	public void actualizarEntrevista(EstadoEntrevista estadoEntrevista) {
		if(this.getEntrevistasRealizadas() < this.getEntrevistas()){
			this.colorEntrevistas = ConstantesPaneles.RED;
		}
		else{
			this.colorEntrevistas = (estadoEntrevista.equals(EstadoEntrevista.CONSTRUCCION)?ConstantesPaneles.RED:ConstantesPaneles.GREEN);
		}
	}

	
	/**
	 * Incrementa los contadores de pago y actualiza el color
	 * @param estadoPago 
	 */
	public void incrementarPago(EstadoPago estadoPago) 
	{
		if(!estadoPago.equals(EstadoPago.NO_APLICA) && !estadoPago.equals(EstadoPago.SUSPENDIDO))
		{
			this.pagosRealizados = this.pagosRealizados + 1;
		}
		
		if(this.cantidadPagos == null)
		{
			this.cantidadPagos = 1;
		}
		else
			this.cantidadPagos = this.cantidadPagos + 1;
	}
	
	
	/**
	 * Actualiza el color de pagos
	 * @param estadoPago 
	 */
	public void actualizarPago(EstadoPago estadoPago) {
		if(this.getPagosRealizados() < this.getPagos()){
			this.colorPagos = ConstantesPaneles.RED;
		}
		else{
			this.colorPagos = (estadoPago.equals(EstadoPago.REALIZADO)?ConstantesPaneles.GREEN:ConstantesPaneles.RED);
		}
	}
	
	
	public void actualizarSemaforoPago(EstadoPago estadoPago) {
		if(this.getPagos() == this.getCantidadPagos() && (estadoPago.equals(EstadoPago.REALIZADO) 
														|| estadoPago.equals(EstadoPago.SUSPENDIDO)
														|| estadoPago.equals(EstadoPago.NO_APLICA)))
		{
			this.colorPagos = ConstantesPaneles.GREEN;
		}
		else 
		{
			this.colorPagos = ConstantesPaneles.RED;
		}
	}
	
	
	public void actualizarSemaforoPagoEntrevistas(Boolean tienePagosAprobados, Long idAlumno){
		if ((!tienePagosAprobados) && (this.getPagos() == this.getCantidadPagos()))
			this.colorPagos = ConstantesPaneles.GREEN;
		else
			this.colorPagos = ConstantesPaneles.RED;				
	}
	
	/**
	 * actualiza el color de la cuenta del RA segun su estado
	 * @param estadoCuenta
	 */
	public void actualizarCuenta(EstadoCuenta estadoCuenta){
		if(estadoCuenta.equals(EstadoCuenta.ACTIVA)){
			this.colorRA = ConstantesPaneles.GREEN;
		}else{
			this.colorRA = ConstantesPaneles.RED;
		}
	}

	public Integer getCantidadPrevias() {
		return cantidadPrevias;
	}

	public void setCantidadPrevias(Integer cantidadPrevias) {
		this.cantidadPrevias = cantidadPrevias;
	}

	public Date getFechaAltaBeca() {
		return fechaAltaBeca;
	}

	public void setFechaAltaBeca(Date fechaAltaBeca) {
		this.fechaAltaBeca = fechaAltaBeca;
	}

	public String getEstadoAlumno() {
		return estadoAlumno;
	}

	public void setEstadoAlumno(String estadoAlumno) {
		this.estadoAlumno = estadoAlumno;
	}
	
	

}
