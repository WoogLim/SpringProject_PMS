package kr.or.ddit.projects.history.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.history.service.AdminHistoryService;
import kr.or.ddit.projects.history.vo.HistoryVO;
import kr.or.ddit.vo.PagingVO;


/**
 * @author 신광진
 * @since 2021. 2. 13.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일       	수정자           수정내용
 * ------------    --------    ----------------------
 * 2021. 2. 13.     신광진           최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
@Service
public class AdminHistoryServiceImpl extends BaseService implements AdminHistoryService {

	@Override
	public int retrieveHistoryListCount(PagingVO<HistoryVO> pagingVO) {
		return adminHistoryDAO.selectHistoryListCount(pagingVO);
	}

	@Override
	public List<HistoryVO> retrieveHistoryList(PagingVO<HistoryVO> pagingVO) {
		return adminHistoryDAO.selectHistoryList(pagingVO);
	}


}
