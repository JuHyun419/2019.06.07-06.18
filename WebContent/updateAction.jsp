<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> 
<%@ page import="bbs.Bbs" %> 
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트문을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 모든 데이터를 UTF-8로 받음 -->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판!!</title>
</head>
<body>

	<!-- 글쓰기 기능은 로그인이 되어있는 경우여야 한다. -->
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) //세션이 존재하는 회원
		{
			userID = (String) session.getAttribute("userID"); //해당 세션의 값을 넣는다.
		}

		if(userID == null) //로그인이 되어있지 않은경우(글쓰기가 안되야함)
		{
	 		PrintWriter script = response.getWriter();
	 		script.println("<script>");
	 		script.println("alert('로그인을 하세요.')");
	 		script.println("location.href = 'login.jsp'"); 
	 		script.println("</script>");
		}
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
			//bbsID가 null값이 아닌경우, bbsID에 읽어온 값을 저장한다.
		}
			
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
	 		script.println("<script>");
	 		script.println("alert('유효하지 않은 글입니다.')");
	 		script.println("location.href = 'bbs.jsp'"); 
	 		script.println("</script>");
		}
		
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
	 		script.println("<script>");
	 		script.println("alert('권한이 없습니다.')");
	 		script.println("location.href = 'bbs.jsp'"); 
	 		script.println("</script>");
		}
		
		
		
		else{
			if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
					|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")) //제목이나 내용을 입력하지 않은경우는 오류발생
					{
					 PrintWriter script = response.getWriter();
					 script.println("<script>");
					 script.println("alert('입력이 안 된 사항이 있습니다.!')");
					 script.println("history.back()"); 
					 script.println("</script>");
					}
					else{
						
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent")); 
					
					 if(result == -1)
					 {
						 PrintWriter script = response.getWriter();
						 script.println("<script>");
						 script.println("alert('글 수정에 실패했습니다.')");
						 script.println("history.back()"); //이전 페이지로 돌려보냄(join 페이지)
						 script.println("</script>"); 
					 }
					//DB를 생성할때 PRIMARY값으로 userID를 주었기 때문에, 동일한 아이뒤는 생성불가
					 
					 else 
					 {
						 PrintWriter script = response.getWriter();
						 script.println("<script>");
						 script.println("location.href = 'bbs.jsp'"); 
						 script.println("</script>");
					 }
					}
		}
		
	
		
	%>
</body>
</html>