<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/includee/preScript.jsp"></jsp:include>
<style type="text/css">
#calendarExcelDown{
	width : 140px;
	height : 40px;
	border-radius: 20px;
	font-size: 14px;
	margin-left: 10px;
}
</style>
</head>
<body>
<security:authentication property="principal" var="principal"/>
<c:set var="authMember" value="${principal.realMember }" />
<c:set var="proId" value="${scheduleVO.proId }" />
<c:set var="scheduleList" value="${scheduleVO.scheduleList }" />
<c:set var="personalScheduleList" value="${scheduleVO.personalScheduleList }" />
<div class="panel-header">
	<div class="page-inner">
		<span class="project-path">
			<a href="">프로젝트</a>
			<a href="">PMS 프로그램 개발</a>
		</span>
		
		<div class="header clearfix">
			<div class="float-left">
				<h1 class="fw-mediumbold"> 캘린더</h1>
			</div>
		</div>
		
		<div id="right">
			<div id="menu">
			    <span class="dropdown">
			        <button id="dropdownMenu-calendarType" class="calbtn btn-default btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
			            <i id="calendarTypeIcon" class="calendar-icon ic_view_month" style="margin-right: 4px;"></i>
			            <span id="calendarTypeName">Dropdown</span>&nbsp;
		            </button>
		            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu-calendarType">
		                <li role="presentation">
		                    <a class="dropdown-menu-title" role="menuitem" data-action="toggle-daily">
		                        <i class="calendar-icon ic_view_day"></i>Daily
		                    </a>
		                </li>
		                <li role="presentation">
		                    <a class="dropdown-menu-title" role="menuitem" data-action="toggle-weekly">
		                        <i class="calendar-icon ic_view_week"></i>Weekly
		                    </a>
		                </li>
		                <li role="presentation">
		                    <a class="dropdown-menu-title" role="menuitem" data-action="toggle-monthly">
		                        <i class="calendar-icon ic_view_month"></i>Month
		                    </a>
		                </li>
		                <li role="presentation">
		                    <a class="dropdown-menu-title" role="menuitem" data-action="toggle-weeks2">
		                        <i class="calendar-icon ic_view_week"></i>2 weeks
		                    </a>
		                </li>
		                <li role="presentation">
		                    <a class="dropdown-menu-title" role="menuitem" data-action="toggle-weeks3">
		                        <i class="calendar-icon ic_view_week"></i>3 weeks
		                    </a>
		                </li>
		                <li role="presentation" class="dropdown-divider"></li>
		                <li role="presentation">
		                    <a role="menuitem" data-action="toggle-workweek">
		                        <input type="checkbox" class="tui-full-calendar-checkbox-square" value="toggle-workweek" checked>
		                        <span class="checkbox-title"></span>Show weekends
		                    </a>
		                </li>
		                <li role="presentation">
		                    <a role="menuitem" data-action="toggle-start-day-1">
		                        <input type="checkbox" class="tui-full-calendar-checkbox-square" value="toggle-start-day-1">
		                        <span class="checkbox-title"></span>Start Week on Monday
		                    </a>
		                </li>
		                <li role="presentation">
		                    <a role="menuitem" data-action="toggle-narrow-weekend">
		                        <input type="checkbox" class="tui-full-calendar-checkbox-square" value="toggle-narrow-weekend">
		                        <span class="checkbox-title"></span>Narrower than weekdays
		                    </a>
		                </li>
		            </ul>
				</span>
				<span id="menu-navi">
		            <button type="button" class="calbtn btn-default btn-sm move-today" data-action="move-today">Today</button>
		            <button type="button" class="calbtn btn-default btn-sm move-day" data-action="move-prev">
		                <i class="calendar-icon ic-arrow-line-left" data-action="move-prev"></i>
		            </button>
		            <button type="button" class="calbtn btn-default btn-sm move-day" data-action="move-next">
		                <i class="calendar-icon ic-arrow-line-right" data-action="move-next"></i>
		            </button>
				</span>
				<span id="renderRange" class="render-range"></span>
		    </div>
		    
		    
			<div id="lnb-calendars" class="lnb-calendars d-flex flex-row-reverse">
	            <div>
	                <div class="lnb-calendars-item">
	                    <label>
	                        <input class="tui-full-calendar-checkbox-square" type="checkbox" value="all" checked>
	                        <span></span>
	                        <strong>View all</strong>
	                    </label>
			            <div id="calendarList" class="lnb-calendars-d1">
			            </div>
	                </div>
	            </div>
	        </div>
	        
	        
			<div class="lnb-new-schedule d-flex flex-row-reverse">
        		<a id="calendarExcelDown" class="btn btn-primary float-right" href="#">엑셀 다운로드</a>
            	<button id="btn-new-schedule" type="button" class="btn btn-default btn-block lnb-new-schedule-btn">
                New schedule</button>
        	</div>
		    <div id="calendar"></div>
		</div>
	</div>
</div>
<form id="calHiddenForm">
	<input type="hidden" name="calId">
	<input type="hidden" name="boardTitle">
	<input type="hidden" name="calLocation">
	<input type="hidden" name="startDate">
	<input type="hidden" name="endDate">
	<input type="hidden" name="director">
	<input type="hidden" name="proId">
</form>
<script src="https://uicdn.toast.com/tui.code-snippet/v1.5.2/tui-code-snippet.min.js"></script>
<script src="https://uicdn.toast.com/tui.time-picker/v2.0.3/tui-time-picker.min.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/v4.0.3/tui-date-picker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.20.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/chance/1.0.13/chance.min.js"></script>
<script src="${pageContext.request.contextPath }/js/schedule/calendar/tui-calendar.js"></script>
<script src="${pageContext.request.contextPath }/js/schedule/calendar/js/data/calendars.js"></script>
<script src="${pageContext.request.contextPath }/js/schedule/calendar/js/data/schedules.js"></script>
<script type="text/javascript">
let loginId = "${authMember.memId}";
let proId = "${proId}"
let calHiddenForm = $("#calHiddenForm");
var ScheduleList = [];

$("#calendarExcelDown").on("click", function(){
	let requestURL = "${cPath}/schedule/calendarExcelDown.do?proId="+proId;
	$(this).attr("href", requestURL);
	return true;
});

function scheduleList(calendar, renderStart, renderEnd){
	var calStart;
	var calEnd;

	<c:forEach items="${scheduleList}" var="calendar">
		var schedule = new ScheduleInfo();
	
		schedule.id = "${calendar.calId }";
		schedule.calendarId = "${calendar.code}";
		schedule.title = "${calendar.boardTitle }";
		schedule.body = "${calendar.boardContent }";
		schedule.category = "allday";
		calStart = ${calendar.startDate};
		schedule.start = new Date(calStart*1000);
		calEnd = ${calendar.endDate*1000};
		schedule.end = new Date(calEnd);
		schedule.attendees = "${calendar.director}";
		schedule.color = calendar.color;
	    schedule.bgColor = calendar.bgColor;
	    schedule.dragBgColor = calendar.dragBgColor;
	    schedule.borderColor = calendar.borderColor;
	    if(loginId!="${calendar.director}"){
	    	schedule.isReadOnly = true;
	    }
	    
	    ScheduleList.push(schedule);
	</c:forEach>
	
	<c:forEach items="${personalScheduleList}" var="personalCalendar">
		var schedule = new ScheduleInfo();
		
		schedule.id = "${personalCalendar.calId }";
		schedule.calendarId = "4";
		schedule.title = "${personalCalendar.boardTitle }";
		schedule.body = "";
		schedule.category = "allday";
		calStart = ${personalCalendar.startDate};
		schedule.start = new Date(calStart);
		calEnd = ${personalCalendar.endDate};
		schedule.end = new Date(calEnd);
		schedule.attendees = "${personalCalendar.director}";
		schedule.location = "${personalCalendar.calLocation}";
		schedule.color = calendar.color;
	    schedule.bgColor = calendar.bgColor;
	    schedule.dragBgColor = calendar.dragBgColor;
	    schedule.borderColor = calendar.borderColor;
	    if(loginId!="${personalCalendar.director}"){
	    	schedule.isReadOnly = true;
	    }
	    
	    ScheduleList.push(schedule);
	</c:forEach>
}

function generateSchedule(viewName, renderStart, renderEnd) {
	ScheduleList = [];
	scheduleList(calendar, renderStart, renderEnd)
};
</script>
<script src="${pageContext.request.contextPath }/js/schedule/calendar/js/app.js"></script>
</body>
</html>