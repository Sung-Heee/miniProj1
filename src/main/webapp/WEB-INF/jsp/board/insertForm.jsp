<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board insertForm</title>
<link rel="stylesheet" type="text/css" href="resource/css/style.css">
</head>
<body>

<!-- 헤더 --> 
<%@ include file="../header/header.jsp" %>

<!-- 내용 --> 
<div class="insertForm-container">

<form id="insertForm" action="board.do" method="post">
	<input type="hidden" name="action" id="action" value="">
	<%-- <input type="hidden" id="bwriter" name="bwriter" value="${loginVO.username}"> --%>
	<input type="hidden" id="bwriter" name="bwriter" value="${loginVO.userName}">
	
<div class="insertForm-inner-container">
	<div class="insertForm-title-container">
		<div class="insertForm-title">Title</div>
		<input class="insertForm-title-input" type="text" id="btitle" name="btitle" placeholder="제목을 입력해주세요.">
	</div>
	<div class="insertForm-content-container">
		<div class="insertForm-content">
			<div class="insertForm-content-area">Content</div>
		</div>
		<div class="insertForm-content-input-container">
			<textarea class="insertForm-content-input" id="bcontent" name="bcontent" placeholder="내용을 입력해주세요."></textarea>
		</div>
	</div>
	<div class="insertForm-btn-container">
		<a href="javascript:jsInsert()" class="insertForm-btn">등록</a>
	</div>
</div>
</form>

</div>

<!-- javascript -->
<script type="text/javascript" src="<c:url value='resource/js/common.js'/>"></script>
<script type="text/javascript">

function jsInsert() {
	if (confirm("등록하시겠습니까?")) {
		action.value = "insert";
		myFetch("board.do", "insertForm", json => {
			if (json.status == 0) {
				// 성공
				alert(json.statusMessage);
				location = "board.do?action=list";
			} else {  
				alert(json.statusMessage);
			}
		});
	}
}
</script>

</body>
</html>