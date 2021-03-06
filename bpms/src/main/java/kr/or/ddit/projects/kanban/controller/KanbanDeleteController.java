package kr.or.ddit.projects.kanban.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.kanban.vo.KanbanStickerVO;
import kr.or.ddit.projects.kanban.vo.KanbanVO;
import kr.or.ddit.validate.groups.DeleteGroup;

@Controller
public class KanbanDeleteController extends BaseController {

	@RequestMapping(value="/kanban/stickerDelete", method=RequestMethod.POST)
	@ResponseBody
	public String deleteSticke(
		@ModelAttribute("sticker") KanbanStickerVO kanbanSticker) {
		
		ServiceResult result = 	kanbanService.deleteSticker(kanbanSticker);
		
		logger.info(result.name() + " 삭제됨");
		
		return result.name();
	}
	
	@RequestMapping(value="/kanban/boardDelete", method=RequestMethod.POST)
	@ResponseBody
	public String deleteBoard(
		@ModelAttribute("kboard") KanbanVO kanbanBoard) {
		
		ServiceResult result = 	kanbanService.deleteBoard(kanbanBoard);
		
		return result.name();
	}
}
