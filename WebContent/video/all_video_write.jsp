<%@page import="dao.DB_Connector"%>
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
	
	Connection conn = DB_Connector.getConnection();
	
	// sub_idx, sub_name, user_table 이름, 
	String sql = "select s.sub_idx, s.sub_name, u.user_name "
			+ "from subject s, user_table u "
			+ "where u.user_idx=s.user_idx";
	
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(sql);
%>
<script>
	function do_submit(){
		var fileInput = document.getElementById("data");
        var video = document.getElementById('test_video');
        var video_time = document.getElementById('video_time');

        var fileUrl = window.URL.createObjectURL(fileInput.files[0]);
        
        video.onloadeddata = function(){
        	video_time.value = video.duration;
        	var input_form = document.getElementById("input_form");
        	input_form.submit();
        }
		video.src = fileUrl;
		return false;
	}
</script>
<link rel="stylesheet" href="../css/test_sub.css">
<title>에듀고 > 모든 동영상</title>
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
					<li class="active"><a href="<%=path%>/video/all_video.jsp">전체</a></li>
					<li><a href="#">정보처리기사</a></li>
					<li><a href="#">전산세무2급</a></li>
				</ul>
			</div>

			<div class="body col-md-9">
				<h3>전체동영상>강의 올리기</h3>
				<br/>				
				<div class="bodyinborder">
				<form id="input_form" action="<%=path%>/video/video_upload_pro.jsp?page_num=<%=page_num%>"
				method="post" enctype="multipart/form-data" onsubmit="return do_submit()">
					<strong>강의선택:</strong>
					<br/>
					<select name="subject">
						<% 	while(rs.next()){ %>
						<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%>_<%=rs.getString(3)%></option>
						<%	} %>
					</select>
					<br/>
					<br/>
					<div class="form-group">
							<label for="board_title">제목 : </label>
							<input type="text" class="form-control" name="video_title" required="required" />
						</div>
						
						<div class="form-group">
							<label for="board_content">내용 : </label>
							<textarea class="form-control" name="video_content" rows="5" required="required" wrap="hard"></textarea>
						</div>
										
					<input type="file" name="data" id="data">
					
										
					<div class="right">
					<input type="hidden" name="video_time" id="video_time" class="btn btn-default" style="outline: none;" />
					<input type="submit" value="업로드" class="btn btn-default" style="outline: none;" />
					<input type="reset" value="초기화" class="btn btn-default" style="outline: none;" />
					</div>
					<br />
				</form>				
			</div>
			
			<video id="test_video" style="display:none"></video>
			
			</div>

		</div>

<%@ include file="/header_footer/footer.jsp"%>