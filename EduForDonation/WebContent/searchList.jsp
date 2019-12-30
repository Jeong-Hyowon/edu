<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PipedWriter"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="main.MainDAO2"%>
<%@ page import="main.Main"%>
<%@ page import="java.util.ArrayList"%>
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
			script.println("alert('로그인 후 지원 가능합니다!')");
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
		request.setCharacterEncoding("utf-8");

		String sv = request.getParameter("sv");
		String sk = request.getParameter("sk");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String dbURL = "jdbc:mysql://localhost:3306/memberdb?characterEncoding=UTF-8&serverTimezone=UTC";
		String dbID = "root";
		String dbPassword = "20161139";
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		String simple = "select * from supportmain"; // 쿼리문장을 보다 쉽게 입력하기 위해 변수 선언
		if ((sk == null && sv == null) || (sk != null && sv == "")) { // 조건비교 (입력되지 않음)
			//pstmt = conn.prepareStatement(simple); // 쿼리 실행전 문장입력
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('검색할 내용을 입력해주세요!')");
			script.println("<history.back()");
			script.println("</script>");
		} else if (sk != null && sv != null) { // 조건비교 (입력이 있음)
			pstmt = conn.prepareStatement(simple + " where " + sk + "= ?"); // 쿼리 실행전 문장입력

			pstmt.setString(1, sv); // 보여줄 값을 세팅한다.
			}
		
		// 쿼리 실행한다.
		rs = pstmt.executeQuery();

		// 쿼리 실행후 결과값을 이용한다.(검색 결과 보여주기)
		while (rs.next()) {
	%>



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
						MainDAO2 mainDAO = new MainDAO2();
							ArrayList<Main> list = mainDAO.getList(pageNumber);
						
					%>
					<tr>
						<td><a
							href="viewSupport.jsp?SupportID="><%=rs.getString("Name").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
							.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
						<td><%=rs.getString("EmailID")%></td>
						<td><%=rs.getString("SupportDate").substring(0, 11)+
								rs.getString("SupportDate").substring(11, 13) + "시"+
								rs.getString("SupportDate").substring(14, 16) + "분"%></td>
					</tr>
		
				</tbody>
			</table>
			<%
				if (pageNumber != 1) {
			%>
			<a href="mainsupport.jsp?pageNumber=<%=pageNumber - 1%>"
				class="btn btn-success btn-arraw-left">이전</a>
			<%
				}
					if (mainDAO.nextPage(pageNumber + 1)) {
			%>
			<a href="mainsupport.jsp?pageNumber=<%=pageNumber + 1%>"
				class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
			<a href="writemain.jsp" class="btn btn-primary pull-right">지원하기</a>
			<%
				}
			%>
			<div id="table_search">
				<form action="<%=request.getContextPath()%>/searchList.jsp"
					method="get">
					<center>
						<select name="sk">
							<!-- option에 따라 선택한 값을 sk에 담아서 post방식으로 이동한다. -->
							<option value="Name">이름</option>
							<option value="EmailID">아이디</option>
						</select> <input type="text" name="sv" class="input_box"> <input
							type="submit" value="search" class="btn">
					</center>
				</form>


			</div>
		</div>
	</div>
	<div class="col-lg-4"></div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>