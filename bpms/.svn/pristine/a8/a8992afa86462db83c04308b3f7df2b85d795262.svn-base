package kr.or.ddit.projects.schedule.controller;

import javax.validation.Valid;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.schedule.vo.CalendarVO;

@Controller
@RequestMapping("/schedule")
public class ScheduleInsertController extends BaseController {

	@RequestMapping("insertSchedule.do")
	public void scheduleInsert(@Valid @ModelAttribute("schedule") CalendarVO calendarVO,
			@AuthenticationPrincipal(expression = "realMember") MemberVO authMember,
			Model model) {
		scheduleService.personalInsertSchedule(calendarVO);
	}
	@RequestMapping(value = "insertSchedule.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String scheduleInsertAjax(@ModelAttribute("schedule") CalendarVO calendarVO,
			@AuthenticationPrincipal(expression = "realMember") MemberVO authMember,
			Model model) {
		scheduleInsert(calendarVO, authMember, model);
		return "jsonView";
	}
}
