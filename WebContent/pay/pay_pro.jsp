<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.sql.*"%>
<%@page import="dao.DB_Connector"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
	request.setCharacterEncoding("UTF-8");

	String path = request.getContextPath();

	String pay_method = request.getParameter("pay_method");
	String price = request.getParameter("price");
	String sub_idx = request.getParameter("sub_idx");
	String user_idx = request.getParameter("user_idx");

	Connection conn = DB_Connector.getConnection();

	String sql = "insert into payment values(pay_seq.nextval, sysdate, ?, ?, ?, ?)";

	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, price);
	pstmt.setString(2, pay_method);
	pstmt.setString(3, sub_idx);
	pstmt.setString(4, user_idx);

	pstmt.execute();

	/* 결제내역 테이블  
	CREATE TABLE payment (
		pay_idx INTEGER primary key, 
		pay_date DATE, 
		pay_charge INTEGER, 
		pay_method VARCHAR2(255),
		sub_idx INTEGER, 
		user_idx INTEGER 
	); */

	String sql2 = "select * from payment order by pay_idx desc";

	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(sql2);

	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

	// select v.video_idx, s.sub_name, v.video_name, u.user_name
	while (rs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("pay_idx", rs.getInt(1));
		map.put("pay_date", rs.getString(2));
		map.put("pay_charge", rs.getString(3));
		map.put("pay_method", rs.getString(4));
		map.put("sub_idx", rs.getInt(5));
		map.put("user_idx", rs.getInt(6));

		list.add(map);
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>결제 테스트</title>
<!-- BootStrap CDN -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="col-sm-1"></div>
	<div class="col-sm-10">
		<h1>결제 확인 pro</h1>
		<br />
		<a href="<%=path%>/video/all_video.jsp" class="btn btn-default">페이지 이동</a>
		<br />
		<br />
		<br />
		<table class="table table-bordered" id="board_list">
			<thead>
				<tr>
					<td width="8%">글번호</td>
					<td width="12%">날짜</td>
					<td>비용</td>
					<td width="10%">방법</td>
					<td width="9%">과목 번호</td>
					<td width="9%">회원 번호</td>
				</tr>
			</thead>
			<tbody>
				<%
					for (HashMap<String, Object> map : list) {
				%>
				<tr>
					<td><%=map.get("pay_idx")%></td>
					<td><%=map.get("pay_date")%></td>
					<td><%=map.get("pay_charge")%></td>
					<td><%=map.get("pay_method")%></td>
					<td><%=map.get("sub_idx")%></td>
					<td><%=map.get("user_idx")%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
	<div class="col-sm-1"></div>
</body>
</html>