package kr.or.ddit.projects.issue.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 전수빈
 * @since 2021. 1. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 28.      작성자명       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
public interface IssueService {
	/**
	 * 전수빈
	 * 작업 내용 : 사용자가 생성 할 issue 데이터를 점검하고 persistence영역에 issue 생성 요청 및 생성 된 결과를 확인하기 위한 메서드. 
	 * 작성 날짜 : 2021. 1. 28.
	 * 메서드명 : createIssue
	 * @param issue
	 * @return : 성공 시 : OK, 실패 시 : FALIED
	 */
	public ServiceResult createIssue(IssueVO issue);
	
	/**
	 * 전수빈
	 * 작업 내용 : 사용자가 수정 할 issue 데이터를 점검하고 persistence영역에 issue 수정 요청 및 수정 결과를 확인하기 위한 메서드.
	 * 작성 날짜 : 2021. 1. 28.
	 * 메서드명 : modifyIssue
	 * @param issue
	 * @return : 성공 시 : OK, 실패 시 : FALIED
	 */
	public ServiceResult modifyIssue(IssueVO issue);
	
	/**
	 * 전수빈
	 * 작업 내용 : 사용자가 삭제 할 issue 데이터를 점검하고 persistence영역에 issue 삭제 요청 및 삭제 결과를 확인하기 위한 메서드.
	 * 작성 날짜 : 2021. 1. 28.
	 * 메서드명 : removeIssue
	 * @param issue
	 * @return : 성공 시 : OK, 실패 시 : FALIED
	 */
	public ServiceResult removeIssue(IssueVO issue);

	/**
	 * 전수빈
	 * 작업 내용 : 상세 조회
	 * 작성 날짜 : 2021. 1. 28.
	 * 메서드명 : retrieveIssue
	 * @param issueVO
	 * @return : 이슈 상세 정보
	 */
	public IssueVO retrieveIssue(IssueVO issue);
	
	/**
	 * 전수빈
	 * 작업 내용 : 페이징 처리를 위한 issue의 total record의 값을 persistence 영역에 요청
	 * 작성 날짜 : 2021. 1. 28.
	 * 메서드명 : retrieveIssueCount
	 * @param issueFilter TODO
	 * @return : issue total record
	 */
	public int retrieveIssueCount(PagingVO<IssueVO> issueVO);
	
	/**
	 * 전수빈
	 * 작업 내용 : 목록 조회 
	 * 작성 날짜 : 2021. 1. 28.
	 * 메서드명 : retrieveIssueList
	 * @param pagingVO
	 * @return : 이슈 목록
	 */
	public List<IssueVO> retrieveIssueList(PagingVO<IssueVO> pagingVO);
	
	/**
	 * 전수빈
	 * 작업 내용 :
	 * 작성 날짜 : 2021. 2. 9.
	 * 메서드명 : retrieveByMemberToIssueList
	 * @param issueFilter
	 * @return : 
	 */
	public List<IssueVO> retrieveByMemberToIssueList(PagingVO<IssueVO> issueVO);
	
	/**
	 * 전수빈
	 * 작업 내용 :
	 * 작성 날짜 : 2021. 2. 9.
	 * 메서드명 : selectByMemberToProjectList
	 * @param memberVO
	 * @return : 
	 */
	public List<ProjectVO> retrieveByMemberToProjectList(MemberVO memberVO);
	
	/**
	 * 전수빈
	 * 작업 내용 :
	 * 작성 날짜 : 2021. 2. 9.
	 * 메서드명 : selectByProjectToMemberList
	 * @param issueVO
	 * @return : 
	 */
	public List<MemberVO> retrieveByProjectToMemberList(IssueVO issueVO);
	
	/**
	 * 신광진
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트에서
	 * 타입별 이슈 개수를 조회
	 * @param project
	 * @return 
	 * </pre>
	 * 검색결과가 있는경우: List&ltIssueVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<IssueVO> retrieveTodayIssueList(ProjectVO projectVO);
	
	/**
	 * 전수빈
	 * 작업 내용 :
	 * 작성 날짜 : 2021. 2. 24.
	 * 메서드명 : retrieveByProjectToWorkList
	 * @param issueVO
	 * @return : 
	 */
	public List<WorkVO> retrieveByProjectToWorkList(IssueVO issueVO);
	
}
