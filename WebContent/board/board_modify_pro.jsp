<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="dao.DB_Connector"%>
<%
	// 인코딩이 받아오는 것보다 먼저야 함!!! 이부분이 위가 아니면 오라클에 들어가는 데이터의 한글이 깨짐
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="board_bean" class="bean.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board_bean" />
<%
	String path = request.getContextPath();

	Connection conn = DB_Connector.getConnection();

	String page_num = request.getParameter("page_num");
	int board_num = Integer.parseInt(request.getParameter("board_num"));

	String sql = null;

	switch (board_num) {
	case 1:
		sql = "update notice set notice_title=?, notice_content=? where notice_idx=?";
		break;
	case 2:
		sql = "update epilogue set epilogue_title=?, epilogue_content=? where epilogue_idx=?";
		break;
	case 3:
		sql = "update event set event_title=?, event_content=? where event_idx=?";
		break;
	case 4:
		sql = "update question set quest_title=?, quest_content=? where quest_idx=?";
		break;
	case 5:
		sql = "update onequest set onequest_title=?, onequest_content=? where onequest_idx=?";
		break;
	case 6:
		sql = "update faq set faq_title=?, faq_content=? where faq_idx=?";
		break;
	}

	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, board_bean.getBoard_title());
	pstmt.setString(2, board_bean.getBoard_content());
	pstmt.setInt(3, board_bean.getBoard_idx());
	pstmt.execute();

	switch (board_num) {
	case 1:
		response.sendRedirect(path
				+ "/community/notice_read.jsp?board_idx="
				+ board_bean.getBoard_idx() + "&page_num=" + page_num);
		break;
	case 2:
		response.sendRedirect(path
				+ "/community/epilogue_read.jsp?board_idx="
				+ board_bean.getBoard_idx() + "&page_num=" + page_num);
		break;
	case 3:
		response.sendRedirect(path
				+ "/community/event_read.jsp?board_idx="
				+ board_bean.getBoard_idx() + "&page_num=" + page_num);
		break;
	case 4:
		response.sendRedirect(path
				+ "/community/q&a_read.jsp?board_idx="
				+ board_bean.getBoard_idx() + "&page_num=" + page_num);
		break;
	case 5:
		response.sendRedirect(path
				+ "/help/onequest_read.jsp?board_idx="
				+ board_bean.getBoard_idx() + "&page_num=" + page_num);
		break;
	case 6:
		response.sendRedirect(path
				+ "/help/faq_read.jsp?board_idx="
				+ board_bean.getBoard_idx() + "&page_num=" + page_num);
		break;
	}
%>