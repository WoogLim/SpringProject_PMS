package kr.or.ddit.projects.project.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.member.vo.ProMemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 신광진
 * @since 2021. 2. 21.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일       	수정자           수정내용
 * ------------    --------    ----------------------
 * 2021. 2. 21.     신광진           최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
public interface ProjectService {
	
	/**
	 * 현재 진행중인 프로젝트를 모두 조회(이름과 아이디만)
	 * 새 프로젝트 요청 시 상위 프로젝트 지정에 사용됨
	 * @param pagingVO TODO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProjectVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<ProjectVO> retrieveSimpleProjectList(PagingVO<ProjectVO> pagingVO);
	
	/**
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트에 속한
	 * 구성원을 모두조회
	 * @param projectVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProMemberVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<ProMemberVO> retrieveProjectMemberList(ProjectVO projectVO);
	
	/**
	 * 파라미터로 받은 memberVO의 memId와 일치하는 회원이 속해있는 프로젝트 리스트를 조회
	 * @param pagingVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProjectVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<ProjectVO> retreiveMyProjectList(PagingVO<ProjectVO> pagingVO);
	
	/**
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트의 
	 * 상태를 변경함
	 */
	public void modifyProjectCode(ProjectVO projectVO);
	
	/**
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트 정보 조회
	 * @param projectVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: projectVO
	 * 검색결과가 없는경우: null
	 * </pre>
	 * @throws DataAccessException
	 */
	public ProjectVO retrieveProject(ProjectVO projectVO) throws DataAccessException;
	
	/**
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트의
	 * 상태코드를 조회
	 * @param projectVO
	 * @return
	 * <pre>
	 * 진행중인경우: ServiceResult.PROGRESS
	 * 정지인 경우: ServiceResult.PAUSE
	 * 완료된 경우: ServiceResult.COMPLETE
	 * </pre>
	 */
	public ServiceResult projectCodeCheck(ProjectVO projectVO);
	
}












