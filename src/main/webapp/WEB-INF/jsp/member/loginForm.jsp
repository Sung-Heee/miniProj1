<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login form</title>
<link rel="stylesheet" type="text/css" href="resource/css/style.css">
</head>

<c:if test="${not empty param.err}">
<script>
	alert("아이디 또는 비밀번호가 잘못되었습니다.");
</script>	
</c:if>

<body>

<!-- 헤더 --> 
<%@ include file="../header/header.jsp" %>

<div class="login-container">
<form id="loginForm" action="member.do" method="post" >
    	<input type="hidden" name="action" value="login">
    	<label>아이디 : </label> <input type="text" id="userId" name=userId required="required" value="${parqa.userId}"><br/>
        <label>비밀번호 : </label> <input type="password" id="userPassword" name="userPassword" required="required"><br/>
    <div>
        <input type="submit" value="로그인" class="btn">
        <a href="member.do?action=list" class="btn">취소</a>
    </div>
             
</form>

</div>


</body>
</html>