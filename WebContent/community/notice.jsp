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
	// 공지사항에 보여줄 데이터를 가져오기
	// 페이지 번호를 넘겨주면 DB에 접속해서 데이터를 가져온다.
	// 각 게시판마다 넘기는 값을 기준으로 각각의 게시판 내용을 가져올수 있도록 코드를 짜야 할듯
	// 1: 공지사항
	ArrayList<HashMap<String, Object>> notice_list = BoardDAO.getBoard(page_num, 1);

	// 전체 게시글의 갯수를 구한다.
	// notice 테이블(공지사항 테이블)의 갯수를 구해오는 쿼리문
	String sql2 = "select count(*) from notice";
	// Statement 생성
	Statement stmt = conn.createStatement();
	// stmt 실행한 결과를 ResultSet에 저장
	ResultSet rs2 = stmt.executeQuery(sql2);
	// ResultSet에 저장한 데이터를 가져오기 위헤 일단 next();
	rs2.next();

	// 가져온 게시글 수를 page_cnt를 선언하고 저장
	int page_cnt = rs2.getInt(1);
	// page_cnt에 10으로 나눈 값을 저장 (이유: 한 페이지에 10개씩 데이터를 보여주기 위해)
	page_cnt = page_cnt / 10;
	// 10으로 나눈 나머지가 0이 아니면
	if (page_cnt % 10 != 0) {
		// 페이지 수를 증가
		page_cnt++;
	}
	
	String chk_login = (String) session.getAttribute("login");
	
	String date = null;
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
	
	$(function(){
		$("#board_list tbody tr").click(function(){
			// 클릭한 글의 인덱스 번호를 추출
			var idx = $(this).data("idx");
			// 이동한다.
			location.href = "<%=path2%>/community/notice_read.jsp?board_idx=" + idx + "&page_num=" + <%=page_num%>;
		});
		// 페이지 번호 셋팅
		$("#page_indicator li:nth-child(<%=page_num%>)").addClass("active");
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
			
				<h3>공지사항</h3>
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
							for (HashMap<String, Object> map : notice_list) {
								date = (String)map.get("board_date");
								date = date.substring(0, 10);
						%>
							<tr data-idx="<%=map.get("board_idx")%>">
								<td class="center"><%=map.get("board_idx")%></td>
								<td><a href="<%=path%>/community/notice_read.jsp?board_idx=<%=map.get("board_idx")%>&page_num=<%=page_num%>"><%=map.get("board_title")%></a></td>
								<td class="center"><%=date%></td>
								<td class="center"><%=map.get("user_id")%></td>
								<td class="center"><%=map.get("board_count")%></td>
							</tr>
						<%
							}
						%>
						</tbody>
					</table>
					
					<!-- 페이지 번호 구현 부분 -->
					<div class="center">
						<ul class="pagination pagination-sm" id="page_indicator">
							<%
								for (int i = 0; i < page_cnt; i++) {
							%>
							<li>
								<a href="<%=path%>/community/notice.jsp?page_num=<%=i + 1%>"><%=i + 1%></a>
							</li>
							<%
								}
							%>
						</ul>
					</div>
					<div class="right">
						<%
							if (chk_login!=null) {
						%>
						<a href="<%=path%>/community/notice_write.jsp" class="btn btn-default">글쓰기</a>
						<%
							}
						%>
					</div>
				</div>
			</div>
			
		</div>

<%@ include file="/header_footer/footer.jsp"%>