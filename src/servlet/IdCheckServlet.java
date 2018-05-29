package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;

@WebServlet("/IdCheckServlet")
public class IdCheckServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String path = request.getContextPath();
		String user_id = request.getParameter("user_id");

		// 로그인 처리 메서드 호출

		try {
			int result = UserDAO.id_check(user_id);
			response.setContentType("text/plain;charset=utf-8");
			PrintWriter out = response.getWriter();
			String str = result + "";
			out.write(str);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
