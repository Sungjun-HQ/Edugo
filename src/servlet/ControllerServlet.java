package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.test")
public class ControllerServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		// 요청시 사용한 주소를 얻어온다.
		String uri = request.getRequestURI();

		// 뒤의 서블릿 이름만 추출
		String[] sname = uri.split("/");
		uri = sname[sname.length - 1];

		// 세션 ID값이 주소에 붙어서 나올경우 처리
		sname = uri.split(";");
		uri = sname[0];

		// 서블릿 이름으로 분기
		if (uri.equals("mystudy.test")) {
			move_to(request, response, "MyStudyServlet");
		} else if (uri.equals("currenttime.test")) {
			move_to(request, response, "CurrentTimeServlet");
		} else if (uri.equals("id_check.test")) {
			move_to(request, response, "IdCheckServlet");
		} else if (uri.equals("updateinfo.test")){
			move_to(request, response, "UpdateInfoServlet");
		} else if (uri.equals("updatepasswd.test")){
			move_to(request, response, "UpdatePasswdServlet");
		} else if (uri.equals("leave.test")){
			move_to(request, response, "LeaveServlet");
		}
	}

	// 이동처리하는 매서드
	public void move_to(HttpServletRequest request,
			HttpServletResponse response, String url) throws ServletException,
			IOException {
		// forward : 응답 결과가 클라이언트로 전달되지 않고 서버에서만 이동한다.
		// redirect : 응답 결과가 클라이언트로 전달된다.
		// RequestDispatcher 추출
		RequestDispatcher dis = request.getRequestDispatcher(url);
		// forward
		dis.forward(request, response);
	}

}
