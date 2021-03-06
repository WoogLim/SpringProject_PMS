package kr.or.ddit.commons.service;

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
public interface DashBoardService {

	/**
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트의 대시보드 정보를 조회
	 * @param projectVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: DashBoardVO
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public DashBoardVO retrieveDashBoard(ProjectVO projectVO);
}
