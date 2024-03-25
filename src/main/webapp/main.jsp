<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<link rel="stylesheet" href="css/style.css">
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
</body>
</html>