<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%@ include file="/header_footer/header.jsp"%>

<jsp:useBean id="user_bean" class="bean.UserBean" scope="session"/>

<link rel="stylesheet" href="../css/test_sub.css">
<title>에듀고 > faq</title>

<%@ include file="/header_footer/header_next.jsp"%>

<script>
function check(){
//	비밀번호 유효성 체크
	var pwd = $("#user_passwd").val();
	var pwd1 = $("#new_passwd").val();
	var pwd2 = $("#new_passwd1").val();
			
	if( pwd1 != pwd2 ) {	//	비밀번호 와 비밀번호 확인이 다르다면 ...
		alert("새 비밀번호가 일치하지 않습니다.");
		return false;
	} else if (pwd !="<%=user_bean.getUser_pw()%>"){
		alert("기존 비밀번호가 일치하지 않습니다.");
		return false;		
	} else
		alert("변경되었습니다.");
	return true;
}
</script>
			<div class="row">
			
				<div class="menu col-md-3">
				
					<ul class="nav nav-pills nav-stacked" id="menu">
						<li><a href="<%=path%>/member/myinfo.jsp">개인정보 변경</a></li>
						<li class="active"><a href="<%=path%>/member/update_passwd.jsp">비밀번호 변경</a></li>
						<li><a href="<%=path%>/member/leave.jsp">회원탈퇴</a></li>
					</ul>
					
				</div>
				
				<div class="container">
					<div class="row add-user-box">
			
						<div class="col-sm-1"></div>
			
						<div class="col-sm-6">
			
							<div class="panel panel-default">
								<div class="panel-heading">비밀번호 변경</div>
								<div class="panel-body">
			
									<form class="form-horizontal" role="form" id="modify" method="post" action="<%=path%>/updatepasswd.test?user_idx=${user_bean.user_idx}" onsubmit="return check()">
			
										<%-- 현재 비밀번호 --%>
										<div class="form-group">
											<label class="control-label col-sm-3" for="user_passwd">현재 비밀번호: </label>
											<div class="col-sm-9">
												<input type="password" class="form-control" id="user_passwd"
												name="user_passwd" placeholder="현재 비밀번호" required autocomplete="off" />
											</div>
										</div>
										
										<%-- 새 비밀번호 --%>
										<div class="form-group">
											<label class="control-label col-sm-3" for="user_passwd">새 비밀번호: </label>
											<div class="col-sm-9">
												<input type="password" class="form-control" id="new_passwd"
												name="new_passwd" placeholder="새 비밀번호" required autocomplete="off" />
											</div>
										</div>
										
										<%-- 새 비밀번호 확인 --%>
										<div class="form-group">
											<label class="control-label col-sm-3" for="user_passwd">비밀번호 확인: </label>
											<div class="col-sm-9">
												<input type="password" class="form-control" id="new_passwd1"
												name="new_passwd_check" placeholder="새 비밀번호 확인" required autocomplete="off" />
											</div>
										</div>
										
										<%-- 확인 / 취소 버튼 --%>
										<div style="text-align: center">
											<button type="submit" class="btn btn-default">확인</button>
											<button type="reset" class="btn btn-default">취소</button>
										</div>
									</form>
			
								</div>
							</div>
						</div>
			
						<div class="col-sm-3"></div>
			
					</div>
				</div>
<%@ include file="/header_footer/footer.jsp"%>