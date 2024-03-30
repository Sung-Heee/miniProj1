<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board list</title>
<link rel="stylesheet" type="text/css" href="resource/css/style.css">
</head>
<body>

<!-- 헤더 --> 
<%@ include file="../header/header.jsp" %>

<form id="searchForm" action="board.do" method="post" >
<input type="hidden" id="action" name="action" value="list">

<div class="list-container">
<div class="list-inner-container">

	
	<div class="list-top-menu">
		<c:choose>
		
		<c:when test="${empty sessionScope.loginVO}">	
		
		<div class="searchbar-container">
			<div class="searchbar">
				<input type="text" placeholder="제목을 입력해주세요." id="searchKey" name="searchKey" value="${param.searchKey}" class="searchbar-input">
				<input type="submit" value="검색" class="searchbar-a">	
			</div>
		</div>
		
		</c:when>
		
		<c:otherwise>
		 
			<c:if test="${loginVO.userId eq 'admin'}">
				<div class="searchbar-container">
					<div class="searchbar">
						<input type="text" placeholder="제목을 입력해주세요." id="searchKey" name="searchKey" value="${param.searchKey}" class="searchbar-input">
						<input type="submit" value="검색" class="searchbar-a">
					</div>
				</div>
			</c:if>
			<c:if test="${loginVO.userId ne 'admin'}">
				<div class="searchbar-container">
					<div class="searchbar">
						<input type="text" placeholder="제목을 입력해주세요." id="searchKey" name="searchKey" value="${param.searchKey}" class="searchbar-input">
						<input type="submit" value="검색" class="searchbar-a">
					</div>
				</div>
				<div class="insert-container">
					<a href="board.do?action=insertForm" class="insert-btn">+ 글 작성하기</a>
				</div>
			</c:if>
		</c:otherwise>
		</c:choose>
		
	</div>
	
	<div class="list">
	<div class="list-top-content">
    	<div class="no-area">No.</div>
        <div class="title-area">제목</div>
        <div class="writer-area">작성자</div>
        <div class="date-area">작성일자</div>
    </div>
    <c:forEach var="board" items="${list}">
	<div class="list-content">
        <div class="no-area">${board.bno}</div>
        <div class="title-area"><a href="board.do?action=detail&bno=${board.bno}" class="title-a">${board.btitle}</a></div> 
        <div class="writer-area">${board.bwriter}</div> 
        <div class="date-area">${board.bdate}</div> 
        <c:if test="${loginVO.userId eq 'admin'}">
        	<div class="admin-delete-btn"><a href="javascript:jsDelete(${board.bno})">삭제</a></div>
        </c:if>
	</div>	
    </c:forEach>

</div>
</div>
</form>
<form id="listForm" name="listForm" action="board.do" method="post">
    <input type="hidden" id="action" name="action" value="">
    <input type="hidden" id="bno" name="bno" value="">
</form>


<script type="text/javascript">
function jsView(bno) {
	//인자의 값을 설정한다 
	bno.value = bno;
	
	//양식을 통해서 서버의 URL로 값을 전달한다
	listForm.submit();
} 

function jsDelete(bno) {
	if(confirm("게시물을 삭제하시겠습니까?")) {
		action.value = "delete";
		document.getElementById("bno").value = bno;
		myFetch("board.do", "listForm", json => {
			if (json.status == 0) {
				alert(json.statusMessage);
				location="board.do?action=list";
			} else {
				alert(json.statusMessage);		
			}
		})
	}
}
</script>      
</body>
</html>