package kr.or.ddit.projects.history.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.history.service.HistoryService;
import kr.or.ddit.projects.history.vo.HistoryVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.vo.PagingVO;

@Service
public class HistoryServiceImpl extends BaseService implements HistoryService {

	@Override
	public int selectHistoryListCount(PagingVO<HistoryVO> pagingVO) {
		return historyDAO.selectHistoryListCount(pagingVO);
	}
	
	@Override
	public List<HistoryVO> selectHistoryList(PagingVO<HistoryVO> pagingVO) {
		return historyDAO.selectHistoryList(pagingVO);
	}
}
