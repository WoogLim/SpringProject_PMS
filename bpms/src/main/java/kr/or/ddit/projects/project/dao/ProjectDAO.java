package kr.or.ddit.projects.project.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

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
@Repository
public interface ProjectDAO {

	/**
	 * 현재 프로젝트를 모두 조회(아이디, 이름, 진행상태)
	 * 새 프로젝트 요청 시 상위 프로젝트 지정에 사용됨
	 * @param pagingVO TODO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProjectVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<ProjectVO> selectSimpleProjectList(PagingVO<ProjectVO> pagingVO);
	
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
	public List<ProMemberVO> selectProjectMemberList(ProjectVO projectVO);
	
	/**
	 * 파라미터로 받은 memberVO의 memId와 일치하는 회원이 속해있는 프로젝트 리스트를 조회
	 * @param pagingVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProjectVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<ProjectVO> selectMyProjectList(PagingVO<ProjectVO> pagingVO);
	
	/**
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트의 
	 * 상태를 변경함
	 * @return
	 * <pre>
	 * 성공: update된 row 수 (return &gt; 0)
	 * 실패: 0
	 * </pre>
	 */
	public int updateProjectCode(ProjectVO projectVO) throws DataAccessException;
	
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
	public ProjectVO selectProject(ProjectVO projectVO) throws DataAccessException;
}

















