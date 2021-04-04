package kr.or.ddit.projects.kanban.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.kanban.vo.KanbanStickerVO;
import kr.or.ddit.projects.kanban.vo.KanbanVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.vo.NotyMessageVO;

@Controller
public class KanbanUpdateController extends BaseController {
	

	@RequestMapping(value="/kanban/boardUpdate", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateBoard(@AuthenticationPrincipal(expression="realMember") MemberVO member,
			@ModelAttribute("kboard") KanbanVO kanbanBoard, Model model) {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		kanbanBoard.setMemId(member.getMemId());
		
		ServiceResult result = kanbanService.updateBoard(kanbanBoard);
		List<Object> boarditem = new ArrayList<>();

		switch (result) {
		case OK:
			KanbanVO boardItem = kanbanService.retrieveBoard(kanbanBoard);
			model.addAttribute("boardItem", boardItem);
			boarditem.add(boardItem);
			break;
		default:
			boarditem.add(NotyMessageVO.builder("서버 오류가 발생했습니다").build());
			break;
		}

		resultMap.put("boarditem", boarditem);
		return resultMap;
	}
	
	@RequestMapping(value="/kanban/stickerUpdate", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSticker(
			@ModelAttribute("sticker") KanbanStickerVO kanbanSticker, Model model) {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		ServiceResult result = kanbanService.updateSticker(kanbanSticker);
		List<Object> item = new ArrayList<>();

		switch (result) {
		case OK:
			KanbanStickerVO stickerItem = kanbanService.retrieveSticker(kanbanSticker);
			model.addAttribute("stickerItem", stickerItem);
			item.add(stickerItem);
			break;
		default:
			item.add(NotyMessageVO.builder("서버 오류가 발생했습니다").build());
			break;
		}

		resultMap.put("stickeritem", item);
		return resultMap;
	
	}
	
	@RequestMapping(value="/kanban/locationUpdate", method=RequestMethod.POST)
	@ResponseBody
	public String updateLocation(
			@ModelAttribute("sticker") KanbanStickerVO kanbanSticker) {

		ServiceResult result = kanbanService.updateLocation(kanbanSticker);

		switch (result) {
		case OK:
			logger.info("위치변경");
			break;
		default:
			logger.info("위치변경 실패");
			break;
		}
		
		return result.name();
	}
}
