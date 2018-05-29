<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	
	String login = (String) session.getAttribute("login");
%>
<script type="text/javascript">
	function show_prompt() {
		var name = '로그인해 주세요';
		alert(name);
	}
</script>
</head>
<body>
	<div class="container">
	
		<div class="header" >
			<%-- 상단부 로그인, 회원가입, 아이디 비번 찾기 버튼 테스트 --%>
			<div class="login" style="padding: 0px; margin: 0px; text-align: right;">
				<%-- pagination-sm 을 사용하여 버튼 크기를 줄였다. --%>
				<ul class="pagination pagination-sm" style="padding: 0px; border: 0px; margin: 0px">
					<%-- active를 사용하여 파란색이 되었다. --%>
					<li class="active">
						<a href="#">
							<span class="glyphicon glyphicon-education"></span>
						</a>
					</li>
					<%
						login = (String) session.getAttribute("login");
						if (login == null || login.length() == 0) {
					%>
					<li><a href="<%=path%>/member/login.jsp">로그인</a></li>
					<li><a href="<%=path%>/member/join_member_check.jsp">회원가입</a></li>
					<li><a href="<%=path%>/member/find_id.jsp">아이디/비밀번호 찾기</a></li>
					<%
						} else {
					%>
					<li><a href="<%=path%>/member/logout.jsp">로그아웃</a></li>
					<li><a href="<%=path%>/member/myinfo.jsp">내 정보</a></li>
					<%
						}
					%>
				</ul>
			</div>
			
			<!-- 메인 로고 -->
			<div style="text-align: center;">
					<a href="<%=path%>/index.jsp"><img src="<%=path%>/image/logo.png" /></a>
			</div>
			
		</div>
		
		<!-- 네비게이션바 -->
		<nav class="navbar navbar-default" >
			<div class="container-fluid">

				<div class="navbar-header">
					<a class="navbar-brand" href="<%=path%>/index.jsp">EduGo</a>
				</div>
				<ul class="nav navbar-nav">
					<%
						login = (String) session.getAttribute("login");
						if (login == null || login.length() == 0) {
					%>
					<li><a href="#" onclick="show_prompt()">내강의</a></li>
					<%
						} else {
					%>
					<li><a href="<%=path%>/mystudy.test">내강의</a></li>
					<%
						}
					%>
					<li><a href="<%=path%>/video/all_video.jsp">동영상 강의</a></li>
					<li><a href="<%=path%>/community/notice.jsp">커뮤니티</a></li>
					<%-- <li><a href="<%=path%>/seminar/tax.jsp">세미나 강의</a></li> --%>
					<%-- <li><a href="<%=path%>/schedule/test_info.jsp">시험정보</a></li> --%>
					<%-- <li><a href="<%=path%>/dataroom/learning_data.jsp">자료실</a></li> --%>
					<li><a href="<%=path%>/help/faq.jsp">고객센터</a></li>
				</ul>

			</div>
		</nav>
