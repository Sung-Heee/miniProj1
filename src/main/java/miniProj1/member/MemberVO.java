package miniProj1.member;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {
	private String memberId;
	private String userId;
	private String userPassword;
	private String userName;
	private int userAge;
	private String userAddress;
	private String userPhone;
	private String userSex; 
	private List<String> hobbies; 
	
	private String userPasswordCheck;
	private String err;
	
	//실행 명령 필드 
	private String action;

	//검색키
	private String searchKey;
	
	public MemberVO(String memberId, String userId, String userPassword, String userName, int userAge, String userAddress, String userPhone, String userSex, List<String> hobbies) {
	    this(memberId, userId, userPassword, userName, userAge, userAddress, userPhone, userSex, hobbies, "", "", "", "");
	}
	// memberId 설정
	public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

	// 비밀 번호 확인 
	public boolean isEqualPassword(MemberVO memberVO) {
		return memberVO != null && userPassword.equals(memberVO.getUserPassword());
	}

	
	
	
}
