<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DB_Connector"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>

<%@ include file="/header_footer/header.jsp"%>

<%
	Connection conn = DB_Connector.getConnection();

	String path2 = request.getContextPath();

	String sql = "select * from "
			+ "(select rownum as rnum, a1.* from "
			+ "(select n.notice_idx, n.notice_title, n.notice_date "
			+ "from user_table u, notice n "
			+ "where u.user_idx=n.user_idx "
			+ "order by n.notice_idx desc) a1) a2 "
			+ "where a2.rnum >= ? and a2.rnum <=?";

	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, 1);
	pstmt.setInt(2, 3);
	ResultSet rs = pstmt.executeQuery();

	ArrayList<HashMap<String, Object>> notice_list = new ArrayList<HashMap<String, Object>>();

	while (rs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("board_idx", rs.getInt(2));
		map.put("board_title", rs.getString(3));
		map.put("board_date", rs.getString(4));

		notice_list.add(map);
	}

	conn.close();

	String date = null;
%>

<link rel="stylesheet" href="./css/test.css">
<title>에듀고 홈페이지</title>
<script>
	$(function(){
		$("#board_list tbody tr").click(function(){
			var idx = $(this).data("idx");
			location.href = "<%=path2%>/community/notice_read.jsp?board_idx=" + idx +"&page_num=" + "1";
		});
	});
</script>

<%@ include file="/header_footer/header_next.jsp"%>

		<div class="body">
			<div class="row">
			
				<div class="col-md-6">
					<%-- BootStrap Carousel(회전목마) 시작 --%>
					<div id="myCarousel" class="carousel slide" data-ride="carousel">
					
						<!-- Indicators -->
						<ol class="carousel-indicators">
						    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						    <li data-target="#myCarousel" data-slide-to="1"></li>
						    <li data-target="#myCarousel" data-slide-to="2"></li>
						    <li data-target="#myCarousel" data-slide-to="3"></li>
					  	</ol>
					  	
					  	<!-- Wrapper for slides -->
						<div class="carousel-inner" role="listbox">
							<div class="item active">
								<img src="<%=path%>/image/edumain.png" alt="edumain" class="img-rounded">
								<!-- <div class="carousel-caption">
									<h3>정보처리기사</h3>
									<p>강사님</p>
								</div> -->
							</div>
					
							<div class="item">
								<img src="<%=path%>/image/new_lecture.png" alt="new_lecture" class="img-rounded">
							</div>
							
							<div class="item">
								<img src="<%=path%>/image/summer.png" alt="summer" class="img-rounded">
							</div>
							
							<div class="item">
								<img src="<%=path%>/image/summer_event.png" alt="summer_event" class="img-rounded">
							</div>
						</div>
					  	
					</div>
				</div>
				
				<%-- bodyright 시작 --%>
				<div class="col-md-6">
				
					<div class="flip3D_1">
						<div class="back">
							<a href="<%=path%>/video/all_video.jsp" style="color: white;" target="_blank">
							<br />
							<br />
							<img src="<%=path%>/image/movie.png" />
							<br />
							<br />
							<p>바로가기</p>
							<br />
							<br />
							<br />
							<br />
							</a>
						</div>
		
						<div class="front">
							<br />
							<br />
							<img src="<%=path%>/image/movie.png" />
							<br />
							<br />
							<p>정보처리 기사</p>
							<br />
						</div>
					</div>
				
					<div class="flip3D_2">
						<div class="back">
							<a href="<%=path%>/video/all_video.jsp" style="color: white;" target="_blank">
							<br />
							<br />
							<img src="<%=path%>/image/movie.png" />
							<br />
							<br />
							<p>바로가기</p>
							<br />
							<br />
							<br />
							</a>
						</div>
		
						<div class="front">
							<br />
							<br />
							<img src="<%=path%>/image/movie.png" />
							<br />
							<br />
							<p>전산세무 2급</p>
							<br />
						</div>
					</div>
	
					<div class="flip3D_2">
						<div class="back">
							<a href="<%=path%>/community/event.jsp" style="color: white;" target="_blank">
							<br />
							<br />
							<img src="<%=path%>/image/event.png" />
							<br />
							<br />
							<p>바로가기</p>
							<br />
							<br />
							<br />
							</a>
						</div>
	
						<div class="front">
							<br />
							<br />
							<img src="<%=path%>/image/event.png" />
							<br />
							<br />
							<p>이벤트 게시판</p>
							<br />
						</div>
					</div>
		
					<div class="flip3D_1">
						<div class="back">
							<a href="<%=path%>/help/faq.jsp" style="color: white;" target="_blank">
							<br />
							<br />
							<img src="<%=path%>/image/center.png" />
							<br />
							<br />
							<p>1578-1578</p>
							<br />
							<br />
							<br />
							<br />
							</a>
						</div>
		
						<div class="front">
							<br />
							<br />
							<img src="<%=path%>/image/center.png" />
							<br />
							<br />
							<p>고객센터</p>
							<br />
						</div>
					</div>
					
				</div>
				<%-- bodyright 끝 --%>
				
			</div>
			
			<div class="row">
				
				<div class="col-md-7 ">
					<div class="bodyfooter1">
					
						<div class="row">
							<div class="col-sm-6">
								<b>-공지사항-</b>
							</div>
							<div class="right col-sm-6">
								<a href="<%=path%>/community/notice.jsp" class="my" >more</a>
							</div>
						</div>
						
						<table class="table table-hover" id="board_list">
							<thead>
								<tr>
									<th width="10%" class="center">글번호</th>
									<th class="center">글 제목</th>
									<th width="18%" class="center">날짜</th>
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
									<td><a href="<%=path%>/community/notice_read.jsp?board_idx=<%=map.get("board_idx")%>&page_num=1"><%=map.get("board_title")%></a></td>
									<td class="center"><%=date%></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
							
					</div>
				</div>
				
				<div class="col-md-5">
					<div class="bodyfooter2">
						<h4>-입금계좌번호 안내-</h4>
						<p>예금주: (주)에듀고</p>
						<p>농 협: 315-4567-1177</p>
						<p>국민은행: 825942-01-124578</p>
						<p>신한은행: 114-522-548512</p>
					</div>
				</div>
			
			</div>
			
		</div>
		
<%@ include file="/header_footer/footer.jsp"%>