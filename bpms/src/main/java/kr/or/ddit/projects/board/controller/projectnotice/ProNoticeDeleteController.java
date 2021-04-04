package kr.or.ddit.projects.board.controller.projectnotice;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.board.vo.ProNoticeVO;

@Controller
@RequestMapping("/proNotice")
public class ProNoticeDeleteController extends BaseController {

	@PostMapping("deleteNotice.do")
	public String deleteNotice(
		@RequestParam("proId") String proId
		, @ModelAttribute("notice") ProNoticeVO pronotice
		, Model model
		, RedirectAttributes redirectAttr
	) {
		ServiceResult result = boardService.removeBoard(pronotice);

		String goPage = null;
		switch (result) {
		case FAILED:
			goPage = "board/projectnotice/projectNoticeView";
			break;
		case OK:
			goPage = "redirect:/proNotice/proNoticeList.do";
			redirectAttr.addAttribute("proId", proId);
			break;
		}

		return goPage;
	}

}
