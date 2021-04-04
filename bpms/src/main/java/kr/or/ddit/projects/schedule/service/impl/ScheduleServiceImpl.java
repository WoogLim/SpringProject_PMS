package kr.or.ddit.projects.schedule.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.schedule.service.ScheduleService;
import kr.or.ddit.projects.schedule.vo.CalendarVO;
import kr.or.ddit.projects.schedule.vo.GanttVO;
import kr.or.ddit.projects.schedule.vo.ScheduleVO;

@Service
public class ScheduleServiceImpl extends BaseService implements ScheduleService {

	@Override
	public List<GanttVO> ganttList(ScheduleVO<GanttVO> scheduleVO) {
		return scheduleDAO.ganttList(scheduleVO);
	}

	@Override
	public GanttVO ganttView(GanttVO ganttVO) {
		return scheduleDAO.ganttView(ganttVO);
	}

	public List<CalendarVO> calendarList(ScheduleVO<CalendarVO> scheduleVO) {
		return scheduleDAO.calendarList(scheduleVO);
	}

	@Override
	public void calendarUpdateBoard(CalendarVO calendarVO) {
		scheduleDAO.calendarUpdateBoard(calendarVO);
		
	}
	
	@Override
	public void calendarUpdateWork(CalendarVO calendarVO) {
		scheduleDAO.calendarUpdateWork(calendarVO);
		
	}
	
	@Override
	public void calendarDeleteWork(CalendarVO calendarVO) {
		scheduleDAO.calendarDeleteWork(calendarVO);
		
	}
	
	@Override
	public void calendarUpdateIssue(CalendarVO calendarVO) {
		scheduleDAO.calendarUpdateIssue(calendarVO);
		
	}
	
	@Override
	public void calendarDeleteIssue(CalendarVO calendarVO) {
		scheduleDAO.calendarDeleteIssue(calendarVO);
		
	}
	
	@Override
	public List<CalendarVO> personalScheduleList(ScheduleVO<CalendarVO> scheduleVO) {
		return scheduleDAO.personalScheduleList(scheduleVO);
	}

	@Override
	public void personalInsertSchedule(CalendarVO calendarVO) {
		scheduleDAO.personalInsertSchedule(calendarVO);

	}

	@Override
	public void personalUpdateSchedule(CalendarVO calendarVO) {
		scheduleDAO.personalUpdateSchedule(calendarVO);

	}

	@Override
	public void personalDeleteSchedule(CalendarVO calendarVO) {
		scheduleDAO.personalDeleteSchedule(calendarVO);

	}
}
