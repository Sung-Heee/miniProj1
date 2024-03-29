<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board detail</title>
<link rel="stylesheet" type="text/css" href="resource/css/style.css">
</head>
<body>

<!-- 헤더 --> 
<%@ include file="../header/header.jsp" %>

<!-- 내용 -->
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
		
		<div class="content">
		${board.btitle}
		</div>
    </div>
     
    <div class="detail-content">
    	<div class="title">
   		내용
   		</div> 
   		
		<div class="content">
   		${board.bcontent}
   		</div>
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
    	<a href="board.do?action=updateForm&bno=${board.bno}" class="modify-btn">수정</a>
    	<a href="javascript:jsDelete()" class="delete-btn">삭제</a>
    </div>
</div>
</div>
</div>

<form id="detailForm" name="detailForm" method="post" action="board.do">
    <input type="hidden" id="action" name="action" value="">
    <input type="hidden" name="bno" value="${board.bno}">
</form>

<!-- javascript -->

<script type="text/javascript">

/* 삭제 */
function jsDelete() {
	if (confirm("삭제하시겠습니까?")) {
		action.value = "delete";
		myFetch("board.do", "detailForm", json => {
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