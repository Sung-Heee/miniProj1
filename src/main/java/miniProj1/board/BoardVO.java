package miniProj1.board;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardVO {
	public BoardVO (String bno, String btitle, String bcontent) {
		this(bno, btitle, bcontent, "", "");
	}

	public BoardVO(String bno, String btitle, String bcontent, String bwriter, String bdate) {
		this(bno, btitle, bcontent, bwriter, bdate, "", "");
	}
	
	private String bno;
	private String btitle;
	private String bcontent;
	private String bwriter;
	private String bdate;
	
	//실행 명령 필드 
	private String action;

	//검색키
	private String searchKey;
	
	public boolean isEmptySearchKey() {
		return searchKey == null || searchKey.length() == 0; 
	}
	
}
