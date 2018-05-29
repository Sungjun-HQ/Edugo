<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%@ include file="/header_footer/header.jsp"%>

<link rel="stylesheet" href="../css/test_sub.css">
<title>에듀고 > faq</title>

<script>
	$(function(){
		$("#modify").validate({
			submitHandler: function() {
                var f = confirm("정말 탈퇴하시겠습니까?");
                if(f){
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
						<li><a href="<%=path%>/member/myinfo.jsp">개인정보 변경</a></li>
						<li><a href="<%=path%>/member/update_passwd.jsp">비밀번호 변경</a></li>
						<li class="active"><a href="<%=path%>/member/leave.jsp">회원탈퇴</a></li>
					</ul>
					
				</div>
				
				<div class="container">
					<div class="row add-user-box">
			
						<div class="col-sm-1"></div>
			
						<div class="col-sm-6">
			
							<div class="panel panel-default">
								<div class="panel-heading">회원 탈퇴</div>
								<div class="panel-body">
			
									<form class="form-horizontal" role="form" id="modify" method="post" action="<%=path%>/leave.test?user_idx=${user_bean.user_idx}">
										탈퇴 하시겠습니까?
										<br/>
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