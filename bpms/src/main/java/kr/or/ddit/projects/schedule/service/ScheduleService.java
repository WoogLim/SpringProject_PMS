package kr.or.ddit.projects.schedule.service;

import java.util.List;

import kr.or.ddit.projects.schedule.vo.CalendarVO;
import kr.or.ddit.projects.schedule.vo.GanttVO;
import kr.or.ddit.projects.schedule.vo.ScheduleVO;

public interface ScheduleService {

	//간트차트
	public List<GanttVO> ganttList(ScheduleVO<GanttVO> scheduleVO);
	public GanttVO ganttView(GanttVO ganttVO);
	//
	public List<CalendarVO> calendarList(ScheduleVO<CalendarVO> scheduleVO);
	public List<CalendarVO> personalScheduleList(ScheduleVO<CalendarVO> scheduleVO);
	public void calendarUpdateBoard(CalendarVO calendarVO);
	//일감
	public void calendarUpdateWork(CalendarVO calendarVO);
	public void calendarDeleteWork(CalendarVO calendarVO);
	//이슈
	public void calendarUpdateIssue(CalendarVO calendarVO);
	public void calendarDeleteIssue(CalendarVO calendarVO);
	//개인 일정
	public void personalInsertSchedule(CalendarVO calendarVO);
	public void personalUpdateSchedule(CalendarVO calendarVO);
	public void personalDeleteSchedule(CalendarVO calendarVO);
}
