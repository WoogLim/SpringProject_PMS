package kr.or.ddit.projects.work.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 신광진
 * @since 2021. 2. 4.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 2. 4.    신광진           최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Repository
public interface WorkDAO {
	/**
	 * 전수빈 작업 내용 : 일감 테이블에 새로운 데이터 생성 작성 날짜 : 2021. 2. 15. 메서드명 : insertWork
	 * 
	 * @param work : 일감을 생성할 데이터를 가지고 있는 WorkVO 객체
	 * @return int : 성공시 1이상, 실패시 : 0 이하
	 */
	public int insertWork(WorkVO work);

	/**
	 * 전수빈 작업 내용 : 사용자가 요청한 일감의 정보를 수정하기 위한 메서드. 작성 날짜 : 2021. 2. 15. 메서드명 :
	 * updateWork
	 * 
	 * @param work : 수정할 일감의 식별 데이터 및 수정할 데이터를 가지고 있는 workVO 객체
	 * @return int : 성공시 1이상, 실패시 : 0 이하
	 */
	public int updateWork(WorkVO work);

	/**
	 * 전수빈 작업 내용 : 사용자가 요청한 일감을 삭제하기 위한 메서드 작성 날짜 : 2021. 2. 15. 메서드명 : deleteWork
	 * 
	 * @param work : 삭자헬 일감의 식별 데이터를 가지고 있는 workVO 객체
	 * @return int : 성공시 1이상, 실패시 : 0 이하
	 */
	public int deleteWork(WorkVO work);

	/**
	 * 전수빈 작업 내용 : 페이징 처리를 위한 일감의 totalRecord를 조회 작성 날짜 : 2021. 2. 15. 메서드명 :
	 * selectWorkListCount
	 * 
	 * @param workFilter
	 * @return : 페이징 처리를 위한 issue의 totalRecord의 값 반환
	 */
	public int selectWorkListCount(PagingVO<WorkVO> workVO);

	/**
	 * 전수빈 작업 내용 : 검색 결과와 일치하는 일감 목록 조회 작성 날짜 : 2021. 2. 15. 메서드명 : selectWorkList
	 * 
	 * @param workFilter : 검색 결과에 맞는 issueVO를 리스트에 담기 위한 pagingVO 객체
	 * @return : 검색 조건과 일치하는 모든 issue 조회. 단, 검색 조건에 아무것도 없다면 모든 issue 정보 조회
	 */
	public List<WorkVO> selectWorkList(PagingVO<WorkVO> pagingVO);

	/**
	 * 전수빈 작업 내용 : 작성 날짜 : 2021. 2. 15. 메서드명 : selectWork
	 * 
	 * @param work
	 * @return :
	 */
	public WorkVO selectWork(WorkVO workVO);

	/**
	 * 전수빈 작업 내용 : 회원이 속한 프로젝트의 일감 목록 조회 작성 날짜 : 2021. 2. 15. 메서드명 :
	 * selectByMemberToWorkList
	 * 
	 * @param workFilter
	 * @return :
	 */
	public List<WorkVO> selectByMemberToWorkList(PagingVO<WorkVO> pagingVO);

	/**
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트에서
	 * 현재 달에 완료된 일감 개수를 일 단위로 조회
	 * ex)현재 1월 -> 1월 1일 ~ 1월 31일까지 일 별로 완료된 일감 개수를 조회
	 * @param projectVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;WorkVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<WorkVO> selectCompleteWorkListInMonth(ProjectVO projectVO);
	
	/* 일감 폼 구성용 메서드 팀원에게 작성 요청 후 제거 */
	// 회원별 프로젝트 리스트 조회
	public List<ProjectVO> selectByMemberToProjectList(MemberVO memberVO);
	// 프로젝트 멤버 조회
	public List<MemberVO> selectByProjectToMemberList(WorkVO workVO);
	// 사용자가 선택한 프로젝트에 존재하는 일감인지 검색
	public WorkVO parenthWorkCheck(WorkVO workVO);
	// 사용자가 선택한 프로젝트의 일감 리스트 조회(상위 일감 검색용)
	public List<WorkVO> selectByProjectToWorkList(WorkVO workVO);
}
