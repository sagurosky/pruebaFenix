package org.cimientos.intranet.utils.cuentas;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.cimientos.intranet.modelo.CicloPrograma;
import org.cimientos.intranet.modelo.ResponsableAdulto;
import org.cimientos.intranet.modelo.ubicacion.Localidad;
import org.cimientos.intranet.utils.Formateador;

import com.cimientos.intranet.enumerativos.TipoDni;

/**
 * Esta clase representa un archivo de solicitud de apertura de cuenta para banco Galicia.
 * Genera una lista de arreglos de String (cada una representaria una linea en un archivo).
 * @author plabaronnie
 *
 */
public class ArchivoSolicitudCuentaGalicia extends ArchivoCuenta{
	
	private static final String CABA = "CABA";

	private static final String CIUDAD_AUTON_BSAS = "CIUDAD AUTONOMA BUENOS AI";

	private static final String CAPITAL_FEDERAL = "CAPITAL FEDERAL";

	//private String[] columnas = new String[]{"Apellido","Nombre","Tipo de Documento","Nro. de documento",
	//		"Sexo",	"Fecha de nacimiento",	"Nacionalidad",	"Nro. de Cuil",	"Ingresos",
	//		"Calle",	"Nro. de calle",	"Piso",	"Localidad",	"Cod. Postal",	"Provincia",
	//		"Nro. de Planta",	"Sucursal de pago",	"Telefono", "Codigo de Area", "Tipo Tel", "email"};
	
	private String[] columnas = new String[]{"Apellido","Nombre","Tipo de Documento","Nro. de documento",
			"Sexo",	"Fecha de nacimiento",	"Nacionalidad",	"Nro. de Cuil",	"Ingresos",
			"Calle",	"Nro. de calle",	"Piso",	"Localidad",	"Cod. Postal",	"Provincia",
			"Nro. de Planta",	"Sucursal de pago",	"Telefono", "Codigo de Area", "Tipo Tel", "email"};
	
	//private String nombreHoja = "datosminimos";
	private String nombreHoja = "Carga de Datos";
	
	public ArchivoSolicitudCuentaGalicia(List<ResponsableAdulto> responsables,/* List<PerfilStaff> staff, */ CicloPrograma cicloActual) {
		super();
		DummyDatosFaltantes.completarDatosFaltantes(responsables/*, staff*/);
		this.generarDatos(responsables, /*staff,*/ cicloActual);
	}

	/**
	 * @param pagos
	 */
	private void generarDatos(List<ResponsableAdulto> responsables, /*List<PerfilStaff> staff,*/ CicloPrograma ciclo) {
		for (ResponsableAdulto responsable : responsables) {
			String[] columna = new String[columnas.length];
			String apellido=getApellido(responsable.getApellido().toUpperCase());
			String nombre=this.getNombre(responsable.getNombre().toUpperCase());
			String calle=this.getCalle(responsable.getCalle().toUpperCase());
			String localidad= this.getLocalidad(responsable.getIdLocalidad()).toUpperCase();
			String provincia=this.getProvincia(responsable.getIdLocalidad()).toUpperCase();
			apellido=apellido.replace("�", "N");
			apellido=apellido.replace("�", "A");
			apellido=apellido.replace("�", "E");
			apellido=apellido.replace("�", "I");
			apellido=apellido.replace("�", "O");
			apellido=apellido.replace("�", "U");
			apellido=apellido.replace(".", " ");
			apellido=apellido.replace("�", "A");
			apellido=apellido.replace("�", "E");
			apellido=apellido.replace("�", "I");
			apellido=apellido.replace("�", "O");
			apellido=apellido.replace("�", "U");
			
			nombre=nombre.replace("�", "N");
			nombre=nombre.replace("�", "A");
			nombre=nombre.replace("�", "E");
			nombre=nombre.replace("�", "I");
			nombre=nombre.replace("�", "O");
			nombre=nombre.replace("�", "U");
			nombre=nombre.replace(".", " ");
			nombre=nombre.replace("�", "A");
			nombre=nombre.replace("�", "E");
			nombre=nombre.replace("�", "I");
			nombre=nombre.replace("�", "O");
			nombre=nombre.replace("�", "U");
			
			calle=calle.replace("�", "N");
			calle=calle.replace("�", "A");
			calle=calle.replace("�", "E");
			calle=calle.replace("�", "I");
			calle=calle.replace("�", "O");
			calle=calle.replace("�", "U");
			calle=calle.replace(".", " ");
			calle=calle.replace("-", " ");
			calle=calle.replace("�", " ");
			calle=calle.replace("'", " ");
			calle=calle.replace(",", " ");
			calle=calle.replace("�", "A");
			calle=calle.replace("�", "E");
			calle=calle.replace("�", "I");
			calle=calle.replace("�", "O");
			calle=calle.replace("�", "U");
			
			localidad=localidad.replace("�", "N");
			localidad=localidad.replace("�", "A");
			localidad=localidad.replace("�", "E");
			localidad=localidad.replace("�", "I");
			localidad=localidad.replace("�", "O");
			localidad=localidad.replace("�", "U");
			localidad=localidad.replace(".", " ");
			localidad=localidad.replace("-", " ");
			localidad=localidad.replace("�", " ");
			localidad=localidad.replace("'", " ");
			localidad=localidad.replace(",", " ");
			localidad=localidad.replace("�", "A");
			localidad=localidad.replace("�", "E");
			localidad=localidad.replace("�", "I");
			localidad=localidad.replace("�", "O");
			localidad=localidad.replace("�", "U");
			
			provincia=provincia.replace("�", "N");
			provincia=provincia.replace("�", "A");
			provincia=provincia.replace("�", "E");
			provincia=provincia.replace("�", "I");
			provincia=provincia.replace("�", "O");
			provincia=provincia.replace("�", "U");
			provincia=provincia.replace(".", " ");
			provincia=provincia.replace("-", " ");
			provincia=provincia.replace("�", " ");
			provincia=provincia.replace("'", " ");
			provincia=provincia.replace(",", " ");
			provincia=provincia.replace("�", "A");
			provincia=provincia.replace("�", "E");
			provincia=provincia.replace("�", "I");
			provincia=provincia.replace("�", "O");
			provincia=provincia.replace("�", "U");
			
			
			
			
			
			columna[0] = apellido; 
			columna[1] = nombre; 
			//columna[2] = this.getTipoDNI(responsable.getIdTipoDni()); 
			//columna[3] = this.getNroDocumento(responsable.getDni());
			columna[2] = this.getSexo(responsable.getSexo());
			//columna[5] = this.getFechaNacimiento(responsable.getFechaNacimiento());
			//columna[6] = this.getNacionalidad("Argentina");
			columna[3] = this.getNroCuil(responsable.getCuilCuit());
			columna[4] = this.getIngresos(ciclo);
			//columna[9] = calle;
			//columna[10] = this.getNroCalle(responsable.getNroCalle());
			//columna[11] = this.getPiso(responsable.getPiso());
			//columna[12] = localidad;
			//columna[13] = this.getCodPostal(responsable.getCodigoPostal());
			//columna[14] = provincia;
			//columna[15] = this.getNroPlanta();
			columna[5] = this.getSucursalPago(responsable.getSucursalBanco().getNumeroSucursal());
			//columna[17] = this.getTelefono(responsable.getTelefono());
			columna[6] = "37230500";
			columna[7] = "11";
			//columna[19] = "F";
			//columna[20] = "pfe@cimientos.org";
			
			datos.add(columna);
		}
		
		

		
//		for (PerfilStaff pstaff : staff) {
//			String[] columna = new String[columnas.length];
//			columna[0] = this.getApellido(pstaff.getDatosPersonales().getApellido());
//			columna[1] = this.getNombre(pstaff.getDatosPersonales().getNombre());
//			columna[2] = this.getTipoDNI(pstaff.getIdTipoDni());
//			columna[3] = this.getNroDocumento(pstaff.getDatosPersonales().getDni());
//			columna[4] = this.getSexo(pstaff.getDatosPersonales().getSex());
//			columna[5] = this.getFechaNacimiento(pstaff.getDatosPersonales().getFechaNacimiento());
//			columna[6] = this.getNacionalidad(pstaff.getNacionalidad());
//			columna[7] = this.getNroCuil(pstaff.getCuilTitularCuenta());
//			columna[8] = this.getIngresos(ciclo);
//			columna[9] = this.getCalle(pstaff.getCalle());
//			columna[10] = this.getNroCalle(pstaff.getNroCalle());
//			columna[11] = this.getPiso(pstaff.getPiso());
//			columna[12] = this.getLocalidad(pstaff.getDatosPersonales().getLocalidad());
//			columna[13] = this.getCodPostal(pstaff.getCodigoPostal());
//			columna[14] = this.getProvincia(pstaff.getDatosPersonales().getLocalidad());
//			columna[15] = this.getNroPlanta();
//			columna[16] = this.getSucursalPago(pstaff.getSucursalPago());
//			columna[17] = this.getTelefono(pstaff.getDatosPersonales().getTelefono());
//			datos.add(columna);
//		}
	
	}



	/**
	 * @param montoIngreso
	 * @return
	 */
	private String getIngresos(CicloPrograma ciclo) {
		String montoBeca = getMontoBecaCicloActual(ciclo);
		if(montoBeca != null){
			int i = montoBeca.indexOf('.');
			return montoBeca.substring(0, i);
		}
		return "";
	}

	/**
	 * @param provincia 
	 * @param idLocalidad
	 * @return
	 */
	private String getProvincia(Localidad localidad) {
		if(localidad != null && localidad.getProvincia()!= null ){
			if(localidad.getNombre().equals(CABA)){
				return CAPITAL_FEDERAL;
			}
			return Formateador.quitarAcentos( localidad.getProvincia().getDescripcion() ).toUpperCase();
		}
		return "";
	}



	/**
	 * @param telefono1
	 * @return
	 */
	private String getTelefono(String telefono1) {
		if(StringUtils.isNotBlank( telefono1)){
			return telefono1;
		}
		return "";
	}

	/**
	 * @param string
	 * @return
	 */
	private String getSucursalPago(String sucursal) {
		if(StringUtils.isNotBlank( sucursal)){
			return StringUtils.leftPad(sucursal, 5, '0');
		}
		return "";
	}

	/**
	 * @param string
	 * @return
	 */
	private String getNroPlanta() {
		return "0000";
	}


	/**
	 * @param idLocalidad
	 * @return
	 */
	private String getLocalidad(Localidad localidad) {
		if(localidad != null){
			if(localidad.getNombre().equals(CABA)){
				return CIUDAD_AUTON_BSAS;
			}
			return Formateador.quitarAcentos( localidad.getNombre()).toUpperCase();
		}
		return "";
	}



	/**
	 * @param string
	 * @return
	 */
	private String getNacionalidad(String string) {
		if(StringUtils.isNotBlank(string)){
			return string.toUpperCase();
		}
		return "";
	}

	/**
	 * @param fechaNacimiento
	 * @return
	 */
	private String getFechaNacimiento(Date fechaNacimiento) {
		if(fechaNacimiento != null){
			return Formateador.formatearFecha(fechaNacimiento, "yyyyMMdd");
		}
		return "";
	}



	/**
	 * @param idTipoDni
	 * @return
	 */
	protected String getTipoDNI(TipoDni idTipoDni) {
		if(idTipoDni != null){
			if(idTipoDni.equals(TipoDni.DNI)){
				return "DU";
			}
			return idTipoDni.getValor();
		}
		return "";
	}

	/**
	 * @return the nombreHoja
	 */
	public String getNombreHoja() {
		return nombreHoja;
	}

	/**
	 * @param nombreHoja the nombreHoja to set
	 */
	public void setNombreHoja(String nombreHoja) {
		this.nombreHoja = nombreHoja;
	}

	/**
	 * @param nombre
	 * @return
	 */
	protected String getNombre(String nombre) {
		if(nombre.length() > 30){
			nombre = nombre.substring(0, 29);
		}
		nombre = Formateador.quitarAcentos(nombre);
		return nombre.toUpperCase();
	}

	/**
	 * @param apellido
	 * @return
	 */
	protected String getApellido(String apellido) {
		if(apellido.length() > 30){
			apellido = apellido.substring(0, 29);
		}
		apellido = Formateador.quitarAcentos(apellido);
		return apellido.toUpperCase();
	}	

	/**
	 * @param direccion
	 * @return
	 */
	protected String getCalle(String calle) {
		if(StringUtils.isNotBlank( calle)){
			return Formateador.quitarAcentos(calle).toUpperCase();
		}
		return "";
	}
	
	
	protected String getNroCalle(String nroCalle) {
		if(nroCalle.length() == 0){
			nroCalle = "SN";
		}		
		return nroCalle;
	}
	
	
}
