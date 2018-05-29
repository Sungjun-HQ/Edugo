<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%@ include file="/header_footer/header.jsp"%>
<jsp:useBean id="board_bean" class="bean.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board_bean"/>

<%
	Connection conn = DB_Connector.getConnection();

	// 페이지 번호 추출
	String page_num = request.getParameter("page_num");
	
	String sql = "select * from epilogue where epilogue_idx=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, board_bean.getBoard_idx());
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
					<li><a href="<%=path%>/community/notice.jsp">공지사항</a></li>
					<li class="active"><a href="<%=path%>/community/epilogue.jsp">수강후기</a></li>
					<li><a href="<%=path%>/community/event.jsp">이벤트</a></li>
					<li><a href="<%=path%>/community/q&a.jsp">질문</a></li>
				</ul>
			</div>
			
			<div class="body col-md-9">
			
				<h3>수강후기 > READ > MODIFY</h3>
				<br />
				
				<div class="bodyinborder">
					<form action="<%=path%>/board/board_modify_pro.jsp?board_idx=<%=board_bean.getBoard_idx()%>&page_num=<%=page_num%>&board_num=2" method="post">
					
						<div class="form-group">
							<label for="board_title">제목 : </label> 
							<input type="text" class="form-control" name="board_title" value="<%=rs.getString("epilogue_title")%>" />
						</div>
						
						<div class="form-group">
							<label for="board_content">내용 : </label>
							<textarea class="form-control" name="board_content" rows="10"><%=rs.getString("epilogue_content")%></textarea>
						</div>
						
						<div class="right">
							<input type="submit" value="수정 완료" class="btn btn-default" style="outline:none;" />
							<input type="reset" value="초기화" class="btn btn-default" style="outline:none;" />
							<a href="<%=path%>/community/epilogue_read.jsp?board_idx=<%=board_bean.getBoard_idx()%>&page_num=<%=page_num%>" class="btn btn-default">이전으로</a>
						</div>
					</form>
					
				</div>
			</div>
			
		</div>

<%@ include file="/header_footer/footer.jsp"%>