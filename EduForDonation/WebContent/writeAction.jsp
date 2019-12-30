<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PipedWriter"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="main.MainDAO2"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="main" class="main.Main" scope="page"></jsp:useBean>
<jsp:setProperty property="name" name="main" />
<jsp:setProperty property="reasonForApplication" name="main" />
<jsp:setProperty property="prosAndCons" name="main" />
<jsp:setProperty property="programYouWant" name="main" />
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
	String EmailID = null;
	
	if (session.getAttribute("EmailID") != null) {
	EmailID = (String) session.getAttribute("EmailID");
	}
	
		if (EmailID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 지원 가능합니다!')");
			script.println("location.href = 'index.html'");
			script.println("</script>");

		} else {
			PrintWriter script = response.getWriter();
			if (main.getName() == null || main.getReasonForApplication() == null || main.getProsAndCons() == null
					|| main.getProgramYouWant() == null) {
				script.println("<script>");
				script.println("alert('입력이 안 된 문항이 있습니다!')");
				script.println("<history.back()");
				script.println("</script>");

			} else {
				MainDAO2 mainDAO = new MainDAO2();
				int result = mainDAO.write(main.getName(), EmailID, main.getReasonForApplication(),
						main.getProsAndCons(), main.getProgramYouWant());
				if (result == -1) {
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다')");
					script.println("<history.back()");
					script.println("</script>");
				} else {

					script.println("<script>");
					script.println("location.href='mainsupport.jsp'");
					script.println("</script>");

				}
			}
		}
	%>