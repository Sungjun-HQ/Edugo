package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.UserBean;
import dao.MyStudyDAO;

@WebServlet("/CurrentTimeServlet")
public class CurrentTimeServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		// 세션에 있는 회원의 정보를 받아온다.
		HttpSession session = request.getSession();
		UserBean user = (UserBean) session.getAttribute("user_bean");

		int currenttime = Integer.parseInt(request.getParameter("currenttime"));
		int video_idx = Integer.parseInt(request.getParameter("video_idx"));

		// System.out.println("cc : " + currenttime);
		// System.out.println("aa : " + user.getUser_idx());
		// System.out.println("kk : " + video_idx);

		// 재생 시간 업데이트
		try {
			MyStudyDAO.currenttime(user.getUser_idx(), currenttime, video_idx);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
