<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header_footer/header.jsp"%>

<link rel="stylesheet" href="../css/test_sub.css">
<title>에듀고 > 세미나</title>
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
					<li class="active"><a href="<%=path%>/seminar/tax.jsp">세무회계법 개정</a></li>
					<li><a href="<%=path%>/seminar/ittrend.jsp">IT 최신 트렌드</a></li>
				</ul>
			</div>
			
			<div class="body col-md-9">
				<p>body</p>
				<h1>세무회계법 개정</h1>
				<br />
				DB 가져올 데이터: 참여할 회원테이블의 내용, 결제내역 테이블
			</div>
			
		</div>
		
<%@ include file="/header_footer/footer.jsp"%>