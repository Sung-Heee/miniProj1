package miniProj1.board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    private static Connection conn = null;
    
    // list
    private static PreparedStatement boardListPstmt = null;
    // detail
    private static PreparedStatement boardDetailPstmt = null;
    // delete 
    private static PreparedStatement boardDeletePstmt = null;
    // insert 
    private static PreparedStatement boardInsertPstmt = null;

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
            
            boardListPstmt = conn.prepareStatement("SELECT * FROM TB_BOARD ORDER BY BOARD_ID");
            boardDetailPstmt = conn.prepareStatement("SELECT * FROM TB_BOARD WHERE BOARD_ID = ?");
            boardDeletePstmt = conn.prepareStatement("DELETE FROM TB_BOARD WHERE BOARD_ID = ?");
            boardInsertPstmt = conn.prepareStatement("INSERT INTO TB_BOARD (BOARD_TITLE, BOARD_CONTENT, BOARD_WRITER) VALUES(?, ?, ?)");
    	} catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<BoardVO> list(BoardVO boardVO) throws SQLException {
    	List<BoardVO> list = new ArrayList<>();
    	ResultSet rs = null;
    	rs = boardListPstmt.executeQuery();
    	// 검색
    		
    	while (rs.next()) {
    		BoardVO board = new BoardVO(rs.getString("BOARD_ID")
   					, rs.getString("BOARD_TITLE")
   					, rs.getString("BOARD_CONTENT")
    				, rs.getString("BOARD_WRITER")
    				, rs.getString("BOARD_DATE"));

   			list.add(board);
 		} 
    	rs.close();
    	conn.commit();
    	
    	return list;
    }

	public BoardVO detail(BoardVO boardVO) throws SQLException {
		BoardVO board = null;
		
		boardDetailPstmt.setString(1, boardVO.getBno());
		
		ResultSet rs = boardDetailPstmt.executeQuery();
		
		if (rs.next()) {
			board = new BoardVO(rs.getString("BOARD_ID")
   					, rs.getString("BOARD_TITLE")
   					, rs.getString("BOARD_CONTENT")
    				, rs.getString("BOARD_WRITER")
    				, rs.getString("BOARD_DATE"));
		}
		rs.close();
		conn.commit();

		return board;
	}

	public int delete(BoardVO boardVO) throws SQLException {
		int updated = 0;
		
		boardDeletePstmt.setString(1, boardVO.getBno());
		
		updated = boardDeletePstmt.executeUpdate();
		
		conn.commit();
		return updated;
	}

	public int insert(BoardVO boardVO) throws SQLException {
		int updated = 0;
		
		boardInsertPstmt.setString(1, boardVO.getBtitle());
		boardInsertPstmt.setString(2, boardVO.getBcontent());
		boardInsertPstmt.setString(3, boardVO.getBwriter());
		
		updated = boardInsertPstmt.executeUpdate();
		
		conn.commit();
		return updated;
	}

}
