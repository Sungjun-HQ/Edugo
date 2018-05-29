<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="dao.DB_Connector"%>

<%@ include file="/header_footer/header.jsp"%>

<jsp:useBean id="user_bean" class="bean.UserBean" scope="session"></jsp:useBean>

<%
	request.setCharacterEncoding("UTF-8");

	String video_idx = request.getParameter("video_idx");
	String page_num = request.getParameter("page_num");

	// 가져올 테이터
	// 선택항 동영상에 대한 (과목명, 강좌명, 선생님 이름, 가격) (결제자 이름)
	Connection conn = DB_Connector.getConnection();
	
	String sql = "select v.video_idx, s.sub_name, v.video_name, u.user_name, v.video_content , s.price, s.sub_idx " + 
			"from user_table u, subject s, video v " +
			"where u.user_idx=s.user_idx and v.sub_idx=s.sub_idx and v.video_idx=?";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, video_idx);
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	
	String subject = rs.getString(2);
	String video_title = rs.getString(3);
	String user_name = rs.getString(4);
	String video_content = rs.getString(5);
	String price = rs.getString(6);
	String sub_idx = rs.getString(7);
%>

<link rel="stylesheet" href="../css/test_sub.css">
<title>에듀고 > 결제</title>

<script type="text/javascript">
	$(function() {
		$("#menu li").click(function() {
			$("#menu li").removeClass("active");
			$(this).addClass("active");
		});
	});
</script>

<%@ include file="/header_footer/header_next.jsp" %>

		<div class="row">
		
			<div class="menu col-md-3">
				<ul class="nav nav-pills nav-stacked" id="menu">
					<li class="active"><a href="<%=path%>/video/all_video.jsp">전체</a></li>
					<li><a href="#">정보처리기사</a></li>
					<li><a href="#">전산세무2급</a></li>
				</ul>
			</div>
			
			<div class="body col-md-9">
			
				<h3>전체동영상>결재하기</h3>
				<br />
				<div class="bodyinborder">

					<div class="row">
					
						<div class="col-sm-6">
							<img src="<%=path%>/image/example.png" style="float: left;" class="img-thumbnail"  />
						</div>

						<div class="col-sm-6">

							<h4>과목 : <%=subject%></h4>
							<h4>제목 : <%=video_title%></h4>
							<h4>강사 이름 : <%=user_name%></h4>
							<h4>강의 소개 내용 : <%=video_content%></h4>
							<h4>강의 비용 : <%=price%></h4>
							<br />
							<br />
							<h4>결제하기 :</h4>
		
							<form action="<%=path%>/pay/pay_pro.jsp" method="post">
								<input type="radio" name="pay_method" value="bankbook" checked="checked">무통장 입금<br />
								<input type="radio" name="pay_method" value="card">카드
								<input type="hidden" name="price" value="<%=price%>">
								<input type="hidden" name="sub_idx" value="<%=sub_idx%>" />
								<input type="hidden" name="user_idx" value="<%=user_bean.getUser_idx()%>" />
								<br />
								<br />
								<br />
								<br />

								<div class="right">
									<button type="submit" class="btn btn-default">결제하기</button>
								</div>

							</form>

						</div>
					</div>
				</div>
			</div>
			
		</div>

<%@ include file="/header_footer/footer.jsp"%>