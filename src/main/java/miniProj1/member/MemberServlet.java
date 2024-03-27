package miniProj1.member;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import miniProj1.member.MemberVO;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Servlet implementation class MemberServlet
 */
// @WebServlet("/member.do")
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MemberController memberController = new MemberController();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			doService(request, response);
		} catch (ServletException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			doService(request, response);
		} catch (ServletException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private Map<String, Object> convertMap(Map<String, String[]> map) {
		Map<String, Object> result = new HashMap<>();

		for (var entry : map.entrySet()) {
			if (entry.getValue().length == 1) {
				//문자열 1건  
				result.put(entry.getKey(), entry.getValue()[0]);
			} else {
				//문자열 배열을 추가한다  
				result.put(entry.getKey(), entry.getValue());
			}
		}
		
		return result;
	}
	
	private void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		//한글 설정 
		request.setCharacterEncoding("utf-8");
		String contentType = request.getContentType();
				
		ObjectMapper objectMapper = new ObjectMapper();
		MemberVO memberVO = null;
		
		if (contentType == null || contentType.startsWith("application/x-www-form-urlencoded")) {
			memberVO = objectMapper.convertValue(convertMap(request.getParameterMap()), MemberVO.class);
		} else if (contentType.startsWith("application/json")) {
			memberVO = objectMapper.readValue(request.getInputStream(), MemberVO.class);
		}
		
		System.out.println("MemberVO " + memberVO);
		
		String action = memberVO.getAction();
		
		Object result = switch (action) {
		case "list" -> memberController.list(request, memberVO); 
		case "loginForm" -> memberController.loginForm(request);
		case "login" -> memberController.login(request, memberVO);
		case "logout" -> memberController.logout(request);
		case "mypage" -> memberController.mypage(request, memberVO);
		default -> "";
		};
		
		if (result instanceof Map map) {
			//json 문자열을 리턴 
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().append(objectMapper.writeValueAsString(map));
		} else if (result instanceof String url) {
			if (url.startsWith("redirect:")) {
				//리다이렉트 
				response.sendRedirect(url.substring("redirect:".length()));
			} else {
				//3. jsp 포워딩 
				//포워딩 
				RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/member/"+url+".jsp");
				rd.forward(request, response);
			}
		}
	}
}
