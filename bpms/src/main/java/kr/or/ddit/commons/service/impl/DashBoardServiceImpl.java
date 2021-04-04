package kr.or.ddit.commons.service.impl;

import org.springframework.stereotype.Service;

import kr.or.ddit.commons.service.DashBoardService;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.vo.DashBoardVO;

/**
 * @author 신광진
 * @since 2021. 2. 18.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 2. 18.    신광진         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
@Service
public class DashBoardServiceImpl extends BaseService implements DashBoardService {

	@Override
	public DashBoardVO retrieveDashBoard(ProjectVO projectVO) {
		return dashBoardDAO.selectDashBoard(projectVO);
	}
}
