package kr.or.ddit.projects.issue.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.issue.service.AdminIssueService;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 신광진
 * @since 2021. 2. 9.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 2. 9.    신광진         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
@Service
public class AdminIssueServiceImpl extends BaseService implements AdminIssueService {

	@Override
	public List<IssueVO> retrieveIssueList(PagingVO<IssueVO> pagingVO) {
		return adminIssueDAO.selectIssueList(pagingVO);
	}

	@Override
	public int retrieveIssueCount(PagingVO<IssueVO> pagingVO) {
		return adminIssueDAO.selectIssueCount(pagingVO);
	}

	@Override
	public List<IssueVO> retrieveIssueListByMember(MemberVO memberVO) {
		return adminIssueDAO.selectIssueListByMember(memberVO);
	}

	@Override
	public List<IssueVO> retrieveIssueDirectorList(PagingVO<IssueVO> pagingVO) {
		return adminIssueDAO.selectIssueDirectorList(pagingVO);
	}

	@Override
	public List<IssueVO> retrieveBoardWriterList(PagingVO<IssueVO> pagingVO) {
		return adminIssueDAO.selectBoardWriterList(pagingVO);
	}

	@Override
	public List<IssueVO> retrieveIssueByState() {
		return adminIssueDAO.selectIssueByState();
	}

}
