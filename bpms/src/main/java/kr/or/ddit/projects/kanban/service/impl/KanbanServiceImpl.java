package kr.or.ddit.projects.kanban.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.kanban.dao.KanbanDAO;
import kr.or.ddit.projects.kanban.service.KanbanService;
import kr.or.ddit.projects.kanban.vo.KanbanStickerVO;
import kr.or.ddit.projects.kanban.vo.KanbanVO;
import kr.or.ddit.projects.member.vo.MemberVO;

@Service
public class KanbanServiceImpl implements KanbanService {

	@Inject
	private KanbanDAO kanbanDAO;

	@Override
	public List<KanbanVO> retrieveKanbanList(MemberVO MemberVO) {
		return kanbanDAO.myKanbanList(MemberVO);
	}

	@Override
	public ServiceResult insertsticker(KanbanStickerVO kanbanSticker) {

		ServiceResult result = null;
		int insertCnt = kanbanDAO.insertSticker(kanbanSticker);
		if (insertCnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public KanbanStickerVO currentSticker(KanbanStickerVO kanbanSticker) {
		return kanbanDAO.currentSticker(kanbanSticker);
	}

	@Override
	public KanbanStickerVO retrieveSticker(KanbanStickerVO kanbanSticker) {
		return kanbanDAO.retrieveSticker(kanbanSticker);
	}

	@Override
	public ServiceResult updateSticker(KanbanStickerVO kanbanSticker) {

		ServiceResult result = null;
		int updateCnt = kanbanDAO.updateSticker(kanbanSticker);
		if (updateCnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public ServiceResult deleteSticker(KanbanStickerVO kanbanSticker) {

		ServiceResult result = null;
		int deleteCnt = kanbanDAO.deleteSticker(kanbanSticker);
		if (deleteCnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public ServiceResult insertBoard(KanbanVO kanbanBoard) {

		ServiceResult result = null;
		int insertCnt = kanbanDAO.insertBoard(kanbanBoard);
		if (insertCnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public KanbanVO retrieveBoard(KanbanVO kanbanBoard) {
		return kanbanDAO.retrieveBoard(kanbanBoard);
	}

	@Override
	public ServiceResult updateBoard(KanbanVO kanbanBoard) {

		ServiceResult result = null;
		int updateCnt = kanbanDAO.updateBoard(kanbanBoard);
		if (updateCnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public ServiceResult deleteBoard(KanbanVO kanbanBoard) {

		ServiceResult result = null;
		kanbanDAO.deleteStickerBoard(kanbanBoard);
		int deleteBoard = kanbanDAO.deleteBoard(kanbanBoard);
		if (deleteBoard > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public ServiceResult updateLocation(KanbanStickerVO kanbanSticker) {

		ServiceResult result = null;
		int updateLocation = kanbanDAO.updateStickerByBoard(kanbanSticker);
		if (updateLocation > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public List<KanbanStickerVO> retrieveStickerList(MemberVO memberVO) {
		return kanbanDAO.myStickerList(memberVO);
	}
}
