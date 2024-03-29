package miniProj1.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class MemberDAO {
	private static Connection conn = null;
	
	// 사용자 리스트 
	private static PreparedStatement memberListPstmt = null;
	// 사용자 세부정보
	private static PreparedStatement memberDetailPstmt = null;
	// 회원가입
	private static PreparedStatement memberInsertPstmt = null;
	// 취미
	private static PreparedStatement memberHobbyPstmt = null;
	// 탈퇴  
    private static PreparedStatement memberWithdraw = null;
	
	    
	static {
    	try {
    		// JDBC 드라이버 로딩
    		Class.forName("org.mariadb.jdbc.Driver");
    		// DB 연결 
            conn = DriverManager.getConnection(
                       "jdbc:mariadb://localhost:3306/miniProj1-DB",
                       "root", //계정이름
                       "0220" //계정비밀번호
               );
            
            System.out.println("DB 연결 성공!");
            conn.setAutoCommit(false);
            
            memberListPstmt = conn.prepareStatement("SELECT M.member_id, M.user_id, M.user_password, M.user_name, M.user_age, M.user_address, M.user_phone, M.user_sex, GROUP_CONCAT(H.hobby_name) AS hobbies FROM TB_MEMBER M LEFT JOIN TB_MEMBER_HOBBY MH ON M.member_id = MH.member_id LEFT JOIN TB_HOBBY H ON MH.hobby_id = H.hobby_id WHERE M.user_id <> 'admin' GROUP BY M.member_id");
            memberDetailPstmt = conn.prepareStatement("SELECT M.member_id, M.user_id, M.user_password, M.user_name, M.user_age, M.user_address, M.user_phone, M.user_sex, GROUP_CONCAT(H.hobby_name) AS hobbies FROM TB_MEMBER M LEFT JOIN TB_MEMBER_HOBBY MH ON M.member_id = MH.member_id LEFT JOIN TB_HOBBY H ON MH.hobby_id = H.hobby_id WHERE user_id = ? GROUP BY M.member_id");
            memberInsertPstmt = conn.prepareStatement("INSERT INTO tb_member (user_id, user_password, user_name, user_age, user_address, user_phone, user_sex) VALUES (?, ?, ?, ?, ?, ?, ?)");
            memberHobbyPstmt =  conn.prepareStatement("INSERT INTO tb_member_hobby (member_id, hobby_id) VALUES (?, (SELECT hobby_id FROM tb_hobby WHERE hobby_name = ?))");
            memberWithdraw = conn.prepareStatement("DELETE FROM tb_member WHERE member_id = ?");
            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public List<MemberVO> list(MemberVO memberVO) throws SQLException {
		List<MemberVO> list = new ArrayList<>();
		
		ResultSet rs = null;
		
		// 검색
		
		rs = memberListPstmt.executeQuery();
		
		 while (rs.next()) {
	            String memberId = rs.getString("member_id");
	            String userId = rs.getString("user_id");
	            String userPassword = rs.getString("user_password");
	            String userName = rs.getString("user_name");
	            int userAge = rs.getInt("user_age");
	            String userAddress = rs.getString("user_address");
	            String userPhone = rs.getString("user_phone");
	            String userSex = rs.getString("user_sex");
	            String hobbyName = rs.getString("hobbies"); 
	            
	            List<String> hobbies = new ArrayList<>();

	            if (hobbyName != null && !hobbyName.isEmpty()) {
	                hobbies = Arrays.asList(hobbyName.split(","));
	            }
	            
	            MemberVO member = new MemberVO(memberId, userId, userPassword, userName, userAge, userAddress, userPhone, userSex, hobbies);
	            list.add(member);
	        }
		
		rs.close();
		conn.commit();
	    return list;
	}

	public MemberVO detail(MemberVO memberVO) throws SQLException {
		MemberVO member = null;
		
		memberDetailPstmt.setString(1, memberVO.getUserId());
		
		ResultSet rs = memberDetailPstmt.executeQuery();
		
		if (rs.next()) {
			String memberId = rs.getString("member_id");
            String userId = rs.getString("user_id");
            String userPassword = rs.getString("user_password");
            String userName = rs.getString("user_name");
            int userAge = rs.getInt("user_age");
            String userAddress = rs.getString("user_address");
            String userPhone = rs.getString("user_phone");
            String userSex = rs.getString("user_sex");
            String hobbyName = rs.getString("hobbies"); 
            
            List<String> hobbies = Arrays.asList(hobbyName.split(",")); 
            
            member = new MemberVO(memberId, userId, userPassword, userName, userAge, userAddress, userPhone, userSex, hobbies);
		}
		
		rs.close();
		conn.commit();
		return member;
	}

	public int insert(MemberVO memberVO) throws SQLException {
	    int updated = 0;

	    memberInsertPstmt.setString(1, memberVO.getUserId());
	    memberInsertPstmt.setString(2, memberVO.getUserPassword());
	    memberInsertPstmt.setString(3, memberVO.getUserName());
	    memberInsertPstmt.setInt(4, memberVO.getUserAge());
	    memberInsertPstmt.setString(5, memberVO.getUserAddress());
	    memberInsertPstmt.setString(6, memberVO.getUserPhone());
	    memberInsertPstmt.setString(7, memberVO.getUserSex());

	    updated = memberInsertPstmt.executeUpdate();

	    if (updated == 1) {
	        // 마지막으로 삽입된 AUTO_INCREMENT 값 조회
	        ResultSet rs = memberInsertPstmt.executeQuery("SELECT LAST_INSERT_ID()");
	        if (rs.next()) {
	            String memberId = rs.getString(1); // 첫 번째 컬럼인 memberId 가져오기
	            memberVO.setMemberId(memberId); // 가져온 memberId를 MemberVO에 설정
	        } else {
	            // memberId를 가져오지 못한 경우 예외 처리
	            throw new SQLException("Failed to get last inserted memberId.");
	        }

	        List<String> hobbies = memberVO.getHobbies();
	        System.out.println("hobbies :" + hobbies);

	        for (String hobby : hobbies) {
	            System.out.println("hobby :" + hobby);
	            System.out.println("memberId : " + memberVO.getMemberId());
	            memberHobbyPstmt.setString(1, memberVO.getMemberId()); // 수정된 부분
	            memberHobbyPstmt.setString(2, hobby);
	            memberHobbyPstmt.executeUpdate();
	        }

	        conn.commit();
	        return 1;
	    } else {
	        return 0;
	    }

	}

	public int withdraw(MemberVO memberVO) throws SQLException {
		int updated = 0;
		
		memberWithdraw.setString(1, memberVO.getMemberId());
		
		updated = memberWithdraw.executeUpdate();
		
		conn.commit();
		return updated;
	}

}
