package kr.or.ddit.projects.kanban.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.projects.kanban.vo.KanbanStickerVO;
import kr.or.ddit.projects.kanban.vo.KanbanVO;
import kr.or.ddit.projects.member.vo.MemberVO;

@Repository
public interface KanbanDAO {
	public List<KanbanVO> myKanbanList(MemberVO memberVO);

	public int insertSticker(KanbanStickerVO kanbanSticker);

	public KanbanStickerVO currentSticker(KanbanStickerVO kanbanSticker);
	
	public KanbanStickerVO retrieveSticker(KanbanStickerVO kanbanSticker);
	
	public int updateSticker(KanbanStickerVO kanbanSticker);
	
	public int deleteSticker(KanbanStickerVO kanbanSticker);

	public int insertBoard(KanbanVO kanbanBoard);
	
	public KanbanVO retrieveBoard(KanbanVO kanbanBoard);
	
	public int updateBoard(KanbanVO kanbanBoard);
	
	public int deleteStickerBoard(KanbanVO kanbanBoard);
	
	public int deleteBoard(KanbanVO kanbanBoard);
	
	public int updateStickerByBoard(KanbanStickerVO kanbanSticker);

	public List<KanbanStickerVO> myStickerList(MemberVO memberVO);
}
