package kr.or.ddit.projects.issue.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.vo.PagingVO;

/**
 * 이슈 관련 DB에 접근하기 위한 DAO 인터페이스
 * 
 * @author 전수빈
 * @since 2021. 1. 27.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 27.     작성자명       	최초작성
 * 2021. 1. 28.		전수빈		insertIssue 추가
 * 2021. 1. 28.		전수빈		updateIssue 추가
 * 2021. 1. 28.		전수빈		deleteIssue 추가
 * 2021. 1. 28.		전수빈		selectIssueListCount 추가
 * 2021. 1. 28.		전수빈		selectIssueList 추가
 * 2021. 1. 28.		전수빈		selectIssue 추가
 *      </pre>
 */
@Repository
public interface IssueDAO {
	/**
	 * 전수빈 작업 내용 : 이슈 테이블에 새로운 데이터 생성 작성 날짜 : 2021. 1. 28. 메서드명 : insertIssue
	 * 
	 * @param issue : 이슈를 생성할 데이터를 가지고 있는 issueVO 객체
	 * @return int : 성공시 1 이상 , 실패시 : 0 이하
	 */
	public int insertIssue(IssueVO issue);

	/**
	 * 전수빈 작업 내용 : 사용자가 요청 한 issue의 정보를 수정하기 위한 메서드. 작성 날짜 : 2021. 1. 28. 메서드명 :
	 * updateIssue
	 * 
	 * @param issue : 수정할 이슈의 식별 데이터 및 수정할 데이터를 가지고 있는 issueVO 객체
	 * @return int : 성공시 1 이상 , 실패시 : 0 이하
	 */
	public int updateIssue(IssueVO issue);

	/**
	 * 전수빈 작업 내용 : 사용자가 요청한 issue를 삭제하기 위한 메서드 작성 날짜 : 2021. 1. 28. 메서드명 :
	 * deleteIssue
	 * 
	 * @param issue : 삭제할 이슈의 식별 데이터를 가지고 있는 issueVO 객체
	 * @return int : 성공시 1 이상 , 실패시 : 0 이하
	 */
	public int deleteIssue(IssueVO issue);

	/**
	 * 전수빈 작업 내용 : 페이징 처리를 위한 issue의 totalRecord를 조회 작성 날짜 : 2021. 1. 28. 메서드명 :
	 * selectIssueListCount
	 * 
	 * @param issueFilter
	 * @return int : 페이징 처리를 위한 issue의 totalRecord의 값 반환
	 */
	public int selectIssueListCount(PagingVO<IssueVO> issueVO);

	/**
	 * 전수빈 작업 내용 : 검색 결과와 일치하는 issue 목록 조회 작성 날짜 : 2021. 1. 28. 메서드명 :
	 * selectIssueList
	 * 
	 * @param pagingVO : 검색 결과에 맞는 issueVO를 리스트에 담기 위한 pagingVO 객체
	 * @return : 검색 조건과 일치하는 모든 issue 조회. 단, 검색 조건에 아무것도 없다면 모든 issue 정보 조회
	 */
	public List<IssueVO> selectIssueList(PagingVO<IssueVO> pagingVO);

	/**
	 * 전수빈 작업 내용 : issue 상세 조회 작성 날짜 : 2021. 1. 28. 메서드명 : selectIssue
	 * 
	 * @param issue : 상세 조회할 이슈의 데이터를 운반하고 식별하기 위한 IssueVO 객체
	 * @return : 식별 조건과 맞는 issue 데이터 반환, 존재 하지 않는 이슈라면 null 반환
	 */
	public IssueVO selectIssue(IssueVO issue);

	/**
	 * 전수빈 작업 내용 : 회원이 속한 프로젝트의 issue 목록 조회 작성 날짜 : 2021. 2. 5. 메서드명 :
	 * selectByauthMemberIssueList
	 * 
	 * @param issueFilter
	 * @return :
	 */
	public List<IssueVO> selectByMemberToIssueList(PagingVO<IssueVO> issueVO);
	
	/**
	 * 신광진
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트에서
	 * 현재 날짜에 생성된 이슈의 타입별 개수를 조회
	 * @param project
	 * @return 
	 * </pre>
	 * 검색결과가 있는경우: List&ltIssueVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<IssueVO> selectTodayIssueList(ProjectVO projectVO);

	/* 이슈 폼 구성용 접근 메서드 나중에 팀원에게 작성 요청 후 제거 */
	/**
	 * 전수빈
	 * 작업 내용 :
	 * 작성 날짜 : 2021. 2. 24.
	 * 메서드명 : selectByMemberToProjectList
	 * @param memberVO
	 * @return : 
	 */
	public List<ProjectVO> selectByMemberToProjectList(MemberVO memberVO);

	// 프로젝트별 구성원 조회
	/**
	 * 전수빈
	 * 작업 내용 :
	 * 작성 날짜 : 2021. 2. 24.
	 * 메서드명 : selectByProjectToMemberList
	 * @param issueVO
	 * @return : 
	 */
	public List<MemberVO> selectByProjectToMemberList(IssueVO issueVO);

	// 프로젝트별 일감 리스트 (연결 일감 조회 용)
	/**
	 * 전수빈
	 * 작업 내용 :
	 * 작성 날짜 : 2021. 2. 24.
	 * 메서드명 : selectByProjectToWorkList
	 * @param issueVO
	 * @return : 
	 */
	public List<WorkVO> selectByProjectToWorkList(IssueVO issueVO);

	/**
	 * 전수빈
	 * 작업 내용 :
	 * 작성 날짜 : 2021. 2. 24.
	 * 메서드명 : issueToWorkCheck
	 * @param issueVO
	 * @return : 
	 */
	public WorkVO issueToWorkCheck(IssueVO issueVO);
}
