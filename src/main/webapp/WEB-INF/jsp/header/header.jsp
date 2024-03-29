<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<header>
    <div class="header-container">

        <div class="logo-container">
            <a href="main.jsp" class="logo">logo</a>
        </div>

        <div class="menu-container">
            <%-- 만약 로그인한 아이디가 "admin"이라면 --%>
            <c:if test="${not empty sessionScope.loginVO and sessionScope.loginVO.userId eq 'admin'}">
                <a href="/" class="menu-btn">Company</a>
                <a href="board.do?action=list" class="menu-btn">Board</a>
                <a href="member.do?action=list" class="menu-btn">Member</a>
            </c:if>
            <%-- 관리자가 아닌 경우에는 "Company"와 "Board"만 표시 --%>
            <c:if test="${empty sessionScope.loginVO or sessionScope.loginVO.userId ne 'admin'}">
                <a href="/" class="menu-btn">Company</a>
                <a href="board.do?action=list" class="menu-btn">Board</a>
            </c:if>
        </div>

        <div class="sign-container">
            <%-- 세션 스코프에 있는 loginVO 변수가 비어있는지 확인하여 로그인 여부를 판단. --%>
            <c:choose>
                <c:when test="${empty sessionScope.loginVO}">
                    <!-- 로그인 되어 있지 않은 경우 -->
                    <a href="member.do?action=loginForm" class="underline-btn">Login</a>
                    <a href="member.do?action=insertForm" class="square-btn">Sign Up</a>
                </c:when>
                <c:otherwise>
                    <!-- 로그인 되어 있는 경우 -->
                    <span>${loginVO.userId}님</span>
                    <%-- 만약 로그인한 아이디가 "admin"이라면 로그아웃 링크를 표시합니다. --%>
                    <c:if test="${loginVO.userId eq 'admin'}">
                        <a href="javascript:jsLogout()" class="square-btn">Logout</a>
                    </c:if>
                    <c:if test="${loginVO.userId ne 'admin'}">
                        <a href="javascript:jsLogout()" class="underline-btn">Logout</a>
                        <a href="member.do?action=mypage&memberId=${loginVO.memberId}" class="square-btn">MyPage</a>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<script type="text/javascript" src="resource/js/common.js"></script>
<script type="text/javascript">

// 로그아웃 
function jsLogout() {
    if (confirm("로그아웃 하시겠습니까?")) {
        myFetch("member.do", {action:"logout"}, json => {
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
