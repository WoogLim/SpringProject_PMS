package kr.or.ddit.projects.board.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CustomTransactionException;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.board.service.BoardService;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.file.vo.AttatchVO;
import kr.or.ddit.projects.history.vo.HistoryVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.vo.PagingVO;

@Service
public class BoardServiceImpl extends BaseService implements BoardService {
	@Value("#{appInfo.boardFolder}")
	private File saveFolder;

	@PostConstruct
	public void init() {
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}
	}

	@Transactional
	@Override
	public ServiceResult createBoard(BoardVO boardVO) {
		int cnt = boardDAO.insertBoard(boardVO);
		if (cnt > 0) {
			cnt += processAttatches(boardVO);
		}
		ServiceResult result = null;
		if (cnt > 0) {
			// 게시판 생성시 히스토리 작업내역 추가 by JSB
			// 로직 검증 하나도 안되어 있음 검증 필요
//			HistoryVO history = new HistoryVO(boardVO, HistoryVO.HISTORYINSERT);
//			historyDAO.insertHistory(history);
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	private int processAttatches(BoardVO boardVO) {
		List<AttatchVO> attatchList = boardVO.getAttatchList();
		int cnt = 0;
		if (attatchList != null && !attatchList.isEmpty()) {
			cnt += fileDAO.insertAttaches(boardVO);
			try {
				for (AttatchVO attatch : attatchList) {
					attatch.saveTo(saveFolder);
				}
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
		}
		return cnt;
	}

	private int processDeleteAttatch(BoardVO boardVO) {
		int cnt = 0;
		int[] delAttNos = boardVO.getDelAttNos();
		if (delAttNos != null && delAttNos.length > 0) {
			String[] saveNames = new String[delAttNos.length];
			for (int i = 0; i < delAttNos.length; i++) {
				saveNames[i] = fileDAO.selectAttatch(delAttNos[i]).getAttSavename();
			}
			cnt = fileDAO.deleteAttatches(boardVO);
			if (cnt == saveNames.length) {
				for (String savename : saveNames) {
					FileUtils.deleteQuietly(new File(saveFolder, savename));
				}
			}
		}
		return cnt;
	}

	@Transactional
	@Override
	public ServiceResult modifyBoard(BoardVO boardVO) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = boardDAO.updateBoard(boardVO);
		if (cnt > 0) {
			// 게시판 수정시 히스토리 작업내역 추가 by JSB
			// 로직 검증 하나도 안되어 있음 검증 필요
//			HistoryVO history = new HistoryVO(boardVO, HistoryVO.HISTORYUPDATE);
//			historyDAO.insertHistory(history);
			processAttatches(boardVO);
			processDeleteAttatch(boardVO);
			result = ServiceResult.OK;
		}
		return result;
	}

	@Transactional
	@Override
	public ServiceResult removeBoard(BoardVO boardVO) {
		BoardVO savedBoard = boardDAO.selectBoard(boardVO);
		if (savedBoard == null)
			throw new CustomTransactionException(boardVO.getBoardNo() + "번 글이 없음");
		ServiceResult result = ServiceResult.FAILED;
		List<AttatchVO> attatchList = savedBoard.getAttatchList();
		String[] saveNames = null;
		int cnt = 0;
		if (attatchList != null && attatchList.size() > 0) {
			saveNames = new String[attatchList.size()];
			for (int i = 0; i < saveNames.length; i++) {
				saveNames[i] = attatchList.get(i).getAttSavename();
			}
			cnt = fileDAO.deleteAttatches(boardVO);
		}
		// 게시글 삭제
		cnt += boardDAO.deleteBoard(boardVO);
		// 첨부파일 2진 데이터 삭제
		if (saveNames != null) {
			for (String savename : saveNames) {
				FileUtils.deleteQuietly(new File(saveFolder, savename));
			}
		}
		if (cnt > 0)
			result = ServiceResult.OK;

		return result;
//		Object retrieveRes = retrieveBoard(boardVO);
//		ServiceResult ret = ServiceResult.OK;
//		if(retrieveRes != null) {
//			int removeRes = boardDAO.deleteBoard(boardVO);
//			if(removeRes < 1) ret = ServiceResult.FAILED;
//		} else {
//			ret = ServiceResult.NOTEXIST;
//		}
//		return ret;
	}

	@Override
	public int retrieveBoardCount(PagingVO<BoardVO> paging) {
		return boardDAO.selectBoardCount(paging);
	}

	@Override
	public List<BoardVO> retrieveBoardList(PagingVO<BoardVO> paging) {
		return boardDAO.selectBoardList(paging);
	}

	@Override
	public BoardVO retrieveBoard(BoardVO boardVO) {
		return boardDAO.selectBoard(boardVO);
	}

	@Override
	public List<BoardVO> retrieveBoardListForMain() {
		return boardDAO.selectBoardListForMain();
	}

	@Override
	public List<BoardVO> retrieveLatelyBoardList(ProjectVO projectVO) {
		return boardDAO.selectLatelyBoardList(projectVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.ddit.projects.board.service.BoardService#retrieveForm(kr.or.ddit.projects.board.vo.BoardVO)
	 */
	@Override
	public BoardVO retrieveForm(BoardVO boardVO) {
		return boardDAO.selectForm(boardVO);
	}
}