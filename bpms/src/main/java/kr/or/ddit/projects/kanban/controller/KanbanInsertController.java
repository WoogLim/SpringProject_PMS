package kr.or.ddit.projects.kanban.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.kanban.vo.KanbanStickerVO;
import kr.or.ddit.projects.kanban.vo.KanbanVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.validate.groups.InsertGroup;
import kr.or.ddit.vo.NotyMessageVO;

/**
 * @author 임건
 * @since 2021. 2. 4
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일            수정자           수정내용
 * ------------     --------    ----------------------
 * 2021. 2. 4.      임건          	최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Controller
public class KanbanInsertController extends BaseController {

	@RequestMapping(value="/kanban/boardInsert", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertBoard(@AuthenticationPrincipal(expression="realMember") MemberVO member,
			@ModelAttribute("kboard") KanbanVO kanbanBoard, Model model) {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		kanbanBoard.setMemId(member.getMemId());
		
		ServiceResult result = kanbanService.insertBoard(kanbanBoard);
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

	@RequestMapping(value="/kanban/stickerInsert", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertSticker(
			@ModelAttribute("sticker") KanbanStickerVO kanbanSticker, Model model) {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		ServiceResult result = kanbanService.insertsticker(kanbanSticker);
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
}

