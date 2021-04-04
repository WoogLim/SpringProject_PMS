package kr.or.ddit.projects.pushmsg.controller;

import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.pushmsg.vo.PushMessageVO;
import kr.or.ddit.vo.NotyMessageVO;

/**
 * @author 신광진
 * @since 2021. 1. 29.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 1. 29.     신광진       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Controller
public class PushMsgController extends BaseController {

	// 프로젝트 거절 푸시메시지 생성
	@RequestMapping(value="/pushMsg/rejectMsgInsert.do")
	public String createProjectRejectMessage(PushMessageVO pushMsgVO, ProjectVO projectVO, RedirectAttributes redirectAtts) {
		NotyMessageVO message = SIMPLE_SUCCESS_MESSAGE_FOR_CLIENT;
		try {
			pushMsgService.createProjectRejectMsg(pushMsgVO, projectVO);
		} catch(DataAccessException | CustomException e) {
			message = EXCEPTION_MESSAGE_FOR_CLIENT;
		}
		
		redirectAtts.addFlashAttribute("message", message);
		return "redirect:/admin/project/requestProjectList.do";
	}
	
	// 푸시메시지 생성
	@PostMapping("/pushMsg/insert.do")
	public String createPushMessage(PushMessageVO pushMsgVO, ProjectVO projectVO, RedirectAttributes redirectAtts) {
		return null;
	}
	
	// 푸시메시지 수정
	@RequestMapping(value="/pushMsg/update.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String updatePushMessage(PushMessageVO pushMsgVO, Model model) {
		NotyMessageVO message = SUCCESS_AJAX_COMMAND;
		int count = 0;
		try {
			count = pushMsgService.modifyPushMsg(pushMsgVO);
		} catch(DataAccessException e) {
			message = FAILED_AJAX_COMMAND;
		} catch(CustomException e) {
			message = FAILED_AJAX_COMMAND;
		}
		model.addAttribute("message", message);
		model.addAttribute("count", count);
		return "jsonView";
	}
	
	// 푸시메시지 삭제
	@RequestMapping("/pushMsg/delete.do")
	public String deletePushMessage(
			MemberVO memberVO
			, RedirectAttributes redirectAtts
			, PushMessageVO searchDetail
			)
	{
		NotyMessageVO message = SUCCESS_REMOVE_PUSH_MESSAGE;
		String goPage = "redirect:/member/mymessage";
		try {
			pushMsgService.removePushMsg(memberVO);
		} catch(DataAccessException e) {
			message = FAILED_REMOVE_PUSH_MESSAGE;
		} catch(CustomException e) {
			message = FAILED_REMOVE_PUSH_MESSAGE;
		}
		redirectAtts.addFlashAttribute("message", message);
		redirectAtts.addFlashAttribute("searchDetail", searchDetail);
		return goPage;
	}
	
}




