<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String path = request.getContextPath();
	
	//로그인 결과 정보 파라미터 추출
	String login_fail = request.getParameter("login_fail");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에듀고 로그인</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- BootStrap CDN -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<style>
.join-button, .logo {
	text-align: center;
}
</style>

</head>
<body>
	<div class="container">
	
		<div class="row login-box">
		
			<div class="col-sm-3"></div>
			
			<div class="col-sm-6">
			
				<div class="low logo">
					<a href="<%=path%>/index.jsp">
						<img src="<%=path%>/image/smalllogo.png" />
					</a>
				</div>

				<div class="panel panel-default">
				
					<div class="panel-heading">로그인</div>
					
					<div class="panel-body">

						<%
							if(login_fail != null) {
								if(login_fail.equals("1")){
									out.write("<p class=\"bg-danger\">등록되지 않은 아이디 입니다.<br/></p>");
								} else if(login_fail.equals("2")){
									out.write("<p class=\"bg-danger\">비밀번호가 잘못되었습니다.<br/></p>");
								}
							}
						%>

						<form class="form-horizontal" role="form" method="post" action="<%=path%>/member/login_pro.jsp">

							<%-- 아이디 폼 --%>
							<div class="form-group">
								<label class="control-label col-sm-3" for="user_id"></label>
								<div class="col-sm-12">
									<input type="text" id="user_id" name="user_id" class="form-control" placeholder="아이디" required autocomplete="off" />
								</div>
							</div>
							
							<%-- 비밀번호 폼 --%>
							<div class="form-group">
								<label class="control-label col-sm-3" for="user_id"></label>
								<div class="col-sm-12">
									<input type="password" id="user_pw" name="user_pw" class="form-control" placeholder="비밀번호" required />
								</div>
							</div>
							
							<%-- 로그인 버튼 --%>
							<button type="submit" class="btn btn-primary btn-block">로그인</button>
									
						</form>
						
					</div>
				</div>
				
				<%-- 회원가입 , id/pw 찾기 이동 --%>
				<div class="row join-button">
					<a class="btn btn-default" href="<%=path%>/member/join_member_check.jsp" role="button">회원가입</a>
					<a class="btn btn-default" href="<%=path%>/member/find_member.jsp" role="button">ID / 비밀번호 찾기</a>
				</div>
				
			</div>
			
			<div class="col-sm-3"></div>
		</div>
		
	</div>
</body>
</html>