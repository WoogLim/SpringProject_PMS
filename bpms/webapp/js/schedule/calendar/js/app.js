'use strict';

(function(window, Calendar) {
    var cal, resizeThrottled;
    var useCreationPopup = true;
    var useDetailPopup = true;
    var datePicker, selectedCalendar;

    cal = new Calendar('#calendar', {
        defaultView: 'month',
        month: {
            isAlways6Week: false
        },
        useCreationPopup: useCreationPopup,
        useDetailPopup: useDetailPopup,
        calendars: CalendarList,
        template: {
            milestone: function(model) {
                return '<span class="calendar-font-icon ic-milestone-b"></span> <span style="background-color: ' + model.bgColor + '">' + model.title + '</span>';
            },
            allday: function(schedule) {
                return getTimeTemplate(schedule, true);
            },
            time: function(schedule) {
                return getTimeTemplate(schedule, false);
            }
        }
    });

    // event handlers
    cal.on({
        'clickMore': function(e) {
            console.log('clickMore', e);
        },
        'clickSchedule': function(e) {
        	document.getElementById("calendar").addEventListener("click", hideButtons);
        	function hideButtons(){
        		var delete_buttons = document.getElementsByClassName("tui-full-calendar-popup-delete")[0];
        		var edit_buttons = document.getElementsByClassName("tui-full-calendar-popup-edit")[0];
        		var line = document.getElementsByClassName("tui-full-calendar-popup-vertical-line")[0];

            }
        },
        'clickDayname': function(date) {
            console.log('clickDayname', date);
        },
        
        // New Schedule 등록 시 동작
        'beforeCreateSchedule': function(e) {
	        saveNewSchedule(e)
        },
        
        // edit 클릭 시 동작
        'beforeUpdateSchedule': function(e) {
            var schedule = e.schedule;
            var changes = e.changes;
            
            if (changes && !changes.isAllDay && schedule.category === 'allday') {
                changes.category = 'time';
            }
            
            let startDate = e.schedule.start.getTime();
            let endDate = e.schedule.end.getTime();
            let changeStartDate = e.changes.start ? (e.changes.start.getTime()) : "";
            let changeEndDate = e.changes.end ? (e.changes.end.getTime()) : "";
            
            if(e.schedule.calendarId=="2"){
            	calHiddenForm.find("[name='calId']").val(e.schedule.id);
            	calHiddenForm.find("[name='boardTitle']").val(e.changes.title ? e.changes.title : e.schedule.title);
            	calHiddenForm.find("[name='calLocation']").val("");
            	calHiddenForm.find("[name='startDate']").val(changeStartDate ? changeStartDate : startDate);
            	calHiddenForm.find("[name='endDate']").val(changeEndDate ? changeEndDate : endDate);
            	
            	let calupdate = $("#calHiddenForm").ajaxForm({
            		dataType:"json",
            		url:"calendarUpdateIssue.do",
            		success:function(){
            			console.log("update success");
            		}
            	}).submit();
            	cal.updateSchedule(schedule.id, schedule.calendarId, changes);
            	refreshScheduleVisibility();
        	}
        	
        	if(e.schedule.calendarId=="3"){
        		calHiddenForm.find("[name='calId']").val(e.schedule.id);
            	calHiddenForm.find("[name='boardTitle']").val(e.changes.title ? e.changes.title : e.schedule.title);
            	calHiddenForm.find("[name='calLocation']").val("");
            	calHiddenForm.find("[name='startDate']").val(changeStartDate ? changeStartDate : startDate);
            	calHiddenForm.find("[name='endDate']").val(changeEndDate ? changeEndDate : endDate);
            	
            	let calupdate = $("#calHiddenForm").ajaxForm({
            		dataType:"json",
            		url:"calendarUpdateWork.do",
            		success:function(){
            			console.log("update success");
            		}
            	}).submit();
            	cal.updateSchedule(schedule.id, schedule.calendarId, changes);
            	refreshScheduleVisibility();
        	}

            if(e.schedule.calendarId=="4"){
            	calHiddenForm.find("[name='calId']").val(e.schedule.id);
            	calHiddenForm.find("[name='boardTitle']").val(e.changes.title ? e.changes.title : e.schedule.title);
            	calHiddenForm.find("[name='calLocation']").val(e.changes.location ? e.changes.location : e.schedule.location);
            	calHiddenForm.find("[name='startDate']").val(changeStartDate ? changeStartDate : startDate);
            	calHiddenForm.find("[name='endDate']").val(changeEndDate ? changeEndDate : endDate);
            	
            	let calupdate = $("#calHiddenForm").ajaxForm({
            		dataType:"json",
            		url:"updateSchedule.do",
            		success:function(){
            			console.log("update success");
            		}
            	}).submit();
            	cal.updateSchedule(schedule.id, schedule.calendarId, changes);
            	refreshScheduleVisibility();
            }            
        },
        
        // delete 클릭 시 동작
        'beforeDeleteSchedule': function(e) {
        	if(e.schedule.calendarId=="2"){
        		calHiddenForm.find("[name='calId']").val(e.schedule.id);
        		let IWdelete = $("#calHiddenForm").ajaxForm({
        			dataType:"json",
        			url:"calendarDeleteIssue.do",
        			success:function(){
        				console.log("issue delete success");
        			}
        		}).submit();
        		cal.deleteSchedule(e.schedule.id, e.schedule.calendarId);
        	}
        	
        	if(e.schedule.calendarId=="3"){
	        	calHiddenForm.find("[name='calId']").val(e.schedule.id);
        		let IWdelete = $("#calHiddenForm").ajaxForm({
        			dataType:"json",
        			url:"calendarDeleteWork.do",
        			success:function(){
        				console.log("work delete success");
        			}
        		}).submit();
        		cal.deleteSchedule(e.schedule.id, e.schedule.calendarId);
        	}
        	
            if(e.schedule.calendarId=="4"){
            	calHiddenForm.find("[name='calId']").val(e.schedule.id);
            	let caldelete = $("#calHiddenForm").ajaxForm({
            		dataType:"json",
            		url:"deleteSchedule.do",
            		success:function(){
            			console.log("success");
            		}
            	}).submit();
            	cal.deleteSchedule(e.schedule.id, e.schedule.calendarId);
            }
        	
            
        },
        'afterRenderSchedule': function(e) {
            var schedule = e.schedule;
            // var element = cal.getElement(schedule.id, schedule.calendarId);
            // console.log('afterRenderSchedule', element);
        },
        'clickTimezonesCollapseBtn': function(timezonesCollapsed) {
            console.log('timezonesCollapsed', timezonesCollapsed);

            if (timezonesCollapsed) {
                cal.setTheme({
                    'week.daygridLeft.width': '77px',
                    'week.timegridLeft.width': '77px'
                });
            } else {
                cal.setTheme({
                    'week.daygridLeft.width': '60px',
                    'week.timegridLeft.width': '60px'
                });
            }

            return true;
        }
    });

    /**
	 * Get time template for time and all-day
	 * 
	 * @param {Schedule}
	 *            schedule - schedule
	 * @param {boolean}
	 *            isAllDay - isAllDay or hasMultiDates
	 * @returns {string}
	 */
    function getTimeTemplate(schedule, isAllDay) {
        var html = [];
        var start = moment(schedule.start.toUTCString());
        if (!isAllDay) {
            html.push('<strong>' + start.format('HH:mm') + '</strong> ');
        }
        if (schedule.isPrivate) {
            html.push('<span class="calendar-font-icon ic-lock-b"></span>');
            html.push(' Private');
        } else {
            if (schedule.is) {
                html.push('<span class="calendar-font-icon ic-readonly-b"></span>');
            } else if (schedule.recurrenceRule) {
                html.push('<span class="calendar-font-icon ic-repeat-b"></span>');
            } else if (schedule.attendees.length) {
                html.push('<span class="calendar-font-icon ic-user-b"></span>');
            } else if (schedule.location) {
                html.push('<span class="calendar-font-icon ic-location-b"></span>');
            }
            html.push(' ' + schedule.title);
        }

        return html.join('');
    }

    /**
	 * A listener for click the menu
	 * 
	 * @param {Event}
	 *            e - click event
	 */
    function onClickMenu(e) {
        var target = $(e.target).closest('a[role="menuitem"]')[0];
        var action = getDataAction(target);
        var options = cal.getOptions();
        var viewName = '';

        console.log(target);
        console.log(action);
        switch (action) {
            case 'toggle-daily':
                viewName = 'day';
                break;
            case 'toggle-weekly':
                viewName = 'week';
                break;
            case 'toggle-monthly':
                options.month.visibleWeeksCount = 0;
                viewName = 'month';
                break;
            case 'toggle-weeks2':
                options.month.visibleWeeksCount = 2;
                viewName = 'month';
                break;
            case 'toggle-weeks3':
                options.month.visibleWeeksCount = 3;
                viewName = 'month';
                break;
            case 'toggle-narrow-weekend':
                options.month.narrowWeekend = !options.month.narrowWeekend;
                options.week.narrowWeekend = !options.week.narrowWeekend;
                viewName = cal.getViewName();

                target.querySelector('input').checked = options.month.narrowWeekend;
                break;
            case 'toggle-start-day-1':
                options.month.startDayOfWeek = options.month.startDayOfWeek ? 0 : 1;
                options.week.startDayOfWeek = options.week.startDayOfWeek ? 0 : 1;
                viewName = cal.getViewName();

                target.querySelector('input').checked = options.month.startDayOfWeek;
                break;
            case 'toggle-workweek':
                options.month.workweek = !options.month.workweek;
                options.week.workweek = !options.week.workweek;
                viewName = cal.getViewName();

                target.querySelector('input').checked = !options.month.workweek;
                break;
            default:
                break;
        }

        cal.setOptions(options, true);
        cal.changeView(viewName, true);

        setDropdownCalendarType();
        setRenderRangeText();
    }

    function onClickNavi(e) {
        var action = getDataAction(e.target);

        switch (action) {
            case 'move-prev':
                cal.prev();
                break;
            case 'move-next':
                cal.next();
                break;
            case 'move-today':
                cal.today();
                break;
            default:
                return;
        }

        setRenderRangeText();
    }

    function onNewSchedule() {
        var title = $('#new-schedule-title').val();
        var location = $('#new-schedule-location').val();
        var isAllDay = document.getElementById('new-schedule-allday').checked;
        var start = datePicker.getStartDate();
        var end = datePicker.getEndDate();
        var calendar = selectedCalendar ? selectedCalendar : CalendarList[0];

        if (!title) {
            return;
        }
        
        cal.createSchedules([{
            id: String(chance.guid()),
            calendarId: calendar.id,
            title: title,
            isAllDay: isAllDay,
            start: start,
            end: end,
            attendees: loginId,
            category: isAllDay ? 'allday' : 'time',
            dueDateClass: '',
            color: calendar.color,
            bgColor: calendar.bgColor,
            dragBgColor: calendar.bgColor,
            borderColor: calendar.borderColor,
            raw: {
                location: location
            },
            state: 'Busy'
        }]);

        $('#modal-new-schedule').modal('hide');
    }

    function onChangeNewScheduleCalendar(e) {
        var target = $(e.target).closest('a[role="menuitem"]')[0];
        var calendarId = getDataAction(target);
        changeNewScheduleCalendar(calendarId);
    }

    function changeNewScheduleCalendar(calendarId) {
        var calendarNameElement = document.getElementById('calendarName');
        var calendar = findCalendar(calendarId);
        var html = [];

        html.push('<span class="calendar-bar" style="background-color: ' + calendar.bgColor + '; border-color:' + calendar.borderColor + ';"></span>');
        html.push('<span class="calendar-name">' + calendar.name + '</span>');

        calendarNameElement.innerHTML = html.join('');

        selectedCalendar = calendar;
    }

    function createNewSchedule(event) {
        var start = event.start ? new Date(event.start.getTime()) : new Date();
        var end = event.end ? new Date(event.end.getTime()) : moment().add(1, 'hours').toDate();

        if (useCreationPopup) {
            cal.openCreationPopup({
                start: start,
                end: end
            });
        }
    }
    
    function saveNewSchedule(scheduleData) {
        var calendar = scheduleData.calendar || findCalendar(scheduleData.calendarId);
        var schedule = {
            id: String(chance.guid()),
            title: scheduleData.title,
            isAllDay: scheduleData.isAllDay,
            start: scheduleData.start,
            end: scheduleData.end,
            attendees: loginId,
            category: scheduleData.isAllDay ? 'allday' : 'time',
            dueDateClass: '',
            color: calendar.color,
            bgColor: calendar.bgColor,
            dragBgColor: calendar.bgColor,
            borderColor: calendar.borderColor,
            location: scheduleData.location,
            raw: {
                class: scheduleData.raw['class']
            },
            state: scheduleData.state
        };
        if (calendar) {
            schedule.calendarId = calendar.id;
            schedule.color = calendar.color;
            schedule.bgColor = calendar.bgColor;
            schedule.borderColor = calendar.borderColor;
        }
        
        var startDate = scheduleData.start.getTime();
        var endDate = scheduleData.end.getTime();
        
        if(schedule.calendarId == '4'){
	        calHiddenForm.find("[name='boardTitle']").val(scheduleData.title);
	        calHiddenForm.find("[name='calLocation']").val(scheduleData.location);
	        calHiddenForm.find("[name='startDate']").val(startDate);
	        calHiddenForm.find("[name='endDate']").val(endDate);
	        calHiddenForm.find("[name='director']").val(loginId);
	        calHiddenForm.find("[name='proId']").val(proId);
	        
	        let calInsert = $("#calHiddenForm").ajaxForm({
	        	dataType:"json",
	        	url:"insertSchedule.do",
	        	success:function(){
	        		console.log("success");
	        	}
	        }).submit();
	
	        cal.createSchedules([schedule]);
	
	        refreshScheduleVisibility();
        }else{
        	alert("alert말고 error 모달로 수정 필요")
        }
    }

    function onChangeCalendars(e) {
        var calendarId = e.target.value;
        var checked = e.target.checked;
        var viewAll = document.querySelector('.lnb-calendars-item input');
        var calendarElements = Array.prototype.slice.call(document.querySelectorAll('#calendarList input'));
        var allCheckedCalendars = true;

        if (calendarId === 'all') {
            allCheckedCalendars = checked;

            calendarElements.forEach(function(input) {
                var span = input.parentNode;
                input.checked = checked;
                span.style.backgroundColor = checked ? span.style.borderColor : 'transparent';
            });

            CalendarList.forEach(function(calendar) {
                calendar.checked = checked;
            });
        } else {
            findCalendar(calendarId).checked = checked;

            allCheckedCalendars = calendarElements.every(function(input) {
                return input.checked;
            });

            if (allCheckedCalendars) {
                viewAll.checked = true;
            } else {
                viewAll.checked = false;
            }
        }

        refreshScheduleVisibility();
    }

    function refreshScheduleVisibility() {
        var calendarElements = Array.prototype.slice.call(document.querySelectorAll('#calendarList input'));

        CalendarList.forEach(function(calendar) {
            cal.toggleSchedules(calendar.id, !calendar.checked, false);
        });

        cal.render(true);

        calendarElements.forEach(function(input) {
            var span = input.nextElementSibling;
            span.style.backgroundColor = input.checked ? span.style.borderColor : 'transparent';
        });
    }

    function setDropdownCalendarType() {
        var calendarTypeName = document.getElementById('calendarTypeName');
        var calendarTypeIcon = document.getElementById('calendarTypeIcon');
        var options = cal.getOptions();
        var type = cal.getViewName();
        var iconClassName;

        if (type === 'day') {
            type = 'Daily';
            iconClassName = 'calendar-icon ic_view_day';
        } else if (type === 'week') {
            type = 'Weekly';
            iconClassName = 'calendar-icon ic_view_week';
        } else if (options.month.visibleWeeksCount === 2) {
            type = '2 weeks';
            iconClassName = 'calendar-icon ic_view_week';
        } else if (options.month.visibleWeeksCount === 3) {
            type = '3 weeks';
            iconClassName = 'calendar-icon ic_view_week';
        } else {
            type = 'Monthly';
            iconClassName = 'calendar-icon ic_view_month';
        }

        calendarTypeName.innerHTML = type;
        calendarTypeIcon.className = iconClassName;
    }

    function currentCalendarDate(format) {
      var currentDate = moment([cal.getDate().getFullYear(), cal.getDate().getMonth(), cal.getDate().getDate()]);

      return currentDate.format(format);
    }

    function setRenderRangeText() {
        var renderRange = document.getElementById('renderRange');
        var options = cal.getOptions();
        var viewName = cal.getViewName();

        var html = [];
        if (viewName === 'day') {
            html.push(currentCalendarDate('YYYY.MM.DD'));
        } else if (viewName === 'month' &&
            (!options.month.visibleWeeksCount || options.month.visibleWeeksCount > 4)) {
            html.push(currentCalendarDate('YYYY.MM'));
        } else {
            html.push(moment(cal.getDateRangeStart().getTime()).format('YYYY.MM.DD'));
            html.push(' ~ ');
            html.push(moment(cal.getDateRangeEnd().getTime()).format(' MM.DD'));
        }
        renderRange.innerHTML = html.join('');
    }

    function setSchedules() {
        cal.clear();
        generateSchedule(cal.getViewName(), cal.getDateRangeStart(), cal.getDateRangeEnd());
        cal.createSchedules(ScheduleList);

        refreshScheduleVisibility();
    }

    function setEventListener() {
        $('#menu-navi').on('click', onClickNavi);
        $('.dropdown-menu a[role="menuitem"]').on('click', onClickMenu);
        $('#lnb-calendars').on('change', onChangeCalendars);

        $('#btn-save-schedule').on('click', onNewSchedule);
        $('#btn-new-schedule').on('click', createNewSchedule);

        $('#dropdownMenu-calendars-list').on('click', onChangeNewScheduleCalendar);

        window.addEventListener('resize', resizeThrottled);
    }

    function getDataAction(target) {
        return target.dataset ? target.dataset.action : target.getAttribute('data-action');
    }

    resizeThrottled = tui.util.throttle(function() {
        cal.render();
    }, 50);

    window.cal = cal;

    setDropdownCalendarType();
    setRenderRangeText();
    setSchedules();
    setEventListener();
})(window, tui.Calendar);

(function() {
    var calendarList = document.getElementById('calendarList');
    var html = [];
    CalendarList.forEach(function(calendar) {
        html.push('<div class="lnb-calendars-item"><label>' +
            '<input type="checkbox" class="tui-full-calendar-checkbox-round" value="' + calendar.id + '" checked>' +
            '<span style="border-color: ' + calendar.borderColor + '; background-color: ' + calendar.borderColor + ';"></span>' +
            '<span>' + calendar.name + '&nbsp&nbsp&nbsp</span>' +
            '</label></div>&nbsp'
        );
    });
    calendarList.innerHTML = html.join('\n');
})();
