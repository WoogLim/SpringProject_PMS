package kr.or.ddit.projects.schedule.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.poi.hpsf.Date;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.board.view.ExcelDownloadViewWithJxls;
import kr.or.ddit.projects.schedule.vo.CalendarVO;
import kr.or.ddit.projects.schedule.vo.GanttVO;
import kr.or.ddit.projects.schedule.vo.ScheduleVO;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.vo.CustomInfoVO;

@Controller
public class ScheduleRetrieveController extends BaseController {
	@Inject
	private WebApplicationContext container;
	
	//--간트 차트--////////////////////////////////////////////////////////////////////////////////
	public void customInfoList(Model model) {
		// 일감 우선 순위 커스텀 정보
		CustomInfoVO wrCustom = new CustomInfoVO();
		// 일감 유형 커스텀 정보
		CustomInfoVO wtCustom = new CustomInfoVO();
		// 일감 상태 커스텀 정보
		CustomInfoVO wsCustom = new CustomInfoVO();

		wrCustom.setGroupCode(WorkVO.WRGROUPCODE);
		wtCustom.setGroupCode(WorkVO.WTGROUPCODE);
		wsCustom.setGroupCode(WorkVO.WSGROUPCODE);

		List<CustomInfoVO> wrCustomList = customInfoService.retrieveCustomInfoList(wrCustom);
		List<CustomInfoVO> wtCustomList = customInfoService.retrieveCustomInfoList(wtCustom);
		List<CustomInfoVO> wsCustomList = customInfoService.retrieveCustomInfoList(wsCustom);

		model.addAttribute("wrCustomList", wrCustomList);
		model.addAttribute("wtCustomList", wtCustomList);
		model.addAttribute("wsCustomList", wsCustomList);
	}	
	@RequestMapping("gantt/ganttList.do")
	public String ganttList(
			@ModelAttribute("scheduleVO") ScheduleVO<GanttVO> scheduleVO, 
			@ModelAttribute("ganttVO") GanttVO ganttVO,
			Model model) {
		
		scheduleVO.setSearchDetail(ganttVO);
		customInfoList(model);
		scheduleVO.setScheduleList(scheduleService.ganttList(scheduleVO));
		model.addAttribute("scheduleVO", scheduleVO);
		
		return "schedule/ganttList";
	}	
	@RequestMapping(value="gantt/ganttList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String ganttListAjax(
			@ModelAttribute("scheduleVO") ScheduleVO<GanttVO> scheduleVO, 
			@ModelAttribute("ganttVO") GanttVO ganttVO,
			Model model) {
		
		ganttList(scheduleVO, ganttVO, model);
		
		return "jsonView";
	}	
	@RequestMapping("gantt/ganttView.do")
	public String ganttView(
			@RequestParam("no") int workId,
			@ModelAttribute("ganttVO") GanttVO ganttVO,
			Model model) {
		
		ganttVO.setWorkId(workId);
		ganttVO = scheduleService.ganttView(ganttVO);
		model.addAttribute("ganttVO", ganttVO);
		
		return "project/schedule/ajax/scheduleView";
	}
	
	
	
	//--캘린더--////////////////////////////////////////////////////////////////////////////////
	@RequestMapping("schedule/calendarList.do")
	public String calendarList(
			@ModelAttribute("scheduleVO") ScheduleVO<CalendarVO> scheduleVO,
			Model model) {
		
		scheduleVO.setScheduleList(scheduleService.calendarList(scheduleVO));
		scheduleVO.setPersonalScheduleList(scheduleService.personalScheduleList(scheduleVO));
		model.addAttribute("scheduleVO", scheduleVO);
		
		return "schedule/calendarList";
	}
	
	@RequestMapping(value="schedule/calendarList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String calendarListAjax(@ModelAttribute("scheduleVO") ScheduleVO<CalendarVO> scheduleVO, 
			Model model) {
		
		calendarList(scheduleVO, model);
		
		return "jsonView";
	}
	
	@RequestMapping(value="schedule/calendarExcelDown.do")
	public ExcelDownloadViewWithJxls calendarExcelDownload(
			@ModelAttribute("scheduleVO") ScheduleVO<CalendarVO> scheduleVO,
			Model model) {
		
		calendarList(scheduleVO, model);
		model.addAttribute("scheduleVO", scheduleVO);
        
		return new ExcelDownloadViewWithJxls() {
			@Override
			public String getDownloadFileName() {
				return "캘리더.xlsx";
			}
			
			@Override
			public Resource getJxlsTemplate() throws IOException {
				return container.getResource("/WEB-INF/jxlstmpl/calendarTemplate.xlsx");
			}
		};
	}
	//////////////////////////////////////////////////////////////////////////////////////
}
