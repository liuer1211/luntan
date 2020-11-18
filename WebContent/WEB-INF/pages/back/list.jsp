<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@include file="/include/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理员</title>
</head>
<body>
<table>
	<c:forEach items="${manager}" var="manager">
		<tr>
			<td>${manager.id }</td>
			<td>${manager.name}</td>
			<td>${manager.password}</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>