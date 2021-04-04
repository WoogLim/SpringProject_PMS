package kr.or.ddit.projects.schedule.controller;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.schedule.vo.CalendarVO;

@Controller
@RequestMapping("/schedule")
public class ScheduleDeleteController extends BaseController {
	
	//캘린더 일감 삭제
	@RequestMapping("calendarDeleteWork.do")
	public void calendarDeleteWork(@ModelAttribute("schedule") CalendarVO calendarVO, Model model) {
		scheduleService.calendarDeleteWork(calendarVO);		
	}
	@RequestMapping(value="calendarDeleteWork.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String calendarDeleteWorkAjax(@ModelAttribute("schedule") CalendarVO calendarVO, Model model) {
		calendarDeleteWork(calendarVO, model);
		return "jsonView";
	}
	
	//캘린더 이슈 삭제
	@RequestMapping("calendarDeleteIssue.do")
	public void calendarDeleteIssue(@ModelAttribute("schedule") CalendarVO calendarVO, Model model) {
		scheduleService.calendarDeleteIssue(calendarVO);		
	}
	@RequestMapping(value="calendarDeleteIssue.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String calendarDeleteIssueAjax(@ModelAttribute("schedule") CalendarVO calendarVO, Model model) {
		calendarDeleteIssue(calendarVO, model);
		return "jsonView";
	}

	//캘린더 일정 삭제
	@RequestMapping("deleteSchedule.do")
	public void personalDeleteSchedule(@ModelAttribute("schedule") CalendarVO calendarVO, Model model) {
		scheduleService.personalDeleteSchedule(calendarVO);
	}
	@RequestMapping(value = "deleteSchedule.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String personalDeleteScheduleAjax(@ModelAttribute("schedule") CalendarVO calendarVO, Model model) {
		personalDeleteSchedule(calendarVO, model);
		return "jsonView";
	}

}
