<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<link rel="stylesheet" type="text/css" href="resource/css/style.css">

</head>
<body>

<!-- 헤더 --> 
<%@ include file="../header/header.jsp" %>

<div class="mypage-container">
	<div class="mypage-inner-container">
		<div class="mypage-top-container">
			<div class="mypage-userid">
			${loginVO.userId} <span>&nbsp;님</span>   
			</div>
			
		</div>
		<div class="mypage-content-container">
			<div class="mypage-content">
				<div class="mypage-area">
					<div class="mypage-title-area">아이디</div>
					<div class="mypage-content-area">${loginVO.userId}</div>
				</div>
				<div class="mypage-area">
					<div class="mypage-title-area">이름</div>
					<div class="mypage-content-area">${loginVO.userName}</div>
				</div>
			</div>
			<div class="mypage-content">
				<div class="mypage-area">
					<div class="mypage-title-area">나이</div>
					<div class="mypage-content-area">${loginVO.userAge}</div>
				</div>
				<div class="mypage-area">
					<div class="mypage-title-area">성별</div>
					<div class="mypage-content-area">${loginVO.userSex}</div>
				</div>
			</div>
			<div class="mypage-content">
				<div class="mypage-area">
					<div class="mypage-title-area">주소</div>
					<div class="mypage-content-area">${loginVO.userAddress}</div>
				</div>
				<div class="mypage-area">
					<div class="mypage-title-area">핸드폰 번호</div>
					<div class="mypage-content-area">${loginVO.userPhone}</div>
				</div>
			</div>
			<div class="mypage-content">
			    <div class="mypage-area">
			        <div class="mypage-title-area">취미</div>
			        <div class="mypage-content-area">${loginVO.hobbies}</div>
			    </div>
			</div>
		</div>
		<div class="mypage-btn-container">
			<div class="mypage-btn-div">
				<a href="member.do?action=updateForm&memberId=${loginVO.memberId}" class="mypage-modify-btn">수정</a>
				<a href="javascript:jsWithdraw()" class="mypage-withdraw-btn">탈퇴</a>
			</div>
		</div>
	</div>
</div>

<form id = "mypageForm" name="mypageForm" method = "post" action="member.do">
	<input type="hidden" id="action" name="action" value="">
	<input type="hidden" id="memberId" name="memberId" value="${loginVO.memberId}">
</form>

<script type="text/javascript">

function jsWithdraw() {
	if (confirm("탈퇴하시겠습니까?")) {
		action.value = "withdraw";
		myFetch("member.do", "mypageForm", json => {
			if (json.status == 0) {
				alert(json.statusMessage);
				location = "main.jsp";
			} else {
				alert(json.statusMessage);
			}
		});
	}
}
</script>

</body>
</html>