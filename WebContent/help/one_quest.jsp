<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%@ include file="/header_footer/header.jsp"%>

<%
	Connection conn = DB_Connector.getConnection();

	// 페이지 번호 파라미터
	int page_num = 0;
	String page_num_str = request.getParameter("page_num");
	try {
		page_num = Integer.parseInt(page_num_str);
	} catch (Exception e) {
		page_num = 1;
	}
	
	// 5: 1:1 게시판
	ArrayList<HashMap<String, Object>> one_list = BoardDAO.getBoard(page_num, 5);

	// 전체 게시글의 갯수를 구한다.
	// notice 테이블(공지사항 테이블)의 갯수를 구해오는 쿼리문
	String sql2 = "select count(*) from onequest";
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
%>

<link rel="stylesheet" href="../css/test_sub.css">
<style type="text/css">
/* 게시판 틀을 보려고 잠시 넣은 css 값 */
table {
	width: 722px;
	text-align: center;
}

table, th, td {
	border: 1px solid black;
}
</style>
<title>에듀고 > 고객센터</title>
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
						<li><a href="<%=path%>/help/faq.jsp">FAQ</a></li>
						<li class="active"><a href="<%=path%>/help/one_quest.jsp">1:1 문의</a></li>
					</ul>
					
				</div>
				
				<div class="body col-md-9">
				
					<h3>1:1 문의</h3>
					<br/>
					
					<div class="bodyinborder">
						<%-- board_num=5 1:1 질문 게시판 --%>
						<form action="<%=path%>/board/board_write_pro.jsp?board_num=5" method="post">
							<div class="form-group">
								<label for="borad_title">제목 : </label>
								<input type="text" class="form-control" name="board_title" />
							</div>
							
							<div class="form-group">
								<label for="board_content">내용 : </label>
								<textarea class="form-control" rows="10" name="board_content" ></textarea>
							</div>
							
							<div class="right">
								<%
								if (chk_login!=null) {
									// 로그인이 안돼 있을시 작성 불가능 부분 
									// jQuery로 다시 구현
								%>
								<input type="submit" class="btn btn-default" style="outline: none" value="작성 완료" />
								<input type="reset"  class="btn btn-default" style="outline: none" value="초기화"/>
								<%
									}
								%>
							</div>
							<br />
						</form>
					</div>
					
					<br />
					<br />
					--데이터가 잘 들어갔는지 확인용--
					<table>
						<tr>
							<td width="10%">글번호</td>
							<td>글 제목</td>
							<td width="10%">날짜</td>
							<td width="20%">작성자</td>
							<td width="10%">조회수</td>
						</tr>
						<%
							for (HashMap<String, Object> map : one_list) {
						%>
						<tr>
							<td><%=map.get("board_idx")%></td>
							<td><a href="<%=path%>/help/one_quest_read.jsp?board_idx=<%=map.get("board_idx")%>&page_num=<%=page_num%>"><%=map.get("board_title")%></a></td>
							<td><%=map.get("board_date")%></td>
							<td><%=map.get("user_id")%></td>
							<td><%=map.get("board_count")%></td>
						</tr>
						<%
							}
						%>
					</table>
				</div>
				
			</div>
		
<%@ include file="/header_footer/footer.jsp"%>