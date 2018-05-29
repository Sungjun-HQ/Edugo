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


@WebServlet("/LeaveServlet")
public class LeaveServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String path = request.getContextPath();
		
		//파라미터 값을 받음.
		int user_idx = Integer.parseInt(request.getParameter("user_idx"));
			
		
		// 업데이트 하는 다오 호출.
		UserBean user = null;
		try {
			UserDAO.leave(user_idx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 이동.
		response.sendRedirect(path + "/member/logout.jsp");
	}
}



