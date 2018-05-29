<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header_footer/header.jsp"%>

<!-- 네비게이션바 보기위해 임시로 넣은 스타일 시트 -->
<link rel="stylesheet" href="../css/test_sub.css">
<title>에듀고 > 자료실</title>
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
					<li class="active"><a href="#">정보처리기사</a></li>
					<li><a href="#">전산세무2급</a></li>
				</ul>
			</div>
			
			<div class="body col-md-9">
				<p>body</p>
				<h1>자료실</h1>
				<br />
				DB 가져올 데이터: 달력형 게시판?: 클릭시 그 주의 시험 정보로 이동, 시험장 위치?
			</div>
			
		</div>
		
<%@ include file="/header_footer/footer.jsp"%>