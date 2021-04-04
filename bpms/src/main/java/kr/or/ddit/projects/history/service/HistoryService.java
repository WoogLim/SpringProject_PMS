package kr.or.ddit.projects.history.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.history.vo.HistoryVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 전수빈
 * @since 2021. 2. 20.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 20.      작성자명       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
public interface HistoryService {
	
	/**
	 * 전수빈
	 * 작업 내용 :
	 * 작성 날짜 : 2021. 2. 20.
	 * 메서드명 : selectHistoryListCount
	 * @param pagingVO
	 * @return : 
	 */
	public int selectHistoryListCount(PagingVO<HistoryVO> pagingVO);
	
	/**
	 * 전수빈
	 * 작업 내용 :
	 * 작성 날짜 : 2021. 2. 20.
	 * 메서드명 : selectHistoryList
	 * @param pagingVO
	 * @return : 
	 */
	public List<HistoryVO> selectHistoryList(PagingVO<HistoryVO> pagingVO);
	
}
