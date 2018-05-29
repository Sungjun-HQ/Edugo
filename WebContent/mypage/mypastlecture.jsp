<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header_footer/header.jsp"%>

<!-- 네비게이션바 보기위해 임시로 넣은 스타일 시트 -->
<link rel="stylesheet" href="../css/test_sub.css">
<title>에듀고 > 수강 내역</title>
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
					<li><a href="<%=path%>/mystudy.test">수강중인 강좌</a></li>
					<li><a href="<%=path%>/mypage/myhomework.jsp">과제</a></li>
					<li><a href="<%=path%>/mypage/mytest.jsp">시험</a></li>
					<li><a href="<%=path%>/mypage/mystudyfile.jsp">학습 자료실</a></li>
					<li><a href="<%=path%>/mypage/myprogress.jsp">학습 진도율</a></li>
					<li class="active"><a href="<%=path%>/mypage/mypastlecture.jsp">수강 내역 조회</a></li>
				</ul>
			</div>

			<div class="body col-md-9">
				<p>body</p>
				<h1>수강 내역 조회</h1>
				<br />
				<a href="#전체">전체</a> | <a href="#과목1">과목1</a> | <a href="#과목2">과목2</a>
				<br />
				db 연결한 게시판 화면
				<br />
				<br />
				DB 가져올 데이터: 과목 이름, 선생님 이름, 수강했던 날짜, 강의 완료 상태?/출석율?/진도율?
			</div>

		</div>

<%@ include file="/header_footer/footer.jsp"%>