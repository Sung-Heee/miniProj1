<header>
    <div class="header-container">

        <div class="logo-container">
            <a href="main.jsp" class="logo">logo</a>
        </div>

        <div class="menu-container">
            <a href="/" class="menu-btn">Company</a>
            <a href="board.do?action=list" class="menu-btn">Board</a>
            <a href="member.do?action=list" class="menu-btn">Member</a>
        </div>

        <div class="sign-container">
            <%-- 세션 스코프에 있는 loginVO 변수가 비어있는지 확인하여 로그인 여부를 판단합니다. --%>
            <c:choose>
                <c:when test="${empty sessionScope.loginVO}">
                    <!-- 로그인 되어 있지 않은 경우 -->
                    <a href="member.do?action=loginForm" class="underline-btn">Login</a>
                    <a href="member.do?action=insertForm" class="square-btn">Sign Up</a>
                </c:when>
                <c:otherwise>
                    <!-- 로그인 되어 있는 경우 -->
                    <a href="member.do?action=logout" class="underline-btn">Logout</a>
                    <a href="member.do?action=mypage" class="square-btn">MyPage</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
