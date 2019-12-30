<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="Admin" class="web.AdminDAO" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>대한민국 대학생 교육기부단</title>
</head>
<body>
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
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="main.jsp">홈</a></li>
			
			<li><a href="edu.jsp">공지사항</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false">대교단이 되어주세요!<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li class="active"><a href="index.html">로그인</a></li>
					<li><a href="join.html">회원가입</a></li>
					<li><a href="admin_login.jsp">관리자 접속</a></li>
				</ul></li>
		</ul>
	</div>

	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="admin_login_action.jsp">
					<h3 style="text-align: center;">관리자 로그인 화면</h3>
					<div class="form-group">
						User Id:<input type="text" class="form-control" placeholder="아이디"
							name="admin_id" maxlength="20" />
					</div>
					<div class="form-group">
						Passwd :<input type="password" class="form-control"
							placeholder="비밀번호" name="admin_pass" maxlength="20" />
					</div>
					<input type="submit" class="btn btn-primary form-control"
						value="로그인" />
				</form>
			</div>
		</div>
		
		<div class="col-lg-4"></div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>

</html>