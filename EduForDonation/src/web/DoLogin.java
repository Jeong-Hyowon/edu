package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.DBUtil;

/**
 * Servlet implementation class DoLogin
 */
@WebServlet("/doLogin")
public class DoLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DoLogin() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		request.setCharacterEncoding("UTF-8");
		String EmailID = request.getParameter("EmailID");
		String Passwd = request.getParameter("Passwd");
		
		HttpSession session = request.getSession();

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		ServletContext sc = getServletContext();
		Connection conn = (Connection) sc.getAttribute("DBconnection");

		ResultSet rs = DBUtil.findUser(conn, EmailID);

		PrintWriter script = response.getWriter();
		if (rs != null) {
			try {

				if (rs.next()) { // existing user

					String checkpw = rs.getString(1);

					if (checkpw.equals(Passwd)) {
						// valid user and passwd

						if (EmailID != null) {
							session.setAttribute("EmailID", EmailID);
							
							script.println("<script>");
							script.println("location.href='main.jsp'");
							script.println("</script>");

						}

					} else {
						// wrong passwd

						script.println("<script>");
						script.println("alert('비밀번호가 틀립니다')");
						script.println("<history.back()");
						script.println("</script>");
					}
				}

				if (EmailID.length() < 1 || Passwd.length() < 1) {

					script.println("<script>");
					script.println("alert('로그인 정보를 모두 입력해주세요')");
					script.println("<history.back()");
					script.println("</script>");
				} else {
					// invalid user

					script.println("<script>");
					script.println("alert('존재하지 않는 아이디입니다')");
					script.println("<history.back()");
					script.println("</script>");
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
