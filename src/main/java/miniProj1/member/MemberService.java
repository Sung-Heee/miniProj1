package miniProj1.member;

import java.sql.SQLException;
import java.util.List;

public class MemberService {

	MemberDAO memberDAO = new MemberDAO();
	
	public List<MemberVO> list(MemberVO memberVO) throws SQLException {
		return memberDAO.list(memberVO);
	}

	public MemberVO detail(MemberVO memberVO) throws SQLException {
		return memberDAO.detail(memberVO);
	}

	public int insert(MemberVO memberVO) throws SQLException {
		return memberDAO.insert(memberVO);
	}

	public int withdraw(MemberVO memberVO) throws SQLException {
		return memberDAO.withdraw(memberVO);
	}

	public int update(MemberVO memberVO) throws SQLException {
	    return memberDAO.update(memberVO);
	}

	public List<HobbyVO> getHobby() throws SQLException {
	    return memberDAO.getHobby();
	}

	public int delete(MemberVO memberVO) throws SQLException {
		return memberDAO.withdraw(memberVO);
	}

}
