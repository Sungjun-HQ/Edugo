<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="user_bean" class="bean.UserBean" scope="session"></jsp:useBean>

<%@ include file="/header_footer/header.jsp"%>

<%
	// 보드 리스트 페이지에서 넘어온 보드 번호 저장
	String board_idx = request.getParameter("board_idx");
	// 보드 리스트 페이지에서 넘어온 보드 페이지 저장했다가 다시 메인으로 돌아갈때 위치를 보여줌
	String page_num = request.getParameter("page_num");

	// DB 접속
	Connection conn = DB_Connector.getConnection();

	// index 번째 글 데이터를 추출
	String sql = "select e.epilogue_idx, e.epilogue_title, e.epilogue_content,"
			+ " e.epilogue_date, e.epilogue_count, u.user_id"
			+ " from user_table u, epilogue e"
			+ " where u.user_idx=e.user_idx and e.epilogue_idx=?";

	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, board_idx);
	ResultSet rs = pstmt.executeQuery();
	// rs 데이터로 커서 위치
	rs.next();

	// 조회수 1 추가
	// 조회수 조작을 방지하기 위한 여러가지 장치를 두어야 한다.
	// 작성자와 로그인한 사람이 같으면 X
	// 동일 아이피로 일정 시간 안에는 두번 못올리게 한다.
	// 기타 등등...
	String sql2 = "update epilogue set epilogue_count=? where epilogue_idx=?";

	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	pstmt2.setInt(1, rs.getInt(5) + 1);
	pstmt2.setString(2, board_idx);
	pstmt2.execute();

	// 댓글 테이블 가져오기

	// 게시판 제목, 게시판 내용, 게시판 카운트, 게시판 등록일, 회원 아이디
	String board_title = rs.getString(2);
	String board_content = rs.getString(3);
	String board_count = rs.getString(5);
	String board_date = rs.getString(4);
	String user_id = rs.getString(6);
	
	conn.close();
%>

<link rel="stylesheet" href="../css/test_sub.css">
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		$("#menu li").click(function() {
			$("#menu li").removeClass("active");
			$(this).addClass("active");
		});
	});
</script>

<%@ include file="/header_footer/header_next.jsp"%>

		<div class="row">
		
			<div class="menu col-md-3">
				<ul class="nav nav-pills nav-stacked" id="menu">
					<li><a href="<%=path%>/community/notice.jsp">공지사항</a></li>
					<li class="active"><a href="<%=path%>/community/epilogue.jsp">수강후기</a></li>
					<li><a href="<%=path%>/community/event.jsp">이벤트</a></li>
					<li><a href="<%=path%>/community/q&a.jsp">질문</a></li>
				</ul>
			</div>
			
			<div class="body col-md-9">
			
				<h3>수강후기 > READ</h3>
				<br />
				
				<div class="bodyinborder">
					
					<div class="row">

						<div class="col-md-6">
							<h4><span class="text-muted">제 목 :</span><%=board_title%></h4>
						</div>
						
						<div class="col-md-6 right">
							<span class="text-muted">등록일</span> : <%=board_date%>
							<br />
							<span class="text-muted">아이디</span> : <%=user_id%>
							<br/>
							<span class="badge">hit</span> : <%=board_count%>
						</div>
						
					</div>
	
					<hr>
	
					<div class="col-md-12">
						<h5 class="ptag"><%=board_content%></h5>
					</div>
	
					<div class="right">
						<a href="<%=path%>/community/epilogue.jsp?page_num=<%=page_num%>" class="btn btn-default">목록보기</a>
						<%
							if (user_id.equals(user_bean.getUser_id())) {
						%>
						<a href="<%=path%>/community/epilogue_modify.jsp?board_idx=<%=board_idx%>&page_num=<%=page_num%>" class="btn btn-default">수정</a>
						<a href="<%=path%>/board/board_delete_pro.jsp?board_idx=<%=board_idx%>&board_num=2" class="btn btn-default">삭제</a>
						<%
							}
						%>
					</div>
					
				</div>
			</div>
			
		</div>

<%@ include file="/header_footer/footer.jsp"%>