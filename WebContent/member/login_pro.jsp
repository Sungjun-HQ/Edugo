<%@page import="dao.UserDAO"%>
<%@page import="bean.UserBean"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
%>
<jsp:useBean id="user_bean" class="bean.UserBean" />
<jsp:setProperty property="*" name="user_bean" />
<%
	UserBean user = UserDAO.check_login(user_bean);

	// 로우를 선택
	if (user == null) {
		// 등록되지 않은 아이디
		response.sendRedirect(path + "/member/login.jsp?login_fail=1");
	} else {
		// 등록된 아이디
		String pw1 = user_bean.getUser_pw();
		String pw2 = user.getUser_pw();
		if (pw1.equals(pw2) == false) {
			response.sendRedirect(path + "/member/login.jsp?login_fail=2");
		} else {
			// 세션에 담아준다.
			session.setAttribute("login", "OK");
			session.setAttribute("user_bean", user);

			response.sendRedirect(path + "/index.jsp");
		}
	}
%>