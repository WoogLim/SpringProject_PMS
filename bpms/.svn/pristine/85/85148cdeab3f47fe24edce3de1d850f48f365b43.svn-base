package kr.or.ddit.projects.member.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.security.vo.AuthorityVO;
import kr.or.ddit.vo.PagingVO;

@Repository
public interface AdminMemberDAO {

	/**
	 * Authentication Class에서 사용하기 위한 id를 통해 사용자를 찾는 select
	 * 
	 * @param mem_id
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: MemberVO
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public MemberVO selectMemberByUserName(String mem_id);

	/**
	 * memberVO의 memId와 일치하는 회원 조회
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있을경우: MemberVO
	 * 검색결과가 없을경우: null
	 *         </pre>
	 */
	public MemberVO selectMember(MemberVO memberVO);

	/**
	 * pagingVO에 포함된 검색결과와 일치하는 회원 수 조회 검색조건이 없는경우 등록된 모든 회원 수 조회
	 * 
	 * @param pagingVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: return&gt;0
	 * 검색결과가 없는경우: 0
	 *         </pre>
	 */
	public int selectMemberCount(PagingVO<MemberVO> pagingVO);

	/**
	 * pagingVO에 포함된 검색결과와 일치하는 회원 정보 조회 검색조건이 없는경우 등록된 모든 회원 정보 조회
	 * 
	 * @param pagingVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;MemberVO&gt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<MemberVO> selectMemberList(PagingVO<MemberVO> pagingVO);

	/**
	 * 메인화면에 출력하기 위해 최근 추가된 회원 5명을 조회
	 * 
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;MemberVO&gt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<MemberVO> selectMemberListForMain();

	/**
	 * 아이디 중복검사
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 * 아이디가 중복된 경우: MemberVO
	 * 아이디가 중복되지 않은 경우: null
	 *         </pre>
	 */
	public MemberVO duplicationCheckForMemId(MemberVO memberVO);

	/**
	 * 신규 회원등록
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 * 성공: 1
	 * 실패: 0
	 *         </pre>
	 */
	public int insertMember(MemberVO memberVO);

	/**
	 * 기존 회원정보 수정
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 * 성공: update된 row 수 (row&gt;0)
	 * 실패: 0
	 *         </pre>
	 */
	public int updateMember(MemberVO memberVO);

	/**
	 * 기존 회원정보 삭제
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 * 성공: delete된 row 수 (row&gt;0)
	 * 실패: 0
	 *         </pre>
	 */
	public int deleteMember(MemberVO memberVO);

	/**
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트에 속한
	 * 구성원을 모두 삭제
	 * @param projectVO
	 * @return
	 * <pre>
	 * 성공: delete된 row 수 (return &gt; 0)
	 * 실패: 0
	 * </pre>
	 */
	public int deleteProMember(ProjectVO projectVO) throws DataAccessException;
	
	/**
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트에 속한
	 * 구성원의 수를 조회
	 * @param projectVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: return &gt; 0
	 * 검색결과가 없는경우: 0
	 * <pre>
	 */
	public int selectProMemberCount(ProjectVO projectVO);
	
	/**
	 * 계정의 잠금상태 변경 memberVO의 memAlive값에 따라 달라진다 (N: 잠금처리, Y: 잠금해제 처리)
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 *         성공: update된 row 수 (row&gt;0) 실패: 0
	 */
	public int changeLockStatus(MemberVO memberVO);

	/**
	 * 파라미터로 받은 memberVO의 memId와 일치하는 회원의 비밀번호를 초기화
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 * 성공: update된 row 수 (row&gt;0)
	 * 실패: 0
	 *         </pre>
	 */
	public int initPassword(MemberVO memberVO);
	
	/////////////////////////////////////////////////
	// proMember 관련
	/////////////////////////////////////////////////
	/**
	 * 여러 명의 프로젝트 멤버 추가
	 * @param projectVO
	 * @return
	 * <pre>
	 * 성공: insert된 row 수 (return &gt; 0)
	 * 실패: 0 or return &lt; proMemberList.size()
	 * </pre>
	 */
	public int insertProMemberByProjectVO(ProjectVO projectVO) throws DataAccessException;
	
	/**
	 * 한 명의 프로젝트 멤버 추가
	 * @param projectVO
	 * @return
	 * <pre>
	 * 성공: 1
	 * 실패: 0
	 * </pre>
	 */
	public int insertProMember(ProjectVO projectVO) throws DataAccessException;

	
}
