package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bean.MyStudyBean;

public class MyStudyDAO {

	// 결제내역에서 수강중인 동영상 불러오기
	public static ArrayList<MyStudyBean> getMyStudyList(int user_idx) {
		ArrayList<MyStudyBean> list = null;
		try {
			Connection conn = DB_Connector.getConnection();

			// 결제 내역에서 회원인덱스와 같은 로우중 과목인덱스만 불러온다.
			// 동영상테이블에서 위의 과목인덱스와 같은 동영상을 전부 불러온다.
			// 미실시 - 결제일로부터 1달 정보만 빼오는 것
			String sql = "SELECT v.VIDEO_IDX, v.VIDEO_NAME, s.SUB_NAME, k.user_name "
					+ "FROM VIDEO v, subject s, "
					+ "(SELECT s.user_idx,  u.user_name "
					+ "FROM subject s, user_table u WHERE s.SUB_IDX in "
					+ "(SELECT sub_idx FROM payment WHERE user_idx=?) "
					+ "AND s.USER_IDX = u.USER_IDX) k "
					+ "WHERE v.SUB_IDX= s.SUB_IDX AND s.USER_IDX= k.user_idx "
					+ "order by v.video_idx desc";

			// String sql =
			// "select v.group_idx, v.video_name, s.sub_name, u.user_name "
			// + "from video v, subject s, payment p, user_table u "
			// + "where v.sub_idx = s.sub_idx and s.sub_idx = p.sub_idx and p.user_idx = u.user_idx "
			// + "and u.user_idx=?";

			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_idx);

			ResultSet rs = pstmt.executeQuery();

			list = new ArrayList<MyStudyBean>();

			while (rs.next()) {
				MyStudyBean add_bean = new MyStudyBean();
				add_bean.setVideo_idx(rs.getInt(1));
				add_bean.setVideo_name(rs.getString(2));
				add_bean.setSub_name(rs.getString(3));
				add_bean.setTeacher_name(rs.getString(4));

				// add_bean.setSub_idx(rs.getInt(4));

				// Date date = rs.getDate(5);
				// SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
				// String str = fm.format(date);

				// add_bean.setVideo_date(str);

				list.add(add_bean);
			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 결제내역에서 선택한 과목의 수강중인 동영상 불러오기
	public static ArrayList<MyStudyBean> getMyStudyList2(int user_idx,
			String sub_name) {
		ArrayList<MyStudyBean> list = null;
		try {
			Connection conn = DB_Connector.getConnection();

			// 결제 내역에서 회원인덱스와 같은 로우중 과목인덱스만 불러온다.
			// 동영상테이블에서 위의 과목인덱스와 같은 동영상을 전부 불러온다.
			// 미실시 - 결제일로부터 1달 정보만 빼오는 것
			String sql = "SELECT v.VIDEO_IDX, v.VIDEO_NAME, s.SUB_NAME, k.user_name"
					+ " FROM VIDEO v, subject s,"
					+ " (SELECT s.user_idx,  u.user_name  FROM subject s, user_table u WHERE s.SUB_IDX in"
					+ " (SELECT sub_idx FROM payment WHERE user_idx=?)"
					+ " AND s.USER_IDX = u.USER_IDX) k"
					+ " WHERE v.SUB_IDX= s.SUB_IDX AND s.USER_IDX= k.user_idx and s.SUB_name= ?";

			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_idx);
			pstmt.setString(2, sub_name);

			ResultSet rs = pstmt.executeQuery();

			list = new ArrayList<MyStudyBean>();

			while (rs.next()) {
				MyStudyBean add_bean = new MyStudyBean();
				add_bean.setVideo_idx(rs.getInt(1));
				add_bean.setVideo_name(rs.getString(2));
				add_bean.setSub_name(rs.getString(3));
				add_bean.setTeacher_name(rs.getString(4));

				// add_bean.setSub_idx(rs.getInt(4));

				// Date date = rs.getDate(5);
				// SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
				// String str = fm.format(date);

				// add_bean.setVideo_date(str);

				list.add(add_bean);
			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 재생시간 불러오기
	public static int starttime(int user_idx, int video_idx) throws Exception {
		Connection conn = DB_Connector.getConnection();

		int time = 0;

		String sql = "select video_currenttime from video_currenttime"
				+ " where user_idx=? and video_idx=?";

		// PreparedStatement를 만들어 준다.
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, user_idx);
		pstmt.setInt(2, video_idx);

		ResultSet rs = pstmt.executeQuery();

		if (rs.next()) {
			time = rs.getInt("video_currenttime");

		}
		// System.out.println("t : " + time);
		conn.close();

		return time;
	}

	// 현재 시청중인 동영상의 위치 저장
	public static void currenttime(int user_idx, int currenttime, int video_idx)
			throws Exception {
		Connection conn = DB_Connector.getConnection();

		// 동영상이 있는지 확인.
		int time = starttime(user_idx, video_idx);

		// 없으면 insert 실행
		if (time == 0) {
			String sql = "insert into video_currenttime values (currenttime_seq.nextval, ?, ?, ?)";

			// PreparedStatement를 만들어 준다.
			PreparedStatement pstmt = conn.prepareStatement(sql);

			// ?에 값을 바인딩한다.
			pstmt.setInt(1, user_idx);
			pstmt.setInt(2, currenttime);
			pstmt.setInt(3, video_idx);
			// 쿼리 실행
			pstmt.execute();
			conn.close();
		} else {

			// 있으면 update 실행
			String sql2 = "UPDATE video_currenttime "
					+ " SET video_currenttime = ?"
					+ " WHERE user_idx=? AND video_idx=?";

			// PreparedStatement를 만들어 준다.
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1, currenttime);
			pstmt2.setInt(2, user_idx);
			pstmt2.setInt(3, video_idx);

			// 쿼리 실행
			pstmt2.execute();

			conn.close();
		}
	}
}
