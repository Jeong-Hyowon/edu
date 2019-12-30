<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PipedWriter"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="web.AdminDAO"%>
<%@ page import="web.AdminEdu"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="main" class="web.AdminEdu" scope="page"></jsp:useBean>
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
		String EmailID = null;
		
		if (session.getAttribute("EmailID") != null) {
			EmailID = (String) session.getAttribute("EmailID");
		}
		
		String admin_id = null;

		if (session.getAttribute("admin_id") != null) {
			admin_id = (String) session.getAttribute("admin_id");
		}

		
		int SupportID = 0;
		if (request.getParameter("SupportID") != null) {
			SupportID = Integer.parseInt(request.getParameter("SupportID"));
		}
		if (SupportID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다!')");
			script.println("location.href = 'edu.jsp'");
			script.println("</script>");
		}
		AdminEdu Main = new AdminDAO().getMain(SupportID);
		
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
				<li class="active"><a href="edu.jsp">공지사항</a></li>
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
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">대교단
							공지사항 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td sytle="width: 20%;">제목</td>
						<td colspan="2"><%=Main.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br>")%></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2"><%=Main.getText()%></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%=Main.getSupportDate().substring(0, 11) + Main.getSupportDate().substring(11, 13) + "시"
					+ Main.getSupportDate().substring(14, 16) + "분"%></td>
					</tr>
					<tr>
						
				</tbody>
			</table>
			<a href="edu.jsp" class="btn btn-primary">목록</a>
			<%
				if (admin_id != null && admin_id.equals(Main.getAdmin_id())) {
			%>
			<a href="updateSupport4.jsp?SupportID=<%=SupportID%>"
				class="btn btn-primary">수정</a> 
				<a onclick="return confirm('해당 게시물를 삭제하시겠습니까?')" href="deleteAction4.jsp?SupportID=<%=SupportID%>"
				class="btn btn-primary">삭제</a>
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