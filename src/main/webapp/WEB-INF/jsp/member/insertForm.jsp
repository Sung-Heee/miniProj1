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
	
	<label>아이디 : </label>
	<input type="text" id="userId" name="userId"> 
	<input type="button" id="duplicateId" value="중복확인"><br/>
	
	<label>비밀번호 : </label>
	<input type="password" id="userPassword" name="userPassword"><br/>
	
	<label>비밀번호 확인 : </label>
	<input type="password" id="userPasswordCheck" name="userPasswordCheck"><br/>
	
	<label>이름 : </label>
	<input type="text" id="userName" name="userName"><br/>
	
	<label>나이 : </label>
	<input type="number" id="userAge" name="userAge"><br/>
	
	<label>주소 : </label>
	<input type="text" id="userAddress" name="userAddress"><br/>
	
	<label>핸드폰 번호 : </label>
	<input type="text" id="userPhone" name="userPhone"><br/>
	
	<label>성별 : </label>
	<input type="radio" id="female" name="userSex" value="Female"> <label for="female">여자</label>
	<input type="radio" id="male" name="userSex" value="Male"> <label for="male">남자</label><br/>
	
	
	<label>취미 : </label>
	<input type="checkbox" id="hobby1" name="hobbies" value="자전거"> 
	<label for="hobby1">자전거</label>
	<input type="checkbox" id="hobby2" name="hobbies" value="영화"> 
	<label for="hobby2">영화</label>
	<input type="checkbox" id="hobby3" name="hobbies" value="음악"> 
	<label for="hobby3">음악</label>
	<input type="checkbox" id="hobby4" name="hobbies" value="수영"> 
	<label for="hobby4">수영</label>
	<br/><br/>
 	
 	<input class="btn" type="submit" value="등록" >
	<a class="btn" href="member.do?action=list">취소</a>
</form>

<script type="text/javascript">

const insertForm = document.getElementById("insertForm");
const userPassword = document.getElementById("userPassword");
const userPasswordCheck = document.getElementById("userPasswordCheck");

insertForm.addEventListener("submit", e => {
	// e라고 써주면 event 객체
	// 서버에 form data를 전송하지 않는다. 
    e.preventDefault();
	
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
			location = "member.do?action=list";
		} else {
			alert(json.statusMessage);
		}
	});
	 
});
</script>

</div>
</body>
</html>