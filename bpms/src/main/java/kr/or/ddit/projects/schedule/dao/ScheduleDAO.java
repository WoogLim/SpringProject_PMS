package kr.or.ddit.projects.schedule.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.projects.schedule.vo.CalendarVO;
import kr.or.ddit.projects.schedule.vo.GanttVO;
import kr.or.ddit.projects.schedule.vo.ScheduleVO;

@Repository
public interface ScheduleDAO {

	public List<GanttVO> ganttList(ScheduleVO<GanttVO> scheduleVO);

	public GanttVO ganttView(GanttVO ganttVO);
	
	public List<CalendarVO> calendarList(ScheduleVO<CalendarVO> scheduleVO);

	public List<CalendarVO> personalScheduleList(ScheduleVO<CalendarVO> scheduleVO);
	
	public void calendarUpdateBoard(CalendarVO calendarVO);
	public void calendarUpdateWork(CalendarVO calendarVO);
	public void calendarDeleteWork(CalendarVO calendarVO);
	public void calendarUpdateIssue(CalendarVO calendarVO);
	public void calendarDeleteIssue(CalendarVO calendarVO);

	public void personalInsertSchedule(CalendarVO calendarVO);

	public void personalUpdateSchedule(CalendarVO calendarVO);

	public void personalDeleteSchedule(CalendarVO calendarVO);
}
