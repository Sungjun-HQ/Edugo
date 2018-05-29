<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%@ include file="/header_footer/header.jsp"%>

<%
	String path2 = request.getContextPath();

	Connection conn = DB_Connector.getConnection();

	// 페이지 번호 파라미터
	int page_num = 0;
	String page_num_str = request.getParameter("page_num");
	try {
		page_num = Integer.parseInt(page_num_str);
	} catch (Exception e) {
		page_num = 1;
	}
	
	// 4: question
	ArrayList<HashMap<String, Object>> question_list = BoardDAO.getBoard(page_num, 4);

	String sql2 = "select count(*) from question";
	Statement stmt = conn.createStatement();
	ResultSet rs2 = stmt.executeQuery(sql2);
	rs2.next();

	int page_cnt = rs2.getInt(1);
	page_cnt = page_cnt / 10;
	if (page_cnt % 10 != 0) {
		page_cnt++;
	}

	String chk_login = (String) session.getAttribute("login");

	String date = null;
	conn.close();
%>

<link rel="stylesheet" href="../css/test_sub.css">
<title>에듀고 > 질문 게시판</title>

<script type="text/javascript">
	$(function() {
		$("#menu li").click(function() {
			$("#menu li").removeClass("active");
			$(this).addClass("active");
		});
	});

	$(function(){
		$("#board_list tbody tr").click(function(){
			// 클릭한 글의 인덱스 번호를 추출
			var idx = $(this).data("idx");
			// 이동한다.
			location.href = "<%=path2%>/community/q&a_read.jsp?board_idx=" + idx + "&page_num=" + <%=page_num%>;
		});
		// 페이지 번호 셋팅
		$("#page_indicator li:nth-child(<%=page_num%>)").addClass("active");
	});
</script>

<%@ include file="/header_footer/header_next.jsp"%>

		<div class="row">

			<div class="menu col-md-3">
				<ul class="nav nav-pills nav-stacked" id="menu">
					<li><a href="<%=path%>/community/notice.jsp">공지사항</a></li>
					<li><a href="<%=path%>/community/epilogue.jsp">수강후기</a></li>
					<li><a href="<%=path%>/community/event.jsp">이벤트</a></li>
					<li class="active"><a href="<%=path%>/community/q&a.jsp">질문</a></li>
				</ul>
			</div>

			<div class="body col-md-9">
			
				<h3>Q&A</h3>
				<br />
				
				<div class="bodyinborder">
				
					<table class="table table-hover" id="board_list">
						<thead>
							<tr>
								<th width="9%" class="center">글번호</th>
								<th class="center">글 제목</th>
								<th width="12%" class="center">날짜</th>
								<th width="9%" class="center">작성자</th>
								<th width="9%" class="center">조회수</th>
							</tr>
						</thead>
						<tbody>
							<%
								for (HashMap<String, Object> map : question_list) {
									date = (String)map.get("board_date");
									date = date.substring(0, 10);
							%>
							<tr data-idx="<%=map.get("board_idx")%>">
								<td class="center"><%=map.get("board_idx")%></td>
								<td><a href="<%=path%>/community/q&a_read.jsp?board_idx=<%=map.get("board_idx")%>&page_num=<%=page_num%>"><%=map.get("board_title")%></a></td>
								<td class="center"><%=date%></td>
								<td class="center"><%=map.get("user_id")%></td>
								<td class="center"><%=map.get("board_count")%></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>

					<div class="center">
						<!-- 페이지 번호 구현 부분 -->
						<ul class="pagination pagination-sm" id="page_indicator">
							<%
								for (int i = 0; i < page_cnt; i++) {
							%>
							<li>
								<a href="<%=path%>/community/q&a.jsp?page_num=<%=i + 1%>"><%=i + 1%></a>
							</li>
							<%
								}
							%>
						</ul>
					</div>
					
					<%-- 글쓰기 버튼 --%>
					<div class="right">
						<%
							if (chk_login!=null) {
						%>
						<a href="<%=path%>/community/q&a_write.jsp" class="btn btn-default">글쓰기</a>
						<%
							}
						%>
					</div>
					
				</div>
			</div>
			
		</div>

<%@ include file="/header_footer/footer.jsp"%>