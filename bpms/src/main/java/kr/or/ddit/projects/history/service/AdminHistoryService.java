package kr.or.ddit.projects.history.service;

import java.util.List;

import kr.or.ddit.projects.history.vo.HistoryVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.SortVO;

/**
 * @author 신광진
 * @since 2021. 2. 13.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일       	수정자           수정내용
 * ------------    --------    ----------------------
 * 2021. 2. 13.     신광진           최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
public interface AdminHistoryService {

	/**
	 * 파라미터로 받은 pagingVO의 조건과 일치하는 히스토리 내역 개수 조회
	 * @param pagingVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: return &gt; 0
	 * 검색결과가 없는경우: 0
	 * </pre>
	 */
	public int retrieveHistoryListCount(PagingVO<HistoryVO> pagingVO);
	
	/**
	 * 파라미터로 받은 pagingVO의 조건과 일치하는 히스토리 리스트 조회
	 * @param pagingVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;HistoryVO&gt;
	 * 검색결과강 없는경우: null
	 * </pre>
	 */
	public List<HistoryVO> retrieveHistoryList(PagingVO<HistoryVO> pagingVO);
	
}
