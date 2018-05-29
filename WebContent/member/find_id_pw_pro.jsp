<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="dao.UserDAO"%>
<%@page import="bean.UserBean"%>
<%@page import="dao.DB_Connector"%>
<%
	request.setCharacterEncoding("utf-8");
	String path = request.getContextPath();
	String check = request.getParameter("check");
%>
<jsp:useBean id="user_bean" class="bean.UserBean" />
<jsp:setProperty property="*" name="user_bean" />
<%
	Connection conn = DB_Connector.getConnection();

	String sql = null;

	if (check.equals("1")) {

		sql = "select * from user_table where user_name=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_bean.getUser_name());

		ResultSet rs = pstmt.executeQuery();

		UserBean bean = null;

		if (rs.next()) {
			bean = new UserBean();
			bean.setUser_idx(rs.getInt("user_idx"));
			bean.setUser_id(rs.getString("user_id"));
			bean.setUser_pw(rs.getString("user_passwd"));
			bean.setUser_name(rs.getString("user_name"));
			bean.setUser_gender(rs.getInt("user_gender"));
			bean.setUser_birth(rs.getString("user_birth"));
			bean.setUser_email(rs.getString("user_email"));
			bean.setUser_address(rs.getString("user_address"));
			bean.setUser_phone(rs.getInt("user_phone"));
			bean.setGrade_idx(rs.getInt("grade_idx"));
		}

		if (bean == null) {
			response.sendRedirect(path
					+ "/member/find_id.jsp?findid_fail=1");
		} else {
			String email1 = bean.getUser_email();
			String email2 = user_bean.getUser_email();

			Integer phone1 = bean.getUser_phone();
			Integer phone2 = user_bean.getUser_phone();

			conn.close();

			if (email1.equals(email2) != true) {
				response.sendRedirect(path + "/member/find_id.jsp?findid_fail=2");
			} else if (phone1.equals(phone2) != true) {
				response.sendRedirect(path + "/member/find_id.jsp?findid_fail=3");
			} else {
				request.setAttribute("id", bean.getUser_id());
				RequestDispatcher dis = request.getRequestDispatcher("/member/find_id.jsp");
				dis.forward(request, response);
			}
		}
	} else if (check.equals("2")) {

		sql = "select * from user_table where user_id=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_bean.getUser_id());

		ResultSet rs = pstmt.executeQuery();

		UserBean bean = null;

		if (rs.next()) {
			bean = new UserBean();
			bean.setUser_idx(rs.getInt("user_idx"));
			bean.setUser_id(rs.getString("user_id"));
			bean.setUser_pw(rs.getString("user_passwd"));
			bean.setUser_name(rs.getString("user_name"));
			bean.setUser_gender(rs.getInt("user_gender"));
			bean.setUser_birth(rs.getString("user_birth"));
			bean.setUser_email(rs.getString("user_email"));
			bean.setUser_address(rs.getString("user_address"));
			bean.setUser_phone(rs.getInt("user_phone"));
			bean.setGrade_idx(rs.getInt("grade_idx"));
		}

		if (bean == null) {
			response.sendRedirect(path + "/member/find_pw.jsp?findid_fail=1");
		} else {
			String name1 = bean.getUser_name();
			String name2 = user_bean.getUser_name();

			String email1 = bean.getUser_email();
			String email2 = user_bean.getUser_email();

			conn.close();

			if (name1.equals(name2) != true) {
				response.sendRedirect(path + "/member/find_pw.jsp?findid_fail=2");
			} else if (email1.equals(email2) != true) {
				response.sendRedirect(path + "/member/find_pw.jsp?findid_fail=3");
			} else {
				request.setAttribute("pw", bean.getUser_pw());
				RequestDispatcher dis = request.getRequestDispatcher("/member/find_pw.jsp");
				dis.forward(request, response);
			}
		}
	}
%>