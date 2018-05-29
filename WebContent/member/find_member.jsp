<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 비밀번호 찾기</title>
</head>
<body>
	아이디 찾기
	<br />
	<br /> 이름
	<input type="text" />
	<br /> 휴대전화
	<input type="number" />
	<br /> or 이메일
	<input type="email" />
	<br />
	<br />
	<br /> 비밀번호 찾기
	<br />
	<br /> 아이디
	<input type="text" />
	<br /> 이름
	<input type="text" />
	<br /> 이메일
	<input type="email" />
	<br />
	<br />
	<br />
	<a href="<%=path%>/index.jsp">메인으로 가기</a>
</body>
</html>