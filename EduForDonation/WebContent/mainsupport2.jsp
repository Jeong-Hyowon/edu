<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PipedWriter"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="web.AdminDAO"%>
<%@ page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="main" class="web.AdminSupport" scope="page" />
<jsp:setProperty property="start" name="main" />
<jsp:setProperty property="end" name="main" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>로그인</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration;
	none;
}
</style>
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
			script.println("alert('관리자 로그인 후 확인 가능합니다!')");
			script.println("location.href = 'admin_login.jsp'");
			script.println("</script>");

		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main2.jsp">대한민국 대학생 교육기부단</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main2.jsp">홈</a></li>
				<li><a href="info.jsp">대교단 소개</a></li>
				<li class="active"><a href="mainsupport2.jsp">대교단 집행부 지원</a></li>
				<li><a href="socsupport2.jsp">쏙쏙캠프 사전연수회</a></li>
				<li><a href="alhamsupport2.jsp">알락달락/함성소리 사전연수회</a></li>
					<li><a href="edu2.jsp">공지사항</a></li>
			</ul>

			<%
				if (admin_id == null) {
			%>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">대교단이 되어주세요!<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="index.html">로그인</a></li>
						<li><a href="join.html">회원가입</a></li>
						<li><a href="admin_login.jsp">관리자 접속</a></li>
					</ul></li>
			</ul>

			<%
				} else {
			%>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"><img src="images/ed.jpg" width="30"
						, height="30">환영합니다!<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="logout.jsp">로그아웃</a></li>
						<li><a href="mypage.jsp">마이페이지</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>

	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="AdminWriteAction.jsp">
				<h3 style="text-align: center;">대교단 집행부 지원서 게시판 시간설정</h3>
				<div class="form-group">
					Start Time:<input type="text" class="form-control"
						placeholder="시작시간" name="start" maxlength="100" />
				</div>
				<div class="form-group">
					End Time:<input type="text" class="form-control"
						placeholder="마감시간" name="end" maxlength="100" />
				</div>
				<input type="submit" class="btn btn-primary form-control"
						value="설정하기" />
				</form>
		</div>

	</div>
	<div class="col-lg-4"></div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>