package kr.or.ddit.projects.work.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.service.AdminProjectService;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.work.service.AdminWorkService;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 신광진
 * @since 2021. 2. 9.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 2. 9.    신광진         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Service
public class AdminWorkServiceImpl extends BaseService implements AdminWorkService {

	@Override
	public List<WorkVO> retrieveWorkList(PagingVO<WorkVO> pagingVO) {
		return adminWorkDAO.selectWorkList(pagingVO);
	}

	@Override
	public int retrieveWorkCount(PagingVO<WorkVO> pagingVO) {
		return adminWorkDAO.selectWorkCount(pagingVO);
	}

	@Override
	public List<WorkVO> retrieveWorkListByMember(MemberVO memberVO) {
		return adminWorkDAO.selectWorkListByMember(memberVO);
	}

	@Override
	public List<WorkVO> retrieveWorkDirectorList(PagingVO<WorkVO> pagingVO) {
		return adminWorkDAO.selectWorkDirectorList(pagingVO);
	}

	@Override
	public List<WorkVO> retrieveBoardWriterrList(PagingVO<WorkVO> pagingVO) {
		return adminWorkDAO.selectBoardWriterList(pagingVO);
	}

	@Override
	public List<WorkVO> retrieveWorkListByState() {
		return adminWorkDAO.selectWorkListByState();
	}

}
