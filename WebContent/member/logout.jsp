<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
	//세션 정보를 제거
	session.setAttribute("login", null);
	session.invalidate();

	String path = request.getContextPath();
	response.sendRedirect(path+"/index.jsp");
%>