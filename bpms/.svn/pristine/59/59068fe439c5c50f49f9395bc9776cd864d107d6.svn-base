package kr.or.ddit.projects.issue.service;

import java.util.List;

import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 신광진
 * @since 2021. 2. 9.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 2. 9.    신광진         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
public interface AdminIssueService {

	/**
	 * pagingVO의 검색조건과 일치하는 모든 이슈 조회
	 * 
	 * @param pagingVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;IssueVO&gt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<IssueVO> retrieveIssueList(PagingVO<IssueVO> pagingVO);

	/**
	 * pagingVO의 검색조건과 일치하는 이슈 수 조회
	 * 
	 * @param pagingVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: return&gt;0
	 * 검색결과가 없는경우: 0
	 *         </pre>
	 */
	public int retrieveIssueCount(PagingVO<IssueVO> pagingVO);

	/**
	 * 파라미터로 받은 memberVO의 memId와 일치하는 회원이 발행한 ISSUE를 최근날짜순서로 최대 5건 조회
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;IssueVOgt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<IssueVO> retrieveIssueListByMember(MemberVO memberVO);

	/**
	 * 파라미터로 받은 pagingVO의 searchVO조건에 맞는 이슈 담당자를 모두 조회 담당자 별 구분을 위해 사용
	 * 
	 * @param pagingVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;IssueVOgt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<IssueVO> retrieveIssueDirectorList(PagingVO<IssueVO> pagingVO);

	/**
	 * 파라미터로 받은 pagingVO의 searchDetail조건에 맞는 이슈 발행인을 모두 조회 발행인 별 구분을 위해 사용
	 * 
	 * @param pagingVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;IssueVOgt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<IssueVO> retrieveBoardWriterList(PagingVO<IssueVO> pagingVO);
	
	/**
	 * 등록된 모든 이슈의 상태별 개수를 조회
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;IssueVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<IssueVO> retrieveIssueByState();
	
}
