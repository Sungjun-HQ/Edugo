<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="dao.BoardDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%@ include file="/header_footer/header.jsp"%>

<%
	// 보드 리스트 페이지에서 넘어온 보드 번호 저장
	String board_idx = request.getParameter("board_idx");
	// 보드 리스트 페이지에서 넘어온 보드 페이지 저장했다가 다시 메인으로 돌아갈때 위치를 보여줌
	String page_num = request.getParameter("page_num");
%>

<link rel="stylesheet" href="../css/test_sub.css">
<title>에듀고 : 커뮤니티 > 공지사항</title>
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
					<li class="active"><a href="<%=path%>/community/notice.jsp">공지사항</a></li>
					<li><a href="<%=path%>/community/epilogue.jsp">수강후기</a></li>
					<li><a href="<%=path%>/community/event.jsp">이벤트</a></li>
					<li><a href="<%=path%>/community/q&a.jsp">질문</a></li>
				</ul>
			</div>

			<div class="body col-md-9">
			
				<h3>공지사항 > WRITE</h3>
				<br />
				
				<div class="bodyinborder">
				
					<form action="<%=path%>/board/board_write_pro.jsp?board_num=1" method="post">
					
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
							<a href="<%=path%>/community/notice.jsp" class="btn btn-default">뒤로</a>
						</div>
					</form>
					
				</div>
			</div>

		</div>

<%@ include file="/header_footer/footer.jsp"%>