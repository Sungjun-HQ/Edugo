<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path3 = request.getContextPath();
	
	// 세션에서 login 데이터를 추출
	String login_chk = (String) session.getAttribute("login");
	if (login_chk == null || login_chk.length() == 0) {
		// 메인페이지로 강제 이동시킨다.
		response.sendRedirect(path3 + "/index.jsp");
	}
%>
