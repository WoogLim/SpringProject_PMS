package kr.or.ddit.projects.history.vo;

import java.io.Serializable;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.work.vo.WorkVO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * @author 전수빈
 * @since 2021. 2. 19.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 19.      작성자명       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
@EqualsAndHashCode(of = "historyId")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class HistoryVO implements Serializable {
	@NotBlank
	@Size(max = 15)
	private String historyId; // 히스토리 아이디

	@Size(max = 200)
	private String historyTitle; // 히스토리 제목

	@Size(max = 15)
	private String historyWriter; // 히스토리 작성자

	@Size(max = 4000)
	private String historyContent; // 히스토리 내용

	@Size(max = 300)
	private String historyUri; // 히스토리 링크

	@Size(max = 10)
	private String historyDate; // 히스토리 날짜

	@Size(max = 15)
	private String proId;	// 프로젝트 식별자

	@NotBlank
	@Size(max = 20)
	private Integer boardType;	// 게시판 유형

	private String historyType;	// 일감 또는 이슈 유형
	
	private String historyState;	// 일감 또는 이슈 상태
	
	private String proTitle; // 프로젝트 제목

	private String memName; // 작성자 명

	private String memImg; // 작성자 프로필 
	
	private String proName; // 작성자 명
	
	private String boardTypeName; // 게시판 유형 이름
	
	private String searchStartDate; // 히스토리 검색 기간
	
	private String searchEndDate; // 히스토리 검색 기간 
	
	private String filterList;	// 검색 리스트 필터
	
	
	// 히스토리 기록이 생성 작업일 때
	public static final String HISTORYINSERT = "생성";
	// 히스토리 기록이 수정 작업일 때
	public static final String HISTORYUPDATE = "수정";
	// 히스토리 기록이 삭제 작업일 때
	public static final String HISTORYDELETE = "삭제"; 
	
	// 히스토리 생성
	public HistoryVO(BoardVO boardVO, String uriType){
		String historyTitle = "#%s (%s) : %s";
		this.historyTitle = String.format(historyTitle, boardVO.getBoardNo(), uriType, boardVO.getBoardTitle());
		this.historyWriter = boardVO.getBoardWriter();
		this.historyContent = boardVO.getBoardContent();
		this.boardType = boardVO.getCode();
		this.proId = boardVO.getProId();
		// 일감 일 때 또는 이슈 일 때 
		if(boardVO instanceof WorkVO) {
			WorkVO workVO = (WorkVO) boardVO;
			this.historyType = workVO.getWorkType();
			this.historyState = workVO.getWorkState();
		}else if(boardVO instanceof IssueVO) {
			IssueVO issueVO = (IssueVO) boardVO;
			this.historyType = issueVO.getIssueType();
			this.historyState = issueVO.getIssueState();
		}
		switch(boardVO.getCode()) {
		// 프로젝트 공지
		case 1:
			this.historyUri = "/board/proNoticeView.do?boardNo=" + boardVO.getBoardNo();
			break;
		// 이슈
		case 2:
			this.historyUri = "/issue/issueView.do?issueId=" + boardVO.getBoardNo();
			break;
		// 일감
		case 3:
			this.historyUri = "/work/workView.do?workId=" + boardVO.getBoardNo();
			break;
		// 위키
		case 7:
			this.historyUri = "/wiki/wikiView.do?boardNo=" + boardVO.getBoardNo();
			break;
		// 일일 업무 보고
		case 12:
			this.historyUri = "/workReport/workReportView.do?boardNo=" + boardVO.getBoardNo();
			break;
		}
	}
}
