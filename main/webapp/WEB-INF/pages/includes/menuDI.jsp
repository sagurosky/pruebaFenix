<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"   %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"   %>

<ul id="menuV" > 
	<li>		
		<a href='<c:url value="/envioInformes/listaInformes.do" />' >Listado para el env�o de informes a Padrinos Individuales</a>
    </li>
    <li>		
		<a href='<c:url value="/envioInformes/listaInformesCorporativos.do" />' >Listado para el env�o de informes a Padrinos Corporativos</a>
    </li>
</ul>
    