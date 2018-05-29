package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class VideoDAO {

	public static ArrayList<HashMap<String, Object>> getVideo(int page_num)
			throws Exception {

		Connection conn = DB_Connector.getConnection();

		int con_mix = 1 + (page_num - 1) * 10;
		int con_max = 10 + (page_num - 1) * 10;

		// 과목 이름, 강사 이름, 동영상 제목 | 없는 정보: 강의 가격, 수강 기간
		String sql = "select * from (select rownum as rnum, a1.* from "
				+ "(select v.video_idx, s.sub_name, v.video_name, u.user_name "
				+ "from user_table u, subject s, video v "
				+ "where u.user_idx=s.user_idx and v.sub_idx=s.sub_idx "
				+ "order by v.video_idx desc) a1) a2 "
				+ "where a2.rnum >= ? and a2.rnum <=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, con_mix);
		pstmt.setInt(2, con_max);
		ResultSet rs = pstmt.executeQuery();

		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		// select v.video_idx, s.sub_name, v.video_name, u.user_name
		while (rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();

			map.put("video_idx", rs.getInt(2));
			map.put("subject", rs.getString(3));
			map.put("video_name", rs.getString(4));
			map.put("user_name", rs.getString(5));

			list.add(map);
		}

		return list;
	}
}
