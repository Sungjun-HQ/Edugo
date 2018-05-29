<%@page import="dao.DB_Connector"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="bean.UserBean"%>
<%@page import="java.sql.*"%>
<%@page import="dao.MyStudyDAO"%>

<%@ include file="/header_footer/header.jsp"%>

<%
	String path2 = request.getContextPath();	

	int video_idx = Integer.parseInt(request.getParameter("idx"));
	/* String video_filename = request.getParameter("name"); */
	
	UserBean user = (UserBean) session.getAttribute("user_bean");
	
	int time = MyStudyDAO.starttime(user.getUser_idx(), video_idx);
	
	Connection conn = DB_Connector.getConnection();
	
	String sql = "select * from video where video_idx=?";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, video_idx);
	
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	
	String VIDEO_SAVE_FILENAME = rs.getString(4);
	
	conn.close();
%>

<link rel="stylesheet" href="../css/test_sub.css">
<title>에듀고 > 학습 진도율</title>
<script type="text/javascript">
	$(function() {
		$("#menu li").click(function() {
			$("#menu li").removeClass("active");
			$(this).addClass("active");
		});
	});
	var time=<%=time%>;
	function playVideo() {
		if (time==0){
			myVideo.play();
		} else {
			myVideo.currentTime=time;
			myVideo.play();
			time=0;
		}
	}
	function pauseVideo() {
		myVideo.pause();
		var currenttime = myVideo.currentTime.toFixed(0);
		// document.getElementById("curTime").textContent = currenttime;
		$.ajax({
			type: 'POST',
			url: '<%=path2%>/currenttime.test',
			data:'currenttime=' + currenttime + '&video_idx=<%=video_idx%>'
		});
	}
</script>

<%@ include file="/header_footer/header_next.jsp"%>

		<div class="row">
		
			<div class="menu col-md-3">
				<ul class="nav nav-pills nav-stacked" id="menu">
					<li class="active"><a href="<%=path%>/mystudy.test">수강중인 강좌</a></li>
					<%-- <li><a href="<%=path%>/mypage/myhomework.jsp">과제</a></li>
					<li><a href="<%=path%>/mypage/mytest.jsp">시험</a></li>
					<li><a href="<%=path%>/mypage/mystudyfile.jsp">학습 자료실</a></li>
					<li><a href="<%=path%>/mypage/myprogress.jsp">학습 진도율</a></li>
					<li><a href="<%=path%>/mypage/mypastlecture.jsp">수강 내역 조회</a></li> --%>
				</ul>
			</div>

			<div class="body col-md-9">
				<h3>수강중인 강좌 > 강의시청</h3>
				<br />
				<div class="bodyinborder center">
					<video src="<%=path%>/video_file/<%=VIDEO_SAVE_FILENAME%>"  
							id="myVideo" controls width="640" height="360" ></video>
					<%-- <video src="<%=path%>/video_file/<%=VIDEO_SAVE_FILENAME%>"  id="myVideo" controls></video> --%>
					<br/>
					<!-- Video Controls -->
					<!-- <div id="video-controls">
					  <button type="button" id="play-pause">Play</button>
					  <input type="range" id="seek-bar" value="0">
					  <button type="button" id="mute">Mute</button>
					  <input type="range" id="volume-bar" min="0" max="1" step="0.1" value="1">
					  <button type="button" id="full-screen">Full-Screen</button>
					</div> -->
					
					<button onclick="playVideo()" class="btn btn-default" style="outline: none;">재생</button>
		 			<button onclick="pauseVideo()" class="btn btn-default" style="outline: none;">일시정지/위치저장</button>
	 			</div>
				<!-- Current time:  <span id="curTime" title="Current time"></span><br /> -->
			</div>
		</div>

<%@ include file="/header_footer/footer.jsp"%>