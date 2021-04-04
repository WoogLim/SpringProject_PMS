package kr.or.ddit.projects.pushmsg.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.pushmsg.vo.PushMessageVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 신광진
 * @since 2021. 1. 29.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 1. 29.     신광진       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Repository
public interface PushMsgDAO {

	/**
	 * 새로운 푸시메시지 등록
	 * @param pushMsgVO
	 * @return 
	 * <pre>
	 * 성공: 1
	 * 실패: 0
	 * </pre>
	 */
	public int insertPushMsg(PushMessageVO pushMsgVO);

	/**
	 * 기존 푸시메시지 삭제
	 * @param memberVO
	 * @return 
	 * <pre>
	 * 성공: delete된 row 수 (return&gt;0)
	 * 실패: 0
	 * </pre>
	 * @throws DataAccessException TODO
	 * @throws CustomException TODO
	 */
	public int deletePushMsg(MemberVO memberVO) throws DataAccessException, CustomException;

	/**
	 * 기존 푸시메시지의 확인상태 변경
	 * @param pushMsgVO
	 * @return
	 * <pre>
	 * 성공: update된 row 수 (return &gt; 0)
	 * 실패: 0
	 * </pre>
	 * @throws DataAccessException
	 */
	public int updatePushMsg(PushMessageVO pushMsgVO) throws DataAccessException;
	
	/**
	 * 기존 푸시메시지 수 조회
	 * pagingVO에 검색조건이 포함된 경우 검색조건에 일치하는 푸시메시지 수 조회
	 * @param paging
	 * @return 
	 * <pre>
	 * 검색결과가 있는경우: return&gt;0
	 * 검색결과가 없는경우: 0
	 * </pre>
	 */
	public int selectPushMsgCount(PagingVO<PushMessageVO> paging);

	/**
	 * 파라미터로 받은 pushMsgVO의 pushNo와 일치하는 푸시 메시지 조회
	 * @param pushMsgVO
	 * @return 
	 * <pre>
	 * 검색결과가 있는경우: PushMessageVO
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public PushMessageVO selectPushMsg(PushMessageVO pushMsgVO);

	/**
	 * 기존 푸시메시지를 모두 조회
	 * pagingVO에 검색조건이 포함된 경우 검색조건에 일치하는 푸시메시지 모두 조회
	 * @param paging
	 * @return 
	 * <pre>
	 * 검색결과가 있는경우: List&lt;PushMessageVO&gt; 
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<PushMessageVO> selectPushMsgList(PagingVO<PushMessageVO> paging);
	
	/**
	 * 파라미터로 받은 memberVO의 memId와 일치하는 회원이 받은 푸시 메시지 중
	 * 확인하지 않은 푸시 메시지를 모두 조회
	 * @param memberVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;PushMessageVO&gt; 
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<PushMessageVO> selectUnConfirmedPushMsgList(MemberVO memberVO);
	
	/**
	 * 파라미터로 받은 memberVO의 memId와 일치하는 회원이 받은 푸시 메시지 중
	 * 확인하지 않은 푸시메시지 개수를 조회
	 * @param memberVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: return&gt;
	 * 검색결과가 없는경우: 0
	 * </pre>
	 */
	public int selectUnConfimedPushMsgCount(MemberVO memberVO);
	
	/**
	 * 프로젝트 거절 푸시 메시지 생성
	 * @param pushMsgVO
	 * @return
	 * <pre>
	 * 성공: 1
	 * 실패: 0
	 * </pre>
	 */
	public int insertProjectRejectMsg(PushMessageVO pushMsgVO) throws DataAccessException;
	
	/**
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트에 속한 구성원들에게
	 * 프로젝트 승인 푸시 메시지 전송
	 * @param hashMap
	 * @return
	 * <pre>
	 * 성공: project에 속한 회원 수
	 * 실패: 0
	 * </pre>
	 */
	public int insertProjectAcceptMsg(HashMap<String, Object> hashMap) throws DataAccessException;
}





