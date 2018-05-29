<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	
	String sql = "select * from faq where faq_idx=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, board_bean.getBoard_idx());
	ResultSet rs = pstmt.executeQuery();
	rs.next();
%>

<link rel="stylesheet" href="../css/test_sub.css">
<title>에듀고 > faq</title>
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
					<li class="active"><a href="<%=path%>/help/faq.jsp">FAQ</a></li>
					<li><a href="<%=path%>/help/one_quest.jsp">1:1 문의</a></li>
				</ul>
			</div>
			
			<div class="body col-md-9">
			
				<h3>FAQ > READ > MODIFY</h3>
				<br />
				
				<div class="bodyinborder">
					<form action="<%=path%>/board/board_modify_pro.jsp?board_idx=<%=board_bean.getBoard_idx()%>&page_num=<%=page_num%>&board_num=6" method="post">
					
						<div class="form-group">
							<label for="board_title">제목 : </label> 
							<input type="text" class="form-control" name="board_title" value="<%=rs.getString("faq_title")%>" />
						</div>
						
						<div class="form-group">
							<label for="board_content">내용 : </label>
							<textarea class="form-control" name="board_content" rows="10"><%=rs.getString("faq_content")%></textarea>
						</div>
						
						<div class="right">
							<input type="submit" value="수정 완료" class="btn btn-default" style="outline:none;"/>
							<input type="reset" value="초기화" class="btn btn-default" style="outline:none;"/>
							<a href="<%=path%>/help/faq_read.jsp?board_idx=<%=board_bean.getBoard_idx()%>&page_num=<%=page_num%>" class="btn btn-default">이전으로</a>
						</div>
					</form>
					
				</div>
				
			</div>
			
		</div>

<%@ include file="/header_footer/footer.jsp"%>