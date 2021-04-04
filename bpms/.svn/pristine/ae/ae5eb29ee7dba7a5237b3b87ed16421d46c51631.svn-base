package kr.or.ddit.projects.board.controller.servernotice;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.validate.groups.UpdateGroup;
import kr.or.ddit.vo.NotyMessageVO;

@Controller
@RequestMapping("/serverNotice/serverNoticeUpdate.do")
public class ServerNoticeUpdateController extends BaseController{
	@GetMapping
	public String form(
			@RequestParam("boardNo") int boardNo
			, Model model
			, @RequestParam(value="mng", required=false, defaultValue="N") String mng
	) {
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardNo(boardNo);
		boardVO.setCode(6);
		
		boardVO = boardService.retrieveBoard(boardVO);
		model.addAttribute("boardVO", boardVO);
		
		String goPage = "serverNotice/serverNoticeForm";
		if("Y".equals(mng)) {
			goPage = "admin/serverNotice/serverNoticeForm";
		}
		return goPage;
	}
	
	@PostMapping
	public String update(
		@RequestParam("proId") String proId
		, @Validated(UpdateGroup.class) BoardVO boardVO
		, Model model
		, RedirectAttributes redirectAttr
		, @RequestParam(value="mng", required=false, defaultValue="N") String mng
		) {
			String goPage = null;
			boardVO.setCode(6);
			ServiceResult result = boardService.modifyBoard(boardVO);
			switch (result) {
				case OK:
					goPage =  "redirect:/serverNotice/serverNoticeView.do?boardNo="+boardVO.getBoardNo();
					redirectAttr.addAttribute("proId", proId);
					redirectAttr.addAttribute("mng", mng);
					break;
				default:	
					goPage = "serverNotice/serverNoticeForm";
					break;

	}
		return goPage;
	}
}
