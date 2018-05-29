<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<%
	request.setCharacterEncoding("utf-8");
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에듀고 회원가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- BootStrap CDN -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<!-- jQuery CDN -->
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

<style>
.logo {
	text-align: center;
}
</style>

<c:url var="url2" value="/id_check.test"/>

<script>
function checkId() {
	var user_id = $("#user_id").val();
	if (user_id==""){
		document.getElementById("checkResult").style.display="block";
		document.getElementById("checkResult").innerHTML="필수 정보입니다.";
        document.getElementById("checkResult").style.color="red";
        document.getElementById("user_id").value = "";
        document.getElementById("user_id").focus();
	} else {
		$.ajax({
			url : "${url2}",
			type : "post",
			data : "user_id="+user_id,
			dataType : "text",
			success : function(result){
				if(result=='0'){
					document.getElementById("checkResult").style.display="block";
					document.getElementById("checkResult").innerHTML="사용가능한 아이디 입니다";
					document.getElementById("checkResult").style.color="blue";
				} else {
					document.getElementById("checkResult").style.display="block";
					document.getElementById("checkResult").innerHTML="중복된 아이디입니다";
					document.getElementById("checkResult").style.color="red";
					document.getElementById("user_id").value = "";
					document.getElementById("user_id").focus();
				}
			}
		});
	}
}
</script>
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
					<div class="panel-heading">회원가입</div>
					<div class="panel-body">

						<form class="form-horizontal" role="form" method="post" action="<%=path%>/member/join_result.jsp">

							<%-- 아이디 --%>
							<div class="form-group">
								<label class="control-label col-sm-3" for="user_id">아이디: </label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="user_id" name="user_id" onblur="checkId()" placeholder="아이디" required autocomplete="off" />
									<%-- checkResult --%>
									<div id="checkResult" style="display: none;"></div>
								</div>
							</div>

							<%-- 비밀번호 --%>
							<div class="form-group">
								<label class="control-label col-sm-3" for="user_pw">비밀번호: </label>
								<div class="col-sm-9">
									<input type="password" class="form-control" id="user_pw" name="user_pw" placeholder="비밀번호" required />
								</div>
							</div>

							<%-- 비밀번호 확인 --%>
							<div class="form-group">
								<label class="control-label col-sm-3" for="user_pw">비밀번호 확인: </label>
								<div class="col-sm-9">
									<input type="password" class="form-control" id="user_pw" name="user_pw" placeholder="비밀번호 확인" required />
								</div>
							</div>

							<%-- 이름 --%>
							<div class="form-group">
								<label class="control-label col-sm-3" for="user_name">이름: </label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="user_name" name="user_name" placeholder="이름" required autocomplete="off" />
								</div>
							</div>

							<%-- 남자/여자 확인 라디오 버튼 --%>
							<div class="form-group">
								<label class="control-label col-sm-3" for="user_gender">성별: </label>
								<div class="col-sm-9">
									<label class="radio-inline"><input type="radio" name="user_gender" value="1">남자</label>
									<label class="radio-inline"><input type="radio" name="user_gender" value="2">여자</label>
								</div>
							</div>

							<%-- 생년월일 --%>
							<div class="form-group">
								<label class="control-label col-sm-3" for="user_date">생년월일: </label>
								<div class="col-sm-9">
									<input type="date" class="form-control" id="user_birth" name="user_birth" placeholder="생년월일" required autocomplete="off" />
								</div>
							</div>

							<%-- 이메일 --%>
							<div class="form-group">
								<label class="control-label col-sm-3" for="user_email">이메일: </label>
								<div class="col-sm-9">
									<input type="email" class="form-control" id="user_email" name="user_email" placeholder="이메일" required autocomplete="off" />
								</div>
							</div>

							<%-- 주소 --%>
							<div class="form-group">
								<label class="control-label col-sm-3" for="user_email">주소: </label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="user_address" name="user_address" placeholder="주소" required autocomplete="off" />
								</div>
							</div>

							<%-- 휴대전화 --%>
							<div class="form-group">
								<label class="control-label col-sm-3" for="user_phone">휴대전화: </label>
								<div class="col-sm-9">
									<input type="tel" class="form-control" id="user_phone" name="user_phone" placeholder="휴대전화" required autocomplete="off" />
								</div>
							</div>

							<%-- 가입 / 초기화 버튼 --%>
							<div style="text-align: right">
								<button type="submit" class="btn btn-default">가입</button>
								<button type="reset" class="btn btn-default">초기화</button>
							</div>

						</form>

					</div>
				</div>
			</div>

			<div class="col-sm-3"></div>

		</div>
	</div>


	<%-- <form action="<%=path%>/member/join_result.jsp" method="post">
		<input type="" placeholder="아이디" required />
		<input type="" autocomplete="off" 자동완성 기능 off />
		아이디: <input type="text" name="user_id" placeholder="아이디" required="required" /> 
		<br />
		비밀번호: <input type="password" name="user_pw" />
		<br />
		비밀번호 재확인: <input type="password" name="user_pw" />
		<br />
		이름: <input type="text" name="user_name" />
		<br />
		성별: <input type="radio" name="user_gender" value="1" />
		남자
		<input type="radio" name="user_gender" value="2" />
		여자
		<br />
		생년/월/일: <input type="date" name="user_birth" />
		<br />
		이메일: <input type="email" name="user_email" />
		<br />
		주소: <input type="text" name="user_address" />
		<br />
		휴대전화: <input type="tel" name="user_phone" />
		<br />
		<input type="submit" value="회원가입" />
	</form> --%>
</body>
</html>