<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
	<!-- viewport=화면상의 표시영역, content=모바일 장치들에 맞게 크기조정, initial=초기화면 배율 설정 -->
	
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="css/custom.css">
	<!-- 스타일시트로 css폴더의 bootstrap.css파일 사용 -->
	
<title>게시판!!</title>
</head>
<body>

	<%
		String userID = null;
		if(session.getAttribute("userID") != null)
		{
			userID = (String) session.getAttribute("userID");
		} //로그인이 된 회원은 로그인의 정보를 담을수 있도록 설정  
		
			int pageNumber = 1; // 기본 첫 페이지에 해당
			if(request.getParameter("pageNumber") != null){
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
				//현재의 게시판이 몇번째 페이지인지를 알려줄 수 있도록 설정
			}
	%>



	<nav class="navbar navbar-inverse"> <!-- navbar-색상(inverse = 검은색, default 22222= 색x) -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
				<!-- class="navbar-toggle collapsed"=>네비게이션의 화면 출력유무 
				data-toggle="collapse" : 모바일 상태에서 클릭하면서 메뉴가 나오게 설정 -->
			
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
					<!-- 아이콘 이미지 -->
				
			</button>
			
			<a class="navbar-brand" href="main.jsp">JJ WORLD</a>
				<!-- Bootstrap navbar 기본 메뉴바 -->
		</div>
		
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav"> <!-- navbar-nav => 네비게이션 바의 메뉴 -->
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
				<!-- 메뉴, 게시판의 main.jsp와 bbs.jsp의 파일로 각각 이동 -->
			</ul>
			<%
				if(userID == null) //로그인이 되어있지 않았을때, 
				{
					
				
			%>
			
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
							<!-- 임시의 주소링크 "#"을 기재한다. -->
							<!-- caret = creates a caret arrow icon (▼) -->
					
						<ul class="dropdown-menu">
							<!-- dropdown-menu : 버튼을 눌렀을때, 생성되는 메뉴(접속하기를 눌렀을때 로그인, 회원가입 메뉴 -->
					
							<li><a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul>
					</li>	
			</ul>
			
			<%
				}else	//로그인이 되었을때
				{
			%>	
			
							<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">회원관리<span class="caret"></span></a>
							<!-- 임시의 주소링크 "#"을 기재한다. -->
							<!-- caret = creates a caret arrow icon (▼) -->
					
						<ul class="dropdown-menu">
							<!-- dropdown-menu : 버튼을 눌렀을때, 생성되는 메뉴(접속하기를 눌렀을때 로그인, 회원가입 메뉴 -->
					
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul>
					</li>	
			</ul>	
			<% 
				}
			%>
			
			
		</div>
	</nav>
	<!--  <img alt="그림 없음" src="Circle.png">
	<img src="JJWORLD.png"> 
	-->
	
	
	<div clas="container">
		<div class="container-fluid">
			<table class="table" style="text-align:center; border: 4px; border-style:double; border-width: thick;">
			
			<thead>
				<tr>
					<th style="background-color: #4CAF50; color : white;text-align:center; font-style: italic;
							   font-size: 25px; font-weight: bold;">번호</th>
							   
					<th style="background-color: #4CAF50; color : white;text-align:center; font-style: italic;
							   font-size: 25px; font-weight: bold;">제목</th>
							   
					<th style="background-color: #4CAF50; color : white;text-align:center; font-style: italic;
							   font-size: 25px; font-weight: bold;">작성자</th>
							   
					<th style="background-color: #4CAF50; color : white;text-align:center; font-style: italic;
							   font-size: 25px; font-weight: bold;">작성일</th>
					
				</tr>
			</thead>
			<tbody>
				<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					for(int i=0; i<list.size(); i++){				
				%>			
				<tr>
					<td><%= list.get(i).getBbsID() %></td>  <!-- 번호, 제목, 작성자, 작성일 표시 -->
					<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>">
					<%= list.get(i).getBbsTitle() %></a></td>
					 <!-- 제목을 눌렀을땐, 해당 게시글을 표시해줘야함 따라서 참조 -->
					<td><%= list.get(i).getUserID() %></td>
					<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + 
					"시 " + list.get(i).getBbsDate().substring(14, 16) + "분 " %></td>
					<!-- MySQL에서 Date를 2019-06-06 12:48:49식으로 나타내서, 보기 좋게 변경 -->
				</tr>	
				<%
					}
				%>
			</tbody>
			
			</table>
			<%
				if(pageNumber != 1)
				{
			%>
					<a href="bbs.jsp?pageNumber=<%=pageNumber -1%>" class="btn btn-success btn-arraw-left">이전</a>
				
			<% 
				}if(bbsDAO.nextPage(pageNumber +1)){
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber +1%>" class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
			
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>