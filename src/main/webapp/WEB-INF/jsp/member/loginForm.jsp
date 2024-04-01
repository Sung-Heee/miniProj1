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
<form id="loginForm" action="member.do?action=login" method="post" >
	<div class="login-inner-container">
		<div class="login-top-container"><h1>Login</h1></div>
		<div class="login-input-container">
    	
    		<div class="login-id">
    			<input type="text" class="login-id-input" id="userId" name=userId required="required" value="${parqa.userId}" placeholder="id">
    		</div>
    		<div class="login-password">
        		<input type="password" class="login-password-input" id="userPassword" name="userPassword" required="required" placeholder="password">
        	</div>
        	<div class="login-autologin-container">
        		<div class="login-autologin">
        			<label for="autologin">자동로그인</label> <input type="checkbox" id="autologin" name="autologin" value="Y">
        		</div>
        	</div>    
    	</div>
    	<div class="login-btn-container">
    		<div class="login-btn-div">
        		<input type="submit" value="Login" class="login-btn">
        	</div>
        	<div class="login-signup">
        		계정이 없으신가요? <a href="member.do?action=insertForm" class="login-signup-a">회원가입</a> 
        	</div>
        	<!-- <a href="member.do?action=list" class="btn">취소</a> -->
    	</div>
    </div>         
</form>

</div>


</body>
</html>