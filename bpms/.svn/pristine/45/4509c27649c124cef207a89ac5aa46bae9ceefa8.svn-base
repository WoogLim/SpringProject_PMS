package kr.or.ddit.projects.work.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
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
 * 2021. 2. 4.    신광진         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
public interface WorkService {
	
	public ServiceResult createWork(WorkVO workVO);

	public ServiceResult modifyWork(WorkVO workVO);

	public ServiceResult removeWork(WorkVO workVO);

	public WorkVO retrieveWork(WorkVO workVO);

	public int retrieveWorkCount(PagingVO<WorkVO> pagingVO);

	public List<WorkVO> retrieveWorkList(PagingVO<WorkVO> pagingVO);

	public List<WorkVO> retrieveByMemberToWorkList(PagingVO<WorkVO> workFilter);

	public List<ProjectVO> retrieveByMemberToProjectList(MemberVO memberVO);

	public List<MemberVO> retrieveByProjectToMemberList(WorkVO workVO);

	public List<WorkVO> retrieveByProjectToWorkList(WorkVO workVO);

	public WorkVO parenthWorkCheck(WorkVO workVO);
	
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
	public List<WorkVO> retrieveCompleteWorkListInMonth(ProjectVO projectVO);
}
