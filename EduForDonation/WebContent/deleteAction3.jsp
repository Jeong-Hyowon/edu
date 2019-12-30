<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PipedWriter"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="hamsung.HamSungDAO"%>
<%@ page import="hamsung.HamSung"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="main" class="hamsung.HamSung" scope="page"></jsp:useBean>
<jsp:setProperty property="name" name="main" />
<jsp:setProperty property="department" name="main" />
<jsp:setProperty property="size" name="main" />
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

		}
		int SupportID = 0;
		if (request.getParameter("SupportID") != null) {
			SupportID = Integer.parseInt(request.getParameter("SupportID"));
		}
		if (SupportID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다!')");
			script.println("location.href = 'mainsupport.jsp'");
			script.println("</script>");
		}
		HamSung Main = new HamSungDAO().getHamSung(SupportID);
		if (!EmailID.equals(Main.getEmailID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다!')");
			script.println("location.href = 'mainsupport.jsp'");
			script.println("</script>");

			} else {
				HamSungDAO mainDAO = new HamSungDAO();
				PrintWriter script = response.getWriter();
				int result = mainDAO.delete(SupportID);
				if (result == -1) {
					script.println("<script>");
					script.println("alert('글삭제에 실패했습니다')");
					script.println("<history.back()");
					script.println("</script>");
				} else {

					script.println("<script>");
					script.println("location.href='mainsupport.jsp'");
					script.println("</script>");

				}
			}
	%>