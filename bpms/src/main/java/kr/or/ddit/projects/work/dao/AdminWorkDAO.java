package kr.or.ddit.projects.work.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.work.vo.WorkVO;
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
@Repository
public interface AdminWorkDAO {

	/**
	 * pagingVO의 검색조건과 일치하는 모든 일감 조회
	 * 
	 * @param pagingVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;WorkVO&gt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<WorkVO> selectWorkList(PagingVO<WorkVO> pagingVO);

	/**
	 * pagingVO의 검색조건과 일치하는 일감 수 조회
	 * 
	 * @param pagingVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: return&gt;0
	 * 검색결과가 없는경우: 0
	 *         </pre>
	 */
	public int selectWorkCount(PagingVO<WorkVO> pagingVO);

	/**
	 * 파라미터로 받은 memberVO의 memId와 일치하는 회원이 생성한 일감을 모두 조회
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;WorkVO&gt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<WorkVO> selectWorkListByMember(MemberVO memberVO);

	/**
	 * 파라미터로 받은 pagingVO의 검색조건과 일치하는 일감의 담당자를 모두 조회 ex) 프로젝트 1번의 일감 담당자를 검색할 경우, 일감
	 * 담당자리스트는 프로젝트 1번의 소속 팀원이 된다.
	 * 
	 * @param pagingVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;WorkVO&gt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<WorkVO> selectWorkDirectorList(PagingVO<WorkVO> pagingVO);

	/**
	 * 파라미터로 받은 pagingVO의 검색조건과 일치하는 일감의 생성자를 모두 조회 ex) 프로젝트 1번의 일감 생성자를 검색할 경우, 일감
	 * 생성자리스트는 프로젝트 1번의 소속 팀원이 된다.
	 * 
	 * @param pagingVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;WorkVO&gt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<WorkVO> selectBoardWriterList(PagingVO<WorkVO> pagingVO);

	/**
	 * 등록된 모든 일감의 상태별 개수를 조회
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&gt;WorkVO&lt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<WorkVO> selectWorkListByState();
}













