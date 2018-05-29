package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import dao.UserDAO;
import bean.UserBean;


@WebServlet("/UpdateInfoServlet")
public class UpdateInfoServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String path = request.getContextPath();
		int user_idx = Integer.parseInt(request.getParameter("user_idx"));
		String user_email = request.getParameter("user_email");
		String user_address = request.getParameter("user_address");
		int user_phone = Integer.parseInt(request.getParameter("user_phone"));
		
		
		UserBean user_bean = new UserBean();
		
		user_bean.setUser_idx(user_idx);
		user_bean.setUser_email(user_email);
		user_bean.setUser_address(user_address);
		user_bean.setUser_phone(user_phone);
		
		
		// 회원정보 변경 메서드 호출
		UserBean user = null;
		try {
			user = UserDAO.update_user(user_bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 이동.
		HttpSession session = request.getSession();
		session.setAttribute("login", "OK");
		session.setAttribute("user_bean", user);
		response.sendRedirect(path + "/member/myinfo.jsp");
	}
}



