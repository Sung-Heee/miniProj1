<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member list</title>
<link rel="stylesheet" type="text/css" href="resource/css/style.css">
</head>
<body>

<!-- 헤더 --> 
<%@ include file="../header/header.jsp" %>

<div class="list-container">
<form id="listForm" action="member.do" method="post">
    <input type="hidden" id="action" name="action" value="view">
    <input type="hidden" id="userId" name="userId" >
</form>

<div class="list-inner-container">
	<div class="list-top-menu">
	<!-- 사용자 추가 대신 회원가입 -->
		<!-- <div class="insert-container">
			<a href="member.do?action=insertForm" class="insert-btn">+ 사용자 추가</a>
		</div> -->
		<div class="searchbar-container">
			<div class="searchbar">
				<input type="text" placeholder="이름을 입력해주세요." class="searchbar-input">
				<a href="" class="searchbar-a">검색</a>
			</div>
		</div>
	</div>
	
	<div class="list">
	<div class="list-top-content">
    	<div class="writer-area">아이디</div>
        <div class="writer-area">이름</div>
        <div class="writer-area">나이</div>
        <div class="writer-area">주소</div>
        <div class="writer-area">핸드폰</div>
        <div class="writer-area">성별</div>
        <div class="title-area">취미</div>
    </div>
  	<c:forEach var="member" items="${list}">
        <div class="list-content">
            <div class="writer-area">${member.userId}</div>
            <div class="writer-area">${member.userName}</div>
            <div class="writer-area">${member.userAge}</div>
            <div class="writer-area">${member.userAddress}</div>
            <div class="writer-area">${member.userPhone}</div>
            <div class="writer-area">${member.userSex}</div>
            <div class="title-area">${member.hobbies}</div>
        </div>
    </c:forEach>

</div>
</div>

<script>

</script>      
</body>
</html>