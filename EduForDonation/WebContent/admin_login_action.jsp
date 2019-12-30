<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="Admin" class="web.AdminDAO" />
		
		<%
	String admin_id = request.getParameter("admin_id");
	String admin_pass = request.getParameter("admin_pass");
	boolean b = Admin.admin_login(admin_id, admin_pass);

	if (b) {
		session.setAttribute("admin_id", admin_id);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자님 로그인 되셨습니다!')");
		script.println("location.href = 'main2.jsp'");
		script.println("</script>");

	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디 및 비밀번호가 올바르지 않습니다!')");
		script.println("history.back()");
		script.println("</script>");

	}
%>
		