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
	private static PreparedStatement memberListPstmt = null;
	private static PreparedStatement memberDetailPstmt = null;
	    
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
            
            memberListPstmt = conn.prepareStatement("SELECT M.member_id, M.user_id, M.user_password, M.user_name, M.user_age, M.user_address, M.user_phone, M.user_sex, GROUP_CONCAT(H.hobby_name) AS hobbies FROM TB_MEMBER M LEFT JOIN TB_MEMBER_HOBBY MH ON M.member_id = MH.member_id LEFT JOIN TB_HOBBY H ON MH.hobby_id = H.hobby_id GROUP BY M.member_id");
            memberDetailPstmt = conn.prepareStatement("SELECT M.member_id, M.user_id, M.user_password, M.user_name, M.user_age, M.user_address, M.user_phone, M.user_sex, GROUP_CONCAT(H.hobby_name) AS hobbies FROM TB_MEMBER M LEFT JOIN TB_MEMBER_HOBBY MH ON M.member_id = MH.member_id LEFT JOIN TB_HOBBY H ON MH.hobby_id = H.hobby_id WHERE user_id = ? GROUP BY M.member_id");
            
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
	            
	            List<String> hobbies = Arrays.asList(hobbyName.split(",")); 
	            
	            MemberVO member = new MemberVO(memberId, userId, userPassword, userName, userAge, userAddress, userPhone, userSex, hobbies);
	            list.add(member);
	        }
		
		rs.close();
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
		return member;
	}

}
