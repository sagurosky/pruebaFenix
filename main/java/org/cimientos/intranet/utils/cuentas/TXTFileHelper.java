/**
 * 
 */
package org.cimientos.intranet.utils.cuentas;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

/**
 * Esta clase se usa para procesar archivos de texto, 
 * extrayendo informacion y validando ciertos formatos.
 * @author plabaronnie
 *
 */
@Service
public class TXTFileHelper {
	
	/**
	 * Valida si el archvo txt esta bien formado
	 * 
	 * @param errores
	 * @return
	 */
	public static final boolean validarImportacionExcelCreacionCuenta(String errores){
		errores = "";
		return true;
	}
	
	/**
	 * Obtiene un map con key = cuil y value = nroCuenta 
	 * para ser procesado en la creacion de ctas
	 * @return
	 * @throws IOException 
	 */
	public static final Map<String, String> obtenerNrosCuentaGalicia(MultipartFile archivo) throws IOException{
		return obtenerNrosCuentaFromTXT(archivo, " ", 3, 0, 1, false);
	}

	/**
	 * Obtiene los nros de cuenta con sus respectivos cuils de un archivo de banco
	 * generando un map con esos datos.
	 * @param archivo
	 * @param separador
	 * @param columnas
	 * @param columnaCUIL
	 * @param columnaNroCuenta
	 * @param headers
	 * @return
	 * @throws IOException
	 */
	private static Map<String, String> obtenerNrosCuentaFromTXT(
			MultipartFile archivo, String separador, int columnas, int columnaCUIL, int columnaNroCuenta, boolean headers) throws IOException {
		Map<String, String> cuentas = new HashMap<String, String>();
		InputStream stream = archivo.getInputStream();
		TXTFileReader reader = new TXTFileReader(stream, separador, columnas);
        List<String[]> lineas = reader.getLineas();
        java.util.Iterator<String[]> ite = lineas.iterator(); 
        if(headers && ite.hasNext()){
        	ite.next();
        }
        while (ite.hasNext()){
        	String[] linea = ite.next();
        	String cuil = linea[columnaCUIL] ;
        	String nroCuenta = linea[columnaNroCuenta];
			cuentas.put(cuil, nroCuenta);
		}
		return cuentas;

	}

	/**
	 * Obtiene un map con key = cuil y value = nroCuenta 
	 * para ser procesado en la creacion de ctas
	 * @return
	 * @throws IOException 
	 */
	public static final Map<String, String> obtenerNrosCuentaMacro(MultipartFile archivo) throws IOException{
		return obtenerNrosCuentaFromTXT(archivo, "\\|",9 , 6, 8, true);
	}
	

	/**
	 * Valida que el archivo cumpla con el patron del txt que envia el banco galicia.
	 * Para eso analiza la primera linea.
	 * @param archivo
	 * @return
	 * @throws IOException 
	 */
	public static boolean validarArchivoCuentaGalicia(MultipartFile archivo) throws IOException {
		InputStream stream = archivo.getInputStream();
		TXTFileReader reader = new TXTFileReader(stream, null, 0);
		String line = reader.getLine(1).substring(0, 30);
		String patronLinea = "\\d{11}\\s\\d{14}\\sCAS[\\s]*";
		boolean valido = Pattern.matches(patronLinea, line);
		return valido;
	}

	/**
	 * Valida que el archivo cumpla con el patron del txt que envia el banco macro.
	 * Para eso analiza la primera linea.
	 * @param archivo
	 * @return
	 * @throws IOException 
	 */
	public static boolean validarArchivoCuentaMacro(MultipartFile archivo) throws IOException {
		InputStream stream = archivo.getInputStream();
		TXTFileReader reader = new TXTFileReader(stream, null, 0);
		String line = reader.getLine(2);
		String patronLinea = "\\d+\\p{Punct}[a-zA-Z-�]+\\s[a-zA-Z-�]+(\\s[a-zA-Z-�]*)*\\p{Punct}([a-zA-Z-�]+\\s[a-zA-Z-�]+(\\s[a-zA-Z-�]*)*)*\\p{Punct}\\d+" +
				"\\p{Punct}\\d+\\p{Punct}\\d+\\p{Punct}\\d{11}\\p{Punct}\\d+\\p{Punct}\\d+\\p{Punct}\\d+" +
				"\\p{Punct}\\d+\\p{Punct}\\p{Punct}";
		boolean valido = Pattern.matches(patronLinea, line);
		return valido;
	}

}
