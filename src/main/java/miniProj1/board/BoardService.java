package miniProj1.board;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;

public class BoardService {
	
	BoardDAO boardDAO = new BoardDAO();
	
	public List<BoardVO> list(BoardVO boardVO) throws ServletException, IOException, SQLException {
		return boardDAO.list(boardVO);
	}

	public BoardVO detail(BoardVO boardVO) throws SQLException {
		return boardDAO.detail(boardVO);
	}

}
