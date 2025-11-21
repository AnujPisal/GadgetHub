<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
String user = (String) session.getAttribute("currentUser");
if(user == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

</body>
</html>