package kr.or.ddit.projects.board.controller.projectnotice;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.board.vo.ProNoticeVO;

@Controller
@RequestMapping("/proNotice")
public class ProNoticeInsertController extends BaseController {

	@GetMapping("insertForm.do")
	public String noticeForm() {
		return "board/projectnotice/projectNoticeForm";
	}

	@PostMapping("insertForm.do")
	public String insertNotice(
		@RequestParam("proId") String proId
		, @ModelAttribute("notice") BoardVO pronotice
		, Model model
		, RedirectAttributes redirectAttr
	){
		String goPage = null;
		ServiceResult result = boardService.createBoard(pronotice);
		switch (result) {
		case OK:
			goPage = "redirect:/proNotice/proNoticeView.do?boardNo=" + pronotice.getBoardNo();
			redirectAttr.addAttribute("proId", proId);
			break;
		case FAILED:
			goPage = "board/projectnotice/projectNoticeForm";
			break;
		}

		return goPage;
	}
}