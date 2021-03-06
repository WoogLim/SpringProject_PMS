package kr.or.ddit.projects.schedule.controller;

import javax.validation.Valid;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.schedule.vo.CalendarVO;

@Controller
@RequestMapping("/schedule")
public class ScheduleUpdateController extends BaseController {

	//캘린더 이슈 업데이트
	@RequestMapping("calendarUpdateIssue.do")
	@Transactional
	public void calendarUpdateIssue(@Valid @ModelAttribute("schedule") CalendarVO calendarVO, Model model) {
		scheduleService.calendarUpdateIssue(calendarVO);
		scheduleService.calendarUpdateBoard(calendarVO);
	}	
	@RequestMapping(value="calendarUpdateIssue.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String calendarUpdateIssueAjax(@ModelAttribute("schedule") CalendarVO calendarVO, Model model) {
		calendarUpdateIssue(calendarVO, model);
		return "jsonView";
	}
	
	//캘린더 일감 업데이트
	@RequestMapping("calendarUpdateWork.do")
	@Transactional
	public void calendarUpdateWork(@Valid @ModelAttribute("schedule") CalendarVO calendarVO, Model model) {
		scheduleService.calendarUpdateWork(calendarVO);
		scheduleService.calendarUpdateBoard(calendarVO);
	}	
	@RequestMapping(value="calendarUpdateWork.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String calendarUpdateWorkAjax(@ModelAttribute("schedule") CalendarVO calendarVO, Model model) {
		calendarUpdateWork(calendarVO, model);
		return "jsonView";
	}
	
	//캘린더 일정 업데이트
	@RequestMapping("updateSchedule.do")
	public void personalUpdateSchedule(@Valid @ModelAttribute("schedule") CalendarVO calendarVO, Model model) {
		scheduleService.personalUpdateSchedule(calendarVO);
	}
	@RequestMapping(value = "updateSchedule.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String personalUpdateScheduleAjax(@ModelAttribute("schedule") CalendarVO calendarVO, Model model) {
		personalUpdateSchedule(calendarVO, model);
		return "jsonView";
	}
}
