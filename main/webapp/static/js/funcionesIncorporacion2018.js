function chequearLongitud(obj){
	if (obj.value.length > 10000) {
	obj.value = obj.value.substring(0, 10000);
	}
}


function habilitarMaterialCompletoCertificadoAlumnoRegular(obj){
	
	if(	((document.getElementById("fotocipiaBoletin").value == 1) || (document.getElementById("fotocipiaBoletin").value == 3))&&
		((obj.value == 1) || (obj.value == 3))&&
		((document.getElementById("firmaAutorizacionImagen").value == 1) || (document.getElementById("firmaAutorizacionImagen").value == 3))&&
		((document.getElementById("firmaActaCompromiso").value == 1) || (document.getElementById("firmaActaCompromiso").value == 3))&&
		((document.getElementById("firmaAutorizacionCierreCaja").value == 1) || (document.getElementById("firmaAutorizacionCierreCaja").value == 3)))
		
	{
		document.getElementById("materialCompleto").checked = 1
	}else{
		document.getElementById("materialCompleto").checked = 0

	}
}

function habilitarMaterialCompletoFotocipiaBoletin(obj){
	
	if(	((document.getElementById("certificadoAlumnoRegular").value == 1) || (document.getElementById("certificadoAlumnoRegular").value == 3))&&
		((obj.value == 1) || (obj.value == 3))&&
		((document.getElementById("firmaAutorizacionImagen").value == 1) || (document.getElementById("firmaAutorizacionImagen").value == 3))&&
		((document.getElementById("firmaActaCompromiso").value == 1) || (document.getElementById("firmaActaCompromiso").value == 3))&&
		((document.getElementById("firmaAutorizacionCierreCaja").value == 1) || (document.getElementById("firmaAutorizacionCierreCaja").value == 3)))
		
	{
		document.getElementById("materialCompleto").checked = 1
	}else{
		document.getElementById("materialCompleto").checked = 0

	}
}

function habilitarMaterialCompletoFirmaActaCompromiso(obj){
	
	if(	((document.getElementById("certificadoAlumnoRegular").value == 1) || (document.getElementById("certificadoAlumnoRegular").value == 3))&&
		((obj.value == 1) || (obj.value == 3))&&
		((document.getElementById("fotocipiaBoletin").value == 1) || (document.getElementById("fotocipiaBoletin").value == 3))&&
		((document.getElementById("firmaAutorizacionImagen").value == 1) || (document.getElementById("firmaAutorizacionImagen").value == 3))&&
		((document.getElementById("firmaAutorizacionCierreCaja").value == 1) || (document.getElementById("firmaAutorizacionCierreCaja").value == 3)))
		
	{
		document.getElementById("materialCompleto").checked = 1
	}else{
		document.getElementById("materialCompleto").checked = 0

	}
}

function habilitarMaterialCompletoFirmaAutorizacionCierreCaja(obj){
		
	if(	((document.getElementById("certificadoAlumnoRegular").value == 1) || (document.getElementById("certificadoAlumnoRegular").value == 3))&&
			((obj.value == 1) || (obj.value == 3))&&
			((document.getElementById("fotocipiaBoletin").value == 1) || (document.getElementById("fotocipiaBoletin").value == 3))&&
			((document.getElementById("firmaActaCompromiso").value == 1) || (document.getElementById("firmaActaCompromiso").value == 3))&&
			((document.getElementById("firmaAutorizacionImagen").value == 1) || (document.getElementById("firmaAutorizacionImagen").value == 3))
			)
			
		{
			document.getElementById("materialCompleto").checked = 1
		}else{
			document.getElementById("materialCompleto").checked = 0

		}
}

function habilitarMaterialCompletoFirmaAutorizacionImagen(obj){
	
	if(	((document.getElementById("certificadoAlumnoRegular").value == 1) || (document.getElementById("certificadoAlumnoRegular").value == 3))&&
			((obj.value == 1) || (obj.value == 3))&&
			((document.getElementById("fotocipiaBoletin").value == 1) || (document.getElementById("fotocipiaBoletin").value == 3))&&
			((document.getElementById("firmaActaCompromiso").value == 1) || (document.getElementById("firmaActaCompromiso").value == 3))&&
			((document.getElementById("firmaAutorizacionCierreCaja").value == 1) || (document.getElementById("firmaAutorizacionCierreCaja").value == 3)))
			
		{
			document.getElementById("materialCompleto").checked = 1
		}else{
			document.getElementById("materialCompleto").checked = 0

		}
}

function habilitarCamposBecado(obj){
	
    if (document.getElementById("incorporacion").value == 1){
    	if(obj.disabled || obj.checked){
			document.getElementById("motivoAusencia").disabled = true;
			document.getElementById("otroMotivoAusencia").disabled = true;
			document.getElementById("motivoAusencia").value = "";
			document.getElementById("otroMotivoAusencia").value= "";
		}
    	else{
			document.getElementById("motivoAusencia").disabled = false;
		}
    }else
    	if (document.getElementById("realizoEntrevista").checked){
    		if(obj.disabled || obj.checked){
				document.getElementById("motivoAusencia").disabled = true;
				document.getElementById("otroMotivoAusencia").disabled = true;
				document.getElementById("motivoAusencia").value = "";
				document.getElementById("otroMotivoAusencia").value= "";
			}
			else{
				document.getElementById("motivoAusencia").disabled = false;
				}
		    }
	    else{
	    	document.getElementById("motivoAusencia").disabled = true;
			document.getElementById("otroMotivoAusencia").disabled = true;
			document.getElementById("motivoAusencia").value = "";
			document.getElementById("otroMotivoAusencia").value= "";
	    }
}

function habilitarCamposRA(obj){
	
	if (document.getElementById("incorporacion").value == 1){ 
		if(obj.checked){
			document.getElementById("motivoAusenciaRA").disabled = true;
			document.getElementById("otroMotivoAusenciaRA").disabled = true;
			document.getElementById("motivoAusenciaRA").value ="";
			document.getElementById("otroMotivoAusenciaRA").value= "";
			document.getElementById("raNoConvocado").checked = true;
			document.getElementById("motivoNoConvocatoria").disabled = true;
		}
		else{
			document.getElementById("motivoAusenciaRA").disabled = true;
		}
	}else
		if (document.getElementById("realizoEntrevista").checked){
			if(obj.checked){
				document.getElementById("motivoAusenciaRA").disabled = true;
				document.getElementById("otroMotivoAusenciaRA").disabled = true;
				document.getElementById("motivoAusenciaRA").value ="";
				document.getElementById("otroMotivoAusenciaRA").value= "";
				document.getElementById("raNoConvocado").checked = true;
				document.getElementById("motivoNoConvocatoria").disabled = true;
			}
			else{
				document.getElementById("motivoAusenciaRA").disabled = true;
				}
			}
		 else{
			document.getElementById("motivoAusenciaRA").disabled = true;
			document.getElementById("otroMotivoAusenciaRA").disabled = true;
			document.getElementById("motivoAusenciaRA").value = "";
			document.getElementById("otroMotivoAusenciaRA").value= "";
			document.getElementById("raNoConvocado").checked = true;
			document.getElementById("motivoNoConvocatoria").disabled = true;
		 }
}

function habilitarCamposIncorporacion(obj){
	if(obj.value == 3){
		document.getElementById("motivoPendiente").disabled = false;
		document.getElementById("motivoNoIncorporacion").disabled = true;
		document.getElementById("motivoNoIncorporacion").value= "";
		document.getElementById("observacionesNoIncorporacion").disabled = true;
		document.getElementById("observacionesNoIncorporacion").value= "";
		document.getElementById("evaluacionCobroBeca").disabled = true;
		document.getElementById("evaluacionCobroBeca").value= "";
		document.getElementById("realizoEntrevista").disabled = false;
		document.getElementById("tipoContacto").disabled = false;
		document.getElementById("certificadoAlumnoRegular").disabled = true;
		document.getElementById("certificadoAlumnoRegular").value= "";
		document.getElementById("firmaActaCompromiso").disabled = true;
		document.getElementById("firmaActaCompromiso").value= "";
		document.getElementById("firmaAutorizacionCierreCaja").disabled = true;
		document.getElementById("firmaAutorizacionCierreCaja").value= "";
		document.getElementById("firmaAutorizacionImagen").disabled = true;
		document.getElementById("firmaAutorizacionImagen").value= "";
		document.getElementById("fotocipiaBoletin").disabled = true;
		document.getElementById("fotocipiaBoletin").value= "";
		document.getElementById("materialCompleto").checked= false;
		document.getElementById("proposito").disabled = true;
		document.getElementById("proposito").value= "";
		//document.getElementById("expectativasRA").disabled = true;
		//document.getElementById("expectativasRA").value= "";
		//document.getElementById("destinoDinero").disabled = true;
		//document.getElementById("destinoDinero").value= "";
		document.getElementById("observacionesGenerales").disabled = false;
		document.getElementById("proximaEntrevista").disabled = false;
		document.getElementById("horaProxEntrevista").disabled = false;
		document.getElementById("lugarProximaEntrevista").disabled = false;
		document.getElementById("entregaMaterial").disabled = true;
		document.getElementById("entregaMaterial").checked= false;
		document.getElementById("participoBecado").disabled = false;
		document.getElementById("participoRA").disabled = false;
		habilitarTipocontacto(document.getElementById("realizoEntrevista"));
	}
	else if(obj.value == 2){
		document.getElementById("motivoNoIncorporacion").disabled = false;
		document.getElementById("observacionesNoIncorporacion").disabled = false;
		document.getElementById("motivoPendiente").disabled = true;
		document.getElementById("motivoPendiente").value = "";
		document.getElementById("evaluacionCobroBeca").disabled = true;
		document.getElementById("evaluacionCobroBeca").value= "";
		document.getElementById("realizoEntrevista").disabled = false;
		document.getElementById("tipoContacto").disabled = false;
		document.getElementById("certificadoAlumnoRegular").disabled = true;
		document.getElementById("certificadoAlumnoRegular").value= "";
		document.getElementById("firmaActaCompromiso").disabled = true;
		document.getElementById("firmaActaCompromiso").value= "";
		document.getElementById("firmaAutorizacionCierreCaja").disabled = true;
		document.getElementById("firmaAutorizacionCierreCaja").value= "";
		document.getElementById("firmaAutorizacionImagen").disabled = true;
		document.getElementById("firmaAutorizacionImagen").value= "";
		document.getElementById("fotocipiaBoletin").disabled = true;
		document.getElementById("fotocipiaBoletin").value= "";
		document.getElementById("materialCompleto").checked= false;
		document.getElementById("proposito").disabled = true;
		document.getElementById("proposito").value= "";
		//document.getElementById("expectativasRA").disabled = true;
		//document.getElementById("expectativasRA").value= "";
		//document.getElementById("destinoDinero").disabled = true;
		//document.getElementById("destinoDinero").value= "";
		document.getElementById("observacionesGenerales").disabled = true;
		document.getElementById("observacionesGenerales").value= "";
		document.getElementById("proximaEntrevista").disabled = true;
		document.getElementById("proximaEntrevista").value= "";
		document.getElementById("horaProxEntrevista").disabled = true;
		document.getElementById("horaProxEntrevista").value= "";
//		document.getElementById("lugarProximaEntrevista").disabled = true;
//		document.getElementById("lugarProximaEntrevista").value= "";
		document.getElementById("entregaMaterial").disabled = true;
		document.getElementById("entregaMaterial").checked= false;
		document.getElementById("participoBecado").disabled = true;
		document.getElementById("participoRA").disabled = true;
		habilitarTipocontacto(document.getElementById("realizoEntrevista"));

	}
	else if(obj.value==1){
		document.getElementById("motivoNoIncorporacion").disabled = true;
		document.getElementById("motivoNoIncorporacion").value= "";
		document.getElementById("observacionesNoIncorporacion").disabled = true;
		document.getElementById("observacionesNoIncorporacion").value= "";
		document.getElementById("motivoPendiente").disabled = true;
		document.getElementById("motivoPendiente").value = "";
		document.getElementById("evaluacionCobroBeca").disabled = false;
		document.getElementById("realizoEntrevista").disabled = true;
		document.getElementById("realizoEntrevista").checked= false;
		document.getElementById("tipoContacto").disabled = true;
		document.getElementById("tipoContacto").value= "";
		document.getElementById("proposito").disabled = false;
		//document.getElementById("expectativasRA").disabled = false;
		//document.getElementById("destinoDinero").disabled = false;
		document.getElementById("observacionesGenerales").disabled = false;
		document.getElementById("fechaEntrevista").disabled = false;
		document.getElementById("lugarEntrevista").disabled = false;
		document.getElementById("proximaEntrevista").disabled = false;
		document.getElementById("horaProxEntrevista").disabled = false;
		document.getElementById("lugarProximaEntrevista").disabled = false;
		document.getElementById("entregaMaterial").disabled = false;
		document.getElementById("participoBecado").disabled = false;
		document.getElementById("participoRA").disabled = false;
		document.getElementById("motivoAusencia").disabled = false;
		document.getElementById("motivoAusenciaRA").disabled = false;
		document.getElementById("otroMotivoAusencia").disabled = true;
		document.getElementById("otroMotivoAusencia").value = "";
		document.getElementById("otroMotivoAusenciaRA").disabled = true;
		document.getElementById("otroMotivoAusenciaRA").value = "";
		document.getElementById("certificadoAlumnoRegular").disabled = false;
		document.getElementById("firmaActaCompromiso").disabled = false;
		document.getElementById("firmaAutorizacionCierreCaja").disabled = false;
		document.getElementById("firmaAutorizacionImagen").disabled = false;
		document.getElementById("fotocipiaBoletin").disabled = false;
		
	}else{
		document.getElementById("motivoPendiente").disabled = true;
		document.getElementById("motivoPendiente").value = "";
		document.getElementById("motivoNoIncorporacion").disabled = true;
		document.getElementById("motivoNoIncorporacion").value= "";
		document.getElementById("observacionesNoIncorporacion").disabled = true;
		document.getElementById("observacionesNoIncorporacion").value= "";
		document.getElementById("evaluacionCobroBeca").disabled = true;
		document.getElementById("evaluacionCobroBeca").value= "";
		document.getElementById("realizoEntrevista").disabled = true;
		document.getElementById("realizoEntrevista").checked= false;
		document.getElementById("tipoContacto").disabled = true;
		document.getElementById("tipoContacto").value= "";
		document.getElementById("fechaEntrevista").disabled = false;
		
		document.getElementById("lugarEntrevista").disabled = true;
//		document.getElementById("lugarEntrevista").value = "";
		document.getElementById("proposito").disabled = true;
		document.getElementById("proposito").value= "";
		//document.getElementById("expectativasRA").disabled = true;
		//document.getElementById("expectativasRA").value= "";
		//document.getElementById("destinoDinero").disabled = true;
		//document.getElementById("destinoDinero").value= "";
		document.getElementById("observacionesGenerales").disabled = true;
		document.getElementById("observacionesGenerales").value= "";
		document.getElementById("proximaEntrevista").disabled = true;
		document.getElementById("proximaEntrevista").value= "";
		document.getElementById("horaProxEntrevista").disabled = true;
		document.getElementById("horaProxEntrevista").value= "";
		document.getElementById("lugarProximaEntrevista").disabled = true;
//		document.getElementById("lugarProximaEntrevista").value= "";
		document.getElementById("entregaMaterial").disabled = true;
		document.getElementById("entregaMaterial").checked= false;
		document.getElementById("participoBecado").disabled = true;
		document.getElementById("participoBecado").checked = false;
		document.getElementById("participoRA").disabled = true;
		document.getElementById("participoRA").checked = false;
		document.getElementById("motivoAusencia").disabled = true;
		document.getElementById("motivoAusencia").value = "";
		document.getElementById("motivoAusenciaRA").disabled = true;
		document.getElementById("motivoAusenciaRA").value = "";
		document.getElementById("otroMotivoAusencia").disabled = true;
		document.getElementById("otroMotivoAusencia").value = "";
		document.getElementById("otroMotivoAusenciaRA").disabled = true;
		document.getElementById("otroMotivoAusenciaRA").value = "";
		document.getElementById("certificadoAlumnoRegular").disabled = true;
		document.getElementById("certificadoAlumnoRegular").value= "";
		document.getElementById("firmaActaCompromiso").disabled = true;
		document.getElementById("firmaActaCompromiso").value= "";
		document.getElementById("firmaAutorizacionCierreCaja").disabled = true;
		document.getElementById("firmaAutorizacionCierreCaja").value= "";
		document.getElementById("firmaAutorizacionImagen").disabled = true;
		document.getElementById("firmaAutorizacionImagen").value= "";
		document.getElementById("fotocipiaBoletin").disabled = true;
		document.getElementById("fotocipiaBoletin").value= "";
		document.getElementById("materialCompleto").checked= false;
		document.getElementById("otroMotivoAusencia").disabled = true;
		document.getElementById("otroMotivoAusencia").value = "";
		document.getElementById("otroMotivoAusenciaRA").disabled = true;
		document.getElementById("otroMotivoAusenciaRA").value = "";
		
		habilitarTipocontacto(document.getElementById("realizoEntrevista"));
		document.getElementById("tipoContacto").disabled = true;
	}
	habilitarMotivoPendiente(document.getElementById("motivoPendiente"));
	habilitarMotivoTipoContacto(document.getElementById("tipoContacto"));
	habilitarOtroMotivoNoIncorporacion(document.getElementById("motivoNoIncorporacion"));
	
}

function habilitarOtroMotivo(obj){
	if(obj.value == 4){
		document.getElementById("otroMotivoAusencia").disabled = false;
	}
	else{
		document.getElementById("otroMotivoAusencia").disabled = true;
		document.getElementById("otroMotivoAusencia").value = "";
	}
}

function habilitarOtroMotivoRA(obj){
	if(obj.value == 4){
		document.getElementById("otroMotivoAusenciaRA").disabled = false;
	}
	else{
		document.getElementById("otroMotivoAusenciaRA").disabled = true;
		document.getElementById("otroMotivoAusenciaRA").value = "";
	}
}


function habilitarTipocontacto(valor){
	if(valor.checked)
		{document.getElementById("tipoContacto").disabled = true;
		document.getElementById("tipoContacto").value = "";
		document.getElementById("participoBecado").disabled = false;
		document.getElementById("participoRA").disabled = false;
		document.getElementById("motivoAusencia").disabled = false;
		document.getElementById("motivoAusenciaRA").disabled = false;
		document.getElementById("otroMotivoAusencia").disabled = treu;
		document.getElementById("otroMotivoAusenciaRA").disabled = false;
		document.getElementById("motivoTipoContactoOtro").disabled = true;
		document.getElementById("motivoTipoContactoOtro").value = "";
		document.getElementById("fechaEntrevista").disabled = false;
		document.getElementById("lugarEntrevista").disabled = false;
		}
	else
		{
		document.getElementById("tipoContacto").disabled = false;
		document.getElementById("motivoTipoContactoOtro").disabled = false;
		document.getElementById("fechaEntrevista").disabled = false;
		
		document.getElementById("lugarEntrevista").disabled = true;
//		document.getElementById("lugarEntrevista").value = "";
		document.getElementById("participoBecado").disabled = true;
		document.getElementById("participoBecado").checked = false;
		document.getElementById("participoRA").disabled = true;
		document.getElementById("participoRA").checked = false;
		document.getElementById("motivoAusencia").disabled = true;
		document.getElementById("motivoAusencia").value = "";
		document.getElementById("motivoAusenciaRA").disabled = true;
		document.getElementById("motivoAusenciaRA").value = "";
		document.getElementById("otroMotivoAusencia").disabled = true;
		document.getElementById("otroMotivoAusencia").value = "";
		document.getElementById("otroMotivoAusenciaRA").disabled = true;
		document.getElementById("otroMotivoAusenciaRA").value = "";
		}
}	

function habilitarMotivoTipoContacto(obj){
	if(obj.value == 5){
		document.getElementById("motivoTipoContactoOtro").disabled = false;
	}
	else{
		document.getElementById("motivoTipoContactoOtro").disabled = true;
		document.getElementById("motivoTipoContactoOtro").value = "";
	
}
}

function habilitarMotivoPendiente(obj){
	if(obj.value == 4){	
		document.getElementById("motivoOtroPendiente").disabled = false;
	}
	else{
		document.getElementById("motivoOtroPendiente").disabled = true;
		document.getElementById("motivoOtroPendiente").value = "";	
	}
}

function habilitarOtroMotivoNoIncorporacion(obj){
	if(obj.value == 5){
		document.getElementById("motivoNoIncorporacionOtro").disabled = false;
	}
	else{
		document.getElementById("motivoNoIncorporacionOtro").disabled = true;
		document.getElementById("motivoNoIncorporacionOtro").value = "";	
	}
}

function cargarDatosIncorporacion(){
	habilitarCamposIncorporacion(document.getElementById("incorporacion"));
	habilitarCamposBecado(document.getElementById("participoBecado"));
	habilitarCamposRA(document.getElementById("participoRA"));
	habilitarOtroMotivo(document.getElementById("motivoAusencia"));
	habilitarOtroMotivoRA(document.getElementById("motivoAusenciaRA"));

}