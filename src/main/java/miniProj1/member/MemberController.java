package miniProj1.member;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class MemberController {
	
	MemberService memberService = new MemberService();

	public Object list(HttpServletRequest request, MemberVO memberVO) throws SQLException {
		System.out.println("[게시물 목록]");
		
		List<MemberVO> list = memberService.list(memberVO);
		
		request.setAttribute("list", list);
		
		return "list";
	}

	public Object loginForm(HttpServletRequest request) {
		return "loginForm";
	}

	public Object login(HttpServletRequest request, MemberVO memberVO) throws SQLException {
		// 로그인 하기 위해 로그인하려는 사용자의 정보를 가져온다.
		MemberVO loginVO = memberService.detail(memberVO);
		
		// 가져온 정보와 사용자가 입력한 비밀번호가 같은지 확인
		if (memberVO.isEqualPassword(loginVO)) {
			// 로그인 사용자의 정보를 세션에 기록 
			HttpSession session = request.getSession();
			session.setAttribute("loginVO", loginVO);
			
			System.out.println("로그인 성공!");
		} else {
			return "redirect:member.do?action=loginForm&err=invalidUserId";
		}
		return "redirect:board.do?action=list";
	}

}
