package kr.or.ddit.projects.project.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.member.vo.ProMemberVO;
import kr.or.ddit.projects.project.service.ProjectService;
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
@Service
public class ProjectServiceImpl extends BaseService implements ProjectService {

	@Override
	public List<ProjectVO> retrieveSimpleProjectList(PagingVO<ProjectVO> pagingVO) {
		return projectDAO.selectSimpleProjectList(pagingVO);
	}

	@Override
	public List<ProMemberVO> retrieveProjectMemberList(ProjectVO projectVO) {
		return projectDAO.selectProjectMemberList(projectVO);
	}

	@Override
	public List<ProjectVO> retreiveMyProjectList(PagingVO<ProjectVO> pagingVO) {
		return projectDAO.selectMyProjectList(pagingVO);
	}

	@Override
	public void modifyProjectCode(ProjectVO projectVO) throws DataAccessException, CustomException {
		projectDAO.updateProjectCode(projectVO);
	}

	@Override
	public ProjectVO retrieveProject(ProjectVO projectVO) throws DataAccessException {
		return projectDAO.selectProject(projectVO);
	}

	@Override
	public ServiceResult projectCodeCheck(ProjectVO projectVO) {
		ProjectVO retrieveVO = retrieveProject(projectVO);
		int code = retrieveVO.getCode();
		
		ServiceResult ret = null;
		if(code == CODE_COMPLETE) 	ret = ServiceResult.COMPLETE;
		else if(code == CODE_PROGRESS) ret = ServiceResult.PROGRESS;
		else if(code == CODE_PAUSE) ret = ServiceResult.PAUSE;
		else if(code == CODE_WAIT) ret = ServiceResult.WAIT;
		
		return ret;
	}

}











