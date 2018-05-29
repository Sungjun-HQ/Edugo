<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashSet"%>
<%@page import="bean.MyStudyBean"%>
<%@page import="java.util.ArrayList"%>

<%@ include file="/header_footer/header.jsp"%>

<%
	String path2 = request.getContextPath();

	ArrayList<MyStudyBean> list = (ArrayList<MyStudyBean>)request.getAttribute("list");
	HashSet<String> subject_set = (HashSet<String>)request.getAttribute("subject_set");

	// System.out.println("fff : " + list.size());
%>

<link rel="stylesheet" href="<%=path2%>/css/test_sub.css">
<title>에듀고 > 수강중인 강좌</title>

<script type="text/javascript">
	$(function() {
		$("#menu li").click(function() {
			$("#menu li").removeClass("active");
			$(this).addClass("active");
		});
	});
	
	$(function(){
		$("#my_list tbody tr").click(function(){
			var name = $(this).data("name");
			var idx = $(this).data("idx");
			// 이동한다.
			location.href = "<%=path2%>/mypage/mystudy_view.jsp?idx="+idx+"&name="+name;
		});
	});
</script>

<%@ include file="/header_footer/header_next.jsp"%>

		<div class="row">
		
			<div class="menu col-md-3">
				<ul class="nav nav-pills nav-stacked" id="menu">
					<li class="active"><a href="<%=path%>/mystudy.test">수강중인 강좌</a></li>
					<%-- <li><a href="<%=path%>/mypage/myhomework.jsp">과제</a></li>
					<li><a href="<%=path%>/mypage/mytest.jsp">시험</a></li>
					<li><a href="<%=path%>/mypage/mystudyfile.jsp">학습 자료실</a></li>
					<li><a href="<%=path%>/mypage/myprogress.jsp">학습 진도율</a></li>
					<li><a href="<%=path%>/mypage/mypastlecture.jsp">수강 내역 조회</a></li> --%>
				</ul>
			</div>
			
			<div class="body col-md-9">
			
				<c:set var="list" value="<%=list%>"/>
				<c:choose>
				
					<c:when test="${list eq null }">
					수강중인 과목이 없습니다.
					</c:when>
					
						<c:otherwise>
							<%-- <a href="#전체">전체 </a>
							<c:forEach var="sub_name" items="<%=subject_set%>">
								<a href="<%=path%>/member/mystudy.test?sub_name=${sub_name}">| ${sub_name}</a>
							</c:forEach>
							<br/> --%>
							<ul class="nav nav-tabs">
								<li class="active"><a href="#">전체</a></li>
								<li><a href="#">정보처리 기사</a></li>
								<li><a href="#">전산세무 2급</a></li>
							</ul>
							
							<div class="bodyinborder2">
								<table class="table table-hover" id="my_list">
								
									<thead>
										<tr>
											<th width="10%" class="center">영상번호</th>
											<th width="10%" class="center">영상</th>
											<th class="center">제목</th>
											<th width="14%" class="center">과목명</th>
										</tr>
									</thead>
									
									<tbody>
										<c:forEach var="item" items="<%=list%>">
										<tr data-name="${item.video_name}" data-idx="${item.video_idx}" class="center">
										<td class="center" style="vertical-align: middle;">${item.video_idx}&nbsp;</td>
										<td class="center">
											<img src="image/example.png" width="100" height="100"/>
										</td>
										<td style="vertical-align: middle;">${item.video_name}&nbsp;</td>
										<td class="center" style="vertical-align: middle;">${item.sub_name}&nbsp;</td>
										</tr>
										</c:forEach>
									</tbody>
									
								</table>
							</div>
						</c:otherwise>
						
				</c:choose>
				
			</div>
			
		</div>

<%@ include file="/header_footer/footer.jsp"%>