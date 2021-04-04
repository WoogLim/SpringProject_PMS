package kr.or.ddit.projects.history.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.projects.history.vo.HistoryVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 전수빈
 * @since 2021. 2. 1.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 1.      전수빈       insertHistory 메서드 추가
 * 2021. 2. 1.      전수빈       deleteHistory 메서드 추가
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
@Repository
public interface HistoryDAO {
	
	/**
	 * 전수빈
	 * 작업 내용 : 히스토리 새로운 데이터 생성
	 * 작성 날짜 : 2021. 2. 1.
	 * 메서드명 : insertHistory
	 * @param history : 히스토리를 생성할 데이터를 가지고 있는 hitoryVO 객체
	 * @return int : 성공시 int형 타입의 1 이상의 값을 반환
	 */
	public int insertHistory(HistoryVO history);
	
	/**
	 * 전수빈
	 * 작업 내용 : 히스토리 데이터 삭제
	 * 작성 날짜 : 2021. 2. 1.
	 * 메서드명 : deleteHistory
	 * @param history : 삭제할 히스토리의 식별 데이터를 가지고 있는 historyVO 객체
	 * @return int : 성공시 int형 타입의 1 이상의 값을 반환
	 */
	public int deleteHistory(HistoryVO history);
	
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
	 * 작업 내용 : 검색 결과에 맞는 history 목록 조회
	 * 작성 날짜 : 2021. 2. 18.
	 * 메서드명 : selectHistoryList
	 * @param pagingVO
	 * @return : 
	 */
	public List<HistoryVO> selectHistoryList(PagingVO<HistoryVO> pagingVO);
}
