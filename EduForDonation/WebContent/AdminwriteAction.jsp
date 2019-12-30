<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PipedWriter"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="web.AdminDAO"%>
<%@ page import="web.AdminEdu"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="main" class="web.AdminEdu" scope="page" />
<jsp:setProperty property="title" name="main" />
<jsp:setProperty property="text" name="main" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>대한민국 대학생 교육기부단</title>
</head>
<body>

	<%
	String admin_id = null;
	
	if (session.getAttribute("admin_id") != null) {
		admin_id = (String) session.getAttribute("admin_id");
	}
	
		if (admin_id == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자 로그인 후 사용 가능합니다!')");
			script.println("location.href = 'index.html'");
			script.println("</script>");

		} else {
			PrintWriter script = response.getWriter();
			if (main.getTitle() == null || main.getText() == null) {
				script.println("<script>");
				script.println("alert('입력이 안 된 항목이 있습니다!')");
				script.println("<history.back()");
				script.println("</script>");

			} else {
				AdminDAO mainDAO = new AdminDAO();
				int result = mainDAO.write(main.getTitle(),main.getText(),
						admin_id);
				if (result == -1) {
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다')");
					script.println("<history.back()");
					script.println("</script>");
				} else {

					script.println("<script>");
					script.println("location.href='edu2.jsp'");
					script.println("</script>");

				}
			}
		}
	%>