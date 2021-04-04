package kr.or.ddit.projects.member.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.vo.MailVO;
import kr.or.ddit.vo.PagingVO;

public interface AdminMemberService {
	/**
	 * Authentication Class에서 사용하기 위한 id를 통해 사용자를 찾는 retrieve
	 * 
	 * @param mem_id
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: MemberVO
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public MemberVO retrieveMemberByUserName(String mem_id);

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
	public MemberVO retrieveMember(MemberVO memberVO);

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
	public int retrieveMemberCount(PagingVO<MemberVO> pagingVO);

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
	public List<MemberVO> retrieveMemberList(PagingVO<MemberVO> pagingVO);

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
	public List<MemberVO> retrieveMemberListForMain();

	/**
	 * 아이디 중복검사
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 * 아이디가 중복된 경우: ServiceResult.PKDUPLICATED
	 * 아이디가 중복되지 않은 경우: ServiceResult.OK
	 *         </pre>
	 */
	public ServiceResult duplicationCheckForMemId(MemberVO memberVO);

	/**
	 * 신규 회원등록
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 * 성공: ServiceResult.OK
	 * 실패: ServiceResult.FAILED
	 *         </pre>
	 */
	public ServiceResult createMember(MemberVO memberVO);

	/**
	 * 기존 회원정보 수정
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 * 성공: ServiceResult.OK
	 * 실패: ServiceResult.FAILED
	 * 회원이 존재하지 않음: ServiceResult.NOTEXIST
	 *         </pre>
	 */
	public ServiceResult modifyMember(MemberVO memberVO);

	/**
	 * 기존 회원정보 삭제
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 * 성공: ServiceResult.OK
	 * 실패: ServiceResult.FAILED
	 * 회원이 존재하지 않음: ServiceResult.NOTEXIST
	 *         </pre>
	 */
	public ServiceResult removeMember(MemberVO memberVO);

	/**
	 * 회원의 비밀번호를 SHA-256 알고리즘을 적용하여 암호화
	 * 
	 * @param memberVO
	 */
	public void passwordEncoder(MemberVO memberVO);

	/**
	 * 계정의 잠금상태 변경 memberVO의 memAlive값에 따라 달라진다 (N: 잠금처리, Y: 잠금해제 처리)
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 * 성공: ServiceResult.OK
	 * 실패: ServiceResult.FAILED
	 * 회원이 존재하지 않음: ServiceResult.NOTEXIST
	 *         </pre>
	 */
	public ServiceResult changeLockStatus(MemberVO memberVO);

	/**
	 * 파라미터로 받은 memberVO의 memId와 일치하는 회원의 비밀번호를 초기화
	 * 
	 * @param memberVO
	 * @return
	 * 
	 *         <pre>
	 * 성공: ServiceResult.OK
	 * 실패: ServiceResult.FAILED
	 * 회원이 존재하지 않음: ServiceResult.NOTEXIST
	 *         </pre>
	 */
	public ServiceResult initPassword(MemberVO memberVO);
	
	//////////////////////////////////////
	// proMember 관련
	//////////////////////////////////////
	/**
	 * 여러 명의 프로젝트 멤버 추가
	 * @param projectVO
	 * @throws DataAccessException TODO
	 * @throws CustomException TODO
	 */
	public void createProMemberByProjectVO(ProjectVO projectVO) throws DataAccessException, CustomException;
	
	/**
	 * 한 명의 프로젝트 멤버 추가
	 * @param projectVO
	 * @throws CustomException TODO
	 */
	public void createProMember(ProjectVO projectVO) throws CustomException;
	
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
	public int retrieveProMemberCount(ProjectVO projectVO);
	
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
	public int removeProMember(ProjectVO projectVO);
	
	
	
	
}
