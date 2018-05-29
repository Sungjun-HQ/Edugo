package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.UserBean;

public class UserDAO {
	// 회원가입
	public static void join_user(UserBean user_bean) throws Exception {
		// 데이터베이스 접속
		// import java.sql
		Connection conn = DB_Connector.getConnection();

		// 쿼리문
		String sql = "insert into user_table values (user_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, 1, 1)";

		// PreparedStatement를 만들어 준다.
		PreparedStatement pstmt = conn.prepareStatement(sql);

		// ?에 값을 바인딩한다.
		pstmt.setString(1, user_bean.getUser_name());
		pstmt.setString(2, user_bean.getUser_id());
		pstmt.setString(3, user_bean.getUser_pw());
		pstmt.setString(4, user_bean.getUser_birth());
		pstmt.setString(5, user_bean.getUser_email());
		pstmt.setInt(6, user_bean.getUser_gender());
		pstmt.setString(7, user_bean.getUser_address());
		pstmt.setInt(8, user_bean.getUser_phone());

		// 쿼리 실행
		pstmt.execute();

		conn.close();
	}

	// 로그인 처리
	public static UserBean check_login(UserBean bean) throws Exception {

		Connection conn = DB_Connector.getConnection();

		String sql = "select * from user_table where user_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, bean.getUser_id());
		ResultSet rs = pstmt.executeQuery();

		// UserBean 선언
		UserBean user_bean = null;

		// 가져온 데이터가 있다면 user_bean 객체 생성 후 넘겨준다.
		if (rs.next()) {
			// user_테이블
			// user_idx, user_name, user_id, user_passwd, user_birth
			// user_email, user_gender, user_address, user_phone, grade_idx
			user_bean = new UserBean();
			user_bean.setUser_idx(rs.getInt("user_idx"));
			user_bean.setUser_id(rs.getString("user_id"));
			user_bean.setUser_pw(rs.getString("user_passwd"));
			user_bean.setUser_name(rs.getString("user_name"));
			user_bean.setUser_gender(rs.getInt("user_gender"));
			user_bean.setUser_birth(rs.getString("user_birth"));
			user_bean.setUser_email(rs.getString("user_email"));
			user_bean.setUser_address(rs.getString("user_address"));
			user_bean.setUser_phone(rs.getInt("user_phone"));
			user_bean.setGrade_idx(rs.getInt("grade_idx"));
		}
		conn.close();

		return user_bean;
	}

	// 아이디 중복 체크
	public static int id_check(String user_id) throws Exception {

		Connection conn = DB_Connector.getConnection();

		String sql = "select count(*) num from user_table where user_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		ResultSet rs = pstmt.executeQuery();

		int check = 0;

		if (rs.next()) {
			check = rs.getInt("num");
		}
		conn.close();

		return check;
	}

	// 회원정보 변경
	public static UserBean update_user(UserBean user_bean) throws Exception {
		// 데이터베이스 접속
		// import java.sql
		Connection conn = DB_Connector.getConnection();

		// 쿼리문
		String sql = "update user_table set user_email=?, user_address=?, user_phone=? where user_idx = ? ";

		// PreparedStatement를 만들어 준다.
		PreparedStatement pstmt = conn.prepareStatement(sql);

		// ?에 값을 바인딩한다.

		pstmt.setString(1, user_bean.getUser_email());
		pstmt.setString(2, user_bean.getUser_address());
		pstmt.setInt(3, user_bean.getUser_phone());
		pstmt.setInt(4, user_bean.getUser_idx());

		// 쿼리 실행
		pstmt.execute();

		// 변경후 새로 세션에 정보를 담기위한 과정
		String sql2 = "select * from user_table where user_idx=?";
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setInt(1, user_bean.getUser_idx());
		ResultSet rs = pstmt2.executeQuery();

		// 가져온 데이터가 있다면 user_bean 객체 생성 후 넘겨준다.
		if (rs.next()) {
			// user_테이블
			// user_idx, user_name, user_id, user_passwd, user_birth
			// user_email, user_gender, user_address, user_phone, grade_idx
			user_bean = new UserBean();
			user_bean.setUser_idx(rs.getInt("user_idx"));
			user_bean.setUser_id(rs.getString("user_id"));
			user_bean.setUser_pw(rs.getString("user_passwd"));
			user_bean.setUser_name(rs.getString("user_name"));
			user_bean.setUser_gender(rs.getInt("user_gender"));
			user_bean.setUser_birth(rs.getString("user_birth"));
			user_bean.setUser_email(rs.getString("user_email"));
			user_bean.setUser_address(rs.getString("user_address"));
			user_bean.setUser_phone(rs.getInt("user_phone"));
			user_bean.setGrade_idx(rs.getInt("grade_idx"));
		}

		conn.close();
		return user_bean;
	}

	// 비밀번호 변경
	public static UserBean update_passwd(UserBean user_bean) throws Exception {
		// 데이터베이스 접속
		// import java.sql
		Connection conn = DB_Connector.getConnection();

		// 입력한 패스워드가 맞는지 확인하는 쿼리문
		String sql = "update user_table set user_passwd=? where user_idx=?";

		// PreparedStatement를 만들어 준다.
		PreparedStatement pstmt = conn.prepareStatement(sql);

		// ?에 값을 바인딩한다.
		pstmt.setString(1, user_bean.getUser_pw());
		pstmt.setInt(2, user_bean.getUser_idx());

		// 쿼리 실행
		pstmt.execute();

		// 변경후 새로 세션에 정보를 담기위한 과정
		String sql2 = "select * from user_table where user_idx=?";
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setInt(1, user_bean.getUser_idx());
		ResultSet rs = pstmt2.executeQuery();

		// 가져온 데이터가 있다면 user_bean 객체 생성 후 넘겨준다.
		if (rs.next()) {
			// user_테이블
			// user_idx, user_name, user_id, user_passwd, user_birth
			// user_email, user_gender, user_address, user_phone, grade_idx
			user_bean = new UserBean();
			user_bean.setUser_idx(rs.getInt("user_idx"));
			user_bean.setUser_id(rs.getString("user_id"));
			user_bean.setUser_pw(rs.getString("user_passwd"));
			user_bean.setUser_name(rs.getString("user_name"));
			user_bean.setUser_gender(rs.getInt("user_gender"));
			user_bean.setUser_birth(rs.getString("user_birth"));
			user_bean.setUser_email(rs.getString("user_email"));
			user_bean.setUser_address(rs.getString("user_address"));
			user_bean.setUser_phone(rs.getInt("user_phone"));
			user_bean.setGrade_idx(rs.getInt("grade_idx"));
		}
		conn.close();
		return user_bean;
	}

	// 유저 탈퇴
	public static void leave(int user_idx) throws Exception {

		Connection conn = DB_Connector.getConnection();

		// 유저를 비활성화 상태로 만든다.
		String sql = "update user_table set user_name=0, user_passwd=0, user_email=0, user_address=0, user_phone=0, activate=0 where user_idx=?";

		// PreparedStatement를 만들어 준다.
		PreparedStatement pstmt = conn.prepareStatement(sql);

		// ?에 값을 바인딩한다.
		pstmt.setInt(1, user_idx);

		// 쿼리 실행
		pstmt.execute();

		conn.close();

	}
}
