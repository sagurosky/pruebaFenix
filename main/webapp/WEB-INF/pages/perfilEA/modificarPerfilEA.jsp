<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edici�n de Perfil EA</title>
</head>

<body>
<form id="editarPerfilEA" class="cmxform" action="<c:url value='/perfilEA/modificarPerfilEA.do' />" method="post">
    <table  border="0" >
     	
 		<tbody>
        <tr >
        <td width="600">
        <label id="label">
            <c:forEach var="z" items="${perfilEA.zona}" >
				<option value="${z.id}"><center>${z.nombre}</center></option>
				<br>	
			</c:forEach>
        </label>
        </td>
      	</tr>
	    </tbody>		
     </table>
</form>
</body>
</html>