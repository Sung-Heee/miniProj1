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

}
