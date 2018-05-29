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


@WebServlet("/UpdatePasswdServlet")
public class UpdatePasswdServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String path = request.getContextPath();
		
		//파라미터 값을 받음.
		int user_idx = Integer.parseInt(request.getParameter("user_idx"));
		String new_passwd = request.getParameter("new_passwd");
		
		
		UserBean user_bean = new UserBean();
		
		user_bean.setUser_idx(user_idx);
		user_bean.setUser_pw(new_passwd);
	
		
		// 업데이트 하는 다오 호출.
		UserBean user = null;
		try {
			user = UserDAO.update_passwd(user_bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 이동.
		HttpSession session = request.getSession();
		session.setAttribute("login", "OK");
		session.setAttribute("user_bean", user);
		response.sendRedirect(path + "/member/update_passwd.jsp");
	}
}



