<%@page import="dao.DB_Connector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
	// 인코딩이 받아오는 것보다 먼저야 함!!! 이부분이 위가 아니면 오라클에 들어가는 데이터의 한글이 깨짐
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user_bean" class="bean.UserBean" scope="session"></jsp:useBean>
<jsp:useBean id="board_bean" class="bean.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board_bean" />
<%
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String path = request.getContextPath();

	//DB 접속
	Connection conn = DB_Connector.getConnection();

	String sql = null;

	switch (board_num) {
	case 1:
		// 공지사항 쿼리문 (글번호, 글제목, 내용, 날짜, 조회수, 회원_인덱스)
		sql = "insert into notice values("
				+ "notice_seq.nextval, ?, ?, sysdate, 0, ?)";
		break;
	case 2:
		// 수강 후기
		sql = "insert into epilogue values("
				+ "epilogue_seq.nextval, ?, ?, sysdate, 0, ?)";
		break;
	case 3:
		// 이벤트
		sql = "insert into event values("
				+ "event_seq.nextval, ?, ?, sysdate, 0, ?)";
		break;
	case 4:
		// 질문
		sql = "insert into question values("
				+ "question_seq.nextval, ?, ?, sysdate, 0, ?)";
		break;
	case 5:
		// 1:1 게시판
		sql = "insert into onequest values("
				+ "onequest_seq.nextval, ?, ?, sysdate, 0, ?)";
		break;
	case 6:
		// faq 게시판
		sql = "insert into faq values("
				+ "faq_seq.nextval, ?, ?, sysdate, 0, ?)";
		break;
	}

	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, board_bean.getBoard_title());
	pstmt.setString(2, board_bean.getBoard_content());
	// 이부분 임시 값 (나중에 로그인 부분 구성하면 다시 설정)
	pstmt.setInt(3, user_bean.getUser_idx());

	// 쿼리 실행
	pstmt.execute();

	switch (board_num) {
	case 1:
		// 작성된 글의 인덱스 번호를 추출
		sql = "select notice_seq.currval from dual";
		break;
	case 2:
		// 수강 후기
		sql = "select epilogue_seq.currval from dual";
		break;
	case 3:
		// 수강 후기
		sql = "select event_seq.currval from dual";
		break;
	case 4:
		// 질문
		sql = "select question_seq.currval from dual";
		break;
	case 5:
		// 질문
		sql = "select onequest_seq.currval from dual";
		break;
	case 6:
		// 질문
		sql = "select faq_seq.currval from dual";
		break;
	}

	PreparedStatement pstmt2 = conn.prepareStatement(sql);
	ResultSet rs = pstmt2.executeQuery();
	rs.next();
	int board_idx = rs.getInt(1);

	switch (board_num) {
	case 1:
		// 글 보는 페이지로 이동
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