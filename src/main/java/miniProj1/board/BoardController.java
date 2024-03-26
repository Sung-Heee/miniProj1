package miniProj1.board;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

public class BoardController {

	BoardService boardService = new BoardService();
	
	public Object list(HttpServletRequest request, BoardVO boardVO) throws ServletException, IOException, SQLException {
		System.out.println("[게시물 목록]");
		
		List<BoardVO> list = boardService.list(boardVO);
		
		request.setAttribute("list", list);
		
		return "list";
	}

	public Object detail(HttpServletRequest request, BoardVO boardVO) throws ServletException, IOException, SQLException {
		System.out.println("[게시물 상세보기]");
		
		request.setAttribute("board", boardService.detail(boardVO));
		
		return "detail";
	}

}
