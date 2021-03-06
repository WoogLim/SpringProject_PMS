package kr.or.ddit.projects.board.controller.servernotice;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
import kr.or.ddit.projects.board.vo.ServerNoticeVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.validate.groups.InsertGroup;
import kr.or.ddit.vo.NotyMessageVO;

@Controller
@RequestMapping("/serverNotice/serverNoticeInsert.do")
public class ServerNoticeInsertController extends BaseController {
	
	@GetMapping
	public String form(@AuthenticationPrincipal(expression="realMember") MemberVO memberVO
					, @RequestParam(value="mng", required=false, defaultValue="N") String mng) {
		
		String goPage = "serverNotice/serverNoticeForm";
		if("Y".equals(mng)) {
			goPage = "admin/serverNotice/serverNoticeForm";
		}
		return goPage;
	}

	@PostMapping
	public String insert(
		@AuthenticationPrincipal(expression="realMember") MemberVO memberVO
		, @RequestParam("proId") String proId
		, @Validated(InsertGroup.class) @ModelAttribute("boardVO") ServerNoticeVO boardVO
		, Model model
		, RedirectAttributes redirectAttr
		, @RequestParam(value="mng", required=false, defaultValue="N") String mng
	){
		String goPage = null;
		boardVO.setBoardWriter(memberVO.getMemName());
		boardVO.setCode(6);
		boardVO.setGroupCode("B");
		ServiceResult result = boardService.createBoard(boardVO);
		switch (result) {
		case OK:
			goPage = "redirect:/serverNotice/serverNoticeView.do?boardNo=" + boardVO.getBoardNo();
			redirectAttr.addAttribute("proId", proId);
			redirectAttr.addAttribute("mng", mng);
			break;
		case FAILED:
			goPage = "serverNotice/serverNoticeForm";
			break;
		}
		return goPage;
	}
}
