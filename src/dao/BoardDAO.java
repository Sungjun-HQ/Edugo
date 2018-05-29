package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class BoardDAO {

	public static ArrayList<HashMap<String, Object>> getBoard(int page_num,
			int board_num) throws Exception {

		// DB 접속
		Connection conn = DB_Connector.getConnection();

		// 최대 최소 번호값 가져오기
		int con_min = 1 + (page_num - 1) * 10;
		int con_max = 10 + (page_num - 1) * 10;

		// 게시판의 글 목록을 가져온다.
		// 가져와 보여줄 데이터
		// 글번호, 글제목, 날짜, 조회수 회원 이름
		// String sql =
		// "select n.notice_idx, n.notice_title, n.notice_date, n.notice_count, u.user_id "
		// + "from user_table u, notice n "
		// + "where u.user_idx=n.user_idx "
		// + "order by n.notice_idx desc";

		String sql = null;

		switch (board_num) {
		case 1:
			sql = "select * from "
					+ "(select rownum as rnum, a1.* from "
					+ "(select n.notice_idx, n.notice_title, n.notice_date, n.notice_count, u.user_id "
					+ "from user_table u, notice n "
					+ "where u.user_idx=n.user_idx "
					+ "order by n.notice_idx desc) a1) a2 "
					+ "where a2.rnum >= ? and a2.rnum <=?";
			break;
		case 2:
			sql = "select * from "
					+ "(select rownum as rnum, a1.* from "
					+ "(select e.epilogue_idx, e.epilogue_title, e.epilogue_date, e.epilogue_count, u.user_id "
					+ "from user_table u, epilogue e "
					+ "where u.user_idx=e.user_idx "
					+ "order by e.epilogue_idx desc) a1) a2 "
					+ "where a2.rnum >= ? and a2.rnum <=?";
			break;
		case 3:
			sql = "select * from "
					+ "(select rownum as rnum, a1.* from "
					+ "(select e.event_idx, e.event_title, e.event_date, e.event_count, u.user_id "
					+ "from user_table u, event e "
					+ "where u.user_idx=e.user_idx "
					+ "order by e.event_idx desc) a1) a2 "
					+ "where a2.rnum >= ? and a2.rnum <=?";
			break;
		case 4:
			sql = "select * from "
					+ "(select rownum as rnum, a1.* from "
					+ "(select q.quest_idx, q.quest_title, q.quest_date, q.quest_count, u.user_id "
					+ "from user_table u, question q "
					+ "where u.user_idx=q.user_idx "
					+ "order by q.quest_idx desc) a1) a2 "
					+ "where a2.rnum >= ? and a2.rnum <=?";
			break;
		case 5:
			sql = "select * from "
					+ "(select rownum as rnum, a1.* from "
					+ "(select o.onequest_idx, o.onequest_title, o.onequest_date, o.onequest_count, u.user_id "
					+ "from user_table u, onequest o "
					+ "where u.user_idx=o.user_idx "
					+ "order by o.onequest_idx desc) a1) a2 "
					+ "where a2.rnum >= ? and a2.rnum <=?";
			break;
		case 6:
			sql = "select * from "
					+ "(select rownum as rnum, a1.* from "
					+ "(select f.faq_idx, f.faq_title, f.faq_date, f.faq_count, u.user_id "
					+ "from user_table u, faq f "
					+ "where u.user_idx=f.user_idx "
					+ "order by f.faq_idx desc) a1) a2 "
					+ "where a2.rnum >= ? and a2.rnum <=?";
			break;
		}

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, con_min);
		pstmt.setInt(2, con_max);
		ResultSet rs = pstmt.executeQuery();

		// Hashmap 을 저장할 ArrayList를 하나 생성
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		while (rs.next()) {
			// 로우 하나에 데이터를 담습니다. Hashmap으로 값을 저장
			HashMap<String, Object> map = new HashMap<String, Object>();

			map.put("board_idx", rs.getInt(2));
			map.put("board_title", rs.getString(3));
			map.put("board_date", rs.getString(4));
			map.put("board_count", rs.getInt(5));
			map.put("user_id", rs.getString(6));

			// 저장한 데이터 map을 ArrayList list에 넣어서 착착 보관해 둡니다.
			list.add(map);
		}

		return list;
	}
}
