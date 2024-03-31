<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<link rel="stylesheet" type="text/css" href="resource/css/style.css">
</head>
<body>

<%@ include file="WEB-INF/jsp/header/header.jsp" %>

<div class="main-content">
    <div>
        <h1>Welcome to Our Website!</h1>
        <p>Welcome to our site, where you can share your thoughts, experiences, and stories with the world.</p>
        <p>Whether you're a seasoned writer or just starting out, our platform provides a welcoming space for all.</p>
        <p>Join our community today and start writing!</p>
        <div class="btn-container">
            <a href="board.do?action=list" class="btn">Board List</a>
        </div>
    </div>
    <img src="resource/images/main_image.png" alt="Main Image">
</div>

</body>
</html>