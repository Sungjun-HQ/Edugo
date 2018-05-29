<%@page import="dao.UserDAO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String path = request.getContextPath();
%>
<%-- 파라미터 데이터 추출 --%>
<jsp:useBean id="user_bean" class="bean.UserBean" />
<jsp:setProperty name="user_bean" property="*" />
<%
	// 가입 처리
	UserDAO.join_user(user_bean);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 완료</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- BootStrap CDN -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<style type="text/css">
.logo {
	text-align: center;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row add-user-box">

			<div class="col-sm-3"></div>

			<div class="col-sm-6">

				<%-- 로고 --%>
				<div class="low logo">
					<a href="<%=path%>/index.jsp">
						<img src="<%=path%>/image/smalllogo.png" />
					</a>
				</div>

				<div class="panel panel-default">
					<div class="panel-heading">회원가입 완료</div>

						<div class="panel-body">
							<h3>회원 가입이 완료되었습니다.</h3>
						</div>
			
						<a class="btn btn-default btn-block" href="<%=path%>/index.jsp">메인으로</a>
				</div>
			</div>

			<div class="col-sm-3"></div>

		</div>
	</div>
</body>
</html>