package kr.or.ddit.projects.board.controller.servernotice;

import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.validate.groups.DeleteGroup;
import kr.or.ddit.vo.NotyMessageVO;

@Controller
public class ServerNoticeDeleteController extends BaseController{
	@RequestMapping(value="/serverNotice/serverNoticeDelete.do", method=RequestMethod.POST)
	public String delete(
		@RequestParam("proId") String proId
		, @Validated(DeleteGroup.class) BoardVO boardVO
		, Errors errors
		, RedirectAttributes redirectAttributes
		, @RequestParam(value="mng", required=false, defaultValue="N") String mng
	){
		String goPage = "redirect:/serverNotice/serverNoticeView.do?boardNo="+boardVO.getBoardNo();
		NotyMessageVO message = null;
		
		if(!errors.hasErrors()) {
			ServiceResult result = boardService.removeBoard(boardVO);
			switch (result) {
			case FAILED:
				message = NotyMessageVO.builder("서버 오류")
										.build();
				break;
			default:
				goPage = "redirect:/serverNotice/serverNoticeList.do";
				redirectAttributes.addAttribute("proId", proId);
				redirectAttributes.addAttribute("mng", mng);
				break;
			}
			
		}else {
			message = NotyMessageVO.builder("누락된 내용이 있는지 확인해주세요.").build();
		}	
		if(message!=null) redirectAttributes.addFlashAttribute("message", message);
		return goPage;
	}
}
