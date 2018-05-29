<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String findid_fail = request.getParameter("findid_fail");
	String pw = (String) request.getAttribute("pw");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에듀고 > 비밀번호 찾기</title>
<!-- BootStrap CDN -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<style type="text/css">
.logo {
	text-align: center;
}

.top_none {
	border-top: none;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row add-user-box">
		
			<div class="col-sm-3"></div>
			
			<div class="col-sm-6">
			
				<%-- 로고 --%>
				<div class="logo">
					<a href="<%=path%>/index.jsp">
						<img src="<%=path%>/image/smalllogo.png" />
					</a>
				</div>
				
				<ul class="nav nav-tabs">
				  <li><a href="<%=path%>/member/find_id.jsp">아이디 찾기</a></li>
				  <li class="active"><a href="<%=path%>/member/find_pw.jsp">패스워드 찾기</a></li>
				</ul>
				
				<div class="panel panel-default top_none">
					<div class="panel-heading">PW 찾기</div>
					
					<div class="panel-body">
					
						<form class="form-horizontal" role="form" method="post" action="<%=path%>/member/find_id_pw_pro.jsp?check=2">
						
							<div class="form-group">
								<label class="control-label col-sm-3" for="user_id">아이디: </label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="user_id" name="user_id" placeholder="아이디" required autocomplete="off" />
								</div>
							</div>
							<%
								if (findid_fail != null) {
									if (findid_fail.equals("1")){
										out.write("<p class=\"bg-danger\">등록되지 않은 아이디 입니다</p>");
									}
								}
							%>
							<div class="form-group">
								<label class="control-label col-sm-3" for="user_name">이름: </label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="user_name" name="user_name" placeholder="이름" required autocomplete="off" />
								</div>
							</div>
							<%
								if (findid_fail != null) {
									if (findid_fail.equals("2")) {
										out.write("<p class=\"bg-danger\">등록되지 않은 이름 입니다</p>");
									}
								}
							%>
							
							<div class="form-group">
								<label class="control-label col-sm-3" for="user_email">이메일: </label>
								<div class="col-sm-9">
									<input type="email" class="form-control" id="user_email" name="user_email" placeholder="이메일" required autocomplete="off" />
								</div>
							</div>
							<%
								if (findid_fail != null) {
									if (findid_fail.equals("3")) {
										out.write("<p class=\"bg-danger\">등록되지 않은 이메일 입니다</p>");
									}
								}
							%>
							
							<div style="text-align: right">
								<button type="submit" class="btn btn-default">확인</button>
								<button type="reset" class="btn btn-default">초기화</button>
							</div>
						</form>
						
					</div>
				</div>
				
				<div class="row pw-box">
				<%
					if (request.getAttribute("pw") != null) {
						String user_pw = (String) request.getAttribute("pw");
						out.write("<h3><p class=\"bg-success\">당신의 비밀번호는 <b>" + user_pw + "</b> 입니다</p></h3><br/>");
					}
				%>
				</div>
			</div>
			
			<div class="col-sm-3"></div>
			
		</div>
	</div>
</body>
</html>