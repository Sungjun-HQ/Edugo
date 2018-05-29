<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="user_bean" class="bean.UserBean" scope="session"></jsp:useBean>

<%@ include file="/header_footer/header.jsp"%>

<%
	String board_idx = request.getParameter("board_idx");
	String page_num = request.getParameter("page_num");

	Connection conn = DB_Connector.getConnection();

	String sql = "select e.event_idx, e.event_title, e.event_content,"
			+ " e.event_date, e.event_count, u.user_id"
			+ " from user_table u, event e"
			+ " where u.user_idx=e.user_idx and e.event_idx=?";

	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, board_idx);
	ResultSet rs = pstmt.executeQuery();
	rs.next();

	// 조회수 조작을 방지하기 위한 여러가지 장치를 두어야 한다.
	// 작성자와 로그인한 사람이 같으면 X
	// 동일 아이피로 일정 시간 안에는 두번 못올리게 한다.
	String sql2 = "update event set event_count=? where event_idx=?";

	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	pstmt2.setInt(1, rs.getInt(5) + 1);
	pstmt2.setString(2, board_idx);
	pstmt2.execute();

	String board_title = rs.getString(2);
	String board_content = rs.getString(3);
	
	// db에서 불러온 글에 줄바꿈을 <br>로 치환
	board_content = board_content.replace("\r\n","<br>");
	
	String board_count = rs.getString(5);
	String board_date = rs.getString(4);
	String user_id = rs.getString(6);
	
	board_date = board_date.substring(0, 10);
	
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
					<li><a href="<%=path%>/community/epilogue.jsp">수강후기</a></li>
					<li class="active"><a href="<%=path%>/community/event.jsp">이벤트</a></li>
					<li><a href="<%=path%>/community/q&a.jsp">질문</a></li>
				</ul>
			</div>
			
			<div class="body col-md-9">
				
				<h3>Event > READ</h3>
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
						<a href="<%=path%>/community/event.jsp?page_num=<%=page_num%>" class="btn btn-default">목록보기</a>
						<%-- 작성자와 로그인한 사람이 같을 경우 나타나게 한다. --%>
						<%
							if (user_id.equals(user_bean.getUser_id())) {
						%>
						<a href="<%=path%>/community/event_modify.jsp?board_idx=<%=board_idx%>&page_num=<%=page_num%>" class="btn btn-default">수정</a>
						<a href="<%=path%>/board/board_delete_pro.jsp?board_idx=<%=board_idx%>&board_num=3" class="btn btn-default">삭제</a>
						<%
							}
						%>
					</div>
					
				</div>
				
			</div>
			
		</div>

<%@ include file="/header_footer/footer.jsp"%>
