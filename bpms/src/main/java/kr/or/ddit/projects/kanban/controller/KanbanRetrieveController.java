package kr.or.ddit.projects.kanban.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.kanban.vo.KanbanStickerVO;
import kr.or.ddit.projects.kanban.vo.KanbanVO;
import kr.or.ddit.projects.member.vo.MemberVO;

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
public class KanbanRetrieveController extends BaseController {

	@RequestMapping(value="/kanban/kanbanView.do", method=RequestMethod.GET)
	public String kanbanboardList(@AuthenticationPrincipal(expression="realMember") MemberVO member, Model model)
			throws JsonProcessingException {

		List<KanbanVO> kanbanList = kanbanService.retrieveKanbanList(member);

		model.addAttribute("kanbanList", kanbanList);

		return "kanban/kanbanView";
	}

	@RequestMapping(value="/kanban/stickerView", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> retrievSticker(@ModelAttribute("sticker") KanbanStickerVO kanbanSticker, Model model){
		logger.info("칸반 연결중"+kanbanSticker.getKstickerId());
		logger.info("연결햇씁니다");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		KanbanStickerVO stickerView = kanbanService.retrieveSticker(kanbanSticker);
		
		resultMap.put("stickerInfo", stickerView);
		return resultMap;
	}
}
