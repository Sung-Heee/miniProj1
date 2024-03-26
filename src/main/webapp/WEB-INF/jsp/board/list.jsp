<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board list</title>
<link rel="stylesheet" type="text/css" href="resource/css/style.css">
</head>
<body>
<header>
<div class="header-container">

<div class="logo-container">
	<a href="main.jsp" class="logo">logo</a>
</div>

<div class="menu-container">
	<a href="/" class="menu-btn">Company</a>
	<a href="board.do?action=list" class="menu-btn">Board</a>
</div>

<div class="sign-container">
	<a href="member.do?action=loginForm" class="underline-btn">Login</a>
	<a href="member.do?action=insertForm" class="square-btn">Sign Up</a>
</div>

</div>
</header>

<div class="list-container">
<form id="listForm" action="board.do" method="post">
    <input type="hidden" id="action" name="action" value="view">
    <input type="hidden" id="bno" name="bno" >
</form>

<div class="list-inner-container">
	<div class="list-top-menu">
		<div class="insert-container">
			<a href="" class="insert-btn">글 작성하기</a>
		</div>
		<div class="searchbar-container">
			<div class="searchbar">
				<input type="text" placeholder="제목을 입력해주세요.">
				<a href="">검색</a>
			</div>
		</div>
	</div>
	
	<div class="list">
<table border="1">
	<tr>
    	<th>게시물번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
    </tr>
    <c:forEach var="board" items="${list}">
    <tr>
        <td onclick="jsView('${board.bno}')"  style="cursor:pointer;">${board.bno}</td>
        <td><a href="board.do?action=detail&bno=${board.bno}">${board.btitle}</a></td>
        <td>${board.bwriter}</td>
        <td>${board.bdate}</td>
    </tr>
    </c:forEach>
</table>

<div class="button-container">
    <a href="board.do?action=insertForm" class="btn">등록</a>
</div>

</div>
</div>

<script>
function jsView(bno) {
	//인자의 값을 설정한다 
	bno.value = bno;
	
	//양식을 통해서 서버의 URL로 값을 전달한다
	listForm.submit();
}
</script>      
</body>
</html>