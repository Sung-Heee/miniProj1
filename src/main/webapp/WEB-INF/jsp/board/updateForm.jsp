<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board updateForm</title>
<link rel="stylesheet" type="text/css" href="resource/css/style.css">
</head>
<body>

<!-- 헤더 -->
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

<!-- 내용 -->
<form id="updateForm" name="updateForm" method="post" action="board.do">
<div class="detail-container">
<div class="detail-inner-container">

<div class="top-bno-container">
	<div class="top-bno">
	No.     ${board.bno}
	</div>
</div>

<div class="detail">
	<div class="detail-title">
		<div class="title">
		제목
		</div>
		
		<input type="text" id="btitle" name="btitle" class="content-input" value="${board.btitle}">
    </div>
     
    <div class="detail-content">
    	<div class="title">
   		내용
   		</div> 
   		
		<textarea id="bcontent" name="bcontent" class="content-input" value="">${board.bcontent}</textarea>
   		
    </div>
    
    <div class="detail-writer">
    	<div class="title">
	    작성자
	    </div>
	    
	    <div class="content">
		${board.bwriter}
		</div>
    </div>
    
    <div class="detail-date">
    	<div class="title">
	    작성일
	    </div>
	    
    	<div class="content">
    	${board.bdate}
    	</div>
    </div>
    
    <div class="detail-btn-container">
    	<a href="javascript:jsUpdate()" class="modify-btn">수정</a>
    </div>
</div>
</div>
</div>


    <input type="hidden" id="action" name="action" value="">
    <input type="hidden" id="bno" name="bno" value="${board.bno}">
</form>

<!-- javascript -->
<script type="text/javascript" src="<c:url value='resource/js/common.js'/>"></script>
<script type="text/javascript">

/* 삭제 */
function jsUpdate() {
	if (confirm("수정하시겠습니까?")) {
		action.value = "update";
		myFetch("board.do", "updateForm", json => {
			if (json.status == 0) {
				// 성공
				alert(json.statusMessage);
				location = "board.do?action=detail&bno=" + bno.value;
			} else {  
				alert(json.statusMessage);
			}
		});
	}
}

</script>



</body>
</html>
