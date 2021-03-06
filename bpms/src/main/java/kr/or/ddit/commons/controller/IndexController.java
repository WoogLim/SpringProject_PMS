package kr.or.ddit.commons.controller;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.kanban.vo.KanbanVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.pushmsg.vo.PushMessageVO;

@Controller
public class IndexController extends BaseController {

	@GetMapping("/")
	public String index() {
//		return "index";
		
		// index페이지 제작 후 URL 변경
		return "redirect:/index";
	}
	
	@RequestMapping("/index")
	public String loginForm() {
		return "BPMSIndex";
	}

	@GetMapping("/user/adminCheck.do")
	public String amdinCheck(@AuthenticationPrincipal(expression = "realMember") MemberVO memberVO, Model model) {
		String userRole = memberVO.getAdminRole();
		String goPage = null;
		if("Y".equals(userRole)) {
			goPage = "redirect:/admin/main";
		}else {
			goPage = "redirect:/user/main";
		}
		return goPage;
	}
	
	@GetMapping("/admin/main")
	public String adminHome(@AuthenticationPrincipal(expression = "realMember") MemberVO memberVO, Model model) {
		
		List<ProjectVO> projectList = adminProjectService.retrieveProjectListForMain();
		model.addAttribute("projectList", projectList);

		List<ProjectVO> reqProjectList = adminProjectService.retrieveRequestProjectList();
		model.addAttribute("reqProjectList", reqProjectList);

		List<BoardVO> serverNoticeList = boardService.retrieveBoardListForMain();
		model.addAttribute("serverNoticeList", serverNoticeList);

		List<MemberVO> memberList = adminMemberService.retrieveMemberListForMain();
		model.addAttribute("memberList", memberList);

		getPushMsgList(memberVO);
		return "admin/main/adminMain";
	}

	@GetMapping("/user/main")
	public String userHome(@AuthenticationPrincipal(expression = "realMember") MemberVO memberVO, Model model) {

		List<ProjectVO> projectList = userMemberService.retrieveMemberProjectList(memberVO);
		model.addAttribute("projectList", projectList);

		List<ProjectVO> projectNoticeList = userMemberService.retrieveProjectNoticeList(memberVO);
		model.addAttribute("projectNoticeList", projectNoticeList);

		List<KanbanVO> kanbanList = kanbanService.retrieveKanbanList(memberVO);
		model.addAttribute("kanbanList", kanbanList);

		getPushMsgList(memberVO);
		return "main/userMain";
	}

	private void getPushMsgList(MemberVO memberVO) {
		List<PushMessageVO> unConfirmedPushMsgList = pushMsgService.retrieveUnConfirmedPushMsgList(memberVO);
		memberVO.setPushMsgList(unConfirmedPushMsgList);
		
		int unConfirmedPushMsgCount = pushMsgService.retrieveUnConfimedPushMsgCount(memberVO);
		memberVO.setUnConfirmedPushMsgCount(unConfirmedPushMsgCount);
	}
}
