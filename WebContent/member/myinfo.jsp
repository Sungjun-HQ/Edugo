<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%@ include file="/header_footer/header.jsp"%>

<jsp:useBean id="user_bean" class="bean.UserBean" scope="session"/>

<link rel="stylesheet" href="../css/test_sub.css">
<title>에듀고 > 회원정보</title>

<script>
	$(function(){
		$("#modify").validate({
			submitHandler: function() {
                var f = confirm("변경을 완료하겠습니까?");
                if(f){
					alert("변경되었습니다.");
                    return true;
                } else {
                    return false;
                }
            }
		});
	});
</script>

<%@ include file="/header_footer/header_next.jsp"%>

			<div class="row">
			
				<div class="menu col-md-3">
				
					<ul class="nav nav-pills nav-stacked" id="menu">
						<li class="active"><a href="<%=path%>/member/myinfo.jsp">개인정보 변경</a></li>
						<li><a href="<%=path%>/member/update_passwd.jsp">비밀번호 변경</a></li>
						<li><a href="<%=path%>/member/leave.jsp">회원탈퇴</a></li>
					</ul>
					
				</div>
				
				<div class="container">
					<div class="row add-user-box">
			
						<div class="col-sm-1"></div>
			
						<div class="col-sm-6">
			
							<div class="panel panel-default">
								<div class="panel-heading">회원정보 수정</div>
								<div class="panel-body">
			
									<form class="form-horizontal" role="form" id="modify" method="post" action="<%=path%>/updateinfo.test?user_idx=${user_bean.user_idx}">
			
										<%-- 아이디 --%>
										<div class="form-group">
											<label class="control-label col-sm-3" for="user_id">아이디: </label>
											<div class="col-sm-9" style="margin-top : 7px">
												${user_bean.user_id}
											</div>
										</div>


										<%-- 이름 --%>
										<div class="form-group">
											<label class="control-label col-sm-3" for="user_name">이름: </label>
											<div class="col-sm-9" style="margin-top : 7px">
												${user_bean.user_name}
											</div>
										</div>
			
										<%-- 남자/여자 확인 라디오 버튼 --%>
										<div class="form-group">
											<label class="control-label col-sm-3" for="user_gender">성별: </label>
											<div class="col-sm-9" style="margin-top : 7px">
												<c:choose>
													<c:when test="${user_bean.user_gender eq 1}">
													남자
													</c:when>
													<c:otherwise>
													여자
													</c:otherwise>
												</c:choose>
											</div>
										</div>
			
										<%-- 생년월일 --%>
										<div class="form-group">
											<label class="control-label col-sm-3" for="user_date">생년월일: </label>
											<div class="col-sm-9" style="margin-top : 7px">
												${user_bean.user_birth}
											</div>
										</div>
			
										<%-- 이메일 --%>
										<div class="form-group">
											<label class="control-label col-sm-3" for="user_email">이메일: </label>
											<div class="col-sm-9">
												<input type="email" class="form-control" id="user_email" value="${user_bean.user_email}"
												name="user_email" placeholder="이메일" required autocomplete="off" />
											</div>
										</div>
			
										<%-- 주소 --%>
										<div class="form-group">
											<label class="control-label col-sm-3" for="user_email">주소: </label>
											<div class="col-sm-9">
												<input type="text" class="form-control" id="user_address" value="${user_bean.user_address}"
												name="user_address" placeholder="주소" required autocomplete="off" />
											</div>
										</div>
			
										<%-- 휴대전화 --%>
										<div class="form-group">
											<label class="control-label col-sm-3" for="user_phone">휴대전화: </label>
											<div class="col-sm-9">
												<input type="tel" class="form-control" id="user_phone" value="${user_bean.user_phone}"
												name="user_phone" placeholder="휴대전화" required autocomplete="off" />
											</div>
										</div>
			
										<%-- 확인 / 취소 버튼 --%>
										<div style="text-align: center">
											<button type="submit" class="btn btn-default2">확인</button>
											<button type="reset" class="btn btn-default2">취소</button>
										</div>
			
									</form>
			
								</div>
							</div>
						</div>
			
						<div class="col-sm-3"></div>
			
					</div>
				</div>

<%@ include file="/header_footer/footer.jsp"%>