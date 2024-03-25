package miniProj1.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

public class BoardController {

	BoardService boardService = new BoardService();
	
	public Object list(HttpServletRequest request, BoardVO boardVO) throws ServletException, IOException {
		System.out.println("[게시물 목록]");
		
		List<BoardVO> list = boardService.list(boardVO);
		
		request.setAttribute("list", list);
		
		return "list";
	}

}
