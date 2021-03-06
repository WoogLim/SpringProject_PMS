package kr.or.ddit.projects.kanban.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.kanban.vo.KanbanStickerVO;
import kr.or.ddit.projects.kanban.vo.KanbanVO;
import kr.or.ddit.projects.member.vo.MemberVO;

public interface KanbanService {
	public List<KanbanVO> retrieveKanbanList(MemberVO memberVO);
	
	public List<KanbanStickerVO> retrieveStickerList(MemberVO memberVO);

	public KanbanStickerVO currentSticker(KanbanStickerVO kanbanSticker);

	public ServiceResult insertsticker(KanbanStickerVO kanbanSticker);
	
	public KanbanStickerVO retrieveSticker(KanbanStickerVO kanbanSticker);
	
	public ServiceResult updateSticker(KanbanStickerVO kanbanSticker);
	
	public ServiceResult deleteSticker(KanbanStickerVO kanbanSticker);	
	
	public ServiceResult updateLocation(KanbanStickerVO kanbanSticker);
	
	public ServiceResult insertBoard(KanbanVO kanbanBoard);
	
	public KanbanVO retrieveBoard(KanbanVO kanbanBoard);

	public ServiceResult updateBoard(KanbanVO kanbanBoard);
	
	public ServiceResult deleteBoard(KanbanVO kanbanBoard);
}
