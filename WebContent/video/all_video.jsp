<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%@ include file="/header_footer/header.jsp"%>

<jsp:useBean id="user_bean" class="bean.UserBean" scope="session"></jsp:useBean>

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
	
	ArrayList<HashMap<String, Object>> video_list = VideoDAO.getVideo(page_num);

	String sql2 = "select count(*) from video";
	Statement stmt = conn.createStatement();
	ResultSet rs2 = stmt.executeQuery(sql2);
	rs2.next();

	int page_cnt = rs2.getInt(1);
	page_cnt = page_cnt / 10;
	if (page_cnt % 10 != 0) {
		page_cnt++;
	}
	
	String chk_login = (String) session.getAttribute("login");

	conn.close();
%>

<link rel="stylesheet" href="../css/test_sub.css">
<title>에듀고 > 동영상 강의</title>

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
			location.href = "<%=path2%>/video/all_video_read.jsp?video_idx=" + idx + "&page_num=" + <%=page_num%>;
		});
		// 페이지 번호 셋팅
		$("#page_indicator li:nth-child(<%=page_num%>)").addClass("active");
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
				<h3>전체 동영상</h3>
				<br />
				
				<div class="bodyinborder">
				<table class="table table-hover" id="board_list">
					<thead>
						<tr>
							<th class="center">글번호</th>
							<th class="center">과목 이름</th>
							<th class="center">동영상 제목</th>
							<th class="center">강사</th>
							<th class="center">수강 신청</th>
						</tr>
					</thead>
					<tbody>
						<%
							for (HashMap<String, Object> map : video_list) {
						%>
						<tr data-idx="<%=map.get("video_idx")%>">
							<td class="center"><%=map.get("video_idx")%></td>
							<td class="center"><%=map.get("subject")%></td>
							<td><a href="<%=path%>/video/all_video_read.jsp?video_idx=<%=map.get("video_idx")%>&page_num=<%=page_num%>"><%=map.get("video_name")%></a></td>
							<td class="center"><%=map.get("user_name")%></td>
							<td class="center"><a href="<%=path%>/pay/pay.jsp?video_idx=<%=map.get("video_idx")%>&page_num=<%=page_num%>">신청하기</a></td>
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
							<a href="<%=path%>/video/all_video.jsp?page_num=<%=i + 1%>"><%=i + 1%></a>
						</li>
						<%
							}
						%>
					</ul>
				</div>
				
				<%-- 글쓰기 버튼 --%>
				<div class="right">
					<%
						if (chk_login!=null && user_bean.getUser_id().equals("tester")) {
					%>
					<a href="<%=path%>/video/all_video_write.jsp" class="btn btn-default">강의올리기</a>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
		
<%@ include file="/header_footer/footer.jsp"%>