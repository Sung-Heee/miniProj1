<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member update</title>
<link rel="stylesheet" type="text/css" href="resource/css/style.css">

</head>
<body>

<!-- 헤더 --> 
<%@ include file="../header/header.jsp" %>

<form id = "mypageUpdateForm" name="mypageUpdateForm" method = "post" action="member.do">
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
					<input type="hidden" id="userId" name="userId" value="${loginVO.userId}">
				</div>
				<div class="mypage-area">
					<div class="mypage-title-area">이름</div>
					<div class="mypage-content-area"><input class="mypage-input" type="text" id="userName" name="userName" value="${loginVO.userName}"></div>
				</div>
			</div>
			<div class="mypage-content">
				<div class="mypage-area">
					<div class="mypage-title-area">비밀번호</div>
					<div class="mypage-content-area"><input class="mypage-input" type="password" id="userPassword" name="userPassword" required></div>
				</div>
				<div class="mypage-area">
					<div class="mypage-title-area">비밀번호 확인</div>
					<div class="mypage-content-area"><input class="mypage-input" type="password" id="userPasswordCheck" name="userPasswordCheck" required></div>
				</div>
			</div>
			<div class="mypage-content">
				<div class="mypage-area">
					<div class="mypage-title-area">나이</div>
					<div class="mypage-content-area"><input class="mypage-input" type="number" id="userAge" name="userAge" value="${loginVO.userAge}"></div>
				</div>
				<div class="mypage-area">
						<div class="mypage-title-area">성별</div>
				        <div class="mypage-content-area">
				            <input type="radio" id="female" name="userSex" value="여자" class="input-radio" <c:if test="${loginVO.userSex eq '여자'}">checked</c:if>> <label for="female">여자</label>
				            <input type="radio" id="male" name="userSex" value="남자" class="input-radio" <c:if test="${loginVO.userSex eq '남자'}">checked</c:if>> <label for="male">남자</label>
				        </div>
				</div>
			</div>
			<div class="mypage-content">
				<div class="mypage-area">
					<div class="mypage-title-area">주소</div>
					<div class="mypage-content-area"><input class="mypage-input" type="text" id="userAddress" name="userAddress" value="${loginVO.userAddress}"></div>
				</div>
				<div class="mypage-area">
					<div class="mypage-title-area">핸드폰 번호</div>
					<div class="mypage-content-area"><input class="mypage-input" type="text" id="userPhone" name="userPhone" value="${loginVO.userPhone}"></div>
				</div>
			</div>
			<div class="mypage-content">
			    <div class="mypage-area">
			        <div class="mypage-title-area">취미</div>
			        <div class="mypage-content-area">
			        	 <c:forEach var="hobby" items="${hobbyList}">
			        	 <div class="input-checkbox">
			                <input type="checkbox" id="hobby${hobby.hobbyId}" name="hobbies" value="${hobby.hobbyName}" <c:if test="${loginVO.hobbies.contains(hobby.hobbyName)}">checked</c:if>> 
			                <label for="hobby${hobby.hobbyId}">${hobby.hobbyName}</label>
			             </div>
			            </c:forEach>		        				     
                    </div>
			    </div>
			</div>
		</div>
		<div class="mypage-btn-container">
			<div class="mypage-btn-div">
				<input type="submit" class="mypage-modify-btn" value="수정하기">
			</div>
		</div>
	</div>
</div>


	<input type="hidden" id="action" name="action" value="">
	<input type="hidden" id="memberId" name="memberId" value="${loginVO.memberId}">
</form>

<script type="text/javascript">

const userPassword = document.getElementById("userPassword");
const userPasswordCheck = document.getElementById("userPasswordCheck");

document.getElementById("mypageUpdateForm").addEventListener("submit", function(event) {
    event.preventDefault();
    
    if (userPassword.value != userPasswordCheck.value) {
   		alert("비밀번호가 일치하지 않습니다.");
		// 비밀번호가 잘못되면 값 비워주고 focus()
		userPasswordCheck.value = "";
		userPasswordCheck.focus()
		return false;
	}
    
    jsUpdate(); // 폼 제출 대신 jsUpdate() 함수 호출
});

function jsUpdate() {	
	if (confirm("회원 정보를 수정하시겠습니까?")) {
		action.value = "update";
		myFetch("member.do", "mypageUpdateForm", json => {
			if (json.status == 0) {
				alert(json.statusMessage);
				location = "member.do?action=mypage&memberId=" + memberId.value;
			} else {
				alert(json.statusMessage);
			}
		});
	}
}
</script>

</body>
</html>