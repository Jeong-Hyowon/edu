package web;

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class DoJoin
 */
@WebServlet("/doJoin")
public class DoJoin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DoJoin() {
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
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("UTF-8");
		
		String EmailID = request.getParameter("EmailID");
		String Passwd = request.getParameter("Passwd");
//      String Passwd_check = request.getParameter("Passwd_check");
		String CPhone = request.getParameter("CPhone");
		

		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		ServletContext sc = getServletContext();
		Connection conn = (Connection) sc.getAttribute("DBconnection");
		PrintWriter script = response.getWriter();
		HttpSession session = request.getSession();

		String emailRegex = "^[_0-9a-zA-Z-]+@[0-9a-zA-Z-]+\\.[0-9a-zA-Z-]*$";
		String phoneRegex = "^(01[016789])-(\\d{3,4})-(\\d{4})*$";
		String nameRegex = "^[a-zA-Z가-힣]+$";
		

		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT EmailID FROM member WHERE EmailID='" + EmailID + "'");

			if (EmailID.length() < 1 || Passwd.length() < 1 ) {
				script.println("<script>");
				script.println("alert('회원가입 정보를 모두 입력해주세요')");
				script.println("<history.back()");
				script.println("</script>");
			} else if (!EmailID.matches(emailRegex)) {
				script.println("<script>");
				script.println("alert('이메일 형식에 맞지 않습니다!')");
				script.println("<history.back()");
				script.println("</script>");
			}
//			else if (!Passwd.equals(Passwd_check)) {
//				out.println("<script>");
//				out.println("location.href = 'differPasswd.html'");
//				out.println("</script>");
//			} 
			else if (rs.next()) {
				script.println("<script>");
				script.println("alert('이미 존재하는 이메일입니다!')");
				script.println("<history.back()");
				script.println("</script>");
			} else if (CPhone.length() > 0 && !CPhone.matches(phoneRegex)) {
				script.println("<script>");
				script.println("alert('휴대전화번호 형식이 맞지 않습니다!')");
				script.println("<history.back()");
				script.println("</script>");
			} else {

				PreparedStatement pstmt = conn.prepareStatement("INSERT INTO MEMBER VALUES (?,?,?)");
				conn.setAutoCommit(false);

				pstmt.setString(1, EmailID.toLowerCase());
				pstmt.setString(2, Passwd.toLowerCase());
//				pstmt.setString(3, Passwd_check.toLowerCase());
				pstmt.setString(3, CPhone);
				
				pstmt.executeUpdate();

				conn.commit();

				conn.setAutoCommit(true);

				session.setAttribute("EmailID", EmailID);

				script.println("<script>");
				script.println("location.href='index.html'");
				script.println("</script>");

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}