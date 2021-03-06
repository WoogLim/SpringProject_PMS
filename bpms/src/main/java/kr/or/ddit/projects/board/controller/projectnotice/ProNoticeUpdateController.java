package kr.or.ddit.projects.board.controller.projectnotice;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
import kr.or.ddit.projects.member.vo.MemberVO;

@Controller
@RequestMapping("/proNotice")
public class ProNoticeUpdateController extends BaseController {
	@GetMapping("updateNotice.do")
	public String updateNoticeForm(@ModelAttribute("boardNo") BoardVO pronotice, Model model) {
		pronotice = boardService.retrieveBoard(pronotice);
		model.addAttribute("pronotice", pronotice);
		return "board/projectnotice/projectNoticeForm";
	}

	@PostMapping("updateNotice.do")
	public String updateNotice(
		@RequestParam("proId") String proId
		, @AuthenticationPrincipal(expression="realMember") MemberVO member
		, @ModelAttribute("notice") ProNoticeVO pronotice
		, Model model
		, RedirectAttributes redirectAttr
	){
		ServiceResult result = null;
		
		pronotice.setCode(1);
		pronotice.setBoardWriter(member.getMemId());
		result = boardService.modifyBoard(pronotice);
		String goPage = null;
		switch (result) {
		case OK:
			goPage = "redirect:/proNotice/proNoticeView.do?boardNo=" + pronotice.getBoardNo();
			redirectAttr.addAttribute("proId", proId);
			break;
		case FAILED:
			goPage = "board/project/projectnotice/projectNoticeForm";
			break;
		}
		return goPage;
	}
}
