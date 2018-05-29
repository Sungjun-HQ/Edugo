<%@page import="dao.DB_Connector"%>
<%@page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
%>
<jsp:useBean id="board_bean" class="bean.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board_bean"></jsp:setProperty>
<%
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String sql = null;

	switch (board_num) {
	case 1:
		sql = "delete from notice where notice_idx=?";
		break;
	case 2:
		sql = "delete from epilogue where epilogue_idx=?";
		break;
	case 3:
		sql = "delete from event where event_idx=?";
		break;
	case 4:
		sql = "delete from question where quest_idx=?";
		break;
	case 5:
		sql = "delete from onequest where onequest_idx=?";
		break;
	case 6:
		sql = "delete from faq where faq_idx=?";
		break;
	}

	Connection conn = DB_Connector.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, board_bean.getBoard_idx());
	pstmt.execute();

	switch (board_num) {
	case 1:
		response.sendRedirect(path + "/community/notice.jsp");
		break;
	case 2:
		response.sendRedirect(path + "/community/epilogue.jsp");
		break;
	case 3:
		response.sendRedirect(path + "/community/event.jsp");
		break;
	case 4:
		response.sendRedirect(path + "/community/q&a.jsp");
		break;
	case 5:
		response.sendRedirect(path + "/help/one_quest.jsp");
		break;
	case 6:
		response.sendRedirect(path + "/help/faq.jsp");
		break;
	}
%>