<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PipedWriter"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="hamsung.HamSungDAO"%>
<%@ page import="hamsung.HamSung"%>
<%@ page import="java.util.ArrayList"%>
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
		String EmailID = null;
		String MemberName = null;
		if (session.getAttribute("EmailID") != null) {
			EmailID = (String) session.getAttribute("EmailID");
		}
		if (session.getAttribute("MemberName") != null) {
			MemberName = (String) session.getAttribute("MemberName");
		}
		if (EmailID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 사용 가능합니다!')");
			script.println("location.href = 'index.html'");
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
			<a class="navbar-brand" href="main.jsp">대한민국 대학생 교육기부단</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">홈</a></li>
				<li><a href="info.jsp">대교단 소개</a></li>
				<li><a href="mainsupport.jsp">대교단 집행부 지원</a></li>
				<li><a href="socsupport.jsp">쏙쏙캠프 사전연수회</a></li>
				<li><a href="alhamsupport.jsp">알락달락/함성소리 사전연수회</a></li>
					<li><a href="edu.jsp">공지사항</a></li>
			</ul>
			
			<%
				if (EmailID == null) {
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
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						
						<th style="background-color: #eeeeee; text-align: center;">이름</th>
						<th style="background-color: #eeeeee; text-align: center;">아이디</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
					HamSungDAO hamsungDAO = new HamSungDAO();
					ArrayList<HamSung> list3 = hamsungDAO.getList(pageNumber);
					for (int i = 0; i < list3.size(); i++) {
							if(session.getAttribute("EmailID").equals(list3.get(i).getEmailID())){
					%>
					<tr>
						
						<td><a
							href="viewSupport2.jsp?SupportID=<%=list3.get(i).getSupportID()%>"><%=list3.get(i).getName().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
						<td><%=list3.get(i).getEmailID()%></td>
						<td><%=list3.get(i).getSupportDate().substring(0, 11) + list3.get(i).getSupportDate().substring(11, 13)
						+ "시" + list3.get(i).getSupportDate().substring(14, 16) + "분"%></td>
					</tr>
					<%
						}}
					%>
				</tbody>
			</table>
			<%
				if (pageNumber != 1) {
			%>
			<a href="mysupport2.jsp?pageNumber=<%=pageNumber - 1%>"
				class="btn btn-success btn-arraw-left">이전</a>
			<%
				}
				if (hamsungDAO.nextPage(pageNumber + 1)) {
			%>
			<a href="mysupport2.jsp?pageNumber=<%=pageNumber + 1%>"
				class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
	
		</div>
	</div>
	<div class="col-lg-4"></div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>