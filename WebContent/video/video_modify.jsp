<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%@ include file="/header_footer/header.jsp"%>
<%-- <jsp:useBean id="board_bean" class="bean.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board_bean"/> --%>

<%
	String board_idx = request.getParameter("board_idx");

	Connection conn = DB_Connector.getConnection();

	// 페이지 번호 추출
	String page_num = request.getParameter("page_num");
	
	String sql = "select * from video where video_idx=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	/* pstmt.setInt(1, board_bean.getBoard_idx()); */
	pstmt.setString(1, board_idx);
	ResultSet rs = pstmt.executeQuery();
	rs.next();
%>

<link rel="stylesheet" href="../css/test_sub.css">
<title>수강후기 수정하기</title>
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
				<p>body</p>
				<form action="<%=path%>/board/board_modify_pro.jsp?board_idx=<%=rs.getInt(1)%>&page_num=<%=page_num%>&board_num=2" method="post">
					제목 : 
					<br/>
					<input type="text" size="49" name="board_title" value="<%=rs.getString("video_name")%>" />
					<br />
					내용 : 
					<br/>
					<textarea cols="50" rows="10" name="board_content" ><%=rs.getString("video_content")%></textarea>
					<br />
					<input type="submit" value="수정 완료" />
					<input type="reset" value="초기화" />
					<br />
				</form>
				<br />
				<a href="<%=path%>/video/all_video_read.jsp?video_idx=<%=rs.getInt(1)%>&page_num=<%=page_num%>">이전으로</a>
			</div>
			
		</div>

<%@ include file="/header_footer/footer.jsp"%>