<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="user_bean" class="bean.UserBean" scope="session"></jsp:useBean>

<%@ include file="/header_footer/header.jsp"%>

<%
	String board_idx = request.getParameter("video_idx");
	String page_num = request.getParameter("page_num");

	Connection conn = DB_Connector.getConnection();

	/* String sql = "select e.event_idx, e.event_title, e.event_content,"
			+ " e.event_date, e.event_count, u.user_id"
			+ " from user_table u, event e"
			+ " where u.user_idx=e.user_idx and e.event_idx=?"; */
			
	String sql = "select v.video_idx, s.sub_name, v.video_name, u.user_name, v.video_count, v.video_content " + 
			"from user_table u, subject s, video v " +
			"where u.user_idx=s.user_idx and v.sub_idx=s.sub_idx and v.video_idx=?";

	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, board_idx);
	ResultSet rs = pstmt.executeQuery();
	rs.next();

	// 조회수 조작을 방지하기 위한 여러가지 장치를 두어야 한다.
	// 작성자와 로그인한 사람이 같으면 X
	// 동일 아이피로 일정 시간 안에는 두번 못올리게 한다.
	String sql2 = "update video set video_count=? where video_idx=?";

	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	pstmt2.setInt(1, rs.getInt(5) + 1);
	pstmt2.setString(2, board_idx);
	pstmt2.execute();

	String subject = rs.getString(2);
	String video_title = rs.getString(3);
	String user_name = rs.getString(4);
	String video_count = rs.getString(5);
	String video_content = rs.getString(6);
%>

<link rel="stylesheet" href="../css/test_sub.css">
<title>전체 동영상</title>
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
					<li class="active"><a href="<%=path%>/video/all_video.jsp">전체</a></li>
					<li><a href="#">정보처리기사</a></li>
					<li><a href="#">전산세무2급</a></li>
				</ul>
			</div>
			
			<div class="body col-md-9">
			
				<h3>전체 동영상> 강의소개</h3>
				<br />
				
				<div class="bodyinborder">
				
					<div class="row">
					
						<div class="col-sm-5">
							<img src="<%=path%>/image/example.png" style="float: left;" class="img-thumbnail" />
						</div>
						
						<div class="col-sm-7">								
							<h4> 과목 : <%=subject%> </h4>
							<h4> 제목 : <%=video_title%> </h4>
							<h4> 강사 이름 : <%=user_name%> </h4>
							<h4> 카운트 : <%=video_count%> </h4>
							<h4> 강의 소개 내용 : <%=video_content %> </h4>
						</div>
						
					</div>
						
					<div class="right">
						<a href="<%=path%>/video/all_video.jsp?page_num=<%=page_num%>" class="btn btn-default">목록보기</a>
						
						<%-- 작성자와 로그인한 사람이 같을 경우 나타나게 한다. --%>
						<%
							if ( user_bean.getUser_id() != null && user_bean.getUser_id().equals("tester") ) {
						%>
						<a href="<%=path%>/video/video_modify.jsp?board_idx=<%=board_idx%>&page_num=<%=page_num%>" class="btn btn-default">수정</a>
						<%-- <a href="<%=path%>/board/board_delete_pro.jsp?board_idx=<%=board_idx%>&board_num=3">삭제</a> --%>
						<%
							}
						%>
					</div>
					
				</div>
			</div>
			
		</div>

<%@ include file="/header_footer/footer.jsp"%>