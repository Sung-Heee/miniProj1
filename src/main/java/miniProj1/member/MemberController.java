package miniProj1.member;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
			
			// 만약 사용자가 입력한 아이디가 admin 이면 관리자로 로그인 되고 관리자 페이지로 이동 
			if (memberVO.getUserId().equals("admin")) {
				return "redirect:member.do?action=list";
			}
		} else {
			return "redirect:member.do?action=loginForm&err=invalidUserId";
		}
		return "redirect:board.do?action=list";
	}

	public Object logout(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();
		session.removeAttribute("loginVO"); // 로그인 정보 삭제
		session.invalidate(); // 세션에 저장된 모든 자료 삭제 
		map.put("status", 0);
		map.put("statusMessage", "로그아웃 되었습니다.");
		
		return map;
	}

	public Object mypage(HttpServletRequest request, MemberVO memberVO) throws SQLException {
		List<HobbyVO> hobbyList = memberService.getHobby();
	    request.setAttribute("hobbyList", hobbyList);
		return "mypage";
	}

	public Object insertForm(HttpServletRequest request, MemberVO memberVO) throws SQLException {
		List<HobbyVO> hobbyList = memberService.getHobby();
	    request.setAttribute("hobbyList", hobbyList);
		return "insertForm";
	}

	public Object insert(HttpServletRequest request, MemberVO memberVO) throws SQLException {
		Map<String, Object> map = new HashMap<>();
		
		if (memberVO.getUserId() == null || memberVO.getUserId().length() == 0) {
			map.put("status", -1);
			map.put("statusMessage", "Null 이거나 길이가 0인 아이디는 사용할 수 없습니다.");
		} else {
			int updated = memberService.insert(memberVO);
			
			if (updated == 1) {
				map.put("status", 0);
				map.put("statusMessage", "회원가입이 완료되었습니다.");
			} else {
				map.put("status", -1);
				map.put("statusMessage", "회원가입 실패! 다시 시도해주세요.");
			}
		}
		
		return map;
	}

	public Object withdraw(HttpServletRequest request, MemberVO memberVO) throws SQLException {
		int updated = memberService.withdraw(memberVO);
		
		Map<String, Object> map = new HashMap<>();
		
		if (updated == 1) {
			HttpSession session = request.getSession();
			session.removeAttribute("loginVO"); // 로그인 정보 삭제
			session.invalidate(); // 세션에 저장된 모든 자료 삭제 
			map.put("status", 0);
			map.put("statusMessage", "탈퇴 성공!");
		} else {
			map.put("status", -1);
			map.put("statusMessage", "탈퇴 실패! 다시 시도해주세요.");
		}
		
		return map;
	}

	public Object updateForm(HttpServletRequest request, MemberVO memberVO) throws SQLException {
		List<HobbyVO> hobbyList = memberService.getHobby();
	    request.setAttribute("hobbyList", hobbyList);
		
		return "updateForm";
	}

	public Object update(HttpServletRequest request, MemberVO memberVO) throws SQLException {
		
		int updated = memberService.update(memberVO);
		
		Map<String, Object> map = new HashMap<>();
		
		if (updated == 1) {
			// 업데이트 완료하고 세션 다시 기록 
			HttpSession session = request.getSession();
			session.setAttribute("loginVO", memberVO);

			map.put("status", 0);
			map.put("statusMessage", "수정되었습니다.");
		} else {
			map.put("status", -1);
			map.put("statusMessage", "수정 실패! 다시 시도해주세요.");
		}
		
		return map;
	}

	public Object existUserId(HttpServletRequest request, MemberVO memberVO) throws SQLException {
		MemberVO existUser = memberService.detail(memberVO);
		
		Map<String, Object> map = new HashMap<>();

		if (existUser == null) {
			map.put("existUser", false);
			map.put("statusMessage", "사용 가능한 아이디입니다.");
		} else {
			map.put("existUser", true);
			map.put("statusMessage", "이미 사용중인 아이디입니다.");
		}
		
		return map;
	}

	public Object delete(HttpServletRequest request, MemberVO memberVO) throws SQLException {
		int updated = memberService.delete(memberVO);
		
		Map<String, Object> map = new HashMap<>();
		
		if (updated == 1) {
			map.put("status", 0);
			map.put("statusMessage", "사용자가 삭제되었습니다.");
		} else {
			map.put("status", -1);
			map.put("statusMessage", "사용자 삭제 실패하였습니다.");
		}
		
		return map;
	}

}