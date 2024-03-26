package miniProj1.board;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public Object delete(HttpServletRequest request, BoardVO boardVO) throws SQLException {
		System.out.println("[게시물 삭제]");
		
		int updated = boardService.delete(boardVO);
		
		Map<String, Object> map = new HashMap<>();
		if (updated == 1) {
			map.put("status", 0); // 성공
			map.put("statusMessage", "게시물이 삭제되었습니다.");
		} else {
			map.put("status", -1);
			map.put("statusMessage", "게시물 삭제 실패하였습니다.");
		}
		
		return map;
	}

	public Object insert(HttpServletRequest request, BoardVO boardVO) throws SQLException {
		System.out.println("[게시물 등록]");
		
		int updated = boardService.insert(boardVO);
		
		Map<String, Object> map = new HashMap<>();
		if (updated == 1) {
			map.put("status", 0); // 성공
			map.put("statusMessage", "게시물이 등록되었습니다.");
		} else {
			map.put("status", -1);
			map.put("statusMessage", "게시물 등록 실패하였습니다.");
		}
	
		return map;
	}

	public Object insertForm(HttpServletRequest request) {
		System.out.println("[게시물 등록 화면]");
		
		return "insertForm";
	}

	public Object updateForm(HttpServletRequest request, BoardVO boardVO) throws SQLException {
		System.out.println("[게시물 수정 화면]");
		
		request.setAttribute("board", boardService.updateForm(boardVO));
		
		return "updateForm";
	}

	public Object update(HttpServletRequest request, BoardVO boardVO) throws SQLException {
		System.out.println("[게시물 수정]");
		
		int updated = boardService.update(boardVO);
		
		Map<String, Object> map = new HashMap<>();
		if (updated == 1) {
			map.put("status", 0); // 성공
			map.put("statusMessage", "게시물이 수정되었습니다.");
		} else {
			map.put("status", -1);
			map.put("statusMessage", "게시물 수정 실패하였습니다.");
		}
	
		return map;
	}

}
