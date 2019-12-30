<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PipedWriter"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

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
			script.println("alert('로그인 후 사용 가능합니다!')");
			script.println("location.href = 'index.html'");
			script.println("</script>");

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
				<li class="active"><a href="mainsupport.jsp">대교단 집행부 지원</a></li>
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
<%
String Passwd = "";
String CPhone = "";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String dbURL = "jdbc:mysql://localhost:3306/memberdb?characterEncoding=UTF-8&serverTimezone=UTC";
String dbID = "root";
String dbPassword = "20161139";
Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

pstmt = conn.prepareStatement("SELECT Passwd, CPhone FROM MEMBER WHERE EmailID = ?");
pstmt.setString(1, EmailID);

rs = pstmt.executeQuery();

if(rs.next()){
 Passwd = rs.getString("Passwd");
 CPhone = rs.getString("CPhone");

}
%>

	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="updatePro.jsp">
					<h3 style="text-align: center;">회원정보 수정</h3>
					<div class="form-group">
						User Email: <% out.println(EmailID); %>
					</div>
					<div class="form-group">
						User Password:<input type="password" class="form-control"
							placeholder="비밀번호" name="Passwd" maxlength="20" />
					</div>
					<!--  			<div class="form-group">
						User Password:<input type="password" class="form-control"
							placeholder="비밀번호 확인" name="Passwd_check" maxlength="20" />
					</div> 
					-->
				
					<div class="form-group">
						User Phone Number:<input type="text" class="form-control"
							placeholder="(ex.010-000(0))-0000)" name="CPhone"
							maxlength="20" />
					</div>
					<input type="submit" class="btn btn-primary form-control"
						value="회원정보 수정" />
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<div class="col-lg-4"></div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>