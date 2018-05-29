<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="dao.BoardDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%@ include file="/header_footer/header.jsp"%>

<%
	String board_idx = request.getParameter("board_idx");
	String page_num = request.getParameter("page_num");
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
			
				<h3>FAQ > WRITE</h3>
				<br/>

				<div class="bodyinborder">

					<form action="<%=path%>/board/board_write_pro.jsp?board_num=6" method="post">
					
						<div class="form-group">
							<label for="board_title">제목 : </label>
							<input type="text" class="form-control" name="board_title" required="required" />
						</div>
						
						<div class="form-group">
							<label for="board_content">내용 : </label>
							<textarea class="form-control" name="board_content" rows="10" required="required" wrap="hard"></textarea>
						</div>
						
						<div class="right">
							<input type="submit" class="btn btn-default" value="작성 완료" style="outline: none;" />
							<input type="reset" class="btn btn-default" value="초기화" style="outline: none;" />
							<a href="<%=path%>/help/faq.jsp" class="btn btn-default">뒤로</a>
						</div>
						
					</form>
					
				</div>
			</div>

		</div>

<%@ include file="/header_footer/footer.jsp"%>