package miniProj1.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;

public class BoardService {
	
	BoardDAO boardDAO = new BoardDAO();
	
	public List<BoardVO> list(BoardVO board) throws ServletException, IOException {
		return boardDAO.list(board);
	}

}
