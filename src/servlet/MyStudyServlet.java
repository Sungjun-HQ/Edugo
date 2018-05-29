package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.MyStudyBean;
import bean.UserBean;
import dao.MyStudyDAO;

@WebServlet("/MyStudyServlet")
public class MyStudyServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		// 세션에 있는 회원의 정보를 받아온다.
		HttpSession session = request.getSession();
		UserBean user = (UserBean) session.getAttribute("user_bean");

		String sub_name = request.getParameter("sub_name");

		ArrayList<MyStudyBean> list = null;

		// 결제한 과목 불러오기.

		// 전체 동영상 불러오기와 선택한 과목의 동영상만 불러오기
		if (sub_name == null) {
			list = MyStudyDAO.getMyStudyList(user.getUser_idx());
		} else {
			list = MyStudyDAO.getMyStudyList2(user.getUser_idx(), sub_name);
		}

		HashSet<String> subject_set = new HashSet<String>();
		for (MyStudyBean m_bean : list) {
			subject_set.add(m_bean.getSub_name());
		}

		// System.out.println("aa : " + user.getUser_idx());

		// user 에서 user_idx를 받아서 넘긴다.
		// ArrayList<MyStudyBean> list =
		// MyStudyDAO.getMyStudyList(user.getUser_idx());

		// ArrayList를 request객체에 담는다.
		request.setAttribute("list", list);

		request.setAttribute("subject_set", subject_set);

		// mystudy.jsp로 이동
		String site = "/mypage/mystudy.jsp";
		RequestDispatcher dis = request.getRequestDispatcher(site);
		dis.forward(request, response);

		// response.sendRedirect(path + "/mypage/mystudy.jsp");
	}
}
