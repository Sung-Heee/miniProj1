package miniProj1.filter;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import miniProj1.member.MemberDAO;
import miniProj1.member.MemberVO;

/**
 * Servlet Filter implementation class LoginFilter
 */
// @WebFilter("*.do")
public class LoginFilter extends HttpFilter implements Filter {
	MemberDAO memberDAO = new MemberDAO();
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public LoginFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		if (request instanceof HttpServletRequest req) {
			HttpServletResponse res = (HttpServletResponse) response;
			HttpSession session = req.getSession();
			MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");
			String contentType = request.getContentType();
			
			String url = req.getRequestURI();
			String action = req.getParameter("action");
			
			Set<String> actionSet = new HashSet<>();
			// 회원가입이랑 로그인 페이지는 로그인하지 않아도 접근 가능하니까 
			// 아래 항목을 actionSet 에 저장 
			actionSet.add("insertForm"); // 회원가입 
			actionSet.add("insert");
			actionSet.add("loginForm"); 
			actionSet.add("login");
			
			System.out.println("url : " + url);
			
			if (!(url.equals("/miniProj1/member.do") && actionSet.contains(action))) {
				// 로그인 정보가 없다면 ?
				if (loginVO == null) {
					
					// 1. uuid 쿠키 값 찾기 
					Cookie[] cookies = req.getCookies();
					if (cookies != null) {
						for (Cookie cookie : cookies) {
							if (cookie.getName().equals("uuidCookie")) {
								// 2. uuid 값을 이용하여 로그인 정보를 얻는다. 
								MemberVO memberVO = MemberVO.builder().useruuid(cookie.getValue()).build();
								try {
									loginVO = memberDAO.getMemberVOFromUUID(memberVO);
								} catch (SQLException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
								// 3. 로그인 정보를 세션에 기록한다. 
								if (loginVO != null) {
									session.setAttribute("loginVO", loginVO);
									chain.doFilter(request, response);
								} else {
									res.sendRedirect(req.getContextPath() + "/member.do?action=loginForm");
								}
								return;
							}
						}
					}
					res.sendRedirect(req.getContextPath() + "/member.do?action=loginForm");
					return;
				}
			}
			
		}
		
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
