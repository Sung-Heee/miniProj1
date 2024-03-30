<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="resource/css/style.css">
</head>
<body>

<%@ include file="../header/header.jsp" %>

<div class="member-insertForm-container">
<form id="insertForm" action="member.do" method="post">
	<input type="hidden" name="action" value="insert">
	<div class="member-insertForm-inner-container">
	<div class="member-top-container">Sign Up</div>
	<div class="member-input-container">
		<div class="member-input-div">
			<div class="member-label">아이디</div>
			<div class="member-input"><input type="text" id="userId" name="userId" required></div> 
			<div class="member-duplicatedId"><input type="button" id="duplicateId" value="중복확인"></div>
		</div>
		
		<div class="member-input-div">
			<div class="member-label">비밀번호</div>
			<div class="member-input"><input type="password" id="userPassword" name="userPassword" required></div>
		</div>
		
		<div class="member-input-div">
			<div class="member-label">비밀번호 확인</div>
			<div class="member-input"><input type="password" id="userPasswordCheck" name="userPasswordCheck" required></div>
		</div>
		
		<div class="member-input-div">
			<div class="member-label">이름</div>
			<div class="member-input"><input type="text" id="userName" name="userName" required></div>
		</div>
		
		<div class="member-input-div">
			<div class="member-label">나이</div>
			<div class="member-input"><input type="number" id="userAge" name="userAge" required></div>
		</div>
		
		<div class="member-input-div">
			<div class="member-label">주소</div>
			<div class="member-input"><input type="text" id="userAddress" name="userAddress" required></div>
		</div>
		
		<div class="member-input-div">
			<div class="member-label">핸드폰</div>
			<div class="member-input"><input type="text" id="userPhone" name="userPhone" required></div>
		</div>
		
		<div class="member-input-div">
			<div class="member-label">성별</div>
			
				<input class="input-radio" type="radio" id="female" name="userSex" value="여자" required> <label for="female">여자</label>
				<input class="input-radio" type="radio" id="male" name="userSex" value="남자" required> <label for="male">남자</label>
		
		</div>
		
		<div class="member-input-div">
			<div class="member-label">취미</div>
			<c:forEach var="hobby" items="${hobbyList}">
		
				<input class="input-checkbox" type="checkbox" id="hobby${hobby.hobbyId}" name="hobbies" value="${hobby.hobbyName}"> 
				<label for="hobby${hobby.hobbyId}">${hobby.hobbyName}</label>
		
			</c:forEach>	
		</div>
 	</div>
 	<div class="member-insertForm-btn-container">
	 	<input type="submit" value="회원가입" class="member-insertForm-btn">
		<!-- <a class="btn" href="member.do?action=list">취소</a> -->
	</div>
	</div>
</form>

<script type="text/javascript">

const insertForm = document.getElementById("insertForm");
const userPassword = document.getElementById("userPassword");
const userPasswordCheck = document.getElementById("userPasswordCheck");

// 중복 체크 여부를 확인하는 
let validUserId = "";

insertForm.addEventListener("submit", e => {
	// e라고 써주면 event 객체
	// 서버에 form data를 전송하지 않는다. 
    e.preventDefault();
	
	if (validUserId == "" || userId.value != validUserId) {
		alert("아이디 중복확인 해주세요.");
		return false;
	}
	
	if (userPassword.value != userPasswordCheck.value) {
   		alert("비밀번호가 일치하지 않습니다.");
		// 비밀번호가 잘못되면 값 비워주고 focus()
		userPasswordCheck.value = "";
		userPasswordCheck.focus()
		return false;
	} 
	myFetch("member.do?action=insert", "insertForm", json => {
		if(json.status == 0) {
			//성공
			alert(json.statusMessage);
			location = "member.do?action=loginForm";
		} else {
			alert(json.statusMessage);
		}
	});
	 
});

const duplicateId = document.getElementById("duplicateId");
duplicateId.addEventListener("click", () => {
	const userId = document.getElementById("userId");
	
	// 아이디 미입력 
	if (userId.value == "") {
		alert("아이디를 입력해주세요.");
		userId.focus();
		return;
	}
	
	const param = {
		action : "existUserId",
		userId : userId.value
	}
	
	fetch("member.do", {
		method : "POST",
		body : JSON.stringify(param),
		headers : {"Content-type" : "application/json; charset=utf-8"}
	}).then(res => res.json()).then(json => {
		if (json.existUser == true) {
			alert(json.statusMessage);
			validUserId = "";
		} else {
			alert(json.statusMessage);
			validUserId = userId.value;
		}
	})
});
</script>

</div>
</body>
</html>